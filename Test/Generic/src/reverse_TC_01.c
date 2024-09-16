/*******************************************************************************
 * Includes
 ******************************************************************************/
#include "reverse_TC_01.h"

/*******************************************************************************
 * Prototypes
 ******************************************************************************/

/*
 * @name: is_string_reverse
 * ----------------------------
 * @brief: Function to check if one string is the reverse of another.
 * @param[in]: str1 - Pointer to the first null-terminated string (const char*).
 * @param[in]: str2 - Pointer to the second null-terminated string (const char*).
 * @return: A boolean value indicating whether str2 is the reverse of str1 (true)
 *          or not (false).
 * @note: None
 */
static bool is_string_reverse ( const char* str1, const char* str2 )
{
	uint32_t lengthString01 = 0U;
	uint32_t lengthString02 = 0U;
	uint32_t index          = 0U;
	bool     retval         = true;

    lengthString01 = strlen(str1);
    lengthString02 = strlen(str2);

    if ( lengthString01 == lengthString02 )
	{
        for ( index = 0U; index < lengthString01; ++index )
		{
			if ( str1[index] != str2[lengthString02 - index - 1] )
			{
				retval = false;
				index  = lengthString01; /* Break loop */
        	}
			else
			{
				/* Do Nothing */
			}
   		}
    }
	else
	{
		retval = false;
	}

    return retval;
}

/*
 * @name: Reverse_TC01
 * ----------------------------
 * @brief: Test case to verify the `is_string_reverse` function by checking if
 *         "automation testing" is identified as the reverse of "gnitset noitamotua".
 * @param: None
 * @return: None. The result of the test is asserted using Unity's TEST_ASSERT_TRUE macro.
 * @note:
 *    The expected outcome of this test is false since "gnitset noitamotua" is not
 *    the reverse of "automation testing". This test ensures that the
 *    `is_string_reverse` function accurately detects non-reverse string pairs.
 */

void Reverse_TC01 ( void )
{
    /* Test case: Check if "automation testing" is reverse of "gnitset nnntamotua" */
    char* str1 = "automation testing";
    char* str2 = "gnitset noitamotua";

    TEST_ASSERT_TRUE(is_string_reverse(str1, str2));
}

/*******************************************************************************
 * EOF
 ******************************************************************************/

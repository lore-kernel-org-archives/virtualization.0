From: Zachary Amsden <zach@vmware.com>
Subject: Re: 2.6.19-rc5-mm2: paravirt X86_PAE=y compile error
Date: Wed, 15 Nov 2006 17:30:32 -0800
Message-ID: <455BBF38.5030503@vmware.com>
References: <20061114014125.dd315fff.akpm@osdl.org>	<20061115231626.GC31879@stusta.de> <20061115153614.a71f944d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070201010000080000010505"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1031038AbWKPBag@vger.kernel.org>
In-Reply-To: <20061115153614.a71f944d.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------070201010000080000010505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> On Thu, 16 Nov 2006 00:16:26 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
>
>   
>> Paravirt breaks CONFIG_X86_PAE=y compilation:
>>
>> <--  snip  -->
>>
>> ...
>>   CC      init/main.o
>> In file included from include2/asm/pgtable.h:245,
>>                  from 
>> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/mm.h:40,
>>                  from 
>> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/poll.h:11,
>>                  from 
>> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/rtc.h:113,
>>                  from 
>> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/efi.h:19,
>>                  from 
>> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/init/main.c:43:
>> include2/asm/pgtable-3level.h:108: error: redefinition of 'pte_clear'
>> include2/asm/paravirt.h:365: error: previous definition of 'pte_clear' was here
>> include2/asm/pgtable-3level.h:115: error: redefinition of 'pmd_clear'
>> include2/asm/paravirt.h:370: error: previous definition of 'pmd_clear' was here
>> make[2]: *** [init/main.o] Error 1
>>
>>     
>
> So it does.  Zach will save us.
>
>   

Well that shouldn't have happened.  Must have been some reject that went 
unnoticed?  Try this.

--------------070201010000080000010505
Content-Type: text/plain;
 name="pae-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pae-fix.patch"

Save big on PAE patches, now cheaper by the dozen!
I hope this doesn't trip someone's ham filter.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.18/include/asm-i386/pgtable-3level.h
===================================================================
--- linux-2.6.18.orig/include/asm-i386/pgtable-3level.h	2006-11-10 14:49:51.000000000 -0800
+++ linux-2.6.18/include/asm-i386/pgtable-3level.h	2006-11-15 17:26:54.000000000 -0800
@@ -78,26 +78,6 @@ static inline void set_pte_present(struc
 		set_64bit((unsigned long long *)(pmdptr),pmd_val(pmdval))
 #define set_pud(pudptr,pudval) \
 		(*(pudptr) = (pudval))
-#endif
-
-/*
- * Pentium-II erratum A13: in PAE mode we explicitly have to flush
- * the TLB via cr3 if the top-level pgd is changed...
- * We do not let the generic code free and clear pgd entries due to
- * this erratum.
- */
-static inline void pud_clear (pud_t * pud) { }
-
-#define pud_page(pud) \
-((struct page *) __va(pud_val(pud) & PAGE_MASK))
-
-#define pud_page_vaddr(pud) \
-((unsigned long) __va(pud_val(pud) & PAGE_MASK))
-
-
-/* Find an entry in the second-level page table.. */
-#define pmd_offset(pud, address) ((pmd_t *) pud_page(*(pud)) + \
-			pmd_index(address))
 
 /*
  * For PTEs and PDEs, we must clear the P-bit first when clearing a page table
@@ -118,6 +98,26 @@ static inline void pmd_clear(pmd_t *pmd)
 	smp_wmb();
 	*(tmp + 1) = 0;
 }
+#endif
+
+/*
+ * Pentium-II erratum A13: in PAE mode we explicitly have to flush
+ * the TLB via cr3 if the top-level pgd is changed...
+ * We do not let the generic code free and clear pgd entries due to
+ * this erratum.
+ */
+static inline void pud_clear (pud_t * pud) { }
+
+#define pud_page(pud) \
+((struct page *) __va(pud_val(pud) & PAGE_MASK))
+
+#define pud_page_vaddr(pud) \
+((unsigned long) __va(pud_val(pud) & PAGE_MASK))
+
+
+/* Find an entry in the second-level page table.. */
+#define pmd_offset(pud, address) ((pmd_t *) pud_page(*(pud)) + \
+			pmd_index(address))
 
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)

--------------070201010000080000010505--

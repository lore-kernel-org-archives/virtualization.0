From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH 3/3] Eliminate read_cr3 on TLB flush
Date: Wed, 30 May 2007 10:32:23 -0500
Message-ID: <465D9907.40406@us.ibm.com>
References: <465D8F03.7000201@us.ibm.com> <465D8FF5.6040804@us.ibm.com>
	<200705301701.23386.ak@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010000060407000300010501"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200705301701.23386.ak@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------010000060407000300010501
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Andi Kleen wrote:
> On Wednesday 30 May 2007 16:53:41 Anthony Liguori wrote:
>   
>> Subject: [PATCH][PARAVIRT] Eliminate unnecessary CR3 read in TLB flush
>>
>> This patch eliminates the CR3 read (which would cause a VM exit) in the TLB
>> flush path.  The patch is based on Ingo Molnar's paravirt series.
>>
>>     
>
> This change could be just done generically for the native architecture, couldn't 
> it?
>   

Sure.  It adds a few more cycles onto native though (two memory reads, 
and some math).  How does the following look?

Regards,

Anthony Liguori

> -Andi
>   


--------------010000060407000300010501
Content-Type: text/x-patch;
 name="no-read-cr3-on-tlbflush.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="no-read-cr3-on-tlbflush.diff"

Subject: [PATCH] Avoid reading CR3 on TLB flush
From: Anthony Liguori <aliguori@us.ibm.com>

In a virtualized environment, there is significant overhead in reading and
writing control registers.  Since we already have the value of CR3 in
current->active_mm->pgd, we can avoid taking the exit on CR3 read when
doing a TLB flush.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

Index: kvm/include/asm-i386/tlbflush.h
===================================================================
--- kvm.orig/include/asm-i386/tlbflush.h	2007-05-30 10:22:48.000000000 -0500
+++ kvm/include/asm-i386/tlbflush.h	2007-05-30 10:22:54.000000000 -0500
@@ -14,13 +14,12 @@
 
 #define __native_flush_tlb()						\
 	do {								\
-		unsigned int tmpreg;					\
+		unsigned int cr3 = __pa(current->active_mm->pgd);	\
 									\
 		__asm__ __volatile__(					\
-			"movl %%cr3, %0;              \n"		\
 			"movl %0, %%cr3;  # flush TLB \n"		\
-			: "=r" (tmpreg)					\
-			:: "memory");					\
+			:: "r" (cr3)				       	\
+			: "memory");					\
 	} while (0)
 
 /*
@@ -29,18 +28,18 @@
  */
 #define __native_flush_tlb_global()					\
 	do {								\
-		unsigned int tmpreg, cr4, cr4_orig;			\
+		unsigned int cr3 = __pa(current->active_mm->pgd);	\
+		unsigned int cr4, cr4_orig;				\
 									\
 		__asm__ __volatile__(					\
-			"movl %%cr4, %2;  # turn off PGE     \n"	\
-			"movl %2, %1;                        \n"	\
-			"andl %3, %1;                        \n"	\
-			"movl %1, %%cr4;                     \n"	\
-			"movl %%cr3, %0;                     \n"	\
-			"movl %0, %%cr3;  # flush TLB        \n"	\
-			"movl %2, %%cr4;  # turn PGE back on \n"	\
-			: "=&r" (tmpreg), "=&r" (cr4), "=&r" (cr4_orig)	\
-			: "i" (~X86_CR4_PGE)				\
+			"movl %%cr4, %1;  # turn off PGE     \n"	\
+			"movl %1, %0;                        \n"	\
+			"andl %2, %0;                        \n"	\
+			"movl %0, %%cr4;                     \n"	\
+			"movl %3, %%cr3;  # flush TLB        \n"	\
+			"movl %1, %%cr4;  # turn PGE back on \n"	\
+			: "=&r" (cr4), "=&r" (cr4_orig)			\
+			: "i" (~X86_CR4_PGE), "r" (cr3)			\
 			: "memory");					\
 	} while (0)
 

--------------010000060407000300010501
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--------------010000060407000300010501--

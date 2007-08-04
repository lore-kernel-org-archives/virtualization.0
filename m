From: Gabriel Barazer <gabriel-KSe8qvLY914@public.gmane.org>
Subject: Re: 2.6.22 x86_64 : kernel initial decompression hangs
	on vmware
Date: Sat, 04 Aug 2007 19:18:48 +0200
Message-ID: <46B4B4F8.6050200@oxeva.fr>
References: <46A7E606.4030001@oxeva.fr> <46B4A7E4.4030907@vmware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000605000502060202080203"
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46B4A7E4.4030907-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Zachary Amsden <zach-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Cc: kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Virtualization Mailing List <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Jim Mattson <jmattson-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------000605000502060202080203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 08/04/2007 6:23:00 PM +0200, Zachary Amsden <zach-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org> wrote:
> Gabriel Barazer wrote:
>> Hi,
>>
>> After upgrading kernel to 2.6.22 on a Vmware workstation guest version 
>> 5.5 and 6 , the kernel decompression stage ("Decompressing Linux...") 
>> is hanging for a very long time (~5 minutes) before finally  
>> succeeding (displaying "done.\nBooting the kernel.\n"). During this 
>> time, the VM process is eating all the CPU time during the 
>> decompression, like an infinite loop.
>> Between these 2 strings is the gunzip() function at 
>> boot/compressed/misc.c which does the real job, and the problem seemed 
>> to appear since commit 1ab60e0f72f71ec54831e525a3e1154f1c092408. 
>> (2.6.22-rc1 hangs, 2.6.21.6 works). The problem occurs with or without 
>> CONFIG_RELOCATABLE enabled.
>>
>> What are the possible solutions to confirm where the problem is coming 
>> from ?
> 
> Since I was just involved in the boot decompressor for another bug, I 
> took a look at this.  2.6.22 switches it to be 64-bit code.  VT is very 
> picky about what state it can run in.  Not using VT on Intel 64-bit 
> hardware cripples performance, running at far below normal speed, and 
> taking minutes to decompress the kernel, which is nearly instantaneous 
> otherwise.
> 
> To get back into VT in this case, not only do we need to load FS and GS, 
> we also need to setup an initial LDT and task.  Can you try the attached 
> patch and see that it does the right thing?

It Works (tm) ! Tried compiling with and without the patch, with exactly 
the same config, just to be sure. Decompressing the kernel is now 
lightning fast.

Thanks !

> I've also cc'd the KVM developers, as the same problem will affect them, 
> and hopefully the same patch will fix it.

--------------000605000502060202080203
Content-Type: text/x-patch;
 name="boot-decompress-vt-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot-decompress-vt-fix.patch"

VT is very picky about when it can enter execution.
Get all segments setup and get LDT and TR into valid state to allow
VT execution under VMware and KVM (untested).

This makes the boot decompression run under VT, which makes it several
orders of magnitude faster on 64-bit Intel hardware.

Before, I was seeing times up to a minute or more to decompress a 1.3MB kernel
on a very fast box.

Signed-off-by: Zachary Amsden <zach-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>


===================================================================
--- a/arch/x86_64/boot/compressed/head.S
+++ a/arch/x86_64/boot/compressed/head.S
@@ -195,6 +195,11 @@
 	movl	%eax, %ds
 	movl	%eax, %es
 	movl	%eax, %ss
+	movl	%eax, %fs
+	movl	%eax, %gs
+	lldt	%ax
+	movl    $0x20, %eax
+	ltr	%ax
 
 	/* Compute the decompressed kernel start address.  It is where
 	 * we were loaded at aligned to a 2M boundary. %rbp contains the
@@ -295,6 +300,8 @@
 	.quad	0x0000000000000000	/* NULL descriptor */
 	.quad	0x00af9a000000ffff	/* __KERNEL_CS */
 	.quad	0x00cf92000000ffff	/* __KERNEL_DS */
+	.quad	0x0080890000000000	/* TS descriptor */
+	.quad   0x0000000000000000	/* TS continued */
 gdt_end:
 	.bss
 /* Stack for uncompression */

--------------000605000502060202080203
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--------------000605000502060202080203
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvm-devel mailing list
kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/kvm-devel

--------------000605000502060202080203--

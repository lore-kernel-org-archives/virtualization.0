From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Xen paravirt frontend block hang
Date: Mon, 28 Jan 2008 16:40:03 -0800
Message-ID: <479E75E3.6030601@goop.org>
References: <4772AC8E.7010007@theshore.net> <47758352.5040504@goop.org>
	<479E71B7.7060207@theshore.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <479E71B7.7060207@theshore.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Christopher S. Aker" <caker@theshore.net>
Cc: xming <xmingske@gmail.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Christopher S. Aker wrote:
>>
>> I'll try to track this down asap.  Have you tried any other kernel
>> versions?  In other words, did it just start happening, or its always
>> done it?  Also, could you try 2.6.24-rc6, just to make sure it hasn't
>> already been fixed (which is possible if its something that happened in
>> a higher layer or something).
>
> Were you able to give this a try?  Still doing it on pv_ops 2.6.24.

Hm.  xming reported similar symtoms to your report, which turned out to 
be a result of problems with events getting lost.  This patch - which is 
in 2.6.24 - resolved the issue.  Stock 2.6.24 still has this problem for 
you?  Can you also reproduce it with lots of console output?

Thanks,
    J


changeset:   76060:66bba82b6e9b
parent:      76048:e10ad8f96525
user:        Jeremy Fitzhardinge <jeremy@goop.org>
date:        Wed Jan 23 18:04:54 2008 -0800
files:       arch/x86/xen/enlighten.c
description:
xen: disable vcpu_info placement for now

There have been several reports of Xen guest domains locking up when
using vcpu_info structure placement.  Disable it for now.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

committer: Linus Torvalds <torvalds@woody.linux-foundation.org>


diff -r e10ad8f96525 -r 66bba82b6e9b arch/x86/xen/enlighten.c
--- a/arch/x86/xen/enlighten.c  Wed Jan 23 09:58:55 2008 -0800
+++ b/arch/x86/xen/enlighten.c  Wed Jan 23 18:04:54 2008 -0800
@@ -95,7 +95,7 @@ struct shared_info *HYPERVISOR_shared_in
  *
  * 0: not available, 1: available
  */
-static int have_vcpu_info_placement = 1;
+static int have_vcpu_info_placement = 0;
 
 static void __init xen_vcpu_setup(int cpu)
 {

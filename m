From: Lee Schermerhorn <lee.schermerhorn@hp.com>
Subject: Announce: Auto/Lazy-migration Patches RFC on linux-numa list
Date: Fri, 12 Nov 2010 11:15:06 -0500
Message-ID: <20101112161506.4425.11535.sendpatchset__48739.6171935417$1289581936$gmane$org@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

At last weeks' LPC, there was some interest in my patches for Auto/Lazy
Migration to improve locality and possibly performance of unpinned guest
VMs on a NUMA platform.  As a result of these conversations I have reposted
the patches [4 series, ~40 patches] as RFCs to the linux-numa list.  Links
to threads given below.

I have rebased the patches atop 3Nov10 mmotm series [2.6.36 + 3nov mmotm].
The patched kernel builds, boots and survives some fairly heavy testing on
an 8 node istanbul x86_64.  Under heavy load, I do encounter a race in the
somewhat optional migration cache.  Currently this generates a warning and
carries on, but the one migration cache entry and related page is then
wedged.  This would need to be resolved.


The series/threads in the order applied:

[PATCH/RFC 0/14] Shared Policy Overview
http://markmail.org/message/trvpl3t7gimvwht6

[PATCH/RFC 0/8] numa - Migrate-on-Fault
http://markmail.org/message/mdwbcitql5ka4uws

[PATCH/RFC 0/11] numa - Automatic-migration
http://markmail.org/message/zik3itmqed65mol2

[PATCH/RFC 1/5] numa - migration cache - core implementation
http://markmail.org/message/xvck7enyezx6chyi

RESEND: [PATCH/RFC 1/5] numa - migration cache - core implementation
http://markmail.org/message/xgvvrnn2nk4nsn2e

	resend to add back the patch description missing from 1st attempt.

From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 00/10] REVIEW: Xen patches for 2.6.24
Date: Fri, 12 Oct 2007 14:11:32 -0700
Message-ID: <20071012211132.198718000@goop.org>
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, Keir Fraser <keir@xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

This is my current set of updates to Xen for 2.6.24.  This is largely
a bugfix set, and a couple of them are also relevent to 2.6.23.

These are in the pre-x86 merge form; I'll update them once the merge
goes into git.

Quick overview:
 - remove some dead code in arch/i386/mm/init.c
 - clean up some duplicate includes
 - when sending an IPI, yield the vcpu if the destination doesn't have
   a real cpu to run on
 - fix a bug where a lazy cr3 reload can prevent a pagetable from being
   unpinned
 - deal with split pte locks properly
 - fix an old structure used for the register_vcpu_info hypercall
 - add some multicall debugging help
 - workaround for a bad XFS/Xen interaction

Thanks,
	J

-- 

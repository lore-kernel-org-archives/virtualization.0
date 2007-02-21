From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 00/24] Xen-paravirt_ops: Xen guest implementation for
	paravirt_ops interface
Date: Wed, 21 Feb 2007 12:52:54 -0800
Message-ID: <20070221205254.169835700@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@muc.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Andi,

This patch series implements the Linux Xen guest as a paravirt_ops
backend.  The features in implemented this patch series are:
 * domU only
 * UP only (most code is SMP-safe, but there's no way to create a new vcpu)
 * writable pagetables, with late pinning/early unpinning
   (no shadow pagetable support)
 * supports both PAE and non-PAE modes
 * xen hvc console (console=3Dhvc0)
 * virtual block device (blockfront)
 * virtual network device (netfront)

The patch series is in two parts:

1-12: cleanups to the core kernel, either to fix outright problems,
      or to add appropriate hooks needed by Xen
13-24: the Xen guest implementation itself

(Some of the earlier patches in the series have already been posted,
 but are included to make the series self-contained.)

I've tried to make each patch as self-explanatory as possible.  The
series is based on 2.6.20-git16.

Changes since the previous posting:
- rebased
- xen-console has been replaced with a xen backend for the hvc console
- dropped patch to remove pgd ctor/dtor
- shared-kernel-pmd extensively reviewed by wli
- use vmalloc_sync_all in alloc_vm_area
- cleaned up Xen Kconfig stuff

I looked at linking in xen-head.S rather than including it into
xen-head.S, but it seems to provoke linker bugs, so I've left it as-is
for now.

Thanks,
	J
-- =

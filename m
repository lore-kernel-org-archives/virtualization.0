From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 00/21] Xen-paravirt: Xen guest implementation for paravirt_ops
	interface
Date: Thu, 15 Feb 2007 18:24:49 -0800
Message-ID: <20070216022449.739760547@goop.org>
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

This patch series implements the Linux Xen guest in terms of the
paravirt-ops interface.  The features in implemented this patch series
are:
 * domU only
 * UP only (most code is SMP-safe, but there's no way to create a new vcpu)
 * writable pagetables, with late pinning/early unpinning
   (no shadow pagetable support)
 * supports both PAE and non-PAE modes
 * xen console
 * virtual block device (blockfront)
 * virtual network device (netfront)

The patch series is in two parts:

1-12: cleanups to the core kernel, either to fix outright problems,
      or to add appropriate hooks for Xen
13-21: the Xen guest implementation itself

I've tried to make each patch as self-explanatory as possible.  The
series is based on git changeset
ec2f9d1331f658433411c58077871e1eef4ee1b4 +
x86_64-2.6.20-git8-070213-1.patch.

Changes since the previous posting:
- rebased
- addressed review comments:
 - deal with missing vga hardware better
 - deal with Andi's comments
 - clean up header file placement
 - update netfront, and move it into drivers/net

I looked at linking in xen-head.S rather than including it into
xen-head.S, but it seems to provoke linker bugs, so I've left it as-is
for now.

Thanks,
	J

-- =

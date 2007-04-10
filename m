From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH 0/10] i386, VMI, BusLogic, Timer fixes for -mm
Date: Mon, 9 Apr 2007 17:05:43 -0700
Message-ID: <200704100005.l3A05hpp020590@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Latest cleanups and junk from Zach's tree.  All for -mm tree.
Based off Jeremy's latest known applied patches.  If the
paravirt or VMI patches reject let me know; we are cleaning up
tree and will redo.

Otherwise, I have 4 fixes for i386; a warning fix in sysenter
which is quite serious; some less important warning removals,
and a bug with pgd locking during root creation.

Next, I tidy up the kmap_atomic_pte code, since it makes no
sense to leave it around under !HIGHMEM and being forced to
define it introduces conflicts with where things get defined
that just is ugly.

Some VMI fixes; we support COMPAT_VDSO now that the relocation
code is there, re-add the lazy MMU fix now that Jeremy's cleanups
have been applied to -mm, implement kmap_atomic_pte.

Next, re-implement the VMI timer, dropping all the NO_IDLE_HZ
code, making it dependent on NO_HZ and using the proper clockevents
infrastructure.  I am looking for feedback on this, but it works
and applies as is, and is certainly better and cleaner than the
existing code.  Hopefully I have taken as many fingers out of the
APIC pie as possible.

Finally, fix the BusLogic driver to use request_range properly.

Zach

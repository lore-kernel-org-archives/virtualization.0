From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH-cc-fixed] vhost: add missing architectures
Date: Thu, 17 Dec 2009 15:01:46 +0200
Message-ID: <20091217130146.GA26726__8423.82599735192$1261055181$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, kvm-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

vhost is completely portable, but Kconfig include was missing for all
architectures besides x86, so it did not appear in the menu.  Add the
relevant Kconfig includes to all architectures that support
virtualization.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Some IBM addresses seem to be bouncing. Reposting with these removed,
please send replies to this shorter list to avoid bounces.  Sorry about
the noise.


Hi Rusty,
please apply the following trivial fixup patch for 2.6.33.
Thanks!

 arch/ia64/kvm/Kconfig    |    1 +
 arch/powerpc/kvm/Kconfig |    1 +
 arch/s390/kvm/Kconfig    |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/ia64/kvm/Kconfig b/arch/ia64/kvm/Kconfig
index ef3e7be..01c7579 100644
--- a/arch/ia64/kvm/Kconfig
+++ b/arch/ia64/kvm/Kconfig
@@ -47,6 +47,7 @@ config KVM_INTEL
 	  Provides support for KVM on Itanium 2 processors equipped with the VT
 	  extensions.
 
+source drivers/vhost/Kconfig
 source drivers/virtio/Kconfig
 
 endif # VIRTUALIZATION
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index c299268..a1b4c5d 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -58,6 +58,7 @@ config KVM_E500
 
 	  If unsure, say N.
 
+source drivers/vhost/Kconfig
 source drivers/virtio/Kconfig
 
 endif # VIRTUALIZATION
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index bf164fc..6be6aea 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -36,6 +36,7 @@ config KVM
 
 # OK, it's a little counter-intuitive to do this, but it puts it neatly under
 # the virtualization menu.
+source drivers/vhost/Kconfig
 source drivers/virtio/Kconfig
 
 endif # VIRTUALIZATION
-- 
1.6.6.rc1.43.gf55cc

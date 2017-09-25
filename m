From: Thomas Huth <thuth@redhat.com>
Subject: [PATCH] KVM: s390: Disable CONFIG_S390_GUEST_OLD_TRANSPORT by default
Date: Mon, 25 Sep 2017 16:45:29 +0200
Message-ID: <1506350729-11311-1-git-send-email-thuth__18561.3125017428$1509079434$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

There is no recent user space application available anymore which still
supports this old virtio transport, so let's disable this by default.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/s390/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 48af970..923bf04 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -930,7 +930,7 @@ config S390_GUEST
 	  the KVM hypervisor.
 
 config S390_GUEST_OLD_TRANSPORT
-	def_bool y
+	def_bool n
 	prompt "Guest support for old s390 virtio transport (DEPRECATED)"
 	depends on S390_GUEST
 	help
-- 
1.8.3.1

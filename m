From: Andrew Jones <drjones@redhat.com>
Subject: [PATCH 4/4] xen kconfig: describe xen tmem in the config menu
Date: Wed, 11 Jan 2012 17:36:41 +0100
Message-ID: <1326299801-7966-4-git-send-email-drjones@redhat.com>
References: <20120111161911.GB18203@andromeda.dapyr.net>
	<1326299801-7966-1-git-send-email-drjones@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1326299801-7966-1-git-send-email-drjones@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: konrad@darnok.org
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com, stefano.stabellini@eu.citrix.com
List-Id: virtualization@lists.linuxfoundation.org

Add a description to the config menu for xen tmem.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 drivers/xen/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index 1d24061..7e8d728 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -143,7 +143,7 @@ config SWIOTLB_XEN
 	select SWIOTLB
 
 config XEN_TMEM
-	bool
+	bool "Xen Transcendent Memory (tmem)"
 	default y if (CLEANCACHE || FRONTSWAP)
 	help
 	  Shim to interface in-kernel Transcendent Memory hooks
-- 
1.7.7.5

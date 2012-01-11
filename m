From: Andrew Jones <drjones@redhat.com>
Subject: [PATCH 1/4] xen kconfig: keep XEN_XENBUS_FRONTEND builtin
Date: Wed, 11 Jan 2012 17:36:38 +0100
Message-ID: <1326299801-7966-1-git-send-email-drjones@redhat.com>
References: <20120111161911.GB18203@andromeda.dapyr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120111161911.GB18203@andromeda.dapyr.net>
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

When XEN_XENBUS_FRONTEND gets selected as a module it can lead to
unbootable configs. If we need it, then we should just build it in.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 drivers/xen/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index 8795480..1d24061 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -118,7 +118,7 @@ config XEN_SYS_HYPERVISOR
 	 but will have no xen contents.
 
 config XEN_XENBUS_FRONTEND
-	tristate
+	bool
 
 config XEN_GNTDEV
 	tristate "userspace grant access device driver"
-- 
1.7.7.5

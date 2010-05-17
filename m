From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] vhost: Storage class should be before const qualifier
Date: Mon, 17 May 2010 15:12:49 +0200
Message-ID: <1274101969-21109-1-git-send-email-tklauser@distanz.ch>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: mst@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.osdl.org, netdev@vger.kernel.org, Tobias Klauser <tklauser@distanz.ch>
List-Id: virtualization@lists.linuxfoundation.org

The C99 specification states in section 6.11.5:

The placement of a storage-class specifier other than at the beginning
of the declaration specifiers in a declaration is an obsolescent
feature.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/vhost/net.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index aa88911..cd36f5f 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -626,7 +626,7 @@ static long vhost_net_compat_ioctl(struct file *f, unsigned int ioctl,
 }
 #endif
 
-const static struct file_operations vhost_net_fops = {
+static const struct file_operations vhost_net_fops = {
 	.owner          = THIS_MODULE,
 	.release        = vhost_net_release,
 	.unlocked_ioctl = vhost_net_ioctl,
-- 
1.6.3.3


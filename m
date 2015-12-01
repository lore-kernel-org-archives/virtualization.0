From: "Sinclair Yeh" <syeh@vmware.com>
Subject: [PATCH 4/6] Input: Remove vmmouse port reservation
Date: Tue,  1 Dec 2015 14:18:50 -0800
Message-ID: <1449008332-9394-4-git-send-email-syeh__8955.13050859353$1449008318$gmane$org@vmware.com>
References: <1449008047-8252-1-git-send-email-syeh@vmware.com>
	<1449008332-9394-1-git-send-email-syeh@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1449008332-9394-1-git-send-email-syeh@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: x86@kernel.org
Cc: pv-drivers@vmware.com, virtualization@lists.linux-foundation.org, linux-graphics-maintainer@vmware.com, linux-kernel@vger.kernel.org, Sinclair Yeh <syeh@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Port reservation is not required.  Furthermore, this port is shared
by other VMware services for host-side communication.

Signed-off-by: Sinclair Yeh <syeh@vmware.com>
Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
Cc: pv-drivers@vmware.com
Cc: linux-graphics-maintainer@vmware.com
Cc: virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/input/mouse/vmmouse.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/input/mouse/vmmouse.c b/drivers/input/mouse/vmmouse.c
index d34e3e4..9109d54 100644
--- a/drivers/input/mouse/vmmouse.c
+++ b/drivers/input/mouse/vmmouse.c
@@ -347,16 +347,10 @@ int vmmouse_detect(struct psmouse *psmouse, bool set_properties)
 		return -ENXIO;
 	}
 
-	if (!request_region(VMMOUSE_PROTO_PORT, 4, "vmmouse")) {
-		psmouse_dbg(psmouse, "VMMouse port in use.\n");
-		return -EBUSY;
-	}
-
 	/* Check if the device is present */
 	response = ~VMMOUSE_PROTO_MAGIC;
 	VMMOUSE_CMD(GETVERSION, 0, version, response, dummy1, dummy2);
 	if (response != VMMOUSE_PROTO_MAGIC || version == 0xffffffffU) {
-		release_region(VMMOUSE_PROTO_PORT, 4);
 		return -ENXIO;
 	}
 
@@ -366,8 +360,6 @@ int vmmouse_detect(struct psmouse *psmouse, bool set_properties)
 		psmouse->model = version;
 	}
 
-	release_region(VMMOUSE_PROTO_PORT, 4);
-
 	return 0;
 }
 
@@ -386,7 +378,6 @@ static void vmmouse_disconnect(struct psmouse *psmouse)
 	psmouse_reset(psmouse);
 	input_unregister_device(priv->abs_dev);
 	kfree(priv);
-	release_region(VMMOUSE_PROTO_PORT, 4);
 }
 
 /**
@@ -430,15 +421,10 @@ int vmmouse_init(struct psmouse *psmouse)
 	struct input_dev *rel_dev = psmouse->dev, *abs_dev;
 	int error;
 
-	if (!request_region(VMMOUSE_PROTO_PORT, 4, "vmmouse")) {
-		psmouse_dbg(psmouse, "VMMouse port in use.\n");
-		return -EBUSY;
-	}
-
 	psmouse_reset(psmouse);
 	error = vmmouse_enable(psmouse);
 	if (error)
-		goto release_region;
+		return error;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	abs_dev = input_allocate_device();
@@ -493,8 +479,5 @@ init_fail:
 	kfree(priv);
 	psmouse->private = NULL;
 
-release_region:
-	release_region(VMMOUSE_PROTO_PORT, 4);
-
 	return error;
 }
-- 
1.9.1

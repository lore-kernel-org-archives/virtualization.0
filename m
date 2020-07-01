From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 5/5] virtio_console: Constify some static variables
Date: Wed,  1 Jul 2020 22:09:50 +0200
Message-ID: <20200701200950.30314-6-rikard.falkeborn@gmail.com>
References: <20200701200950.30314-1-rikard.falkeborn@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200701200950.30314-1-rikard.falkeborn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Rikard Falkeborn <rikard.falkeborn@gmail.com>, Amit Shah <amit@kernel.org>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

The id_table and feature_table pointers in struct virtio_driver are
pointers to const. Mark the corresponding static variables const to
allow the compiler to put them in read-only memory.

Before:
   text    data     bss     dec     hex filename
  25447     713      76   26236    667c drivers/char/virtio_console.o

After:
   text    data     bss     dec     hex filename
  25488     673      76   26237    667d drivers/char/virtio_console.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/char/virtio_console.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 00c5e3acee46..896f0ba9ba3c 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2112,24 +2112,24 @@ static int virtcons_probe(struct virtio_device *vdev)
 	return err;
 }
 
-static struct virtio_device_id id_table[] = {
+static const struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_CONSOLE, VIRTIO_DEV_ANY_ID },
 	{ 0 },
 };
 
-static unsigned int features[] = {
+static const unsigned int features[] = {
 	VIRTIO_CONSOLE_F_SIZE,
 	VIRTIO_CONSOLE_F_MULTIPORT,
 };
 
-static struct virtio_device_id rproc_serial_id_table[] = {
+static const struct virtio_device_id rproc_serial_id_table[] = {
 #if IS_ENABLED(CONFIG_REMOTEPROC)
 	{ VIRTIO_ID_RPROC_SERIAL, VIRTIO_DEV_ANY_ID },
 #endif
 	{ 0 },
 };
 
-static unsigned int rproc_serial_features[] = {
+static const unsigned int rproc_serial_features[] = {
 };
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.27.0

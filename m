From: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH resend] virtio: virtio_console: add missing MODULE_DEVICE_TABLE() for rproc serial
Date: Tue, 23 Jun 2020 11:09:33 +0000
Message-ID: <x7C_CbeJtoGMy258nwAXASYz3xgFMFpyzmUvOyZzRnQrgWCREBjaqBOpAUS7ol4NnZYvSVwmTsCG0Ohyfvta-ygw6HMHcoeKK0C3QFiAO_Q=@pm.me>
Reply-To: Alexander Lobakin <alobakin@pm.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Amit Shah <amit@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Sjur_Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>, Rusty Russell <rusty@rustcorp.com.au>, Alexander Lobakin <alobakin@pm.me>, virtualization@lists.linux-foundation.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

rproc_serial_id_table lacks an exposure to module devicetable, so
when remoteproc firmware requests VIRTIO_ID_RPROC_SERIAL, no uevent
is generated and no module autoloading occurs.
Add missing MODULE_DEVICE_TABLE() annotation and move the existing
one for VIRTIO_ID_CONSOLE right to the table itself.

Fixes: 1b6370463e88 ("virtio_console: Add support for remoteproc serial")
Cc: <stable@vger.kernel.org> # v3.8+
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
Reviewed-by: Amit Shah <amit@kernel.org>
---
 drivers/char/virtio_console.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 00c5e3acee46..ca691bce9791 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2116,6 +2116,7 @@ static struct virtio_device_id id_table[] =3D {
 =09{ VIRTIO_ID_CONSOLE, VIRTIO_DEV_ANY_ID },
 =09{ 0 },
 };
+MODULE_DEVICE_TABLE(virtio, id_table);
=20
 static unsigned int features[] =3D {
 =09VIRTIO_CONSOLE_F_SIZE,
@@ -2128,6 +2129,7 @@ static struct virtio_device_id rproc_serial_id_table[=
] =3D {
 #endif
 =09{ 0 },
 };
+MODULE_DEVICE_TABLE(virtio, rproc_serial_id_table);
=20
 static unsigned int rproc_serial_features[] =3D {
 };
@@ -2280,6 +2282,5 @@ static void __exit fini(void)
 module_init(init);
 module_exit(fini);
=20
-MODULE_DEVICE_TABLE(virtio, id_table);
 MODULE_DESCRIPTION("Virtio console driver");
 MODULE_LICENSE("GPL");
--=20
2.27.0

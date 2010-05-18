From: Steven Liu <lingjiujianke@gmail.com>
Subject: [PATCH] fix a code style in drivers/char/virtio_console.c
Date: Tue, 18 May 2010 13:17:22 +0800
Message-ID: <AANLkTilW8zZxCOrdiefZ4ZtixprI58LzDZ6Cz03z4lFk__21298.0775432245$1274192471$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: amit.shah@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

fix a code style in drivers/char/virtio_console.c

Signed-off-by: Liu Qi <lingjiujianke@gmail.com>
---
 drivers/char/virtio_console.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 196428c..61dad7e 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1299,36 +1299,31 @@ static int init_vqs(struct ports_device *portdev)
        char **io_names;
        struct virtqueue **vqs;
        u32 i, j, nr_ports, nr_queues;
-       int err;
+       int err = -ENOMEM;

        nr_ports = portdev->config.max_nr_ports;
        nr_queues = use_multiport(portdev) ? (nr_ports + 1) * 2 : 2;

        vqs = kmalloc(nr_queues * sizeof(struct virtqueue *), GFP_KERNEL);
        if (!vqs) {
-               err = -ENOMEM;
                goto fail;
        }
        io_callbacks = kmalloc(nr_queues * sizeof(vq_callback_t *), GFP_KERNEL);
        if (!io_callbacks) {
-               err = -ENOMEM;
                goto free_vqs;
        }
        io_names = kmalloc(nr_queues * sizeof(char *), GFP_KERNEL);
        if (!io_names) {
-               err = -ENOMEM;
                goto free_callbacks;
        }
        portdev->in_vqs = kmalloc(nr_ports * sizeof(struct virtqueue *),
                                  GFP_KERNEL);
        if (!portdev->in_vqs) {
-               err = -ENOMEM;
                goto free_names;
        }
        portdev->out_vqs = kmalloc(nr_ports * sizeof(struct virtqueue *),
                                   GFP_KERNEL);
        if (!portdev->out_vqs) {
-               err = -ENOMEM;
                goto free_invqs;
        }

--
1.7.1



Best regards

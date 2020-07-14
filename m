From: mwilck@suse.com
Subject: [PATCH] virtio-rng: return available data with O_NONBLOCK
Date: Wed, 15 Jul 2020 00:00:19 +0200
Message-ID: <20200714220019.10854-1-mwilck@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane-mx.org@nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel2=m.gmane-mx.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+gceq-qemu-devel2=m.gmane-mx.org@nongnu.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Martin Wilck <mwilck@suse.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Martin Wilck <mwilck@suse.com>

If a program opens /dev/hwrng with O_NONBLOCK and uses poll() and
non-blocking read() to retrieve random data, it ends up in a tight
loop with poll() always returning POLLIN and read() returning EAGAIN.
This repeats forever until some process makes a blocking read() call.
The reason is that virtio_read() always returns 0 in non-blocking mode,
even if data is available.

The following test program illustrates the behavior.

void loop(int fd)
{
        struct pollfd pfd0 = { .fd = fd, .events  = POLLIN, };
        int rc;
        unsigned int n;

        for (n = LOOPS; n > 0; n--) {
                struct pollfd pfd = pfd0;
                char buf[SIZE];

                rc = poll(&pfd, 1, 1);
                if (rc > 0) {
                        int rd = read(fd, buf, sizeof(buf));

                        if (rd == -1)
                                perror("read");
                        else
                                printf("read %d bytes\n", rd);
                } else if (rc == -1)
                        perror("poll");
                else
                        fprintf(stderr, "timeout\n");

        }
}

int main(void)
{
        int fd;

        fd = open("/dev/hwrng", O_RDONLY|O_NONBLOCK);
        if (fd == -1) {
                perror("open");
                return 1;
        };
        loop(fd);
        close(fd);
        return 0;
}

This can be observed in the real word e.g. with nested qemu/KVM virtual
machines, if both the "outer" and "inner" VMs have a virtio-rng device.
If the "inner" VM requests random data, qemu running in the "outer" VM
uses this device in a non-blocking manner like the test program above.

Fix it by returning available data if it exists.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 drivers/char/hw_random/virtio-rng.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 79a6e47b5fbc..94806308d814 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -59,6 +59,9 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
 	if (vi->hwrng_removed)
 		return -ENODEV;
 
+	if (vi->data_avail >= size || (vi->data_avail && !wait))
+		return vi->data_avail;
+
 	if (!vi->busy) {
 		vi->busy = true;
 		reinit_completion(&vi->have_data);
-- 
2.26.2

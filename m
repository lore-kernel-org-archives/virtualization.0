From: mwilck@suse.com
Subject: [PATCH v2] virtio-rng: return available data with O_NONBLOCK
Date: Wed, 15 Jul 2020 15:32:55 +0200
Message-ID: <20200715133255.10526-1-mwilck@suse.com>
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
even if data is available. Worse, it fetches random data from the
hypervisor after every non-blocking call, without ever using this data.

The following test program illustrates the behavior and can be used
for testing and experiments. The problem will only be seen if all
tasks use non-blocking access; otherwise the blocking reads will
"recharge" the random pool and cause other, non-blocking reads to
succeed at least sometimes.

/* Whether to use non-blocking mode in a task, problem occurs if CONDITION is 1 */
//#define CONDITION (getpid() % 2 != 0)

static volatile sig_atomic_t stop;
static void handler(int sig __attribute__((unused))) { stop = 1; }

static void loop(int fd, int sec)
{
	struct pollfd pfd = { .fd = fd, .events  = POLLIN, };
	unsigned long errors = 0, eagains = 0, bytes = 0, succ = 0;
	int size, rc, rd;

	srandom(getpid());
	if (CONDITION && fcntl(fd, F_SETFL, fcntl(fd, F_GETFL) | O_NONBLOCK) == -1)
		perror("fcntl");
	size = MINBUFSIZ + random() % (MAXBUFSIZ - MINBUFSIZ + 1);

	for(;;) {
		char buf[size];

		if (stop)
			break;
		rc = poll(&pfd, 1, sec);
		if (rc > 0) {
			rd = read(fd, buf, sizeof(buf));
			if (rd == -1 && errno == EAGAIN)
				eagains++;
			else if (rd == -1)
				errors++;
			else {
				succ++;
				bytes += rd;
				write(1, buf, sizeof(buf));
			}
		} else if (rc == -1) {
			if (errno != EINTR)
				perror("poll");
			break;
		} else
			fprintf(stderr, "poll: timeout\n");
	}
	fprintf(stderr,
		"pid %d %sblocking, bufsize %d, %d seconds, %lu bytes read, %lu success, %lu eagain, %lu errors\n",
		getpid(), CONDITION ? "non-" : "", size, sec, bytes, succ, eagains, errors);
}

int main(void)
{
	int fd;

	fork(); fork();
	fd = open("/dev/hwrng", O_RDONLY);
	if (fd == -1) {
		perror("open");
		return 1;
	};
	signal(SIGALRM, handler);
	alarm(SECONDS);
	loop(fd, SECONDS);
	close(fd);
	wait(NULL);
	return 0;
}

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

Fix it by returning available data if a previous hypervisor call has
completed in the meantime. I tested the patch with the program above,
and with rng-tools.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 drivers/char/hw_random/virtio-rng.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 79a6e47b5fbc..984713b35892 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -59,6 +59,20 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
 	if (vi->hwrng_removed)
 		return -ENODEV;
 
+	/*
+	 * If the previous call was non-blocking, we may have got some
+	 * randomness already.
+	 */
+	if (vi->busy && completion_done(&vi->have_data)) {
+		unsigned int len;
+
+		vi->busy = false;
+		len = vi->data_avail > size ? size : vi->data_avail;
+		vi->data_avail -= len;
+		if (len)
+			return len;
+	}
+
 	if (!vi->busy) {
 		vi->busy = true;
 		reinit_completion(&vi->have_data);
-- 
2.26.2

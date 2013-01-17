From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 6/6] tools/virtio: adapt for API changes.
Date: Thu, 17 Jan 2013 20:59:43 +1030
Message-ID: <1358418584-26345-6-git-send-email-rusty@rustcorp.com.au>
References: <1358418584-26345-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1358418584-26345-1-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 tools/virtio/vringh_test.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index f3868f4..df09a3f 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -109,8 +109,7 @@ static int parallel_test(unsigned long features)
 
 	if (fork() != 0) {
 		struct vringh vrh;
-		bool notify = false;
-		int status;
+		int status, err;
 
 		/* We are the host: never access guest addresses! */
 		munmap(guest_map, mapsize);
@@ -128,7 +127,7 @@ static int parallel_test(unsigned long features)
 				 vrh.vring.desc, vrh.vring.avail, vrh.vring.used);
 		CPU_SET(first_cpu, &cpu_set);
 		if (sched_setaffinity(getpid(), sizeof(cpu_set), &cpu_set))
-			err(1, "Could not set affinity to cpu %u", first_cpu);
+			errx(1, "Could not set affinity to cpu %u", first_cpu);
 
 		while (xfers < NUM_XFERS) {
 			struct iovec host_riov[2], host_wiov[2];
@@ -150,10 +149,13 @@ static int parallel_test(unsigned long features)
 			if (err == 0) {
 				char buf[128];
 
-				if (notify) {
+				err = vringh_need_notify_user(&vrh);
+				if (err < 0)
+					errx(1, "vringh_need_notify_user: %i",
+					     err);
+				if (err) {
 					write(to_guest[1], "", 1);
 					notifies++;
-					notify = false;
 				}
 
 				if (vringh_notify_enable_user(&vrh))
@@ -180,15 +182,17 @@ static int parallel_test(unsigned long features)
 			xfers++;
 			assert(wiov.i == wiov.max);
 
-			err = vringh_complete_user(&vrh, head, rlen, &notify);
+			err = vringh_complete_user(&vrh, head, rlen);
 			if (err != 0)
 				errx(1, "vringh_complete_user: %i", err);
 		}
 
-		if (notify) {
+		err = vringh_need_notify_user(&vrh);
+		if (err < 0)
+			errx(1, "vringh_need_notify_user: %i", err);
+		if (err) {
 			write(to_guest[1], "", 1);
 			notifies++;
-			notify = false;
 		}
 		wait(&status);
 		if (!WIFEXITED(status))
@@ -344,7 +348,6 @@ int main(int argc, char *argv[])
 	u16 head;
 	int err;
 	unsigned i;
-	bool notify = false;
 	void *ret;
 
 	vdev.features[0] = 0;
@@ -435,7 +438,7 @@ int main(int argc, char *argv[])
 	assert(vringh_iov_push_kern(&wiov, buf, 5) == 0);
 
 	/* Host is done. */
-	err = vringh_complete_user(&vrh, head, err, &notify);
+	err = vringh_complete_user(&vrh, head, err);
 	if (err != 0)
 		errx(1, "vringh_complete_user: %i", err);
 
-- 
1.7.10.4

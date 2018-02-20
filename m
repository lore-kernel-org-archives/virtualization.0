From: Arnd Bergmann <arnd@arndb.de>
Subject: [4.4-stable 12/22] virtio_balloon: prevent uninitialized variable use
Date: Tue, 20 Feb 2018 12:54:59 +0100
Message-ID: <20180220115527.1806578-13-arnd@arndb.de>
References: <20180220115527.1806578-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180220115527.1806578-1-arnd@arndb.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, "Michael S . Tsirkin" <mst@redhat.com>, Greg KH <gregkh@linuxfoundation.org>, Ladi Prosek <lprosek@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

commit f0bb2d50dfcc519f06f901aac88502be6ff1df2c upstream.

The latest gcc-7.0.1 snapshot reports a new warning:

virtio/virtio_balloon.c: In function 'update_balloon_stats':
virtio/virtio_balloon.c:258:26: error: 'events[2]' is used uninitialized in this function [-Werror=uninitialized]
virtio/virtio_balloon.c:260:26: error: 'events[3]' is used uninitialized in this function [-Werror=uninitialized]
virtio/virtio_balloon.c:261:56: error: 'events[18]' is used uninitialized in this function [-Werror=uninitialized]
virtio/virtio_balloon.c:262:56: error: 'events[17]' is used uninitialized in this function [-Werror=uninitialized]

This seems absolutely right, so we should add an extra check to
prevent copying uninitialized stack data into the statistics.
From all I can tell, this has been broken since the statistics code
was originally added in 2.6.34.

Fixes: 9564e138b1f6 ("virtio: Add memory statistics reporting to the balloon driver (V4)")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
[arnd: backported to 4.4]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/virtio/virtio_balloon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 01d15dca940e..26d0dff069f0 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -239,12 +239,15 @@ static void update_balloon_stats(struct virtio_balloon *vb)
 	all_vm_events(events);
 	si_meminfo(&i);
 
+
+#ifdef CONFIG_VM_EVENT_COUNTERS
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_IN,
 				pages_to_bytes(events[PSWPIN]));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_OUT,
 				pages_to_bytes(events[PSWPOUT]));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MAJFLT, events[PGMAJFAULT]);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
+#endif
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMFREE,
 				pages_to_bytes(i.freeram));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMTOT,
-- 
2.9.0

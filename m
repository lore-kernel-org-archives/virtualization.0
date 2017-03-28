From: Ladi Prosek <lprosek@redhat.com>
Subject: [PATCH v3 3/3] virtio_balloon: prevent uninitialized variable use
Date: Tue, 28 Mar 2017 18:46:59 +0200
Message-ID: <20170328164659.4311-4-lprosek@redhat.com>
References: <20170328164659.4311-1-lprosek@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170328164659.4311-1-lprosek@redhat.com>
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
Cc: arnd@arndb.de, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Arnd Bergmann <arnd@arndb.de>

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
---
 drivers/virtio/virtio_balloon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index d9544db..34adf9b 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -254,12 +254,14 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
 
 	available = si_mem_available();
 
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
2.9.3

From: Ladi Prosek <lprosek@redhat.com>
Subject: [PATCH v3 0/3] virtio_balloon: don't push uninitialized buffers to
	stats virtqueue
Date: Tue, 28 Mar 2017 18:46:56 +0200
Message-ID: <20170328164659.4311-1-lprosek@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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

This series fixes issues with variable initialization in the virtio
balloon driver which manifest as the driver sending invalid memory
stats to the host.

v1->v2:

* Call update_balloon_stats instead of filling the buffer with
  invalid tags.
* Add BUG_ON to update_balloon_stats to formalize the invariant that
  all slots in the buffer must be initialized.

v2->v3:

* Remove BUG_ON and return the actual number of counters from
  update_balloon_stats instead.
* Added Arnd's patch to omit VM stats if CONFIG_VM_EVENT_COUNTERS
  is not defined.


Arnd Bergmann (1):
      virtio_balloon: prevent uninitialized variable use

Ladi Prosek (2):
      virtio_balloon: don't push uninitialized buffers to stats virtqueue
      virtio-balloon: use actual number of stats for stats queue buffers

 drivers/virtio/virtio_balloon.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

Thanks!
Ladi

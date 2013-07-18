From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 00/10] virtio: console: fixes for races with port unplug
Date: Fri, 19 Jul 2013 01:46:07 +0530
Message-ID: <cover.1374177234.git.amit.shah@redhat.com>
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
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hello,

This series fixes a few races with port unplug and the various file
operations: read(), write(), close() and poll().

There still might be more races lurking, but testing this series looks
good to at least solve the easily-triggerable ones.  I've run the
virtio-serial testsuite and a few open/close/unplug tests, and haven't
seen any badness.

I've marked these patches for stable@ as well.  I went over the list
twice to check if really each one should go to stable, and to me it
looks like all are stable candidates.

Please review and apply if appropriate,

Amit Shah (10):
  virtio: console: fix race with port unplug and open/close
  virtio: console: fix race in port_fops_open() and port unplug
  virtio: console: clean up port data immediately at time of unplug
  virtio: console: return -ENODEV on all read operations after unplug
  virtio: console: update private_data in struct file only on successful
    open
  virtio: console: fix race in port_fops_poll() and port unplug
  virtio: console: fix raising SIGIO after port unplug
  virtio: console: add locks around buffer removal in port unplug path
  virtio: console: add locking in port unplug path
  virtio: console: fix locking around send_sigio_to_port()

 drivers/char/virtio_console.c | 67 ++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 23 deletions(-)

-- 
1.8.1.4

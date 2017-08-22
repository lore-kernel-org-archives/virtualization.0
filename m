From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: [PATCH] net/virtio-net: reverse unregistering on exit
Date: Tue, 22 Aug 2017 16:59:51 +0200
Message-ID: <1503413992-29558-1-git-send-email-pmorel@linux.vnet.ibm.com>
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
Cc: mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Hi,

I got a problem with virtio-net in a QEMU guest.

When virtio-net is used as a module in a guest and the network is
activated, removing the virtio-net modules produces a kernel error:

[ 2375.624949] Last Breaking-Event-Address:
[ 2375.624954]  [<00000000001453d4>] __cpuhp_remove_state+0x84/0x1a8
[ 2375.624959] ---[ end trace cc9fd68b89f5235a ]---
[ 2375.624966] Error: Removing state 163 which has instances left.
[ 2375.624985] ------------[ cut here ]------------

The problem is produced by an inversion in the order of unregistering
the driver and the hotplug state machine callbacks in virtio_net_driver_exit.

This patch solves the problem by first unregistering the virtio_net_driver
before unregistering the hotplug state machine callbacks.

Best regards,

Pierre Morel

Pierre Morel (1):
  net/virtio-net: reverse unregistering on exit

 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.7.4

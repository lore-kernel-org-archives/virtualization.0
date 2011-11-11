From: Krishna Kumar <krkumar2@in.ibm.com>
Subject: [RFC] [ver3 PATCH 0/6] Implement multiqueue virtio-net
Date: Fri, 11 Nov 2011 18:32:23 +0530
Message-ID: <20111111130223.9878.59517.sendpatchset__48216.7664020837$1321017744$gmane$org@krkumar2.in.ibm.com>
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
To: rusty@rustcorp.com.au, mst@redhat.com
Cc: Krishna Kumar <krkumar2@in.ibm.com>, netdev@vger.kernel.org, davem@davemloft.net, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This patch series resurrects the earlier multiple TX/RX queues
functionality for virtio_net, and addresses the issues pointed
out.  It also includes an API to share irq's, f.e.  amongst the
TX vqs. 

I plan to run TCP/UDP STREAM and RR tests for local->host and
local->remote, and send the results in the next couple of days.


patch #1: Introduce VIRTIO_NET_F_MULTIQUEUE
patch #2: Move 'num_queues' to virtqueue
patch #3: virtio_net driver changes
patch #4: vhost_net changes
patch #5: Implement find_vqs_irq()
patch #6: Convert virtio_net driver to use find_vqs_irq()


		Changes from rev2:
Michael:
-------
1. Added functions to handle setting RX/TX/CTRL vq's.
2. num_queue_pairs instead of numtxqs.
3. Experimental support for fewer irq's in find_vqs.

Rusty:
------
4. Cleaned up some existing "while (1)".
5. rvq/svq and rx_sg/tx_sg changed to vq and sg respectively.
6. Cleaned up some "#if 1" code.


Issue when using patch5:
-------------------------

The new API is designed to minimize code duplication.  E.g.
vp_find_vqs() is implemented as:

static int vp_find_vqs(...)
{
	return vp_find_vqs_irq(vdev, nvqs, vqs, callbacks, names, NULL);
}

In my testing, when multiple tx/rx is used with multiple netperf
sessions, all the device tx queues stops a few thousand times and
subsequently woken up by skb_xmit_done.  But after some 40K-50K
iterations of stop/wake, some of the txq's stop and no wake
interrupt comes. (modprobe -r followed by modprobe solves this, so
it is not a system hang).  At the time of the hang (#txqs=#rxqs=4):

# egrep "CPU|virtio0" /proc/interrupts | grep -v config
       CPU0     CPU1     CPU2    CPU3
41:    49057    49262    48828   49421  PCI-MSI-edge    virtio0-input.0
42:    5066     5213     5221    5109   PCI-MSI-edge    virtio0-output.0
43:    43380    43770    43007   43148  PCI-MSI-edge    virtio0-input.1
44:    41433    41727    42101   41175  PCI-MSI-edge    virtio0-input.2
45:    38465    37629    38468   38768  PCI-MSI-edge    virtio0-input.3

# tc -s qdisc show dev eth0
qdisc mq 0: root      
	Sent 393196939897 bytes 271191624 pkt (dropped 59897,
	overlimits 0 requeues 67156) backlog 25375720b 1601p
	requeues 67156  

I am not sure if patch #5 is responsible for the hang.  Also, without
patch #5/patch #6, I changed vp_find_vqs() to:
static int vp_find_vqs(...)
{
	return vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
				  false, false);
}
No packets were getting TX'd with this change when #txqs>1.  This is
with the MQ-only patch that doesn't touch drivers/virtio/ directory.

Also, the MQ patch works reasonably well with 2 vectors - with
use_msix=1 and per_vq_vectors=0 in vp_find_vqs().

Patch against net-next - please review.

Signed-off-by: krkumar2@in.ibm.com
---

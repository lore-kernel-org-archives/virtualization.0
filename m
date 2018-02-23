From: Tiwei Bie <tiwei.bie@intel.com>
Subject: [PATCH RFC 0/2] Packed ring for virtio
Date: Fri, 23 Feb 2018 19:17:59 +0800
Message-ID: <20180223111801.15240-1-tiwei.bie@intel.com>
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
To: mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Hello everyone,

This RFC implements a subset of packed ring which is described at
https://github.com/oasis-tcs/virtio-docs/blob/master/virtio-v1.1-packed-wd08.pdf

The code was tested with DPDK vhost (testpmd/vhost-PMD) implemented
by Jens at http://dpdk.org/ml/archives/dev/2018-January/089417.html
Minor changes are needed for the vhost code, e.g. to kick the guest.

It's not a complete implementation, here is what's missing:

- Device area and driver area
- VIRTIO_RING_F_INDIRECT_DESC
- VIRTIO_F_NOTIFICATION_DATA
- Virtio devices except net are not tested
- See FIXME in the code for more details

Thanks!

Best regards,
Tiwei Bie

Tiwei Bie (2):
  virtio: introduce packed ring defines
  virtio_ring: support packed ring

 drivers/virtio/virtio_ring.c       | 699 ++++++++++++++++++++++++++++++++-----
 include/linux/virtio_ring.h        |   8 +-
 include/uapi/linux/virtio_config.h |  18 +-
 include/uapi/linux/virtio_ring.h   |  68 ++++
 4 files changed, 703 insertions(+), 90 deletions(-)

-- 
2.14.1

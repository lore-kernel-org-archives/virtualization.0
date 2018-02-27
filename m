From: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH RFC 1/2] virtio: introduce packed ring defines
Date: Tue, 27 Feb 2018 10:18:00 +0100
Message-ID: <20180227091800.n45ng3xgraoqi24u__30281.5883457244$1519722997$gmane$org@dhcp-192-241.str.redhat.com>
References: <20180223111801.15240-1-tiwei.bie@intel.com>
	<20180223111801.15240-2-tiwei.bie@intel.com>
	<20180227085458.h5dytkwaeczrrijr@dhcp-192-241.str.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180227085458.h5dytkwaeczrrijr@dhcp-192-241.str.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 27, 2018 at 09:54:58AM +0100, Jens Freimann wrote:
>On Fri, Feb 23, 2018 at 07:18:00PM +0800, Tiwei Bie wrote:
>>Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
>>---
>>include/uapi/linux/virtio_config.h | 18 +++++++++-
>>include/uapi/linux/virtio_ring.h   | 68 ++++++++++++++++++++++++++++++++++++++
>>2 files changed, 85 insertions(+), 1 deletion(-)
>>
>>diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
>>index 308e2096291f..e3d077ef5207 100644
>>--- a/include/uapi/linux/virtio_config.h
>>+++ b/include/uapi/linux/virtio_config.h
>>@@ -49,7 +49,7 @@
>> * transport being used (eg. virtio_ring), the rest are per-device feature
>> * bits. */
>>#define VIRTIO_TRANSPORT_F_START	28
>>-#define VIRTIO_TRANSPORT_F_END		34
>>+#define VIRTIO_TRANSPORT_F_END		37
>>
>>#ifndef VIRTIO_CONFIG_NO_LEGACY
>>/* Do we get callbacks when the ring is completely used, even if we've
>>@@ -71,4 +71,20 @@
>> * this is for compatibility with legacy systems.
>> */
>>#define VIRTIO_F_IOMMU_PLATFORM		33
>>+
>>+/* This feature indicates support for the packed virtqueue layout. */
>>+#define VIRTIO_F_RING_PACKED		34
>
>Spec says VIRTIO_F_PACKED_RING not RING_PACKED

Ignore this. Seems to have changed.

regards,
Jens 

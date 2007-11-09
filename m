From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio config_ops refactoring
Date: Fri, 9 Nov 2007 22:54:07 +1100
Message-ID: <200711092254.08099.rusty__12915.4695118361$1194609359$gmane$org@rustcorp.com.au>
References: <4730A8F3.6020008@us.ibm.com>
	<200711090924.28659.rusty@rustcorp.com.au>
	<47338EA0.6050100@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47338EA0.6050100@codemonkey.ws>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org, lguest <lguest@ozlabs.org>, Dor Laor <dor.laor@qumranet.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 09 November 2007 09:33:04 Anthony Liguori wrote:
> I really want to make sure that if a guest tries
> to read a 4-byte PCI config field, that it does so using an "outl"
> instruction so that in my QEMU backend

So you want to enforce PCI requirements onto virtio config accesses.  This 
doesn't seem very nice: the fact that PCI accesses use different namespaces 
for different sizes makes sense from a primitive hardware point of view, but 
sucks for software.  Fortunately, if you insist on byte-at-a-time they're the 
same.

> switch (addr) {
> case VIRTIO_BLK_CONFIG_MAX_SEG:
>    return vdev->max_seg & 0xFF;
> case VIRTIO_BLK_CONFIG_MAX_SEG + 1:
>    return (vdev->max_seg >> 8) & 0xFF;
> case VIRTIO_BLK_CONFIG_MAX_SEG + 2:
>    return (vdev->max_seg >> 16) & 0xFF;
> case VIRTIO_BLK_CONFIG_MAX_SEG + 3:
>    return (vdev->max_seg >> 24) & 0xFF;
> case VIRTIO_BLK_CONFIG_MAX_SIZE:
>    return vdev->max_size & 0xFF;
> case VIRTIO_BLK_CONFIG_MAX_SIZE + 1:
>    return (vdev->max_size >> 8) & 0xFF;
> case VIRTIO_BLK_CONFIG_MAX_SIZE + 2:
>    return (vdev->max_size >> 16) & 0xFF;
> case VIRTIO_BLK_CONFIG_MAX_SIZE + 3:
>    return (vdev->max_size >> 24) & 0xFF;
> ...

	struct virtio_blk_config
	{
		uint32_t max_seg, max_size;
	};

	...
	struct virtio_blk_config conf = { vdev->max_seg, vdev->max_size };

	return ((unsigned char *)&conf)[addr];

(Which strongly implies our headers should expose that nominal struct, rather 
than numerical constants).

Rusty.

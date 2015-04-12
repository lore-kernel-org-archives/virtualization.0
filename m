From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/6] virtio_balloon: virtio 1 support
Date: Sun, 12 Apr 2015 17:02:42 +0200
Message-ID: <20150412170141-mutt-send-email-mst@redhat.com>
References: <1427884468-23930-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1427884468-23930-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 01, 2015 at 02:57:35PM +0200, Michael S. Tsirkin wrote:
> Virtio 1.0 doesn't include a modern balloon device.  At some point we'll likely
> define an incompatible interface with a different ID and different
> semantics.  But for now, it's not a big effort to support a transitional
> balloon device: this has the advantage of supporting existing drivers,
> transparently, as well as transports that don't allow mixing virtio 0 and
> virtio 1 devices. And balloon is an easy device to test, so it's also useful
> for people to test virtio core handling of transitional devices.
> 
> The only interface issue is with the stats buffer, which has misaligned
> fields. We could leave it as is, but this sets a bad precedent that
> others might copy by mistake.
> 
> As we need to change stats code to do byteswaps for virtio 1.0, it seems easy
> to fix by prepending a 6 byte reserved field.  I also had to change config
> structure field types from __le32 to __u32 to match other devices. This means
> we need a couple of __force tags for legacy path but that seems minor.

Rusty, what are your thoughts here?
How about merging this for 4.1?


> changes from v2:
> 	fix up stats endian-ness
> Changes from v1:
> 	correctly handle config space endian-ness
> 
> Michael S. Tsirkin (6):
>   virtio_balloon: transitional interface
>   virtio: balloon might not be a legacy device
>   virtio_ccw: support non-legacy balloon devices
>   virtio_mmio: support non-legacy balloon devices
>   virtio_pci: support non-legacy balloon devices
>   virtio: drop virtio_device_is_legacy_only
> 
>  include/linux/virtio.h              |  2 --
>  include/uapi/linux/virtio_balloon.h | 11 +++++++++--
>  drivers/s390/kvm/virtio_ccw.c       | 10 +++-------
>  drivers/virtio/virtio.c             |  6 ------
>  drivers/virtio/virtio_balloon.c     | 33 +++++++++++++++++++++++----------
>  drivers/virtio/virtio_mmio.c        |  8 --------
>  drivers/virtio/virtio_pci_modern.c  |  3 ---
>  7 files changed, 35 insertions(+), 38 deletions(-)
> 
> -- 
> MST

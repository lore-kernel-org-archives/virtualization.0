From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 0/6] virtio_balloon: virtio 1 support
Date: Tue, 31 Mar 2015 10:46:18 +0200
Message-ID: <20150331104618.3da249e3.cornelia.huck__29853.5988353708$1427791611$gmane$org@de.ibm.com>
References: <1427737006-23191-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1427737006-23191-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 30 Mar 2015 19:37:08 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Virtio 1.0 doesn't include a modern balloon device.
> At some point we'll likely define an incompatible interface with a different
> ID.  But for now, it's not a big change to support a transitional balloon
> device: this has the advantage of supporting existing drivers, transparently.

This is needed to support a ballooner on transports that don't support
mixing legacy and 1.0, right?

> 
> The only issue is with the stats buffer, which has misaligned fields.
> Seems easy to fix by prepending a 6 byte reserved field.

I assume you also define the stats fields to be le for 1.0?

> 
> I'll post spec patch and qemu patches shortly.

I'll defer review until then.

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
>  include/uapi/linux/virtio_balloon.h |  6 ++++++
>  drivers/s390/kvm/virtio_ccw.c       | 10 +++-------
>  drivers/virtio/virtio.c             |  6 ------
>  drivers/virtio/virtio_balloon.c     |  8 ++++++--
>  drivers/virtio/virtio_mmio.c        |  8 --------
>  drivers/virtio/virtio_pci_modern.c  |  3 ---
>  7 files changed, 15 insertions(+), 28 deletions(-)
> 

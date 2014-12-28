From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH 0/3] Sharing MSIX irq for tx/rx queue pairs
Date: Sun, 28 Dec 2014 09:52:26 +0200
Message-ID: <20141228075226.GA25704@redhat.com>
References: <1419562425-20614-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1419562425-20614-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 26, 2014 at 10:53:42AM +0800, Jason Wang wrote:
> Hi all:
> 
> This series try to share MSIX irq for each tx/rx queue pair. This is
> done through:
> 
> - introducing virtio pci channel which are group of virtqueues that
>   sharing a single MSIX irq (Patch 1)
> - expose channel setting to virtio core api (Patch 2)
> - try to use channel setting in virtio-net (Patch 3)
> 
> For the transport that does not support channel, channel paramters
> were simply ignored. For devices that does not use channel, it can
> simply pass NULL or zero to virito core.
> 
> With the patch, 1 MSIX irq were saved for each TX/RX queue pair.
> 
> Please review.

How does this sharing affect performance?


> Thanks
> 
> Jason Wang (3):
>   virtio-pci: introduce channels
>   virtio: let vp_find_vqs accept channel setting paramters
>   virtio-net: using single MSIX irq for each TX/RX queue pair
> 
>  drivers/block/virtio_blk.c             |   3 +-
>  drivers/char/virtio_console.c          |   3 +-
>  drivers/lguest/lguest_device.c         |   5 +-
>  drivers/misc/mic/card/mic_virtio.c     |   5 +-
>  drivers/net/caif/caif_virtio.c         |   3 +-
>  drivers/net/virtio_net.c               |  26 ++++-
>  drivers/remoteproc/remoteproc_virtio.c |   5 +-
>  drivers/rpmsg/virtio_rpmsg_bus.c       |   3 +-
>  drivers/s390/kvm/kvm_virtio.c          |   5 +-
>  drivers/s390/kvm/virtio_ccw.c          |   5 +-
>  drivers/scsi/virtio_scsi.c             |   3 +-
>  drivers/virtio/virtio_balloon.c        |   3 +-
>  drivers/virtio/virtio_mmio.c           |   5 +-
>  drivers/virtio/virtio_pci_common.c     | 207 ++++++++++++++++++++-------------
>  drivers/virtio/virtio_pci_common.h     |  19 ++-
>  include/linux/virtio_config.h          |   8 +-
>  16 files changed, 208 insertions(+), 100 deletions(-)
> 
> -- 
> 1.8.3.1

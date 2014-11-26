From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC v3 11/12] virtio-net/virtio-blk: enable virtio 1.0
Date: Wed, 26 Nov 2014 20:50:05 +0200
Message-ID: <20141126185005.GA9549@redhat.com>
References: <1417022923-1654-1-git-send-email-cornelia.huck@de.ibm.com>
	<1417022923-1654-12-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1417022923-1654-12-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 26, 2014 at 06:28:42PM +0100, Cornelia Huck wrote:
> virtio-net (non-vhost) and virtio-blk have everything in place to support
> virtio 1.0: let's enable the feature bit for them.

Hmm I doubt that.
At least not without more patches.

For block, scsi, wce and config-wce must be off, and
it must support ANY_LAYOUT (which might be a bit more code).

For net, header size is different when mergeable bufs are off,
and mac is read-only.



> Note that VIRTIO_F_VERSION_1 is technically a transport feature; once
> every device is ready for virtio 1.0, we can move this setting this
> feature bit out of the individual devices.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/block/virtio-blk.c |    4 ++++
>  hw/net/virtio-net.c   |    4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 6d86f60..3781f98 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -569,6 +569,10 @@ static uint32_t virtio_blk_get_features(VirtIODevice *vdev, unsigned int index,
>  {
>      VirtIOBlock *s = VIRTIO_BLK(vdev);
>  
> +    if (index == 1) {
> +        features |= (1 << (VIRTIO_F_VERSION_1 - 32));
> +    }
> +
>      if (index > 0) {
>          return features;
>      }
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 1e214b5..fcfc95f 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -447,6 +447,10 @@ static uint32_t virtio_net_get_features(VirtIODevice *vdev, unsigned int index,
>      VirtIONet *n = VIRTIO_NET(vdev);
>      NetClientState *nc = qemu_get_queue(n->nic);
>  
> +    if (index == 1 && !get_vhost_net(nc->peer)) {
> +        features |= (1 << (VIRTIO_F_VERSION_1 - 32));
> +    }
> +
>      if (index > 0) {
>          return features;
>      }
> -- 
> 1.7.9.5

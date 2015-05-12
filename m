From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC 4/7] vhost: set vring endianness for
	legacy virtio
Date: Tue, 12 May 2015 15:25:30 +0200
Message-ID: <20150512152530.4ab0c56f.cornelia.huck@de.ibm.com>
References: <20150506120729.8607.23404.stgit@bahia.huguette.org>
	<20150506120801.8607.64278.stgit@bahia.huguette.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150506120801.8607.64278.stgit@bahia.huguette.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 06 May 2015 14:08:02 +0200
Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:

> Legacy virtio is native endian: if the guest and host endianness differ,
> we have to tell vhost so it can swap bytes where appropriate. This is
> done through a vhost ring ioctl.
> 
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> ---
>  hw/virtio/vhost.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 54851b7..1d7b939 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
(...)
> @@ -677,6 +700,16 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
>          return -errno;
>      }
> 
> +    if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1) &&

I think this should either go in after the virtio-1 base support (more
feature bits etc.) or get a big fat comment and be touched up later.
I'd prefer the first solution so it does not get forgotten, but I'm not
sure when Michael plans to proceed with the virtio-1 patches (I think
they're mostly fine already).

> +        virtio_legacy_is_cross_endian(vdev)) {
> +        r = vhost_virtqueue_set_vring_endian_legacy(dev,
> +                                                    virtio_is_big_endian(vdev),
> +                                                    vhost_vq_index);
> +        if (r) {
> +            return -errno;
> +        }
> +    }
> +
>      s = l = virtio_queue_get_desc_size(vdev, idx);
>      a = virtio_queue_get_desc_addr(vdev, idx);
>      vq->desc = cpu_physical_memory_map(a, &l, 0);

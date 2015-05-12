From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC 1/7] virtio: relax feature check
Date: Tue, 12 May 2015 15:14:53 +0200
Message-ID: <20150512151453.42880d6c.cornelia.huck@de.ibm.com>
References: <20150506120729.8607.23404.stgit@bahia.huguette.org>
	<20150506120737.8607.30158.stgit@bahia.huguette.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150506120737.8607.30158.stgit@bahia.huguette.org>
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

On Wed, 06 May 2015 14:07:37 +0200
Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:

> Unlike with add and clear, there is no valid reason to abort when checking
> for a feature. It makes more sense to return false (i.e. the feature bit
> isn't set). This is exactly what __virtio_has_feature() does if fbit >= 32.
> 
> This allows to introduce code that is aware about new 64-bit features like
> VIRTIO_F_VERSION_1, even if they are still not implemented.
> 
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> ---
>  include/hw/virtio/virtio.h |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index d95f8b6..6ef70f1 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -233,7 +233,6 @@ static inline void virtio_clear_feature(uint32_t *features, unsigned int fbit)
> 
>  static inline bool __virtio_has_feature(uint32_t features, unsigned int fbit)
>  {
> -    assert(fbit < 32);
>      return !!(features & (1 << fbit));
>  }
> 
> 
> 

I must say I'm not very comfortable with knowingly passing out-of-rage
values to this function.

Can we perhaps apply at least the feature-bit-size extending patches
prior to your patchset, if the remainder of the virtio-1 patchset still
takes some time?

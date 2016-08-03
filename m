From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH -next v2] virtio: fix possible memory leak in
	virtqueue_add()
Date: Wed, 3 Aug 2016 07:22:01 +0300
Message-ID: <20160803072138-mutt-send-email-mst@kernel.org>
References: <1470146345-19531-1-git-send-email-weiyj.lk@gmail.com>
	<1470147391-20549-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1470147391-20549-1-git-send-email-weiyj.lk@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 02, 2016 at 02:16:31PM +0000, Wei Yongjun wrote:
> 'desc' is malloced in virtqueue_add() and should be freed before
> leaving from the error handling cases, otherwise it will cause
> memory leak.
> 
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>

Appliecd except I moved this to before END_USE - seems
cleaner as alloc is caller after START_USE.

> ---
>  drivers/virtio/virtio_ring.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 114a0c8..e4be912 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -328,6 +328,8 @@ static inline int virtqueue_add(struct virtqueue *_vq,
>  		if (out_sgs)
>  			vq->notify(&vq->vq);
>  		END_USE(vq);
> +		if (indirect)
> +			kfree(desc);
>  		return -ENOSPC;
>  	}

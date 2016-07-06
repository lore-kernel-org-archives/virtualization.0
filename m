From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH] virtio: Return correct errno for function init_vq's
	failure
Date: Wed, 6 Jul 2016 11:18:32 +0200
Message-ID: <20160706111832.5d4d6f43.cornelia.huck__44426.204407546$1467802986$gmane$org@de.ibm.com>
References: <1466993358-12064-1-git-send-email-mnghuan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1466993358-12064-1-git-send-email-mnghuan@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Minfei Huang <mnghuan@gmail.com>, mst@redhat.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Minfei Huang <minfei.hmf@alibaba-inc.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 27 Jun 2016 10:09:18 +0800
Minfei Huang <mnghuan@gmail.com> wrote:

> The error number -ENOENT or 0 will be returned, if we can not allocate
> more memory in function init_vq. If host can support multiple virtual
> queues, and we fails to allocate necessary memory structures for vq,
> kernel may crash due to incorrect returning.
> 
> To fix it, kernel will return correct value in init_vq.
> 
> Signed-off-by: Minfei Huang <mnghuan@gmail.com>
> Signed-off-by: Minfei Huang <minfei.hmf@alibaba-inc.com>
> ---
>  drivers/block/virtio_blk.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 42758b5..40ecb2b 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -393,11 +393,10 @@ static int init_vq(struct virtio_blk *vblk)
>  	if (err)
>  		num_vqs = 1;
> 
> +	err = -ENOMEM;
>  	vblk->vqs = kmalloc(sizeof(*vblk->vqs) * num_vqs, GFP_KERNEL);
> -	if (!vblk->vqs) {
> -		err = -ENOMEM;
> +	if (!vblk->vqs)
>  		goto out;
> -	}
> 
>  	names = kmalloc(sizeof(*names) * num_vqs, GFP_KERNEL);
>  	if (!names)

The error handling in this function looks horrible.

When mq was introduced, init_vq started mixing up several things:
- The mq feature is not available - which is not an error, and
therefore should not have any influence on the return code.
- One of the several memory allocations failed - only ->vqs gets
special treatment, however.
- The ->find_vqs callback failed.

Your patch fixes the code, but it is still very convoluted due to the
temporary arrays.

May it be worthwile to introduce a helper for setting up the virtqueues
where all virtqueues are essentially the same and just get a
consecutive number? Michael?

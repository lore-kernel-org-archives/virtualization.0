From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH 12/16] virtio_console: use simplified virtqueue accessors.
Date: Wed, 20 Feb 2013 18:12:40 +0800
Message-ID: <5124A198.8020102@cn.fujitsu.com>
References: <1361260594-601-1-git-send-email-rusty@rustcorp.com.au>
	<1361260594-601-13-git-send-email-rusty@rustcorp.com.au>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1361260594-601-13-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 02/19/2013 03:56 PM, Rusty Russell wrote:
> We never add buffers with input and output parts, so use the new accessors.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> ---
>  drivers/char/virtio_console.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index e905d5f..6d59f16 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -502,7 +502,7 @@ static int add_inbuf(struct virtqueue *vq, struct port_buffer *buf)
>  
>  	sg_init_one(sg, buf->buf, buf->size);
>  
> -	ret = virtqueue_add_buf(vq, sg, 0, 1, buf, GFP_ATOMIC);
> +	ret = virtqueue_add_inbuf(vq, sg, 1, buf, GFP_ATOMIC);
>  	virtqueue_kick(vq);
>  	if (!ret)
>  		ret = vq->num_free;
> @@ -569,7 +569,7 @@ static ssize_t __send_control_msg(struct ports_device *portdev, u32 port_id,
>  	vq = portdev->c_ovq;
>  
>  	sg_init_one(sg, &cpkt, sizeof(cpkt));
> -	if (virtqueue_add_buf(vq, sg, 1, 0, &cpkt, GFP_ATOMIC) == 0) {
> +	if (virtqueue_add_outbuf(vq, sg, 1, &cpkt, GFP_ATOMIC) == 0) {
>  		virtqueue_kick(vq);
>  		while (!virtqueue_get_buf(vq, &len))
>  			cpu_relax();
> @@ -618,7 +618,7 @@ static ssize_t __send_to_port(struct port *port, struct scatterlist *sg,
>  
>  	reclaim_consumed_buffers(port);
>  
> -	err = virtqueue_add_buf(out_vq, sg, nents, 0, data, GFP_ATOMIC);
> +	err = virtqueue_add_outbuf(out_vq, sg, nents, data, GFP_ATOMIC);
>  
>  	/* Tell Host to go! */
>  	virtqueue_kick(out_vq);
> 

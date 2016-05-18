From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 1/1] virtio-balloon: handle virtio-1 endianness
Date: Wed, 18 May 2016 15:33:58 +0300
Message-ID: <20160518153318-mutt-send-email-mst@redhat.com>
References: <1463573563-34081-1-git-send-email-cornelia.huck@de.ibm.com>
	<1463573563-34081-2-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1463573563-34081-2-git-send-email-cornelia.huck@de.ibm.com>
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
Cc: borntraeger@de.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 18, 2016 at 02:12:43PM +0200, Cornelia Huck wrote:
> As virtio-1 devices use little endian on their queues, we need
> to make sure the pfns are in virtio32 format before we put
> them on the queue.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

I have a less hacky version that I was testing.
Will post now.

> ---
>  drivers/virtio/virtio_balloon.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 7b6d74f..89da06c 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -76,6 +76,7 @@ struct virtio_balloon {
>  	/* The array of pfns we tell the Host about. */
>  	unsigned int num_pfns;
>  	u32 pfns[VIRTIO_BALLOON_ARRAY_PFNS_MAX];
> +	__virtio32 vpfns[VIRTIO_BALLOON_ARRAY_PFNS_MAX];
>  
>  	/* Memory statistics */
>  	struct virtio_balloon_stat stats[VIRTIO_BALLOON_S_NR];
> @@ -115,8 +116,11 @@ static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
>  {
>  	struct scatterlist sg;
>  	unsigned int len;
> +	int i;
>  
> -	sg_init_one(&sg, vb->pfns, sizeof(vb->pfns[0]) * vb->num_pfns);
> +	for (i = 0; i < vb->num_pfns; i++)
> +		vb->vpfns[i] = cpu_to_virtio32(vb->vdev, vb->pfns[i]);
> +	sg_init_one(&sg, vb->vpfns, sizeof(vb->vpfns[0]) * vb->num_pfns);
>  
>  	/* We should always be able to add one buffer to an empty queue. */
>  	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
> -- 
> 2.6.6

From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/2] crypto: virtio: fix src/dst scatterlist calculation
Date: Mon, 25 May 2020 11:12:14 +0800
Message-ID: <25cff618-601c-e899-a3cc-b289863a7407@redhat.com>
References: <20200525005627.707-1-longpeng2@huawei.com>
 <20200525005627.707-2-longpeng2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <20200525005627.707-2-longpeng2@huawei.com>
Content-Language: en-US
Sender: linux-crypto-owner@vger.kernel.org
To: "Longpeng(Mike)" <longpeng2@huawei.com>, linux-crypto@vger.kernel.org
Cc: Gonglei <arei.gonglei@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, LABBE Corentin <clabbe@baylibre.com>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/5/25 上午8:56, Longpeng(Mike) wrote:
> The system will crash when we insmod crypto/tcrypt.ko whit mode=38.
>
> Usually the next entry of one sg will be @sg@ + 1, but if this sg element
> is part of a chained scatterlist, it could jump to the start of a new
> scatterlist array. Let's fix it by sg_next() on calculation of src/dst
> scatterlist.
>
> BTW I add a check for sg_nents_for_len() its return value since
> sg_nents_for_len() function could fail.
>
> Cc: Gonglei <arei.gonglei@huawei.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: virtualization@lists.linux-foundation.org
> Cc: linux-kernel@vger.kernel.org
>
> Reported-by: LABBE Corentin <clabbe@baylibre.com>
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>   drivers/crypto/virtio/virtio_crypto_algs.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/crypto/virtio/virtio_crypto_algs.c b/drivers/crypto/virtio/virtio_crypto_algs.c
> index 372babb44112..2fa1129f96d6 100644
> --- a/drivers/crypto/virtio/virtio_crypto_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_algs.c
> @@ -359,8 +359,14 @@ __virtio_crypto_skcipher_do_req(struct virtio_crypto_sym_request *vc_sym_req,
>   	unsigned int num_out = 0, num_in = 0;
>   	int sg_total;
>   	uint8_t *iv;
> +	struct scatterlist *sg;
>   
>   	src_nents = sg_nents_for_len(req->src, req->cryptlen);
> +	if (src_nents < 0) {
> +		pr_err("Invalid number of src SG.\n");
> +		return src_nents;
> +	}
> +
>   	dst_nents = sg_nents(req->dst);
>   
>   	pr_debug("virtio_crypto: Number of sgs (src_nents: %d, dst_nents: %d)\n",
> @@ -446,12 +452,12 @@ __virtio_crypto_skcipher_do_req(struct virtio_crypto_sym_request *vc_sym_req,
>   	vc_sym_req->iv = iv;
>   
>   	/* Source data */
> -	for (i = 0; i < src_nents; i++)
> -		sgs[num_out++] = &req->src[i];
> +	for (sg = req->src, i = 0; sg && i < src_nents; sg = sg_next(sg), i++)


Any reason sg is checked here?

I believe it should be checked in sg_nents_for_len().


> +		sgs[num_out++] = sg;
>   
>   	/* Destination data */
> -	for (i = 0; i < dst_nents; i++)
> -		sgs[num_out + num_in++] = &req->dst[i];
> +	for (sg = req->dst, i = 0; sg && i < dst_nents; sg = sg_next(sg), i++)
> +		sgs[num_out + num_in++] = sg;


I believe sg should be checked in sg_nents().

Thanks


>   
>   	/* Status */
>   	sg_init_one(&status_sg, &vc_req->status, sizeof(vc_req->status));

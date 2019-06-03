From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v3 5/8] virtio/s390: use cacheline aligned airq bit vectors
Date: Mon, 3 Jun 2019 11:10:43 +0200
Message-ID: <6ae9d5dd-f4a1-a10a-0973-0e6ca93f4734@de.ibm.com>
References: <20190529122657.166148-1-mimu@linux.ibm.com>
	<20190529122657.166148-6-mimu@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190529122657.166148-6-mimu@linux.ibm.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michael Mueller <mimu@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org



On 29.05.19 14:26, Michael Mueller wrote:
> From: Halil Pasic <pasic@linux.ibm.com>
> 
> The flag AIRQ_IV_CACHELINE was recently added to airq_iv_create(). Let
> us use it! We actually wanted the vector to span a cacheline all along.

Given that VIRTIO_IV_BITS is (L1_CACHE_BYTES * 8) this makes perfect sense.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index f995798bb025..1da7430f94c8 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -216,7 +216,8 @@ static struct airq_info *new_airq_info(void)
>  	if (!info)
>  		return NULL;
>  	rwlock_init(&info->lock);
> -	info->aiv = airq_iv_create(VIRTIO_IV_BITS, AIRQ_IV_ALLOC | AIRQ_IV_PTR);
> +	info->aiv = airq_iv_create(VIRTIO_IV_BITS, AIRQ_IV_ALLOC | AIRQ_IV_PTR
> +				   | AIRQ_IV_CACHELINE);
>  	if (!info->aiv) {
>  		kfree(info);
>  		return NULL;
> 

From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC][PATCH] virtio: 64 bit features
Date: Tue, 12 Apr 2011 16:04:56 +0200
Message-ID: <4DA45C08.4070304__7986.70601002431$1302617259$gmane$org@de.ibm.com>
References: <20110411165525.GA1395@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110411165525.GA1395@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, lguest@lists.ozlabs.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Am 11.04.2011 18:55, schrieb Michael S. Tsirkin:

Looks mostly good, but 


> --- a/drivers/s390/kvm/kvm_virtio.c
> +++ b/drivers/s390/kvm/kvm_virtio.c
> @@ -82,13 +82,13 @@ static unsigned desc_size(const struct kvm_device_desc *desc)
>  static u32 kvm_get_features(struct virtio_device *vdev)

This should be u64.

>  {
>  	unsigned int i;
> -	u32 features = 0;
> +	u64 features = 0;
>  	struct kvm_device_desc *desc = to_kvmdev(vdev)->desc;
>  	u8 *in_features = kvm_vq_features(desc);
> 
> -	for (i = 0; i < min(desc->feature_len * 8, 32); i++)
> +	for (i = 0; i < min(desc->feature_len * 8, 64); i++)
>  		if (in_features[i / 8] & (1 << (i % 8)))
> -			features |= (1 << i);
> +			features |= (1ull << i);
>  	return features;
>  }

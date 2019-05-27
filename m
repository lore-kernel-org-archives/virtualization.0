From: Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH v2 2/8] s390/cio: introduce DMA pools to cio
Date: Mon, 27 May 2019 13:26:45 +0200
Message-ID: <a42a0d7d-fd0b-b1bf-d4d9-3d64a8ff31f1@linux.ibm.com>
References: <20190523162209.9543-1-mimu@linux.ibm.com>
	<20190523162209.9543-3-mimu@linux.ibm.com>
	<alpine.LFD.2.21.1905251115590.3359@schleppi>
Reply-To: mimu@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.21.1905251115590.3359@schleppi>
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
To: Sebastian Ott <sebott@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoph Hellwig <hch@infradead.org>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org



On 25.05.19 11:22, Sebastian Ott wrote:
> 
> On Thu, 23 May 2019, Michael Mueller wrote:
>> +static void __init cio_dma_pool_init(void)
>> +{
>> +	/* No need to free up the resources: compiled in */
>> +	cio_dma_pool = cio_gp_dma_create(cio_get_dma_css_dev(), 1);
> 
> This can return NULL.

css_bus_init() will fail with -ENOMEM in v3

> 
>> +/**
>> + * Allocate dma memory from the css global pool. Intended for memory not
>> + * specific to any single device within the css. The allocated memory
>> + * is not guaranteed to be 31-bit addressable.
>> + *
>> + * Caution: Not suitable for early stuff like console.
>> + *
>> + */
> 
> drivers/s390/cio/css.c:1121: warning: Function parameter or member 'size' not described in 'cio_dma_zalloc'

will complete param description in v3

> 
> Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>

Thanks!

> 

Michael

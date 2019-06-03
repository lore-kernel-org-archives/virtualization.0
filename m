From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 8/8] virtio/s390: make airq summary indicators DMA
Date: Mon, 3 Jun 2019 18:03:37 +0200
Message-ID: <20190603180337.17723bcf.cohuck@redhat.com>
References: <20190529122657.166148-1-mimu@linux.ibm.com>
	<20190529122657.166148-9-mimu@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190529122657.166148-9-mimu@linux.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michael Mueller <mimu@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoph Hellwig <hch@infradead.org>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 29 May 2019 14:26:57 +0200
Michael Mueller <mimu@linux.ibm.com> wrote:

> From: Halil Pasic <pasic@linux.ibm.com>
> 
> Hypervisor needs to interact with the summary indicators, so these
> need to be DMA memory as well (at least for protected virtualization
> guests).
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)

(...)

> @@ -1501,6 +1508,11 @@ static int __init virtio_ccw_init(void)
>  {
>  	/* parse no_auto string before we do anything further */
>  	no_auto_parse();
> +
> +	summary_indicators = cio_dma_zalloc(MAX_AIRQ_AREAS);
> +	if (!summary_indicators)
> +		return -ENOMEM;
> +
>  	return ccw_driver_register(&virtio_ccw_driver);

Don't you need to free summary_indicators again if registering the
driver fails?

>  }
>  device_initcall(virtio_ccw_init);

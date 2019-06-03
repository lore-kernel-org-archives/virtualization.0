From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3 2/8] s390/cio: introduce DMA pools to cio
Date: Mon, 3 Jun 2019 16:04:28 +0200
Message-ID: <20190603160428.2112077a.pasic@linux.ibm.com>
References: <20190529122657.166148-1-mimu@linux.ibm.com>
	<20190529122657.166148-3-mimu@linux.ibm.com>
	<20190603133745.240c00a7.cohuck@redhat.com>
	<035b4bd3-5856-e8e5-91bf-ba0b5c7c3736@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <035b4bd3-5856-e8e5-91bf-ba0b5c7c3736@linux.ibm.com>
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
Cc: Vasily Gorbik <gor@linux.ibm.com>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 3 Jun 2019 14:09:02 +0200
Michael Mueller <mimu@linux.ibm.com> wrote:

> >> @@ -1059,16 +1168,19 @@ static int __init css_bus_init(void)
> >>   	if (ret)
> >>   		goto out_unregister;
> >>   	ret = register_pm_notifier(&css_power_notifier);
> >> -	if (ret) {
> >> -		unregister_reboot_notifier(&css_reboot_notifier);
> >> -		goto out_unregister;
> >> -	}
> >> +	if (ret)
> >> +		goto out_unregister_rn;
> >> +	ret = cio_dma_pool_init();
> >> +	if (ret)
> >> +		goto out_unregister_rn;  
> > 
> > Don't you also need to unregister the pm notifier on failure here?  
> 
> Mmh, that was the original intention. Thanks!

I suppose we could also move cio_dma_pool_init() right before the
register_reboot_notifier() call and goto out_unregister on error.

Regards,
Halil

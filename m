From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3 2/8] s390/cio: introduce DMA pools to cio
Date: Mon, 3 Jun 2019 14:57:30 +0200
Message-ID: <20190603145730.3e45b8f5.pasic@linux.ibm.com>
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

> >> @@ -224,6 +226,8 @@ struct subchannel *css_alloc_subchannel(struct subchannel_id schid,
> >>   	INIT_WORK(&sch->todo_work, css_sch_todo);
> >>   	sch->dev.release = &css_subchannel_release;
> >>   	device_initialize(&sch->dev);  
> > 
> > It might be helpful to add a comment why you use 31 bit here...  
> 
> @Halil, please let me know what comment you prefere here...
> 

How about?

/*
 * The physical addresses of some the dma structures that
 * can belong  to a subchannel need to fit 31 bit width (examples ccw,).
 */


> >   
> >> +	sch->dev.coherent_dma_mask = DMA_BIT_MASK(31);
> >> +	sch->dev.dma_mask = &sch->dev.coherent_dma_mask;
> >>   	return sch;
> >>   
> >>   err:
> >> @@ -899,6 +903,8 @@ static int __init setup_css(int nr)
> >>   	dev_set_name(&css->device, "css%x", nr);
> >>   	css->device.groups = cssdev_attr_groups;
> >>   	css->device.release = channel_subsystem_release;  
> > 
> > ...and 64 bit here.  
> 
> and here.

/*
 * We currently allocate notifier bits with this (using css->device
 * as the device argument with the DMA API), and are fine with 64 bit
 * addresses.
 */

Regards,
Halil

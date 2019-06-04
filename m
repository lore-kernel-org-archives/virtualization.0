From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3 7/8] virtio/s390: use DMA memory for ccw I/O and
	classic notifiers
Date: Tue, 4 Jun 2019 16:29:09 +0200
Message-ID: <20190604162909.54de39fb.pasic@linux.ibm.com>
References: <20190529122657.166148-1-mimu@linux.ibm.com>
	<20190529122657.166148-8-mimu@linux.ibm.com>
	<20190603181716.325101d9.cohuck@redhat.com>
	<20190604150819.1f8707b5.pasic@linux.ibm.com>
	<20190604153625.6c03c232.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190604153625.6c03c232.cohuck@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cohuck@redhat.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Farhan Ali <alifm@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Mueller <mimu@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 4 Jun 2019 15:36:25 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 4 Jun 2019 15:08:19 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 

[..]

> 
> Two things:
> - The call path goes from the vcdev to the vdev, then back to the vcdev
>   and then to the cdev. Going from the vcdev to the cdev  directly
>   eliminates the roundtrip via the vdev, which I think does not add
>   anything.
> - I prefer
> 	variable = function_returning_a_pointer(...);
>   over
> 	function_setting_a_variable(..., variable);
>   The latter obscures the fact that we change the value of the
>   variable, unless named very obviously.
> 

I understand. Here it's especially bad because what looks like a
function is actually a macro so it ain't even fn(..., &variable) but
just fn(..., variable). I guess I'm a bit desensitized towards the latter
because of my c++ background.


> > 
> > I will change this for v4 as you requested. Again sorry for missing it!
> 
> np, can happen.

Thanks for the explanation. I will use

ccw_device_dma_zalloc() directly in v4.

Regards,
Halil

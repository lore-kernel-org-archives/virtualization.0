From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH 05/10] s390/cio: introduce DMA pools to cio
Date: Thu, 9 May 2019 10:40:59 +0200 (CEST)
Message-ID: <alpine.LFD.2.21.1905091039520.1779@schleppi>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
	<20190426183245.37939-6-pasic@linux.ibm.com>
	<alpine.LFD.2.21.1905081447280.1773@schleppi>
	<20190508232210.5a555caa.pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190508232210.5a555caa.pasic@linux.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Mueller <mimu@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org


On Wed, 8 May 2019, Halil Pasic wrote:
> On Wed, 8 May 2019 15:18:10 +0200 (CEST)
> Sebastian Ott <sebott@linux.ibm.com> wrote:
> > > @@ -1063,6 +1163,7 @@ static int __init css_bus_init(void)
> > >  		unregister_reboot_notifier(&css_reboot_notifier);
> > >  		goto out_unregister;
> > >  	}
> > > +	cio_dma_pool_init();  
> > 
> > This is too late for early devices (ccw console!).
> 
> You have already raised concern about this last time (thanks). I think,
> I've addressed this issue: tje cio_dma_pool is only used by the airq
> stuff. I don't think the ccw console needs it. Please have an other look
> at patch #6, and explain your concern in more detail if it persists.

Oh, you don't use the global pool for that - yes that should work.

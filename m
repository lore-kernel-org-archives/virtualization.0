From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3 4/8] s390/airq: use DMA memory for adapter interrupts
Date: Tue, 4 Jun 2019 17:06:18 +0200
Message-ID: <20190604170618.74f2c561.pasic@linux.ibm.com>
References: <20190529122657.166148-1-mimu@linux.ibm.com>
	<20190529122657.166148-5-mimu@linux.ibm.com>
	<20190603172740.1023e078.cohuck@redhat.com>
	<20190604152256.158d688c.pasic@linux.ibm.com>
	<20190604165120.5afdce78.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190604165120.5afdce78.cohuck@redhat.com>
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

On Tue, 4 Jun 2019 16:51:20 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 4 Jun 2019 15:22:56 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Mon, 3 Jun 2019 17:27:40 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > > Apologies if that already has been answered (and I missed it in my mail
> > > pile...), but two things had come to my mind previously:
> > > 
> > > - CHSC... does anything need to be done there? Last time I asked:
> > >   "Anyway, css_bus_init() uses some chscs
> > >    early (before cio_dma_pool_init), so we could not use the pools
> > >    there, even if we wanted to. Do chsc commands either work, or else
> > >    fail benignly on a protected virt guest?"  
> > 
> > Protected virt won't support all CHSC. The supported ones won't requre
> > use of shared memory. So we are fine.
> 
> I suppose the supported ones are the sync chscs that use the chsc area
> as a direct parameter (and therefore are handled similarly to the other
> I/O instructions that supply a direct parameter)? I don't think we care
> about async chscs in KVM/QEMU anyway, as we don't even emulate chsc
> subchannels :) (And IIRC, you don't get chsc subchannels in z/VM
> guests, either.)

Nod.

> 
> > 
> > > - PCI indicators... does this interact with any dma configuration on
> > >   the pci device? (I know pci is not supported yet, and I don't really
> > >   expect any problems.)
> > >   
> > 
> > It does but, I'm pretty confident we don't have a problem with PCI. IMHO
> > Sebastian is the guy who needs to be paranoid about this, and he r-b-ed
> > the respective patches.
> 
> Just wanted to make sure that this was on the radar. You guys are
> obviously in a better position than me to judge this :)
> 
> Anyway, I do not intend to annoy with those questions, it's just hard
> to get a feel if there are areas that still need care if you don't have
> access to the documentation for this... if you tell me that you are
> aware of it and it should work, that's fine for me.
> 

The questions are important. It is just the not so unusual problem with
the availability of public documentation that makes things a bit
difficult for me as well.

And sorry if these questions were ignored in the past. I did not have
the bandwidth to take care of all the questions properly, but I did
enough so that the other guys never knew if they need to engage or not.

Regards,
Halil

From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3 4/8] s390/airq: use DMA memory for adapter interrupts
Date: Tue, 4 Jun 2019 15:22:56 +0200
Message-ID: <20190604152256.158d688c.pasic@linux.ibm.com>
References: <20190529122657.166148-1-mimu@linux.ibm.com>
	<20190529122657.166148-5-mimu@linux.ibm.com>
	<20190603172740.1023e078.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190603172740.1023e078.cohuck@redhat.com>
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
Cc: Vasily Gorbik <gor@linux.ibm.com>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Mueller <mimu@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 3 Jun 2019 17:27:40 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 29 May 2019 14:26:53 +0200
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
> > From: Halil Pasic <pasic@linux.ibm.com>
> > 
> > Protected virtualization guests have to use shared pages for airq
> > notifier bit vectors, because hypervisor needs to write these bits.
> > 
> > Let us make sure we allocate DMA memory for the notifier bit vectors by
> > replacing the kmem_cache with a dma_cache and kalloc() with
> > cio_dma_zalloc().
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
> > Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> > ---
> >  arch/s390/include/asm/airq.h |  2 ++
> >  drivers/s390/cio/airq.c      | 32 ++++++++++++++++++++------------
> >  drivers/s390/cio/cio.h       |  2 ++
> >  drivers/s390/cio/css.c       |  1 +
> >  4 files changed, 25 insertions(+), 12 deletions(-)
> 
> Apologies if that already has been answered (and I missed it in my mail
> pile...), but two things had come to my mind previously:
> 
> - CHSC... does anything need to be done there? Last time I asked:
>   "Anyway, css_bus_init() uses some chscs
>    early (before cio_dma_pool_init), so we could not use the pools
>    there, even if we wanted to. Do chsc commands either work, or else
>    fail benignly on a protected virt guest?"

Protected virt won't support all CHSC. The supported ones won't requre
use of shared memory. So we are fine.

> - PCI indicators... does this interact with any dma configuration on
>   the pci device? (I know pci is not supported yet, and I don't really
>   expect any problems.)
> 

It does but, I'm pretty confident we don't have a problem with PCI. IMHO
Sebastian is the guy who needs to be paranoid about this, and he r-b-ed
the respective patches.

Regards,
Halil

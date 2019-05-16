From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH 05/10] s390/cio: introduce DMA pools to cio
Date: Thu, 16 May 2019 15:59:22 +0200 (CEST)
Message-ID: <alpine.LFD.2.21.1905161517570.1767@schleppi>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
	<20190426183245.37939-6-pasic@linux.ibm.com>
	<alpine.LFD.2.21.1905081447280.1773@schleppi>
	<20190508232210.5a555caa.pasic@linux.ibm.com>
	<20190509121106.48aa04db.cohuck@redhat.com>
	<20190510001112.479b2fd7.pasic@linux.ibm.com>
	<20190510161013.7e697337.cohuck@redhat.com>
	<20190512202256.5517592d.pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190512202256.5517592d.pasic@linux.ibm.com>
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

On Sun, 12 May 2019, Halil Pasic wrote:
> I've also got code that deals with AIRQ_IV_CACHELINE by turning the
> kmem_cache into a dma_pool.
> 
> Cornelia, Sebastian which approach do you prefer:
> 1) get rid of cio_dma_pool and AIRQ_IV_CACHELINE, and waste a page per
> vector, or
> 2) go with the approach taken by the patch below?

We only have a couple of users for airq_iv:

virtio_ccw.c: 2K bits

pci with floating IRQs: <= 2K (for the per-function bit vectors)
                        1..4K (for the summary bit vector)

pci with CPU directed IRQs: 2K (for the per-CPU bit vectors)
                            1..nr_cpu (for the summary bit vector)


The options are:
* page allocations for everything
* dma_pool for AIRQ_IV_CACHELINE ,gen_pool for others
* dma_pool for everything

I think we should do option 3 and use a dma_pool with cachesize
alignment for everything (as a prerequisite we have to limit
config PCI_NR_FUNCTIONS to 2K - but that is not a real constraint).

Sebastian

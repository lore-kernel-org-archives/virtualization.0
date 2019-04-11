From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [RFC PATCH 04/12] s390/cio: introduce cio DMA pool
Date: Thu, 11 Apr 2019 20:25:01 +0200 (CEST)
Message-ID: <alpine.LFD.2.21.1904111955520.2283@schleppi>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
	<20190404231622.52531-5-pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190404231622.52531-5-pasic@linux.ibm.com>
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
Cc: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, virtualization@lists.linux-foundation.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 5 Apr 2019, Halil Pasic wrote:
> To support protected virtualization cio will need to make sure the
> memory used for communication with the hypervisor is DMA memory.
> 
> Let us introduce a DMA pool to cio that will help us in allocating
> deallocating those chunks of memory.
> 
> We use a gen_pool backed with DMA pages to avoid each allocation
> effectively wasting a page, as we typically allocate much less
> than PAGE_SIZE.

I don't think we should use this global DMA pool. I guess it's OK for
stuff like airq (where we don't have a struct device at hand) but for
CCW we should use the device we have. Yes, this way we waste some memory
but all dma memory a device uses should fit in a page - so the wastage
is not too much.

Sebastian

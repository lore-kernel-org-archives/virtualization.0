From: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Tue, 5 Feb 2019 08:24:07 +0100
Message-ID: <20190205072407.GA4311__766.240868118473$1549381333$gmane$org@lst.de>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<87womn8inf.fsf@morokweng.localdomain>
	<20190129134750-mutt-send-email-mst@kernel.org>
	<6c68f7f7-1b28-6eba-9b8b-2c32efac9701@redhat.com>
	<20190129213137-mutt-send-email-mst@kernel.org>
	<20190130074427.GA29516@lst.de>
	<875ztzxvw2.fsf@morokweng.localdomain>
	<20190204152416-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190204152416-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paul Mackerras <paulus@ozlabs.org>, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Feb 04, 2019 at 04:38:21PM -0500, Michael S. Tsirkin wrote:
> It was designed to make, when set, as many guests as we can work
> correctly, and it seems to be successful in doing exactly that.
> 
> Unfortunately there could be legacy guests that do work correctly but
> become slow. Whether trying to somehow work around that
> can paint us into a corner where things again don't
> work for some people is a question worth discussing.

The other problem is that some qemu machines just throw passthrough
devices and virtio devices on the same virtual PCI(e) bus, and have a
common IOMMU setup for the whole bus / root port / domain.  I think
this is completely bogus, but unfortunately it is out in the field.

Given that power is one of these examples I suspect that is what
Thiago referes to.  But in this case the answer can't be that we
pile on hack ontop of another, but instead introduce a new qemu
machine that separates these clearly, and make that mandatory for
the secure guest support.

From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Tue, 29 Jan 2019 14:02:36 -0500
Message-ID: <20190129134750-mutt-send-email-mst__17037.7311458409$1548825682$gmane$org@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<87womn8inf.fsf@morokweng.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87womn8inf.fsf@morokweng.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paul Mackerras <paulus@ozlabs.org>, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>, David Gibson <david@gibson.dropbear.id.au>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 29, 2019 at 03:42:44PM -0200, Thiago Jung Bauermann wrote:
> 
> Fixing address of powerpc mailing list.
> 
> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
> 
> > Hello,
> >
> > With Christoph's rework of the DMA API that recently landed, the patch
> > below is the only change needed in virtio to make it work in a POWER
> > secure guest under the ultravisor.
> >
> > The other change we need (making sure the device's dma_map_ops is NULL
> > so that the dma-direct/swiotlb code is used) can be made in
> > powerpc-specific code.
> >
> > Of course, I also have patches (soon to be posted as RFC) which hook up
> > <linux/mem_encrypt.h> to the powerpc secure guest support code.
> >
> > What do you think?
> >
> > From d0629a36a75c678b4a72b853f8f7f8c17eedd6b3 Mon Sep 17 00:00:00 2001
> > From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > Date: Thu, 24 Jan 2019 22:08:02 -0200
> > Subject: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
> >
> > The host can't access the guest memory when it's encrypted, so using
> > regular memory pages for the ring isn't an option. Go through the DMA API.
> >
> > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Well I think this will come back to bite us (witness xen which is now
reworking precisely this path - but at least they aren't to blame, xen
came before ACCESS_PLATFORM).

I also still think the right thing would have been to set
ACCESS_PLATFORM for all systems where device can't access all memory.

But I also think I don't have the energy to argue about power secure
guest anymore.  So be it for power secure guest since the involved
engineers disagree with me.  Hey I've been wrong in the past ;).

But the name "sev_active" makes me scared because at least AMD guys who
were doing the sensible thing and setting ACCESS_PLATFORM (unless I'm
wrong? I reemember distinctly that's so) will likely be affected too.
We don't want that.

So let's find a way to make sure it's just power secure guest for now
pls.

I also think we should add a dma_api near features under virtio_device
such that these hacks can move off data path.

By the way could you please respond about virtio-iommu and
why there's no support for ACCESS_PLATFORM on power?

I have Cc'd you on these discussions.


Thanks!


> > ---
> >  drivers/virtio/virtio_ring.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index cd7e755484e3..321a27075380 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -259,8 +259,11 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> >  	 * not work without an even larger kludge.  Instead, enable
> >  	 * the DMA API if we're a Xen guest, which at least allows
> >  	 * all of the sensible Xen configurations to work correctly.
> > +	 *
> > +	 * Also, if guest memory is encrypted the host can't access
> > +	 * it directly. In this case, we'll need to use the DMA API.
> >  	 */
> > -	if (xen_domain())
> > +	if (xen_domain() || sev_active())
> >  		return true;
> >
> >  	return false;
> 
> 
> -- 
> Thiago Jung Bauermann
> IBM Linux Technology Center

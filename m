From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv4 2/2] virtio: refactor find_vqs
Date: Thu, 27 Aug 2009 20:32:24 +0930
Message-ID: <200908272032.24724.rusty__5925.71627717025$1251371016$gmane$org@rustcorp.com.au>
References: <cover.1248623150.git.mst@redhat.com>
	<200908271900.34757.rusty@rustcorp.com.au>
	<20090827094926.GB8391@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090827094926.GB8391@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, avi@redhat.com, Anthony Liguori <anthony@codemonkey.ws>, amit.shah@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 27 Aug 2009 07:19:26 pm Michael S. Tsirkin wrote:
> On Thu, Aug 27, 2009 at 07:00:34PM +0930, Rusty Russell wrote:
> > On Tue, 25 Aug 2009 09:34:34 pm Michael S. Tsirkin wrote:
> > > > That's because we didn't do the request_irq's for the per_vector case, because
> > > > we don't have the names.  This is what prevented me from doing a nice
> > > > encapsulation.
> > > 
> > > Yes. But let's split free_vectors out into free_msix_vectors and
> > > free_intx as well?
> > 
> > Perhaps.  Patch welcome :)
> 
> Could you put the end result somewhere so I can work on top of it?

Sure, it'll hit linux-next tomorrow, otherwise you can steal from
http://ozlabs.org/~rusty/kernel/rr-latest (virtio:pci-minor-cleanups.patch
and virtio:pci-minor-cleanups-fix.patch).

> > But vector for something which isn't always the vector
> > is misleading, IMHO.
> 
> I think you mean it's isn't always used? It's always a vector ...

The non-MSI case, it's set to VIRTIO_MSI_NO_VECTOR, and we use a normal
interrupt vector.

> BTW, let's get rid of msix_enabled completely?
> We can always use msix_vectors ...

That would be nice.  But yes, requiring more audit.

Ideally, if msix_vectors == 0, implies intx_enabled.

Thanks,
Rusty.

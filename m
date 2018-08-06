From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Tue, 07 Aug 2018 09:18:44 +1000
Message-ID: <8e985b8117407b256e2dd8f1c0a5c2e560ef03d7.camel@kernel.crashing.org>
References: <20180802225738-mutt-send-email-mst@kernel.org>
	<de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
	<20180803070507.GA1344@infradead.org>
	<eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
	<20180803220443-mutt-send-email-mst@kernel.org>
	<051fd78e15595b414839fa8f9d445b9f4d7576c6.camel@kernel.crashing.org>
	<20180805031046-mutt-send-email-mst@kernel.org>
	<fd8fee94cf42e436878f179c7895de3a4dab3355.camel@kernel.crashing.org>
	<20180806164106-mutt-send-email-mst@kernel.org>
	<ef6d5d7c7b812bd797a1c3fd6bc7a26d0074020f.camel@kernel.crashing.org>
	<20180806233024-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180806233024-mutt-send-email-mst@kernel.org>
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
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, mpe@ellerman.id.au, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linuxram@us.ibm.com, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, jean-philippe.brucker@arm.com, paulus@samba.org, marc.zyngier@arm.com, joe@perches.com, robin.murphy@arm.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2018-08-06 at 23:35 +0300, Michael S. Tsirkin wrote:
> On Tue, Aug 07, 2018 at 05:56:59AM +1000, Benjamin Herrenschmidt wrote:
> > On Mon, 2018-08-06 at 16:46 +0300, Michael S. Tsirkin wrote:
> > > 
> > > > Right, we'll need some quirk to disable balloons  in the guest I
> > > > suppose.
> > > > 
> > > > Passing something from libvirt is cumbersome because the end user may
> > > > not even need to know about secure VMs. There are use cases where the
> > > > security is a contract down to some special application running inside
> > > > the secure VM, the sysadmin knows nothing about.
> > > > 
> > > > Also there's repercussions all the way to admin tools, web UIs etc...
> > > > so it's fairly wide ranging.
> > > > 
> > > > So as long as we only need to quirk a couple of devices, it's much
> > > > better contained that way.
> > > 
> > > So just the balloon thing already means that yes management and all the
> > > way to the user tools must know this is going on. Otherwise
> > > user will try to inflate the balloon and wonder why this does not work.
> > 
> > There is *dozens* of management systems out there, not even all open
> > source, we won't ever be able to see the end of the tunnel if we need
> > to teach every single of them, including end users, about platform
> > specific new VM flags like that.
> > 
> > .../...
> 
> In the end I suspect you will find you have to.

Maybe... we'll tackle this if/when we have to.

For balloon I suspect it's not such a big deal because once secure, all
the guest memory goes into the secure memory which isn't visible or
accounted by the hypervisor, so there's nothing to steal but the guest
is also using no HV memory (other than the few "non-secure" pages used
for swiotlb and a couple of other kernel things).

Future versions of our secure architecture might allow to turn
arbitrary pages of memory secure/non-secure rather than relying on a
separate physical pool, in which case, the balloon will be able to work
normally.

Cheers,
Ben.

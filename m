From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Wed, 8 Aug 2018 22:40:13 -0700
Message-ID: <20180809054013.GA20507@infradead.org>
References: <20180807062117.GD32709@infradead.org>
	<aa59c7f8556bd4b332394a1dcf2d4a8faf3dc4a2.camel@kernel.crashing.org>
	<20180807135505.GA29034@infradead.org>
	<2103ecfe52d23cec03f185d08a87bfad9c9d82b5.camel@kernel.crashing.org>
	<20180808063158.GA2474@infradead.org>
	<4b596883892b5cb5560bef26fcd249e7107173ac.camel@kernel.crashing.org>
	<20180808123036.GA2525@infradead.org>
	<b8b9150a747453c070ad3b0e4c92d2b1b052ad06.camel@kernel.crashing.org>
	<20180808232210-mutt-send-email-mst@kernel.org>
	<98eb367ce322ad84baa31e3c7beffc4a42be8458.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <98eb367ce322ad84baa31e3c7beffc4a42be8458.camel@kernel.crashing.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>, mpe@ellerman.id.au, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linuxram@us.ibm.com, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, jean-philippe.brucker@arm.com, paulus@samba.org, marc.zyngier@arm.com, joe@perches.com, robin.murphy@arm.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 09, 2018 at 08:13:32AM +1000, Benjamin Herrenschmidt wrote:
> > > -	if (xen_domain())
> > > +	if (xen_domain() || pseries_secure_vm())
> > > 		return true;
> > 
> > I don't think it's pseries specific actually. E.g. I suspect AMD SEV
> > might benefit from the same kind of hack.
> 
> As long as they can provide the same guarantee that the DMA ops are
> completely equivalent between virtio and other PCI devices, at least on
> the same bus, ie, we don't have to go hack special DMA ops.
> 
> I think the latter is really what Christoph wants to avoid for good
> reasons.

Yes.  I also generally want to avoid too much arch specific magic.

FYI, I'm off to a week-long vacation today, don't expect quick replies.

From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Mon, 6 Aug 2018 23:21:17 -0700
Message-ID: <20180807062117.GD32709__20590.1352259845$1533622764$gmane$org@infradead.org>
References: <20180803070507.GA1344@infradead.org>
	<eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
	<20180803160246.GA13794@infradead.org>
	<22310f58605169fe9de83abf78b59f593ff7fbb7.camel@kernel.crashing.org>
	<20180804082120.GB4421@infradead.org>
	<a3ec0a454928e880dabc3782ea906e318634abf9.camel@kernel.crashing.org>
	<20180805072930.GB23288@infradead.org>
	<b7e8294e3e70d24072883a7e8e5375719d5af870.camel@kernel.crashing.org>
	<20180806094243.GA16032@infradead.org>
	<6c707d6d33ac25a42265c2e9b521c2416d72c739.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <6c707d6d33ac25a42265c2e9b521c2416d72c739.camel@kernel.crashing.org>
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

On Tue, Aug 07, 2018 at 05:52:12AM +1000, Benjamin Herrenschmidt wrote:
> > It is your job to write a coherent interface specification that does
> > not depend on the used components.  The hypervisor might be PAPR,
> > Linux + qemu, VMware, Hyperv or something so secret that you'd have
> > to shoot me if you had to tell me.  The guest might be Linux, FreeBSD,
> > AIX, OS400 or a Hipster project of the day in Rust.  As long as we
> > properly specify the interface it simplify does not matter.
> 
> That's the point Christoph. The interface is today's interface. It does
> NOT change. That information is not part of the interface.
> 
> It's the VM itself that is stashing away its memory in a secret place,
> and thus needs to do bounce buffering. There is no change to the virtio
> interface per-se.

Any guest that doesn't know about your magic limited adressing is simply
not going to work, so we need to communicate that fact.

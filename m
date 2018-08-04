From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Sat, 4 Aug 2018 01:21:20 -0700
Message-ID: <20180804082120.GB4421@infradead.org>
References: <20180802182959-mutt-send-email-mst@kernel.org>
	<82ccef6ec3d95ee43f3990a4a2d0aea87eb45e89.camel@kernel.crashing.org>
	<20180802200646-mutt-send-email-mst@kernel.org>
	<e9beb6bba5a7d05741e27e85b24a3b23ba7c2762.camel@kernel.crashing.org>
	<20180802225738-mutt-send-email-mst@kernel.org>
	<de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
	<20180803070507.GA1344@infradead.org>
	<eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
	<20180803160246.GA13794@infradead.org>
	<22310f58605169fe9de83abf78b59f593ff7fbb7.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <22310f58605169fe9de83abf78b59f593ff7fbb7.camel@kernel.crashing.org>
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
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>, mpe@ellerman.id.au, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linuxram@us.ibm.com, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, paulus@samba.org, marc.zyngier@arm.com, joe@perches.com, robin.murphy@arm.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Aug 03, 2018 at 01:58:46PM -0500, Benjamin Herrenschmidt wrote:
> You are saying something along the lines of "I don't like an
> instruction in your ISA, let's not support your entire CPU architecture
> in Linux".

No.  I'm saying if you can't describe your architecture in the virtio
spec document it is bogus.

> Our setup is not fucked. It makes a LOT of sense and it's a very
> sensible design. It's hitting a problem due to a corner case oddity in
> virtio bypassing the MMU, we've worked around such corner cases many
> times in the past without any problem, I fail to see what the problem
> is here.

No matter if you like it or not (I don't!) virtio is defined to bypass
dma translations, it is very clearly stated in the spec.  It has some
ill-defined bits to bypass it, so if you want the dma mapping API
to be used you'll have to set that bit (in its original form, a refined
form, or an entirely newly defined sane form) and make sure your
hypersivors always sets it.  It's not rocket science, just a little bit
for work to make sure your setup is actually going to work reliably
and portably.

> We aren't going to cancel years of HW and SW development for our

Maybe you should have actually read the specs you are claiming to
implemented before spending all that effort.

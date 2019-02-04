From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Mon, 4 Feb 2019 16:38:21 -0500
Message-ID: <20190204152416-mutt-send-email-mst__10230.6713046104$1549340969$gmane$org@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<87womn8inf.fsf@morokweng.localdomain>
	<20190129134750-mutt-send-email-mst@kernel.org>
	<6c68f7f7-1b28-6eba-9b8b-2c32efac9701@redhat.com>
	<20190129213137-mutt-send-email-mst@kernel.org>
	<20190130074427.GA29516@lst.de>
	<875ztzxvw2.fsf@morokweng.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <875ztzxvw2.fsf@morokweng.localdomain>
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

On Mon, Feb 04, 2019 at 04:15:41PM -0200, Thiago Jung Bauermann wrote:
> 
> Christoph Hellwig <hch@lst.de> writes:
> 
> > On Tue, Jan 29, 2019 at 09:36:08PM -0500, Michael S. Tsirkin wrote:
> >> This has been discussed ad nauseum. virtio is all about compatibility.
> >> Losing a couple of lines of code isn't worth breaking working setups.
> >> People that want "just use DMA API no tricks" now have the option.
> >> Setting a flag in a feature bit map is literally a single line
> >> of code in the hypervisor. So stop pushing for breaking working
> >> legacy setups and just fix it in the right place.
> >
> > I agree with the legacy aspect.  What I am missing is an extremely
> > strong wording that says you SHOULD always set this flag for new
> > hosts, including an explanation why.
> 
> My understanding of ACCESS_PLATFORM is that it means "this device will
> behave in all aspects like a regular device attached to this bus".


Not really. Look it up in the spec:

VIRTIO_F_ACCESS_PLATFORM(33) This feature indicates that the device can be used on a platform
	where device access to data in memory is limited and/or translated. E.g. this is the case if the device
	can be located behind an IOMMU that translates bus addresses from the device into physical addresses
	in memory, if the device can be limited to only access certain memory addresses or if special commands
	such as a cache flush can be needed to synchronise data in memory with the device. Whether accesses
	are actually limited or translated is described by platform-specific means. If this feature bit is set to 0,
	then the device has same access to memory addresses supplied to it as the driver has. In particular, the
	device will always use physical addresses matching addresses used by the driver (typically meaning
	physical addresses used by the CPU) and not translated further, and can access any address supplied
	to it by the driver. When clear, this overrides any platform-specific description of whether device access
	is limited or translated in any way, e.g. whether an IOMMU may be present.



> Is
> that it? Therefore it should be set because it's the sane thing to do?

It's the sane thing to do unless you want the very specific thing that
having it clear means, which is just have it be another CPU.

It was designed to make, when set, as many guests as we can work
correctly, and it seems to be successful in doing exactly that.

Unfortunately there could be legacy guests that do work correctly but
become slow. Whether trying to somehow work around that
can paint us into a corner where things again don't
work for some people is a question worth discussing.


> --
> Thiago Jung Bauermann
> IBM Linux Technology Center

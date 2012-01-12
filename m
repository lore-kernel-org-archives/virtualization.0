From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Thu, 12 Jan 2012 08:37:11 +0200
Message-ID: <20120112063710.GE10319@redhat.com>
References: <20111220113718.GF3913@redhat.com> <878vm6daqy.fsf@rustcorp.com.au>
	<20120110170334.GA18404@redhat.com>
	<8762gj6q5r.fsf@rustcorp.com.au>
	<20120111102129.GC20988@redhat.com>
	<1326316422.23910.154.camel@pasglop>
	<20120111221349.GD27292@redhat.com>
	<1326322599.23910.167.camel@pasglop>
	<20120112052953.GB10319@redhat.com>
	<1326348822.23910.202.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1326348822.23910.202.camel@pasglop>
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Pawel Moll <pawel.moll@arm.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 12, 2012 at 05:13:42PM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2012-01-12 at 07:29 +0200, Michael S. Tsirkin wrote:
> > On Thu, Jan 12, 2012 at 09:56:39AM +1100, Benjamin Herrenschmidt wrote:
> > > I'd suggest doing a simple user space app that creates such a ring,
> > > forks, and produce / consume. We can then run that through perf and
> > > analyze the cache behaviour, maximum throughput, etc....
> > > 
> > > Cheers,
> > > Ben.
> > 
> > Sure. You can also use my tools/virtio hack: this rebuilds virtio
> > ring code in userspace, has the advantage of reusing
> > actual kernel code, so it's up to date, has same barriers, etc.
> 
> Yes, Rusty mentioned it today :-)
> 
> We'll play around in the next couple of weeks. With LCA, I'm not sure
> how much I'll get done next week but heh...
> 
> I'm curious to see if we can still have a one-size-fit-all between
> unordered blk requests with large data/descriptor access ratio and
> ordered network buffers with a much smaller one.
> 
> Cheers,
> Ben.
> 

network buffers aren't ordered when the backend is zero copy.
Another idea is to add different sized bufs in the RX ring,
and have the device use the size that fits best.
This can improve small packet memory utilization without
need for data copies, but it also means that
descriptors are completed out of order in -net.

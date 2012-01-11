From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Thu, 12 Jan 2012 09:56:39 +1100
Message-ID: <1326322599.23910.167.camel@pasglop>
References: <20111218101831.GB30374@redhat.com>
	<87bor5nlht.fsf@rustcorp.com.au> <20111219091324.GA19535@redhat.com>
	<871us0om2t.fsf@rustcorp.com.au> <20111220113718.GF3913@redhat.com>
	<878vm6daqy.fsf@rustcorp.com.au> <20120110170334.GA18404@redhat.com>
	<8762gj6q5r.fsf@rustcorp.com.au> <20120111102129.GC20988@redhat.com>
	<1326316422.23910.154.camel@pasglop>
	<20120111221349.GD27292@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120111221349.GD27292@redhat.com>
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Pawel Moll <pawel.moll@arm.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2012-01-12 at 00:13 +0200, Michael S. Tsirkin wrote:

> > Well, I would argue that the network driver world has proven countless
> > times that those are good ideas :-)
> 
> Below you seem to suggest that separate rings like
> virtio has now is better than a single ring like Rusty
> suggested.

I was merely pointing at examples. My understanding (but I may have
misparsed him) is that Rusty wants to collate the descriptors and the
"available" ring. I personally don't think the completions (the used
ring) should be merged, it should remain separate. If Rusty was hinting
at doing that then I disagree with him :-)

> Are you familiar with current virtio ring structure?  How is this
> different?

Vaguely yes :-) It does have this uni-directional model, I didn't
express myself very well or I got confused by the statements about a
single ring. Yes, I think we should keep the ring at least split into
two directions as it is today.

But we can certainly merge available ring and descriptors ring.

Another option is having the ring entry size be a configurable power of
two. This is trivial and comes at pretty much no cost. That would allow
virtio-net for example to do efficient things like putting the headers
as immediate data in the ring and the data as indirect.

This means a large part of the packet processing can happen without
touching additional cache lines.

Anyway, at this stage, I plan to sit down with Rusty next week and hash
out some kind of proposal, which we can experiment with & benchmark.

I'd suggest doing a simple user space app that creates such a ring,
forks, and produce / consume. We can then run that through perf and
analyze the cache behaviour, maximum throughput, etc....

Cheers,
Ben.

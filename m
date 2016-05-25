From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC kernel] balloon: speed up inflating/deflating process
Date: Wed, 25 May 2016 12:40:10 +0300
Message-ID: <20160525123546-mutt-send-email-mst@redhat.com>
References: <1463738386-30868-1-git-send-email-liang.z.li@intel.com>
	<20160520120038.GA28757@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E041A4BFD@shsmsx102.ccr.corp.intel.com>
	<20160524130041-mutt-send-email-mst@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E041A6C67@shsmsx102.ccr.corp.intel.com>
	<20160525115419-mutt-send-email-mst@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E041A6CF9@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <F2CBF3009FA73547804AE4C663CAB28E041A6CF9@shsmsx102.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Li, Liang Z" <liang.z.li@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 25, 2016 at 09:28:58AM +0000, Li, Liang Z wrote:
> > On Wed, May 25, 2016 at 08:48:17AM +0000, Li, Liang Z wrote:
> > > > > > Suggestion to address all above comments:
> > > > > > 	1. allocate a bunch of pages and link them up,
> > > > > > 	   calculating the min and the max pfn.
> > > > > > 	   if max-min exceeds the allocated bitmap size,
> > > > > > 	   tell host.
> > > > >
> > > > > I am not sure if it works well in some cases, e.g. The allocated
> > > > > pages are across a wide range and the max-min > limit is very
> > > > > frequently to be
> > > > true.
> > > > > Then, there will be many times of virtio transmission and it's bad
> > > > > for performance improvement. Right?
> > > >
> > > > It's a tradeoff for sure. Measure it, see what the overhead is.
> > > >
> > >
> > > Hi MST,
> > >
> > > I have measured the performance when using a 32K page bitmap,
> > 
> > Just to make sure. Do you mean a 32Kbyte bitmap?
> > Covering 1Gbyte of memory?
> Yes.
> 
> > 
> > > and inflate the balloon to 3GB
> > > of an idle guest with 4GB RAM.
> > 
> > Should take 3 requests then, right?
> > 
> 
> No,  we can't assign the PFN when allocating page in balloon driver,
> So the PFNs of pages allocated may be across a large range,  we will
> tell the host once the pfn_max -pfn_min >= 0x40000(1GB range),
> so the requests count is most likely to be more than 3. 
> 
> > > Now:
> > > total inflating time: 338ms
> > > the count of virtio data transmission:  373
> > 
> > Why was this so high? I would expect 3 transmissions.
> 
> I follow your suggestion:
> ------------------------------------------------------------------------------------
> Suggestion to address all above comments:
> 	1. allocate a bunch of pages and link them up,
> 	   calculating the min and the max pfn.
> 	   if max-min exceeds the allocated bitmap size,
> 	   tell host.
> 	2. limit allocated bitmap size to something reasonable.
> 	   How about 32Kbytes? This is 256kilo bit in the map, which comes
> 	   out to 1Giga bytes of memory in the balloon.
> -------------------------------------------------------------------------------------
> Because the PFNs of the allocated pages are not linear increased, so 3 transmissions
> are  impossible.
> 
> 
> Liang

Interesting. How about instead of tell host, we do multiple scans, each
time ignoring pages out of range?

	for (pfn = min pfn; pfn < max pfn; pfn += 1G) {
		foreach page
			if page pfn < pfn || page pfn >= pfn + 1G
				continue
			set bit
		tell host
	}

> 
> > 
> > > the call count of madvise: 865
> > >
> > > before:
> > > total inflating time: 175ms
> > > the count of virtio data transmission: 1 the call count of madvise: 42
> > >
> > > Maybe the result will be worse if the guest is not idle, or the guest has
> > more RAM.
> > > Do you want more data?
> > >
> > > Is it worth to do that?
> > >
> > > Liang
> > 
> > Either my math is wrong or there's an implementation bug.
> > 
> > > > >
> > > > > > 	2. limit allocated bitmap size to something reasonable.
> > > > > > 	   How about 32Kbytes? This is 256kilo bit in the map, which comes
> > > > > > 	   out to 1Giga bytes of memory in the balloon.
> > > > >
> > > > > So, even the VM has 1TB of RAM, the page bitmap will take 32MB of
> > > > memory.
> > > > > Maybe it's better to use a big page bitmap the save the pages
> > > > > allocated by balloon, and split the big page bitmap to 32K bytes
> > > > > unit, then
> > > > transfer one unit at a time.
> > > >
> > > > How is this different from what I said?
> > > >
> > > > >
> > > > > Should we use a page bitmap to replace 'vb->pages' ?
> > > > >
> > > > > How about rolling back to use PFNs if the count of requested pages
> > > > > is a
> > > > small number?
> > > > >
> > > > > Liang
> > > >
> > > > That's why we have start pfn. you can use that to pass even a single
> > > > page without a lot of overhead.
> > > >
> > > > > > > --
> > > > > > > 1.9.1
> > > > > > --
> > > > > > To unsubscribe from this list: send the line "unsubscribe kvm"
> > > > > > in the body of a message to majordomo@vger.kernel.org More
> > > > > > majordomo info at http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe kvm" in the body of
> > a message to majordomo@vger.kernel.org More majordomo info at
> > http://vger.kernel.org/majordomo-info.html

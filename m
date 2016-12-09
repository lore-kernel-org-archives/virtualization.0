From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [PATCH kernel v5 0/5] Extend virtio-balloon for fast
	(de)inflating & fast live migration
Date: Fri, 9 Dec 2016 03:09:47 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3A14D246__6623.33557052097$1481253003$gmane$org@SHSMSX104.ccr.corp.intel.com>
References: <1480495397-23225-1-git-send-email-liang.z.li@intel.com>
	<f67ca79c-ad34-59dd-835f-e7bc9dcaef58@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E3A130C01@shsmsx102.ccr.corp.intel.com>
	<f7b47cc4-ee94-bacb-5a17-d049b402263e@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <f7b47cc4-ee94-bacb-5a17-d049b402263e@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Hansen, Dave" <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mhocko@suse.com" <mhocko@suse.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

> Subject: Re: [PATCH kernel v5 0/5] Extend virtio-balloon for fast (de)inflating
> & fast live migration
> 
> On 12/07/2016 05:35 AM, Li, Liang Z wrote:
> >> Am 30.11.2016 um 09:43 schrieb Liang Li:
> >> IOW in real examples, do we have really large consecutive areas or
> >> are all pages just completely distributed over our memory?
> >
> > The buddy system of Linux kernel memory management shows there
> should
> > be quite a lot of consecutive pages as long as there are a portion of
> > free memory in the guest.
> ...
> > If all pages just completely distributed over our memory, it means the
> > memory fragmentation is very serious, the kernel has the mechanism to
> > avoid this happened.
> 
> While it is correct that the kernel has anti-fragmentation mechanisms, I don't
> think it invalidates the question as to whether a bitmap would be too sparse
> to be effective.
> 
> > In the other hand, the inflating should not happen at this time
> > because the guest is almost 'out of memory'.
> 
> I don't think this is correct.  Most systems try to run with relatively little free
> memory all the time, using the bulk of it as page cache.  We have no reason
> to expect that ballooning will only occur when there is lots of actual free
> memory and that it will not occur when that same memory is in use as page
> cache.
> 

Yes.
> In these patches, you're effectively still sending pfns.  You're just sending
> one pfn per high-order page which is giving a really nice speedup.  IMNHO,
> you're avoiding doing a real bitmap because creating a bitmap means either
> have a really big bitmap, or you would have to do some sorting (or multiple
> passes) of the free lists before populating a smaller bitmap.
> 
> Like David, I would still like to see some data on whether the choice between
> bitmaps and pfn lists is ever clearly in favor of bitmaps.  You haven't
> convinced me, at least, that the data isn't even worth collecting.

I will try to get some data with the real workload and share it with your guys.

Thanks!
Liang

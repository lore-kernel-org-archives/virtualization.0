From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [Qemu-devel] [PATCH kernel v5 0/5] Extend virtio-balloon for
	fast (de)inflating & fast live migration
Date: Sat, 17 Dec 2016 12:39:01 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3C32C4D5__39596.6949327432$1481978351$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <b58fd9f6-d9dd-dd56-d476-dd342174dac5@intel.com>
	<20161207202824.GH28786@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E3A14E2AD@SHSMSX104.ccr.corp.intel.com>
	<060287c7-d1af-45d5-70ea-ad35d4bbeb84@intel.com>
	<F2CBF3009FA73547804AE4C663CAB28E3C31D0E6@SHSMSX104.ccr.corp.intel.com>
	<01886693-c73e-3696-860b-086417d695e1@intel.com>
	<F2CBF3009FA73547804AE4C663CAB28E3C32985A@shsmsx102.ccr.corp.intel.com>
	<f517bfbe-18b8-6962-5c57-545f6ef47ad0@intel.com>
	<F2CBF3009FA73547804AE4C663CAB28E3C32A8D6@shsmsx102.ccr.corp.intel.com>
	<84ac9822-880d-b998-52ca-6aa87e0f7a43@intel.com>
	<20161216160112.GC6168@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161216160112.GC6168@redhat.com>
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
To: Andrea Arcangeli <aarcange@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>
Cc: "mhocko@suse.com" <mhocko@suse.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> Subject: Re: [Qemu-devel] [PATCH kernel v5 0/5] Extend virtio-balloon for
> fast (de)inflating & fast live migration
> 
> On Thu, Dec 15, 2016 at 05:40:45PM -0800, Dave Hansen wrote:
> > On 12/15/2016 05:38 PM, Li, Liang Z wrote:
> > >
> > > Use 52 bits for 'pfn', 12 bits for 'length', when the 12 bits is not long
> enough for the 'length'
> > > Set the 'length' to a special value to indicate the "actual length in next 8
> bytes".
> > >
> > > That will be much more simple. Right?
> >
> > Sounds fine to me.
> >
> 
> Sounds fine to me too indeed.
> 
> I'm only wondering what is the major point for compressing gpfn+len in
> 8 bytes in the common case, you already use sg_init_table to send down two
> pages, we could send three as well and avoid all math and bit shifts and ors,
> or not?
> 

Yes, we can use more pages for that.

> I agree with the above because from a performance prospective I tend to
> think the above proposal will run at least theoretically faster because the
> other way is to waste double amount of CPU cache, and bit mangling in the
> encoding and the later decoding on qemu side should be faster than
> accessing an array of double size, but then I'm not sure if it's measurable
> optimization. So I'd be curious to know the exact motivation and if it is to
> reduce the CPU cache usage or if there's some other fundamental reason to
> compress it.
> The header already tells qemu how big is the array payload, couldn't we just
> add more pages if one isn't enough?
> 

The original intention to compress the PFN and length it's to reduce the memory required.
Even the code was changed a lot from the previous versions, I think this is still true.

Now we allocate a specified buffer size to save the 'PFN|length', when the buffer is not big
enough to save all the page info for a specified order. A double size buffer will be allocated.
This is what we want to avoid because the allocation may fail and allocation takes some time,
for fast live migration, time is a critical factor we have to consider, more time takes means
more unnecessary pages are sent, because live migration starts before the request for unused
 pages get response. 

Thanks

Liang

> Thanks,
> Andrea

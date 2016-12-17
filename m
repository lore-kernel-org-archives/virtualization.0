From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [Qemu-devel] [PATCH kernel v5 0/5] Extend virtio-balloon for
	fast (de)inflating & fast live migration
Date: Sat, 17 Dec 2016 11:56:40 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3C32C4A1@shsmsx102.ccr.corp.intel.com>
References: <d3ff453c-56fa-19de-317c-1c82456f2831@intel.com>
	<20161207183817.GE28786@redhat.com>
	<b58fd9f6-d9dd-dd56-d476-dd342174dac5@intel.com>
	<20161207202824.GH28786@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E3A14E2AD@SHSMSX104.ccr.corp.intel.com>
	<060287c7-d1af-45d5-70ea-ad35d4bbeb84@intel.com>
	<F2CBF3009FA73547804AE4C663CAB28E3C31D0E6@SHSMSX104.ccr.corp.intel.com>
	<01886693-c73e-3696-860b-086417d695e1@intel.com>
	<20161215173901-mutt-send-email-mst@kernel.org>
	<F2CBF3009FA73547804AE4C663CAB28E3C32A899@shsmsx102.ccr.corp.intel.com>
	<20161216154049.GB6168@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161216154049.GB6168@redhat.com>
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
To: Andrea Arcangeli <aarcange@redhat.com>
Cc: "mhocko@suse.com" <mhocko@suse.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "Hansen,
	Dave" <dave.hansen@intel.com>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> On Fri, Dec 16, 2016 at 01:12:21AM +0000, Li, Liang Z wrote:
> > There still exist the case if the MAX_ORDER is configured to a large
> > value, e.g. 36 for a system with huge amount of memory, then there is only
> 28 bits left for the pfn, which is not enough.
> 
> Not related to the balloon but how would it help to set MAX_ORDER to 36?
> 

My point here is  MAX_ORDER may be configured to a big value.

> What the MAX_ORDER affects is that you won't be able to ask the kernel
> page allocator for contiguous memory bigger than 1<<(MAX_ORDER-1), but
> that's a driver issue not relevant to the amount of RAM. Drivers won't
> suddenly start to ask the kernel allocator to allocate compound pages at
> orders >= 11 just because more RAM was added.
> 
> The higher the MAX_ORDER the slower the kernel runs simply so the smaller
> the MAX_ORDER the better.
> 
> > Should  we limit the MAX_ORDER? I don't think so.
> 
> We shouldn't strictly depend on MAX_ORDER value but it's mostly limited
> already even if configurable at build time.
> 

I didn't know that and will take a look, thanks for your information.


Liang
> We definitely need it to reach at least the hugepage size, then it's mostly
> driver issue, but drivers requiring large contiguous allocations should rely on
> CMA only or vmalloc if they only require it virtually contiguous, and not rely
> on larger MAX_ORDER that would slowdown all kernel allocations/freeing.

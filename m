From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [PATCH kernel v5 0/5] Extend virtio-balloon for fast
	(de)inflating & fast live migration
Date: Wed, 7 Dec 2016 13:35:26 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3A130C01__47858.4567354575$1481117752$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1480495397-23225-1-git-send-email-liang.z.li@intel.com>
	<f67ca79c-ad34-59dd-835f-e7bc9dcaef58@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <f67ca79c-ad34-59dd-835f-e7bc9dcaef58@redhat.com>
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
To: David Hildenbrand <david@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mhocko@suse.com" <mhocko@suse.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "Hansen,
	Dave" <dave.hansen@intel.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

> Am 30.11.2016 um 09:43 schrieb Liang Li:
> > This patch set contains two parts of changes to the virtio-balloon.
> >
> > One is the change for speeding up the inflating & deflating process,
> > the main idea of this optimization is to use bitmap to send the page
> > information to host instead of the PFNs, to reduce the overhead of
> > virtio data transmission, address translation and madvise(). This can
> > help to improve the performance by about 85%.
> 
> Do you have some statistics/some rough feeling how many consecutive bits are
> usually set in the bitmaps? Is it really just purely random or is there some
> granularity that is usually consecutive?
> 

I did something similar. Filled the balloon with 15GB for a 16GB idle guest, by
using bitmap, the madvise count was reduced to 605. when using the PFNs, the madvise count
was 3932160. It means there are quite a lot consecutive bits in the bitmap.
I didn't test for a guest with heavy memory workload. 

> IOW in real examples, do we have really large consecutive areas or are all
> pages just completely distributed over our memory?
> 

The buddy system of Linux kernel memory management shows there should be quite a lot of
 consecutive pages as long as there are a portion of free memory in the guest.
If all pages just completely distributed over our memory, it means the memory 
fragmentation is very serious, the kernel has the mechanism to avoid this happened.
In the other hand, the inflating should not happen at this time because the guest is almost
'out of memory'.

Liang

> Thanks!
> 
> --
> 
> David

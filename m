From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH kernel v5 0/5] Extend virtio-balloon for fast
	(de)inflating & fast live migration
Date: Wed, 7 Dec 2016 16:42:05 +0100
Message-ID: <0b18c636-ee67-cbb4-1ba3-81a06150db76__49570.2429944233$1481125336$gmane$org@redhat.com>
References: <1480495397-23225-1-git-send-email-liang.z.li@intel.com>
	<f67ca79c-ad34-59dd-835f-e7bc9dcaef58@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E3A130C01@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <F2CBF3009FA73547804AE4C663CAB28E3A130C01@shsmsx102.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Li, Liang Z" <liang.z.li@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mhocko@suse.com" <mhocko@suse.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "Hansen,
	Dave" <dave.hansen@intel.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Am 07.12.2016 um 14:35 schrieb Li, Liang Z:
>> Am 30.11.2016 um 09:43 schrieb Liang Li:
>>> This patch set contains two parts of changes to the virtio-balloon.
>>>
>>> One is the change for speeding up the inflating & deflating process,
>>> the main idea of this optimization is to use bitmap to send the page
>>> information to host instead of the PFNs, to reduce the overhead of
>>> virtio data transmission, address translation and madvise(). This can
>>> help to improve the performance by about 85%.
>>
>> Do you have some statistics/some rough feeling how many consecutive bits are
>> usually set in the bitmaps? Is it really just purely random or is there some
>> granularity that is usually consecutive?
>>
>
> I did something similar. Filled the balloon with 15GB for a 16GB idle guest, by
> using bitmap, the madvise count was reduced to 605. when using the PFNs, the madvise count
> was 3932160. It means there are quite a lot consecutive bits in the bitmap.
> I didn't test for a guest with heavy memory workload.

Would it then even make sense to go one step further and report {pfn, 
length} combinations?

So simply send over an array of {pfn, length}?

This idea came up when talking to Andrea Arcangeli (put him on cc).

And it makes sense if you think about:

a) hugetlb backing: The host may only be able to free huge pages (we 
might want to communicate that to the guest later, that's another 
story). Still we would have to send bitmaps full of 4k frames (512 bits 
for 2mb frames). Of course, we could add a way to communicate that we 
are using a different bitmap-granularity.

b) if we really inflate huge memory regions (and it sounds like that 
according to your measurements), we can minimize the communication to 
the hypervisor and therefore the madvice calls.

c) we don't want to optimize for inflating guests with almost full 
memory (and therefore little consecutive memory areas) - my opinion :)


Thanks for the explanation!

-- 

David

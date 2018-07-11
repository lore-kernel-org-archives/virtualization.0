From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v35 1/5] mm: support to get hints of free page blocks
Date: Wed, 11 Jul 2018 09:28:48 +0800
Message-ID: <5B455D50.90902__39888.6750954718$1531272160$gmane$org@intel.com>
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com>
	<1531215067-35472-2-git-send-email-wei.w.wang@intel.com>
	<CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, Rik van Riel <riel@redhat.com>, quan.xu0@gmail.com, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, nilal@redhat.com, liliang.opensource@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, linux-mm <linux-mm@kvack.org>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 07/11/2018 01:33 AM, Linus Torvalds wrote:
> NAK.
>
> On Tue, Jul 10, 2018 at 2:56 AM Wei Wang <wei.w.wang@intel.com> wrote:
>> +
>> +       buf_page = list_first_entry_or_null(pages, struct page, lru);
>> +       if (!buf_page)
>> +               return -EINVAL;
>> +       buf = (__le64 *)page_address(buf_page);
> Stop this garbage.
>
> Why the hell would you pass in some crazy "liost of pages" that uses
> that lru list?
>
> That's just insane shit.
>
> Just pass in a an array to fill in. No idiotic games like this with
> odd list entries (what's the locking?) and crazy casting to
>
> So if you want an array of page addresses, pass that in as such. If
> you want to do it in a page, do it with
>
>      u64 *array = page_address(page);
>      int nr = PAGE_SIZE / sizeof(u64);
>
> and now you pass that array in to the thing. None of this completely
> insane crazy crap interfaces.
>
> Plus, I still haven't heard an explanation for why you want so many
> pages in the first place, and why you want anything but MAX_ORDER-1.

Sorry for missing that explanation.
We only get addresses of the "MAX_ORDER-1" blocks into the array. The 
max size of the array that could be allocated by kmalloc is 
KMALLOC_MAX_SIZE (i.e. 4MB on x86). With that max array, we could load 
"4MB / sizeof(u64)" addresses of "MAX_ORDER-1" blocks, that is, 2TB free 
memory at most. We thought about removing that 2TB limitation by passing 
in multiple such max arrays (a list of them).

But 2TB has been enough for our use cases so far, and agree it would be 
better to have a simpler API in the first place. So I plan to go back to 
the previous version of just passing in one simple array 
(https://lkml.org/lkml/2018/6/15/21) if no objections.

Best,
Wei

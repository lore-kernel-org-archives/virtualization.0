From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v35 1/5] mm: support to get hints of free page blocks
Date: Tue, 10 Jul 2018 18:44:34 -0700
Message-ID: <CA+55aFzqj8wxXnHAdUTiOomipgFONVbqKMjL_tfk7e5ar1FziQ__18863.9373671778$1531273518$gmane$org@mail.gmail.com>
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com>
	<1531215067-35472-2-git-send-email-wei.w.wang@intel.com>
	<CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
	<5B455D50.90902@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5B455D50.90902@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: wei.w.wang@intel.com
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, Rik van Riel <riel@redhat.com>, quan.xu0@gmail.com, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, nilal@redhat.com, liliang.opensource@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, linux-mm <linux-mm@kvack.org>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 10, 2018 at 6:24 PM Wei Wang <wei.w.wang@intel.com> wrote:
>
> We only get addresses of the "MAX_ORDER-1" blocks into the array. The
> max size of the array that could be allocated by kmalloc is
> KMALLOC_MAX_SIZE (i.e. 4MB on x86). With that max array, we could load
> "4MB / sizeof(u64)" addresses of "MAX_ORDER-1" blocks, that is, 2TB free
> memory at most. We thought about removing that 2TB limitation by passing
> in multiple such max arrays (a list of them).

No.

Stop this already./

You're doing everthing wrong.

If the array has to describe *all* memory you will ever free, then you
have already lost.

Just do it in chunks.

I don't want the VM code to even fill in that big of an array anyway -
this all happens under the zone lock, and you're walking a list that
is bad for caching anyway.

So plan on an interface that allows _incremental_ freeing, because any
plan that starts with "I worry that maybe two TERABYTES of memory
isn't big enough" is so broken that it's laughable.

That was what I tried to encourage with actually removing the pages
form the page list. That would be an _incremental_ interface. You can
remove MAX_ORDER-1 pages one by one (or a hundred at a time), and mark
them free for ballooning that way. And if you still feel you have tons
of free memory, just continue removing more pages from the free list.

Notice? Incremental. Not "I want to have a crazy array that is enough
to hold 2TB at one time".

So here's the rule:

 - make it a simple array interface

 - make the array *small*. Not megabytes. Kilobytes. Because if you're
filling in megabytes worth of free pointers while holding the zone
lock, you're doing something wrong.

 - design the interface so that you do not *need* to have this crazy
"all or nothing" approach.

See what I'm trying to push for. Think "low latency". Think "small
arrays". Think "simple and straightforward interfaces".

At no point should you ever worry about "2TB". Never.

           Linus

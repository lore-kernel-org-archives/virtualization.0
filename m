From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v33 1/4] mm: add a function to get free page blocks
Date: Wed, 27 Jun 2018 22:07:02 +0300
Message-ID: <20180627220402-mutt-send-email-mst@kernel.org>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
	<1529037793-35521-2-git-send-email-wei.w.wang@intel.com>
	<CA+55aFzhuGKinEq5udPsk_uYHShkQxJYqcPO=tLCkT-oxpsgPg@mail.gmail.com>
	<20180626045118-mutt-send-email-mst@kernel.org>
	<CA+55aFwFpDPvfL=KPdabO-x1r0FnwpfPk5oN8+e01TKqAPNYbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFwFpDPvfL=KPdabO-x1r0FnwpfPk5oN8+e01TKqAPNYbw@mail.gmail.com>
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
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, Rik van Riel <riel@redhat.com>, quan.xu0@gmail.com, KVM list <kvm@vger.kernel.org>, nilal@redhat.com, liliang.opensource@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, linux-mm <linux-mm@kvack.org>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 27, 2018 at 09:05:39AM -0700, Linus Torvalds wrote:
> [ Sorry for slow reply, my travels have made a mess of my inbox ]
> 
> On Mon, Jun 25, 2018 at 6:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > Linus, do you think it would be ok to have get_from_free_page_list
> > actually pop entries from the free list and use them as the buffer
> > to store PAs?
> 
> Honestly, what I think the best option would be is to get rid of this
> interface *entirely*, and just have the balloon code do
> 
>     #define GFP_MINFLAGS (__GFP_NORETRY | __GFP_NOWARN |
> __GFP_THISNODE | __GFP_NOMEMALLOC)
> 
>     struct page *page =  alloc_pages(GFP_MINFLAGS, MAX_ORDER-1);
> 
>  which is not a new interface, and simply removes the max-order page
> from the list if at all possible.
> 
> The above has the advantage of "just working", and not having any races.
> 
> Now, because you don't want to necessarily *entirely* deplete the max
> order, I'd suggest that the *one* new interface you add is just a "how
> many max-order pages are there" interface. So then you can query
> (either before or after getting the max-order page) just how many of
> them there were and whether you want to give that page back.
> 
> Notice? No need for any page lists or physical addresses. No races. No
> complex new functions.
> 
> The physical address you can just get from the "struct page" you got.
> 
> And if you run out of memory because of getting a page, you get all
> the usual "hey, we ran out of memory" responses..
> 
> Wouldn't the above be sufficient?
> 
>             Linus

I think so, thanks!

Wei, to put it in balloon terms, I think there's one thing we missed: if
you do manage to allocate a page, and you don't have a use for it, then
hey, you can just give it to the host because you know it's free - you
are going to return it to the free list.

-- 
MST

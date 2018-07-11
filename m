From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v35 1/5] mm: support to get hints of free page blocks
Date: Wed, 11 Jul 2018 07:00:37 +0300
Message-ID: <20180711064709-mutt-send-email-mst__5115.38312207467$1531281525$gmane$org@kernel.org>
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com>
	<1531215067-35472-2-git-send-email-wei.w.wang@intel.com>
	<CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, Rik van Riel <riel@redhat.com>, quan.xu0@gmail.com, KVM list <kvm@vger.kernel.org>, nilal@redhat.com, liliang.opensource@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, linux-mm <linux-mm@kvack.org>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 10, 2018 at 10:33:08AM -0700, Linus Torvalds wrote:
> NAK.
> 
> On Tue, Jul 10, 2018 at 2:56 AM Wei Wang <wei.w.wang@intel.com> wrote:
> >
> > +
> > +       buf_page = list_first_entry_or_null(pages, struct page, lru);
> > +       if (!buf_page)
> > +               return -EINVAL;
> > +       buf = (__le64 *)page_address(buf_page);
> 
> Stop this garbage.
> 
> Why the hell would you pass in some crazy "liost of pages" that uses
> that lru list?
> 
> That's just insane shit.
> 
> Just pass in a an array to fill in.
> No idiotic games like this with
> odd list entries (what's the locking?) and crazy casting to
> 
> So if you want an array of page addresses, pass that in as such. If
> you want to do it in a page, do it with
> 
>     u64 *array = page_address(page);
>     int nr = PAGE_SIZE / sizeof(u64);
> 
> and now you pass that array in to the thing. None of this completely
> insane crazy crap interfaces.

Question was raised what to do if there are so many free
MAX_ORDER pages that their addresses don't fit in a single MAX_ORDER
page. Yes, only a huge guest would trigger that but it seems
theoretically possible.

I guess an array of arrays then?

An alternative suggestion was not to pass an array at all,
instead peel enough pages off the list to contain
all free entries. Maybe that's too hacky.


> 
> Plus, I still haven't heard an explanation for why you want so many
> pages in the first place, and why you want anything but MAX_ORDER-1.
> 
> So no. This kind of unnecessarily complex code with completely insane
> calling interfaces does not make it into the VM layer.
> 
> Maybe that crazy "let's pass a chain of pages that uses the lru list"
> makes sense to the virtio-balloon code. But you need to understand
> that it makes ZERO conceptual sense to anybody else. And the core VM
> code is about a million times more important than the balloon code in
> this case, so you had better make the interface make sense to *it*.
> 
>                Linus

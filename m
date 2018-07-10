From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v35 1/5] mm: support to get hints of free page blocks
Date: Tue, 10 Jul 2018 10:33:08 -0700
Message-ID: <CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com>
	<1531215067-35472-2-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1531215067-35472-2-git-send-email-wei.w.wang@intel.com>
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

NAK.

On Tue, Jul 10, 2018 at 2:56 AM Wei Wang <wei.w.wang@intel.com> wrote:
>
> +
> +       buf_page = list_first_entry_or_null(pages, struct page, lru);
> +       if (!buf_page)
> +               return -EINVAL;
> +       buf = (__le64 *)page_address(buf_page);

Stop this garbage.

Why the hell would you pass in some crazy "liost of pages" that uses
that lru list?

That's just insane shit.

Just pass in a an array to fill in. No idiotic games like this with
odd list entries (what's the locking?) and crazy casting to

So if you want an array of page addresses, pass that in as such. If
you want to do it in a page, do it with

    u64 *array = page_address(page);
    int nr = PAGE_SIZE / sizeof(u64);

and now you pass that array in to the thing. None of this completely
insane crazy crap interfaces.

Plus, I still haven't heard an explanation for why you want so many
pages in the first place, and why you want anything but MAX_ORDER-1.

So no. This kind of unnecessarily complex code with completely insane
calling interfaces does not make it into the VM layer.

Maybe that crazy "let's pass a chain of pages that uses the lru list"
makes sense to the virtio-balloon code. But you need to understand
that it makes ZERO conceptual sense to anybody else. And the core VM
code is about a million times more important than the balloon code in
this case, so you had better make the interface make sense to *it*.

               Linus

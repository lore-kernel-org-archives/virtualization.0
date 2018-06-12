From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PULL] vhost: cleanups and fixes
Date: Mon, 11 Jun 2018 18:59:40 -0700
Message-ID: <CA+55aFyNhEzzufw0XP9DcqZNS1CH+jDGdN4CVnazb3ssFxFbzQ@mail.gmail.com>
References: <20180611192353-mutt-send-email-mst@kernel.org>
	<CA+55aFzrPgnd7hRPrkeV+jX-MSwOZf7T4wKxz66Lk4oub3PZsw@mail.gmail.com>
	<CA+55aFz4uBHaWnBarVUEG90s2ucyVtoLmwYpYVwDV+XQESNRqw@mail.gmail.com>
	<20180612042600-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180612042600-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: KVM list <kvm@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 11, 2018 at 6:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Maybe it will help to have GFP_NONE which will make any allocation
> fail if attempted. Linus, would this address your comment?

It would definitely have helped me initially overlook that call chain.

But then when I started looking at the whole dma_map_page() thing, it
just raised my hackles again.

I would seriously suggest having a much simpler version for the "no
allocation, no dma mapping" case, so that it's *obvious* that that
never happens.

So instead of having virtio_balloon_send_free_pages() call a really
generic complex chain of functions that in _some_ cases can do memory
allocation, why isn't there a short-circuited "vitruque_add_datum()"
that is guaranteed to never do anything like that?

Honestly, I look at "add_one_sg()" and it really doesn't make me
happy. It looks hacky as hell. If I read the code right, you're really
trying to just queue up a simple tuple of <pfn,len>, except you encode
it as a page pointer in order to play games with the SG logic, and
then you hmap that to the ring, except in this case it's all a fake
ring that just adds the cpu-physical address instead.

And to figuer that out, it's like five layers of indirection through
different helper functions that *can* do more generic things but in
this case don't.

And you do all of this from a core VM callback function with some
_really_ core VM locks held.

That makes no sense to me.

How about this:

 - get rid of all that code

 - make the core VM callback save the "these are the free memory
regions" in a fixed and limited array. One that DOES JUST THAT. No
crazy "SG IO dma-mapping function crap". Just a plain array of a fixed
size, pre-allocated for that virtio instance.

 - make it obvious that what you do in that sequence is ten
instructions and no allocations ("Look ma, I wrote a value to an array
and incremented the array idex, and I'M DONE")

 - then in that workqueue entry that you start *anyway*, you empty the
array and do all the crazy virtio stuff.

In fact, while at it, just simplify the VM interface too. Instead of
traversing a random number of buddy lists, just trraverse *one* - the
top-level one. Are you seriously ever going to shrink or mark
read-only anythin *but* something big enough to be in the maximum
order?

MAX_ORDER is what, 11? So we're talking 8MB blocks. Do you *really*
want the balloon code to work on smaller things, particularly since
the whole interface is fundamentally racy and opportunistic to begin
with?

The whole sequence of events really looks "this is too much
complexity, and way too fragile" to me at so many levels.

                 Linus

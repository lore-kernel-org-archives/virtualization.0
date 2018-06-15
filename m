From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PULL] vhost: cleanups and fixes
Date: Fri, 15 Jun 2018 11:53:17 +0800
Message-ID: <5B23382D.7090909@intel.com>
References: <20180611192353-mutt-send-email-mst@kernel.org>
	<CA+55aFzrPgnd7hRPrkeV+jX-MSwOZf7T4wKxz66Lk4oub3PZsw@mail.gmail.com>
	<CA+55aFz4uBHaWnBarVUEG90s2ucyVtoLmwYpYVwDV+XQESNRqw@mail.gmail.com>
	<20180612042600-mutt-send-email-mst@kernel.org>
	<CA+55aFyNhEzzufw0XP9DcqZNS1CH+jDGdN4CVnazb3ssFxFbzQ@mail.gmail.com>
	<5B1FA8EF.4030409@intel.com>
	<0f18063c-c76b-4728-5145-810f069988ea@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <0f18063c-c76b-4728-5145-810f069988ea@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nitesh Narayan Lal <nilal@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: KVM list <kvm@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 06/14/2018 11:01 PM, Nitesh Narayan Lal wrote:
> Hi Wei,
>
>
> On 06/12/2018 07:05 AM, Wei Wang wrote:
>> On 06/12/2018 09:59 AM, Linus Torvalds wrote:
>>> On Mon, Jun 11, 2018 at 6:36 PM Michael S. Tsirkin <mst@redhat.com>
>>> wrote:
>>>> Maybe it will help to have GFP_NONE which will make any allocation
>>>> fail if attempted. Linus, would this address your comment?
>>> It would definitely have helped me initially overlook that call chain.
>>>
>>> But then when I started looking at the whole dma_map_page() thing, it
>>> just raised my hackles again.
>>>
>>> I would seriously suggest having a much simpler version for the "no
>>> allocation, no dma mapping" case, so that it's *obvious* that that
>>> never happens.
>>>
>>> So instead of having virtio_balloon_send_free_pages() call a really
>>> generic complex chain of functions that in _some_ cases can do memory
>>> allocation, why isn't there a short-circuited "vitruque_add_datum()"
>>> that is guaranteed to never do anything like that?
>>>
>>> Honestly, I look at "add_one_sg()" and it really doesn't make me
>>> happy. It looks hacky as hell. If I read the code right, you're really
>>> trying to just queue up a simple tuple of <pfn,len>, except you encode
>>> it as a page pointer in order to play games with the SG logic, and
>>> then you hmap that to the ring, except in this case it's all a fake
>>> ring that just adds the cpu-physical address instead.
>>>
>>> And to figuer that out, it's like five layers of indirection through
>>> different helper functions that *can* do more generic things but in
>>> this case don't.
>>>
>>> And you do all of this from a core VM callback function with some
>>> _really_ core VM locks held.
>>>
>>> That makes no sense to me.
>>>
>>> How about this:
>>>
>>>    - get rid of all that code
>>>
>>>    - make the core VM callback save the "these are the free memory
>>> regions" in a fixed and limited array. One that DOES JUST THAT. No
>>> crazy "SG IO dma-mapping function crap". Just a plain array of a fixed
>>> size, pre-allocated for that virtio instance.
>>>
>>>    - make it obvious that what you do in that sequence is ten
>>> instructions and no allocations ("Look ma, I wrote a value to an array
>>> and incremented the array idex, and I'M DONE")
>>>
>>>    - then in that workqueue entry that you start *anyway*, you empty the
>>> array and do all the crazy virtio stuff.
>>>
>>> In fact, while at it, just simplify the VM interface too. Instead of
>>> traversing a random number of buddy lists, just trraverse *one* - the
>>> top-level one. Are you seriously ever going to shrink or mark
>>> read-only anythin *but* something big enough to be in the maximum
>>> order?
>>>
>>> MAX_ORDER is what, 11? So we're talking 8MB blocks. Do you *really*
>>> want the balloon code to work on smaller things, particularly since
>>> the whole interface is fundamentally racy and opportunistic to begin
>>> with?
>> OK, I will implement a new version based on the suggestions. Thanks.
> I have been working on a similar series [1] that is more generic, which
> solves the problem of giving unused memory back to the host and could be
> used to solve the migration problem as well. Can you take a look and see
> if you can use my series in some way?

Hi Nitesh,

I actually checked the last version, which dates back to last year. It 
seems the new version does not have fundamental differences.

Actually there are obvious differences between the two series. This 
series provides a simple lightweight method (will continue to post out a 
new version with simpler interfaces based on the above suggestions) to 
offer free pages hints, and the hints are quit helpful for usages like 
accelerating live migration and guest snapshot. If I read that 
correctly, that series seems to provide true (guaranteed) free pages 
with much more heavyweight logics, but true free pages are not necessary 
for the live migration optimization, which is the goal and motivation of 
this work. And from my point of view, that series seems more like an 
alternative function to ballooning, which takes out free pages (or say 
guest unused pages) via allocation.

I will join the discussion in that thread. Probably we would need to 
think about other new usages for that series.

Best,
Wei

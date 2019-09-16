From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Date: Mon, 16 Sep 2019 09:41:42 +0800
Message-ID: <5D7EE856.2080602@intel.com>
References: <CAJuQAmpQmNN1EJHm4RinZnBven9Bx4GGqd-8Mt+L=3Z-3pd+zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJuQAmpQmNN1EJHm4RinZnBven9Bx4GGqd-8Mt+L=3Z-3pd+zg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tyler Sanderson <tysand@google.com>, virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 09/14/2019 02:36 AM, Tyler Sanderson wrote:
> Hello, I'm curious about the intent of VIRTIO_BALLOON_F_FREE_PAGE_HINT 
> (commit 
> <https://github.com/torvalds/linux/commit/86a559787e6f5cf662c081363f64a20cad654195#diff-fd202acf694d9eba19c8c64da3e480c9>). 
>
>
> My understanding is that this mechanism works similarly to the 
> existing inflate/deflate queues. Pages are allocated by the guest and 
> then reported on VQ_FREE_PAGE.
>
> Question: Is there a limit to how many pages will be allocated? What 
> controls the amount of memory pressure applied?

No control for the limit currently. The implementation reports all the 
guest free pages to host.
The main usage for this feature so far is to have guest skip sending 
those guest free pages
(the more, the better) during live migration.


>
> In my experience with virtio balloon there are problems with the 
> mechanisms that are supposed to deflate the balloon in response to 
> memory pressure (e.g. OOM notifier).

What problem did you see? We've also changed balloon to use memory shrinker,
did you see the problem with shrinker as well?

>
> It seems an ideal balloon interface would allow the guest to round 
> robin through free guest physical pages, allowing the host to unback 
> them, but never having more than a few pages allocated to the balloon 
> at any one time. For example:
> 1. Guest allocates 1 page and notifies balloon device of this page's 
> address.
> 2. Host debacks the received page.
> 3. Guest frees the page.
> 4. Repeat at #1, but ensure that different pages are allocated each time.

Probably you need a mechanism to "ensure" different pages to be allocated.
The current implementation (having balloon hold the allocated pages) could
be thought of as one mechanism (it is simple).

>
> This way the "balloon size" is never more than a few pages and does 
> not create memory pressure. However the difficulty is in ensuring each 
> set of sent pages is disjoint from previously sent pages. Is there a 
> mechanism to round-robin allocations through all of guest physical 
> memory? Does VIRTIO_BALLOON_F_FREE_PAGE_HINT enable this?
>

AFAIK, no such round-robin allocation so far. This may need the page 
allocation to have states recording
the allocation history.

Best,
Wei

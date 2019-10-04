From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Date: Fri, 4 Oct 2019 04:35:46 -0400
Message-ID: <20191004043446-mutt-send-email-mst@kernel.org>
References: <CAJuQAmpQmNN1EJHm4RinZnBven9Bx4GGqd-8Mt+L=3Z-3pd+zg@mail.gmail.com>
	<5D7EE856.2080602@intel.com>
	<09257686-90df-5c31-c35f-9d16fc77fee1@redhat.com>
	<CAJuQAmpQV26kb9vTyoW-Q7PsD0SOfX+otkiQZAks1L6k7rgdig@mail.gmail.com>
	<20191003142854-mutt-send-email-mst@kernel.org>
	<CAJuQAmrCiPsofYpDvm8=i32d9c9yCmKpJRBSRFkeubP_2=XKtw@mail.gmail.com>
	<0df87f00-5102-973b-3a7a-735e44f4ac3f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <0df87f00-5102-973b-3a7a-735e44f4ac3f@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Hildenbrand <david@redhat.com>
Cc: Tyler Sanderson <tysand@google.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 04, 2019 at 10:06:03AM +0200, David Hildenbrand wrote:
> On 04.10.19 01:15, Tyler Sanderson wrote:
> > I was mistaken, the problem with overcommit accounting is not fixed by
> > the change to shrinker interface.
> > This means that large allocations are stopped even if they could succeed
> > by deflating the balloon.
> 
> Please note that some people use the balloon for actual memory unplug -
> so initiating to deflate the balloon under any circumstances is
> undesired. It's different with "VIRTIO_BALLOON_F_DEFLATE_ON_OOM" being
> set - however that is barely the case (at least in the setups I know :) ).
> 
> So yes, free page reporting is a different thing, because it really is
> used to "hint" and not to "agree to unplug" in any scenario.
> 
> -- 
> 
> Thanks,
> 


VIRTIO_BALLOON_F_DEFLATE_ON_OOM isn't really well thought through
at the spec level either. For example, when will we inflate again?
Current code does this at the next interrupt, which requires
host to somehow know it's time to inflate.

-- 
MST

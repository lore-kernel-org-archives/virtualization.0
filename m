From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Date: Sat, 5 Oct 2019 17:03:11 -0400
Message-ID: <20191005170200-mutt-send-email-mst@kernel.org>
References: <CAJuQAmpQmNN1EJHm4RinZnBven9Bx4GGqd-8Mt+L=3Z-3pd+zg@mail.gmail.com>
	<5D7EE856.2080602@intel.com>
	<09257686-90df-5c31-c35f-9d16fc77fee1@redhat.com>
	<CAJuQAmpQV26kb9vTyoW-Q7PsD0SOfX+otkiQZAks1L6k7rgdig@mail.gmail.com>
	<20191003142854-mutt-send-email-mst@kernel.org>
	<CAJuQAmrCiPsofYpDvm8=i32d9c9yCmKpJRBSRFkeubP_2=XKtw@mail.gmail.com>
	<0df87f00-5102-973b-3a7a-735e44f4ac3f@redhat.com>
	<20191004043446-mutt-send-email-mst@kernel.org>
	<30c6feba-7037-b52f-3ef4-4a5c50be0aff@redhat.com>
	<CAJuQAmpwQ4guGtHTTWC60EAYBuJ264d6CgWmWEHSnb8-CRtWBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAJuQAmpwQ4guGtHTTWC60EAYBuJ264d6CgWmWEHSnb8-CRtWBw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tyler Sanderson <tysand@google.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 04, 2019 at 12:03:43PM -0700, Tyler Sanderson wrote:
> I think DEFLATE_ON_OOM makes sense conceptually, it's just that the
> implementation doesn't play well with the rest of memory management under
> memory pressure.
> It could probably be fixed with enough effort, but IMO free page hinting =
gets
> 90% of the benefit without poking the dark corners of memory management a=
nd so
> is a net win.
> =

> The obvious place where free page hinting falls short (as David pointed o=
ut
> above) is that it can't pressure the page cache.
> Would it be possible=A0to add a mechanism that explicitly causes page cac=
he to
> shrink without requiring the system to be under memory pressure?

Which API would you call to shrink it?


> On Fri, Oct 4, 2019 at 1:56 AM David Hildenbrand <david@redhat.com> wrote:
> =

>     On 04.10.19 10:35, Michael S. Tsirkin wrote:
>     > On Fri, Oct 04, 2019 at 10:06:03AM +0200, David Hildenbrand wrote:
>     >> On 04.10.19 01:15, Tyler Sanderson wrote:
>     >>> I was mistaken, the problem with overcommit accounting is not fix=
ed by
>     >>> the change to shrinker interface.
>     >>> This means that large allocations are stopped even if they could
>     succeed
>     >>> by deflating the balloon.
>     >>
>     >> Please note that some people use the balloon for actual memory unp=
lug -
>     >> so initiating to deflate the balloon under any circumstances is
>     >> undesired. It's different with "VIRTIO_BALLOON_F_DEFLATE_ON_OOM" b=
eing
>     >> set - however that is barely the case (at least in the setups I kn=
ow :)
>     ).
>     >>
>     >> So yes, free page reporting is a different thing, because it reall=
y is
>     >> used to "hint" and not to "agree to unplug" in any scenario.
>     >>
>     >> --
>     >>
>     >> Thanks,
>     >>
>     >
>     >
>     > VIRTIO_BALLOON_F_DEFLATE_ON_OOM isn't really well thought through
>     > at the spec level either. For example, when will we inflate again?
>     > Current code does this at the next interrupt, which requires
>     > host to somehow know it's time to inflate.
>     >
> =

>     The host has access to memory stats of the guest, so it could come up
>     with some heuristics - but I do agree that is not well thought throug=
h -
>     one reason why it is barely used :)
> =

>     --
> =

>     Thanks,
> =

>     David / dhildenb
> =

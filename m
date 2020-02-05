From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Balloon pressuring page cache
Date: Wed, 5 Feb 2020 01:57:45 -0500
Message-ID: <20200205015057-mutt-send-email-mst@kernel.org>
References: <CAJuQAmqcayaNuG19fKCuux=YVO3+VcN-qrXvobgKMykogeMkzA@mail.gmail.com>
 <20200203080520-mutt-send-email-mst@kernel.org>
 <5ac131de8e3b7fc1fafd05a61feb5f6889aeb917.camel@linux.intel.com>
 <c836a8d1-c5cc-eb8b-84ed-027070b77bf8@redhat.com>
 <20200203120225-mutt-send-email-mst@kernel.org>
 <CAJuQAmqGA9mhzR5AQeMDtovJAh7y8khC3qUtLKx_e9RdL0wFJQ@mail.gmail.com>
 <74cc25a6-cefb-c580-8e59-5b76fb680bf4@redhat.com>
 <CAJuQAmpiVqnNt-vSkQh5Gg63QZ49_nuz4+VW2Jfwn51gWVdtfA@mail.gmail.com>
 <b809340d-7e86-caf6-bf12-db7bb8265045@redhat.com>
 <CAJuQAmqeKvc_k7pmDuC1b+w6yezzHoSxZJ8WW5sHVo1yMsRPfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJuQAmqeKvc_k7pmDuC1b+w6yezzHoSxZJ8WW5sHVo1yMsRPfg@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Tyler Sanderson <tysand@google.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, namit@vmware.com, David Rientjes <rientjes@google.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 04, 2020 at 03:58:51PM -0800, Tyler Sanderson wrote:
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 1. It is last-resort, which means the sy=
stem has already gone     through
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0heroics to prevent OOM. Tho=
se heroic reclaim efforts are     expensive
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0and impact application perf=
ormance.
>     >
>     >=C2=A0 =C2=A0 =C2=A0That's *exactly* what "deflate on OOM" suggests.
>     >
>     >
>     > It seems there are some use cases where "deflate on OOM" is desired=
 and
>     > others where "deflate on pressure" is desired.
>     > This suggests adding a new feature bit "DEFLATE_ON_PRESSURE" that
>     > registers the shrinker, and reverting DEFLATE_ON_OOM to use the OOM
>     > notifier callback.
>     >
>     > This lets users configure the balloon for their use case.
> =

>     You want the old behavior back, so why should we introduce a new one?=
 Or
>     am I missing something? (you did want us to revert to old handling, n=
o?)
> =

> Reverting actually doesn't help me because this has been the behavior sin=
ce
> Linux 4.19 which is already widely in use. So my device implementation ne=
eds to
> handle the shrinker behavior anyways. I started this conversation to ask =
what
> the intended device implementation was.
> =

> I think there are reasonable device implementations that would prefer the
> shrinker=C2=A0behavior (it turns out that mine doesn't).
> For example, an implementation that slowly inflates the balloon for the p=
urpose
> of memory overcommit. It might leave the balloon inflated and expect any =
memory
> pressure (including page cache usage) to deflate the balloon as a way to
> dynamically right-size the balloon.

So just to make sure we understand, what exactly does your
implementation do?


> Two reasons I didn't go with the above implementation:
> 1. I need to support guests before Linux 4.19 which don't have the shrink=
er
> behavior.
> 2. Memory in the balloon does not appear as "available" in /proc/meminfo =
even
> though it is freeable. This is confusing to users, but isn't a deal break=
er.
> =

> If we added a DEFLATE_ON_PRESSURE feature bit that indicated shrinker API
> support then that would resolve reason=C2=A0#1 (ideally we would backport=
 the bit to
> 4.19).

We could declare lack of pagecache pressure with DEFLATE_ON_OOM a
regression and backport the revert but not I think the new
DEFLATE_ON_PRESSURE.


> In any case, the shrinker=C2=A0behavior when pressuring page cache is mor=
e of an
> inefficiency than a bug. It's not clear to me that it necessitates revert=
ing.
> If there were/are reasons to be on the shrinker=C2=A0interface then I thi=
nk those
> carry similar weight as the problem itself.
> =C2=A0
> =

> =

>     I consider virtio-balloon to this very day a big hack. And I don't see
>     it getting better with new config knobs. Having that said, the
>     technologies that are candidates to replace it (free page reporting,
>     taming the guest page cache, etc.) are still not ready - so we'll have
>     to stick with it for now :( .
> =

>     >
>     > I'm actually not sure how you would safely do memory overcommit wit=
hout
>     > DEFLATE_ON_OOM. So I think it unlocks a huge use case.
> =

>     Using better suited technologies that are not ready yet (well, some f=
orm
>     of free page reporting is available under IBM z already but in a
>     proprietary form) ;) Anyhow, I remember that DEFLATE_ON_OOM only makes
>     it less likely to crash your guest, but not that you are safe to sque=
eze
>     the last bit out of your guest VM.
> =

> Can you elaborate on the danger of DEFLATE_ON_OOM? I haven't seen any pro=
blems
> in testing but I'd really like to know about the dangers.
> Is there a difference in safety between the OOM notifier callback and the
> shrinker API?

It's not about dangers as such. It's just that when linux hits OOM
all kind of error paths are being hit, latent bugs start triggering,
latency goes up drastically.


> =

> =

>     --
>     Thanks,
> =

>     David / dhildenb
> =

> =

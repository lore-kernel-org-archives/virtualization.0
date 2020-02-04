From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Balloon pressuring page cache
Date: Tue, 4 Feb 2020 13:56:21 -0500
Message-ID: <20200204135533-mutt-send-email-mst@kernel.org>
References: <75d4594f-0864-5172-a0f8-f97affedb366@redhat.com>
 <286AC319A985734F985F78AFA26841F73E3F8A02@shsmsx102.ccr.corp.intel.com>
 <CAJuQAmqcayaNuG19fKCuux=YVO3+VcN-qrXvobgKMykogeMkzA@mail.gmail.com>
 <20200203080520-mutt-send-email-mst@kernel.org>
 <5ac131de8e3b7fc1fafd05a61feb5f6889aeb917.camel@linux.intel.com>
 <c836a8d1-c5cc-eb8b-84ed-027070b77bf8@redhat.com>
 <20200203120225-mutt-send-email-mst@kernel.org>
 <CAJuQAmqGA9mhzR5AQeMDtovJAh7y8khC3qUtLKx_e9RdL0wFJQ@mail.gmail.com>
 <74cc25a6-cefb-c580-8e59-5b76fb680bf4@redhat.com>
 <CAJuQAmpiVqnNt-vSkQh5Gg63QZ49_nuz4+VW2Jfwn51gWVdtfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJuQAmpiVqnNt-vSkQh5Gg63QZ49_nuz4+VW2Jfwn51gWVdtfA@mail.gmail.com>
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

On Tue, Feb 04, 2020 at 10:52:42AM -0800, Tyler Sanderson wrote:
> =

> =

> On Tue, Feb 4, 2020 at 12:29 AM David Hildenbrand <david@redhat.com> wrot=
e:
> =

>     On 03.02.20 21:32, Tyler Sanderson wrote:
>     > There were apparently good reasons for moving away from OOM notifier
>     > callback:
>     > https://lkml.org/lkml/2018/7/12/314
>     > https://lkml.org/lkml/2018/8/2/322
>     >
>     > In particular the OOM notifier is worse than the shrinker because:
> =

>     The issue is that DEFLATE_ON_OOM is under-specified.
> =

>     >
>     >=C2=A0 1. It is last-resort, which means the system has already gone=
 through
>     >=C2=A0 =C2=A0 =C2=A0heroics to prevent OOM. Those heroic reclaim eff=
orts are expensive
>     >=C2=A0 =C2=A0 =C2=A0and impact application performance.
> =

>     That's *exactly* what "deflate on OOM" suggests.
> =

> =

> It seems there are some use cases where "deflate on OOM" is desired and o=
thers
> where "deflate on pressure" is desired.
> This suggests adding a new feature bit "DEFLATE_ON_PRESSURE" that registe=
rs the
> shrinker, and reverting DEFLATE_ON_OOM to use the OOM notifier callback.
> =

> This lets users configure the balloon for their use case.

Right. Let's not repeat past mistakes and let's try to specify this
new one properly though :)

> =

> =

>     Assume you are using virtio-balloon for some weird way of memory
>     hotunplug (which is what some people do) and you want to minimize the
>     footprint of your guest. Then you really only want to give the guest
>     more memory (or rather, let it take back memory automatically in this
>     case) in case it really needs more memory. It should try to reclaim f=
irst.
> =

>     Under-specified.
> =

> =

>     >=C2=A0 2. It lacks understanding of NUMA or other OOM constraints.
> =

>     Ballooning in general lacks the understanding of NUMA.
> =

>     >=C2=A0 3. It has a higher potential for bugs due to the subtlety=C2=
=A0of the
>     >=C2=A0 =C2=A0 =C2=A0callback context.
> =

>     While that is a valid point, it doesn't explain why existing
>     functionality is changed.
> =

>     Personally, I think DEFLATE_ON_OOM should never have been introduced =
(at
>     least not in this form).
> =

> I'm actually not sure how you would safely do memory overcommit without
> DEFLATE_ON_OOM. So I think it unlocks a huge use case.
> =C2=A0
> =

> =

> =

>     --
>     Thanks,
> =

>     David / dhildenb
> =

> =

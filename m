From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 3/3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Date: Sun, 16 Feb 2020 04:46:12 -0500
Message-ID: <20200216044551-mutt-send-email-mst@kernel.org>
References: <20200205163402.42627-1-david@redhat.com>
 <20200205163402.42627-4-david@redhat.com>
 <20200214140641.GB31689@dhcp22.suse.cz>
 <802f93b1-1588-bd2c-8238-c12ec7f7ae9e@redhat.com>
 <CAJuQAmpGKcyWo8Ojnia_pXZAaOt98u0c_Sk-8ieCO218hutW1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJuQAmpGKcyWo8Ojnia_pXZAaOt98u0c_Sk-8ieCO218hutW1g@mail.gmail.com>
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
Cc: linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Nadav Amit <namit@vmware.com>, David Rientjes <rientjes@google.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 14, 2020 at 12:48:42PM -0800, Tyler Sanderson wrote:
> Regarding Wei's patch that modifies the shrinker implementation, versus t=
his
> patch which reverts to OOM notifier:
> I am in favor of both patches. But I do want to make sure a fix gets back
> ported to 4.19 where the performance regression was first introduced.
> My concern with reverting to the OOM notifier is, as mst@ put it (in the =
other
> thread):
> "when linux hits OOM=C2=A0all kind of error paths are being hit, latent b=
ugs start
> triggering,=C2=A0latency goes up drastically."
> The guest could be in a lot of pain before the OOM notifier is invoked, a=
nd it
> seems like the shrinker API might allow more fine grained control of when=
 we
> deflate.
> =

> On the other hand, I'm not totally convinced that Wei's patch is an expec=
ted
> use of the shrinker/page-cache APIs, and maybe it is fragile. Needs more
> testing=C2=A0and scrutiny.
> =

> It seems to me like the shrinker API is the right API in the long run, pe=
rhaps
> with some fixes and modifications. But maybe reverting to OOM notifier is=
 the
> best patch to back port?

In that case can I see some Tested-by reports pls?


> On Fri, Feb 14, 2020 at 6:19 AM David Hildenbrand <david@redhat.com> wrot=
e:
> =

>     >> There was a report that this results in undesired side effects when
>     >> inflating the balloon to shrink the page cache. [1]
>     >>=C2=A0 =C2=A0 =C2=A0 "When inflating the balloon against page cache=
 (i.e. no free memory
>     >>=C2=A0 =C2=A0 =C2=A0 =C2=A0remains) vmscan.c will both shrink page =
cache, but also invoke the
>     >>=C2=A0 =C2=A0 =C2=A0 =C2=A0shrinkers -- including the balloon's shr=
inker. So the balloon
>     >>=C2=A0 =C2=A0 =C2=A0 =C2=A0driver allocates memory which requires r=
eclaim, vmscan gets this
>     >>=C2=A0 =C2=A0 =C2=A0 =C2=A0memory by shrinking the balloon, and the=
n the driver adds the
>     >>=C2=A0 =C2=A0 =C2=A0 =C2=A0memory back to the balloon. Basically a =
busy no-op."
>     >>
>     >> The name "deflate on OOM" makes it pretty clear when deflation sho=
uld
>     >> happen - after other approaches to reclaim memory failed, not while
>     >> reclaiming. This allows to minimize the footprint of a guest - mem=
ory
>     >> will only be taken out of the balloon when really needed.
>     >>
>     >> Especially, a drop_slab() will result in the whole balloon getting
>     >> deflated - undesired.
>     >
>     > Could you explain why some more? drop_caches shouldn't be really us=
ed in
>     > any production workloads and if somebody really wants all the cache=
 to
>     > be dropped then why is balloon any different?
>     >
> =

>     Deflation should happen when the guest is out of memory, not when
>     somebody thinks it's time to reclaim some memory. That's what the
>     feature promised from the beginning: Only give the guest more memory =
in
>     case it *really* needs more memory.
> =

>     Deflate on oom, not deflate on reclaim/memory pressure. (that's what =
the
>     report was all about)
> =

>     A priority for shrinkers might be a step into the right direction.
> =

>     --
>     Thanks,
> =

>     David / dhildenb
> =

> =

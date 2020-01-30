From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Balloon pressuring page cache
Date: Thu, 30 Jan 2020 10:20:17 -0500
Message-ID: <20200130101710-mutt-send-email-mst@kernel.org>
References: <CAJuQAmpDUyve2S+oxp9tLUhuRcnddXnNztC5PmYOOCpY6c68xg@mail.gmail.com>
 <91270a68-ff48-88b0-219c-69801f0c252f@redhat.com>
 <CAJuQAmoaK0Swytu2Os_SQRfG5_LqiCPaDa9yatatm9MtfncNTQ@mail.gmail.com>
 <75d4594f-0864-5172-a0f8-f97affedb366@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <75d4594f-0864-5172-a0f8-f97affedb366@redhat.com>
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
To: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>, Tyler Sanderson <tysand@google.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, David Rientjes <rientjes@google.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 30, 2020 at 04:02:34PM +0100, David Hildenbrand wrote:
> On 29.01.20 20:11, Tyler Sanderson wrote:
> > =

> > =

> > On Wed, Jan 29, 2020 at 2:31 AM David Hildenbrand <david@redhat.com
> > <mailto:david@redhat.com>> wrote:
> > =

> >     On 29.01.20 01:22, Tyler Sanderson via Virtualization wrote:
> >     > A primary advantage of virtio balloon over other=C2=A0memory recl=
aim
> >     > mechanisms is that it can=C2=A0pressure the guest's page cache in=
to
> >     shrinking.
> >     >
> >     > However, since the balloon driver changed to using the shrinker A=
PI
> >     >
> >     <https://github.com/torvalds/linux/commit/71994620bb25a8b109388fefa=
9e99a28e355255a#diff-fd202acf694d9eba19c8c64da3e480c9>=C2=A0this
> >     > use case has become a bit more tricky. I'm wondering what the int=
ended
> >     > device implementation is.
> >     >
> >     > When inflating the balloon against page cache (i.e. no free memory
> >     > remains) vmscan.c will both shrink page cache, but also invoke the
> >     > shrinkers -- including the balloon's shrinker. So the balloon dri=
ver
> >     > allocates memory which requires reclaim, vmscan gets this memory =
by
> >     > shrinking the balloon, and then the driver adds the memory back t=
o the
> >     > balloon. Basically a busy no-op.
> >     >
> >     > If file IO is ongoing during this balloon inflation then the page
> >     cache
> >     > could be growing which further puts "back pressure" on the balloon
> >     > trying to inflate. In testing I've seen periods of > 45 seconds w=
here
> >     > balloon inflation makes no net forward progress.
> >     >
> >     > This wasn't a problem before the change to the shrinker API since
> >     forced
> >     > balloon deflation only occurred via the OOM notifier callback
> >     which was
> >     > invoked only after the page cache had depleted.
> >     >
> >     > Is this new busy behavior working as intended?
> > =

> >     Please note that the shrinker will only be registered in case we ha=
ve
> >     VIRTIO_BALLOON_F_DEFLATE_ON_OOM - (which is AFAIK very rare) - to
> >     implement automatic balloon deflation when the guest is under memory
> >     pressure.
> > =

> > =

> >     Are you actually experiencing issues with that or did you just stum=
ble
> >     over the code?
> > =

> > =

> > We have a use case that is encountering this (and that registers
> > DEFLATE_ON_OOM). We can work around this, but it does seem inefficient.
> > I understand there were good reasons for moving away from the OOM
> > notifier callback, but I'm wondering if the balloon driver could specify
> > a "nice" level to the shrinker API that would cause it to be reclaimed
> > from only as a last resort?
> > =C2=A0
> =

> Cc-ing linux-mm, Michal and Michael.


Interesting.  VIRTIO_BALLOON_F_DEFLATE_ON_OOM is really
underspecified in a bunch of ways.

I'll wait to see what does Michal say from Linux POV.





> Just wondering, how does your workaround look like?
> =

> -- =

> Thanks,
> =

> David / dhildenb

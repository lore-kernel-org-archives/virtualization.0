From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: BUG: KASAN: use-after-free in free_old_xmit_skbs
Date: Thu, 22 Jun 2017 21:53:03 +0300
Message-ID: <20170622215125-mutt-send-email-mst__18433.8372353979$1498157591$gmane$org@kernel.org>
References: <d2e8cf65-ea3d-7db2-9382-a063daf1168a@gmail.com>
	<20170605050423-mutt-send-email-mst@kernel.org>
	<20170606024211-mutt-send-email-mst@kernel.org>
	<CAOTcU=u_HSMQiwDF3Snv5P8mT-b_Aepeb=Z9gbLd1j=2P+Yy+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAOTcU=u_HSMQiwDF3Snv5P8mT-b_Aepeb=Z9gbLd1j=2P+Yy+A@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jean-philippe menil <jpmenil@gmail.com>
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 22, 2017 at 08:15:58AM +0200, jean-philippe menil wrote:
> 2017-06-06 1:52 GMT+02:00 Michael S. Tsirkin <mst@redhat.com>:
> =

>     On Mon, Jun 05, 2017 at 05:08:25AM +0300, Michael S. Tsirkin wrote:
>     > On Mon, Jun 05, 2017 at 12:48:53AM +0200, Jean-Philippe Menil wrote:
>     > > Hi,
>     > >
>     > > while playing with xdp and ebpf, i'm hitting the following:
>     > >
>     > > [=A0 309.993136]
>     > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     > > [=A0 309.994735] BUG: KASAN: use-after-free in
>     > > free_old_xmit_skbs.isra.29+0x2b7/0x2e0 [virtio_net]
>     > > [=A0 309.998396] Read of size 8 at addr ffff88006aa64220 by task =
sshd/323
>     > > [=A0 310.000650]
>     > > [=A0 310.002305] CPU: 1 PID: 323 Comm: sshd Not tainted 4.12.0-rc=
3+ #2
>     > > [=A0 310.004018] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996),
>     BIOS
>     > > 1.10.2-20170228_101828-anatol 04/01/2014

...

>     >
>     > Since commit 680557cf79f82623e2c4fd42733077d60a843513
>     >=A0 =A0 =A0virtio_net: rework mergeable buffer handling
>     >
>     > we no longer must do the resets, we now have enough space
>     > to store a bit saying whether a buffer is xdp one or not.
>     >
>     > And that's probably a cleaner way to fix these issues than
>     > try to find and fix the race condition.
>     >
>     > John?
>     >
>     > --
>     > MST
> =

> =

>     I think I see the source of the race. virtio net calls
>     netif_device_detach and assumes no packets will be sent after
>     this point. However, all it does is stop all queues so
>     no new packets will be transmitted.
> =

>     Try locking with HARD_TX_LOCK?
>    =

> =

>     --
>     MST
> =

> =

> Hi Michael,
> =

> from what i see, the race appear when we hit virtnet_reset in virtnet_xdp=
_set.
> virtnet_reset
> =A0 _remove_vq_common
> =A0=A0=A0 virtnet_del_vqs
> =A0=A0=A0=A0=A0 virtnet_free_queues
> =A0=A0=A0=A0=A0 =A0 kfree(vi->sq)
> when the xdp program (with two instances of the program to trigger it fas=
ter)
> is added or removed.
> =

> It's easily repeatable, with 2 cpus and 4 queues on the qemu command line,
> running the xdp_ttl tool from Jesper.
> =

> For now, i'm able to continue my qualification, testing if xdp_qp is not =
null,
> but do not seem to be a sustainable trick.
> if (xdp_qp && vi->xdp_queues_pairs !=3D xdp_qp)
> =

> Maybe it will be more clear to you with theses informations.
> =

> Best regards.
> =

> Jean-Philippe


I'm pretty clear about the issue here, I was trying to figure out a fix.
Jason, any thoughts?


-- =

MST

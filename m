From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCHv7 3/3] vhost_net: a kernel-level virtio server
Date: Tue, 3 Nov 2009 15:57:44 -0800
Message-ID: <20091103235744.GF6726__1585.34489241919$1257292949$gmane$org@linux.vnet.ibm.com>
References: <cover.1257267892.git.mst@redhat.com>
	<20091103172422.GD5591@redhat.com> <4AF0708B.4020406@gmail.com>
	<4AF07199.2020601@gmail.com> <4AF072EE.9020202@gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4AF072EE.9020202@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gregory Haskins <gregory.haskins@gmail.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 03, 2009 at 01:14:06PM -0500, Gregory Haskins wrote:
> Gregory Haskins wrote:
> > Eric Dumazet wrote:
> >> Michael S. Tsirkin a =E9crit :
> >>> +static void handle_tx(struct vhost_net *net)
> >>> +{
> >>> +	struct vhost_virtqueue *vq =3D &net->dev.vqs[VHOST_NET_VQ_TX];
> >>> +	unsigned head, out, in, s;
> >>> +	struct msghdr msg =3D {
> >>> +		.msg_name =3D NULL,
> >>> +		.msg_namelen =3D 0,
> >>> +		.msg_control =3D NULL,
> >>> +		.msg_controllen =3D 0,
> >>> +		.msg_iov =3D vq->iov,
> >>> +		.msg_flags =3D MSG_DONTWAIT,
> >>> +	};
> >>> +	size_t len, total_len =3D 0;
> >>> +	int err, wmem;
> >>> +	size_t hdr_size;
> >>> +	struct socket *sock =3D rcu_dereference(vq->private_data);
> >>> +	if (!sock)
> >>> +		return;
> >>> +
> >>> +	wmem =3D atomic_read(&sock->sk->sk_wmem_alloc);
> >>> +	if (wmem >=3D sock->sk->sk_sndbuf)
> >>> +		return;
> >>> +
> >>> +	use_mm(net->dev.mm);
> >>> +	mutex_lock(&vq->mutex);
> >>> +	vhost_no_notify(vq);
> >>> +
> >> using rcu_dereference() and mutex_lock() at the same time seems wrong,=
 I suspect
> >> that your use of RCU is not correct.
> >>
> >> 1) rcu_dereference() should be done inside a read_rcu_lock() section, =
and
> >>    we are not allowed to sleep in such a section.
> >>    (Quoting Documentation/RCU/whatisRCU.txt :
> >>      It is illegal to block while in an RCU read-side critical section=
, )
> >>
> >> 2) mutex_lock() can sleep (ie block)
> >>
> > =

> > =

> > Michael,
> >   I warned you that this needed better documentation ;)
> > =

> > Eric,
> >   I think I flagged this once before, but Michael convinced me that it
> > was indeed "ok", if but perhaps a bit unconventional.  I will try to
> > find the thread.
> > =

> > Kind Regards,
> > -Greg
> > =

> =

> Here it is:
> =

> http://lkml.org/lkml/2009/8/12/173

What was happening in that case was that the rcu_dereference()
was being used in a workqueue item.  The role of rcu_read_lock()
was taken on be the start of execution of the workqueue item, of
rcu_read_unlock() by the end of execution of the workqueue item, and
of synchronize_rcu() by flush_workqueue().  This does work, at least
assuming that flush_workqueue() operates as advertised, which it appears
to at first glance.

The above code looks somewhat different, however -- I don't see
handle_tx() being executed in the context of a work queue.  Instead
it appears to be in an interrupt handler.

So what is the story?  Using synchronize_irq() or some such?

							Thanx, Paul

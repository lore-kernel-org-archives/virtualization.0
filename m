From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv7 3/3] vhost_net: a kernel-level virtio server
Date: Tue, 3 Nov 2009 21:55:57 +0200
Message-ID: <20091103195557.GA6669__16313.7400326834$1257278384$gmane$org@redhat.com>
References: <cover.1257267892.git.mst@redhat.com>
	<20091103172422.GD5591@redhat.com> <4AF0708B.4020406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4AF0708B.4020406@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, mingo@elte.hu, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 03, 2009 at 07:03:55PM +0100, Eric Dumazet wrote:
> Michael S. Tsirkin a =E9crit :
> > +static void handle_tx(struct vhost_net *net)
> > +{
> > +	struct vhost_virtqueue *vq =3D &net->dev.vqs[VHOST_NET_VQ_TX];
> > +	unsigned head, out, in, s;
> > +	struct msghdr msg =3D {
> > +		.msg_name =3D NULL,
> > +		.msg_namelen =3D 0,
> > +		.msg_control =3D NULL,
> > +		.msg_controllen =3D 0,
> > +		.msg_iov =3D vq->iov,
> > +		.msg_flags =3D MSG_DONTWAIT,
> > +	};
> > +	size_t len, total_len =3D 0;
> > +	int err, wmem;
> > +	size_t hdr_size;
> > +	struct socket *sock =3D rcu_dereference(vq->private_data);
> > +	if (!sock)
> > +		return;
> > +
> > +	wmem =3D atomic_read(&sock->sk->sk_wmem_alloc);
> > +	if (wmem >=3D sock->sk->sk_sndbuf)
> > +		return;
> > +
> > +	use_mm(net->dev.mm);
> > +	mutex_lock(&vq->mutex);
> > +	vhost_no_notify(vq);
> > +
> =

> using rcu_dereference() and mutex_lock() at the same time seems wrong, I =
suspect
> that your use of RCU is not correct.
> =

> 1) rcu_dereference() should be done inside a read_rcu_lock() section, and
>    we are not allowed to sleep in such a section.
>    (Quoting Documentation/RCU/whatisRCU.txt :
>      It is illegal to block while in an RCU read-side critical section, )
> =

> 2) mutex_lock() can sleep (ie block)

This use is correct. See comment in vhost.h This use of RCU has been
acked by Paul E. McKenney (paulmck@linux.vnet.ibm.com) as well.
There are many ways to use RCU not all of which involve read_rcu_lock.

From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 11/11] vhost_net: batch submitting XDP buffers
	to underlayer sockets
Date: Fri, 7 Sep 2018 12:13:06 -0400
Message-ID: <20180907121148-mutt-send-email-mst__36157.0637244315$1536336667$gmane$org@kernel.org>
References: <20180906040526.22518-1-jasowang@redhat.com>
	<20180906040526.22518-12-jasowang@redhat.com>
	<20180906122857-mutt-send-email-mst@kernel.org>
	<ffb802e6-1505-e01e-f6d5-11cde8dace9b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <ffb802e6-1505-e01e-f6d5-11cde8dace9b@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 07, 2018 at 03:41:52PM +0800, Jason Wang wrote:
> > > @@ -556,10 +667,14 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> > >   	size_t len, total_len = 0;
> > >   	int err;
> > >   	int sent_pkts = 0;
> > > +	bool bulking = (sock->sk->sk_sndbuf == INT_MAX);
> > What does bulking mean?
> 
> The name is misleading, it means whether we can do batching. For simplicity,
> I disable batching is sndbuf is not INT_MAX.

But what does batching have to do with sndbuf?

> > >   	for (;;) {
> > >   		bool busyloop_intr = false;
> > > +		if (nvq->done_idx == VHOST_NET_BATCH)
> > > +			vhost_tx_batch(net, nvq, sock, &msg);
> > > +
> > >   		head = get_tx_bufs(net, nvq, &msg, &out, &in, &len,
> > >   				   &busyloop_intr);
> > >   		/* On error, stop handling until the next kick. */
> > > @@ -577,14 +692,34 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> > >   			break;
> > >   		}
> > > -		vq->heads[nvq->done_idx].id = cpu_to_vhost32(vq, head);
> > > -		vq->heads[nvq->done_idx].len = 0;
> > > -
> > >   		total_len += len;
> > > -		if (tx_can_batch(vq, total_len))
> > > -			msg.msg_flags |= MSG_MORE;
> > > -		else
> > > -			msg.msg_flags &= ~MSG_MORE;
> > > +
> > > +		/* For simplicity, TX batching is only enabled if
> > > +		 * sndbuf is unlimited.
> > What if sndbuf changes while this processing is going on?
> 
> We will get the correct sndbuf in the next run of handle_tx(). I think this
> is safe.

If it's safe why bother with special-casing INT_MAX?

-- 
MST

From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [RFC PATCH 07/13] vsock: handle buffer_size sockopts in the core
Date: Thu, 10 Oct 2019 11:32:54 +0200
Message-ID: <20191010093254.aluys4hpsfcepb42__28898.2414220058$1570699991$gmane$org@steredhat>
References: <20190927112703.17745-1-sgarzare@redhat.com>
	<20190927112703.17745-8-sgarzare@redhat.com>
	<20191009123026.GH5747@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191009123026.GH5747@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 09, 2019 at 01:30:26PM +0100, Stefan Hajnoczi wrote:
> On Fri, Sep 27, 2019 at 01:26:57PM +0200, Stefano Garzarella wrote:
> > @@ -140,18 +145,11 @@ struct vsock_transport {
> >  		struct vsock_transport_send_notify_data *);
> >  	int (*notify_send_post_enqueue)(struct vsock_sock *, ssize_t,
> >  		struct vsock_transport_send_notify_data *);
> > +	int (*notify_buffer_size)(struct vsock_sock *, u64 *);
> 
> Is ->notify_buffer_size() called under lock_sock(sk)?  If yes, please
> document it.

Yes, it is. I'll document it!

> 
> > +static void vsock_update_buffer_size(struct vsock_sock *vsk,
> > +				     const struct vsock_transport *transport,
> > +				     u64 val)
> > +{
> > +	if (val > vsk->buffer_max_size)
> > +		val = vsk->buffer_max_size;
> > +
> > +	if (val < vsk->buffer_min_size)
> > +		val = vsk->buffer_min_size;
> > +
> > +	if (val != vsk->buffer_size &&
> > +	    transport && transport->notify_buffer_size)
> > +		transport->notify_buffer_size(vsk, &val);
> 
> Why does this function return an int if we don't check the return value?
> 

Copy and past :-(
I'll fix it returning void since I don't think it can fail.

> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index fc046c071178..bac9e7430a2e 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -403,17 +403,13 @@ int virtio_transport_do_socket_init(struct vsock_sock *vsk,
> >  	if (psk) {
> >  		struct virtio_vsock_sock *ptrans = psk->trans;
> >  
> > -		vvs->buf_size	= ptrans->buf_size;
> > -		vvs->buf_size_min = ptrans->buf_size_min;
> > -		vvs->buf_size_max = ptrans->buf_size_max;
> >  		vvs->peer_buf_alloc = ptrans->peer_buf_alloc;
> > -	} else {
> > -		vvs->buf_size = VIRTIO_VSOCK_DEFAULT_BUF_SIZE;
> > -		vvs->buf_size_min = VIRTIO_VSOCK_DEFAULT_MIN_BUF_SIZE;
> > -		vvs->buf_size_max = VIRTIO_VSOCK_DEFAULT_MAX_BUF_SIZE;
> >  	}
> >  
> > -	vvs->buf_alloc = vvs->buf_size;
> > +	if (vsk->buffer_size > VIRTIO_VSOCK_MAX_BUF_SIZE)
> > +		vsk->buffer_size = VIRTIO_VSOCK_MAX_BUF_SIZE;
> 
> Hmm...this could be outside the [min, max] range.  I'm not sure how much
> it matters.

The core guarantees that vsk->buffer_size is <= of the max, so since we are
lowering it, the max should be respected. For the min you are right,
but I think this limit is stricter than the min set by the user.

> 
> Another issue is that this patch drops the VIRTIO_VSOCK_MAX_BUF_SIZE
> limit that used to be enforced by virtio_transport_set_buffer_size().
> Now the limit is only applied at socket init time.  If the buffer size
> is changed later then VIRTIO_VSOCK_MAX_BUF_SIZE can be exceeded.  If
> that doesn't matter, why even bother with VIRTIO_VSOCK_MAX_BUF_SIZE
> here?
> 

The .notify_buffer_size() should avoid this issue, since it allows the
transport to limit the buffer size requested after the initialization.

But again the min set by the user can not be respected and in the
previous implementation we forced it to VIRTIO_VSOCK_MAX_BUF_SIZE.

Now we don't limit the min, but we guarantee only that vsk->buffer_size
is lower than VIRTIO_VSOCK_MAX_BUF_SIZE.

Can that be an acceptable compromise?

Thanks,
Stefano

From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v4 3/5] vsock/virtio: fix locking in
	virtio_transport_inc_tx_pkt()
Date: Thu, 18 Jul 2019 09:43:04 +0200
Message-ID: <CAGxU2F5PS8Ug3ei79ShVHOwLSXGYKwn3umvfvnhSFDs9pdvH2g__11153.7991486088$1563435802$gmane$org@mail.gmail.com>
References: <20190717113030.163499-1-sgarzare@redhat.com>
	<20190717113030.163499-4-sgarzare@redhat.com>
	<20190717105056-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190717105056-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 17, 2019 at 4:51 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jul 17, 2019 at 01:30:28PM +0200, Stefano Garzarella wrote:
> > fwd_cnt and last_fwd_cnt are protected by rx_lock, so we should use
> > the same spinlock also if we are in the TX path.
> >
> > Move also buf_alloc under the same lock.
> >
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
> Wait a second is this a bugfix?
> If it's used under the wrong lock won't values get corrupted?
> Won't traffic then stall or more data get to sent than
> credits?

Before this series, we only read vvs->fwd_cnt and vvs->buf_alloc in this
function, but using a different lock than the one used to write them.
I'm not sure if a corruption can happen, but if we want to avoid the
lock, we should use an atomic operation or memory barriers.

Since now we also need to update vvs->last_fwd_cnt, in order to limit the
credit message, I decided to take the same lock used to protect vvs->fwd_cnt
and vvs->last_fwd_cnt.


Thanks,
Stefano

>
> > ---
> >  include/linux/virtio_vsock.h            | 2 +-
> >  net/vmw_vsock/virtio_transport_common.c | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > index 49fc9d20bc43..4c7781f4b29b 100644
> > --- a/include/linux/virtio_vsock.h
> > +++ b/include/linux/virtio_vsock.h
> > @@ -35,7 +35,6 @@ struct virtio_vsock_sock {
> >
> >       /* Protected by tx_lock */
> >       u32 tx_cnt;
> > -     u32 buf_alloc;
> >       u32 peer_fwd_cnt;
> >       u32 peer_buf_alloc;
> >
> > @@ -43,6 +42,7 @@ struct virtio_vsock_sock {
> >       u32 fwd_cnt;
> >       u32 last_fwd_cnt;
> >       u32 rx_bytes;
> > +     u32 buf_alloc;
> >       struct list_head rx_queue;
> >  };
> >
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index a85559d4d974..34a2b42313b7 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -210,11 +210,11 @@ static void virtio_transport_dec_rx_pkt(struct virtio_vsock_sock *vvs,
> >
> >  void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct virtio_vsock_pkt *pkt)
> >  {
> > -     spin_lock_bh(&vvs->tx_lock);
> > +     spin_lock_bh(&vvs->rx_lock);
> >       vvs->last_fwd_cnt = vvs->fwd_cnt;
> >       pkt->hdr.fwd_cnt = cpu_to_le32(vvs->fwd_cnt);
> >       pkt->hdr.buf_alloc = cpu_to_le32(vvs->buf_alloc);
> > -     spin_unlock_bh(&vvs->tx_lock);
> > +     spin_unlock_bh(&vvs->rx_lock);
> >  }
> >  EXPORT_SYMBOL_GPL(virtio_transport_inc_tx_pkt);
> >
> > --
> > 2.20.1

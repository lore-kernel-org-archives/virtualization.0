From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost: vsock: don't send pkt when vq is not started
Date: Thu, 30 Apr 2020 15:43:00 -0400
Message-ID: <20200430153929-mutt-send-email-mst@kernel.org>
References: <20200430021314.6425-1-justin.he@arm.com>
 <20200430082608.wbtqgglmtnd7e5ci@steredhat>
 <AM6PR08MB4069D4AB611B8C8180DC4B9CF7AA0@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <20200430162521.k4b4t3vttfabgqal@steredhat>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200430162521.k4b4t3vttfabgqal@steredhat>
Sender: kvm-owner@vger.kernel.org
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Justin He <Justin.He@arm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kaly Xin <Kaly.Xin@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 30, 2020 at 06:25:21PM +0200, Stefano Garzarella wrote:
> On Thu, Apr 30, 2020 at 10:06:26AM +0000, Justin He wrote:
> > Hi Stefano
> > 
> > > -----Original Message-----
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > Sent: Thursday, April 30, 2020 4:26 PM
> > > To: Justin He <Justin.He@arm.com>
> > > Cc: Stefan Hajnoczi <stefanha@redhat.com>; Michael S. Tsirkin
> > > <mst@redhat.com>; Jason Wang <jasowang@redhat.com>;
> > > kvm@vger.kernel.org; virtualization@lists.linux-foundation.org;
> > > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Kaly Xin
> > > <Kaly.Xin@arm.com>
> > > Subject: Re: [PATCH] vhost: vsock: don't send pkt when vq is not started
> > >
> > > Hi Jia,
> > > thanks for the patch, some comments below:
> > >
> > > On Thu, Apr 30, 2020 at 10:13:14AM +0800, Jia He wrote:
> > > > Ning Bo reported an abnormal 2-second gap when booting Kata container
> > > [1].
> > > > The unconditional timeout is caused by
> > > VSOCK_DEFAULT_CONNECT_TIMEOUT of
> > > > connect at client side. The vhost vsock client tries to connect an
> > > > initlizing virtio vsock server.
> > > >
> > > > The abnormal flow looks like:
> > > > host-userspace           vhost vsock                       guest vsock
> > > > ==============           ===========                       ============
> > > > connect()     -------->  vhost_transport_send_pkt_work()   initializing
> > > >    |                     vq->private_data==NULL
> > > >    |                     will not be queued
> > > >    V
> > > > schedule_timeout(2s)
> > > >                          vhost_vsock_start()  <---------   device ready
> > > >                          set vq->private_data
> > > >
> > > > wait for 2s and failed
> > > >
> > > > connect() again          vq->private_data!=NULL          recv connecting pkt
> > > >
> > > > 1. host userspace sends a connect pkt, at that time, guest vsock is under
> > > > initializing, hence the vhost_vsock_start has not been called. So
> > > > vq->private_data==NULL, and the pkt is not been queued to send to guest.
> > > > 2. then it sleeps for 2s
> > > > 3. after guest vsock finishes initializing, vq->private_data is set.
> > > > 4. When host userspace wakes up after 2s, send connecting pkt again,
> > > > everything is fine.
> > > >
> > > > This fixes it by checking vq->private_data in vhost_transport_send_pkt,
> > > > and return at once if !vq->private_data. This makes user connect()
> > > > be returned with ECONNREFUSED.
> > > >
> > > > After this patch, kata-runtime (with vsock enabled) boottime reduces from
> > > > 3s to 1s on ThunderX2 arm64 server.
> > > >
> > > > [1] https://github.com/kata-containers/runtime/issues/1917
> > > >
> > > > Reported-by: Ning Bo <n.b@live.com>
> > > > Signed-off-by: Jia He <justin.he@arm.com>
> > > > ---
> > > >  drivers/vhost/vsock.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > > > index e36aaf9ba7bd..67474334dd88 100644
> > > > --- a/drivers/vhost/vsock.c
> > > > +++ b/drivers/vhost/vsock.c
> > > > @@ -241,6 +241,7 @@ vhost_transport_send_pkt(struct virtio_vsock_pkt
> > > *pkt)
> > > >  {
> > > >  struct vhost_vsock *vsock;
> > > >  int len = pkt->len;
> > > > +struct vhost_virtqueue *vq;
> > > >
> > > >  rcu_read_lock();
> > > >
> > > > @@ -252,6 +253,13 @@ vhost_transport_send_pkt(struct virtio_vsock_pkt
> > > *pkt)
> > > >  return -ENODEV;
> > > >  }
> > > >
> > > > +vq = &vsock->vqs[VSOCK_VQ_RX];
> > > > +if (!vq->private_data) {
> > >
> > > I think is better to use vhost_vq_get_backend():
> > >
> > > if (!vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])) {
> > > ...
> > >
> > > This function should be called with 'vq->mutex' acquired as explained in
> > > the comment, but here we can avoid that, because we are not using the vq,
> > > so it is safe, because in vhost_transport_do_send_pkt() we check it again.
> > >
> > > Please add a comment explaining that.
> > >
> > 
> > Thanks, vhost_vq_get_backend is better. I chose a 5.3 kernel to develop
> > and missed this helper.
> 
> :-)
> 
> > >
> > > As an alternative to this patch, should we kick the send worker when the
> > > device is ready?
> > >
> > > IIUC we reach the timeout because the send worker (that runs
> > > vhost_transport_do_send_pkt()) exits immediately since 'vq->private_data'
> > > is NULL, and no one will requeue it.
> > >
> > > Let's do it when we know the device is ready:
> > >
> > > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > > index e36aaf9ba7bd..295b5867944f 100644
> > > --- a/drivers/vhost/vsock.c
> > > +++ b/drivers/vhost/vsock.c
> > > @@ -543,6 +543,11 @@ static int vhost_vsock_start(struct vhost_vsock
> > > *vsock)
> > >                 mutex_unlock(&vq->mutex);
> > >         }
> > >
> > > +       /* Some packets may have been queued before the device was started,
> > > +        * let's kick the send worker to send them.
> > > +        */
> > > +       vhost_work_queue(&vsock->dev, &vsock->send_pkt_work);
> > > +
> > Yes, it works.
> > But do you think a threshold should be set here to prevent the queue
> > from being too long? E.g. the client user sends too many connect pkts
> > in a short time before the server is completely ready.
> 
> When the user call the connect() the socket status is moved to
> SS_CONNECTING (see net/vmw_vsock/af_vsock.c), so another connect() on
> the same socket will receive EALREADY error.
> 
> If the user uses multiple sockets, the socket layer already check for
> any limits, so I don't think we should put a threshold here.
> 
> > 
> > >         mutex_unlock(&vsock->dev.mutex);
> > >         return 0;
> > >
> > > I didn't test it, can you try if it fixes the issue?
> > >
> > > I'm not sure which is better...
> > I don't know, either. Wait for more comments 😊
> 
> I prefer the second option, because the device is in a transitional
> state and a connect can block (for at most two seconds) until the device is
> started.
> 
> For the first option, I'm also not sure if ECONNREFUSED is the right error
> to return, maybe is better ENETUNREACH.
> 
> Cheers,
> Stefano

IIRC:

ECONNREFUSED is what one gets when connecting to remote a port which does not
yet have a listening socket, so remote sends back RST.
ENETUNREACH is when local network's down, so you can't even send a
connection request.
EHOSTUNREACH is remote network is down.

-- 
MST

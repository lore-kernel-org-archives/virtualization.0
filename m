From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v2 2/8] vsock/virtio: free packets during the socket
	release
Date: Sat, 11 May 2019 10:27:05 +0200
Message-ID: <20190511082705.t62d3rfbgibc4zxi@steredhat.homenet.telecomitalia.it>
References: <20190510125843.95587-1-sgarzare@redhat.com>
	<20190510125843.95587-3-sgarzare@redhat.com>
	<20190510.152008.1902268386064871188.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190510.152008.1902268386064871188.davem@davemloft.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 10, 2019 at 03:20:08PM -0700, David Miller wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> Date: Fri, 10 May 2019 14:58:37 +0200
> 
> > @@ -827,12 +827,20 @@ static bool virtio_transport_close(struct vsock_sock *vsk)
> >  
> >  void virtio_transport_release(struct vsock_sock *vsk)
> >  {
> > +	struct virtio_vsock_sock *vvs = vsk->trans;
> > +	struct virtio_vsock_buf *buf;
> >  	struct sock *sk = &vsk->sk;
> >  	bool remove_sock = true;
> >  
> >  	lock_sock(sk);
> >  	if (sk->sk_type == SOCK_STREAM)
> >  		remove_sock = virtio_transport_close(vsk);
> > +	while (!list_empty(&vvs->rx_queue)) {
> > +		buf = list_first_entry(&vvs->rx_queue,
> > +				       struct virtio_vsock_buf, list);
> 
> Please use list_for_each_entry_safe().

Thanks for the review, I'll change it in the v3.

Cheers,
Stefano

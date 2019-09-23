From: Matias Ezequiel Vara Larsen <matiasevara@gmail.com>
Subject: Re: [RFC] VSOCK: add support for MSG_PEEK
Date: Mon, 23 Sep 2019 19:16:26 +0000
Message-ID: <20190923191626.GA2342__8932.36832214228$1569266204$gmane$org@scw-93ddc8.cloud.online.net>
References: <1569174507-15267-1-git-send-email-matiasevara@gmail.com>
	<20190923075830.a6sjwffnkljmyyqm@steredhat>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190923075830.a6sjwffnkljmyyqm@steredhat>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 23, 2019 at 09:58:30AM +0200, Stefano Garzarella wrote:
> Hi Matias,
> thanks for this patch!
> 
> Since this patch only concerns virtio_transport,
> I'd use the 'vsock/virtio' prefix in the commit title:
> "vsock/virtio: add support for MSG_PEEK"
> 
> Some comments below:
> 
> On Sun, Sep 22, 2019 at 05:48:27PM +0000, Matias Ezequiel Vara Larsen wrote:
> > This patch adds support for MSG_PEEK. In such a case, packets are not
> > removed from the rx_queue and credit updates are not sent.
> > 
> > Signed-off-by: Matias Ezequiel Vara Larsen <matiasevara@gmail.com>
> > ---
> >  net/vmw_vsock/virtio_transport_common.c | 59 +++++++++++++++++++++++++++++++--
> >  1 file changed, 56 insertions(+), 3 deletions(-)
> > 
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index 94cc0fa..830e890 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -264,6 +264,59 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk,
> >  }
> >  
> >  static ssize_t
> > +virtio_transport_stream_do_peek(struct vsock_sock *vsk,
> > +				struct msghdr *msg,
> > +				size_t len)
> > +{
> > +	struct virtio_vsock_sock *vvs = vsk->trans;
> > +	struct virtio_vsock_pkt *pkt;
> > +	size_t bytes, off = 0, total = 0;
> > +	int err = -EFAULT;
> > +
> > +	spin_lock_bh(&vvs->rx_lock);
> > +
> 
> What about using list_for_each_entry() to cycle through the queued packets?
> 
> > +	if (list_empty(&vvs->rx_queue)) {
> > +		spin_unlock_bh(&vvs->rx_lock);
> > +		return 0;
> > +	}
> > +
> > +	pkt = list_first_entry(&vvs->rx_queue,
> > +			       struct virtio_vsock_pkt, list);
> > +	do {
> 
> pkt->off contains the offset inside the packet where the unread data starts.
> So here we should initialize 'off':
> 
> 		off = pkt->off;
> 
> Or just use pkt->off later (without increasing it as in the dequeue).
> 
> > +		bytes = len - total;
> > +		if (bytes > pkt->len - off)
> > +			bytes = pkt->len - off;
> > +
> > +		/* sk_lock is held by caller so no one else can dequeue.
> > +		 * Unlock rx_lock since memcpy_to_msg() may sleep.
> > +		 */
> > +		spin_unlock_bh(&vvs->rx_lock);
> > +
> > +		err = memcpy_to_msg(msg, pkt->buf + off, bytes);
> > +		if (err)
> > +			goto out;
> > +
> > +		spin_lock_bh(&vvs->rx_lock);
> > +
> > +		total += bytes;
> 
> Using list_for_each_entry(), here we can just do:
> (or better, at the beginning of the cycle)
> 
> 		if (total == len)
> 			break;
> 
> removing the next part...
> 
> > +		off += bytes;
> > +		if (off == pkt->len) {
> > +			pkt = list_next_entry(pkt, list);
> > +			off = 0;
> > +		}
> > +	} while ((total < len) && !list_is_first(&pkt->list, &vvs->rx_queue));
> 
> ...until here.
> 
> > +
> > +	spin_unlock_bh(&vvs->rx_lock);
> > +
> > +	return total;
> > +
> > +out:
> > +	if (total)
> > +		err = total;
> > +	return err;
> > +}
> > +
> > +static ssize_t
> >  virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> >  				   struct msghdr *msg,
> >  				   size_t len)
> > @@ -330,9 +383,9 @@ virtio_transport_stream_dequeue(struct vsock_sock *vsk,
> >  				size_t len, int flags)
> >  {
> >  	if (flags & MSG_PEEK)
> > -		return -EOPNOTSUPP;
> > -
> > -	return virtio_transport_stream_do_dequeue(vsk, msg, len);
> > +		return virtio_transport_stream_do_peek(vsk, msg, len);
> > +	else
> > +		return virtio_transport_stream_do_dequeue(vsk, msg, len);
> >  }
> >  EXPORT_SYMBOL_GPL(virtio_transport_stream_dequeue);
> >  
> 
> The rest looks good to me!
> 
> Thanks,
> Stefano
Thanks Stefano. Based on your comments, I will modify the patch and
resubmit it.

Matias

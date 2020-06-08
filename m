From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH RFC v5 12/13] vhost/vsock: switch to the buf API
Date: Mon, 8 Jun 2020 18:26:08 +0200
Message-ID: <20200608162608.gk2fpebujpvmkzpc@steredhat>
References: <20200607141057.704085-1-mst@redhat.com>
 <20200607141057.704085-13-mst@redhat.com>
 <20200608101746.xnxtwwygolsk7yol@steredhat>
 <20200608092953-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200608092953-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, eperezma@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 08, 2020 at 09:30:38AM -0400, Michael S. Tsirkin wrote:
> On Mon, Jun 08, 2020 at 12:17:46PM +0200, Stefano Garzarella wrote:
> > On Sun, Jun 07, 2020 at 10:11:49AM -0400, Michael S. Tsirkin wrote:
> > > A straight-forward conversion.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  drivers/vhost/vsock.c | 30 ++++++++++++++++++------------
> > >  1 file changed, 18 insertions(+), 12 deletions(-)
> > 
> > The changes for vsock part LGTM:
> > 
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > 
> > I also did some tests with vhost-vsock (tools/testing/vsock/vsock_test
> > and iperf-vsock), so for vsock:
> > 
> > Tested-by: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > Thanks,
> > Stefano
> 
> Re-testing v6 would be very much appreciated.

Sure, I'm building v6 now and I'll send you a feedback :-)

Stefano

> 
> > > 
> > > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > > index a483cec31d5c..61c6d3dd2ae3 100644
> > > --- a/drivers/vhost/vsock.c
> > > +++ b/drivers/vhost/vsock.c
> > > @@ -103,7 +103,8 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> > >  		unsigned out, in;
> > >  		size_t nbytes;
> > >  		size_t iov_len, payload_len;
> > > -		int head;
> > > +		struct vhost_buf buf;
> > > +		int ret;
> > >  
> > >  		spin_lock_bh(&vsock->send_pkt_list_lock);
> > >  		if (list_empty(&vsock->send_pkt_list)) {
> > > @@ -117,16 +118,17 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> > >  		list_del_init(&pkt->list);
> > >  		spin_unlock_bh(&vsock->send_pkt_list_lock);
> > >  
> > > -		head = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
> > > -					 &out, &in, NULL, NULL);
> > > -		if (head < 0) {
> > > +		ret = vhost_get_avail_buf(vq, &buf,
> > > +					  vq->iov, ARRAY_SIZE(vq->iov),
> > > +					  &out, &in, NULL, NULL);
> > > +		if (ret < 0) {
> > >  			spin_lock_bh(&vsock->send_pkt_list_lock);
> > >  			list_add(&pkt->list, &vsock->send_pkt_list);
> > >  			spin_unlock_bh(&vsock->send_pkt_list_lock);
> > >  			break;
> > >  		}
> > >  
> > > -		if (head == vq->num) {
> > > +		if (!ret) {
> > >  			spin_lock_bh(&vsock->send_pkt_list_lock);
> > >  			list_add(&pkt->list, &vsock->send_pkt_list);
> > >  			spin_unlock_bh(&vsock->send_pkt_list_lock);
> > > @@ -186,7 +188,8 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> > >  		 */
> > >  		virtio_transport_deliver_tap_pkt(pkt);
> > >  
> > > -		vhost_add_used(vq, head, sizeof(pkt->hdr) + payload_len);
> > > +		buf.in_len = sizeof(pkt->hdr) + payload_len;
> > > +		vhost_put_used_buf(vq, &buf);
> > >  		added = true;
> > >  
> > >  		pkt->off += payload_len;
> > > @@ -440,7 +443,8 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
> > >  	struct vhost_vsock *vsock = container_of(vq->dev, struct vhost_vsock,
> > >  						 dev);
> > >  	struct virtio_vsock_pkt *pkt;
> > > -	int head, pkts = 0, total_len = 0;
> > > +	int ret, pkts = 0, total_len = 0;
> > > +	struct vhost_buf buf;
> > >  	unsigned int out, in;
> > >  	bool added = false;
> > >  
> > > @@ -461,12 +465,13 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
> > >  			goto no_more_replies;
> > >  		}
> > >  
> > > -		head = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
> > > -					 &out, &in, NULL, NULL);
> > > -		if (head < 0)
> > > +		ret = vhost_get_avail_buf(vq, &buf,
> > > +					  vq->iov, ARRAY_SIZE(vq->iov),
> > > +					  &out, &in, NULL, NULL);
> > > +		if (ret < 0)
> > >  			break;
> > >  
> > > -		if (head == vq->num) {
> > > +		if (!ret) {
> > >  			if (unlikely(vhost_enable_notify(&vsock->dev, vq))) {
> > >  				vhost_disable_notify(&vsock->dev, vq);
> > >  				continue;
> > > @@ -494,7 +499,8 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
> > >  			virtio_transport_free_pkt(pkt);
> > >  
> > >  		len += sizeof(pkt->hdr);
> > > -		vhost_add_used(vq, head, len);
> > > +		buf.in_len = len;
> > > +		vhost_put_used_buf(vq, &buf);
> > >  		total_len += len;
> > >  		added = true;
> > >  	} while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
> > > -- 
> > > MST
> > > 
> 

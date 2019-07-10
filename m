From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC] virtio-net: share receive_*() and add_recvbuf_*() with
	virtio-vsock
Date: Wed, 10 Jul 2019 17:37:07 +0200
Message-ID: <20190710153707.twmzgmwqqw3pstos__893.790372514047$1562773399$gmane$org@steredhat>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,
as Jason suggested some months ago, I looked better at the virtio-net driver to
understand if we can reuse some parts also in the virtio-vsock driver, since we
have similar challenges (mergeable buffers, page allocation, small
packets, etc.).

Initially, I would add the skbuff in the virtio-vsock in order to re-use
receive_*() functions.
Then I would move receive_[small, big, mergeable]() and
add_recvbuf_[small, big, mergeable]() outside of virtio-net driver, in order to
call them also from virtio-vsock. I need to do some refactoring (e.g. leave the
XDP part on the virtio-net driver), but I think it is feasible.

The idea is to create a virtio-skb.[h,c] where put these functions and a new
object where stores some attributes needed (e.g. hdr_len ) and status (e.g.
some fields of struct receive_queue). This is an idea of virtio-skb.h that
I have in mind:
    struct virtskb;

    struct sk_buff *virtskb_receive_small(struct virtskb *vs, ...);
    struct sk_buff *virtskb_receive_big(struct virtskb *vs, ...);
    struct sk_buff *virtskb_receive_mergeable(struct virtskb *vs, ...);

    int virtskb_add_recvbuf_small(struct virtskb*vs, ...);
    int virtskb_add_recvbuf_big(struct virtskb *vs, ...);
    int virtskb_add_recvbuf_mergeable(struct virtskb *vs, ...);

For the Guest->Host path it should be easier, so maybe I can add a
"virtskb_send(struct virtskb *vs, struct sk_buff *skb)" with a part of the code
of xmit_skb().

Let me know if you have in mind better names or if I should put these function
in another place.

I would like to leave the control part completely separate, so, for example,
the two drivers will negotiate the features independently and they will call
the right virtskb_receive_*() function based on the negotiation.

I already started to work on it, but before to do more steps and send an RFC
patch, I would like to hear your opinion.
Do you think that makes sense?
Do you see any issue or a better solution?

Thanks in advance,
Stefano

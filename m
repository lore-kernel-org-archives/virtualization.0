From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [bug report] virtio_net: rework mergeable buffer handling
Date: Fri, 2 Jun 2017 18:35:39 +0300
Message-ID: <20170602183107-mutt-send-email-mst@kernel.org>
References: <20170406052949.GA26854@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170406052949.GA26854@mwanda>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 06, 2017 at 08:29:49AM +0300, Dan Carpenter wrote:
> Hello Michael S. Tsirkin,
> 
> The patch 6c8e5f3c41c8: "virtio_net: rework mergeable buffer
> handling" from Mar 6, 2017, leads to the following static checker
> warning:
> 
> 	drivers/net/virtio_net.c:1042 virtnet_receive()
> 	error: uninitialized symbol 'ctx'.
> 
> drivers/net/virtio_net.c
>   1030  static int virtnet_receive(struct receive_queue *rq, int budget)
>   1031  {
>   1032          struct virtnet_info *vi = rq->vq->vdev->priv;
>   1033          unsigned int len, received = 0, bytes = 0;
>   1034          void *buf;
>   1035          struct virtnet_stats *stats = this_cpu_ptr(vi->stats);
>   1036  
>   1037          if (vi->mergeable_rx_bufs) {
>   1038                  void *ctx;
>                               ^^^
>   1039  
>   1040                  while (received < budget &&
>   1041                         (buf = virtqueue_get_buf_ctx(rq->vq, &len, &ctx))) {
>                                                                            ^^^^
>   1042                          bytes += receive_buf(vi, rq, buf, len, ctx);
>                                                                        ^^^
> 
> It's possible that this code is correct, but I looked at it and wasn't
> immediately convinced.  Returning non-NULL buf is not sufficient to
> show that "ctx" is initialized, because if it's vq->indirect then "buf"
> is still unintialized.  Also it's possible that receive_buf() checks
> vq->indirect through some side effect way that I didn't see so it
> doesn't use the uninitialized value...
> 
> I feel like if this is a false positive, that means the rules are too
> subtle...  :/

Yes, false positive I think.

What happens is this: __vring_new_virtqueue does:
        vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
                !context;

so indirect is never set with context.

Adding code comments should help - could you take a stub at it?


>   1043                          received++;
>   1044                  }
>   1045          } else {
>   1046                  while (received < budget &&
>   1047                         (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
>   1048                          bytes += receive_buf(vi, rq, buf, len, NULL);
>   1049                          received++;
>   1050                  }
>   1051          }
>   1052  
> 
> regards,
> dan carpenter

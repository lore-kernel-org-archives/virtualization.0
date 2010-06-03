From: "Bruce Rogers" <brogers@novell.com>
Subject: [PATCH 1/3][STABLE] KVM: fix delayed refill checking
Date: Thu, 03 Jun 2010 16:26:12 -0600
Message-ID: <4C07D7A40200004800097501@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: virtualization@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Please consider this for the 2.6.32 stable tree:

commit 39d321577405e8e269fd238b278aaf2425fa788a
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Mon Jan 25 15:51:01 2010 -0800

    virtio_net: Make delayed refill more reliable

    I have seen RX stalls on a machine that experienced a suspected
    OOM.  After the stall, the RX buffer is empty on the guest side
    and there are exactly 16 entries available on the host side.  As
    the number of entries is less than that required by a maximal
    skb, the host cannot proceed.

    The guest did not have a refill job scheduled.

    My diagnosis is that an OOM had occured, with the delayed refill
    job scheduled.  The job was able to allocate at least one skb, but
    not enough to overcome the minimum required by the host to proceed.

    As the refill job would only reschedule itself if it failed completely
    to allocate any skbs, this would lead to an RX stall.

    The following patch removes this stall possibility by always
    rescheduling the refill job until the ring is totally refilled.

    Testing has shown that the RX stall no longer occurs whereas
    previously it would occur within a day.

    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
    Acked-by: Rusty Russell <rusty@rustcorp.com.au>
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c708ecc..9ead30b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -395,8 +395,7 @@ static void refill_work(struct work_struct *work)

        vi = container_of(work, struct virtnet_info, refill.work);
        napi_disable(&vi->napi);
-       try_fill_recv(vi, GFP_KERNEL);
-       still_empty = (vi->num == 0);
+       still_empty = !try_fill_recv(vi, GFP_KERNEL);
        napi_enable(&vi->napi);

        /* In theory, this can happen: if we don't get any buffers in

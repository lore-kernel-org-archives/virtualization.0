From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] vhost: fix IOTLB locking
Date: Mon, 03 Dec 2018 15:53:17 -0800 (PST)
Message-ID: <20181203.155317.2179703794307611009.davem__20273.6452142291$1543881075$gmane$org@davemloft.net>
References: <20181130160553.9739-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181130160553.9739-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jean-philippe.brucker@arm.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Date: Fri, 30 Nov 2018 16:05:53 +0000

> Commit 78139c94dc8c ("net: vhost: lock the vqs one by one") moved the vq
> lock to improve scalability, but introduced a possible deadlock in
> vhost-iotlb. vhost_iotlb_notify_vq() now takes vq->mutex while holding
> the device's IOTLB spinlock. And on the vhost_iotlb_miss() path, the
> spinlock is taken while holding vq->mutex.
> 
> Since calling vhost_poll_queue() doesn't require any lock, avoid the
> deadlock by not taking vq->mutex.
> 
> Fixes: 78139c94dc8c ("net: vhost: lock the vqs one by one")
> Acked-by: Jason Wang <jasowang@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Applied, thank you.

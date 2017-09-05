From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net V2] vhost_net: correctly check tx avail during rx
	busy polling
Date: Tue, 05 Sep 2017 14:48:04 -0700 (PDT)
Message-ID: <20170905.144804.755338183074090970.davem__14606.3703265556$1504648135$gmane$org@davemloft.net>
References: <1504574525-4711-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1504574525-4711-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jasowang@redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Tue,  5 Sep 2017 09:22:05 +0800

> We check tx avail through vhost_enable_notify() in the past which is
> wrong since it only checks whether or not guest has filled more
> available buffer since last avail idx synchronization which was just
> done by vhost_vq_avail_empty() before. What we really want is checking
> pending buffers in the avail ring. Fix this by calling
> vhost_vq_avail_empty() instead.
> 
> This issue could be noticed by doing netperf TCP_RR benchmark as
> client from guest (but not host). With this fix, TCP_RR from guest to
> localhost restores from 1375.91 trans per sec to 55235.28 trans per
> sec on my laptop (Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz).
> 
> Fixes: 030881372460 ("vhost_net: basic polling support")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied and queued up for -stable, thanks.

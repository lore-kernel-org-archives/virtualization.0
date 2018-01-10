From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] vhost_net: batch used ring update in rx
Date: Wed, 10 Jan 2018 15:04:50 -0500 (EST)
Message-ID: <20180110.150450.1379438704417696171.davem@davemloft.net>
References: <1515493665-35306-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1515493665-35306-1-git-send-email-jasowang@redhat.com>
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
Cc: willemb@google.com, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Tue,  9 Jan 2018 18:27:45 +0800

> This patch tries to batched used ring update during RX. This is pretty
> fit for the case when guest is much faster (e.g dpdk based
> backend). In this case, used ring is almost empty:
> 
> - we may get serious cache line misses/contending on both used ring
>   and used idx.
> - at most 1 packet could be dequeued at one time, batching in guest
>   does not make much effect.
> 
> Update used ring in a batch can help since guest won't access the used
> ring until used idx was advanced for several descriptors and since we
> advance used ring for every N packets, guest will only need to access
> used idx for every N packet since it can cache the used idx. To have a
> better interaction for both batch dequeuing and dpdk batching,
> VHOST_RX_BATCH was used as the maximum number of descriptors that
> could be batched.
> 
> Test were done between two machines with 2.40GHz Intel(R) Xeon(R) CPU
> E5-2630 connected back to back through ixgbe. Traffic were generated
> on one remote ixgbe through MoonGen and measure the RX pps through
> testpmd in guest when do xdp_redirect_map from local ixgbe to
> tap. RX pps were increased from 3.05 Mpps to 4.00 Mpps (about 31%
> improvement).
> 
> One possible concern for this is the implications for TCP (especially
> latency sensitive workload). Result[1] does not show obvious changes
> for most of the netperf test (RR, TX, and RX). And we do get some
> improvements for RX on some specific size.
 ...
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied, thanks Jason.

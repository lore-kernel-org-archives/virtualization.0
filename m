From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 net-next] virtio_net: Add ethtool stats
Date: Mon, 22 Jan 2018 15:25:51 -0500 (EST)
Message-ID: <20180122.152551.785701430717306186.davem__41703.8728287027$1516652656$gmane$org@davemloft.net>
References: <1516171105-2483-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1516171105-2483-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: makita.toshiaki@lab.ntt.co.jp
Cc: f.fainelli@gmail.com, mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Date: Wed, 17 Jan 2018 15:38:25 +0900

> The main purpose of this patch is adding a way of checking per-queue stats.
> It's useful to debug performance problems on multiqueue environment.
> 
> $ ethtool -S ens10
> NIC statistics:
>      rx_queue_0_packets: 2090408
>      rx_queue_0_bytes: 3164825094
>      rx_queue_1_packets: 2082531
>      rx_queue_1_bytes: 3152932314
>      tx_queue_0_packets: 2770841
>      tx_queue_0_bytes: 4194955474
>      tx_queue_1_packets: 3084697
>      tx_queue_1_bytes: 4670196372
> 
> This change converts existing per-cpu stats structure into per-queue one.
> This should not impact on performance since each queue counter is not
> updated concurrently by multiple cpus.
> 
> Performance numbers:
>  - Guest has 2 vcpus and 2 queues
>  - Guest runs netserver
>  - Host runs 100-flow super_netperf
> 
>                      Before      After       Diff
> UDP_STREAM 18byte        86.22       87.00   +0.90%
> UDP_STREAM 1472byte    4055.27     4042.18   -0.32%
> TCP_STREAM            16956.32    16890.63   -0.39%
> UDP_RR               178667.11   185862.70   +4.03%
> TCP_RR               128473.04   124985.81   -2.71%
> 
> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> ---
> v2:
> - Removed redundant counters which can be obtained from dev_get_stats.
> - Made queue counter structure different for tx and rx so they can be
>   easily extended separately, as some additional counters are expected
>   like XDP related ones and VM-Exit event.
> - Added performance numbers in commitlog.

Applied, thanks.

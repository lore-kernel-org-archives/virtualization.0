From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: Re: [PATCH] virtio_net: add local_bh_disable() around
	u64_stats_update_begin
Date: Thu, 18 Oct 2018 18:06:57 +0900
Message-ID: <0dce3017-9973-af2d-f324-6fe8b5eb5469@lab.ntt.co.jp>
References: <20181016165545.guksrl23ulcudxrk@linutronix.de>
	<20181016110114.73e2b248@xeon-e3>
	<20181016184206.coukhtgmlr32hyl7@linutronix.de>
	<20181016114414.23ea73c3@xeon-e3>
	<20181018084313.oopu34iwfwgkcwwc@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181018084313.oopu34iwfwgkcwwc@linutronix.de>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, tglx@linutronix.de, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On 2018/10/18 17:43, Sebastian Andrzej Siewior wrote:
> on 32bit, lockdep notices that virtnet_open() and refill_work() invoke
> try_fill_recv() from process context while virtnet_receive() invokes the
> same function from BH context. The problem that the seqcounter within
> u64_stats_update_begin() may deadlock if it is interrupted by BH and
> then acquired again.
> 
> Introduce u64_stats_update_begin_bh() which disables BH on 32bit
> architectures. Since the BH might interrupt the worker, this new
> function should not limited to SMP like the others which are expected
> to be used in softirq.
> 
> With this change we might lose increments but this is okay. The
> important part that the two 32bit parts of the 64bit counter are not
> corrupted.
> 
> Fixes: 461f03dc99cf6 ("virtio_net: Add kick stats").
> Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

NACK. Again, this race should not happen because of NAPI guard.
We need to investigate why this warning happened.

-- 
Toshiaki Makita

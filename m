From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] virtio_net: add local_bh_disable() around
	u64_stats_update_begin
Date: Thu, 18 Oct 2018 16:23:08 -0700 (PDT)
Message-ID: <20181018.162308.2295937118791060714.davem@davemloft.net>
References: <20181016184206.coukhtgmlr32hyl7@linutronix.de>
	<20181016114414.23ea73c3@xeon-e3>
	<20181018084313.oopu34iwfwgkcwwc@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181018084313.oopu34iwfwgkcwwc@linutronix.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: bigeasy@linutronix.de
Cc: mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Thu, 18 Oct 2018 10:43:13 +0200

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

Trying to get down to the bottom of this:

1) virtnet_receive() runs from softirq but only if NAPI is active and
   enabled.  It is in this context that it invokes try_fill_recv().

2) refill_work() runs from process context, but disables NAPI (and
   thus invocation of virtnet_receive()) before calling
   try_fill_recv().

3) virtnet_open() invokes from process context as well, but before the
   NAPI instances are enabled, it is same as case #2.

4) virtnet_restore_up() is the same situations as #3.

Therefore I agree that this is a false positive, and simply lockdep
cannot see the NAPI synchronization done by case #2.

I think we shouldn't add unnecessary BH disabling here, and instead
find some way to annotate this for lockdep's sake.

Thank you.

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] virtio_net: add local_bh_disable() around
	u64_stats_update_begin
Date: Thu, 18 Oct 2018 11:11:14 +0200
Message-ID: <20181018091114.jqiedzds2bqezxtb__49669.9322284714$1539853757$gmane$org@linutronix.de>
References: <20181016165545.guksrl23ulcudxrk@linutronix.de>
	<20181016110114.73e2b248@xeon-e3>
	<20181016184206.coukhtgmlr32hyl7@linutronix.de>
	<20181016114414.23ea73c3@xeon-e3>
	<20181018084313.oopu34iwfwgkcwwc@linutronix.de>
	<0dce3017-9973-af2d-f324-6fe8b5eb5469@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <0dce3017-9973-af2d-f324-6fe8b5eb5469@lab.ntt.co.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, tglx@linutronix.de, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On 2018-10-18 18:06:57 [+0900], Toshiaki Makita wrote:
> NACK. Again, this race should not happen because of NAPI guard.
> We need to investigate why this warning happened.

I tried to explain this. Please see
	20181018090812.rry5qgnqxxrjxaii@linutronix.de

Sebastian

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC] virtio_net: add local_bh_disable() around
	u64_stats_update_begin
Date: Tue, 16 Oct 2018 20:21:48 +0200
Message-ID: <20181016182148.xjitjrh2g3kzapqt@linutronix.de>
References: <20181016165545.guksrl23ulcudxrk@linutronix.de>
	<20181016105930.55e8fe5d@xeon-e3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181016105930.55e8fe5d@xeon-e3>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, tglx@linutronix.de, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On 2018-10-16 10:59:30 [-0700], Stephen Hemminger wrote:
> Since there already is u64_stats_update_begin_irqsave inline, why not introduce
> u64_stats_update_begin_bh which encapsulates the local_bh_disable

CPU0				CPU1
refill_work()			virtnet_receive()
 try_fill_recv()		 try_fill_recv()
  u64_stats_update_begin_bh()	  u64_stats_update_begin_bh()

both CPUs may operate on the `rq'.

Sebastian

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC] virtio_net: add local_bh_disable() around
	u64_stats_update_begin
Date: Tue, 16 Oct 2018 20:42:07 +0200
Message-ID: <20181016184206.coukhtgmlr32hyl7__9178.15695652298$1539715210$gmane$org@linutronix.de>
References: <20181016165545.guksrl23ulcudxrk@linutronix.de>
	<20181016110114.73e2b248@xeon-e3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181016110114.73e2b248@xeon-e3>
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

On 2018-10-16 11:01:14 [-0700], Stephen Hemminger wrote:
> On Tue, 16 Oct 2018 18:55:45 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > Also, ptr->var++ is not an atomic operation even on 64bit CPUs. Which
> > means if try_fill_recv() runs on CPU0 (via virtnet_receive()) then the
> > worker might run on CPU1.
> 
> On modern CPU's increment of native types is atomic but not locked.
> u64_stats_update_begin is a no-op on UP and also if BIT_PER_LONG != 32

On ARM64 you have load, inc, store. So if two CPUs increment the counter
simultaneously we might lose one increment. That is why I asked if we
care or not.

Sebastian

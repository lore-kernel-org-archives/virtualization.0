From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [RFC] virtio_net: add local_bh_disable() around
	u64_stats_update_begin
Date: Tue, 16 Oct 2018 11:44:14 -0700
Message-ID: <20181016114414.23ea73c3__8316.78338950059$1539715335$gmane$org@xeon-e3>
References: <20181016165545.guksrl23ulcudxrk@linutronix.de>
	<20181016110114.73e2b248@xeon-e3>
	<20181016184206.coukhtgmlr32hyl7@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181016184206.coukhtgmlr32hyl7@linutronix.de>
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

On Tue, 16 Oct 2018 20:42:07 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2018-10-16 11:01:14 [-0700], Stephen Hemminger wrote:
> > On Tue, 16 Oct 2018 18:55:45 +0200
> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >   
> > > Also, ptr->var++ is not an atomic operation even on 64bit CPUs. Which
> > > means if try_fill_recv() runs on CPU0 (via virtnet_receive()) then the
> > > worker might run on CPU1.  
> > 
> > On modern CPU's increment of native types is atomic but not locked.
> > u64_stats_update_begin is a no-op on UP and also if BIT_PER_LONG != 32  
> 
> On ARM64 you have load, inc, store. So if two CPUs increment the counter
> simultaneously we might lose one increment. That is why I asked if we
> care or not.
> 
> Sebastian

The point is that kicks is just a counter, not important as part of the
device operation. The point of the u64_stats is to avoid problems with
high/low 32 bit wrap on increment. So this is ok on ARM64.

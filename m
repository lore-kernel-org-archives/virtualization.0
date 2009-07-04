From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/4] net: skb_orphan on dev_hard_start_xmit
Date: Fri, 03 Jul 2009 20:13:47 -0700 (PDT)
Message-ID: <20090703.201347.146036232.davem__31721.2477945306$1246677262$gmane$org@davemloft.net>
References: <20090703075530.GA25190@gondor.apana.org.au>
	<20090703.200254.172991821.davem@davemloft.net>
	<20090704030830.GA32442@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090704030830.GA32442@gondor.apana.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: herbert@gondor.apana.org.au
Cc: patrick.ohly@intel.com, libertas-dev@lists.infradead.org, dcbw@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, rolandd@cisco.com, divy@chelsio.com, xemul@openvz.org
List-Id: virtualization@lists.linuxfoundation.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sat, 4 Jul 2009 11:08:30 +0800

> On Fri, Jul 03, 2009 at 08:02:54PM -0700, David Miller wrote:
>>
>> In particular the case of handling a device without usable TX
>> completion event indications is still quite troublesome.
> e
> Which particular devices do you have in mind?

NIU

I basically can't defer interrupts because the chip supports
per-TX-desc interrupt indications but it lacks an "all TX queue sent"
event.  So if, say, tell it to interrupt every 1/4 of the TX queue
then up to 1/4 of the queue can have packets "stuck" in there
if TX activity all of a sudden ceases.

The only thing I've come up with to be able to mitigate interrupts is
to use an hrtimer of some sort.  But that's going to be hard to get
right, and who knows what kind of latencies will be introduced for TX
completion packet freeing unless I am very carefull.

And finally this belongs in generic code, not in the NIU driver,
whatever we come up with.  Especially since my understanding is that
this is similar to what Rusty needs.

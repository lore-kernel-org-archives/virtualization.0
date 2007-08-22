From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: bug in virtio network driver?
Date: Wed, 22 Aug 2007 13:08:39 +1000
Message-ID: <1187752119.6174.7.camel@localhost.localdomain>
References: <200708211048.33534.borntraeger@de.ibm.com>
	<1187687377.19435.176.camel@localhost.localdomain>
	<200708211706.29676.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200708211706.29676.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-08-21 at 17:06 +0200, Arnd Bergmann wrote:
> On Tuesday 21 August 2007, Rusty Russell wrote:
> > > One solution would be to use the xmit_done interrupt. Unfortunately this would 
> > > require additional locking as multiple interrupts can happen at two or more 
> > > cpus. Do you have any better ideas?
> > 
> > The only reason that we don't do it in skb_xmit_done() is because
> > kfree_skb() isn't supposed to be called from an interrupt.  But there's
> > dev_kfree_skb_any() which can be used.
> 
> That will simply trigger a softirq, right? If you need the softirq anyway,
> why not do all the tx handling in the poll() method like other drivers?

That would work, too.  It seems a little non-obvious to me to trigger
poll when a packet has been transmitted, but if that's the Standard I'll
follow.

Cheers,
Rusty.

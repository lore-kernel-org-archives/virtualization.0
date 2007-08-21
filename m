From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: bug in virtio network driver?
Date: Tue, 21 Aug 2007 19:09:37 +1000
Message-ID: <1187687377.19435.176.camel__15936.1352016733$1187687560$gmane$org@localhost.localdomain>
References: <200708211048.33534.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200708211048.33534.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm-devel@lists.sourceforge.net, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-08-21 at 10:48 +0200, Christian Borntraeger wrote:
> Hello Rusty,
> 
> I think I have found a problem in the virtio network driver. virtio_net 
> reclaims sent skbs on xmit. That means that there is always one skb 
> outstanding and the netdev packet statistic is always one packet to low.

Hi Christian,

	Good catch!

> One solution would be to use the xmit_done interrupt. Unfortunately this would 
> require additional locking as multiple interrupts can happen at two or more 
> cpus. Do you have any better ideas?

The only reason that we don't do it in skb_xmit_done() is because
kfree_skb() isn't supposed to be called from an interrupt.  But there's
dev_kfree_skb_any() which can be used.

Cheers,
Rusty.

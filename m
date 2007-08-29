From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: bug in virtio network driver?
Date: Thu, 30 Aug 2007 07:07:20 +1000
Message-ID: <1188421640.5531.141.camel__38407.4868671179$1188421810$gmane$org@localhost.localdomain>
References: <200708211048.33534.borntraeger@de.ibm.com>
	<1187687377.19435.176.camel@localhost.localdomain>
	<200708211802.04103.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200708211802.04103.borntraeger@de.ibm.com>
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
Cc: kvm-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-08-21 at 18:02 +0200, Christian Borntraeger wrote:
> Am Dienstag, 21. August 2007 schrieb Rusty Russell:
> > The only reason that we don't do it in skb_xmit_done() is because
> > kfree_skb() isn't supposed to be called from an interrupt.  But there's
> > dev_kfree_skb_any() which can be used.
> 
> Ok, I now hacked something that works but I really dont like the 
> local_irq_disable bits. I sent this patch nevertheless, but I will look into 
> Arnds suggestion.

Hi Christian,

	What's the status of this?  Should I apply this patch, or do you want
me to wait for a ->poll patch as per Arnd's suggestion?

Rusty.

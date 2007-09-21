From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH 3/6] virtio net driver
Date: Fri, 21 Sep 2007 21:53:35 +1000
Message-ID: <1190375615.27805.9.camel__33816.849513869$1190375769$gmane$org@localhost.localdomain>
References: <1190289808.7262.223.camel@localhost.localdomain>
	<1190290369.7262.231.camel@localhost.localdomain>
	<1190290495.7262.235.camel@localhost.localdomain>
	<200709211248.11783.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200709211248.11783.borntraeger@de.ibm.com>
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
Cc: kvm-devel@lists.sourceforge.net, lguest <lguest@ozlabs.org>, Herbert Xu <herbert@gondor.apana.org.au>, Jeff Garzik <jeff@garzik.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-09-21 at 12:48 +0200, Christian Borntraeger wrote:
> Am Donnerstag, 20. September 2007 schrieb Rusty Russell:
> > The network driver uses *two* virtqueues: one for input packets and
> > one for output packets.  This has nice locking properties (ie. we
> > don't do any for recv vs send).
> [...]
> > 	3) Resolve freeing of old xmit skbs (someone sent patch IIRC?)
> 
> Yes, that was me. I am quite busy at the moment but I will send a refreshed 
> patch soon. The most annoying fact of my current patch is, that I have to add 
> locking. (Because of the only one operation per virtqueue at a time rule)

Sorry Christian, I thought it was you but was in a hurry to send out the
patches so didn't go back and check.

Can't we just re-use the default xmit lock?

> [...]
> > +struct virtnet_info
> > +{
> > +	struct virtqueue_ops *vq_ops;
> > +	struct virtqueue *vq_recv;
> > +	struct virtqueue *vq_send;
> > +	struct net_device *ndev;
> 
> This is only a matter of taste, but I like netdev or dev more than ndev.

Yeah, I agreed.  It was a moment of weakness: I've renamed it to "dev".

Thanks!
Rusty.

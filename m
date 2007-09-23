From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH 3/6] virtio net driver
Date: Sun, 23 Sep 2007 17:13:50 +1000
Message-ID: <1190531630.27805.106.camel__32248.4534852721$1190531863$gmane$org@localhost.localdomain>
References: <1190289808.7262.223.camel@localhost.localdomain>
	<200709211436.43964.borntraeger@de.ibm.com>
	<20070921140833.GA12242@gondor.apana.org.au>
	<200709211642.25208.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200709211642.25208.borntraeger@de.ibm.com>
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

On Fri, 2007-09-21 at 16:42 +0200, Christian Borntraeger wrote:
> Am Freitag, 21. September 2007 schrieb Herbert Xu:
> > Please don't use LLTX in new drivers.  We're trying to get rid
> > of it since it's
> > 
> > 1) unnecessary;
> > 2) causes problems with AF_PACKET seeing things twice.
> 
> Ok, but then I cannot reuse the xmit lock in an interrupt handler. Otherwise 
> deadlock can occur because hard_start_xmit has interrupts enabled. 
> 
> Rusty, seems we need an additional lock.

Can we use a tasklet?  Seems like it'd be safe at a glance...

Thanks,
Rusty.

From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [kvm-devel] [PATCH 3/6] virtio net driver
Date: Fri, 21 Sep 2007 16:42:25 +0200
Message-ID: <200709211642.25208.borntraeger__48759.1120916933$1190385923$gmane$org@de.ibm.com>
References: <1190289808.7262.223.camel@localhost.localdomain>
	<200709211436.43964.borntraeger@de.ibm.com>
	<20070921140833.GA12242@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070921140833.GA12242@gondor.apana.org.au>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel@lists.sourceforge.net
Cc: lguest <lguest@ozlabs.org>, Herbert Xu <herbert@gondor.apana.org.au>, Jeff Garzik <jeff@garzik.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Am Freitag, 21. September 2007 schrieb Herbert Xu:
> Please don't use LLTX in new drivers.  We're trying to get rid
> of it since it's
> 
> 1) unnecessary;
> 2) causes problems with AF_PACKET seeing things twice.

Ok, but then I cannot reuse the xmit lock in an interrupt handler. Otherwise 
deadlock can occur because hard_start_xmit has interrupts enabled. 

Rusty, seems we need an additional lock.

Christian

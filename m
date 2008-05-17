From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 2/2] lguest: virtio-rng support
Date: Sat, 17 May 2008 09:43:53 +0200
Message-ID: <200805170943.54031.borntraeger@de.ibm.com>
References: <482C8595.5030509@garzik.org>
	<200805171628.03801.rusty@rustcorp.com.au>
	<20080517064307.GA16857@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080517064307.GA16857@gondor.apana.org.au>
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
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Theodore Tso <tytso@mit.edu>, Jeff Garzik <jeff@garzik.org>, Matt Mackall <mpm@selenic.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, Johannes Berg <johannes@sipsolutions.net>
List-Id: virtualization@lists.linuxfoundation.org

Am Samstag, 17. Mai 2008 schrieb Herbert Xu:
> On Sat, May 17, 2008 at 04:28:03PM +1000, Rusty Russell wrote:
> >
> > But you did not address the DoS question: can we ignore it?  Or are we 
trading 
> > off a DoS in the host against a potential security weakness in the guest?
> 
> Why not do both? Use the host's urandom to make the guest at least
> unpredictable on start-up without increasing the guest's entropy,
> and use the host's random to actually increase the guest's entropy.

I think the proper solution would be to use the hosts /dev/hw_rng - if 
available.

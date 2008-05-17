From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/2] lguest: virtio-rng support
Date: Sat, 17 May 2008 08:56:49 -0700
Message-ID: <482F0041.6070208__45206.1550030068$1211040210$gmane$org@zytor.com>
References: <482C8595.5030509@garzik.org>
	<200805171628.03801.rusty@rustcorp.com.au>
	<20080517064307.GA16857@gondor.apana.org.au>
	<200805170943.54031.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805170943.54031.borntraeger@de.ibm.com>
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
Cc: Theodore Tso <tytso@mit.edu>, Herbert Xu <herbert@gondor.apana.org.au>, Jeff Garzik <jeff@garzik.org>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Matt Mackall <mpm@selenic.com>, Johannes Berg <johannes@sipsolutions.net>
List-Id: virtualization@lists.linuxfoundation.org

Christian Borntraeger wrote:
> I think the proper solution would be to use the hosts /dev/hw_rng - if 
> available.

Not really, no.  The host has access to real entropy in the form of 
hardware timings as well as possibly /dev/hw_rng.

	-hpa

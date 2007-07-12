From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 3/3] Virtio draft IV: the net driver
Date: Wed, 11 Jul 2007 19:26:09 -0700 (PDT)
Message-ID: <20070711.192609.18580123.davem@davemloft.net>
References: <200707111245.40717.borntraeger@de.ibm.com>
	<20070711.134447.39159166.davem@davemloft.net>
	<1184206893.6005.669.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1184206893.6005.669.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: borntraeger@de.ibm.com, cotte@de.ibm.com, herbert@gondor.apana.org.au, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Rusty Russell <rusty@rustcorp.com.au>
Date: Thu, 12 Jul 2007 12:21:33 +1000

> Dave, I think you're the only one (so far?) with multiple irqs.

Luckily there are known hw implementations with that issue
so I won't be weird for long :)

> It's not clear that guest-controlled interrupt mitigation is the best
> approach for virtual devices, but at the moment it doesn't hurt.

It would be nice for consistency's sake, once it is easy to do so.

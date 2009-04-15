From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [Lguest] [PATCH 4/5] lguest: use KVM hypercalls
Date: Wed, 15 Apr 2009 11:07:05 +0200
Message-ID: <200904151107.05949.borntraeger@de.ibm.com>
References: <200903271022.38244.rusty@rustcorp.com.au> <20090415083610.GA8579@gondor.apana.org.au> <20090415084717.GA8829@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20090415084717.GA8829@gondor.apana.org.au>
Content-Disposition: inline
Sender: netdev-owner@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Patrick McHardy <kaber@trash.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Matias Zabaljauregui <zabaljauregui@gmail.com>, odie@cs.aau.dk, Rusty Russell <rusty@rustcorp.com.au>, lguest@ozlabs.org, virtualization@lists.osdl.org, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Am Wednesday 15 April 2009 10:47:17 schrieb Herbert Xu:
> tun: Fix sk_sleep races when attaching/detaching
>
> As the sk_sleep wait queue actually lives in tfile, which may be
> detached from the tun device, bad things will happen when we use
> sk_sleep after detaching.
>
> Since the tun device is the persistent data structure here (when
> requested by the user), it makes much more sense to have the wait
> queue live there.  There is no reason to have it in tfile at all
> since the only time we can wait is if we have a tun attached.
> In fact we already have a wait queue in tun_struct, so we might
> as well use it.
>
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reported-by: Eric W. Biederman <ebiederm@xmission.com>
> Reported-by: Patrick McHardy <kaber@trash.net>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>

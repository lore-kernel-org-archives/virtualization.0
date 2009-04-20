From: David Miller <davem@davemloft.net>
Subject: Re: [2/2] tun: Fix sk_sleep races when attaching/detaching
Date: Mon, 20 Apr 2009 03:02:15 -0700 (PDT)
Message-ID: <20090420.030215.118567197.davem@davemloft.net>
References: <20090420083550.GA2582@gondor.apana.org.au>
	<20090420.022635.57839830.davem@davemloft.net>
	<20090420093549.GA3356@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20090420093549.GA3356@gondor.apana.org.au>
Sender: netdev-owner@vger.kernel.org
To: herbert@gondor.apana.org.au
Cc: ebiederm@xmission.com, kaber@trash.net, zabaljauregui@gmail.com, odie@cs.aau.dk, rusty@rustcorp.com.au, lguest@ozlabs.org, virtualization@lists.osdl.org, netdev@vger.kernel.org, borntraeger@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Mon, 20 Apr 2009 17:35:49 +0800

> On Mon, Apr 20, 2009 at 02:26:35AM -0700, David Miller wrote:
>> 
>> Do you think these two patches are ready to go into net-2.6
>> now?
> 
> I think so.

Great, applied, thanks Herbert.

From: David Miller <davem@davemloft.net>
Subject: Re: [2/2] tun: Fix sk_sleep races when attaching/detaching
Date: Mon, 20 Apr 2009 02:26:35 -0700 (PDT)
Message-ID: <20090420.022635.57839830.davem@davemloft.net>
References: <20090416110818.GA20950@gondor.apana.org.au>
	<20090416110952.GB20950@gondor.apana.org.au>
	<20090420083550.GA2582@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20090420083550.GA2582@gondor.apana.org.au>
Sender: netdev-owner@vger.kernel.org
To: herbert@gondor.apana.org.au
Cc: ebiederm@xmission.com, kaber@trash.net, zabaljauregui@gmail.com, odie@cs.aau.dk, rusty@rustcorp.com.au, lguest@ozlabs.org, virtualization@lists.osdl.org, netdev@vger.kernel.org, borntraeger@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Mon, 20 Apr 2009 16:35:50 +0800

> On Thu, Apr 16, 2009 at 07:09:52PM +0800, Herbert Xu wrote:
>> 
>> tun: Fix sk_sleep races when attaching/detaching
> 
> That patch doesn't apply anymore because of contextual changes
> caused by the first patch.  Here's an update.
> 
> tun: Fix sk_sleep races when attaching/detaching

Do you think these two patches are ready to go into net-2.6
now?

Thanks.

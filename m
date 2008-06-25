From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 4/4] lguest: Use GSO/IFF_VNET_HDR extensions on tun/tap
Date: Thu, 26 Jun 2008 01:45:18 +1000
Message-ID: <200806260145.19058.rusty__15678.9332665086$1214408991$gmane$org@rustcorp.com.au>
References: <200806260028.07883.rusty@rustcorp.com.au>
	<200806260030.38293.rusty@rustcorp.com.au>
	<200806260032.12359.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200806260032.12359.rusty@rustcorp.com.au>
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
To: virtualization@lists.linux-foundation.org
Cc: markmc@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>, Max Krasnyansky <maxk@qualcomm.com>, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 26 June 2008 00:32:12 Rusty Russell wrote:
> (Might not apply cleanly to current Linus, there are other lguest things
>  going on, but this gives you the idea at least).
...
> +	if (ioctl(netfd, TUNSETFEATURES,
> +		  TUN_F_CSUM|TUN_F_TSO4|TUN_F_TSO6|TUN_F_TSO_ECN) != 0)
> +		err(1, "Could not set features for tun device");

This should be TUNSETOFFLOAD of course.  I renamed it at the last minute, 
because TUNSETFEATURES implies symmetry with TUNGETFEATURES, which is 
completely different.

Cheers,
Rusty.

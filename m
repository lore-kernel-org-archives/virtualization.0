From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [PATCH 1/4] tun: Interface to query tun/tap features.
Date: Tue, 01 Jul 2008 21:59:02 -0700
Message-ID: <486B0B16.10205__15258.2319723026$1214974862$gmane$org@qualcomm.com>
References: <200806260028.07883.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200806260028.07883.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: netdev@vger.kernel.org, David Miller <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


Rusty Russell wrote:
> The problem with introducing checksum offload and gso to tun is they
> need to set dev->features to enable GSO and/or checksumming, which is
> supposed to be done before register_netdevice(), ie. as part of
> TUNSETIFF.
> 
> Unfortunately, TUNSETIFF has always just ignored flags it doesn't
> understand, so there's no good way of detecting whether the kernel
> supports new IFF_ flags.
> 
> This patch implements a TUNGETFEATURES ioctl which returns all the valid IFF
> flags.  It could be extended later to include other features.

<snip>

Looks good.

Dave, do you want me to put all outstanding TUN patches into a git tree so
that you can pull them in one shot ?
Otherwise if you're ok with applying them one by one please apply this one.

Acked-by: Max Krasnyansky <maxk@qualcomm.com>

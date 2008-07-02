From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [PATCH 2/4] tun: TUNSETFEATURES to set gso features.
Date: Tue, 01 Jul 2008 22:02:00 -0700
Message-ID: <486B0BC8.4000601__21547.024526126$1214975038$gmane$org@qualcomm.com>
References: <200806260028.07883.rusty@rustcorp.com.au>
	<200806260029.40267.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200806260029.40267.rusty@rustcorp.com.au>
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
Cc: markmc@redhat.com, netdev@vger.kernel.org, David Miller <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



Rusty Russell wrote:
> ethtool is useful for setting (some) device fields, but it's
> root-only.  Finer feature control is available through a tun-specific
> ioctl.
> 
> (Includes Mark McLoughlin <markmc@redhat.com>'s fix to hold rtnl sem).
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>


Agree. And it's often way more convenient to muck with the TUN settings
directly on the fd instead of using external tool.

Acked-by: Max Krasnyansky <maxk@qualcomm.com>

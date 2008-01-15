From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/3] skb_partial_csum_set
Date: Wed, 16 Jan 2008 08:03:05 +1100
Message-ID: <200801160803.06052.rusty__22982.9928292476$1200431363$gmane$org@rustcorp.com.au>
References: <200801152141.56172.rusty@rustcorp.com.au>
	<20080115.031422.06112893.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080115.031422.06112893.davem@davemloft.net>
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
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 15 January 2008 22:14:22 David Miller wrote:
> From: Rusty Russell <rusty@rustcorp.com.au>
> Date: Tue, 15 Jan 2008 21:41:55 +1100
>
> > Implement skb_partial_csum_set, for setting partial csums on untrusted
> > packets.
> >
> > Use it in virtio_net (replacing buggy version there), it's also going
> > to be used by TAP for partial csum support.
> >
> > Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>
> Looks fine to me.
>
> Acked-by: David S. Miller <davem@davemloft.net>
>
> If you like I can merge this into my net-2.6.25 tree, or alternatively
> if it makes your life easier you then you can handle it yourself.

Thanks, that will reduce coordination pain.

Cheers,
Rusty.

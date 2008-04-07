From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH RFC 4/5] tun: vringfd xmit support.
Date: Mon, 07 Apr 2008 00:35:28 -0700 (PDT)
Message-ID: <20080407.003528.96136816.davem__5993.83336161754$1207553915$gmane$org@davemloft.net>
References: <E1Jijfs-0004Lo-00@gondolin.me.apana.org.au>
	<200804071724.51781.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804071724.51781.rusty@rustcorp.com.au>
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, herbert@gondor.apana.org.au, maxk@qualcomm.com, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

From: Rusty Russell <rusty@rustcorp.com.au>
Date: Mon, 7 Apr 2008 17:24:51 +1000

> On Monday 07 April 2008 15:13:44 Herbert Xu wrote:
> > On second thought, this is not going to work.  The network stack
> > can clone individual pages out of this skb and put it into a new
> > skb.  Therefore whatever scheme we come up with will either need
> > to be page-based, or add a flag to tell the network stack that it
> > can't clone those pages.
> 
> Erk... I'll put in the latter for now.   A page-level solution is not really 
> an option: if userspace hands us mmaped pages for example.

Keep in mind that the core of the TCP stack really depends
upon being able to slice and dice paged SKBs as is pleases
in order to send packets out.

In fact, it also does such splitting during SACK processing.

It really is a base requirement for efficient TSO support.
Otherwise the above operations would be so incredibly
expensive we might as well rip all of the TSO support out.

From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC 4/5] tun: vringfd xmit support.
Date: Tue, 8 Apr 2008 11:51:43 +1000
Message-ID: <200804081151.43599.rusty__40388.3756873713$1207620383$gmane$org@rustcorp.com.au>
References: <E1Jijfs-0004Lo-00@gondolin.me.apana.org.au>
	<200804071724.51781.rusty@rustcorp.com.au>
	<20080407.003528.96136816.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080407.003528.96136816.davem@davemloft.net>
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, herbert@gondor.apana.org.au, maxk@qualcomm.com, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Monday 07 April 2008 17:35:28 David Miller wrote:
> From: Rusty Russell <rusty@rustcorp.com.au>
> Date: Mon, 7 Apr 2008 17:24:51 +1000
>
> > On Monday 07 April 2008 15:13:44 Herbert Xu wrote:
> > > On second thought, this is not going to work.  The network stack
> > > can clone individual pages out of this skb and put it into a new
> > > skb.  Therefore whatever scheme we come up with will either need
> > > to be page-based, or add a flag to tell the network stack that it
> > > can't clone those pages.
> >
> > Erk... I'll put in the latter for now.   A page-level solution is not
> > really an option: if userspace hands us mmaped pages for example.
>
> Keep in mind that the core of the TCP stack really depends
> upon being able to slice and dice paged SKBs as is pleases
> in order to send packets out.
>
> In fact, it also does such splitting during SACK processing.
>
> It really is a base requirement for efficient TSO support.
> Otherwise the above operations would be so incredibly
> expensive we might as well rip all of the TSO support out.

In this case that's OK; these are only for packets coming from 
userspace/guest, so the only interaction with the tcp code is possibly as a 
recipient.

If tcp wanted to do zero-copy aio xmit, I think we'd need something else.

Cheers,
Rusty.

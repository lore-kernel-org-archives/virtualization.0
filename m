From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 22/25] xen: xen-netfront: use skb.cb for storing private
 data
Date: Fri, 27 Apr 2007 15:19:50 -0700
Message-ID: <46327706.80508@goop.org>
References: <20070423215638.563901986@goop.org>
	<20070423215713.550883195@goop.org>
	<20070424014528.GA27789@gondor.apana.org.au>
	<462D88EF.9030007@goop.org>
	<20070424055731.GA30018@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070424055731.GA30018@gondor.apana.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Herbert Xu wrote:
> Sure thing.  I'll look over it soon.
>
> Actually there is one thing I'd like to see changed first up: I noticed
> that you've stripped out the checksum hack which is in the main Xen tree.
> We actually have the code in net-2.6.22 (which is also in mm) that lets
> you use CHECKSUM_PARTIAL on received packets without having to do that
> hack.
>
> Here's the patch that I've been testing so far.  It's against the Xen
> source, but should be easy to adapt to your version as well.
>
> I just thought about this again, and in fact we need this change for
> correctness as well as performance.  Because not setting ip_summed
> to CHECKSUM_PARTIAL in netfront is not going to stop netback from
> sending CHECKSUM_PARTIAL packets to us.  If these packets are then
> routed/bridged back to netback, they'll have the wrong checksum.
>   

OK, I've been sitting on this in the hope that I'll suddenly see the
light and work out what you're talking about - but apparently that's not
going to happen.  So, some questions:

   1. Does this patch change the dom0 <-> domU interface?  or does it
      fix something that's currently broken?
   2. Can just apply the netfront part to the pv_ops kernel, or does it
      require the corresponding dom0 patch to be applied as well?

Thanks,
    J

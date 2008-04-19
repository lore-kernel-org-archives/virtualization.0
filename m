From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 5/5] tun: vringfd xmit support.
Date: Sun, 20 Apr 2008 00:41:43 +1000
Message-ID: <200804200041.43969.rusty__10989.9744893939$1208627384$gmane$org@rustcorp.com.au>
References: <200804181433.48488.rusty@rustcorp.com.au>
	<200804190115.15983.rusty@rustcorp.com.au>
	<20080418120634.986e30f1.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080418120634.986e30f1.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Max Krasnyansky <maxk@qualcomm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Saturday 19 April 2008 05:06:34 Andrew Morton wrote:
> On Sat, 19 Apr 2008 01:15:15 +1000 Rusty Russell <rusty@rustcorp.com.au> 
wrote:
> > > What is the maximum numbet of pages which an unpriviliged user can
> > > concurrently pin with this code?
> >
> > Since only root can open the tun device, it's currently OK.  The old code
> > kmalloced and copied: is there some mm-fu reason why pinning userspace
> > memory is worse?
>
> We generally try to avoid it - it allows users to dos the box.

My question is: is pinning a page worse than allocating a (kernel) page in 
some way?

Cheers,
Rusty.

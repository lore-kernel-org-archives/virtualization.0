From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5/5] tun: vringfd xmit support.
Date: Sat, 19 Apr 2008 10:51:48 -0700
Message-ID: <20080419105148.1bed4fee.akpm__2633.50252430445$1208630021$gmane$org@linux-foundation.org>
References: <200804181433.48488.rusty@rustcorp.com.au>
	<200804190115.15983.rusty@rustcorp.com.au>
	<20080418120634.986e30f1.akpm@linux-foundation.org>
	<200804200041.43969.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804200041.43969.rusty@rustcorp.com.au>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, maxk@qualcomm.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

> On Sun, 20 Apr 2008 00:41:43 +1000 Rusty Russell <rusty@rustcorp.com.au> wrote:
> On Saturday 19 April 2008 05:06:34 Andrew Morton wrote:
> > On Sat, 19 Apr 2008 01:15:15 +1000 Rusty Russell <rusty@rustcorp.com.au> 
> wrote:
> > > > What is the maximum numbet of pages which an unpriviliged user can
> > > > concurrently pin with this code?
> > >
> > > Since only root can open the tun device, it's currently OK.  The old code
> > > kmalloced and copied: is there some mm-fu reason why pinning userspace
> > > memory is worse?
> >
> > We generally try to avoid it - it allows users to dos the box.
> 
> My question is: is pinning a page worse than allocating a (kernel) page in 
> some way?
> 

I guess pinning is not as bad as straight-out allocating.

Pinning is limited to the size of the program's VM.  Pinning
it at least pining something which is accounted and is exposed
to admin tools.

But they're both pretty similar in effect and risk.

From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] virtio_balloon: fix towards_target when deflating balloon
Date: Mon, 18 Aug 2008 21:17:12 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808182115210.3324__9835.82021804086$1219119661$gmane$org@nehalem.linux-foundation.org>
References: <1219097731-1224-1-git-send-email-aliguori@us.ibm.com>
	<alpine.LFD.1.10.0808181740500.3324@nehalem.linux-foundation.org>
	<48AA1D5E.5050405@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48AA1D5E.5050405@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On Mon, 18 Aug 2008, Anthony Liguori wrote:
> 
> Nothing.  It works just fine.  However, I implemented it more verbosely
> because this is the second time we've "fixed" this problem.  See
> 
> commit bdc1681cdf1ab6a65fa935a2b3f8fc63b20c54ea
> Author: Rusty Russell <rusty@rustcorp.com.au>
> Date:   Mon Mar 17 22:58:15 2008 -0500
> 
>    virtio: handle > 2 billion page balloon targets

Well, we could perhaps add a sparse warning that makes noise when a 
unsigned subtraction is cast to a wider signed field. I dunno if it would 
catch anything interesting, or just cause a ton of irritating noise.

> So I thought I'd rely a little less on the subtleties of promotion and make
> things a bit more clear.  However, I don't feel that strongly about it so here
> you go.

Ugly and inefficient is not acceptable, even for these kinds of reasons. 
So yes, the simpler version is much better.

		Linus

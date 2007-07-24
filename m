From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/7] lguest: documentation pt I: Preparation
Date: Tue, 24 Jul 2007 11:39:47 +1000
Message-ID: <1185241187.1803.82.camel__46559.8311195665$1185241316$gmane$org@localhost.localdomain>
References: <1184980678.6344.1.camel@localhost.localdomain>
	<20070723171238.1a832b31.akpm@linux-foundation.org>
	<1185238908.1803.63.camel@localhost.localdomain>
	<20070723182027.ebe04818.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070723182027.ebe04818.akpm@linux-foundation.org>
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Landley <rob@landley.net>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-07-23 at 18:20 -0700, Andrew Morton wrote:
> On Tue, 24 Jul 2007 11:01:48 +1000 Rusty Russell <rusty@rustcorp.com.au> wrote:
> > But writing this documentation took *weeks*, to document 5000 lines of
> > code.  Perhaps this effort, if merged, will inspire others, but I've
> > seen little indication so far: we have enough trouble getting them
> > documenting a single public function.
> 
> Yeah, I suspect there will be insufficient interest and energy for anyone
> else to take this anywhere.
> 
> Could you please redo the changes after "link lguest example launcher
> non-static", which made a fairly big mess?

Indeed... which is why I was waiting to see if it got into Linus' tree
(I sent it before rc1, but too late now).

I'm waiting until Linus says he'll apply my documentation patches, then
I'll rejig that patch...

Thanks,
Rusty.

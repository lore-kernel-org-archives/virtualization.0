From: Ian Campbell <ijc@hellion.org.uk>
Subject: Re: [PATCHv3 1/3] x86: use ELF format in compressed images.
Date: Thu, 14 Feb 2008 17:51:56 +0000
Message-ID: <1203011516.30565.5.camel__4598.50064148686$1203011666$gmane$org@cthulhu.hellion.org.uk>
References: <1202936100-30859-1-git-send-email-ijc@hellion.org.uk>
	<9d3a007a2bfe774201b6deed5115a0cc8182bbb4.1202935389.git.ijc@hellion.org.uk>
	<1202988844.26435.4.camel@muff>
	<1203008490.30818.69.camel@localhost.localdomain>
	<1203010675.16280.15.camel@muff>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1203010675.16280.15.camel@muff>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark McLoughlin <markmc@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org


On Thu, 2008-02-14 at 17:37 +0000, Mark McLoughlin wrote:
> On Thu, 2008-02-14 at 17:01 +0000, Ian Campbell wrote:
> With this, AFLAGS would apply to building when building the
> prerequisites of header.o too, which you don't want
> 
> The make manual says:
> 
>   "when you define a target-specific variable that variable value is
>    also in effect for all prerequisites of this target, and all their
>    prerequisites"

Ah yes, quite right.

I think given that subtleties of these kinds of variable definitions
it's probably clearer to stick with the header file way of doing things.
it's nice and straight forward.

Ian.
-- 
Ian Campbell

Davis' Law of Traffic Density:
	The density of rush-hour traffic is directly proportional to
	1.5 times the amount of extra time you allow to arrive on time.

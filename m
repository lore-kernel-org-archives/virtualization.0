From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/7] lguest documentation: infrastructure and Chapter I
Date: Thu, 7 Jun 2007 23:23:49 -0700
Message-ID: <20070607232349.b4673058.akpm__16060.2191849195$1181283903$gmane$org@linux-foundation.org>
References: <1181272257.24958.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1181272257.24958.12.camel@localhost.localdomain>
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
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 08 Jun 2007 13:10:57 +1000 Rusty Russell <rusty@rustcorp.com.au> wrote:

> The netfilter code had very good documentation: the Netfilter Hacking
> HOWTO.  Noone ever read it.
> 
> So this time I'm trying something different, using a bit of
> Knuthiness.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> ---
>  Documentation/lguest/extract          |   58 +++++++++++++++++++++++++++++++++
>  Documentation/lguest/lguest.c         |    9 +++--
>  drivers/lguest/Makefile               |   12 ++++++
>  drivers/lguest/README                 |   47 ++++++++++++++++++++++++++
>  drivers/lguest/core.c                 |    7 ++-
>  drivers/lguest/hypercalls.c           |    9 +++--
>  drivers/lguest/interrupts_and_traps.c |   13 +++++++
>  drivers/lguest/io.c                   |    8 +++-
>  drivers/lguest/lguest.c               |   31 ++++++++++++++++-
>  drivers/lguest/lguest_bus.c           |    3 +
>  drivers/lguest/lguest_user.c          |    7 +++
>  drivers/lguest/page_tables.c          |   10 ++++-
>  drivers/lguest/segments.c             |   11 ++++++
>  drivers/lguest/switcher.S             |   13 +++----
>  14 files changed, 219 insertions(+), 19 deletions(-)

This patch series craps all over the existing one:

lguest-export-symbols-for-lguest-as-a-module.patch
lguest-the-guest-code.patch
lguest-the-host-code.patch
lguest-the-asm-offsets.patch
lguest-the-makefile-and-kconfig.patch
lguest-the-console-driver.patch
lguest-the-net-driver.patch
lguest-the-block-driver.patch
lguest-the-documentation-example-launcher.patch

obviously we could append this new series to the existing one, but that
limits our ability to make further changes over the next few weeks.  Or we
just give up trying to present the series nicely and it hits mainline with
a random stream of uninteresting and irrelevant afterthoughts at the end,
like we're some lameo git users or something.

(I could split all this up, but I'm getting kinda bored of preventing you
from mucking up your own patch series)

So... what course dost thou wish to take?

From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 06/19] asm/rwonce: Don't pull <asm/barrier.h> into
 'asm-generic/rwonce.h'
Date: Fri, 10 Jul 2020 18:15:09 +0100
Message-ID: <20200710171508.GA31366@willie-the-truck>
References: <20200710165203.31284-1-will@kernel.org>
 <20200710165203.31284-7-will@kernel.org>
 <CAKwvOd=HJye0iHr=9=7EMytO8ycFNJEsHHe1m64uT8s0jOQw0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKwvOd=HJye0iHr=9=7EMytO8ycFNJEsHHe1m64uT8s0jOQw0Q@mail.gmail.com>
Sender: linux-alpha-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>, Sami Tolvanen <samitolvanen@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-alpha@vger.kernel.org, virtualization@lists.linux-fou
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 10, 2020 at 10:06:12AM -0700, Nick Desaulniers wrote:
> On Fri, Jul 10, 2020 at 9:52 AM Will Deacon <will@kernel.org> wrote:
> > diff --git a/include/linux/nospec.h b/include/linux/nospec.h
> > index 0c5ef54fd416..c1e79f72cd89 100644
> > --- a/include/linux/nospec.h
> > +++ b/include/linux/nospec.h
> > @@ -5,6 +5,8 @@
> >
> >  #ifndef _LINUX_NOSPEC_H
> >  #define _LINUX_NOSPEC_H
> > +
> > +#include <linux/compiler.h>
> 
> The other hunks LGTM, but this one is a little more curious to me. Can
> you walk me through this addition?

Sure. Without it, the build breaks on riscv because it includes this header
without first including <linux/compiler.h>, and this header relies on
OPTIMIZER_HIDE_VAR() being to defined as it is used in static inline
functions.

Perhaps I should squash this hunk into "compiler.h: Split {READ,WRITE}_ONCE
definitions out into rwonce.h" instead, as that is where I remove the
include of <linux/compiler.h> from 'asm-generic/barrier.h'. I'll check
the bisection on riscv...

Will

From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when CLANG_LTO=y
Date: Wed, 1 Jul 2020 12:59:36 +0200
Message-ID: <CAK8P3a1MWBxHihcUaduqcpS2U61cKPujQG6mAfn3-pCokzLwUw@mail.gmail.com>
References: <20200630173734.14057-1-will@kernel.org> <20200630173734.14057-19-will@kernel.org>
 <CAK8P3a2zB4z121reuy6BCqQ3-1mDBAkUkRRXeDuvSFtSr3ha2g@mail.gmail.com> <20200701101922.GC14959@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <20200701101922.GC14959@willie-the-truck>
Sender: linux-alpha-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, alpha <linux-alpha@vger.k>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 1, 2020 at 12:19 PM Will Deacon <will@kernel.org> wrote:
> On Tue, Jun 30, 2020 at 09:25:03PM +0200, Arnd Bergmann wrote:
> > On Tue, Jun 30, 2020 at 7:39 PM Will Deacon <will@kernel.org> wrote:
> > Once we make gcc-4.9 the minimum version,
> > this could be further improved to
> >
> >        __auto_type __x = &(x);
>
> Is anybody working on moving to 4.9? I've seen the mails from Linus
> championing it, but I thought there was a RHEL in support that people
> might care about?

I don't think there was a serious discussion about it so far, and
we only just moved to gcc-4.8.

I think moving to gnu11 (gcc-4.9 or clang) instead of gnu99 has other
benefits as well, so we may well want to do it anyway when something
else comes up.

For __auto_type(), we could do it like

#if (clang or gcc-4.9+)
#define auto_typeof(x) __auto_type
#else
#define auto_typeof(x) typeof(x)
#endif

which could be used in a lot of macros.

     Arnd

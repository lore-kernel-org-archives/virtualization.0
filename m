From: Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH 04/18] alpha: Override READ_ONCE() with barriered implementation
Date: Thu, 2 Jul 2020 11:07:19 -0400
Message-ID: <CAJWu+ooEsf70ri4J+M5+Fkz6VrH1kN5541j71LE8=y=rmSLDJQ@mail.gmail.com>
References: <20200630173734.14057-1-will@kernel.org> <20200630173734.14057-5-will@kernel.org>
 <CAJWu+oqs-d0oDswB2Owyh-4Zo4WXAqKhKU0L=1HEwEfQbc1izw@mail.gmail.com> <20200702145532.GB16999@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200702145532.GB16999@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 2, 2020 at 10:55 AM Will Deacon <will@kernel.org> wrote:
> On Thu, Jul 02, 2020 at 10:43:55AM -0400, Joel Fernandes wrote:
> > On Tue, Jun 30, 2020 at 1:38 PM Will Deacon <will@kernel.org> wrote:
> > > diff --git a/arch/alpha/include/asm/barrier.h b/arch/alpha/include/asm/barrier.h
> > > index 92ec486a4f9e..2ecd068d91d1 100644
> > > --- a/arch/alpha/include/asm/barrier.h
> > > +++ b/arch/alpha/include/asm/barrier.h
> > > - * For example, the following code would force ordering (the initial
> > > - * value of "a" is zero, "b" is one, and "p" is "&a"):
> > > - *
> > > - * <programlisting>
> > > - *     CPU 0                           CPU 1
> > > - *
> > > - *     b = 2;
> > > - *     memory_barrier();
> > > - *     p = &b;                         q = p;
> > > - *                                     read_barrier_depends();
> > > - *                                     d = *q;
> > > - * </programlisting>
> > > - *
> > > - * because the read of "*q" depends on the read of "p" and these
> > > - * two reads are separated by a read_barrier_depends().  However,
> > > - * the following code, with the same initial values for "a" and "b":
> > > - *
> >
> > Would it be Ok to keep this example in the kernel sources? I think it
> > serves as good documentation and highlights the issue in the Alpha
> > architecture well.
>
> I'd _really_ like to remove it, as I think it only serves to confuse people
> on a topic that is confusing enough already. Paul's perfbook [1] already has
> plenty of information about this, so I don't think we need to repeat that
> here. I could add a citation, perhaps?

True, and also found that LKMM docs and the memory-barriers.txt talks
about it, so removing it here sounds good to me. Maybe a reference
here to either documentation should be Ok.

> > BTW,  do you know any architecture where speculative execution of
> > address-dependent loads can cause similar misorderings? That would be
> > pretty insane though. In Alpha's case it is not speculation but rather
> > the split local cache design as the docs mention.   The reason I ask
> > is it is pretty amusing that control-dependent loads do have such
> > misordering issues due to speculative branch execution and I wondered
> > what other games the CPUs are playing. FWIW I ran into [1] which talks
> > about analogy between memory dependence and control dependence.
>
> I think you're asking about value prediction, and the implications it would
> have on address-dependent loads where the address can itself be predicted.

Yes.

> I'm not aware of an CPUs where that is observable architecturally.

I see.

> arm64 has some load instructions that do not honour address dependencies,
> but I believe that's mainly to enable alternative cache designs for things
> like non-temporal and large vector loads.

Good to know this, thanks.

 - Joel

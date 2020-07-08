From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when
 CLANG_LTO=y
Date: Wed, 8 Jul 2020 11:20:36 -0700
Message-ID: <20200708182036.GR9247@paulmck-ThinkPad-P72>
References: <20200701170722.4rte5ssnmrn2uqzg@bakewell.cambridge.arm.com>
 <20200702072301.GA15963@willie-the-truck>
 <20200706160023.GB10992@arm.com>
 <20200706163455.GV9247@paulmck-ThinkPad-P72>
 <20200706170556.GE10992@arm.com>
 <20200706173628.GZ9247@paulmck-ThinkPad-P72>
 <20200707102915.GI10992@arm.com>
 <20200707225122.GJ9247@paulmck-ThinkPad-P72>
 <CAKwvOdkW__H21m8vqqk1-n6-KK67HBk=YbA+MkUS7igxfjV1iw@mail.gmail.com>
 <20200708091620.GF597537@hirez.programming.kicks-ass.net>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200708091620.GF597537@hirez.programming.kicks-ass.net>
Sender: linux-alpha-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Dave Martin <Dave.Martin@arm.com>, Will Deacon <will@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, Matt Turner <mattst88@gmail.com>, kernel-team <kernel-team@android.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Richard
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 08, 2020 at 11:16:20AM +0200, Peter Zijlstra wrote:
> On Tue, Jul 07, 2020 at 04:01:28PM -0700, Nick Desaulniers wrote:
> > I'm trying to put together a Micro Conference for Linux Plumbers
> > conference focused on "make LLVM slightly less shitty."  Do you all
> > plan on attending the conference? Would it be worthwhile to hold a
> > session focused on discussing this (LTO and memory models) be
> > worthwhile?
> 
> I'd love to have a session about compilers and memory ordering with both
> GCC and CLANG in attendance.
> 
> We need a solution for dependent-loads and control-dependencies for both
> toolchains.

What Peter said!  ;-)

							Thanx, Paul

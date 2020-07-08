From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when
 CLANG_LTO=y
Date: Wed, 8 Jul 2020 11:16:20 +0200
Message-ID: <20200708091620.GF597537@hirez.programming.kicks-ass.net>
References: <20200630173734.14057-19-will@kernel.org>
 <20200701170722.4rte5ssnmrn2uqzg@bakewell.cambridge.arm.com>
 <20200702072301.GA15963@willie-the-truck>
 <20200706160023.GB10992@arm.com>
 <20200706163455.GV9247@paulmck-ThinkPad-P72>
 <20200706170556.GE10992@arm.com>
 <20200706173628.GZ9247@paulmck-ThinkPad-P72>
 <20200707102915.GI10992@arm.com>
 <20200707225122.GJ9247@paulmck-ThinkPad-P72>
 <CAKwvOdkW__H21m8vqqk1-n6-KK67HBk=YbA+MkUS7igxfjV1iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAKwvOdkW__H21m8vqqk1-n6-KK67HBk=YbA+MkUS7igxfjV1iw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alan Stern <stern@rowland.harvard.edu>, Sami Tolvanen <samitolvanen@google.com>, Matt Turner <mattst88@gmail.com>, kernel-team <kernel-team@android.com>, Dave Martin <Dave.Martin@arm.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Richard Henderson <rth@twiddle.net>, LKML <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 07, 2020 at 04:01:28PM -0700, Nick Desaulniers wrote:
> I'm trying to put together a Micro Conference for Linux Plumbers
> conference focused on "make LLVM slightly less shitty."  Do you all
> plan on attending the conference? Would it be worthwhile to hold a
> session focused on discussing this (LTO and memory models) be
> worthwhile?

I'd love to have a session about compilers and memory ordering with both
GCC and CLANG in attendance.

We need a solution for dependent-loads and control-dependencies for both
toolchains.

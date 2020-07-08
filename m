From: Marco Elver <elver@google.com>
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when CLANG_LTO=y
Date: Wed, 8 Jul 2020 09:15:44 +0200
Message-ID: <CANpmjNP8xwyjiDRgzWO13K3rPbxM0gRwTvMvX3Amm-QOWD0_tQ@mail.gmail.com>
References: <20200630173734.14057-1-will@kernel.org> <20200630173734.14057-19-will@kernel.org>
 <20200701170722.4rte5ssnmrn2uqzg@bakewell.cambridge.arm.com>
 <20200702072301.GA15963@willie-the-truck> <20200706160023.GB10992@arm.com>
 <20200706163455.GV9247@paulmck-ThinkPad-P72> <20200706170556.GE10992@arm.com>
 <20200706173628.GZ9247@paulmck-ThinkPad-P72> <20200707102915.GI10992@arm.com>
 <20200707225122.GJ9247@paulmck-ThinkPad-P72> <CAKwvOdkW__H21m8vqqk1-n6-KK67HBk=YbA+MkUS7igxfjV1iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <CAKwvOdkW__H21m8vqqk1-n6-KK67HBk=YbA+MkUS7igxfjV1iw@mail.gmail.com>
Sender: linux-alpha-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Dave Martin <Dave.Martin@arm.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Mark Rutland <mark.rutland@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, Matt Turner <mattst88@gmail.com>, kernel-team <kernel-team@android.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Richard
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 8 Jul 2020 at 01:01, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> I'm trying to put together a Micro Conference for Linux Plumbers
> conference focused on "make LLVM slightly less shitty."  Do you all
> plan on attending the conference? Would it be worthwhile to hold a
> session focused on discussing this (LTO and memory models) be
> worthwhile?

I would welcome sessions on LLVM, and would try to attend. Apart from
general improvements to the LLVM ecosystem, we should also emphasize
the benefits LLVM provides and how we can enable them (one reason we
want LTO is to get CFI).

Regarding LTO and memory models, I'm not sure. Given the current state
of things, such a discussion needs to be carefully framed to not go in
circles, because we're trying to figure out things at the intersection
of architecture, what the compiler does, the C standard, and the
kernel wants. And because some of these boxes are difficult to change
(standard, arch, compiler) or difficult to precisely define behaviour
(compiler), we might end up going in circles. From what I see there
are efforts to fix the situation at the root (standard), and we might
have means to get the compiler to tell us what it's doing. But these
happen extremely slowly.

So, if we do this, we need to be careful to not end up re-discussing
what we discussed here, but rather try and make it a continuation that
hopefully leads to some constructive output.

Thanks,
-- Marco

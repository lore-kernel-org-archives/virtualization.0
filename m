From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 00/18] Allow architectures to override __READ_ONCE()
Date: Wed, 1 Jul 2020 00:38:46 -0700
Message-ID: <20200701073846.GC301687@localhost>
References: <20200630173734.14057-1-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200630173734.14057-1-will@kernel.org>
Sender: linux-alpha-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, virtualization@lists.linux-foundation.orgkernel
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 30, 2020 at 06:37:16PM +0100, Will Deacon wrote:
> The patches allow architectures to provide their own implementation of
> __READ_ONCE(). This serves two main purposes:
> 
>   1. It finally allows us to remove [smp_]read_barrier_depends() from the
>      Linux memory model and make it an implementation detail of the Alpha
>      back-end.

And there was much rejoicing. Thank you.

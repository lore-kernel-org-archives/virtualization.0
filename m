From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 01/18] tools: bpf: Use local copy of headers including uapi/linux/filter.h
Date: Wed, 1 Jul 2020 09:38:46 -0700
Message-ID: <CAADnVQJ5kZRT+H7MZWKcJ6HqCGR54Y4zdk67KZO3=ho6Kab5fw@mail.gmail.com>
References: <20200630173734.14057-1-will@kernel.org> <20200630173734.14057-2-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <20200630173734.14057-2-will@kernel.org>
Sender: linux-alpha-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>linux
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 30, 2020 at 10:37 AM Will Deacon <will@kernel.org> wrote:
>
> Pulling header files directly out of the kernel sources for inclusion in
> userspace programs is highly error prone, not least because it bypasses
> the kbuild infrastructure entirely and so may end up referencing other
> header files that have not been generated.
>
> Subsequent patches will cause compiler.h to pull in the ungenerated
> asm/rwonce.h file via filter.h, breaking the build for tools/bpf:
>
>   | $ make -C tools/bpf
>   | make: Entering directory '/linux/tools/bpf'
>   |   CC       bpf_jit_disasm.o
>   |   LINK     bpf_jit_disasm
>   |   CC       bpf_dbg.o
>   | In file included from /linux/include/uapi/linux/filter.h:9,
>   |                  from /linux/tools/bpf/bpf_dbg.c:41:
>   | /linux/include/linux/compiler.h:247:10: fatal error: asm/rwonce.h: No such file or directory
>   |  #include <asm/rwonce.h>
>   |           ^~~~~~~~~~~~~~
>   | compilation terminated.
>   | make: *** [Makefile:61: bpf_dbg.o] Error 1
>   | make: Leaving directory '/linux/tools/bpf'
>
> Take a copy of the installed version of linux/filter.h  (i.e. the one
> created by the 'headers_install' target) into tools/include/uapi/linux/
> and adjust the BPF tool Makefile to reference the local include
> directories instead of those in the main source tree.
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> Reported-by: Xiao Yang <ice_yangxiao@163.com>
> Signed-off-by: Will Deacon <will@kernel.org>

Acked-by: Alexei Starovoitov <ast@kernel.org>

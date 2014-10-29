From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 3/3] x86: Support compiling out userspace I/O (iopl
	and ioperm)
Date: Wed, 29 Oct 2014 22:00:54 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1410292155300.5308@nanos>
References: <7159269982aac3b732af2c33a2e3d04e2048bdfb.1414598511.git.josh@joshtriplett.org>
	<9d77d0e4df8feb2cb55fb21689e016a3145cb7f8.1414598511.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <9d77d0e4df8feb2cb55fb21689e016a3145cb7f8.1414598511.git.josh@joshtriplett.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Kees Cook <keescook@chromium.org>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 29 Oct 2014, Josh Triplett wrote:
> v3: Eliminated several #ifdefs, and in particular almost all #ifdefs in
>     .c files, by adding a macro INIT_SET_IOPL_MASK to use in place of
>     the initializer for set_iopl_mask, and using __maybe_unused rather
>     than wrapping function definitions in #ifdef.  Rebased on v3.18-rc1.
>     Recomputed bloat-o-meter.

Can you please split this patch into smaller pieces?

    - Seperate the code move to header files
    - Seperate the macro stuff
    - Add the #ifdef CONFIG_.... changes

Thanks,

	tglx

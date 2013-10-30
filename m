From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/3] x86: process: Unify 32-bit and 64-bit copy_thread I/O
	bitmap handling
Date: Wed, 30 Oct 2013 15:21:23 -0700
Message-ID: <CAGXu5jKB31cumm2ga_hFMv4=ejLKsPQS5vK-OXT4DCJncz6-Mg@mail.gmail.com>
References: <cover.1382407802.git.josh@joshtriplett.org>
	<41c886146639d4ab07331be335b889e2f48a79b5.1382407802.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <41c886146639d4ab07331be335b889e2f48a79b5.1382407802.git.josh@joshtriplett.org>
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
Cc: Alexander van Heukelum <heukelum@fastmail.fm>, Jeremy Fitzhardinge <jeremy@goop.org>, "x86@kernel.org" <x86@kernel.org>, Len Brown <len.brown@intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Herrmann <dh.herrmann@gmail.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Seiji Aguchi <seiji.aguchi@hds.com>, Jiri Slaby <jslaby@suse.cz>, Alok Kataria <akataria@vmware.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Andi Kleen <ak@linux.intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, xen-devel@lists.xenproject.org, Borislav Petkov <bp@suse.de>, Fenghua Yu <feng>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 21, 2013 at 7:34 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> The 32-bit and 64-bit versions of copy_thread have functionally
> identical handling for copying the I/O bitmap, modulo differences in
> error handling.  Clean up the error paths in both by moving the copy of
> the I/O bitmap to the end, to eliminate the need to free it if
> subsequent copy steps fail; move the resulting identical code to a
> static inline in a common header.
>
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>

This seems quite sensible to me.

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
Chrome OS Security

From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 3/3] x86: Support compiling out userspace I/O (iopl and
	ioperm)
Date: Sat, 26 Oct 2013 05:30:25 +0100
Message-ID: <CAGXu5j+5vRSXX30A8PTB6XB1je2+qriQ22enoCxCeV9uhZqVCg@mail.gmail.com>
References: <cover.1382407802.git.josh@joshtriplett.org>
	<c6432a64f977031b3d1cf0df1d292c3808faf166.1382407802.git.josh@joshtriplett.org>
	<CAOaVG168R6noZq5Zegs7ZcX3hYp9z6O8MaaJ4ZKeR+_iPTkPwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAOaVG168R6noZq5Zegs7ZcX3hYp9z6O8MaaJ4ZKeR+_iPTkPwQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Alexander van Heukelum <heukelum@fastmail.fm>, Jeremy Fitzhardinge <jeremy@goop.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Fenghua Yu <fenghua.yu@intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, "x86@kernel.org" <x86@kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Seiji Aguchi <seiji.aguchi@hds.com>, Jiri Slaby <jslaby@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Andi Kleen <ak@linux.intel.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, Borislav Petkov <bp@suse.de>, Len Brown <len.brown@intel.com>, Konrad
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Oct 26, 2013 at 4:17 AM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> I/O from userspace  is used to implement usermode virtio driver(s).
> This has been done independently by Intel, Brocade/Vyatta, and 6Wind.
> Sorry, it has to stay.

This isn't about removing it, it's about putting it behind a default=y
CONFIG. At the very least, the cleanups and 32/64 merging look
sensible.

As for the CONFIG, I think it'd be useful to have that, since some
more specialized users may not want IO ports at all (some folks see IO
ports as dangerous since they are a potential way to make a jump from
uid-0 to ring-0).

-Kees

-- 
Kees Cook
Chrome OS Security

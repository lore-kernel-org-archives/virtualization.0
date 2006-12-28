From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Use correct macros in raid code, not raw asm
Date: Thu, 28 Dec 2006 15:51:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612281549080.4473@woody.osdl.org>
References: <1167348861.30506.46.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1167348861.30506.46.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, virtualization <virtualization@lists.osdl.org>, Neil Brown <neilb@suse.de>, Ingo Molnar <mingo@elte.hu>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org



On Fri, 29 Dec 2006, Rusty Russell wrote:
>
> This make sure it's paravirtualized correctly when CONFIG_PARAVIRT=3Dy.

Why doesn't this code use "kernel_fpu_begin()" and "kernel_fpu_end()"?

The raid6 code is crap, and slower. It does "fsave/frstor" or movaps or =

other crud, and the thing is, it shouldn't. It should just do =

kernel_fpu_begin/end(), which does it all right, and avoids saving any =

state at all unless it's being used by the user RIGHT NOW.

		Linus

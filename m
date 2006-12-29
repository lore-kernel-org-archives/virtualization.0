From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] Use correct macros in raid code, not raw asm
Date: 29 Dec 2006 12:13:55 +0100
Message-ID: <20061229111355.GA82929@muc.de>
References: <1167348861.30506.46.camel@localhost.localdomain>
	<20061228155659.462eaa9c.akpm@osdl.org>
	<1167350803.30506.49.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Date: Fri, 29 Dec 2006 12:13:55 +0100
Content-Disposition: inline
In-Reply-To: <1167350803.30506.49.camel@localhost.localdomain>
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
Cc: Andrew Morton <akpm@osdl.org>, virtualization <virtualization@lists.osdl.org>, Linus Torvalds <torvalds@osdl.org>, Neil Brown <neilb@suse.de>, Ingo Molnar <mingo@elte.hu>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

> =

> The code looks like it's designed to be included from userspace for
> testing; as it compiles without this include (and has no other
> includes), I chose not to add it.
> =

> Linus makes a good point, but someone who actually knows the code
> should, y'know, test it and stuff...

It should use kernel_fpu_begin() imho. If someone wants to test
it in user space again they can add dummy definitions of that
to their user space  header.

-Andi

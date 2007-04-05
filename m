From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] lguest32 kallsyms backtrace of guest.
Date: Wed, 04 Apr 2007 23:19:57 -0400
Message-ID: <1175743197.9371.39.camel@localhost.localdomain>
References: <1175711023.9371.21.camel@localhost.localdomain>
	<1175741652.12230.620.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1175741652.12230.620.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-04-05 at 12:54 +1000, Rusty Russell wrote:

> =

> 	This is a cool idea, but there are two issues with this patch.  The
> first is that it's 500 lines of code: that's around +10% on lguest's
> total code size!  The second is that it conflicts with the medium-term
> plan to allow any user to run up lguests: this is why lg.ko never
> printk()s about problems with the guest.

Not much I can do about the size, but it's in the debug section so
hopefully it's not considered too bad :)

> =

> While it is useful for cases where a guest dies mysteriously before it
> brings up the console, three alternatives come to mind:
> =

> 1) Modify early_printk so Guests can use it.
> 2) Have a separate tool(-set?) for this kind of post-mortem.  Then you
> just have to implement guest suspend! 8)
> 3) Put this in a CONFIG_LGUEST_DEBUG.
> =

> Note that options 1 or 2 make you do more work, but are probably better
> in the long term.  I'm happy for #3 to sit as a patch in the tree for
> the duration, tho!

OK, I'll make a #3 patch to send, but the #1 looks best. Not to mention
that I still need to make it so that the console can read it.

-- Steve

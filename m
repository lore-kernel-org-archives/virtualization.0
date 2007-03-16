From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] make CONFIG_PARAVIRT require NO_HZ
Date: Fri, 16 Mar 2007 12:29:18 +0100
Message-ID: <200703161229.18686.ak@suse.de>
References: <20070316054746.GD10574@sequoia.sous-sol.org>
	<20070316105538.GA13557@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070316105538.GA13557@elte.hu>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Friday 16 March 2007 11:55, Ingo Molnar wrote:
> * Chris Wright <chrisw@sous-sol.org> wrote:
> > Given all the discussion, let's just require NO_HZ when
> > CONFIG_PARAVIRT.  Anyone object?
>
> well ... why do we want this? I'd not mind making it default y if
> CONFIG_PARAVIRT is enabled, but why force it?

I guess because they don't want to debug and maintain two different timer c=
ode =

paths. It would be fine for me. !NOHZ will hopefully go away at some point
anyways and it clearly is important for virtualized environments.

Although I would prefer a select instead of a depends I think. Otherwise
the relationship will be quite unobvious.

-Andi

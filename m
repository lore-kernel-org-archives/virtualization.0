From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Section mismatch in parainstructions
Date: Mon, 11 Dec 2006 01:34:25 -0800
Message-ID: <457D2621.4030402@goop.org>
References: <20061210155821.d2c5dfa5.randy.dunlap@oracle.com>	<457CA915.1040109@goop.org>
	<20061210183441.86785fee.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20061210183441.86785fee.randy.dunlap@oracle.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: akpm <akpm@osdl.org>, virtualization@lists.osdl.org, sam@ravnborg.org
List-Id: virtualization@lists.linuxfoundation.org

Randy Dunlap wrote:
> Good question.  I don't see much doc on that subject.
> Rusty could probably answer that better than me.
>   =


Yep, it is definitely his problem, since he wrote both halves of the
equation...

> Something like this:
>
> .exit.text section(s) can be discarded from built-in (non-modular)
> code (or not even loaded at all).
>
> .exit.text section(s) in modules is only loaded when
> CONFIG_MODULE_UNLOAD=3Dy.
>
>
> so what are the .parainstructions text sections for?
> Are they for replacing code instructions based on some
> condition(s)?  (like <gag> self-modifying code? </gag>)

You can compile in support for multiple paravirtualizing hypervisors
(ie, Xen, VMI and/or lhype), and it will work out which backend is
appropriate to use at runtime.  Once it has done that, the backends have
the option to patch inline code to implement simple operations (sti, for
example).

So the .parainstructions section marks where there are instructions
which the backend may want to replace, and the substitution happens
relatively early in the kernel boot process (and on module load, I
assume, but I haven't checked).

    J

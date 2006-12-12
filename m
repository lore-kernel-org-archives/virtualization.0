From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Why disable vdso by default with CONFIG_PARAVIRT?
Date: Wed, 13 Dec 2006 10:22:08 +1100
Message-ID: <1165965728.30004.21.camel@localhost.localdomain>
References: <457E0460.4030107@goop.org>  <200612120402.19958.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <200612120402.19958.ak@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@suse.de>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2006-12-12 at 04:02 +0100, Andi Kleen wrote:
> On Tuesday 12 December 2006 02:22, Jeremy Fitzhardinge wrote:
> > What problem do they cause together?  There's certainly no problem with
> > Xen+vdso
> =

> This was the change which finally got my test system (with an older
> SUSE 9.0 based user land to boot).  With paravirt older glibc's ld.so =

> otherwise throws assertation failures because it somehow can't deal with =

> the new placement. This only happens with paravirt enabled.
> =

> Binary compatibility is important.

Yes, this goes back to the original COMPAT_VDSO config option, months
ago.  FC1's buggy glibc couldn't handle the vdso being in an unusual
place, and (over my objections) the COMPAT_VDSO option was introduced.
Seems like SuSE 9.0 is similarly effected.

I don't have a system which has this problem (and, at the end of a
modem, I'm unlikely to get one soon).  But I would suggest that
COMPAT_VDSO should be rewritten: catch the segv from init (presumably in
around the old vdso 0xFFFF0000 addr?), printk a message, turn vdso off
and re-exec init.

That should make everyone happy.  Now, someone who can repro this please
code it up!

Thanks!
Rusty.

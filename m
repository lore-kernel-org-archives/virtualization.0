From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: What do we need to do to hit 2.6.19?
Date: Fri, 4 Aug 2006 15:21:47 -0700
Message-ID: <20060804222147.GP2654@sequoia.sous-sol.org>
References: <44D39351.9070405@goop.org> <200608050014.17061.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200608050014.17061.ak@suse.de>
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
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

* Andi Kleen (ak@suse.de) wrote:
> On Friday 04 August 2006 20:34, Jeremy Fitzhardinge wrote:
> > Chris said, and I agree, that we should try to get the basic PV-ops =

> > infrastructure stuff into 2.6.19.  To me this means being able to run a =

> > kernel native with CONFIG_PARAVIRT, and see little or no functional or =

> > performance degradation.  What do we need to do to get there:
> > =

> >     * fix the slowdown bug, which seems to be something to do with
> >       rdmsr/wrmsr on SMP systems
> >     * work out how to handle all the low-level system interfaces, like
> >       ACPI, PnP BIOS, APM
> >     * what else?
> =

> You're already too late for most of this. The merge window will
> open in the forseeable future and you don't have had significant
> -mm* or x86_64-* testing yet and in general stuff is still
> very fresh.
> =

> Maybe we can get some basic "obvious" stuff like a few =

> macro substitutions in (if you submit them properly), but probably not =

> the full support.

I don't agree.  We've got the first bit of obvious stuff posted and
queued up.  There's a bit more, then the final piece is #ifdef that means
none of the new code will even get compiled for non CONFIG_PARAVIRT users
(mark it as experimental, default =3D N, etc).  Then we have a safe place
to push things up w/out disturbing others.  IOW, at that point it's like
a new device driver, or fs, or arch....those can merge quite late.
Not saying it's not agressive, but I don't think it's obviously too
late.

thanks,
-chris

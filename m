From: Andi Kleen <ak@suse.de>
Subject: Re: Why disable vdso by default with CONFIG_PARAVIRT?
Date: Tue, 12 Dec 2006 22:15:19 +0100
Message-ID: <200612122215.19238.ak@suse.de>
References: <457E0460.4030107@goop.org> <200612121301.08444.ak@suse.de>
	<457F0D02.3040000@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <457F0D02.3040000@goop.org>
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
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 12 December 2006 21:11, Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> > I don't think being incompatible to old binaries is a sensible default.=
 That
> > is why I changed the wrong default. If paravirt ops cannot supply
> > a compatible vdso it has to do without one.
> =

> Do you know what glibc2.1 actually needs from the vdso?  Does it
> actually interpret as an elf file,

Interpret it as a ELF file, but then has some special hacks to jump
directly anyways (or at least there is no direct linking, but =

it goes over a trampoline in the main glibc)

The failure is an assertation failure in ld.so.

-Andi

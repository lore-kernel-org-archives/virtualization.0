From: Andi Kleen <ak@suse.de>
Subject: Re: Why disable vdso by default with CONFIG_PARAVIRT?
Date: Tue, 12 Dec 2006 13:01:08 +0100
Message-ID: <200612121301.08444.ak@suse.de>
References: <457E0460.4030107@goop.org> <200612120827.56363.ak@suse.de>
	<457E830D.6010801@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <457E830D.6010801@goop.org>
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

On Tuesday 12 December 2006 11:23, Jeremy Fitzhardinge wrote:

> Will your system boot with vdso=3D0 on the kernel command line?

Sure, it's the same as what I did by default.

> Presumably it will boot paravirt-native without it (since native makes
> no claims on the address space), so its something you could put in your
> Xen config file, no?

I don't think being incompatible to old binaries is a sensible default. That
is why I changed the wrong default. If paravirt ops cannot supply
a compatible vdso it has to do without one.

-Andi

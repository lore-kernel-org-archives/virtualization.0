From: Andi Kleen <ak@suse.de>
Subject: Re: Why disable vdso by default with CONFIG_PARAVIRT?
Date: Tue, 12 Dec 2006 04:02:19 +0100
Message-ID: <200612120402.19958.ak@suse.de>
References: <457E0460.4030107@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <457E0460.4030107@goop.org>
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

On Tuesday 12 December 2006 02:22, Jeremy Fitzhardinge wrote:
> What problem do they cause together?  There's certainly no problem with
> Xen+vdso

This was the change which finally got my test system (with an older
SUSE 9.0 based user land to boot).  With paravirt older glibc's ld.so =

otherwise throws assertation failures because it somehow can't deal with =

the new placement. This only happens with paravirt enabled.

Binary compatibility is important.

> (in fact, its actually very useful so that it picks up the
> right libc with Xen-friendly TLS).

AFAIK libc selection comes from the aux vector, not the vdso.

-Andi

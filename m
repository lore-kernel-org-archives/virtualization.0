From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Why disable vdso by default with CONFIG_PARAVIRT?
Date: Mon, 11 Dec 2006 22:50:44 -0800
Message-ID: <457E5144.7020406@goop.org>
References: <457E0460.4030107@goop.org> <200612120402.19958.ak@suse.de>
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

Andi Kleen wrote:
> This was the change which finally got my test system (with an older
> SUSE 9.0 based user land to boot).  With paravirt older glibc's ld.so =

> otherwise throws assertation failures because it somehow can't deal with =

> the new placement. This only happens with paravirt enabled.
>
> Binary compatibility is important.
>   =


So the SUSE 9 libc needs COMPAT_VDSO, or it just can't deal with the
vdso moving around?  Can it deal with the current kernel's mobile vdso?

>> (in fact, its actually very useful so that it picks up the
>> right libc with Xen-friendly TLS).
>>     =

>
> AFAIK libc selection comes from the aux vector, not the vdso.

No, it seems to be done by adding a .note segment to the vdso share
object.  Without the vdso, my Xen test system doesn't boot because it
can't find the nosegneg versions of the libraries (it doesn't seem to
know where to look).  I'm not sure how all this stuff fits together. =

But the auxv is supposed to point to the vdso...

    J

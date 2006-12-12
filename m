From: Zachary Amsden <zach@vmware.com>
Subject: Re: Why disable vdso by default with CONFIG_PARAVIRT?
Date: Mon, 11 Dec 2006 22:28:42 -0800
Message-ID: <457E4C1A.4000905@vmware.com>
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
> On Tuesday 12 December 2006 02:22, Jeremy Fitzhardinge wrote:
>   =

>> What problem do they cause together?  There's certainly no problem with
>> Xen+vdso
>>     =

>
> This was the change which finally got my test system (with an older
> SUSE 9.0 based user land to boot).  With paravirt older glibc's ld.so =

> otherwise throws assertation failures because it somehow can't deal with =

> the new placement. This only happens with paravirt enabled.
>
> Binary compatibility is important.
>   =


Yes, but the old placement of the vdso is incompatible with paravirt =

guests.  The only solution I can think of to keep compatibility is to =

dynamically place the vdso during boot, but this is complex and =

introduces an indirection penalty to the fast sysenter syscall path =

(unless we make that a dynamic patch).

What should we do to fix this?  Breaking compatibility for paravirt =

compilation is certainly the easiest thing to do.

Zach

From: Alan Meadows <alan.meadows@gmail.com>
Subject: Re: [PATCH RFC V6 0/11] Paravirtualized ticketlocks
Date: Wed, 28 Mar 2012 09:09:29 -0700
Message-ID: <CAMy5W3foop40+R1RLv_JPhnO5ZmV90uMmNERYY-e3QCeaJfqLw@mail.gmail.com>
References: <20120321102041.473.61069.sendpatchset@codeblue.in.ibm.com>
	<4F707C5F.1000905@redhat.com> <4F716E31.3000803@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6951695511347277467=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4F716E31.3000803@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Virtualization <virtualization@lists.linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Avi Kivity <avi@redhat.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, Attilio Rao <attilio.rao@citrix.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Xen Devel <xen-devel@lists.xensource.com>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============6951695511347277467==
Content-Type: multipart/alternative; boundary=14dae934067d13f17304bc4fd53f

--14dae934067d13f17304bc4fd53f
Content-Type: text/plain; charset=ISO-8859-1

I am happy to see this issue receiving some attention and second the wish
to see these patches be considered for further review and inclusion in an
upcoming release.

Overcommit is not as common in enterprise and single-tenant virtualized
environments as it is in multi-tenant environments, and frankly we have
been suffering.

We have been running an early copy of these patches in our lab and in a
small production node sample set both on 3.2.0-rc4 and 3.3.0-rc6 for over
two weeks now with great success. With the heavy level of vCPU:pCPU
overcommit required for our situation, the patches are increasing
performance by an _order of magnitude_ on our E5645 and E5620 systems.

Alan Meadows

On Tue, Mar 27, 2012 at 12:37 AM, Raghavendra K T <
raghavendra.kt@linux.vnet.ibm.com> wrote:

> On 03/26/2012 07:55 PM, Avi Kivity wrote:
>
>> On 03/21/2012 12:20 PM, Raghavendra K T wrote:
>>
>>> From: Jeremy Fitzhardinge<jeremy.**fitzhardinge@citrix.com<jeremy.fitzhardinge@citrix.com>
>>> >
>>>
>> [...]
>
>
>>> This series provides a Xen implementation, but it should be
>>> straightforward to add a KVM implementation as well.
>>>
>>>
>> Looks like a good baseline on which to build the KVM implementation.  We
>> might need some handshake to prevent interference on the host side with
>> the PLE code.
>>
>>
> Avi, Thanks for reviewing. True, it is sort of equivalent to PLE on non
> PLE machine.
>
> Ingo, Peter,
> Can you please let us know if this series can be considered for next merge
> window?
> OR do you still have some concerns that needs addressing.
>
> I shall rebase patches to 3.3 and resend. (main difference would be
> UNINLINE_SPIN_UNLOCK and jump label changes to use static_key_true/false()
> usage instead of static_branch.)
>
> Thanks,
> Raghu
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/**majordomo-info.html<http://vger.kernel.org/majordomo-info.html>
> Please read the FAQ at  http://www.tux.org/lkml/
>

--14dae934067d13f17304bc4fd53f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>I am happy to see this issue receiving some attention and second the w=
ish to see these patches be considered for further review and inclusion in =
an upcoming release.</div><div><br></div><div>Overcommit is not as common i=
n enterprise and single-tenant virtualized environments as it is in multi-t=
enant environments, and frankly we have been suffering.</div>
<div><br></div><div>We have been running an early copy of these patches in =
our lab and in a small production node sample set both on<span style=3D"fon=
t-family:arial,sans-serif;font-size:13px;background-color:rgb(255,255,255)"=
>=A0</span><span class=3D"il" style=3D"background-image:initial;background-=
color:rgb(255,255,255);color:rgb(34,34,34);font-family:arial,sans-serif;fon=
t-size:13px">3.2</span><span style=3D"font-family:arial,sans-serif;font-siz=
e:13px;background-color:rgb(255,255,255)">.0-rc4</span>=A0and=A0<span style=
=3D"background-color:rgb(255,255,255);font-family:arial,sans-serif;font-siz=
e:13px">3.3.0-rc6 for over two weeks now with great success. With the heavy=
 level of vCPU:pCPU overcommit required for our situation, the patches are =
increasing performance by an _order of magnitude_ on our=A0</span><font fac=
e=3D"arial, sans-serif">E5645=A0and=A0E5620 systems.=A0</font></div>
<div><font face=3D"arial, sans-serif"><br></font></div><div><font face=3D"a=
rial, sans-serif">Alan Meadows</font></div><div><font face=3D"arial, sans-s=
erif"><br></font></div><div class=3D"gmail_quote">On Tue, Mar 27, 2012 at 1=
2:37 AM, Raghavendra K T <span dir=3D"ltr">&lt;<a href=3D"mailto:raghavendr=
a.kt@linux.vnet.ibm.com">raghavendra.kt@linux.vnet.ibm.com</a>&gt;</span> w=
rote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On 03/26/2012 07:55 PM, Av=
i Kivity wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 03/21/2012 12:20 PM, Raghavendra K T wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
From: Jeremy Fitzhardinge&lt;<a href=3D"mailto:jeremy.fitzhardinge@citrix.c=
om" target=3D"_blank">jeremy.<u></u>fitzhardinge@citrix.com</a>&gt;<br>
</blockquote></blockquote></div>
[...]<div class=3D"im"><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
This series provides a Xen implementation, but it should be<br>
straightforward to add a KVM implementation as well.<br>
<br>
</blockquote>
<br>
Looks like a good baseline on which to build the KVM implementation. =A0We<=
br>
might need some handshake to prevent interference on the host side with<br>
the PLE code.<br>
<br>
</blockquote>
<br></div>
Avi, Thanks for reviewing. True, it is sort of equivalent to PLE on non PLE=
 machine.<br>
<br>
Ingo, Peter,<br>
Can you please let us know if this series can be considered for next merge =
window?<br>
OR do you still have some concerns that needs addressing.<br>
<br>
I shall rebase patches to 3.3 and resend. (main difference would be UNINLIN=
E_SPIN_UNLOCK and jump label changes to use static_key_true/false() usage i=
nstead of static_branch.)<br>
<br>
Thanks,<br>
Raghu<div><div></div><div class=3D"h5"><br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel=
&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org" targe=
t=3D"_blank">majordomo@vger.kernel.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/<u></u>majordomo-info.html</=
a><br>
Please read the FAQ at =A0<a href=3D"http://www.tux.org/lkml/" target=3D"_b=
lank">http://www.tux.org/lkml/</a><br>
</div></div></blockquote></div><br>

--14dae934067d13f17304bc4fd53f--

--===============6951695511347277467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6951695511347277467==--

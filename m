From: Anup Patel <anup@brainfault.org>
Subject: Re: [ANNOUNCE] Xen port to Cortex-A15 / ARMv7 with virt extensions
Date: Wed, 30 Nov 2011 10:12:19 +0530
Message-ID: <CAAhSdy3F1oUQP=f_Tig4_MnufwPRpNooZYW8_cSTAse7aOaDoA__1824.04950396648$1322669459$gmane$org@mail.gmail.com>
References: <alpine.DEB.2.00.1111281009090.31179@kaball-desktop>
	<201111292129.20444.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5726122609665322294=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201111292129.20444.arnd@arndb.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: xen-devel@lists.xensource.com, linaro-dev@lists.linaro.org, kvm@vger.kernel.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, android-virt@lists.cs.columbia.edu, embeddedxen-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

--===============5726122609665322294==
Content-Type: multipart/alternative; boundary=0015174be22c66cfcd04b2ec5c2b

--0015174be22c66cfcd04b2ec5c2b
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

I wanted to know how Xen-ARM for A15 will address following concerns:

- How will Xen-ARM for A15 support legacy guest environment like ARMv5 or
ARMv6 ?
- What if my Cortex-A15 board does not have a GIC with virtualization
support ?

Best Regards,
Anup Patel

On Wed, Nov 30, 2011 at 2:59 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Tuesday 29 November 2011, Stefano Stabellini wrote:
> > Hi all,
> > a few weeks ago I (and a few others) started hacking on a
> > proof-of-concept hypervisor port to Cortex-A15 which uses and requires
> > ARMv7 virtualization extensions. The intention of this work was to find
> > out how to best support ARM v7+ on Xen. See
> >
> http://old-list-archives.xen.org/archives/html/xen-arm/2011-09/msg00013.html
> > for more details.
> >
> > I am pleased to announce that significant progress has been made, and
> > that we now have a nascent Xen port for Cortex-A15. The port is based on
> > xen-unstable (HG CS 8d6edc3d26d2) and written from scratch exploiting
> > the latest virtualization, LPAE, GIC and generic timer support in
> > hardware.
>
> Very nice!
>
> Do you have a pointer to the kernel sources for the Linux guest?
> Since Xen and KVM are both in an early working state right now,
> it would be very nice if we could agree on the guest model to make
> sure that it's always possible to run the same kernel in both
> (and potentially other future) hypervisors without modifications.
>
>        Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--0015174be22c66cfcd04b2ec5c2b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<br><br>I wanted to know how Xen-ARM for A15 will address following =
concerns:<br><br>- How will Xen-ARM for A15 support legacy guest environmen=
t like ARMv5 or ARMv6 ?<br>- What if my Cortex-A15 board does not have a GI=
C with virtualization support ?<br>
<br>Best Regards,<br>Anup Patel<br><br><div class=3D"gmail_quote">On Wed, N=
ov 30, 2011 at 2:59 AM, Arnd Bergmann <span dir=3D"ltr">&lt;<a href=3D"mail=
to:arnd@arndb.de">arnd@arndb.de</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid=
 rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">On Tuesday 29 November 2011, Stefano Stabellini wrote:<br=
>
&gt; Hi all,<br>
&gt; a few weeks ago I (and a few others) started hacking on a<br>
&gt; proof-of-concept hypervisor port to Cortex-A15 which uses and requires=
<br>
&gt; ARMv7 virtualization extensions. The intention of this work was to fin=
d<br>
&gt; out how to best support ARM v7+ on Xen. See<br>
&gt; <a href=3D"http://old-list-archives.xen.org/archives/html/xen-arm/2011=
-09/msg00013.html" target=3D"_blank">http://old-list-archives.xen.org/archi=
ves/html/xen-arm/2011-09/msg00013.html</a><br>
&gt; for more details.<br>
&gt;<br>
&gt; I am pleased to announce that significant progress has been made, and<=
br>
&gt; that we now have a nascent Xen port for Cortex-A15. The port is based =
on<br>
&gt; xen-unstable (HG CS 8d6edc3d26d2) and written from scratch exploiting<=
br>
&gt; the latest virtualization, LPAE, GIC and generic timer support in<br>
&gt; hardware.<br>
<br>
</div>Very nice!<br>
<br>
Do you have a pointer to the kernel sources for the Linux guest?<br>
Since Xen and KVM are both in an early working state right now,<br>
it would be very nice if we could agree on the guest model to make<br>
sure that it&#39;s always possible to run the same kernel in both<br>
(and potentially other future) hypervisors without modifications.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
 =A0 =A0 =A0 =A0Arnd<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5">--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel=
&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
Please read the FAQ at =A0<a href=3D"http://www.tux.org/lkml/" target=3D"_b=
lank">http://www.tux.org/lkml/</a><br>
</div></div></blockquote></div><br>

--0015174be22c66cfcd04b2ec5c2b--

--===============5726122609665322294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5726122609665322294==--

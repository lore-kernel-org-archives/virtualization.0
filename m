From: Cam Macdonell <cam@cs.ualberta.ca>
Subject: Re: [Qemu-devel] Why I advise against using ivshmem
Date: Thu, 26 Jun 2014 14:02:00 -0600
Message-ID: <CAKjmth+o16hRKbU8oiM584RWZL5QRgS2Z6vghQStqOZ6V5ftsQ@mail.gmail.com>
References: <87vbs6qjhj.fsf_-_@blackfin.pond.sub.org>
	<5399CF09.8030803@6wind.com> <87ppidnqmy.fsf@blackfin.pond.sub.org>
	<539AC3E0.9090404@6wind.com> <539ACDE6.7020709@redhat.com>
	<539AFF7C.7090702@6wind.com> <539B064D.2050501@redhat.com>
	<CAJSP0QUcFGSGgQMjU=Ax3n6Gqx6h_ZZ1yXz6QgQiyYYe+e4K4w@mail.gmail.com>
	<53A00464.8090609@6wind.com> <53A00DEB.8030400@redhat.com>
	<20140618104849.GH14030@stefanha-thinkpad.redhat.com>
	<53A1A8BE.3000801@6wind.com>
	<CAJSP0QXpEDfqVAswv4_9CEtfwRrMYpVuRoh9T9+vi2v_wxGExQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8626326949085288923=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJSP0QXpEDfqVAswv4_9CEtfwRrMYpVuRoh9T9+vi2v_wxGExQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Henning Schild <henning.schild@siemens.com>, Olivier MATZ <olivier.matz@6wind.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "thomas.monjalon@6wind.com" <thomas.monjalon@6wind.com>, Paolo Bonzini <pbonzini@redhat.com>, Vincent JARDIN <vincent.jardin@6wind.com>, David Marchand <david.marchand@6wind.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============8626326949085288923==
Content-Type: multipart/alternative; boundary=089e013cc23673dc6804fcc2aa9b

--089e013cc23673dc6804fcc2aa9b
Content-Type: text/plain; charset=UTF-8

Hello,

Just to add my two bits.

I will fully support getting all the necessary parts of ivshmem into tree
where appropriate, both qemu and a driver in Linux.  I understand those
concerns.

I do not have the time to fully maintain ivshmem at the level needed, but I
will help as much as I can.

Sorry for the delay in contributing to this conversation.

Cheers,
Cam


On Sat, Jun 21, 2014 at 3:34 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Wed, Jun 18, 2014 at 10:57 PM, David Marchand
> <david.marchand@6wind.com> wrote:
> > On 06/18/2014 12:48 PM, Stefan Hajnoczi wrote:
> >>
> >> One more thing to add to the list:
> >>
> >> static void ivshmem_read(void *opaque, const uint8_t * buf, int flags)
> >>
> >> The "flags" argument should be "size".  Size should be checked before
> >> accessing buf.
> >
> >
> > You are welcome to send a fix and I will review it.
>
> I don't plan to send ivshmem patches in the near future because I
> don't use or support it.
>
> I thought you were interested in bringing ivshmem up to a level where
> distros feel comfortable enabling and supporting it.  Getting there
> will require effort from you to audit, clean up, and achieve test
> coverage.  That's what a maintainer needs to do in a case like this.
>
> Stefan
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>
>

--089e013cc23673dc6804fcc2aa9b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>Just to add my two bits.</div><d=
iv><br></div><div>I will fully support getting all the necessary parts of i=
vshmem into tree where appropriate, both qemu and a driver in Linux. =C2=A0=
I understand those concerns.</div>
<div><br></div><div>I do not have the time to fully maintain ivshmem at the=
 level needed, but I will help as much as I can.</div><div><br></div><div>S=
orry for the delay in contributing to this conversation.</div><div><br>
</div><div>Cheers,</div><div>Cam</div></div><div class=3D"gmail_extra"><br>=
<br><div class=3D"gmail_quote">On Sat, Jun 21, 2014 at 3:34 AM, Stefan Hajn=
oczi <span dir=3D"ltr">&lt;<a href=3D"mailto:stefanha@gmail.com" target=3D"=
_blank">stefanha@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"">On Wed, Jun 18, 2014 at 10:5=
7 PM, David Marchand<br>
&lt;<a href=3D"mailto:david.marchand@6wind.com">david.marchand@6wind.com</a=
>&gt; wrote:<br>
&gt; On 06/18/2014 12:48 PM, Stefan Hajnoczi wrote:<br>
&gt;&gt;<br>
&gt;&gt; One more thing to add to the list:<br>
&gt;&gt;<br>
&gt;&gt; static void ivshmem_read(void *opaque, const uint8_t * buf, int fl=
ags)<br>
&gt;&gt;<br>
&gt;&gt; The &quot;flags&quot; argument should be &quot;size&quot;. =C2=A0S=
ize should be checked before<br>
&gt;&gt; accessing buf.<br>
&gt;<br>
&gt;<br>
&gt; You are welcome to send a fix and I will review it.<br>
<br>
</div>I don&#39;t plan to send ivshmem patches in the near future because I=
<br>
don&#39;t use or support it.<br>
<br>
I thought you were interested in bringing ivshmem up to a level where<br>
distros feel comfortable enabling and supporting it. =C2=A0Getting there<br=
>
will require effort from you to audit, clean up, and achieve test<br>
coverage. =C2=A0That&#39;s what a maintainer needs to do in a case like thi=
s.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Stefan<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5">_____________________=
__________________________<br>
Virtualization mailing list<br>
<a href=3D"mailto:Virtualization@lists.linux-foundation.org">Virtualization=
@lists.linux-foundation.org</a><br>
<a href=3D"https://lists.linuxfoundation.org/mailman/listinfo/virtualizatio=
n" target=3D"_blank">https://lists.linuxfoundation.org/mailman/listinfo/vir=
tualization</a><br>
<br>
</div></div></blockquote></div><br></div>

--089e013cc23673dc6804fcc2aa9b--

--===============8626326949085288923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8626326949085288923==--

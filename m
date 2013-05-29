From: Bryan Venteicher <bryanv@freebsd.org>
Subject: Re: [Qemu-devel] [PATCH v2 00/11] qemu: use virtio linux headers in
	portable code
Date: Wed, 29 May 2013 00:17:02 -0500
Message-ID: <CAGaYwLdxhm78qJMYguddanS9CL=1zpsY2anJ_2suNP1v295sjQ__40393.8895361081$1369958602$gmane$org@mail.gmail.com>
References: <1369581694-1655-1-git-send-email-mst@redhat.com>
	<CAFEAcA9stW6xv3mr0ouMVTcDfVE=4=_OcUuZscguJkzGFY9WKg@mail.gmail.com>
	<20130526175110.GA3115@redhat.com>
	<CAFEAcA9HW6=F7QKpuof02hGTaAnLsZmoZ_-Yo98wKzeELi_zvA@mail.gmail.com>
	<20130526181017.GB3115@redhat.com> <51A253C6.7060303@redhat.com>
	<20130526183747.GB3427@redhat.com> <51A25A2D.8030700@redhat.com>
	<20130526200251.GA4305@redhat.com> <51A26E95.5000207@redhat.com>
	<878v314gb2.fsf@codemonkey.ws> <87ehcsptbg.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5059335054648481827=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87ehcsptbg.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtualization <virtualization@lists.linux-foundation.org>, Anthony Liguori <anthony@codemonkey.ws>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============5059335054648481827==
Content-Type: multipart/alternative; boundary=047d7b414098c2730504ddd47f7f

--047d7b414098c2730504ddd47f7f
Content-Type: text/plain; charset=ISO-8859-1

On Mon, May 27, 2013 at 6:15 AM, Rusty Russell <rusty@rustcorp.com.au>wrote:

> Anthony Liguori <anthony@codemonkey.ws> writes:
> > Paolo Bonzini <pbonzini@redhat.com> writes:
> >
> >> Il 26/05/2013 22:02, Michael S. Tsirkin ha scritto:
> >>> > My fault.  I should have looked at linux/types.h (actually
> asm-generic/).
> >>>
> >>> Not really, __uX appear in the headers that were posted.
> >
> > Which is a problem because this is a reserved namespace in C99.
>
> Personally, I find it hard to care.  What matters is not what the
> standard has carved out, but whether we have clashes, reserved namespace
> or no.  And that won't happen for these.
>
> If someone wants to convert all the kernel headers, I won't NAK it
> though.
>
> > Perhaps it's even worth moving the headers from uapi/linux to
> > uapi/virtio.  Rusty, what do you think?
>
> Hmm, #include <virtio/virtio_net.h> etc would be worthwhile if that also
> worked on FreeBSD.  Bryan CC'd...
>
>
I've only done minor work on the VirtIO headers when importing them to
FreeBSD - mostly converting the _XX types to the preferred C99 variants,
along with some misc nits. I'm not too concerned with keeping the
headers identical to what is in Linux; I manually merge in required changes
when supporting a new feature and this hasn't been an issue. I'm content as
long as they remain BSD licensed. Growing GPL'ed #includes is a bit
worrisome, but I have a hard time foreseeing what the VirtIO files
could possibly depend on that isn't trivial.

I don't think I have enough context to understand the  ' #include
<virtio/virtio_net.h> etc' suggestion ... In FreeBSD, the VirtIO headers
files exist only in the source tree along side the corresponding device,
ie. sys/dev/virtio/network/virtio_net.h, sys/dev/virtio/pci/virtio_pci.h,
etc. The FreeBSD hypervisor (bhyve) just duplicates the
needed definitions/defines. This will be fixed at some point, but bhyve's
VirtIO is so barebones there is bigger fish to fry.


> Cheers,
> Rusty.
>

--047d7b414098c2730504ddd47f7f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, May 27, 2013 at 6:15 AM, Rusty Russell <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:rusty@rustcorp.com.au" target=3D"_blank">rusty@rustcorp.com.au<=
/a>&gt;</span> wrote:<br>


<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">Anthony Liguori &lt;<a href=3D"mailto:anthony@codemonkey.w=
s" target=3D"_blank">anthony@codemonkey.ws</a>&gt; writes:<br>



&gt; Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_bl=
ank">pbonzini@redhat.com</a>&gt; writes:<br>
&gt;<br>
&gt;&gt; Il 26/05/2013 22:02, Michael S. Tsirkin ha scritto:<br>
&gt;&gt;&gt; &gt; My fault. =A0I should have looked at linux/types.h (actua=
lly asm-generic/).<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Not really, __uX appear in the headers that were posted.<br>
&gt;<br>
&gt; Which is a problem because this is a reserved namespace in C99.<br>
<br>
Personally, I find it hard to care. =A0What matters is not what the<br>
standard has carved out, but whether we have clashes, reserved namespace<br=
>
or no. =A0And that won&#39;t happen for these.<br>
<br>
If someone wants to convert all the kernel headers, I won&#39;t NAK it<br>
though.<br>
<br>
&gt; Perhaps it&#39;s even worth moving the headers from uapi/linux to<br>
&gt; uapi/virtio. =A0Rusty, what do you think?<br>
<br>
Hmm, #include &lt;virtio/virtio_net.h&gt; etc would be worthwhile if that a=
lso<br>
worked on FreeBSD. =A0Bryan CC&#39;d...<br>
<br></blockquote><div><br></div><div>I&#39;ve only done minor work on the V=
irtIO headers when importing them to FreeBSD - mostly converting the _XX ty=
pes to the=A0preferred=A0C99 variants, along with some misc nits. I&#39;m n=
ot too concerned with keeping the headers=A0identical=A0to what is in Linux=
; I manually merge in required changes when supporting a new feature and th=
is hasn&#39;t been an issue.=A0I&#39;m content as long as they remain BSD l=
icensed. Growing GPL&#39;ed #includes is a bit worrisome, but I have a hard=
 time=A0foreseeing=A0what the VirtIO files could=A0possibly=A0depend on tha=
t isn&#39;t=A0trivial.</div>


<div><br></div><div>I don&#39;t think I have enough context to understand t=
he =A0&#39;=A0#include &lt;virtio/virtio_net.h&gt; etc&#39; suggestion ... =
In FreeBSD, the VirtIO headers files exist only in the source tree along si=
de the=A0corresponding=A0device, ie. sys/dev/virtio/network/virtio_net.h, s=
ys/dev/virtio/pci/virtio_pci.h, etc. The FreeBSD hypervisor (bhyve) just du=
plicates the needed=A0definitions/defines. This will be fixed at some point=
, but bhyve&#39;s VirtIO is so barebones there is bigger fish to fry.</div>


<div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left=
-style:solid;padding-left:1ex">
Cheers,<br>
Rusty.<br>
</blockquote></div><br></div></div>

--047d7b414098c2730504ddd47f7f--

--===============5059335054648481827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5059335054648481827==--

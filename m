From: Andru Gheorghiu <gheorghiuandru@gmail.com>
Subject: Re: [PATCH] drivers: virtio: Use PTR_RET function
Date: Tue, 26 Mar 2013 09:41:46 +0200
Message-ID: <CADca43+r4kPBv-=kqo5VZ4+E2-OD1Y6ipkPXzxmFwrt2x1Z7Vw@mail.gmail.com>
References: <1364217936-6284-1-git-send-email-gheorghiuandru@gmail.com>
	<87fvzidenm.fsf@rustcorp.com.au>
	<20130325220150.af9795a7.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4270882312017725921=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130325220150.af9795a7.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============4270882312017725921==
Content-Type: multipart/alternative; boundary=047d7b3a7f10b4f5be04d8cf0db5

--047d7b3a7f10b4f5be04d8cf0db5
Content-Type: text/plain; charset=ISO-8859-1

PTR_RET does return. It's perfectly equivalent to using IS_ERR and the
returning PTR_ERR. The implementation is here [1]. The reason for using it
is this: if you have a function that does something why not call it instead
of reproducing it's behavior by explicitly writing what it does.

[1] http://lxr.free-electrons.com/source/include/linux/err.h#L55

Alexandru Gheorghiu


On Tue, Mar 26, 2013 at 7:01 AM, Andrew Morton <akpm@linux-foundation.org>wrote:

> On Tue, 26 Mar 2013 13:57:09 +1030 Rusty Russell <rusty@rustcorp.com.au>
> wrote:
>
> > Alexandru Gheorghiu <gheorghiuandru@gmail.com> writes:
> >
> > > Used PTR_RET function instead of IS_ERR and PTR_ERR.
> > > Patch found using coccinelle.
> >
> > WTF is PTR_RET?  PTR_RET doesn't return anything.  Why is it called
> > that?  It doesn't even make sense.
> >
> > ZERO_OR_PTR_ERR() maybe.
> >
> > But what problem are we solving?  Insufficient churn in the tree?  Code
> > being too readable?  This isn't some hard-to-get right corner case, or a
> > missed optimization.
> >
> > Andrew, what am I missing here?
>
> It seemed like a good idea at the time.  Merged it two years ago and
> have since been keenly awaiting an opportunity to use it.
>
> It seems that people _have_ been using it, but mainly netfilter people
> and we know they're all crazy ;)
>
>

--047d7b3a7f10b4f5be04d8cf0db5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

PTR_RET does return. It&#39;s perfectly equivalent to using IS_ERR and the =
returning PTR_ERR. The implementation is here [1]. The reason for using it =
is this: if you have a function that does something why not call it instead=
 of reproducing it&#39;s=A0behavior=A0by explicitly writing what it does.<d=
iv>
<br></div><div>[1]=A0<a href=3D"http://lxr.free-electrons.com/source/includ=
e/linux/err.h#L55">http://lxr.free-electrons.com/source/include/linux/err.h=
#L55</a></div><div><br></div><div>Alexandru Gheorghiu<div><br><br><div clas=
s=3D"gmail_quote">
On Tue, Mar 26, 2013 at 7:01 AM, Andrew Morton <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:akpm@linux-foundation.org" target=3D"_blank">akpm@linux-foundat=
ion.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im">On Tue, 26 Mar 2013 13:57:09 +1030 Rusty Russell &lt;<a h=
ref=3D"mailto:rusty@rustcorp.com.au">rusty@rustcorp.com.au</a>&gt; wrote:<b=
r>
<br>
&gt; Alexandru Gheorghiu &lt;<a href=3D"mailto:gheorghiuandru@gmail.com">gh=
eorghiuandru@gmail.com</a>&gt; writes:<br>
&gt;<br>
&gt; &gt; Used PTR_RET function instead of IS_ERR and PTR_ERR.<br>
&gt; &gt; Patch found using coccinelle.<br>
&gt;<br>
&gt; WTF is PTR_RET? =A0PTR_RET doesn&#39;t return anything. =A0Why is it c=
alled<br>
&gt; that? =A0It doesn&#39;t even make sense.<br>
&gt;<br>
&gt; ZERO_OR_PTR_ERR() maybe.<br>
&gt;<br>
&gt; But what problem are we solving? =A0Insufficient churn in the tree? =
=A0Code<br>
&gt; being too readable? =A0This isn&#39;t some hard-to-get right corner ca=
se, or a<br>
&gt; missed optimization.<br>
&gt;<br>
&gt; Andrew, what am I missing here?<br>
<br>
</div>It seemed like a good idea at the time. =A0Merged it two years ago an=
d<br>
have since been keenly awaiting an opportunity to use it.<br>
<br>
It seems that people _have_ been using it, but mainly netfilter people<br>
and we know they&#39;re all crazy ;)<br>
<br>
</blockquote></div><br></div></div>

--047d7b3a7f10b4f5be04d8cf0db5--

--===============4270882312017725921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4270882312017725921==--

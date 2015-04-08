From: Luke Gorrie <luke@snabb.co>
Subject: Re: [snabb-devel] Re: memory barriers in virtq.lua?
Date: Wed, 8 Apr 2015 05:40:11 +0200
Message-ID: <CAA2XHbehi0rFuEGXDA=KTeVr5My1gvUOpOjFP5oSEUiYozrdCA__13122.5582831123$1428464422$gmane$org@mail.gmail.com>
References: <20150127160126.GA10651@redhat.com>
	<CADDJ2=M6hwFwooXqUjUc9+JxjW1sVYvKhY9dBavrmMUrej6Ysw@mail.gmail.com>
	<CAA2XHbcU0tV0NrBXT6oh6LOz7sKm9P8jqD1=T-ZgTahSVM_qwQ@mail.gmail.com>
	<20150407172849-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2990089147354836685=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150407172849-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "snabb-devel@googlegroups.com" <snabb-devel@googlegroups.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, VirtualOpenSystems Technical Team <tech@virtualopensystems.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============2990089147354836685==
Content-Type: multipart/alternative; boundary=001a1134d092d768d605132e4949

--001a1134d092d768d605132e4949
Content-Type: text/plain; charset=UTF-8

On 7 April 2015 at 17:30, Michael S. Tsirkin <mst@redhat.com> wrote:

> Just guessing from the available info:
>
> I think you refer to this:
>         The driver MUST handle spurious interrupts from the device.
>
> The intent is to be able to handle some spurious interrupts once in a
> while.  AFAIK linux triggers the message if it gets a huge number of
> spurious interrupts for an extended period of time.
> For example, this will trigger if the device does not clear interrupt
> line after interrupt register read.
>

Thanks for that info.

The only spurious interrupt that I think we need is one when vhost-user
reconnects. That would be to cover the case where the vswitch is restarted
after writing used->idx but before sending the interrupt.

Or perhaps there is a better solution to that case?

Looking forward to getting an upstream vhost-user reconnect. one thing at a
time.. :)

Cheers,
-Luke

--001a1134d092d768d605132e4949
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On 7=
 April 2015 at 17:30, Michael S. Tsirkin <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt;</span> wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5"=
><span style=3D"color:rgb(34,34,34)">Just guessing from the available info:=
</span><br></div></div>
<br>
I think you refer to this:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 The driver MUST handle spurious interrupts from=
 the device.<br>
<br>
The intent is to be able to handle some spurious interrupts once in a<br>
while.=C2=A0 AFAIK linux triggers the message if it gets a huge number of<b=
r>
spurious interrupts for an extended period of time.<br>
For example, this will trigger if the device does not clear interrupt<br>
line after interrupt register read.<br></blockquote><div><br></div><div>Tha=
nks for that info.</div><div><br></div><div>The only spurious interrupt tha=
t I think we need is one when vhost-user reconnects. That would be to cover=
 the case where the vswitch is restarted after writing used-&gt;idx but bef=
ore sending the interrupt.</div><div><br></div><div>Or perhaps there is a b=
etter solution to that case?</div><div><br></div><div>Looking forward to ge=
tting an upstream vhost-user reconnect. one thing at a time.. :)</div><div>=
<br></div><div>Cheers,</div><div>-Luke</div><div><br></div><div><br></div><=
/div></div></div>

--001a1134d092d768d605132e4949--

--===============2990089147354836685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2990089147354836685==--

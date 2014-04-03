From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: what is the driver of vm's virtual ethernet?
Date: Wed, 2 Apr 2014 23:51:05 -0700
Message-ID: <CAOaVG16-CnPO=ijH5VSQxKf6KZwhjyE+st8D0GV5rupU7s8Kuw@mail.gmail.com>
References: <67759941.af95.14510c03e65.Coremail.kernelluck@163.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0740611493127433370=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <67759941.af95.14510c03e65.Coremail.kernelluck@163.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "longguang.yue" <kernelluck@163.com>
Cc: bridge <bridge@lists.linux-foundation.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

--===============0740611493127433370==
Content-Type: multipart/alternative; boundary=001a1136015444796d04f61dd33f

--001a1136015444796d04f61dd33f
Content-Type: text/plain; charset=ISO-8859-1

What happens is that real (or virtual) network devices call the common
network receive function - netif_receive_skb
This function has a hook rx_handler which is called if the device is part
of a bridge.
The bridge code the processes the packets and either floods them,
redirects, or drops the packets
based on the learned forwarding table.


On Sat, Mar 29, 2014 at 7:10 PM, longguang.yue <kernelluck@163.com> wrote:

> hi,all
> each port of bridge, has its packets process function called
> br_handle_frame.
> i want to know before this function called   who and how it get the
> packets?
> if it is a real physical ethernet, it  must be its driver, but for virtual
> ethernet , what is the driver?
>
>
> thanks
>
>
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

--001a1136015444796d04f61dd33f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">What happens is that real (or virtual) network devices cal=
l the common network receive function - netif_receive_skb<div>This function=
 has a hook rx_handler which is called if the device is part of a bridge.</=
div>
<div>The bridge code the processes the packets and either floods them, redi=
rects, or drops the packets</div><div>based on the learned forwarding table=
.</div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">
On Sat, Mar 29, 2014 at 7:10 PM, longguang.yue <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:kernelluck@163.com" target=3D"_blank">kernelluck@163.com</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
<div style=3D"line-height:1.7;font-size:14px;font-family:arial"><div>hi,all=
</div><div>each port of bridge, has its packets process function called br_=
handle_frame.</div><div>i want to know before this function called=A0=A0 wh=
o and how it get the packets?</div>
<div>if it is a real physical ethernet, it=A0 must be its driver, but for v=
irtual ethernet , what is the driver?</div><div>=A0</div><div>=A0</div><div=
>thanks</div></div><br><br><span title=3D"neteasefooter"><span></span></spa=
n><br>
_______________________________________________<br>
Virtualization mailing list<br>
<a href=3D"mailto:Virtualization@lists.linux-foundation.org">Virtualization=
@lists.linux-foundation.org</a><br>
<a href=3D"https://lists.linuxfoundation.org/mailman/listinfo/virtualizatio=
n" target=3D"_blank">https://lists.linuxfoundation.org/mailman/listinfo/vir=
tualization</a><br></blockquote></div><br></div>

--001a1136015444796d04f61dd33f--

--===============0740611493127433370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0740611493127433370==--

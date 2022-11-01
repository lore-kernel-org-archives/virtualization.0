Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD76C433FE
	for <virtualization@archiver.kernel.org>; Tue,  1 Nov 2022 20:21:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40E6A40A00;
	Tue,  1 Nov 2022 20:21:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 40E6A40A00
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=docker.com header.i=@docker.com header.a=rsa-sha256 header.s=google header.b=RcLYDtcm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GMLULuECHK7J; Tue,  1 Nov 2022 20:21:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 200B2409F1;
	Tue,  1 Nov 2022 20:21:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 200B2409F1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2A0DC0032;
	Tue,  1 Nov 2022 20:21:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF896C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Nov 2022 20:21:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A4F9460D70
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Nov 2022 20:21:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A4F9460D70
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=docker.com header.i=@docker.com
 header.a=rsa-sha256 header.s=google header.b=RcLYDtcm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kmJBsDMsvwLN
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Nov 2022 20:21:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A885B60AF6
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A885B60AF6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Nov 2022 20:21:17 +0000 (UTC)
Received: by mail-il1-x133.google.com with SMTP id l6so8429247ilq.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Nov 2022 13:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=docker.com; s=google;
 h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AZ0EoV4dpq0Ns5M3aKwLWX7lSPLVUvC73aUJriwY+Kk=;
 b=RcLYDtcmN5kt+DWXwZX1hmn4E391iNOFl8kt/KkJxZoO/Abin0XR6A+pCf4YpC/92A
 qVSVeIP6lDry6QZtNr8gYYokT7/ih5TQaSQRJjeA2BGwTJ+AXHe8rme7fW6eSRA6b+jv
 9m3qfp0VC7SuqdIQC2K8LyONNhTWI/kFi8kwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AZ0EoV4dpq0Ns5M3aKwLWX7lSPLVUvC73aUJriwY+Kk=;
 b=SHZTO5FU9o2IQp7k2x76o6aM+C1c9sNecwCEG1D+oALMuBWzZCUOl45jC8MNRb+P+V
 dQvHV/OXbQTeObUuT1EpO4ztP8PS8ORdjcU2JqhD8VOMGttYP2SWRxgWJ8DOoK05e+uF
 ufFyvntrqOFaPaxNFxU+GfKov0gVFFf0C1LZ5Ne3Bff19gdsAU056z+8pLJ5bID7ieu5
 JBMFDJu40jRZlaYPvsaIuNLLbvNJfFWn7QPw+MXcL162gVWHPQhMd2zzGauBHK/sUaBx
 1YagtmUmJCGG/wvkkxthXZz28DMv/Y0cXS8sVwDPcIBJ4dxmeEgL98eEAJuDuXOvXxST
 yoLg==
X-Gm-Message-State: ACrzQf3rS4s/UtTzFQAAZrwGmZsJlWpdVAfW2yKyz6lVpnINjl94wJ+Y
 mTpM0ltz+enqX4CqBN04q2muuoqO+QDWDTh4gWt1bw==
X-Received: by 2002:a92:1a12:0:b0:300:cb7d:ba3 with SMTP id
 a18-20020a921a12000000b00300cb7d0ba3mt244876ila.239.1667334076647; Tue, 01
 Nov 2022 13:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221028205646.28084-1-decui@microsoft.com>
 <20221028205646.28084-3-decui@microsoft.com>
 <20221031084327.63vikvodhs7aowhe@sgarzare-redhat>
In-Reply-To: <20221031084327.63vikvodhs7aowhe@sgarzare-redhat>
Date: Tue, 1 Nov 2022 21:21:06 +0100
Message-ID: <CANWeT6gyKNRraJWzO=02gkqDwa-=tw7NmP2WYRGUyodUBLotkQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] vsock: fix possible infinite sleep in
 vsock_connectible_wait_data()
Cc: wei.liu@kernel.org, netdev@vger.kernel.org, haiyangz@microsoft.com,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux-foundation.org,
 stephen@networkplumber.org, edumazet@google.com, kuba@kernel.org,
 arseny.krasnov@kaspersky.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
From: Frederic Dalleau via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Frederic Dalleau <frederic.dalleau@docker.com>
Content-Type: multipart/mixed; boundary="===============8970249897745251430=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============8970249897745251430==
Content-Type: multipart/alternative; boundary="0000000000005cf99f05ec6e7718"

--0000000000005cf99f05ec6e7718
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dexan, Stephano,

This solution has been proposed here,
https://lists.linuxfoundation.org/pipermail/virtualization/2022-August/0626=
56.html

Best regards,
Fr=C3=A9d=C3=A9ric

On Mon, Oct 31, 2022 at 9:43 AM Stefano Garzarella <sgarzare@redhat.com>
wrote:

> On Fri, Oct 28, 2022 at 01:56:46PM -0700, Dexuan Cui wrote:
> >Currently vsock_connectible_has_data() may miss a wakeup operation
> >between vsock_connectible_has_data() =3D=3D 0 and the prepare_to_wait().
> >
> >Fix the race by adding the process to the wait qeuue before checking
>
> s/qeuue/queue
>
> >vsock_connectible_has_data().
> >
> >Fixes: b3f7fd54881b ("af_vsock: separate wait data loop")
> >Signed-off-by: Dexuan Cui <decui@microsoft.com>
> >---
> > net/vmw_vsock/af_vsock.c | 7 ++++++-
> > 1 file changed, 6 insertions(+), 1 deletion(-)
> >
> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >index d258fd43092e..03a6b5bc6ba7 100644
> >--- a/net/vmw_vsock/af_vsock.c
> >+++ b/net/vmw_vsock/af_vsock.c
> >@@ -1905,8 +1905,11 @@ static int vsock_connectible_wait_data(struct soc=
k
> *sk,
> >       err =3D 0;
> >       transport =3D vsk->transport;
> >
> >-      while ((data =3D vsock_connectible_has_data(vsk)) =3D=3D 0) {
> >+      while (1) {
> >               prepare_to_wait(sk_sleep(sk), wait, TASK_INTERRUPTIBLE);
> >+              data =3D vsock_connectible_has_data(vsk);
> >+              if (data !=3D 0)
> >+                      break;
> >
> >               if (sk->sk_err !=3D 0 ||
> >                   (sk->sk_shutdown & RCV_SHUTDOWN) ||
> >@@ -1937,6 +1940,8 @@ static int vsock_connectible_wait_data(struct sock
> *sk,
> >                       err =3D -EAGAIN;
> >                       break;
> >               }
> >+
> >+              finish_wait(sk_sleep(sk), wait);
>
> Since we are going to call again prepare_to_wait() on top of the loop,
> is finish_wait() call here really needed?
>
> What about following what we do in vsock_accept and vsock_connect?
>
>      prepare_to_wait()
>
>      while (condition) {
>          ...
>          prepare_to_wait();
>      }
>
>      finish_wait()
>
> I find it a little more readable, but your solution is fine too.
>
> Thanks,
> Stefano
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

--0000000000005cf99f05ec6e7718
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Dexan, Stephano,</div><div><br></div><div>This sol=
ution has been proposed here,</div><div><a href=3D"https://lists.linuxfound=
ation.org/pipermail/virtualization/2022-August/062656.html">https://lists.l=
inuxfoundation.org/pipermail/virtualization/2022-August/062656.html</a></di=
v><div><br></div><div>Best regards,</div><div>Fr=C3=A9d=C3=A9ric</div></div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mo=
n, Oct 31, 2022 at 9:43 AM Stefano Garzarella &lt;<a href=3D"mailto:sgarzar=
e@redhat.com">sgarzare@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Fri, Oct 28, 2022 at 01:56:46PM -0700, =
Dexuan Cui wrote:<br>
&gt;Currently vsock_connectible_has_data() may miss a wakeup operation<br>
&gt;between vsock_connectible_has_data() =3D=3D 0 and the prepare_to_wait()=
.<br>
&gt;<br>
&gt;Fix the race by adding the process to the wait qeuue before checking<br=
>
<br>
s/qeuue/queue<br>
<br>
&gt;vsock_connectible_has_data().<br>
&gt;<br>
&gt;Fixes: b3f7fd54881b (&quot;af_vsock: separate wait data loop&quot;)<br>
&gt;Signed-off-by: Dexuan Cui &lt;<a href=3D"mailto:decui@microsoft.com" ta=
rget=3D"_blank">decui@microsoft.com</a>&gt;<br>
&gt;---<br>
&gt; net/vmw_vsock/af_vsock.c | 7 ++++++-<br>
&gt; 1 file changed, 6 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt;diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c<br>
&gt;index d258fd43092e..03a6b5bc6ba7 100644<br>
&gt;--- a/net/vmw_vsock/af_vsock.c<br>
&gt;+++ b/net/vmw_vsock/af_vsock.c<br>
&gt;@@ -1905,8 +1905,11 @@ static int vsock_connectible_wait_data(struct so=
ck *sk,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0transport =3D vsk-&gt;transport;<br>
&gt;<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 while ((data =3D vsock_connectible_has_data(vsk))=
 =3D=3D 0) {<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 while (1) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prepare_to_wait(=
sk_sleep(sk), wait, TASK_INTERRUPTIBLE);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D vsock_connec=
tible_has_data(vsk);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (data !=3D 0)<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sk-&gt;sk_er=
r !=3D 0 ||<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s=
k-&gt;sk_shutdown &amp; RCV_SHUTDOWN) ||<br>
&gt;@@ -1937,6 +1940,8 @@ static int vsock_connectible_wait_data(struct soc=
k *sk,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0err =3D -EAGAIN;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;+<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 finish_wait(sk_sleep(=
sk), wait);<br>
<br>
Since we are going to call again prepare_to_wait() on top of the loop, <br>
is finish_wait() call here really needed?<br>
<br>
What about following what we do in vsock_accept and vsock_connect?<br>
<br>
=C2=A0 =C2=A0 =C2=A0prepare_to_wait()<br>
<br>
=C2=A0 =C2=A0 =C2=A0while (condition) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prepare_to_wait();<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0finish_wait()<br>
<br>
I find it a little more readable, but your solution is fine too.<br>
<br>
Thanks,<br>
Stefano<br>
<br>
_______________________________________________<br>
Virtualization mailing list<br>
<a href=3D"mailto:Virtualization@lists.linux-foundation.org" target=3D"_bla=
nk">Virtualization@lists.linux-foundation.org</a><br>
<a href=3D"https://lists.linuxfoundation.org/mailman/listinfo/virtualizatio=
n" rel=3D"noreferrer" target=3D"_blank">https://lists.linuxfoundation.org/m=
ailman/listinfo/virtualization</a><br>
</blockquote></div>

--0000000000005cf99f05ec6e7718--

--===============8970249897745251430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8970249897745251430==--

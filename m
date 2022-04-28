Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44395C433EF
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 11:43:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFD4E827FB;
	Thu, 28 Apr 2022 11:43:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id clYribBIcdOy; Thu, 28 Apr 2022 11:43:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 75E4D82E5F;
	Thu, 28 Apr 2022 11:43:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39CE0C0039;
	Thu, 28 Apr 2022 11:43:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5AB35C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 11:43:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5170982E5F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 11:43:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aQ9_T6Yt-_Lx
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 11:43:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 194EF827FB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 11:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651146215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A3VNVQbyWOMiG5MSi1c3OlpS/oGdXctdWFVWFZf8IW0=;
 b=Jgy5UnCxwEtew8OlWocJhF3vTRsqoJZZcfPTVyJli7sAf7XgumHk5Pqsbr+xUA9xECXhtV
 0teMxGsJsf0Eunu57bDV/IeCzTtS9v/eGA+FtpiNsdMwlM0+krtag6yjrWA8PiWpsUpB2X
 7xesXMbJXFQ5DeWDO4PYFl8V5B9N4Kg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-wZfUIHuINIq9lJKyXOOcMg-1; Thu, 28 Apr 2022 07:43:34 -0400
X-MC-Unique: wZfUIHuINIq9lJKyXOOcMg-1
Received: by mail-wm1-f70.google.com with SMTP id
 125-20020a1c0283000000b003928cd3853aso4171379wmc.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 04:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:message-id:mime-version:subject:date
 :in-reply-to:cc:to:references;
 bh=ctGs0iw1V61njzeHFcs+s1y0v3JVBzH7Bf3gRkaSckw=;
 b=hfIKSjtEvTJwGqwe3s4AOAXgPHJ1pNYOVsAV04TOEbr3GojPqYMq0QE/CzsXhHTkSL
 ggeACMoNvvQDzEzNO2+/7yKK2RZJwuCqrQnQogBbzh6M2XxV8wgJu0oerExdXNb9Nhmb
 L/0m5sSUuY5n0KHxIaRWDKHmyJOonGGS/WhBFeiRL2+HfpGpsTv6t+o/NzCvPY5IPuWU
 2D8yBhyxt0I+2bHGgc5TcPdkb4LvqNEKadCw9CutLpEPV4aF2HiF8Yg4pz6iRmYzJzu4
 x9R6V4+xEdssfa5NKhBYulty2HfEMsmmvP9uG/dVVhm+HTIOIn33Unve9FKTmCELSk60
 carg==
X-Gm-Message-State: AOAM532cZ7hcwwANTjwZMsTPZPJrxTzxbgACeNp3zhCFv11xJMm6+yAi
 fNVq2amU/lYeLR+IkhjJN+cqR4ChsKTn4M+RwlugBgTbJF6imAU07OwTRCCOhK24BvgnMRMclop
 qm4qcZ5LwLBkMxFkWV7lTXJYh3VPRK9LQxWvSOv2LKQ==
X-Received: by 2002:a05:600c:1ca2:b0:394:19df:20df with SMTP id
 k34-20020a05600c1ca200b0039419df20dfmr232660wms.188.1651146213012; 
 Thu, 28 Apr 2022 04:43:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzx9pjkpMZ6hV7aEf7LsQskCOqcMzHhPpf4fjCB3svvJQ17BrUHcLUzu7rnoqB1of8M/gkIkw==
X-Received: by 2002:a05:600c:1ca2:b0:394:19df:20df with SMTP id
 k34-20020a05600c1ca200b0039419df20dfmr232636wms.188.1651146212652; 
 Thu, 28 Apr 2022 04:43:32 -0700 (PDT)
Received: from smtpclient.apple ([2a01:e0a:834:5aa0:5160:7495:6b8e:3f15])
 by smtp.gmail.com with ESMTPSA id
 b11-20020adfc74b000000b0020ad84d3fa3sm11802950wrh.44.2022.04.28.04.43.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 28 Apr 2022 04:43:31 -0700 (PDT)
From: Christophe Marie Francois Dupont de Dinechin <cdupontd@redhat.com>
Message-Id: <0C8432EA-7156-492F-A5F5-B7683F37BAFF@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] virtio-pci: Remove wrong address verification in
 vp_del_vqs()
Date: Thu, 28 Apr 2022 13:43:30 +0200
In-Reply-To: <20220428070345-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220415023002.49805-1-muriloo@linux.ibm.com>
 <e8620e70-16bb-639c-9446-68dcd199253f@linux.ibm.com>
 <A5CD1C91-F5D0-4109-9894-824184362B5C@redhat.com>
 <B954A683-EE43-4469-B57A-EB8C6B671BEC@redhat.com>
 <2F2EFFE9-5174-49A8-A71F-EE134D387E07@redhat.com>
 <20220428070345-mutt-send-email-mst@kernel.org>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cdupontd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mopsfelder@gmail.com, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Christophe de Dinechin <dinechin@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============2866727343750860914=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============2866727343750860914==
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_6C207FBF-1664-40D5-A393-41045FCBA55D"

--Apple-Mail=_6C207FBF-1664-40D5-A393-41045FCBA55D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 28 Apr 2022, at 13:03, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Thu, Apr 28, 2022 at 11:55:31AM +0200, Christophe Marie Francois Dupon=
t de Dinechin wrote:
>>=20
>>=20
>>> On 28 Apr 2022, at 11:51, Christophe Marie Francois Dupont de Dinechin =
<cdupontd@redhat.com> wrote:
>>>=20
>>>=20
>>>=20
>>>> On 28 Apr 2022, at 11:46, Christophe Marie Francois Dupont de Dinechin=
 <cdupontd@redhat.com> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On 15 Apr 2022, at 05:51, Murilo Opsfelder Ara=C3=BAjo <muriloo@linux=
.ibm.com> wrote:
>>>>>=20
>>>>> On 4/14/22 23:30, Murilo Opsfelder Araujo wrote:
>>>>>> GCC 12 enhanced -Waddress when comparing array address to null [0],
>>>>>> which warns:
>>>>>> drivers/virtio/virtio_pci_common.c: In function =E2=80=98vp_del_vqs=
=E2=80=99:
>>>>>> drivers/virtio/virtio_pci_common.c:257:29: warning: the comparison w=
ill always evaluate as =E2=80=98true=E2=80=99 for the pointer operand in =
=E2=80=98vp_dev->msix_affinity_masks + (sizetype)((long unsigned int)i * 25=
6)=E2=80=99 must not be NULL [-Waddress]
>>>>>> 257 | if (vp_dev->msix_affinity_masks[i])
>>>>>> | ^~~~~~
>>>>>> In fact, the verification is comparing the result of a pointer
>>>>>> arithmetic, the address "msix_affinity_masks + i", which will always
>>>>>> evaluate to true.
>>>>>> Under the hood, free_cpumask_var() calls kfree(), which is safe to p=
ass
>>>>>> NULL, not requiring non-null verification. So remove the verificatio=
n
>>>>>> to make compiler happy (happy compiler, happy life).
>>>>>> [0] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D102103
>>>>>> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
>>>>>> ---
>>>>>> drivers/virtio/virtio_pci_common.c | 3 +--
>>>>>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/vir=
tio_pci_common.c
>>>>>> index d724f676608b..5046efcffb4c 100644
>>>>>> --- a/drivers/virtio/virtio_pci_common.c
>>>>>> +++ b/drivers/virtio/virtio_pci_common.c
>>>>>> @@ -254,8 +254,7 @@ void vp_del_vqs(struct virtio_device *vdev)
>>>>>> =09if (vp_dev->msix_affinity_masks) {
>>>>>> =09=09for (i =3D 0; i < vp_dev->msix_vectors; i++)
>>>>>> -=09=09=09if (vp_dev->msix_affinity_masks[i])
>>>>>> -=09=09=09=09free_cpumask_var(vp_dev->msix_affinity_masks[i]);
>>>>>> +=09=09=09free_cpumask_var(vp_dev->msix_affinity_masks[i]);
>>>>>> =09}
>>>>>> =09if (vp_dev->msix_enabled) {
>>>>>=20
>>>>> After I sent this message, I realized that Christophe (copied here)
>>>>> had already proposed a fix:
>>>>>=20
>>>>> https://lore.kernel.org/lkml/20220414150855.2407137-4-dinechin@redhat=
.com/
>>>>>=20
>>>>> Christophe,
>>>>>=20
>>>>> Since free_cpumask_var() calls kfree() and kfree() is null-safe,
>>>>> can we just drop this null verification and call free_cpumask_var() r=
ight away?
>>>>=20
>>>> Apologies for the delay in responding, broken laptop=E2=80=A6
>>>>=20
>>>> In the case where CONFIG_CPUMASK_OFFSTACK is not defined, we have:
>>>>=20
>>>> =09typedef struct cpumask cpumask_var_t[1];
>>>>=20
>>>> So that vp_dev->msix_affinity_masks[i] is statically not null (that=E2=
=80=99s the warning)
>>>> but also a static pointer, so not kfree-safe IMO.
>>>=20
>>> =E2=80=A6 which also renders my own patch invalid :-/
>>>=20
>>> Compiler warnings are good. Clearly not sufficient.
>>=20
>> Ah, I just noticed that free_cpumask_var is a noop in that case.
>>=20
>> So yes, your fix is better :-)
>=20
> ACK then?

Yes.

Acked-by: Christophe de Dinechin <dinechin@redhat.com <mailto:dinechin@redh=
at.com>>

>=20


--Apple-Mail=_6C207FBF-1664-40D5-A393-41045FCBA55D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: s=
pace; line-break: after-white-space;" class=3D""><br class=3D""><div><br cl=
ass=3D""><blockquote type=3D"cite" class=3D""><div class=3D"">On 28 Apr 202=
2, at 13:03, Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" class=
=3D"">mst@redhat.com</a>&gt; wrote:</div><br class=3D"Apple-interchange-new=
line"><div class=3D""><div class=3D"">On Thu, Apr 28, 2022 at 11:55:31AM +0=
200, Christophe Marie Francois Dupont de Dinechin wrote:<br class=3D""><blo=
ckquote type=3D"cite" class=3D""><br class=3D""><br class=3D""><blockquote =
type=3D"cite" class=3D"">On 28 Apr 2022, at 11:51, Christophe Marie Francoi=
s Dupont de Dinechin &lt;<a href=3D"mailto:cdupontd@redhat.com" class=3D"">=
cdupontd@redhat.com</a>&gt; wrote:<br class=3D""><br class=3D""><br class=
=3D""><br class=3D""><blockquote type=3D"cite" class=3D"">On 28 Apr 2022, a=
t 11:46, Christophe Marie Francois Dupont de Dinechin &lt;<a href=3D"mailto=
:cdupontd@redhat.com" class=3D"">cdupontd@redhat.com</a>&gt; wrote:<br clas=
s=3D""><br class=3D""><br class=3D""><br class=3D""><blockquote type=3D"cit=
e" class=3D"">On 15 Apr 2022, at 05:51, Murilo Opsfelder Ara=C3=BAjo &lt;<a=
 href=3D"mailto:muriloo@linux.ibm.com" class=3D"">muriloo@linux.ibm.com</a>=
&gt; wrote:<br class=3D""><br class=3D"">On 4/14/22 23:30, Murilo Opsfelder=
 Araujo wrote:<br class=3D""><blockquote type=3D"cite" class=3D"">GCC 12 en=
hanced -Waddress when comparing array address to null [0],<br class=3D"">wh=
ich warns:<br class=3D"">drivers/virtio/virtio_pci_common.c: In function =
=E2=80=98vp_del_vqs=E2=80=99:<br class=3D"">drivers/virtio/virtio_pci_commo=
n.c:257:29: warning: the comparison will always evaluate as =E2=80=98true=
=E2=80=99 for the pointer operand in =E2=80=98vp_dev-&gt;msix_affinity_mask=
s + (sizetype)((long unsigned int)i * 256)=E2=80=99 must not be NULL [-Wadd=
ress]<br class=3D"">257 | if (vp_dev-&gt;msix_affinity_masks[i])<br class=
=3D"">| ^~~~~~<br class=3D"">In fact, the verification is comparing the res=
ult of a pointer<br class=3D"">arithmetic, the address "msix_affinity_masks=
 + i", which will always<br class=3D"">evaluate to true.<br class=3D"">Unde=
r the hood, free_cpumask_var() calls kfree(), which is safe to pass<br clas=
s=3D"">NULL, not requiring non-null verification. So remove the verificatio=
n<br class=3D"">to make compiler happy (happy compiler, happy life).<br cla=
ss=3D"">[0] <a href=3D"https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D10210=
3" class=3D"">https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D102103</a><br =
class=3D"">Signed-off-by: Murilo Opsfelder Araujo &lt;<a href=3D"mailto:mur=
iloo@linux.ibm.com" class=3D"">muriloo@linux.ibm.com</a>&gt;<br class=3D"">=
---<br class=3D"">drivers/virtio/virtio_pci_common.c | 3 +--<br class=3D"">=
1 file changed, 1 insertion(+), 2 deletions(-)<br class=3D"">diff --git a/d=
rivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c<br c=
lass=3D"">index d724f676608b..5046efcffb4c 100644<br class=3D"">--- a/drive=
rs/virtio/virtio_pci_common.c<br class=3D"">+++ b/drivers/virtio/virtio_pci=
_common.c<br class=3D"">@@ -254,8 +254,7 @@ void vp_del_vqs(struct virtio_d=
evice *vdev)<br class=3D""><span class=3D"Apple-tab-span" style=3D"white-sp=
ace:pre">=09</span>if (vp_dev-&gt;msix_affinity_masks) {<br class=3D""><spa=
n class=3D"Apple-tab-span" style=3D"white-space:pre">=09</span><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">=09</span>for (i =3D 0; i &lt=
; vp_dev-&gt;msix_vectors; i++)<br class=3D"">-<span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">=09</span><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">=09</span><span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">=09</span>if (vp_dev-&gt;msix_affinity_masks[i])<br class=3D""=
>-<span class=3D"Apple-tab-span" style=3D"white-space:pre">=09</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">=09</span><span class=3D=
"Apple-tab-span" style=3D"white-space:pre">=09</span><span class=3D"Apple-t=
ab-span" style=3D"white-space:pre">=09</span>free_cpumask_var(vp_dev-&gt;ms=
ix_affinity_masks[i]);<br class=3D"">+<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">=09</span><span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">=09</span><span class=3D"Apple-tab-span" style=3D"white-space:=
pre">=09</span>free_cpumask_var(vp_dev-&gt;msix_affinity_masks[i]);<br clas=
s=3D""><span class=3D"Apple-tab-span" style=3D"white-space:pre">=09</span>}=
<br class=3D""><span class=3D"Apple-tab-span" style=3D"white-space:pre">=09=
</span>if (vp_dev-&gt;msix_enabled) {<br class=3D""></blockquote><br class=
=3D"">After I sent this message, I realized that Christophe (copied here)<b=
r class=3D"">had already proposed a fix:<br class=3D""><br class=3D""><a hr=
ef=3D"https://lore.kernel.org/lkml/20220414150855.2407137-4-dinechin@redhat=
.com/" class=3D"">https://lore.kernel.org/lkml/20220414150855.2407137-4-din=
echin@redhat.com/</a><br class=3D""><br class=3D"">Christophe,<br class=3D"=
"><br class=3D"">Since free_cpumask_var() calls kfree() and kfree() is null=
-safe,<br class=3D"">can we just drop this null verification and call free_=
cpumask_var() right away?<br class=3D""></blockquote><br class=3D"">Apologi=
es for the delay in responding, broken laptop=E2=80=A6<br class=3D""><br cl=
ass=3D"">In the case where CONFIG_CPUMASK_OFFSTACK is not defined, we have:=
<br class=3D""><br class=3D""><span class=3D"Apple-tab-span" style=3D"white=
-space:pre">=09</span>typedef struct cpumask cpumask_var_t[1];<br class=3D"=
"><br class=3D"">So that vp_dev-&gt;msix_affinity_masks[i] is statically no=
t null (that=E2=80=99s the warning)<br class=3D"">but also a static pointer=
, so not kfree-safe IMO.<br class=3D""></blockquote><br class=3D"">=E2=80=
=A6 which also renders my own patch invalid :-/<br class=3D""><br class=3D"=
">Compiler warnings are good. Clearly not sufficient.<br class=3D""></block=
quote><br class=3D"">Ah, I just noticed that free_cpumask_var is a noop in =
that case.<br class=3D""><br class=3D"">So yes, your fix is better :-)<br c=
lass=3D""></blockquote><br class=3D"">ACK then?<br class=3D""></div></div><=
/blockquote><div><br class=3D""></div><div>Yes.</div><div><br class=3D""></=
div><div>Acked-by: Christophe de Dinechin &lt;<a href=3D"mailto:dinechin@re=
dhat.com" class=3D"">dinechin@redhat.com</a>&gt;</div><br class=3D""><block=
quote type=3D"cite" class=3D""><div class=3D""><div class=3D""><br class=3D=
""></div></div></blockquote></div><br class=3D""></body></html>
--Apple-Mail=_6C207FBF-1664-40D5-A393-41045FCBA55D--


--===============2866727343750860914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2866727343750860914==--


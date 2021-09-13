Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CB8C433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 12:26:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 874D060F6C
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 12:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 874D060F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5199E606ED;
	Mon, 13 Sep 2021 12:26:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iwVMGuO32m6O; Mon, 13 Sep 2021 12:26:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EF27260669;
	Mon, 13 Sep 2021 12:26:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE21CC0011;
	Mon, 13 Sep 2021 12:26:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE15EC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 12:26:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ABBEF401CD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 12:26:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lDER2x1u2Wbp
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 12:26:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7772D400C3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 12:26:51 +0000 (UTC)
Received: by mail-io1-xd34.google.com with SMTP id b200so11746772iof.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 05:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2ekkJ1mBgfTRlb47nm2TtvJwx4CSRMP/xrIjq+fk3Oo=;
 b=sGT+QAuwSW19EIXWFaWPXmdLxMbAFgXIHEy1xDAhU4+z+jAzzSQS8jEdiq1cOKjNXp
 AEA0Q4vypqOr12G4dx7k6Kv8g5kqZHMsSnW/3g2njJuRPj3NrjpK0PQJgzCqh//IvHS8
 ssPHA1om8oN1Y1yS6PS51U5s/ObJsP60RZJSA6ZvsSFkUmBjSKvavE2otYUu1FWf1UBe
 w84GSETP+8+fMaPgwqmfy9qTAre5qBEYd0WFlBNCuRT3zVqPBZTxu/VEmc6yBJvVbIV4
 /brcDS179JhN1HuUAoc0+Yn692V0vDXnurZj3h/lsx7rFAga8wx2gFrm7UL8LRB4mPw2
 Xrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2ekkJ1mBgfTRlb47nm2TtvJwx4CSRMP/xrIjq+fk3Oo=;
 b=r+I7NVXd08/S0+Ju0MAEEFnf3uyrchlXsAP5thbCO2NWtHh/WnIuh5FpwGLggP4nWQ
 +b01vVmkpPUqaR7qZH+yUzt0GONqvvMh6Vqd6iTv3LSObtvWE2NDgLGhqcTxGxnr+XLz
 0FoUEtOeTTHzI56txEqlJReZfrUhOLWHXEYHbxRnA9Q4ekmfGls5WKWb9iFFZ4sOY/v+
 mvQhcEOsaOr2HEnu7RQB4Ge2ymJPj77ewMKtxORgxQultsPwtCBRuSFTyYkLhXqJBbB7
 av7moGu+StahQLINz2FVM0XzItkS0GimVcbw20R9yoQqrHPnArjckkhujj5yPHX8tZ4/
 lZFw==
X-Gm-Message-State: AOAM5313xIzTmsAzsBOGEPBmXWPVqYktAfXT6QjucbXqTQvE2WraKJgo
 /b9l2chieqs980TFe1fkx4rD2hf3JnwWXZ6WnX4ZzQ==
X-Google-Smtp-Source: ABdhPJyfvXrzBw0lHhWkmwc0B+rZ3jHO1sjYpaCBCUtFMbcAvp6p8q5S8TNTdoUw9vOKbXklqlXib5417wFfXH92wo4=
X-Received: by 2002:a02:5d83:: with SMTP id w125mr9133413jaa.20.1631536010534; 
 Mon, 13 Sep 2021 05:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210913104640.85839-1-mst@redhat.com>
In-Reply-To: <20210913104640.85839-1-mst@redhat.com>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 13 Sep 2021 17:56:39 +0530
Message-ID: <CAKohpo=U5wrBuNumOD=rOwCzewExsJj-M0fBhvN2BqH3rirk=Q@mail.gmail.com>
Subject: Re: [PATCH] virtio: don't fail on !of_device_is_compatible
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Bill Mills <bill.mills@linaro.org>
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
Content-Type: multipart/mixed; boundary="===============1879831233963830726=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============1879831233963830726==
Content-Type: multipart/alternative; boundary="00000000000058b8c605cbdf94e9"

--00000000000058b8c605cbdf94e9
Content-Type: text/plain; charset="UTF-8"

Sorry about HTML (From phone)..

On Mon, 13 Sep 2021, 16:17 Michael S. Tsirkin, <mst@redhat.com> wrote:

> A recent change checking of_device_is_compatible on probe broke some
> powerpc/pseries setups. Apparently there virtio devices do not have a
> "compatible" property - they are matched by PCI vendor/device ids.
>
> Let's just skip of_node setup but proceed with initialization like we
> did previously.
>
> Fixes: 694a1116b405 ("virtio: Bind virtio device to device-tree node")
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> Arnd could you help review this pls? Viresh is on vacation.
>
>  drivers/virtio/virtio.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index c46cc1fbc7ae..19a70a2361b4 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -347,8 +347,13 @@ static int virtio_device_of_init(struct virtio_device
> *dev)
>         ret = snprintf(compat, sizeof(compat), "virtio,device%x",
> dev->id.device);
>         BUG_ON(ret >= sizeof(compat));
>
> +       /*
> +        * On powerpc/pseries virtio devices are PCI devices so PCI
> +        * vendor/device ids play the role of the "compatible" property.
> +        * Simply don't init of_node in this case.
> +        */
>         if (!of_device_is_compatible(np, compat)) {
> -               ret = -EINVAL;
> +               ret = 0;
>                 goto out;
>         }
>

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

>

--00000000000058b8c605cbdf94e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Sorry about HTML (From phone)..<br><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 13 Sep 2021, 16=
:17 Michael S. Tsirkin, &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">A recent change ch=
ecking of_device_is_compatible on probe broke some<br>
powerpc/pseries setups. Apparently there virtio devices do not have a<br>
&quot;compatible&quot; property - they are matched by PCI vendor/device ids=
.<br>
<br>
Let&#39;s just skip of_node setup but proceed with initialization like we<b=
r>
did previously.<br>
<br>
Fixes: 694a1116b405 (&quot;virtio: Bind virtio device to device-tree node&q=
uot;)<br>
Reported-by: Alexey Kardashevskiy &lt;<a href=3D"mailto:aik@ozlabs.ru" targ=
et=3D"_blank" rel=3D"noreferrer">aik@ozlabs.ru</a>&gt;<br>
Cc: Arnd Bergmann &lt;<a href=3D"mailto:arnd@arndb.de" target=3D"_blank" re=
l=3D"noreferrer">arnd@arndb.de</a>&gt;<br>
Cc: Viresh Kumar &lt;<a href=3D"mailto:viresh.kumar@linaro.org" target=3D"_=
blank" rel=3D"noreferrer">viresh.kumar@linaro.org</a>&gt;<br>
Signed-off-by: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">mst@redhat.com</a>&gt;<br>
---<br>
<br>
Arnd could you help review this pls? Viresh is on vacation.<br>
<br>
=C2=A0drivers/virtio/virtio.c | 7 ++++++-<br>
=C2=A01 file changed, 6 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c<br>
index c46cc1fbc7ae..19a70a2361b4 100644<br>
--- a/drivers/virtio/virtio.c<br>
+++ b/drivers/virtio/virtio.c<br>
@@ -347,8 +347,13 @@ static int virtio_device_of_init(struct virtio_device =
*dev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D snprintf(compat, sizeof(compat), &quot;=
virtio,device%x&quot;, dev-&gt;id.device);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG_ON(ret &gt;=3D sizeof(compat));<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * On powerpc/pseries virtio devices are PCI de=
vices so PCI<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * vendor/device ids play the role of the &quot=
;compatible&quot; property.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Simply don&#39;t init of_node in this case.<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!of_device_is_compatible(np, compat)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EINVAL;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></blockquote></div></div><div dir=3D"auto"=
><br></div><div dir=3D"auto">Reviewed-by: Viresh Kumar &lt;<a href=3D"mailt=
o:viresh.kumar@linaro.org">viresh.kumar@linaro.org</a>&gt;</div><div dir=3D=
"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--00000000000058b8c605cbdf94e9--

--===============1879831233963830726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1879831233963830726==--

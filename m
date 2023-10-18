Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED662CDB47E
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 23:25:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94AB961070;
	Wed, 18 Oct 2023 23:25:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 94AB961070
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=X8COWS1C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3HNGrJ7a0sNj; Wed, 18 Oct 2023 23:25:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 91F8061392;
	Wed, 18 Oct 2023 23:25:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 91F8061392
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69E51C0039;
	Wed, 18 Oct 2023 23:25:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F4FDC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 23:25:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0CE7541969
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 23:25:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0CE7541969
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=X8COWS1C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 026M0myS33ik
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 23:25:30 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3E83F408B7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 23:25:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3E83F408B7
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9c2a0725825so658955166b.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 16:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697671528; x=1698276328;
 darn=lists.linux-foundation.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9Q2SL9D0t5i70Rk9KsizMgca9slcDcaDWQWMlQS8ivQ=;
 b=X8COWS1Cf68WMcbBU6PsqXeqwsI1C3iMsfjr3HWorUCMSGDYfN7v2DvGLmR+YkvDhg
 radpj6LF4zOpAlEPbGw5+jQGnn4nyrsNuYXy79NANcbhhFENwY8LeWlOtG25KN7LCssB
 uwfPDNorf7VdRiuApeR/jBj6d/OQbXtFVu7BA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697671528; x=1698276328;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Q2SL9D0t5i70Rk9KsizMgca9slcDcaDWQWMlQS8ivQ=;
 b=T2u2EmBr+7sdIlJg3gYE+TMFJtfJxjdlZPaNqtTDxekVtJu23XMqknblgHjCzz/wGQ
 OnAersU4U2i4L1Owvc92fxzRuEmHw927wANr+Q8e5S2A2tV625p53EsM3m99Lo4I3fmA
 5PFfYivCpl1btx6P1FP/HNLMAnV3zdNj9xhSIpx5J4mmBeJHNO7xGcECzr81OgpMvUae
 K8UPc7U9RWtmq3c7UllhFb/hvJFwn7se9OUSbNHRx+ea7ITmMz8QkNwcvsZhVyUJ9A4h
 xWNcxbmUjBN5fhpKYw5ei6ZyP3lBC7xtnm/8QTj4Nbg8B1NBjUrRLypk/+lSPW1W5TM5
 XWXQ==
X-Gm-Message-State: AOJu0YwPW0qL79DWBZT+0nOKj2GMj/h2H0Jm1junRG4gHyFtQvE99d4n
 6aDSTfWDna0as6E+i1xXaB7zLEZ60EWXisDcvsopFw==
X-Google-Smtp-Source: AGHT+IEHzPBHqcU9J4aSwr3pG6IjvSdqfOPfvQRUbFtZDUnFMgRMDxyHK0bnfThLH2WPfwe/SfY0vg==
X-Received: by 2002:a17:907:1c86:b0:9ae:5be8:ff90 with SMTP id
 nb6-20020a1709071c8600b009ae5be8ff90mr474514ejc.68.1697671528209; 
 Wed, 18 Oct 2023 16:25:28 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com.
 [209.85.208.47]) by smtp.gmail.com with ESMTPSA id
 fi3-20020a170906da0300b009c0c511bd62sm2431356ejb.197.2023.10.18.16.25.27
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 16:25:27 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-53eeb28e8e5so2739a12.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 16:25:27 -0700 (PDT)
X-Received: by 2002:aa7:c452:0:b0:53f:91cc:1d04 with SMTP id
 n18-20020aa7c452000000b0053f91cc1d04mr25683edr.4.1697671527546; Wed, 18 Oct
 2023 16:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231010135722.1142265-1-ray.huang@amd.com>
 <2f8bcce1-6551-6c2d-481c-67502c82bc68@collabora.com>
 <2c162058-288c-9e9e-48d5-3b2ddb0cc1fa@collabora.com>
 <ZSYnQbHUecuUlwvr@amd.com>
In-Reply-To: <ZSYnQbHUecuUlwvr@amd.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed, 18 Oct 2023 16:25:15 -0700
X-Gmail-Original-Message-ID: <CAAfnVB=Mki1zEyjByJ_7tRrib74E4KSbjezqQcb_Uia8EQEXHw@mail.gmail.com>
Message-ID: <CAAfnVB=Mki1zEyjByJ_7tRrib74E4KSbjezqQcb_Uia8EQEXHw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/virtio: add new virtio gpu capset definitions
To: Huang Rui <ray.huang@amd.com>
Cc: "Huang, Honglei1" <Honglei1.Huang@amd.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, "Stabellini,
 Stefano" <stefano.stabellini@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "Chen,
 Jiqian" <Jiqian.Chen@amd.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, David Airlie <airlied@redhat.com>,
 "Zhang, Julia" <Julia.Zhang@amd.com>, Chia-I Wu <olvaffe@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============3712804351133585730=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============3712804351133585730==
Content-Type: multipart/alternative; boundary="00000000000058df6c060805f461"

--00000000000058df6c060805f461
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 9:41=E2=80=AFPM Huang Rui <ray.huang@amd.com> wrote=
:

> On Tue, Oct 10, 2023 at 11:52:14PM +0800, Dmitry Osipenko wrote:
> > On 10/10/23 18:40, Dmitry Osipenko wrote:
> > > On 10/10/23 16:57, Huang Rui wrote:
> > >> These definitions are used fro qemu, and qemu imports this marco in
> the
> > >> headers to enable gfxstream, venus, cross domain, and drm (native
> > >> context) for virtio gpu. So it should add them even kernel doesn't u=
se
> > >> this.
> > >>
> > >> Signed-off-by: Huang Rui <ray.huang@amd.com>
> > >> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > >> ---
> > >>
> > >> Changes V1 -> V2:
> > >> - Add all capsets including gfxstream and venus in kernel header
> (Dmitry Osipenko)
> > >>
> > >> Changes V2 -> V3:
> > >> - Add missed capsets including cross domain and drm (native context)
> > >>   (Dmitry Osipenko)
> > >>
> > >> v1:
> https://lore.kernel.org/lkml/20230915105918.3763061-1-ray.huang@amd.com/
> > >> v2:
> https://lore.kernel.org/lkml/20231010032553.1138036-1-ray.huang@amd.com/
> > >>
> > >>  include/uapi/linux/virtio_gpu.h | 4 ++++
> > >>  1 file changed, 4 insertions(+)
> > >>
> > >> diff --git a/include/uapi/linux/virtio_gpu.h
> b/include/uapi/linux/virtio_gpu.h
> > >> index f556fde07b76..240911c8da31 100644
> > >> --- a/include/uapi/linux/virtio_gpu.h
> > >> +++ b/include/uapi/linux/virtio_gpu.h
> > >> @@ -309,6 +309,10 @@ struct virtio_gpu_cmd_submit {
> > >>
> > >>  #define VIRTIO_GPU_CAPSET_VIRGL 1
> > >>  #define VIRTIO_GPU_CAPSET_VIRGL2 2
> > >> +#define VIRTIO_GPU_CAPSET_GFXSTREAM 3
> > >
> > > The GFXSTREAM capset isn't correct, it should be GFXSTREAM_VULKAN in
> > > accordance to [1] and [2]. There are more capsets for GFXSTREAM.
> > >
> > > [1]
> > >
> https://github.com/google/crosvm/blob/main/rutabaga_gfx/src/rutabaga_util=
s.rs#L172
> > >
> > > [2]
> > >
> https://patchwork.kernel.org/project/qemu-devel/patch/20231006010835.444-=
7-gurchetansingh@chromium.org/
> >
> > Though, maybe those are "rutabaga" capsets that not related to
> > virtio-gpu because crosvm has another defs for virtio-gpu capsets [3].
> > The DRM capset is oddly missing in [3] and code uses "rutabaga" capset
> > for DRM and virtio-gpu.
> >
> > [3]
> >
> https://github.com/google/crosvm/blob/main/devices/src/virtio/gpu/protoco=
l.rs#L416
>
> Yes, [3] is the file that I referred to add these capsets definitions. An=
d
> it's defined as gfxstream not gfxstream_vulkan.
>
> >
> > Gurchetan, could you please clarify which capsets definitions are
> > related to virtio-gpu and gfxstream. The
> > GFXSTREAM_VULKAN/GLES/MAGMA/COMPOSER or just the single GFXSTREAM?


It should be GFXSTREAM_VULKAN.  The rest are more experimental and easy to
modify in terms of the enum value, should the need arise.

I imagine the virtio-spec update to reflect the GFXSTREAM to
GFXSTREAM_VULKAN change will happen eventually.


> >
>
> Gurchetan, may we have your insight?
>
> Thanks,
> Ray
>
> > --
> > Best regards,
> > Dmitry
> >
>

--00000000000058df6c060805f461
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 10, 2023 at 9:41=E2=80=AF=
PM Huang Rui &lt;<a href=3D"mailto:ray.huang@amd.com">ray.huang@amd.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On T=
ue, Oct 10, 2023 at 11:52:14PM +0800, Dmitry Osipenko wrote:<br>
&gt; On 10/10/23 18:40, Dmitry Osipenko wrote:<br>
&gt; &gt; On 10/10/23 16:57, Huang Rui wrote:<br>
&gt; &gt;&gt; These definitions are used fro qemu, and qemu imports this ma=
rco in the<br>
&gt; &gt;&gt; headers to enable gfxstream, venus, cross domain, and drm (na=
tive<br>
&gt; &gt;&gt; context) for virtio gpu. So it should add them even kernel do=
esn&#39;t use<br>
&gt; &gt;&gt; this.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Signed-off-by: Huang Rui &lt;<a href=3D"mailto:ray.huang@amd.=
com" target=3D"_blank">ray.huang@amd.com</a>&gt;<br>
&gt; &gt;&gt; Reviewed-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odak=
i@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Changes V1 -&gt; V2:<br>
&gt; &gt;&gt; - Add all capsets including gfxstream and venus in kernel hea=
der (Dmitry Osipenko)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Changes V2 -&gt; V3:<br>
&gt; &gt;&gt; - Add missed capsets including cross domain and drm (native c=
ontext)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0(Dmitry Osipenko)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; v1: <a href=3D"https://lore.kernel.org/lkml/20230915105918.37=
63061-1-ray.huang@amd.com/" rel=3D"noreferrer" target=3D"_blank">https://lo=
re.kernel.org/lkml/20230915105918.3763061-1-ray.huang@amd.com/</a><br>
&gt; &gt;&gt; v2: <a href=3D"https://lore.kernel.org/lkml/20231010032553.11=
38036-1-ray.huang@amd.com/" rel=3D"noreferrer" target=3D"_blank">https://lo=
re.kernel.org/lkml/20231010032553.1138036-1-ray.huang@amd.com/</a><br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0 include/uapi/linux/virtio_gpu.h | 4 ++++<br>
&gt; &gt;&gt;=C2=A0 1 file changed, 4 insertions(+)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/l=
inux/virtio_gpu.h<br>
&gt; &gt;&gt; index f556fde07b76..240911c8da31 100644<br>
&gt; &gt;&gt; --- a/include/uapi/linux/virtio_gpu.h<br>
&gt; &gt;&gt; +++ b/include/uapi/linux/virtio_gpu.h<br>
&gt; &gt;&gt; @@ -309,6 +309,10 @@ struct virtio_gpu_cmd_submit {<br>
&gt; &gt;&gt;=C2=A0 <br>
&gt; &gt;&gt;=C2=A0 #define VIRTIO_GPU_CAPSET_VIRGL 1<br>
&gt; &gt;&gt;=C2=A0 #define VIRTIO_GPU_CAPSET_VIRGL2 2<br>
&gt; &gt;&gt; +#define VIRTIO_GPU_CAPSET_GFXSTREAM 3<br>
&gt; &gt; <br>
&gt; &gt; The GFXSTREAM capset isn&#39;t correct, it should be GFXSTREAM_VU=
LKAN in<br>
&gt; &gt; accordance to [1] and [2]. There are more capsets for GFXSTREAM.<=
br>
&gt; &gt; <br>
&gt; &gt; [1]<br>
&gt; &gt; <a href=3D"https://github.com/google/crosvm/blob/main/rutabaga_gf=
x/src/rutabaga_utils.rs#L172" rel=3D"noreferrer" target=3D"_blank">https://=
github.com/google/crosvm/blob/main/rutabaga_gfx/src/rutabaga_utils.rs#L172<=
/a><br>
&gt; &gt; <br>
&gt; &gt; [2]<br>
&gt; &gt; <a href=3D"https://patchwork.kernel.org/project/qemu-devel/patch/=
20231006010835.444-7-gurchetansingh@chromium.org/" rel=3D"noreferrer" targe=
t=3D"_blank">https://patchwork.kernel.org/project/qemu-devel/patch/20231006=
010835.444-7-gurchetansingh@chromium.org/</a><br>
&gt; <br>
&gt; Though, maybe those are &quot;rutabaga&quot; capsets that not related =
to<br>
&gt; virtio-gpu because crosvm has another defs for virtio-gpu capsets [3].=
<br>
&gt; The DRM capset is oddly missing in [3] and code uses &quot;rutabaga&qu=
ot; capset<br>
&gt; for DRM and virtio-gpu.<br>
&gt; <br>
&gt; [3]<br>
&gt; <a href=3D"https://github.com/google/crosvm/blob/main/devices/src/virt=
io/gpu/protocol.rs#L416" rel=3D"noreferrer" target=3D"_blank">https://githu=
b.com/google/crosvm/blob/main/devices/src/virtio/gpu/protocol.rs#L416</a><b=
r>
<br>
Yes, [3] is the file that I referred to add these capsets definitions. And<=
br>
it&#39;s defined as gfxstream not gfxstream_vulkan.<br>
<br>
&gt; <br>
&gt; Gurchetan, could you please clarify which capsets definitions are<br>
&gt; related to virtio-gpu and gfxstream. The<br>
&gt; GFXSTREAM_VULKAN/GLES/MAGMA/COMPOSER or just the single GFXSTREAM?</bl=
ockquote><div><br></div><div>It should be GFXSTREAM_VULKAN.=C2=A0 The rest =
are more experimental and easy to modify in terms of the enum value, should=
 the need arise.</div><div><br></div><div>I imagine the virtio-spec update =
to reflect the GFXSTREAM to GFXSTREAM_VULKAN change will happen eventually.=
</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
&gt; <br>
<br>
Gurchetan, may we have your insight?<br>
<br>
Thanks,<br>
Ray<br>
<br>
&gt; -- <br>
&gt; Best regards,<br>
&gt; Dmitry<br>
&gt; <br>
</blockquote></div></div>

--00000000000058df6c060805f461--

--===============3712804351133585730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3712804351133585730==--

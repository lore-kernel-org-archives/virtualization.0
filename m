Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289D9C77B7F
	for <virtualization@archiver.kernel.org>; Fri, 12 May 2023 00:17:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A85A98496F;
	Fri, 12 May 2023 00:17:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A85A98496F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=C058dF6y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QuQTFAnMVEaC; Fri, 12 May 2023 00:17:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CF94C84689;
	Fri, 12 May 2023 00:17:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CF94C84689
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DDFBC0037;
	Fri, 12 May 2023 00:17:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F368C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 00:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE30140895
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 00:17:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EE30140895
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=C058dF6y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FAi_QQDS5q8z
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 00:17:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6767A40327
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6767A40327
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 00:17:45 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-966400ee79aso1231029566b.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 17:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1683850663; x=1686442663;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A8SW9YoumdQ8cXqFALi795RyrEYhnQ1pvgweAzLFr0w=;
 b=C058dF6y+mfJ89SQm6Q3anr/4ebdu9+eETydzkGC/8JLRV5v78l6p0MvNeSO4xupp2
 dleH5zI15hZY3itpmykHGc5PSMo2AQzlBNd8Hbt5nnA0JrOWnSQM82E3o7gRFhDB6a44
 yRpYhF/X7YT+WGo1a3UHcJ49JoOlf5zfLYvUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683850663; x=1686442663;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A8SW9YoumdQ8cXqFALi795RyrEYhnQ1pvgweAzLFr0w=;
 b=aYGjD3f3AGhiApmKWbD7SRTRSpnEMinM4+lnEA9Nk1ZKwGnXAoOWHfzn6KgXG9jSvY
 7g5IWmcZiltW4NomV0pGX1OHjtKejEeJT9V4kMgDEQCjJgi/2ct91kLEYzwZ1+IXKcVC
 U2vppzf+3y2Yyi0AxJE3iB5fEFPbVlQ/tAqahmceLOfm8OoBvPK2hbMTeNZCOMBiwL9O
 3e97i903MIXCQGA4AtGxey3dzEopgTF/E02sllojT0kj2TxiQPHuU8U/pwklXBmJuX1j
 lnexgauJ4J1gC3VwMypXfrKwb0lslq50ISJEAHP0fO7UbPjAxyQKkZnXtjOTnS135+4M
 DiZQ==
X-Gm-Message-State: AC+VfDxCTFZwS41eqjsKxezKD4GgyYGgrNvrOcfgE+IOTIZsAUgFa84b
 OOxC7Yw/yjnSy2ju07/hTtC/6raVUWyZwhaew9s2pg==
X-Google-Smtp-Source: ACHHUZ7khuwN7aG/U7Uc/QbJFoAHlu3+56aCIzAwlS6Uwg6pIi3ZWhZSWzBTvdjbMNbFwZTMpNqd2Q==
X-Received: by 2002:a17:906:6a1b:b0:968:2b4a:aba3 with SMTP id
 qw27-20020a1709066a1b00b009682b4aaba3mr15279873ejc.5.1683850663277; 
 Thu, 11 May 2023 17:17:43 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com.
 [209.85.208.54]) by smtp.gmail.com with ESMTPSA id
 de25-20020a1709069bd900b0096664376ec9sm4679330ejc.55.2023.05.11.17.17.42
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 May 2023 17:17:43 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-50bc3a5f462so26579a12.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 17:17:42 -0700 (PDT)
X-Received: by 2002:a50:d4ce:0:b0:502:2af:7b1d with SMTP id
 e14-20020a50d4ce000000b0050202af7b1dmr10146edj.3.1683850662405; Thu, 11 May
 2023 17:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
 <141b928d-6165-f282-b8e6-f140cb09333d@collabora.com>
 <CAAfnVBnrUotph4TYJVu9Bohqv3m80t90V34TNhh-Tspxwsj-ZQ@mail.gmail.com>
 <CAF6AEGs4fuq4i8UJdO5hvgHTNhzFMKGZ87+w1oyvL0LAqWio6A@mail.gmail.com>
In-Reply-To: <CAF6AEGs4fuq4i8UJdO5hvgHTNhzFMKGZ87+w1oyvL0LAqWio6A@mail.gmail.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 11 May 2023 17:17:30 -0700
X-Gmail-Original-Message-ID: <CAAfnVBkLhYVaSG3U_QUZwXLFv-XT=9F2v2pgrCDQQBgNZ3MSWA@mail.gmail.com>
Message-ID: <CAAfnVBkLhYVaSG3U_QUZwXLFv-XT=9F2v2pgrCDQQBgNZ3MSWA@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Add sync object UAPI support to VirtIO-GPU driver
To: Rob Clark <robdclark@gmail.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@redhat.com>, kernel@collabora.com,
 Chia-I Wu <olvaffe@gmail.com>, Emil Velikov <emil.velikov@collabora.com>
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
Content-Type: multipart/mixed; boundary="===============1710335549638144041=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============1710335549638144041==
Content-Type: multipart/alternative; boundary="00000000000096c54605fb740851"

--00000000000096c54605fb740851
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 8, 2023 at 6:59=E2=80=AFAM Rob Clark <robdclark@gmail.com> wrot=
e:

> On Wed, May 3, 2023 at 10:07=E2=80=AFAM Gurchetan Singh
> <gurchetansingh@chromium.org> wrote:
> >
> >
> >
> > On Mon, May 1, 2023 at 8:38=E2=80=AFAM Dmitry Osipenko <
> dmitry.osipenko@collabora.com> wrote:
> >>
> >> On 4/16/23 14:52, Dmitry Osipenko wrote:
> >> > We have multiple Vulkan context types that are awaiting for the
> addition
> >> > of the sync object DRM UAPI support to the VirtIO-GPU kernel driver:
> >> >
> >> >  1. Venus context
> >> >  2. Native contexts (virtio-freedreno, virtio-intel, virtio-amdgpu)
> >> >
> >> > Mesa core supports DRM sync object UAPI, providing Vulkan drivers
> with a
> >> > generic fencing implementation that we want to utilize.
> >> >
> >> > This patch adds initial sync objects support. It creates fundament
> for a
> >> > further fencing improvements. Later on we will want to extend the
> VirtIO-GPU
> >> > fencing API with passing fence IDs to host for waiting, it will be a
> new
> >> > additional VirtIO-GPU IOCTL and more. Today we have several
> VirtIO-GPU context
> >> > drivers in works that require VirtIO-GPU to support sync objects UAP=
I.
> >> >
> >> > The patch is heavily inspired by the sync object UAPI implementation
> of the
> >> > MSM driver.
> >>
> >> Gerd, do you have any objections to merging this series?
> >>
> >> We have AMDGPU [1] and Intel [2] native context WIP drivers depending =
on
> >> the sync object support. It is the only part missing from kernel today
> >> that is wanted by the native context drivers. Otherwise, there are few
> >> other things in Qemu and virglrenderer left to sort out.
> >>
> >> [1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21658
> >> [2]
> https://gitlab.freedesktop.org/digetx/mesa/-/commits/native-context-iris
> >
> >
> > I'm not saying this change isn't good, just it's probably possible to
> implement the native contexts (even up to even VK1.2) without it.  But th=
is
> patch series may be the most ergonomic way to do it, given how Mesa is
> designed.  But you probably want one of Mesa MRs reviewed first before
> merging (I added a comment on the amdgpu change) and that is a requiremen=
t
> [a].
> >
> > [a] "The userspace side must be fully reviewed and tested to the
> standards of that user space project. For e.g. mesa this means piglit
> testcases and review on the mailing list. This is again to ensure that th=
e
> new interface actually gets the job done." -- from the requirements
> >
>
> tbh, the syncobj support is all drm core, the only driver specifics is
> the ioctl parsing.  IMHO existing tests and the two existing consumers
> are sufficient.  (Also, considering that additional non-drm
> dependencies involved.)
>

Can we get one of the Mesa MRs reviewed first?  There's currently no
virtio-intel MR AFAICT, and the amdgpu one is marked as "Draft:".

Even for the amdgpu, Pierre suggests the feature "will be marked as
experimental both in Mesa and virglrenderer" and we can revise as needed.
The DRM requirements seem to warn against adding an UAPI too hastily...

You can get the deqp-vk 1.2 tests to pass with the current UAPI, if you
just change your mesa <--> virglrenderer protocol a little.  Perhaps that
way is even better, since you plumb the in sync-obj into host-side command
submission.

Without inter-context sharing of the fence, this MR really only adds guest
kernel syntactic sugar.

Note I'm not against syntactic sugar, but I just want to point out that you
can likely merge the native context work without any UAPI changes, in case
it's not clear.

If this was for the core drm syncobj implementation, and not just
> driver ioctl parsing and wiring up the core helpers, I would agree
> with you.
>

There are several possible and viable paths to get the features in question
(VK1.2 syncobjs, and inter-context fence sharing).  There are paths
entirely without the syncobj, paths that only use the syncobj for the
inter-context fence sharing case and create host syncobjs for VK1.2, paths
that also use guest syncobjs in every proxied command submission.

It's really hard to tell which one is better.  Here's my suggestion:

1) Get the native contexts reviewed/merged in Mesa/virglrenderer using the
current UAPI.  Options for VK1.2 include: pushing down the syncobjs to the
host, and simulating the syncobj (as already done).  It's fine to mark
these contexts as "experimental" like msm-experimental.  That will allow
you to experiment with the protocols, come up with tests, and hopefully
determine an answer to the host versus guest syncobj question.

2) Once you've completed (1), try to add UAPI changes for features that are
missing or things that are suboptimal with the knowledge gained from doing
(2).

WDYT?


>
> BR,
> -R
>

--00000000000096c54605fb740851
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 8, 2023 at 6:59=E2=80=AFA=
M Rob Clark &lt;<a href=3D"mailto:robdclark@gmail.com" target=3D"_blank">ro=
bdclark@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On Wed, May 3, 2023 at 10:07=E2=80=AFAM Gurchetan Singh<br=
>
&lt;<a href=3D"mailto:gurchetansingh@chromium.org" target=3D"_blank">gurche=
tansingh@chromium.org</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Mon, May 1, 2023 at 8:38=E2=80=AFAM Dmitry Osipenko &lt;<a href=3D"=
mailto:dmitry.osipenko@collabora.com" target=3D"_blank">dmitry.osipenko@col=
labora.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On 4/16/23 14:52, Dmitry Osipenko wrote:<br>
&gt;&gt; &gt; We have multiple Vulkan context types that are awaiting for t=
he addition<br>
&gt;&gt; &gt; of the sync object DRM UAPI support to the VirtIO-GPU kernel =
driver:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 1. Venus context<br>
&gt;&gt; &gt;=C2=A0 2. Native contexts (virtio-freedreno, virtio-intel, vir=
tio-amdgpu)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Mesa core supports DRM sync object UAPI, providing Vulkan dri=
vers with a<br>
&gt;&gt; &gt; generic fencing implementation that we want to utilize.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; This patch adds initial sync objects support. It creates fund=
ament for a<br>
&gt;&gt; &gt; further fencing improvements. Later on we will want to extend=
 the VirtIO-GPU<br>
&gt;&gt; &gt; fencing API with passing fence IDs to host for waiting, it wi=
ll be a new<br>
&gt;&gt; &gt; additional VirtIO-GPU IOCTL and more. Today we have several V=
irtIO-GPU context<br>
&gt;&gt; &gt; drivers in works that require VirtIO-GPU to support sync obje=
cts UAPI.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The patch is heavily inspired by the sync object UAPI impleme=
ntation of the<br>
&gt;&gt; &gt; MSM driver.<br>
&gt;&gt;<br>
&gt;&gt; Gerd, do you have any objections to merging this series?<br>
&gt;&gt;<br>
&gt;&gt; We have AMDGPU [1] and Intel [2] native context WIP drivers depend=
ing on<br>
&gt;&gt; the sync object support. It is the only part missing from kernel t=
oday<br>
&gt;&gt; that is wanted by the native context drivers. Otherwise, there are=
 few<br>
&gt;&gt; other things in Qemu and virglrenderer left to sort out.<br>
&gt;&gt;<br>
&gt;&gt; [1] <a href=3D"https://gitlab.freedesktop.org/mesa/mesa/-/merge_re=
quests/21658" rel=3D"noreferrer" target=3D"_blank">https://gitlab.freedeskt=
op.org/mesa/mesa/-/merge_requests/21658</a><br>
&gt;&gt; [2] <a href=3D"https://gitlab.freedesktop.org/digetx/mesa/-/commit=
s/native-context-iris" rel=3D"noreferrer" target=3D"_blank">https://gitlab.=
freedesktop.org/digetx/mesa/-/commits/native-context-iris</a><br>
&gt;<br>
&gt;<br>
&gt; I&#39;m not saying this change isn&#39;t good, just it&#39;s probably =
possible to implement the native contexts (even up to even VK1.2) without i=
t.=C2=A0 But this patch series may be the most ergonomic way to do it, give=
n how Mesa is designed.=C2=A0 But you probably want one of Mesa MRs reviewe=
d first before merging (I added a comment on the amdgpu change) and that is=
 a requirement [a].<br>
&gt;<br>
&gt; [a] &quot;The userspace side must be fully reviewed and tested to the =
standards of that user space project. For e.g. mesa this means piglit testc=
ases and review on the mailing list. This is again to ensure that the new i=
nterface actually gets the job done.&quot; -- from the requirements<br>
&gt;<br>
<br>
tbh, the syncobj support is all drm core, the only driver specifics is<br>
the ioctl parsing.=C2=A0 IMHO existing tests and the two existing consumers=
<br>
are sufficient.=C2=A0 (Also, considering that additional non-drm<br>
dependencies involved.)<br></blockquote><div><br></div><div>Can we get one =
of the Mesa MRs reviewed first?=C2=A0 There&#39;s currently no virtio-intel=
 MR AFAICT, and the amdgpu one is marked as &quot;Draft:&quot;.=C2=A0=C2=A0=
</div><div><br></div><div>Even for the amdgpu, Pierre suggests the feature =
&quot;will be marked as experimental both in Mesa and virglrenderer&quot; a=
nd we can revise as needed.=C2=A0 The DRM requirements seem to warn against=
 adding an UAPI too hastily...</div><div><br></div><div>You can get the deq=
p-vk 1.2 tests to pass with the current UAPI, if you just change your mesa =
&lt;--&gt; virglrenderer protocol a little.=C2=A0 Perhaps that way is even =
better, since you plumb the in sync-obj into host-side command submission.=
=C2=A0=C2=A0</div><div><br></div><div>Without inter-context sharing of the =
fence, this MR really only adds guest kernel syntactic sugar.</div><div><br=
></div><div>Note I&#39;m not against syntactic sugar, but I just want to po=
int out that you can likely merge the native context work without any UAPI =
changes, in case it&#39;s not clear.=C2=A0 =C2=A0=C2=A0</div><div><br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
If this was for the core drm syncobj implementation, and not just<br>
driver ioctl parsing and wiring up the core helpers, I would agree<br>
with you.<br></blockquote><div><br></div><div>There are several possible an=
d viable paths to get the features in question (VK1.2 syncobjs, and inter-c=
ontext fence sharing).=C2=A0 There are paths entirely without the syncobj, =
paths that only use the syncobj for the inter-context fence sharing case an=
d create host syncobjs for VK1.2, paths that also use guest syncobjs in eve=
ry proxied command submission.=C2=A0=C2=A0</div><div><br></div><div>It&#39;=
s really hard to tell which one is better.=C2=A0 Here&#39;s my suggestion:<=
/div><div><br></div><div>1) Get the native contexts reviewed/merged in Mesa=
/virglrenderer using the current UAPI.=C2=A0 Options for VK1.2 include: pus=
hing down the syncobjs to the host, and simulating the syncobj (as already =
done).=C2=A0 It&#39;s fine to mark these contexts as &quot;experimental&quo=
t; like msm-experimental.=C2=A0 That will allow you to experiment with the =
protocols, come up with tests, and hopefully determine an answer to the hos=
t versus guest syncobj question.=C2=A0=C2=A0</div><div><br></div><div>2) On=
ce you&#39;ve completed (1), try to add UAPI changes for features that are =
missing or things that are suboptimal with the knowledge gained from doing =
(2).=C2=A0=C2=A0</div><div><br></div><div>WDYT?</div><div>=C2=A0<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
BR,<br>
-R<br>
</blockquote></div></div>

--00000000000096c54605fb740851--

--===============1710335549638144041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1710335549638144041==--

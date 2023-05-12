Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14580C77B7C
	for <virtualization@archiver.kernel.org>; Fri, 12 May 2023 21:29:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8EAB0401DD;
	Fri, 12 May 2023 21:29:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8EAB0401DD
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MzV/iWZ7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f68bRCN3b_Db; Fri, 12 May 2023 21:29:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 830F9402F3;
	Fri, 12 May 2023 21:29:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 830F9402F3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40211C0036;
	Fri, 12 May 2023 21:29:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A9B8C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 21:29:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5F0A8402F3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 21:29:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5F0A8402F3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vkxL8wx5Yno9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 21:29:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B6930401DD
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B6930401DD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 21:29:38 +0000 (UTC)
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4f14468ef54so11875485e87.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 14:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1683926976; x=1686518976;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2SjsOTRUtDoh7Q8a4uh3MjlFC3Uqc/ELXfUQWIOF12A=;
 b=MzV/iWZ7CVb1vBmXqWulMeqGsmzCjBTgmjTdjHMm1sqUlKfgyhBZP6QkK+FiVdQT+X
 aqAWMA4705PsW9pe7lpSn49uThnqTYuZm901eB4s8B7rvNtOQ9cdLtEpcXZj7Gnbrh1j
 lJAEaDsqlB0Z0P0VVOxbB5hX5CWSDmx9XxZ18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683926976; x=1686518976;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2SjsOTRUtDoh7Q8a4uh3MjlFC3Uqc/ELXfUQWIOF12A=;
 b=QMsiuoKlW6pGzpMoHY9qyqkDCchR7Hjv6CNpTHFq4Ql4y6m/wg9Ai1o1PgTGosWV0q
 d3BWI0MTqgeCp6HzYRJhWXKD7JnQeFxJRnkVX8NIeIQ2PdbS8F3F3HqQphmCREJ6RcDC
 e6fjo+4Lfud6fkin01z5n88UaTkzNaKIWnUZrBG/YGj32Fn5Cz9F2woUwTsUKs0GsHHz
 BmMF+PyX0pM87/citnGXZZPqvtc6PGBsSQU7AVICR8aMe2EvHZk4iPQczjhSpmKKRBCB
 3kDHW07rIjtjzghqXN1o82bOzx+1oNV64Jb7A50+EawuhoPRjNJq2BJ23bu4BAVA+b2y
 ILWQ==
X-Gm-Message-State: AC+VfDx8WAEPuTTlxFe2DfqGxxfYmicr3tMBh6lY6+odAXkHNHkZQ/k+
 NpYEKG5+o3DYu/ZWKJErUrNrFnSVu0RnS5wLDknnug==
X-Google-Smtp-Source: ACHHUZ6zTTOCW57864aTNchi0lJpPBOTQT24XxAVUZ0e3zzDenrwJVDQLjfuEHU2t203QN6NCBuOZg==
X-Received: by 2002:a19:f813:0:b0:4ec:a48a:28c0 with SMTP id
 a19-20020a19f813000000b004eca48a28c0mr4186671lff.25.1683926976210; 
 Fri, 12 May 2023 14:29:36 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com.
 [209.85.167.54]) by smtp.gmail.com with ESMTPSA id
 y27-20020ac2447b000000b004db3eff4b12sm1455030lfl.171.2023.05.12.14.29.36
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 May 2023 14:29:36 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-4efea87c578so19737e87.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 14:29:36 -0700 (PDT)
X-Received: by 2002:a50:f60b:0:b0:502:7e99:a1a7 with SMTP id
 c11-20020a50f60b000000b005027e99a1a7mr94623edn.1.1683926617343; Fri, 12 May
 2023 14:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
 <141b928d-6165-f282-b8e6-f140cb09333d@collabora.com>
 <CAAfnVBnrUotph4TYJVu9Bohqv3m80t90V34TNhh-Tspxwsj-ZQ@mail.gmail.com>
 <CAF6AEGs4fuq4i8UJdO5hvgHTNhzFMKGZ87+w1oyvL0LAqWio6A@mail.gmail.com>
 <CAAfnVBkLhYVaSG3U_QUZwXLFv-XT=9F2v2pgrCDQQBgNZ3MSWA@mail.gmail.com>
 <a453d562-7e93-aef3-a533-171f572b6ee3@collabora.com>
In-Reply-To: <a453d562-7e93-aef3-a533-171f572b6ee3@collabora.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Fri, 12 May 2023 14:23:24 -0700
X-Gmail-Original-Message-ID: <CAAfnVBmwVTBNx4GC2hiYQ9Ya8ufP_D8N0-JOzT2iPV9BYZhD9w@mail.gmail.com>
Message-ID: <CAAfnVBmwVTBNx4GC2hiYQ9Ya8ufP_D8N0-JOzT2iPV9BYZhD9w@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Add sync object UAPI support to VirtIO-GPU driver
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, Rob Clark <robdclark@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@redhat.com>,
 kernel@collabora.com, Chia-I Wu <olvaffe@gmail.com>,
 Emil Velikov <emil.velikov@collabora.com>
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
Content-Type: multipart/mixed; boundary="===============7499998747916039986=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============7499998747916039986==
Content-Type: multipart/alternative; boundary="000000000000db126a05fb85b7ab"

--000000000000db126a05fb85b7ab
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2023 at 7:33=E2=80=AFPM Dmitry Osipenko <
dmitry.osipenko@collabora.com> wrote:

> On 5/12/23 03:17, Gurchetan Singh wrote:
> ...
> > Can we get one of the Mesa MRs reviewed first?  There's currently no
> > virtio-intel MR AFAICT, and the amdgpu one is marked as "Draft:".
> >
> > Even for the amdgpu, Pierre suggests the feature "will be marked as
> > experimental both in Mesa and virglrenderer" and we can revise as neede=
d.
> > The DRM requirements seem to warn against adding an UAPI too hastily...
> >
> > You can get the deqp-vk 1.2 tests to pass with the current UAPI, if you
> > just change your mesa <--> virglrenderer protocol a little.  Perhaps th=
at
> > way is even better, since you plumb the in sync-obj into host-side
> command
> > submission.
> >
> > Without inter-context sharing of the fence, this MR really only adds
> guest
> > kernel syntactic sugar.
> >
> > Note I'm not against syntactic sugar, but I just want to point out that
> you
> > can likely merge the native context work without any UAPI changes, in
> case
> > it's not clear.
> >
> > If this was for the core drm syncobj implementation, and not just
> >> driver ioctl parsing and wiring up the core helpers, I would agree
> >> with you.
> >>
> >
> > There are several possible and viable paths to get the features in
> question
> > (VK1.2 syncobjs, and inter-context fence sharing).  There are paths
> > entirely without the syncobj, paths that only use the syncobj for the
> > inter-context fence sharing case and create host syncobjs for VK1.2,
> paths
> > that also use guest syncobjs in every proxied command submission.
> >
> > It's really hard to tell which one is better.  Here's my suggestion:
> >
> > 1) Get the native contexts reviewed/merged in Mesa/virglrenderer using
> the
> > current UAPI.  Options for VK1.2 include: pushing down the syncobjs to
> the
> > host, and simulating the syncobj (as already done).  It's fine to mark
> > these contexts as "experimental" like msm-experimental.  That will allo=
w
> > you to experiment with the protocols, come up with tests, and hopefully
> > determine an answer to the host versus guest syncobj question.
> >
> > 2) Once you've completed (1), try to add UAPI changes for features that
> are
> > missing or things that are suboptimal with the knowledge gained from
> doing
> > (2).
> >
> > WDYT?
>
> Having syncobj support available by DRM driver is a mandatory
> requirement for native contexts because userspace (Mesa) relies on sync
> objects support presence. In particular, Intel Mesa driver checks
> whether DRM driver supports sync objects to decide which features are
> available, ANV depends on the syncobj support.


> I'm not familiar with a history of Venus and its limitations. Perhaps
> the reason it's using host-side syncobjs is to have 1:1 Vulkan API
> mapping between guest and host. Not sure if Venus could use guest
> syncobjs instead or there are problems with that.
>

Why not submit a Venus MR?  It's already in-tree, and you can see how your
API works in scenarios with a host side timeline semaphore (aka syncobj).
I think they are also interested in fencing/sync improvements.


>
> When syncobj was initially added to kernel, it was done from the needs
> of supporting Vulkan wait API. For Venus the actual Vulkan driver is on
> host side, while for native contexts it's on guest side. Native contexts
> don't need syncobj on host side, it will be unnecessary overhead for
> every nctx to have it on host. Hence, if there is no good reason for
> host-side syncobjs, then why do that?


Depends on your threading model.  You can have the following scenarios:

1) N guest contexts : 1 host thread
2) N guest contexts : N host threads for each context
3) 1:1 thread

I think the native context is single-threaded (1), IIRC?  If the goal is to
push command submission to the host (for inter-context sharing), I think
you'll at-least want (2).  For a 1:1 model (a la gfxstream), one host
thread can put another thread's out_sync_objs as it's in_sync_objs (in the
same virtgpu context).  I think that's kind of the goal of timeline
semaphores, with the example given by Khronos as with a compute thread + a
graphics thread.

I'm not saying one threading model is better than any other, perhaps the
native context using the host driver in the guest is so good, it doesn't
matter.  I'm just saying these are the types of discussions we can have if
we tried to get one the Mesa MRs merged first ;-)


> Native contexts pass deqp synchronization tests, they use sync objects
> universally for both GL and VK. Games work, piglit/deqp passing. What
> else you're wanting to test? Turnip?
>

Turnip would also fulfill the requirements, since most of the native
context stuff is already wired for freedreno.


>
> The AMDGPU code has been looked and it looks good. It's a draft for now
> because of the missing sync objects UAPI and other virglrender/Qemu
> changes required to get KMS working.


Get it out of draft mode then :-).  How long would that take?

Also, there's crosvm which builds on standard Linux, so I wouldn't consider
QEMU patches as a requirement.  Just Mesa/virglrenderer part.


> Maybe it will be acceptable to
> merge the Mesa part once kernel will get sync objects supported, will
> need to revisit it.
>

You can think of my commentary as the following suggestions:

- You can probably get native contexts and deqp-vk 1.2 working with the
current UAPI
- It would be terrific to see inter-context fence sharing working (with the
wait pushed down to the host), that's something the current UAPI can't do
- Work iteratively (i.e, it's fine to merge Mesa/virglrenderer MRs as
"experimental") and in steps, no need to figure everything out at once

Now these are just suggestions, and while I think they are good, you can
safely ignore them.

But there's also the DRM requirements, which state "userspace side must be
fully reviewed and tested to the standards of that user-space project.".
So I think to meet the minimum requirements, I think we should at-least
have one of the following (not all, just one) reviewed:

1) venus using the new uapi
2) gfxstream vk using the new uapi
3) amdgpu nctx out of "draft" mode and using the new uapi.
4) virtio-intel using new uapi
5) turnip using your new uapi

Depending on which one you chose, maybe we can get it done within 1-2 weeks=
?

I'm not opening MR for virtio-intel because it has open questions that
> need to be resolved first.
>
> --
> Best regards,
> Dmitry
>
>

--000000000000db126a05fb85b7ab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 11, 2023 at 7:33=E2=80=AF=
PM Dmitry Osipenko &lt;<a href=3D"mailto:dmitry.osipenko@collabora.com" tar=
get=3D"_blank">dmitry.osipenko@collabora.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">On 5/12/23 03:17, Gurchetan Sin=
gh wrote:<br>
...<br>
&gt; Can we get one of the Mesa MRs reviewed first?=C2=A0 There&#39;s curre=
ntly no<br>
&gt; virtio-intel MR AFAICT, and the amdgpu one is marked as &quot;Draft:&q=
uot;.<br>
&gt; <br>
&gt; Even for the amdgpu, Pierre suggests the feature &quot;will be marked =
as<br>
&gt; experimental both in Mesa and virglrenderer&quot; and we can revise as=
 needed.<br>
&gt; The DRM requirements seem to warn against adding an UAPI too hastily..=
.<br>
&gt; <br>
&gt; You can get the deqp-vk 1.2 tests to pass with the current UAPI, if yo=
u<br>
&gt; just change your mesa &lt;--&gt; virglrenderer protocol a little.=C2=
=A0 Perhaps that<br>
&gt; way is even better, since you plumb the in sync-obj into host-side com=
mand<br>
&gt; submission.<br>
&gt; <br>
&gt; Without inter-context sharing of the fence, this MR really only adds g=
uest<br>
&gt; kernel syntactic sugar.<br>
&gt; <br>
&gt; Note I&#39;m not against syntactic sugar, but I just want to point out=
 that you<br>
&gt; can likely merge the native context work without any UAPI changes, in =
case<br>
&gt; it&#39;s not clear.<br>
&gt; <br>
&gt; If this was for the core drm syncobj implementation, and not just<br>
&gt;&gt; driver ioctl parsing and wiring up the core helpers, I would agree=
<br>
&gt;&gt; with you.<br>
&gt;&gt;<br>
&gt; <br>
&gt; There are several possible and viable paths to get the features in que=
stion<br>
&gt; (VK1.2 syncobjs, and inter-context fence sharing).=C2=A0 There are pat=
hs<br>
&gt; entirely without the syncobj, paths that only use the syncobj for the<=
br>
&gt; inter-context fence sharing case and create host syncobjs for VK1.2, p=
aths<br>
&gt; that also use guest syncobjs in every proxied command submission.<br>
&gt; <br>
&gt; It&#39;s really hard to tell which one is better.=C2=A0 Here&#39;s my =
suggestion:<br>
&gt; <br>
&gt; 1) Get the native contexts reviewed/merged in Mesa/virglrenderer using=
 the<br>
&gt; current UAPI.=C2=A0 Options for VK1.2 include: pushing down the syncob=
js to the<br>
&gt; host, and simulating the syncobj (as already done).=C2=A0 It&#39;s fin=
e to mark<br>
&gt; these contexts as &quot;experimental&quot; like msm-experimental.=C2=
=A0 That will allow<br>
&gt; you to experiment with the protocols, come up with tests, and hopefull=
y<br>
&gt; determine an answer to the host versus guest syncobj question.<br>
&gt; <br>
&gt; 2) Once you&#39;ve completed (1), try to add UAPI changes for features=
 that are<br>
&gt; missing or things that are suboptimal with the knowledge gained from d=
oing<br>
&gt; (2).<br>
&gt; <br>
&gt; WDYT?<br>
<br>
Having syncobj support available by DRM driver is a mandatory<br>
requirement for native contexts because userspace (Mesa) relies on sync<br>
objects support presence. In particular, Intel Mesa driver checks<br>
whether DRM driver supports sync objects to decide which features are<br>
available, ANV depends on the syncobj support.=C2=A0</blockquote><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<br>
I&#39;m not familiar with a history of Venus and its limitations. Perhaps<b=
r>
the reason it&#39;s using host-side syncobjs is to have 1:1 Vulkan API<br>
mapping between guest and host. Not sure if Venus could use guest<br>
syncobjs instead or there are problems with that.<br></blockquote><div><br>=
</div><div>Why not submit a Venus MR?=C2=A0 It&#39;s already in-tree, and y=
ou can see how your API works in scenarios with a host side timeline semaph=
ore (aka syncobj).=C2=A0 I think they are also interested in fencing/sync i=
mprovements.=C2=A0 =C2=A0=C2=A0</div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex"><br>
When syncobj was initially added to kernel, it was done from the needs<br>
of supporting Vulkan wait API. For Venus the actual Vulkan driver is on<br>
host side, while for native contexts it&#39;s on guest side. Native context=
s<br>
don&#39;t need syncobj on host side, it will be unnecessary overhead for<br=
>
every nctx to have it on host. Hence, if there is no good reason for<br>
host-side syncobjs, then why do that?</blockquote><div><br></div><div>Depen=
ds on your threading model.=C2=A0 You can have the following scenarios:</di=
v><div><br></div><div>1) N guest contexts : 1 host thread</div><div>2) N gu=
est contexts : N host threads for each context</div><div>3) 1:1 thread</div=
><div><br></div><div>I think the native context is single-threaded (1), IIR=
C?=C2=A0 If the goal is to push command submission to the host (for inter-c=
ontext sharing), I think you&#39;ll at-least=C2=A0want (2).=C2=A0 For a 1:1=
 model (a la gfxstream), one host thread can put another thread&#39;s out_s=
ync_objs as it&#39;s in_sync_objs (in the same virtgpu context).=C2=A0 I th=
ink that&#39;s kind of the goal of timeline semaphores, with the example gi=
ven by Khronos as with a compute thread=C2=A0+ a graphics thread.=C2=A0=C2=
=A0</div><div><br></div><div>I&#39;m not saying one threading model is bett=
er than any other, perhaps the native context using the host driver in the =
guest is so good, it doesn&#39;t matter.=C2=A0 I&#39;m just saying these ar=
e the types of discussions we can have if we tried to get one the Mesa MRs =
merged first ;-)</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
Native contexts pass deqp synchronization tests, they use sync objects<br>
universally for both GL and VK. Games work, piglit/deqp passing. What<br>
else you&#39;re wanting to test? Turnip?<br></blockquote><div><br></div><di=
v>Turnip would also fulfill the requirements, since most of the native cont=
ext stuff is already wired for freedreno.</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br>
The AMDGPU code has been looked and it looks good. It&#39;s a draft for now=
<br>
because of the missing sync objects UAPI and other virglrender/Qemu<br>
changes required to get KMS working. </blockquote><div><br></div><div>Get i=
t out of draft mode then :-).=C2=A0 How long would that take?=C2=A0=C2=A0</=
div><div><br></div><div>Also, there&#39;s crosvm which builds on standard L=
inux, so I wouldn&#39;t consider QEMU patches as a requirement.=C2=A0 Just =
Mesa/virglrenderer part.=C2=A0 =C2=A0=C2=A0</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">Maybe it will be acceptable to<br>
merge the Mesa part once kernel will get sync objects supported, will<br>
need to revisit it.<br></blockquote><div><br></div><div>You can think of my=
 commentary as the following suggestions:</div><div><br></div><div>- You ca=
n probably get native contexts and deqp-vk 1.2 working with the current UAP=
I</div><div>- It would be terrific to see inter-context fence sharing worki=
ng (with the wait pushed down to the host), that&#39;s something the curren=
t UAPI can&#39;t do<br></div><div><div>- Work iteratively (i.e, it&#39;s fi=
ne to merge Mesa/virglrenderer MRs as &quot;experimental&quot;) and in step=
s, no need to figure everything out at once</div></div><div><br></div><div>=
Now these are just suggestions, and while I think they=C2=A0are good, you c=
an safely ignore them.</div><div><br></div><div>But there&#39;s also the DR=
M requirements, which state &quot;userspace side must be fully reviewed and=
 tested to the standards of that user-space project.&quot;.=C2=A0 So I thin=
k to meet the minimum requirements, I think we should at-least have one of =
the following (not all, just one) reviewed:</div><div><br></div><div>1) ven=
us using the new uapi</div><div>2) gfxstream vk using the new uapi</div><di=
v>3) amdgpu nctx out of &quot;draft&quot; mode and using the new uapi.=C2=
=A0</div><div>4) virtio-intel using new uapi</div><div>5) turnip using your=
 new uapi</div><div><br></div><div>Depending on which one you chose, maybe =
we can get it done within 1-2 weeks?</div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
I&#39;m not opening MR for virtio-intel because it has open questions that<=
br>
need to be resolved first.<br>
<br>
-- <br>
Best regards,<br>
Dmitry<br>
<br>
</blockquote></div></div>

--000000000000db126a05fb85b7ab--

--===============7499998747916039986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7499998747916039986==--

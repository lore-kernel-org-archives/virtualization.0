Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAACBC5479D
	for <virtualization@archiver.kernel.org>; Tue, 10 Jan 2023 01:47:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 487A660784;
	Tue, 10 Jan 2023 01:47:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 487A660784
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=qFcyM27X
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E38Zn_LOAhhX; Tue, 10 Jan 2023 01:47:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E030760812;
	Tue, 10 Jan 2023 01:47:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E030760812
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7382C0032;
	Tue, 10 Jan 2023 01:47:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26715C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 01:47:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E1AF6401F3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 01:47:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E1AF6401F3
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=qFcyM27X
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pQMdP5ENa-tz
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 01:47:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C7F3A400C0
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C7F3A400C0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 01:47:37 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 m7-20020a9d73c7000000b00683e2f36c18so6263862otk.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Jan 2023 17:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kbDcjQtwcmYIyMwYrj6WVATDcFAVZZpovnNCEJKINmc=;
 b=qFcyM27Xbo5tKN2io6bi2zLc6Pb2fKgrzjr3usL6fFZ/eMmZxf8JV4ni8ZtxQ84vAK
 sK7qmXC5dNvM6ePIGeUbtF1s1lsumaDCC+I605W8zUdwevk9B5yPJIMO3YAYb3nyQSOV
 wXbLqNy/gkvObGh/MoTWxeSCtuyeJL9NlLLtcEtnsLlcpKmN1wGMDnvdTCYXlXT69jz7
 Q0cNNkh94qHckX4ck7DlWz+YkJjk+nwbuHHWzK9oCrNfhh6duJha5SIhBEJJuxCwApVM
 7Oq0Fu8hueRCOFcwf8PL9+UTPMRLqHQl817LRAMO6Q7B15QnQrc6Ft2mD1uhrw15QvLx
 VlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kbDcjQtwcmYIyMwYrj6WVATDcFAVZZpovnNCEJKINmc=;
 b=THCFCZh0y8kk5mLOu+h7KMJuOXo+B6W3Y1GSypwkud8w5TEYOzmMcGl23OCOzXDEi3
 vUZu3zR+vQ7L+JcenFOojJ2VUow9uNmM5OcgvY0JQ7fxPwyilGPqM59q5XSFpVQ0CMTr
 McVs6z9heUl9/D+HjYKMUF7ov5tIYxJb+7PrjCsaaRJTfqNIr0cJ4pq1DbKVWdTWl3UT
 2frRqtYliSsaKEXBsEf/QsZul8KQQittmyv0+cfY+6/Cz8hUC6l3/NCwCEqXtENchp30
 FHjyshSXT3ION5Jz7JMG49pNKzZHiMLyvJu84gpos5FByV9VCUMFdTP86aAtW4TVhhFo
 7kjw==
X-Gm-Message-State: AFqh2krq8ssVlFx68dwCQ206dLICBztqa17Ckx7Xb76cQu/4pQI4rBfH
 +6VV/B8dpONigO+qUUg/59TUoUk6dHriXuby6+0=
X-Google-Smtp-Source: AMrXdXvvOgJPNnYtha/68FhbwNYmEh+bLUpMyl+dlv1Y6ezF1RZbS7ig7ahlDY/Aoks9r8hpVJT5WzWwe7Zkbrw1ABs=
X-Received: by 2002:a9d:7310:0:b0:678:272b:41e1 with SMTP id
 e16-20020a9d7310000000b00678272b41e1mr3478533otk.328.1673315256862; Mon, 09
 Jan 2023 17:47:36 -0800 (PST)
MIME-Version: 1.0
References: <20221216233355.542197-1-robdclark@gmail.com>
 <20221216233355.542197-2-robdclark@gmail.com>
 <3ae74f28-580b-3b53-3d7b-e8bde97dabe3@collabora.com>
In-Reply-To: <3ae74f28-580b-3b53-3d7b-e8bde97dabe3@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 9 Jan 2023 17:47:34 -0800
Message-ID: <CAF6AEGvGb66L7cXod40PiKijJRTCOhWL+qCz4bgmi-69ZxJt8Q@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Fix GEM handle creation UAF
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Rob Clark <robdclark@chromium.org>,
 open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 David Airlie <airlied@redhat.com>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Jan 9, 2023 at 3:28 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 12/17/22 02:33, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Userspace can guess the handle value and try to race GEM object creation
> > with handle close, resulting in a use-after-free if we dereference the
> > object after dropping the handle's reference.  For that reason, dropping
> > the handle's reference must be done *after* we are done dereferencing
> > the object.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
>
> Added fixes/stable tags and applied this virtio-gpu patch to misc-fixes.
> The Panfrost patch is untouched.

Thanks.. the panfrost patch was not intended to be part of the same
series (but apparently that is what happens when I send them at the
same time), and was superceded by a patch from Steven Price (commit
4217c6ac8174 ("drm/panfrost: Fix GEM handle creation ref-counting")
already applied to misc-fixes

BR,
-R
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

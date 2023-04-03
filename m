Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC682C77B60
	for <virtualization@archiver.kernel.org>; Mon,  3 Apr 2023 13:22:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4791B41606;
	Mon,  3 Apr 2023 13:22:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4791B41606
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=iFmu6Bph
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id riLAMjrkdaXu; Mon,  3 Apr 2023 13:22:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 984FF41296;
	Mon,  3 Apr 2023 13:22:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 984FF41296
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C517C0037;
	Mon,  3 Apr 2023 13:22:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23D3AC002F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 13:22:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DF26481E37
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 13:22:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF26481E37
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=iFmu6Bph
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XVFjKZ_H_qad
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 13:22:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2524D81E23
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2524D81E23
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 13:22:33 +0000 (UTC)
Received: by mail-yb1-xb30.google.com with SMTP id n125so34673381ybg.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Apr 2023 06:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680528152;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=puJQIiNwi0B7OHT+YCNoLm1RVfBbXjaYqHubaytTOZc=;
 b=iFmu6Bph/r5JtPpy4KiE3uF1FZx4WD1yKmH9pZNGnpcQ+rpE7jJXoHdkumVA8mECJ9
 1yuVFCPOEZAJvB8kJXc1F2AequweKSrN82RJjtyE2aSxlHiKn5qTmxPsEspfGvjnxcc+
 xO4OI/xLCUDLiDR6iXCVuF5rWXOkUwipr/nJZ6syWHfavVYl1oBrGXDm9cMRfyY0HS5R
 LHpXIg53OEKGjqDV8dmXxMElXPSjS96U8N6WMzBQtsbMd2tFuDVmB76E3bEOWSld7FPY
 a25ESuLO+P8iW9goF0NmubEftjJ0BDJT9c9zkgjjNItMW4hPRPFvcCOQCTUSDEPhXRqD
 QU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680528152;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=puJQIiNwi0B7OHT+YCNoLm1RVfBbXjaYqHubaytTOZc=;
 b=VIfEnozZRyeVB7uAxxeUyrF9hBE692U9JM37rfVQelODjlONmm/er+EHFZnL0oN0K6
 cSPbjBQofLuOUQLVlj0UplLrAMUZjH+rldbqOcD1H6UmfncW+ohC+LQH9qtsjt3LJC+V
 EWRBoixK6gg6YXNX0ZbPn6XptkCQi+eWuhz6j/amagjxHydEi2JxZweAKcMTXhfs4dCN
 K4S2W43StIvsKrHaawH8x8BzCmfs4BoN9JrIcfN/vVsvRwuQfXDzGFqZiSNXWuTJ13rn
 2/X3yhVa0PAjh6o5zzwmQCyv7XYnH/w/ArwvGH9DDSL+VHEQMcTelNMBjSUJ7hmltXWV
 PIXA==
X-Gm-Message-State: AAQBX9dP9waeNI9WwWIgAU2lwBeAPpwxVzpXUJa23xqxJoWPIZ2x2kc5
 A29mb90qsAjwI79t/XiPB6/BsEqRx4ClhHW7UUM=
X-Google-Smtp-Source: AKy350bWysdzXHGZ8/wze3T0qWf/LM4Wl8ayF7vOJuIYnrg0bXgibm9ykvXEhOtu6Wmfpbs5ZM+9QenlXSPq3ioXank=
X-Received: by 2002:a25:d784:0:b0:b76:3b21:b1dc with SMTP id
 o126-20020a25d784000000b00b763b21b1dcmr11126480ybg.0.1680528152080; Mon, 03
 Apr 2023 06:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230323230755.1094832-1-dmitry.osipenko@collabora.com>
 <20230323230755.1094832-3-dmitry.osipenko@collabora.com>
 <ZCXF4q81wPcczkqx@arch-x395>
 <3618a293-4f61-b076-0a9c-c70812436431@collabora.com>
 <CACvgo51GWRCQuiJDVrqo=xzd3frKvs6WNcc755pbu8jNk6t-Rg@mail.gmail.com>
In-Reply-To: <CACvgo51GWRCQuiJDVrqo=xzd3frKvs6WNcc755pbu8jNk6t-Rg@mail.gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Mon, 3 Apr 2023 14:22:20 +0100
Message-ID: <CACvgo53bkvDm7CXN_zFETZeuWas50tJys6u+nc5DO_MWK4SZfw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/virtio: Support sync objects
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 David Airlie <airlied@redhat.com>, kernel@collabora.com,
 virtualization@lists.linux-foundation.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, 3 Apr 2023 at 14:00, Emil Velikov <emil.l.velikov@gmail.com> wrote:

> > > I think we should zero num_(in|out)_syncobjs when the respective parse
> > > fails. Otherwise we get one "cleanup" within the parse function itself
> > > and a second during the cleanup_submit. Haven't looked at it too closely
> > > but I suspect that will trigger an UAF or two.
> >
> > There are checks for NULL pointers in the code that will prevent the
> > UAF.  I'll add zeroing of the nums for more consistency.
> >
>
> Riiiight the drm_syncobj is attached to the encapsulating struct
> virtio_gpu_submit _only_ on success.
> By clearing the num variables,  the NULL checks will no longer be
> needed ... in case you'd want to drop that.
>
> Either way - even as-is the code is safe.
>

Err or not. The NULL check itself will cause NULL pointer deref.

In more detail: in/out syncobjs are memset() to NULL in
virtio_gpu_init_submit(). The virtio_gpu_parse_(|post_)deps() will
fail and leave them unchanged. Then virtio_gpu_free_syncobjs() and
virtio_gpu_reset_syncobjs() will trigger a NULL ptr deref, because
they are accessing the elements of a the (NULL) array.

Apart from the num_(in|out)_syncobjcs=0, I would drop the NULL checks
- they give a false sense of security IMHO.

-Emil
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

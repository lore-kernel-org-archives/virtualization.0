Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A87C433F5
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 18:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2A444058B;
	Tue, 23 Nov 2021 18:47:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uk5DK-FnUejI; Tue, 23 Nov 2021 18:47:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8FBD640582;
	Tue, 23 Nov 2021 18:47:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56B5CC001E;
	Tue, 23 Nov 2021 18:47:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B250DC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 18:47:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 87BEB40169
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 18:47:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dYBzUh7lpJ0B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 18:47:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A34254010E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 18:47:39 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id y12so96200877eda.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 10:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LKJrDfQmwKaC53bj2iHawRUpVnad+wbaQMjhFO5RDyA=;
 b=BtRqghgRFhUtoNOS+OOnBF8RzAgbmUSpkNjprtb4qFgZVgl8RJKGI4sW5b7Svcsb3k
 2IDgBK9w+bUYEkOcy2U4dO0mL865Er+SgF1I3ppCRoEFtvCk93SbYAfMXpJ1nxh0FIlM
 mKXCwU3D5yufMN1Y7gMYvt8RKB128jBlnsXu9qjzSC4/soJLngUtBe95Scl7vFjf0DrK
 A3nlIgRa7/+Jqmzp8tKbbiW4EN/MDwg+3sjQr0RgBt8aRQ/s8/92NskDPJpSz6NPdseW
 iR3QjDgMa4V7K2x/EIB05RrcwpXIPFjBiCZX72oigvKNo8Q/oVFOtWrnLEYS6qir+RQX
 Ty8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LKJrDfQmwKaC53bj2iHawRUpVnad+wbaQMjhFO5RDyA=;
 b=1e7kB96Gq3C34x92GABgXSruaOgYZnFsQOcwWGBZMUTCBmbJVrhr4EdtjS+vbF7HA2
 o8stv2eLIhbqnig3wtxfk/Kuj9Brs3c0P8PehXHqPd6IMAKoAnaMq9Fv/tSyp2onLJ0F
 Ytzp21rWPprqEXEjBYInH5lRvvRmwjjG513xiwp+WK8uEt+5sHseQtNiVR/WhneXzGcR
 qQ90bkwLkUnLO6LmpcjLYvtptI+jJlJDp4BvnbgxwSlxZN+3rCCO7tVIMhDO6hir2kSX
 PjrlysSGCggHol8FEi8cL2pA13Zjf+KhnJnirnIIzFsWL9J8m8fdUgzG3Gninf4FDAJy
 4nUw==
X-Gm-Message-State: AOAM533OSGVIfdfLQhH4e5VoJNzYL3sU3/qtkzGckR9FuVcQptgdnzi0
 DTTdOabJqoWEmYCciaydgWtDcd3mBtKKKLmj5Rg=
X-Google-Smtp-Source: ABdhPJxDgvQbGh55arMTMvVVtGGMagNZkVz0+HZG7Jro3W6BzwdGTZ5kJmTH/FQ23iQpqvxdZHZroQyzUbbdqNziWiY=
X-Received: by 2002:a17:907:6d05:: with SMTP id
 sa5mr10579024ejc.246.1637693257678; 
 Tue, 23 Nov 2021 10:47:37 -0800 (PST)
MIME-Version: 1.0
References: <20211118111632.GE1147@kili>
In-Reply-To: <20211118111632.GE1147@kili>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Tue, 23 Nov 2021 10:47:26 -0800
Message-ID: <CAPaKu7RKuHNfy4ANqfCCVGMhrTd7y-kMpJvz+UP7U2o=i4OJbg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: Fix an NULL vs IS_ERR() bug in
 virtio_gpu_object_shmem_init()
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org,
 ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
 NET AND BLOCK DRIVERS" <virtualization@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>
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

On Thu, Nov 18, 2021 at 3:16 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The drm_gem_shmem_get_sg_table() function never returns NULL.  It returns
> error pointers on error.
>
> Fixes: c66df701e783 ("drm/virtio: switch from ttm to gem shmem helpers")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: I originally sent this patch on 19 Jun 2020 but it was somehow
>     not applied.  As I review it now, I see that the bug is actually
>     older than I originally thought and so I have updated the Fixes
>     tag.
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

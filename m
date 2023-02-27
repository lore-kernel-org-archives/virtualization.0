Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4867C7EE2E
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 15:40:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F09260C0E;
	Mon, 27 Feb 2023 15:40:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F09260C0E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=oI9zcZYj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WfsbOh_d0QI6; Mon, 27 Feb 2023 15:40:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 23C136009C;
	Mon, 27 Feb 2023 15:40:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 23C136009C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4C27C0032;
	Mon, 27 Feb 2023 15:40:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CB3EC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 15:40:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5769341763
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 15:40:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5769341763
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=oI9zcZYj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z-2Q3HtGpG6Z
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 15:40:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E711408EA
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E711408EA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 15:40:23 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id bm20so5488257oib.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 07:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CyTB/8yjHEGeVb5eYubYQqNDzW1fdOoIcMGH96ABpv4=;
 b=oI9zcZYjxrQqI5sYOaUtqe/5zhMZErmABdHSldC6FrXKdAHLIc51dMDe5gV3uHW+Sj
 WduVlXX2H1y0qnMrwVnxVOL79HAsX+q/8PqyZmSxC3+q7tzpSAdM6VvzBN8SwQ1x7DMV
 IYzXTUyH7EroFrtoQC45sSNzp7yFQDODcKIMPCKQMKXnkZtC3eohfaP5y3+hME4QLIUA
 zx9gWufCFU8QRWqia6+SjTJSW+nLIgw2Z164GAbcHI3Q9e1UmOTnGU1/R86td0RUWYe8
 yFfrdDSXHf/vtV5Q2HbH0bMJ0ssqfaOizzn0u6O7K12fvzRYES8no82mhajBy8V7g6gC
 oYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CyTB/8yjHEGeVb5eYubYQqNDzW1fdOoIcMGH96ABpv4=;
 b=xHGJB2ZX6NQoZgtJOLl+e/FD4Zzozmc8RfH3LDexNoQAnt3iGzYSHWwnGqm1YbQBWT
 mh8IS+xydO5YysLrySJ3qQ07hWefWM7z+cI4fmgZKJPAIWzt9ABmok4RrLeBAbKs3HFW
 pKUuOB5Cn0rpFxXiqf85/TAVtl3Ip1HBIf/zIsyCTF/80GNNe5haSnNGcMfMRecpVZRu
 3E4oZ/uMqpdWnhDLYzEtxaOkoZt4UB0yt6+bulFKODDIXDtXIaOxMZyvOZAjOwrWhAqD
 /98FGhZRrEDBtCuz3ygrF/tkxuhjgFJZ6mR4FdTOKhyQJfxBtKPJNrBg3JqvYbcUI8Ts
 +7lQ==
X-Gm-Message-State: AO0yUKW2cBDxnfM1K3FkGGo0JgLrir3ngQTfN+EZQVEjhxtFzgsvZtUW
 8dN0wzDP2Nh+q7WmzgWm8wqYnKHZZkOJfE8bPOE=
X-Google-Smtp-Source: AK7set+WPiN+PMC33D7dGKvMOq4tjpD5BANv/fOXy/omKUC1JZ4GUk6hlHvST2Ba9zIlMFuhIdoN5PtweesP99tGF+U=
X-Received: by 2002:a05:6808:486:b0:384:23ed:1ff6 with SMTP id
 z6-20020a056808048600b0038423ed1ff6mr1448259oid.3.1677512422552; Mon, 27 Feb
 2023 07:40:22 -0800 (PST)
MIME-Version: 1.0
References: <20230224180225.2477641-1-robdclark@gmail.com>
 <20230227063821.dg2gbjjwcekbxyzw@sirius.home.kraxel.org>
In-Reply-To: <20230227063821.dg2gbjjwcekbxyzw@sirius.home.kraxel.org>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 27 Feb 2023 07:40:11 -0800
Message-ID: <CAF6AEGsv1G7CPSkCPe3iHGB9JEO4iy+bTbkFLoitmx64U78RJw@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Add option to disable KMS support
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Rob Clark <robdclark@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Ryan Neph <ryanneph@chromium.org>, David Airlie <airlied@redhat.com>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Chia-I Wu <olvaffe@gmail.com>
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

On Sun, Feb 26, 2023 at 10:38 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Fri, Feb 24, 2023 at 10:02:24AM -0800, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Add a build option to disable modesetting support.  This is useful in
> > cases where the guest only needs to use the GPU in a headless mode, or
> > (such as in the CrOS usage) window surfaces are proxied to a host
> > compositor.
>
> Why make that a compile time option?  There is a config option for the
> number of scanouts (aka virtual displays) a device has.  Just set that
> to zero (and fix the driver to not consider that configuration an
> error).

The goal is to not advertise DRIVER_MODESET (and DRIVER_ATOMIC).. I
guess that could be done based on whether there are any scanouts, but
it would mean making the drm_driver struct non-const.  And I think it
is legitimate to allow the guest to make this choice, regardless of
what the host decides to expose, since it is about the ioctl surface
area that the guest kernel exposes to guest userspace.

BR,
-R
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

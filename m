Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA7AC64ED6
	for <virtualization@archiver.kernel.org>; Tue, 28 Feb 2023 06:28:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81CB081570;
	Tue, 28 Feb 2023 06:28:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 81CB081570
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OP4Vzpw4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t_OH9KGDpDMf; Tue, 28 Feb 2023 06:28:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D431481430;
	Tue, 28 Feb 2023 06:28:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D431481430
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADAA4C0033;
	Tue, 28 Feb 2023 06:28:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A6BCC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 06:28:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4DB4840239
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 06:28:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4DB4840239
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OP4Vzpw4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wdkc0LRPLtgd
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 06:28:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF60640235
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DF60640235
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 06:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677565695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iFyJ4pdf0AOcSeP1Ng1BKT/ZjTRTFBASYA1oXOLwdZw=;
 b=OP4Vzpw4ki39Ri6qjfXsfoM0qUvp4pght9hM0IbjQBeN4KjfuL/u5wo6P3WBIoQd2Hldc6
 VDFlqvkF7NsUpc+445JP9LnfEDbcuxOUyQvcBlkVXuZlbNY2XZt+Fe+VgO5lGL4qTTLsMw
 6TbrQGnSL1TnSwcZhXiBICUuXiNrhuM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-CQ2WxJ70ONW4n0-8EN7DVw-1; Tue, 28 Feb 2023 01:28:11 -0500
X-MC-Unique: CQ2WxJ70ONW4n0-8EN7DVw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0914B101A521;
 Tue, 28 Feb 2023 06:28:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4716492B12;
 Tue, 28 Feb 2023 06:28:10 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 477C6180099A; Tue, 28 Feb 2023 07:28:09 +0100 (CET)
Date: Tue, 28 Feb 2023 07:28:09 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] drm/virtio: Add option to disable KMS support
Message-ID: <20230228062809.ccyzgnvizh6jidn4@sirius.home.kraxel.org>
References: <20230224180225.2477641-1-robdclark@gmail.com>
 <20230227063821.dg2gbjjwcekbxyzw@sirius.home.kraxel.org>
 <CAF6AEGsv1G7CPSkCPe3iHGB9JEO4iy+bTbkFLoitmx64U78RJw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF6AEGsv1G7CPSkCPe3iHGB9JEO4iy+bTbkFLoitmx64U78RJw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

On Mon, Feb 27, 2023 at 07:40:11AM -0800, Rob Clark wrote:
> On Sun, Feb 26, 2023 at 10:38 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > On Fri, Feb 24, 2023 at 10:02:24AM -0800, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > Add a build option to disable modesetting support.  This is useful in
> > > cases where the guest only needs to use the GPU in a headless mode, or
> > > (such as in the CrOS usage) window surfaces are proxied to a host
> > > compositor.
> >
> > Why make that a compile time option?  There is a config option for the
> > number of scanouts (aka virtual displays) a device has.  Just set that
> > to zero (and fix the driver to not consider that configuration an
> > error).
> 
> The goal is to not advertise DRIVER_MODESET (and DRIVER_ATOMIC).. I
> guess that could be done based on whether there are any scanouts, but
> it would mean making the drm_driver struct non-const.

Apparently there is a drm_device->driver_features override,
(amdgpu uses that).  The driver could simply drop the DRIVER_MODESET and
DRIVER_ATOMIC bits in case no scanout is present instead of throwing an
error.

> And I think it is legitimate to allow the guest to make this choice,
> regardless of what the host decides to expose, since it is about the
> ioctl surface area that the guest kernel exposes to guest userspace.

I think it is a bad idea to make that a compile time option, I'd suggest
a runtime switch instead, for example a module parameter to ask the
driver to ignore any scanouts.

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

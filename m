Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BFBC77B7F
	for <virtualization@archiver.kernel.org>; Wed,  3 May 2023 06:51:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4081C41B9E;
	Wed,  3 May 2023 06:51:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4081C41B9E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e6p+vkh5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g4EmZpArX6jH; Wed,  3 May 2023 06:51:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 62F2741C21;
	Wed,  3 May 2023 06:51:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 62F2741C21
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 385F7C0037;
	Wed,  3 May 2023 06:51:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 228DCC002A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 06:51:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EAAC6403AE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 06:51:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EAAC6403AE
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=e6p+vkh5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bw7Snf1TzOsp
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 06:51:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D634040164
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D634040164
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 06:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683096706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZAUDt/vzN1VeMkqTdFA804MyRykQ+diCShj5qJ6AEJ4=;
 b=e6p+vkh5G2qCsv6R+nDmsNg844qhaeRHlp19msoflbx12XcAWGGl4CBmcRRYg8nCkZAz/l
 mFbT3r2eLuU4OpJPlwQxcE0ONekaTmaQdC10mBdobMRFlKdCkS/b2JlxnN+mm1O+SyLI8H
 SAodQ5ff5azQqKnRSiYPbN/++GBRbHc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-gXx-JDx6N4OsBA4ZlslPRw-1; Wed, 03 May 2023 02:51:39 -0400
X-MC-Unique: gXx-JDx6N4OsBA4ZlslPRw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78C12185A78B;
 Wed,  3 May 2023 06:51:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F0F5740F2D4B;
 Wed,  3 May 2023 06:51:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3E967180093A; Wed,  3 May 2023 08:51:36 +0200 (CEST)
Date: Wed, 3 May 2023 08:51:36 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v6 0/3] Add sync object UAPI support to VirtIO-GPU driver
Message-ID: <6g5bonxpnlw7pcyt3pqrcty2exknpesst4i3v24nqxi3fy5gkr@5rej6zbfadta>
References: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
 <141b928d-6165-f282-b8e6-f140cb09333d@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <141b928d-6165-f282-b8e6-f140cb09333d@collabora.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Marek =?utf-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Rob Clark <robdclark@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@redhat.com>,
 kernel@collabora.com, virtualization@lists.linux-foundation.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, May 01, 2023 at 06:38:45PM +0300, Dmitry Osipenko wrote:
> On 4/16/23 14:52, Dmitry Osipenko wrote:
> > We have multiple Vulkan context types that are awaiting for the addition
> > of the sync object DRM UAPI support to the VirtIO-GPU kernel driver:
> > 
> >  1. Venus context
> >  2. Native contexts (virtio-freedreno, virtio-intel, virtio-amdgpu)
> > 
> > Mesa core supports DRM sync object UAPI, providing Vulkan drivers with a
> > generic fencing implementation that we want to utilize.
> > 
> > This patch adds initial sync objects support. It creates fundament for a
> > further fencing improvements. Later on we will want to extend the VirtIO-GPU
> > fencing API with passing fence IDs to host for waiting, it will be a new
> > additional VirtIO-GPU IOCTL and more. Today we have several VirtIO-GPU context
> > drivers in works that require VirtIO-GPU to support sync objects UAPI.
> > 
> > The patch is heavily inspired by the sync object UAPI implementation of the
> > MSM driver.
> 
> Gerd, do you have any objections to merging this series?

No objections.  Can't spot any issues, but I also don't follow drm close
enough to be able to review the sync object logic in detail.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

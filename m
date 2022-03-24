Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E309C433F5
	for <virtualization@archiver.kernel.org>; Thu, 24 Mar 2022 15:33:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18A5284438;
	Thu, 24 Mar 2022 15:33:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RzL9Mhv_oFzX; Thu, 24 Mar 2022 15:33:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 92C8784419;
	Thu, 24 Mar 2022 15:33:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69020C0012;
	Thu, 24 Mar 2022 15:33:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11441C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 15:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EAE7084433
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 15:33:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id McnEBpw4SaMg
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 15:33:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E448684419
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 15:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648136002;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8QnjcDWT8YHaE2ypxB7fTnVt6WqhkXSObBAZWvhDXe0=;
 b=GPC7WpJ17TuKMyygFtRZOlh+tJ6n/iEFv+4u2vsmfzlkggV+IBNfjIpDl37faT4b4ojoxs
 mUSO3qqZtWI+se43ivM89/niHICtrp9tG/72wNqOgTmkZkAx9RJU3Fdr6uo1kaMmsXCPZ2
 qIj2KylPEDQcsn29AbOFXFglpbLZUP8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-AkdLzR3CP2ant435S_RImw-1; Thu, 24 Mar 2022 11:33:16 -0400
X-MC-Unique: AkdLzR3CP2ant435S_RImw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5771628EC119;
 Thu, 24 Mar 2022 15:33:16 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EB00492D46;
 Thu, 24 Mar 2022 15:33:14 +0000 (UTC)
Date: Thu, 24 Mar 2022 15:33:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Spice-devel] =?utf-8?B?5Zue5aSNOiBS?=
 =?utf-8?B?ZTog5Zue5aSNOiBSZTog5Zue5aSNOiBSZTog5Zue5aSNOiBSZTogW1BBVEM=?=
 =?utf-8?Q?H?= v1 1/2] drm/qxl: replace ioremap by ioremap_cache on arm64
Message-ID: <YjyPODaEUKC693sL@redhat.com>
References: <olr8fzd5ad-olr8fzd5ae@nsmail6.0>
 <20220324132109.3ox6k2wif6tkp47n@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20220324132109.3ox6k2wif6tkp47n@sirius.home.kraxel.org>
User-Agent: Mutt/2.1.5 (2021-12-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, ray.huang@amd.com,
 liucong2@kylinos.cn, daniel@ffwll.ch, airlied@redhat.com,
 spice-devel@lists.freedesktop.org, Robin Murphy <robin.murphy@arm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Mar 24, 2022 at 02:21:09PM +0100, Gerd Hoffmann wrote:
> On Thu, Mar 24, 2022 at 06:34:02PM +0800, liucong2@kylinos.cn wrote:
> >    ok, thanks, a lot of our customer use qxl on x86 before, so it still need
> >    to supoort qxl on arm64.
> 
> Well, qxl isn't the best choice even on x86.  The main advantage it
> offers (2d acceleration) is basically useless today because pretty much
> everything moved on to use 3d acceleration instead.  So qxl ends up
> being used as dumb framebuffer with software 3d rendering.
> 
> So, I'm still recommending to just use virtio-gpu ...

Also bear in mind that while almost no one uses the 2d acceleration
in QXL, the QEMU device still implements all the 2d functionality.
This exposes an attack surface to the guest VM, from code that is
largely ignored by maintainers today, as attention is focused on
virtio-gpu instead. 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

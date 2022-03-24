Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3244CC433F5
	for <virtualization@archiver.kernel.org>; Thu, 24 Mar 2022 10:27:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DBF714102C;
	Thu, 24 Mar 2022 10:27:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cwN8iWqJu60r; Thu, 24 Mar 2022 10:26:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4391D400A8;
	Thu, 24 Mar 2022 10:26:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16F16C001A;
	Thu, 24 Mar 2022 10:26:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B0A6C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 10:26:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 67BAE4102C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 10:26:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g4aL1PtXDmCO
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 10:26:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 256D8400A8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 10:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648117615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F8jc/bx/HzJp4dhctGOy3fEy8URceAcwu2QM3mRZ9WQ=;
 b=QysdC/oW51dx3cwwkf1LhovcB/ScbuMZt3VzLP6rin3PFPsHA8kfScr/Crtp6lnAojieji
 q3DB6H5L/uhHDXCrHiqyseNKikQi47XeXreHDdjcYDZJFND86wXMLs8NiNvwcU51PWSquV
 vWAmuEwDS15sknIuNF7B1xUXsM3qhSo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-463-dXkEgGkDOMqURq3skhMiEQ-1; Thu, 24 Mar 2022 06:26:51 -0400
X-MC-Unique: dXkEgGkDOMqURq3skhMiEQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2105C28078DE;
 Thu, 24 Mar 2022 10:26:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.196.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0B56141DEDB;
 Thu, 24 Mar 2022 10:26:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0D57318000AA; Thu, 24 Mar 2022 11:26:49 +0100 (CET)
Date: Thu, 24 Mar 2022 11:26:49 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBSZTog5Zue5aSNOiBSZTog5Zue5aSNOiBSZTog?=
 =?utf-8?Q?=5BPATC?= =?utf-8?Q?H?= v1 1/2] drm/qxl: replace ioremap by
 ioremap_cache on arm64
Message-ID: <20220324102649.axcgnofblqqua63e@sirius.home.kraxel.org>
References: <2n05d7wxagz-2n05d7wxah0@nsmail6.0>
 <12eba824-ee80-0aac-56ed-e13084c9cae7@amd.com>
MIME-Version: 1.0
In-Reply-To: <12eba824-ee80-0aac-56ed-e13084c9cae7@amd.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, ray.huang@amd.com,
 liucong2@kylinos.cn, daniel@ffwll.ch, spice-devel@lists.freedesktop.org,
 airlied@redhat.com, Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Mar 24, 2022 at 10:20:40AM +0100, Christian K=F6nig wrote:
> Hi Cong,
> =

> when I understand Robin correctly all mapping (host, guest, kernel,
> userspace etc..) must have the same caching attributes unless you use the
> S2FWB feature introduced with Armv8.4.
> =

> If you don't follow those rules you usually run into coherency issues or
> even worse system hangs. So you not only need to adjust the kernel mappin=
gs,
> but also the function for userspace mappings to follow those rules.

That matches my understanding.

For qxl specifically: when using the xork qxl driver getting the
userspace mappings right is essential because userspace will write qxl
command buffers then.  When using the xorg modesetting driver or wayland
the worst thing happening would be display corruption because userspace
will only map dumb bo's for pixel data.

I'm wondering though why you are keen on getting qxl work instead of
just using virtio-gpu?

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

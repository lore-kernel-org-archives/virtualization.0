Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1752CC433F5
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 10:11:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A825260BEB;
	Wed, 23 Mar 2022 10:11:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wn6o_2fWZ726; Wed, 23 Mar 2022 10:11:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 47AD660E67;
	Wed, 23 Mar 2022 10:11:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 172A4C0012;
	Wed, 23 Mar 2022 10:11:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FCD4C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 10:11:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2E5F460BEB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 10:11:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z5_Y6EW7ou30
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 10:11:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 43CDB60BDB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 10:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648030305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRlbgUKoboQvtHs0uy2s00DW+qHr4F9Xa1tGZLniJ+c=;
 b=DQT+J8pb+IUCKsGtUFttUTx/lVdxv+F2oCR+z8kdxcfGkA3qSJwkt2/mD1s3j+FyFuCrzc
 gCOQOToC07cos9XDzZYQhETcFDSuMUowyXREPe9lDTqOaDQ81/jEoW8hxOtWaa8CoI4dL0
 aiCuECBfGICCfvo4q3f5nUFx/naa1xE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-S7ju9NHeNSOyvYmLS0mV9Q-1; Wed, 23 Mar 2022 06:11:41 -0400
X-MC-Unique: S7ju9NHeNSOyvYmLS0mV9Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC474811E80;
 Wed, 23 Mar 2022 10:11:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.196.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 29B4C1427AF5;
 Wed, 23 Mar 2022 10:11:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 96F3A180063D; Wed, 23 Mar 2022 11:11:38 +0100 (CET)
Date: Wed, 23 Mar 2022 11:11:38 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v1 1/2] drm/qxl: replace ioremap by ioremap_cache on arm64
Message-ID: <20220323101138.7oiwefh7ofcxojgq@sirius.home.kraxel.org>
References: <20220322093444.1236582-1-liucong2@kylinos.cn>
 <e2bc20e4-41e1-7162-257c-f2ad3309f1cb@amd.com>
 <a6acb2ce-2465-6619-e3fd-ac34ddf07d35@arm.com>
MIME-Version: 1.0
In-Reply-To: <a6acb2ce-2465-6619-e3fd-ac34ddf07d35@arm.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, ray.huang@amd.com,
 Cong Liu <liucong2@kylinos.cn>, daniel@ffwll.ch,
 spice-devel@lists.freedesktop.org, airlied@redhat.com,
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Mar 23, 2022 at 09:45:13AM +0000, Robin Murphy wrote:
> On 2022-03-23 07:15, Christian K=F6nig wrote:
> > Am 22.03.22 um 10:34 schrieb Cong Liu:
> > > qxl use ioremap to map ram_header and rom, in the arm64 implementatio=
n,
> > > the device is mapped as DEVICE_nGnRE, it can not support unaligned
> > > access.
> > =

> > Well that some ARM boards doesn't allow unaligned access to MMIO space
> > is a well known bug of those ARM boards.
> > =

> > So as far as I know this is a hardware bug you are trying to workaround
> > here and I'm not 100% sure that this is correct.
> =

> No, this one's not a bug. The Device memory type used for iomem mappings =
is
> *architecturally* defined to enforce properties like aligned accesses, no
> speculation, no reordering, etc. If something wants to be treated more li=
ke
> RAM than actual MMIO registers, then ioremap_wc() or ioremap_cache() is t=
he
> appropriate thing to do in general (with the former being a bit more
> portable according to Documentation/driver-api/device-io.rst).

Well, qxl is a virtual device, so it *is* ram.

I'm wondering whenever qxl actually works on arm?  As far I know all
virtual display devices with (virtual) pci memory bars for vram do not
work on arm due to the guest mapping vram as io memory and the host
mapping vram as normal ram and the mapping attribute mismatch causes
caching troubles (only noticeable on real arm hardware, not in
emulation).  Did something change here recently?

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

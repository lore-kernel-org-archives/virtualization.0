Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9FAC43334
	for <virtualization@archiver.kernel.org>; Wed,  6 Jul 2022 07:13:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D501640AFC;
	Wed,  6 Jul 2022 07:13:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D501640AFC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T4vWfTfP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VVTsMPzDE6b3; Wed,  6 Jul 2022 07:13:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7E28B400E2;
	Wed,  6 Jul 2022 07:13:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E28B400E2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39744C0071;
	Wed,  6 Jul 2022 07:13:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9FC3C0070
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 07:13:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9DD37417A8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 07:13:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9DD37417A8
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=T4vWfTfP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8NVgEYgw1XIi
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 07:13:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ACF7540931
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ACF7540931
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 07:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657091589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xC/tPIV26dzWDx6JEF57ktxGrZ/+tVkL24+pBomvNqw=;
 b=T4vWfTfPBHb2vDDsGGGTOQyAKaVRPjMABUB+OXSZSuXTvRc7benvK6rMf9x6gny/nCo54Q
 Hmv3LKvSp6mpi17mYsls+QTr1NIsPAURjS3tQpCphXJlAGn6OAY6ghvmDLnSGEb31QME0P
 Yiya2M1+UX+HkpbPPtwGgax+2X9Ts3E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-JJgkedS7NV2rpdhWsPVb4Q-1; Wed, 06 Jul 2022 03:13:03 -0400
X-MC-Unique: JJgkedS7NV2rpdhWsPVb4Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B51461C08969;
 Wed,  6 Jul 2022 07:13:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E1E42166B26;
 Wed,  6 Jul 2022 07:13:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 10D1518003AA; Wed,  6 Jul 2022 09:13:01 +0200 (CEST)
Date: Wed, 6 Jul 2022 09:13:01 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v7 7/9] drm/virtio: Improve DMA API usage for shmem BOs
Message-ID: <20220706071301.43fvbioka4iksqup@sirius.home.kraxel.org>
References: <20220630200726.1884320-1-dmitry.osipenko@collabora.com>
 <20220630200726.1884320-8-dmitry.osipenko@collabora.com>
 <20220705135323.emr4gdbcxoisdcxe@sirius.home.kraxel.org>
 <d2c64d09-c4bb-9aed-069d-a9b4d07a1f66@collabora.com>
 <20220705154507.67ovlun4m26xzppn@sirius.home.kraxel.org>
 <1380526d-17fb-6eb2-0fd5-5cddbdf0a92e@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1380526d-17fb-6eb2-0fd5-5cddbdf0a92e@collabora.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Cc: David Airlie <airlied@linux.ie>, Robin Murphy <robin.murphy@arm.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
 Emil Velikov <emil.l.velikov@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Dmitry Osipenko <digetx@gmail.com>,
 kernel@collabora.com, virtualization@lists.linux-foundation.org
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

  Hi,

> Gerd, thank you very much! It's was indeed unclear to me how to test the
> MMIO GPU, but yours variant with microvm works! I was looking for trying
> aarch64 in the past, but it also was unclear how to do it since there is
> no DT support for the VirtIO-GPU, AFAICS.

aarch64 uses acpi by default (can be disabled via 'qemu -no-acpi').
Not fully sure about arm(v7).

Even with DT it should work because DT only describes the virtio-mmio
'slots', not the actual virtio devices.

> There is no virgl support because it's a virtio-gpu-device and not
> virtio-gpu-device-gl that is PCI-only in Qemu. Hence everything seems good.

It's named 'virtio-gpu-gl-device'

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

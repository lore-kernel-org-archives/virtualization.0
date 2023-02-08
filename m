Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E116C636CC
	for <virtualization@archiver.kernel.org>; Wed,  8 Feb 2023 10:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24D7E81F41;
	Wed,  8 Feb 2023 10:29:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 24D7E81F41
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=qNvBsfjN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VvaXq_x7qx2B; Wed,  8 Feb 2023 10:29:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9F5DB81EA1;
	Wed,  8 Feb 2023 10:29:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F5DB81EA1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 718C8C0033;
	Wed,  8 Feb 2023 10:29:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0296C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Feb 2023 10:29:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B3D7940B8C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Feb 2023 10:29:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B3D7940B8C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=qNvBsfjN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D8_hHuEy7JIN
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Feb 2023 10:29:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EF32F40105
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EF32F40105
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Feb 2023 10:29:41 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id e19so10830448plc.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Feb 2023 02:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Uw2ZicEA5RLzfShMXQ1dwaKNDb+ZvEQ5nofhk/pEKE8=;
 b=qNvBsfjNBF1TkmnJTB3tUs4ujn+RLEV1Twl1prVx+53gUaxKFIy+mCCT33Cg+gE5tn
 YTdT/tgxI8JWYnb8kl1KE8f7JQWbSioraFlguQvUmbyuBrXhFrKebzHO0S6MeuaQJfv0
 bYgsluSWWVbKreOBmLyRvaoaNDEj70uvFKRzk5sEUhhHaL2MRuZcHDpFbQKSbJxMRacu
 gu9XR6iUMFR9ZzbRUfHW8mHUezeg0H0j0MQM8mU739C2b9DtqwRROw5VF8PvEwqUNiEB
 O/QCPyZB18cjx8JUBDwZUaQjnEH2/jbXrpkpJhr0zqmxU79zMu3Z0+anu8mNzDXqA0f5
 5lzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uw2ZicEA5RLzfShMXQ1dwaKNDb+ZvEQ5nofhk/pEKE8=;
 b=FAmc+luV6q99YPowRUIa3eSn9hnncIjRW5JdnGw07G3k/IJlK5qrD+6Ugg+VIoLuTL
 wH4jE5UUd6z9DgyGYPgaez7MB+8w3cQWOaDSm6cTyoe2YlS3LAL8DfQH1koa0LtfwqAU
 mrw4+VMmOuVUdZOtIogdkotsvGGoYSFgH8ItbZNauR9+5ndzuqWjtSqQjUQlg+VMfyZt
 kWTWF0gXPTUUOqka7ST01BdtxaWBlQsfk2RV2+fj0Pi3E0MNb2GmTKlfTet6AkCQWfpb
 Mizp3Pxr3VdwpRRZb/M42BqBFAGX8udZ2wlukGp4p++mCK0lGwGsF4/WOQLvdPGs8Gew
 mDZw==
X-Gm-Message-State: AO0yUKW4OWWrICnLu56Smiqg3/8RRTeISbEy9GWN4bbSEpRmvvTzfXE8
 MiOqNaixSVMJWRnp95+Jl8HQznNIeBxUYXQs0CE9sA==
X-Google-Smtp-Source: AK7set/D85OP4MbEUttLin1Mc4kBwGa/GSqWKwYp9esG56LQONCdHonoSsb/1780I1mBh093u4BaKZgg9Akx7nlrlwU=
X-Received: by 2002:a17:90a:764d:b0:230:c6fa:9305 with SMTP id
 s13-20020a17090a764d00b00230c6fa9305mr600415pjl.93.1675852181066; Wed, 08 Feb
 2023 02:29:41 -0800 (PST)
MIME-Version: 1.0
References: <20230208094253.702672-1-eperezma@redhat.com>
In-Reply-To: <20230208094253.702672-1-eperezma@redhat.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 8 Feb 2023 12:29:03 +0200
Message-ID: <CAJs=3_DQQPGUYK_Fv4tuiVcdJ6V1dtRjRkUL3_EqNhwJt-+kYg@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Dynamycally switch to vhost shadow virtqueues at
 vdpa net migration
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Lei Yang <leiyang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 longpeng2@huawei.com, Shannon Nelson <snelson@pensando.io>,
 Liuxiangdong <liuxiangdong5@huawei.com>
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

HI Eugenio, thanks for the series!

I tested the series with our DPU, SolidNET.

The test went as follow:

- Create 2 virtio net vdpa devices, every device in a separated VF.
- Start 2 VMs with the vdpa device as a single network device, without
shadow vq.
   The source VM with "-netdev
vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,id=hostnet0"
   The destination VM with "-netdev
vhost-vdpa,vhostdev=/dev/vhost-vdpa-1,id=hostnet0"
- Boot the source VM, test the network by pinging.
- Migrate
- Test the destination VM network.

Everything worked fine.

Tested-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA69AC47089
	for <virtualization@archiver.kernel.org>; Mon,  5 Dec 2022 16:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3A8AA40193;
	Mon,  5 Dec 2022 16:55:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A8AA40193
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=BGuV1KzR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mf0al_PUxi7A; Mon,  5 Dec 2022 16:55:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D770F40239;
	Mon,  5 Dec 2022 16:55:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D770F40239
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93CE0C0033;
	Mon,  5 Dec 2022 16:55:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 517A6C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 16:55:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2B8AF813F4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 16:55:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2B8AF813F4
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=BGuV1KzR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FFSlxREiYavE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 16:55:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A362813F0
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A362813F0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 16:55:24 +0000 (UTC)
Received: by mail-io1-xd35.google.com with SMTP id 3so1681796iou.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Dec 2022 08:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0QodG8RJKnCqNufeEIIJdgXCu8dUCAVeVMPgRJOL4GA=;
 b=BGuV1KzRLszzoWS8B9MmSfCFnSqf383ZoK3Rj7c+FKosfVUkrGIpG5L4cXXqFM7v46
 8XiSpMske0eYmBFOqdyxIQkQJnETebeZf+NP2DaNN7JmDEUsET+uik83SKAJC84xOgtN
 V7A4K/TEtCkZNC0kvw8IRV87TnMoTkR2+g8QsjS+9ucHeqXeCPalze3RDVD3UnIGzuqM
 9oGZfSB9x9fyTdauig6qoJQEgaRBLJE13CTBBJjV3f55+fdGq6ZhisTiG554+jj+a7F/
 NJup1W4JPX/ayoSDn0OVpSlR1KLJZ3LKDDeY1e8nsqcUdGRxQREYz8ujqx3ebfqByzW7
 nZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0QodG8RJKnCqNufeEIIJdgXCu8dUCAVeVMPgRJOL4GA=;
 b=TYmhBljzZ0nB+7ZO3os080FtGBnK7E6ZBz6XO2b1yNXKNwxYGdZ9RNUnfSlHNO6p8d
 dfFVbysF3xmE3N6RIuuTki3Cl9aaxz+9D64FcMJlUF99wjQbvmmqgvCTi7lJq/mXNyi5
 tQh44NaZpUC2CbUP0YnXQKmz9pL7ItOglTxQ1KjIymsfaj05Eq4pY8vBZlN/VhszTl8c
 kiF2dptncG2yOMvyVIGNqBJz7RmZCxh+D07heO20ysMqcQ9nrrsLSVq1P3xjpg5OpgW+
 KQ3wPaHRa1Td7fssz7td/twzIP9oucaJgxuHqJW77Se3OmPX6/vFbUurl8Eaz1jGLbnR
 FblQ==
X-Gm-Message-State: ANoB5plsjlOtpHAaNjj3qnnqg6reOnklh41Nnflv7xhgFhwt0DZq7TGN
 3b4/q7qxUSsLt4sqhuQVoDJc/+SMqbix9EjQYOsG4A==
X-Google-Smtp-Source: AA0mqf4ds3rGOKWv83T439XeinKDlOaSwKqBZmFtL5xfagtwNssr5PQi7Kcj2U4WhfbEkofto9Te4AoMYEBNXCry6ic=
X-Received: by 2002:a02:8603:0:b0:38a:9b1:d500 with SMTP id
 e3-20020a028603000000b0038a09b1d500mr10222571jai.252.1670259323414; Mon, 05
 Dec 2022 08:55:23 -0800 (PST)
MIME-Version: 1.0
References: <20221129143335.1902170-1-alvaro.karsz@solid-run.com>
 <9cc0448a-7a69-727c-a27e-32a27b7cd5e4@redhat.com>
 <CAJs=3_AOoY=8GmMEbQfz2LDGPVWHgU5pw5Levs8rBTsSwfUdpg@mail.gmail.com>
In-Reply-To: <CAJs=3_AOoY=8GmMEbQfz2LDGPVWHgU5pw5Levs8rBTsSwfUdpg@mail.gmail.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon, 5 Dec 2022 18:54:47 +0200
Message-ID: <CAJs=3_A+4hdcrHEiuQv+z_4SHoKNQ8F5qJYDA8SkOBk+SZFwWA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: vdpa: new SolidNET DPU driver.
To: Jason Wang <jasowang@redhat.com>
Cc: Jean Delvare <jdelvare@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>, virtualization@lists.linux-foundation.org
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

> We must send a  SNET_MSG_DESTROY message to the DPU before removing the device.
> This remove() makes sure that if somehow remove was called
> before/without reset, the DPU will receive this message.

I meant that the message must be sent before the PCI device is removed.
The message is sent from the vDPA reset cb, and the reset in the PCI
remove cb makes sure that PCI remove wasn't called without calling
vDPA reset.
I can remove it if you think that this is not required.


Alvaro
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

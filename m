Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69764C4321E
	for <virtualization@archiver.kernel.org>; Mon,  5 Dec 2022 09:26:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DBFCD404F6;
	Mon,  5 Dec 2022 09:26:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DBFCD404F6
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=qvkiqBK4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rb6T8POeCXlx; Mon,  5 Dec 2022 09:26:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5C8FE40153;
	Mon,  5 Dec 2022 09:26:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5C8FE40153
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28025C0033;
	Mon,  5 Dec 2022 09:26:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12646C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 09:26:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E1F006068F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 09:26:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E1F006068F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=qvkiqBK4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EQxXEqEZSj-X
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 09:26:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 74AF4605C9
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 74AF4605C9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 09:26:02 +0000 (UTC)
Received: by mail-io1-xd36.google.com with SMTP id d123so1695217iof.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Dec 2022 01:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y9toifbCuBh0gX5Y+Zg/GinrrYZkm+flnR3bBlKLdlg=;
 b=qvkiqBK4ZHcvECraT+z6CPWdSilJzGwWxbHga9OS/s6sszLCcXi6E5l8MtXa40mxdn
 Ki5Qg8R1SEvmyEd2DSzjhT0b33k7Q65cF4KF1+zQudPJZedYRl/6HDWDlIiqTyEZ9vdN
 HTuvtY0hjfzgtB5tm4AHsfg+Z4lcOxTgguNCAF4CDu1QdL08ss5pOxttboJrpJdK+Nl5
 F0lbl+wHvnLc0SpiYCmTVxJwYpdyJqFd2yxuZC88A6NPxFmRvICIgk/aLx10fpqhsacy
 E5oWh4wDiJTSiCc8ZsuSOkZmiwK4xE3Y2EJ9SfgnVJcuT6SpLg8AOR46ukHDvaWwlofD
 vpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y9toifbCuBh0gX5Y+Zg/GinrrYZkm+flnR3bBlKLdlg=;
 b=3O0oWSkKOtQQ/paySmzy5odZ+LDg1eEI6UMpslD1g/BFIaDCBVJg4Vto1IIls3uxTB
 yUL7WmjDwOJsq3wW5d938tVKTl79NOZxJSwHJ799SXh0fVdqK1MAJNzmU8Km2H7S/aD1
 jFpBFS5JPuI9sY5XMQdsC+Oqt7L16khO2UJkttxreT6wMK/2BBHfwUHv3+e7jYAjpyoH
 tDBFYKbVtBzM01M5wdeCalJiGCaesDzrDWrf5TaZFVxxVnAnUAJOB3wOpxnVkegtfPDw
 kcS6SKdXLrTVR7/VIwvKKEcifiV1u88Ra96Z8E5UlQioZE6p0jF77084amDxvCIOm1uf
 JRdA==
X-Gm-Message-State: ANoB5pmSjfhnBaghD/idmFRB4y2RnaF7W2ue5R+hjcIqHfNGGhmZgfY+
 USQloxnbTZ6JSJQN5g4I5Kl49TQH7mO93Ti7KRORzA==
X-Google-Smtp-Source: AA0mqf7GDhRsz+cMBkNgl6wEsG7N0iQdUR1Vs7KYA7VSGDbpTbU1EZU1pNDKJEO8mtCgIr3DNgMgcz6XqX/dPkI3KtE=
X-Received: by 2002:a5d:9385:0:b0:6da:b0b7:ec83 with SMTP id
 c5-20020a5d9385000000b006dab0b7ec83mr26640669iol.93.1670232361500; Mon, 05
 Dec 2022 01:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20221129143335.1902170-1-alvaro.karsz@solid-run.com>
 <9cc0448a-7a69-727c-a27e-32a27b7cd5e4@redhat.com>
In-Reply-To: <9cc0448a-7a69-727c-a27e-32a27b7cd5e4@redhat.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon, 5 Dec 2022 11:25:25 +0200
Message-ID: <CAJs=3_AOoY=8GmMEbQfz2LDGPVWHgU5pw5Levs8rBTsSwfUdpg@mail.gmail.com>
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

Hi Jason,
Thanks for your comment.

> I wonder if vq_num and max_size_host_cfg is not about to be changed by
> the upper layer, any reason not fail the psnet_read_cfg()?

You're right, I can catch this error earlier in psnet_read_cfg.

> So during reset, the irqs were freed, but I don't see how they are
> allocated here.

The IRQs are allocated in probe and are freed in reset.
This assumes that the device won't be revived after reset.
I  will change it and request the IRQs in snet_set_status.

> Any reason for this reset in the remove()?

We must send a  SNET_MSG_DESTROY message to the DPU before removing the device.
This remove() makes sure that if somehow remove was called
before/without reset, the DPU will receive this message.


Alvaro
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF67C4332F
	for <virtualization@archiver.kernel.org>; Thu, 29 Dec 2022 12:09:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 234A180BA0;
	Thu, 29 Dec 2022 12:09:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 234A180BA0
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=brKW5+n6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RwfC85UmfEX5; Thu, 29 Dec 2022 12:09:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1AB5580A55;
	Thu, 29 Dec 2022 12:09:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1AB5580A55
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5CDCC0033;
	Thu, 29 Dec 2022 12:09:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B9C0C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 12:09:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F3844047D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 12:09:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F3844047D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=brKW5+n6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9GOy5NCRZbdY
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 12:09:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E4624403D0
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E4624403D0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 12:09:11 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id v3so12272693pgh.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 04:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LKQAf165q2GYAJ6df90mK2ocE6dVs8653dgRlwxP66g=;
 b=brKW5+n6g6R87cN9ldLAAVHhujsMyACQw/WW8LJ8itT9uECTC2xu6/cinuX693zryl
 c9ifvMNoLgSiKBh95nO7VPq4n20oBVpj81adNyWYd/lPp5moANi+BiOwA5p1ul/PCHXU
 FGP2b5euRdrVlJaGdykXbN93b5ZpXNiMmY4/EEwUGIWuxQxDyM5KcrXPRDlJsz3D4srs
 sXk2vkSc6+wpgBKLE9RBBsfCF5dZiagch33wEPIx+1L1bshI1uDbssseUxcjlff3T5cg
 1t6lvgBkSyKGlS0N4tC/+tf/wVc1NsV1+ae5kMupEyhTdfcMcxNVQUA4OZVy+AkWUpGs
 sRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LKQAf165q2GYAJ6df90mK2ocE6dVs8653dgRlwxP66g=;
 b=P1lKV4uZ9ERSmr2reLsDb9pQYp1rUxjL9CkO3XwTEAGxdXYMRCtGv+szKl7lSG2eKU
 M9tdepSUnj2Nf99waHBJJqdEm34voonSb9jBFZXN5MsUB0NPsaYKHK66B/NJRwIunK8n
 Z4rrTrd3OIIhhdHXqJWCg0LkFi2Q3VBa4kfm2umGsnPyp8zwYdXomCF6os44MctTf9Wh
 J3Fp0EuNxhodWCn9rtVnBHLbYAGMps0dauvQlBbuiAHHwqc/NF13bPvhq4bm7tS17WYF
 ffDrhH9VmGK6kmYSrv9LO2UDaOFBK2FBPqccOnB6aCJrsVdQVSmIlRdQE3swXH8L05wY
 KrlQ==
X-Gm-Message-State: AFqh2kqShpNh7y1QtCSwwGYBAA0rqBSs/PJSEfXz5064Ac/fPXyWm2oF
 XfRDvsSm+Loi0D7LCREUos42jMLNvCtzESGaaL+aAw==
X-Google-Smtp-Source: AMrXdXt1Us6Pft3if2DIPzlyzIT7EAJIu1P91kWQa+fhnUWxIU8z8EocAyjDtOp7TIQ01F5RBw3Yuffmq6Fi4rBkrDA=
X-Received: by 2002:a65:45c8:0:b0:48c:5903:2f5b with SMTP id
 m8-20020a6545c8000000b0048c59032f5bmr1452115pgr.504.1672315750885; Thu, 29
 Dec 2022 04:09:10 -0800 (PST)
MIME-Version: 1.0
References: <20221219122155.333099-1-alvaro.karsz@solid-run.com>
 <20221229030850-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221229030850-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Thu, 29 Dec 2022 14:08:34 +0200
Message-ID: <CAJs=3_ApAnMTC0O81vO=hvRLssLYRnJsVUE5gd_aomCB+5eWLQ@mail.gmail.com>
Subject: Re: [PATCH v5] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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

> So due to my mistake this got pushed out to next linux release.
> Sorry :(

No problem at all :)

> I'd like to use this opportunity to write a new better
> interface that actually works with modern backends,
> and add it to the virtio spec.
>
> Do you think you can take up this task?

Sure, I can do it.
So, the idea is to:

* Drop this patch
* Implement a new, more general virtio block feature for virtio spec
* Add linux support for the new feature

right?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

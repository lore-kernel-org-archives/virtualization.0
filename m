Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E5FC4167B
	for <virtualization@archiver.kernel.org>; Mon, 19 Dec 2022 10:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BFEC640181;
	Mon, 19 Dec 2022 10:55:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BFEC640181
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=hz/LA/UW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4WXVnYEkW_P6; Mon, 19 Dec 2022 10:55:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 66458400F8;
	Mon, 19 Dec 2022 10:55:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 66458400F8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12AEDC0032;
	Mon, 19 Dec 2022 10:55:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CE98C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 10:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E44F581364
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 10:55:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E44F581364
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=hz/LA/UW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qUhrP0T6Gs_K
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 10:55:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A39681363
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6A39681363
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 10:55:40 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id a14so5957791pfa.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 02:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bcUxBgVr1z9DyQ4ZN2GN42Ihfr7E/yAe4kWvlKo/9VE=;
 b=hz/LA/UWMhUrKc88oqLv8a5AOO+B6sEdDVPbcCMjTKBSYTkliVR/8zKqmlC1v3srEO
 3puDnIEUH6kSdA4wITqevLiygPOddqtvdL9C/cWGPUFobBkoYS34CRZxlaGnu2hxyKRQ
 VnpmjX86mxK0ZFWPu6BNfn25mZRdsDUcJyruWO+4ymiPxVtGblaXosEWCxp82YSzLNoM
 1ktZkcXqATyd3RM32EDtBUEnYwlNaqnmmXgoEI3WZ4hlYl8iabTLp0smE4dSyEGyZa0E
 te8nPPmEDLv39jRYjRbJlWXDWTWmCGzETgZRULoFooKFPGkWXECXORBuXWny8bEzlIyj
 ek3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bcUxBgVr1z9DyQ4ZN2GN42Ihfr7E/yAe4kWvlKo/9VE=;
 b=SQr0OVGtzbsc/wc1aIQRAr+YTL5hZqE44tH5XtH7ONmCxNkBlxEcnw0TVihC7up1gs
 O3Wh1DlBXRmWi0y1oXwUlKu8y3rmBGoE2TsRTrFrWcOTAVJvfaNC1r6oVd133xyUCFSF
 JPhdW0lVRqUDn2HrRbeU6Lfvbvk1T7IcWq8f+H53e50AChFAHLJAIyMP0D2jxg/VKotQ
 Q3g0StbIAkYAv7yUfrpcbkrBPsMJUCT8dbO3YS6aNk+8WWDohLjOOgsK8ISSY1URNTad
 kdKO9fefACXfjbVFNPBAYji+i2nGnfBqWEUZlZNIlgXGlmgz3nFQPhF0M0OwKPhsxFFL
 kNAA==
X-Gm-Message-State: ANoB5pluKpZLW2eNIjAqqNCAq0V+bvdN9YvLjCTIdD5CtTc61d+xVxv9
 h3vy0OzC9JwXn5y8Szv1/h7IlY80wf+gENbJwktIOQ==
X-Google-Smtp-Source: AA0mqf7rPC0YgLWsVPpb+FmNTD+eVkLuI7fLf1hvZREsRO6CU3k+C4ECG2TcrBjQHusbGAQIeozy3w9W4ChOzgQ5SFA=
X-Received: by 2002:a05:6a00:10cd:b0:572:5c03:f7ad with SMTP id
 d13-20020a056a0010cd00b005725c03f7admr100325300pfu.17.1671447339734; Mon, 19
 Dec 2022 02:55:39 -0800 (PST)
MIME-Version: 1.0
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com>
 <20221219054757-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221219054757-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon, 19 Dec 2022 12:55:02 +0200
Message-ID: <CAJs=3_B+NB9LuqDBw_1a_6mXGCP2rA6bsrxLuoQ6gWdEg-vscg@mail.gmail.com>
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 virtualization@lists.linux-foundation.org
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

> could we add a comment explaining this trick please?
> can be patch on top ...

Add a comment where?
Do you mean adding a comment in the change log?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

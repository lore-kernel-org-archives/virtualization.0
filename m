Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C3EC4332F
	for <virtualization@archiver.kernel.org>; Tue, 13 Dec 2022 09:49:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7317560B2E;
	Tue, 13 Dec 2022 09:49:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7317560B2E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=2Uep2WiD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FdNJEw5lSyrr; Tue, 13 Dec 2022 09:49:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 12884600C4;
	Tue, 13 Dec 2022 09:49:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 12884600C4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDA1DC0032;
	Tue, 13 Dec 2022 09:49:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AEF5C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 09:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6E70B80C24
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 09:49:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E70B80C24
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=2Uep2WiD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w8LI2yvzSa3z
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 09:49:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D570A80C22
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D570A80C22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 09:49:39 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id x66so1816254pfx.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 01:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F28/EdyRvefoVHyGfMio1JFWTkHmrhy+T6OdTBNf+8U=;
 b=2Uep2WiDct1n2ETNSZj0mBuhTSpvFpVPRUBReK2DjCLZHUFr72+q3QYqh9ydX+TiSJ
 vUrN+KsDe53917F1iFN7RQruLZedT73dpnauAJWUMpXobkrYL2KMApfWrgTy19ANibLw
 w2xtSA1rPzfWhluqDM2/745lBtBkDStGs5tT6YuqZC5biJ8mgJUcAusMtfjmmeK2dHFG
 y3/628cfch1txfsH2El3YAuQ2eTbCdsPHwQnAjab9RQQ9KSEf1b6W5+uJ3pL07lOodTX
 WJCFxx2zHCdmCEbZPB1ygfaWwVUCTWHVul45KRiobV9uXui0cf7N9UvcBKdlHBhejcYC
 DOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F28/EdyRvefoVHyGfMio1JFWTkHmrhy+T6OdTBNf+8U=;
 b=qXDKtzwEu/w7T5ut6CtigdchDIAfblyeeYxuoOyJkK91v9Mkldkf97sLWNLAHCTF+P
 tp6Oz+EYwaQnyCnzNbU0Kzt07exQ6O7nW1FSrZsw3nNVL5+/2E1tfueKd/sY5Pr4kabs
 P7WBW2WmlXeEKaklMJS171OBD6e4F+5wgC8DbhTCDsG4dk4UEbq6U6cv89xyKonGpD8y
 bTTqyZQ/2jULuGM3LeQ3eZfUlBe7dlKAMXAhf7OJk1VTK8cqwHARcv804HVNpic/5/Dl
 Jgg3tY+djNBbe7Z85YuEPa41EkeZl0zmSCba5VYcYwY5WxuftYVtI7kk6LftY3zRql8Q
 Z4eQ==
X-Gm-Message-State: ANoB5pmiNulaVNJmTaH+7mRbR1ubb8agjDmOazXpD72cma6JqA8hnCeL
 fZQJVMLCmqWd6BfZqDDAUlhvYj+ZxHlWwmU2EIV8XnEeFwCEd6LF
X-Google-Smtp-Source: AA0mqf7VihVI8WU1ugZdKx4ZbS/fKwXwCKuGRtGhFMBOldsKaYGCZUPKQKF7xukz+wKXkksXcdyyfPKnaL6qJki1Lns=
X-Received: by 2002:a05:6a00:d47:b0:577:8bad:4f9e with SMTP id
 n7-20020a056a000d4700b005778bad4f9emr6763995pfv.77.1670924978132; Tue, 13 Dec
 2022 01:49:38 -0800 (PST)
MIME-Version: 1.0
References: <20221213094402.3623277-1-alvaro.karsz@solid-run.com>
In-Reply-To: <20221213094402.3623277-1-alvaro.karsz@solid-run.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Tue, 13 Dec 2022 11:49:01 +0200
Message-ID: <CAJs=3_DVnbHoPfETF=X5sf=kYnWPTaLZ-KicNF3PkXSr22eRmg@mail.gmail.com>
Subject: Re: [PATCH 3/3 v5] virtio: vdpa: new SolidNET DPU driver.
To: virtualization@lists.linux-foundation.org
Cc: linux-pci@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 linux@roeck-us.net, "Michael S. Tsirkin" <mst@redhat.com>
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

> +               SNET_WRN(pdev, "Can't start HWMON, CONFIG_HWMON is not enabled\n");

I'm really sorry, but SNET_WRN should be SNET_WARN.
I will fix it

Alvaro
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

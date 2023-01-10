Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2581C54EBC
	for <virtualization@archiver.kernel.org>; Tue, 10 Jan 2023 20:27:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D63661048;
	Tue, 10 Jan 2023 20:27:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D63661048
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=j3FsT18C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xf1hVq9d7e5B; Tue, 10 Jan 2023 20:27:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B968461038;
	Tue, 10 Jan 2023 20:27:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B968461038
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 889DFC0032;
	Tue, 10 Jan 2023 20:27:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02EF9C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 20:27:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9259F417A9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 20:27:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9259F417A9
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=j3FsT18C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mai2a5ytl5wv
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 20:27:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D2670417A6
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D2670417A6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 20:27:43 +0000 (UTC)
Received: by mail-pl1-x634.google.com with SMTP id g16so14406054plq.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 12:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hnalCCYocdOc6dBKQJU+F9gTJfjhuUSpjSRGgEmHt6o=;
 b=j3FsT18CuY1oLPxlhL6paqVFRAsE4lhebHCM5wgJyrciHVCDEVjIeceKjPfaiPdrL7
 vURDctS+icRMDCz6pfDWbi2j5y28dPcphLdlDl4NszW4X65Xo606pcTcZinhAiHwodgs
 IDzgG0Z2AnB0kc1jmomSexK++LRyELFpB8kY/oo/+eMhTKGrSrLOdkUT1Ur8uNoo6YoJ
 a3Apx9J+TkJIEEEne7+vYjc34c8PA4ryBZFkJ5ICTToT3IkmwXkpCaF9TfcTCpcdrMg6
 E9uLSNS8ydPJV2Ohytbrs+dJySeCPS0qQznJAtEyEVgtlfKqViGSfqtcCYY4ROhLgJWR
 zm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hnalCCYocdOc6dBKQJU+F9gTJfjhuUSpjSRGgEmHt6o=;
 b=DO7ACo4o3gifoh+3j3g3FSF05XTn1b14JDUu6vaR1MqEZyssynYxU339DfnDzWYbWx
 U6K5miDGZvgbLETMZpA/WnZy8sUZ40oylrPV2eh8VjNAolsnHeA/d6YALMXKsLWO/+hs
 +ilwk2dXU5fBghGOaPvE5RL78CHUAY9qETm9sqBC8Xd7UzVZz5Xv94MeGEb3U75Lf9lJ
 aEykm/IUwvsNhMGxVFKfKjNuUB/iqYRetPFScPE8vprU2VXAhMQH8V5zSmq5AFKEp8jw
 ySaxxKbPepPw86BA0LC1zPS3YckM6VPziWvNASlCnqBrrZ27jLgugktafUFJnN2XelKs
 gbsg==
X-Gm-Message-State: AFqh2kpav5bwIZfRsm/hrrwEvwqqaKgGZv9aMqvlqqbfgry6ByzJb+Mb
 omTcoNNY23ujE5Z5toVrY9GL2B5Shn7pLZeUd/5yvw==
X-Google-Smtp-Source: AMrXdXsIAS4tz4uevCVL2tigrpJ4P+6YeD9yn4mnyIF2KtgkuCXem6rSV1UwatuwgSg5FLNcEH/OwMb+u8P8QkTVXlw=
X-Received: by 2002:a17:903:2447:b0:18d:e541:8a6d with SMTP id
 l7-20020a170903244700b0018de5418a6dmr3509524pls.104.1673382462921; Tue, 10
 Jan 2023 12:27:42 -0800 (PST)
MIME-Version: 1.0
References: <20230110165638.123745-1-alvaro.karsz@solid-run.com>
 <20230110175528.GA1589047@bhelgaas>
In-Reply-To: <20230110175528.GA1589047@bhelgaas>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Tue, 10 Jan 2023 22:27:04 +0200
Message-ID: <CAJs=3_ApcsYnVxWvBKQ1rxsSCdWRX0Abh2CrPJLK23X+UjF7pg@mail.gmail.com>
Subject: Re: [PATCH v9 0/3] virtio: vdpa: new SolidNET DPU driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, mst@redhat.com,
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

> Beautiful, nice threading, thanks! :)
Sure, thanks for noticing the indentation issue in the first place :)
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

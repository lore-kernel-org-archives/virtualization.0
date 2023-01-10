Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1678CC46467
	for <virtualization@archiver.kernel.org>; Tue, 10 Jan 2023 16:40:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 977D3417CE;
	Tue, 10 Jan 2023 16:40:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 977D3417CE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=tnXiGnTf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bkNDjTtoHrzF; Tue, 10 Jan 2023 16:40:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E30AF417C8;
	Tue, 10 Jan 2023 16:39:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E30AF417C8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B00CBC0032;
	Tue, 10 Jan 2023 16:39:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50030C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 16:39:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2573560FB0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 16:39:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2573560FB0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=tnXiGnTf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yj9ezkVLRsLR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 16:39:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A23BE60DFA
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A23BE60DFA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 16:39:55 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id o13so9479792pjg.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 08:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f2UBCvUFmYInRwn74UFvzQNsOsFN73MDnqKsik60sBs=;
 b=tnXiGnTfFPvEcLDnbZEJF/75GpBDtWxuoh7L/szv9yMKT5/bNu4l9OKkgcDSJAZ3ry
 iXREgR6aVHEh+CFzPareSVPmyC3WKJfAs9txx2bTBj5f5qNUgKjsF4Vh6rB5nIDBxXzV
 YkuDrWIWc2tZQSwrYLWIirEVDAMxzAcXqMvKvUgkp+5MANUFS9lBNvZxxMAU0lmyV56y
 V1vfYBx9teudy3IKbiEbCsNdGhaxc3NgzA0a74UdLu01W2LbQJ8l6NUaqna90PMUp2dh
 AO1pKyrrwNw0dZe/6DVFKN4Lgd7rwXUHnkDEBdLa2q5hTUlZvDHu3cXLx/8VJQDWuogr
 ycag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f2UBCvUFmYInRwn74UFvzQNsOsFN73MDnqKsik60sBs=;
 b=4IWiUg2oYcZw/34qHDYhfpmxos5FxOd4d0Z+6UghXbwuEBO8/0CavX9zueOEfw4wKK
 fHVB1uJ5pxuRxZvUyqlekfMc82NPznYql7ZASW99GRl2/y2JiZhfAkJ6FtVbCzIyA4DY
 SXRpxwij3bxr0I2dmvv4jJpPFPOX9V6aJAdBhqCMa0snR0IEsXvIV+OGC6XnDVzsMHM0
 QOPH2Wa4p20AUE+TslcmpDEY1VPiLLNbj+d7Tc78uJ46a8SsKbL6jWqsnc9c/Tg0V+JZ
 5cWipVrBTCZGT34zLaOk4r8zMJugC1U4IMhtat5SvgVYv8KdcpZ0I3gMccuhe0DPhm2R
 yiqA==
X-Gm-Message-State: AFqh2kpGxmGSjEczQGcZPgghORrLAxaY3alFGXO7qx1uP1wmcPIYK6dV
 9AunExjJrtK82o4SewsnoYTiE5CwpzGneD90padAlg==
X-Google-Smtp-Source: AMrXdXsTJollCDt1+PW9Sqma+EGTebP4RvX8ZMYoq/6e/0ff9vgNybAoDP2M9sGdrNtWuMXVS2pTRVM6RmJbCEJWLIY=
X-Received: by 2002:a17:903:3014:b0:189:d0d5:e75b with SMTP id
 o20-20020a170903301400b00189d0d5e75bmr6139663pla.163.1673368794845; Tue, 10
 Jan 2023 08:39:54 -0800 (PST)
MIME-Version: 1.0
References: <CAJs=3_Cx1Pxg4iwLY5eWV9RVJoJ-btZVop3rHhzFmtErMJzj1Q@mail.gmail.com>
 <20230110161241.GA1507687@bhelgaas>
In-Reply-To: <20230110161241.GA1507687@bhelgaas>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Tue, 10 Jan 2023 18:39:18 +0200
Message-ID: <CAJs=3_BAYYqQTFgXZbX78Un_eU+tjqM2wMzXLmYWJRhyBH2+AA@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] PCI: Add SolidRun vendor ID
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 virtualization@lists.linux-foundation.org, mst@redhat.com
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

Ok, I'll send a new version
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

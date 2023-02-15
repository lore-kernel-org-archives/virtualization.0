Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A271C636D4
	for <virtualization@archiver.kernel.org>; Wed, 15 Feb 2023 15:08:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 18BD440BD2;
	Wed, 15 Feb 2023 15:08:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 18BD440BD2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=pxB5rQcH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mnZ4mZ95e_tx; Wed, 15 Feb 2023 15:08:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A855E40393;
	Wed, 15 Feb 2023 15:08:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A855E40393
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 887A2C0033;
	Wed, 15 Feb 2023 15:08:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3AFD5C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 15:08:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 21FB58188D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 15:08:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 21FB58188D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=pxB5rQcH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZQnwYb7zA5mB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 15:08:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8CC70813A3
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8CC70813A3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 15:08:11 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id bt14so6058660pfb.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 07:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=om5xFN9DIqdUPr2TpEEvGw4kLIL/LefrYACkVqsX0aY=;
 b=pxB5rQcHCg32tiqpWkO0sVy+jk+yqanZXcRrjHAatJ6cLhdfRA1Y2j6V+1wxoFDWvW
 TPfyWUdVAE580PCr3cNZD7xiayPIl0n1PeVDoeQjk0vn8gbXfABIedSwDVt/cNKeWKyf
 YlzxkzmFNN3QGT06AWdtkuXLb2ZIi0qGsWUdSKbdjC5woS0xzuAYCNbOjY4KLxEqZkC1
 mQYJhnXFf+rz6NrcVn0flST5H3/sr0o4VIoc5VvPiEe4ZzfVf8k92ya/5cD83JzsUvcY
 AIm90BllkG9170bE1ombUAS/QtbbmbxEvA3ArigrjTXr9l9YEva20AojBr92K+1CRRcz
 opgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=om5xFN9DIqdUPr2TpEEvGw4kLIL/LefrYACkVqsX0aY=;
 b=1C9/opRNYYJpaW+SNQCDxpMTL6pMEGnPuboLWLS1Kuh+xOTz8Y3vZH4REmiqXN1bJS
 oZogTOLo2HSvJOK0Pu1cASkcDkIXU0qfaf9rVWdRRBjzkHKYRf8uaJFiWESdbg6B+jcn
 U8Gm23pUgJHIh9ofvNPFULstbSGTZ0TU1KmrSfVt6Fnao6rOzRcI13XCx2WanMUEtm87
 9lfqN4MldoSPX/1EXJgCpesz+OUk/+b+2Ft2al3VQs5SuW7T9tM2hSMrzlOI5IY5pp7i
 wBaeHSLc6Kh1fEo81PnxqkzdywL37Munf7zOS4z5yqHNVjl9xsLGWGh1Iw7+1dLVIsp+
 hZcA==
X-Gm-Message-State: AO0yUKXnPACPtTueyr0GzMTUPpHD9tTu6gjD/6NMcb7Q2VNKNfdcedUp
 sG5QX1A2PEDRQ4Vm2zTMHOIbppOzAX6in6y9MbFLig==
X-Google-Smtp-Source: AK7set8IP+nxzoJIpBKnAnUSj+1hOv4ULHL1fOIa2eJLeSUCIkpwUMrjiRCTinPYHUoPsky+6aEED+11BassA9OUVzQ=
X-Received: by 2002:a63:3c1a:0:b0:4da:146e:f14a with SMTP id
 j26-20020a633c1a000000b004da146ef14amr367627pga.8.1676473690911; Wed, 15 Feb
 2023 07:08:10 -0800 (PST)
MIME-Version: 1.0
References: <20230209075128.78915-1-alvaro.karsz@solid-run.com>
 <CAJs=3_CfX-K9E5Y=s8cK1YKRktcKNmyRhGFcD8OU-N8YYPt4XA@mail.gmail.com>
In-Reply-To: <CAJs=3_CfX-K9E5Y=s8cK1YKRktcKNmyRhGFcD8OU-N8YYPt4XA@mail.gmail.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 15 Feb 2023 17:07:33 +0200
Message-ID: <CAJs=3_Af0wJsdMZs2aqm8Y68c7+zk9y39s0MDFNHMZq-amrAYA@mail.gmail.com>
Subject: Re: [PATCH] vdpa: snet: clear dpu_ready flag on reset
To: mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org
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

Michael, never mind.

I just saw that you merged the commit with "virtio: vdpa: new SolidNET
DPU driver."

Thanks!
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

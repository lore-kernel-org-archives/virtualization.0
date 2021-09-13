Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DFFC433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 22:01:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0181B6112E
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 22:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0181B6112E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BC84E40265;
	Mon, 13 Sep 2021 22:01:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WzGRoLqHQajH; Mon, 13 Sep 2021 22:01:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3CE6B40022;
	Mon, 13 Sep 2021 22:01:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12CD0C000F;
	Mon, 13 Sep 2021 22:01:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E9E3C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 22:01:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EFA8080DAA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 22:01:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Be4vJ_gP27pR
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 22:01:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 03A8980DA9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 22:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631570473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hBIFmwovN0AX7FNl3CrTwWZ3rAWB/MKhfO4Mt83/g5Q=;
 b=FUl5igrIhdofxOqXbp9y7NgtBcZM2a0M/GOzbY9mhPoBCiuUhseK3CeZOSGn7s5xeeNvjL
 STq+1lenwGaDiVKM+NiLsSPnRRTQGfn7uLCwkG8dkK2jknTdHVSnNumvln4IBAJ3aQb8Gk
 /fob5HUiTO0zHXPQ46pqiGwMfTAlVNo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-Doe-148VPCO-msvo5tyonQ-1; Mon, 13 Sep 2021 18:01:10 -0400
X-MC-Unique: Doe-148VPCO-msvo5tyonQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 u2-20020adfdd42000000b001579f5d6779so3167551wrm.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 15:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hBIFmwovN0AX7FNl3CrTwWZ3rAWB/MKhfO4Mt83/g5Q=;
 b=KHmTDfSFj7Z1uaPOqb2Z65AOVh5ibsSr9tQSMI81Y8t8nZbgluvfnXD19C2h5mIsMP
 tb1kZfM3VUeXw4ELVH9XpBqsIKQ5yFgflRPN6p8Aycz1Q94Dd1IggbpU8A/77bPNsauS
 eznDymlwohBofFdtN+1tbGYiIU4Wp7rcGqdpZ3lhw39w8NJ8IHCFnCPPKuRXYOF9sagh
 r2nz4WREZhugwrc7Kgz+PCrVocF5fOkkJpmxREVqHgwOk+akLx8nMdjQSj3eC0KG9e45
 bOSmFIIQSDuQXJ8teTz/K8YfpIJ0jiqVR6YcaYsqP1stOd3rtgDXMTXTiqepVyPJUJrt
 I0XA==
X-Gm-Message-State: AOAM531K3qTnq1mrRe0Rsm5tuKGjSUn+nBJKH7xauYRsTYy9jou87sxr
 B3pGxr+u8Y2nP3ll8wd8jjek/Lb7gHr6QG3L61YiuUCUhlQKFWPCYwa0a64f9tjhUzSVM1y0ooM
 qniEmEB+XLVEm6qtq9z/IcnoawgJ1EoLUnA1eousBtA==
X-Received: by 2002:a05:600c:19d0:: with SMTP id
 u16mr13251213wmq.21.1631570468927; 
 Mon, 13 Sep 2021 15:01:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgHCJVlTo5Q7ufuv4RmgQflxRDkka0ghsQSd8ubKToVxE5UDhUvgwSIExgPSoK0Pk5nJxZyA==
X-Received: by 2002:a05:600c:19d0:: with SMTP id
 u16mr13251198wmq.21.1631570468793; 
 Mon, 13 Sep 2021 15:01:08 -0700 (PDT)
Received: from redhat.com ([2.55.151.134])
 by smtp.gmail.com with ESMTPSA id m1sm7570288wmq.10.2021.09.13.15.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 15:01:08 -0700 (PDT)
Date: Mon, 13 Sep 2021 18:01:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 7/9] virtio-pci: harden INTX interrupts
Message-ID: <20210913175428-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-8-jasowang@redhat.com> <875yv4f99j.ffs@tglx>
MIME-Version: 1.0
In-Reply-To: <875yv4f99j.ffs@tglx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Paul E. McKenney" <paulmck@kernel.org>, david.kaplan@amd.com,
 konrad.wilk@oracle.com, Peter Zijlstra <peterz@infradead.org>,
 f.hetzelt@tu-berlin.de, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>
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

On Mon, Sep 13, 2021 at 11:36:24PM +0200, Thomas Gleixner wrote:
> >From the interrupt perspective the sequence:
> 
>         disable_irq();
>         vp_dev->intx_soft_enabled = true;
>         enable_irq();
> 
> is perfectly fine as well. Any interrupt arriving during the disabled
> section will be reraised on enable_irq() in hardware because it's a
> level interrupt. Any resulting failure is either a hardware or a
> hypervisor bug.

yes but it's a shared interrupt. what happens if multiple callers do
this in parallel?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

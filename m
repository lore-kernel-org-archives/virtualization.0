Return-Path: <SRS0=HAf6=MG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3BCC07E95
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 02:10:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5E3161260
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 02:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E3161260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 96BE983B39;
	Wed, 14 Jul 2021 02:10:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8P7JNvUnBtTs; Wed, 14 Jul 2021 02:10:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 24FFD833A0;
	Wed, 14 Jul 2021 02:10:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00867C0010;
	Wed, 14 Jul 2021 02:10:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45722C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:10:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F3DF60761
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:10:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vgRiAL3yPvhq
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:10:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3189F605D1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:10:45 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id x16so648600plg.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 19:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=gXlJL7ra5SyqPc0iG65gvOPT5c5xzf36xPc1PPpU1xY=;
 b=F44tQNhiaOYkkT64bIFSQ15xn18NX3ZfkXEA567D5eUlr5qmw25qfBkbNJKOZ1RtAM
 yUBzdpKghrVkyIHV1OYVWpAfwo8fBhg2jURAXuaituq8YdIvRmlv/0t2Oliqn/igY16U
 JiERsoTKqcV1cZ1sDBwgOCsYJV8PM697hA6GVnMrRnUQX6w6h5qZCNfTbbkWiRDbd+FF
 Uln4V228uHEGOGc0mlBt1/QA3zpKeqQvgCDFdo2V+gd5K5Tcv0PkkruoFMZOMfSdBUgM
 nTFIgMZ6opatBceDhhzvrXYkaRa6rEZuPpQhY9/f2Faj2Q2zo4qnL1/EHZwxaXcUVHQC
 R2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=gXlJL7ra5SyqPc0iG65gvOPT5c5xzf36xPc1PPpU1xY=;
 b=OHf0lKgo8cJLsmFF2YMowout1waONA37l9frHjAKzWACVyxbQD4IhtU1VRhQvR1zrs
 oqKS1za02mUGe8ErOZ/vG2ngl4wvah+qJ+Kx/dVu79zrz9aHBlnvwKuBpgNJMJOvYY0v
 m8Je4r77vPSouaNSD3OCsw948x3Cc3cbBoowPMVv80ISoXpJV7d5jp/fTmGvgKK1VIV5
 tDjyxrGVyIWm2QldeSw7/uQcbib+RKx3idon8FrI1Uhy0VgtGfGJnvqbnnd/exkRadqZ
 l5sfqAzNliVafXU926uMwpyyhv9EDa54OeGQTgay/buRgnjZ7hIfSBkqiPavoKLOEm7f
 XBow==
X-Gm-Message-State: AOAM533lA2OHEUjvezmMMDnT5jVYFqPVzVI3pfQPCh1uxR5sqyrBRevp
 SRc7JhecOFi6C9SR6/OlM+yiMA==
X-Google-Smtp-Source: ABdhPJzJRksFxhnqpVSkwr6RMFocOpadjnvHZAefwMJ4xF9fIEpb5BbiiuDCxaKGDcyYOFGTwhuy9Q==
X-Received: by 2002:a17:90a:600d:: with SMTP id
 y13mr1304985pji.14.1626228644619; 
 Tue, 13 Jul 2021 19:10:44 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id mz6sm414071pjb.38.2021.07.13.19.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 19:10:44 -0700 (PDT)
Date: Wed, 14 Jul 2021 07:40:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v14] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210714021042.56hnr73wzrie3jzj@vireshk-i7>
References: <984ebecaf697058eb73389ed14ead9dd6d38fb53.1625796246.git.jie.deng@intel.com>
 <20210713113607-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210713113607-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, wsa@kernel.org,
 wsa+renesas@sang-engineering.com, linux-i2c@vger.kernel.org,
 stefanha@redhat.com, shuo.a.liu@intel.com, andriy.shevchenko@linux.intel.com,
 conghui.chen@intel.com, yu1.wang@intel.com
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

On 13-07-21, 11:38, Michael S. Tsirkin wrote:
> I think we should tweak this such that we add multiple buffers but
> only make them visible to host after all add commands were successful.
> With split this is possible by deffering avail idx update,
> with packed by deferring update of the avail bit in the descriptor.
> I'll write a patch to add an API like that to virtio, then we
> can switch to that.

That will be great, exactly what we wanted but didn't ask for :)

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

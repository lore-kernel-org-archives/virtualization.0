Return-Path: <SRS0=XE2Y=MP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00836C432BE
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 02:25:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9951C60EC0
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 02:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9951C60EC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54EE981BD4;
	Fri, 23 Jul 2021 02:25:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y-95QygbdgvD; Fri, 23 Jul 2021 02:25:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ED28A81B9D;
	Fri, 23 Jul 2021 02:25:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCB46C0010;
	Fri, 23 Jul 2021 02:25:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 744CFC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 02:25:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C6BC401F8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 02:25:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id re3eTugxbgX7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 02:25:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 167F2401EA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 02:25:21 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id j1so181440pjv.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 19:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=PQccQSknciYEz+n8vMov2qIaMOTTz2i/faaaUpe1ves=;
 b=A45mqdZ9NUlHUuAdi1IUNK7gOjV5p0ujOWHLzbW0/QXJvJUNFKNny/2c1p4Mtcdr/x
 5S8LqxaRoZAacfPRFifcchpgpzTWy5TvcPM2XtyABgL+A2k8Cwnfg+/6SGhjTrGja3xH
 6mOdzshtd2QPQS0VkG4Ti5P7a4HDVdmeKh9/+qOM/IYZ3dSjHtOIWjXoiRMgPRFxFKvH
 G0F4veE/I0mCHn28OcibHI8w/AgyOO3mPMnsPwluWGKoRlPkRL2C7+wdgYc8VQ+VMani
 dszAucomLARADiWfQiFcdRSUCgbz6I0iscKkLzQVlofTqyOE07KrFotcnJQ69eqejN2s
 QDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=PQccQSknciYEz+n8vMov2qIaMOTTz2i/faaaUpe1ves=;
 b=dMCkIVnqOsXNt3/7NtD1DRxOoWmOqjodybvk/LpfjIehdAgQPD6bWu/Pb8AXbiLHCM
 UUSYpPMV7yhape3zqFWQgigGj2yb8kDOWS2iiCtQIm80yz95guL7OUe8Y2lo9DW1onLy
 L9U/MmYgvimpmWaA0KWk/dks7F+VMf0K79/D1l282Sm34qaf/rIgjx1Cwk/HqqvisbQP
 w7pzXw+Gk1MHC2RX2Fvbklz3xQJi2iMk8pCAlG+B6+MoOCsYohwLmaUHX/meUSLgxTr+
 YJfJG/NYbXQhXwDj/JU8c7Vp496+wvwW23nVM/zbKR3T30cERGpyPB9oUaR9Y02CS0li
 MGlg==
X-Gm-Message-State: AOAM531TgFxmip9bWgXXIOgEWjHoII/7J6HzvhIlmhs95HhieCIIZk9i
 z3h5gkRuWLTngzrriE9zCWBTGQ==
X-Google-Smtp-Source: ABdhPJzhsY60obBNk4BePJxS8brgK9/EnN99iFqvo544XU8b6qNM33Gi/DvHCWhR6iGHXcWT38N5Eg==
X-Received: by 2002:a63:770c:: with SMTP id s12mr2777345pgc.339.1627007121397; 
 Thu, 22 Jul 2021 19:25:21 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id b184sm27503788pfg.72.2021.07.22.19.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jul 2021 19:25:21 -0700 (PDT)
Date: Fri, 23 Jul 2021 07:55:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH v14] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210723022519.olfmnshiulnhevja@vireshk-i7>
References: <984ebecaf697058eb73389ed14ead9dd6d38fb53.1625796246.git.jie.deng@intel.com>
 <YPmQQelKfa4J7zdA@ninjato>
 <4c257470-9b07-d5dc-a5ba-770b0229663e@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4c257470-9b07-d5dc-a5ba-770b0229663e@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: yu1.wang@intel.com, arnd@arndb.de, mst@redhat.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Wolfram Sang <wsa@kernel.org>,
 linux-i2c@vger.kernel.org, stefanha@redhat.com, shuo.a.liu@intel.com,
 andriy.shevchenko@linux.intel.com, conghui.chen@intel.com
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

On 23-07-21, 10:21, Jie Deng wrote:
> I think we can add an i2c_adapter_quirks for this moment. Support for
> I2C_FUNC_SMBUS_QUICK
> can be added incrementally if needed.

+1.

We just need to get this merged :)
 
> I will play this role. I see Viresh also spend a lot of time on this driver.
> 
> So I'd like to ask Viresh, are you willing to be a co-maintainer ?

I will be happy to be listed as one. Really appreciate it Jie.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

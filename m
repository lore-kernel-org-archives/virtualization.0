Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40BCC07E98
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 09:41:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84105613BD
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 09:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84105613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 492EB83A0A;
	Mon,  5 Jul 2021 09:41:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kFaHe9G25BWQ; Mon,  5 Jul 2021 09:41:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 03F2F83638;
	Mon,  5 Jul 2021 09:41:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6DC9C0010;
	Mon,  5 Jul 2021 09:41:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0652DC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 09:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CC1164041C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 09:41:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OSI-zAbq_WQB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 09:41:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE657403E0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 09:41:19 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 b5-20020a17090a9905b029016fc06f6c5bso11438608pjp.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jul 2021 02:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=p6TZn0pkcrohcFlzQ6B5a1UXee/0wUIqAanNPpbpYxY=;
 b=uw1MTYYdbcLOELgs2jigWYEeV1o8X6Ol1GQ0tTEFDy1ioqGaj+151xmsO2EZ35+NQj
 UUurQPGY5Hm7h6uYIOLK+sz1XG0WK4pIlHWkSoEmm7CUGQPvp9OV73fsXBxKUOywW5TO
 kht4kSFJxdwNCkkULth6ftnfe0wX1ZPQUv61LR3poblw0FUbpSSkO02gdoYJd7kIrOuq
 ghuDu+WAnY+jS3poWdCNdSPCpSiHOTuDiEQVvKiR6+nHKoiVA1QxZ4gYcazPNmBe85Vj
 aIWcSCVO6wbp/PXGjqPidGVmlmRxtM7nFv8QmZzLmKcHxVjigiuJTisM7EKrwkV77LVj
 JLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=p6TZn0pkcrohcFlzQ6B5a1UXee/0wUIqAanNPpbpYxY=;
 b=cko7Tv6qqc+F5RBN/9LkdW1qiTZCYdIh70Fq4Nn47+1p9skCDIXCdggaJLqPrIG2Up
 aUumWev0UArn155kJmKIXdJxW2BBX21sX8qnSlKEHYT0qn9+QHsueZDWAaOT0G7u1p+G
 Gzjj3V+y+/Qj0xwzEDspkzSl+yzcaWLPBVivvqQqie/U+uro49vZ7igBCMnHkbe2cd96
 syAQFGEpukTXoYJjbtKFRfTfTuLSNKPeWl13orYR3oC08TE4xFdjbNOqjmOcB+1Qz51p
 4xdleOdGLVmfyVBLJcjrJ2dsHUeqP8yb8umk/PDU8W1cNfNq8vPt1TRpdhe27ZlOLmOU
 3F3Q==
X-Gm-Message-State: AOAM530GUfJUF/+rs3wcmOkuaSnRvDm10VZVp4IYRBopuEG/vHNzGhQ4
 IiHGfm59pUupqNgQHEhuIbyoEg==
X-Google-Smtp-Source: ABdhPJzjxeYwiQ48kETRpE7tMsMr3QlzW/XaT/X4Z+Cp/UJKBtL3paBM0nQfK91MoPQnH0Hv9Tu9WQ==
X-Received: by 2002:a17:90b:3ec7:: with SMTP id
 rm7mr14629902pjb.214.1625478079109; 
 Mon, 05 Jul 2021 02:41:19 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id a15sm12283460pff.128.2021.07.05.02.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jul 2021 02:41:18 -0700 (PDT)
Date: Mon, 5 Jul 2021 15:11:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v13] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210705094116.mxzi262n4tpmcjgm@vireshk-i7>
References: <8908f35a741e25a630d521e1012494e67d31ea64.1625466616.git.jie.deng@intel.com>
 <20210705080245.yabjlrgje5l7vndt@vireshk-i7>
 <CAHp75Vf0_8+KW_cp2g0V1miMx1cegBdjLzBjTbtpmcmdCHQJxA@mail.gmail.com>
 <20210705085610.okcvnhwhwehjiehy@vireshk-i7>
 <CAHp75VeE4Du29XJV54VWR4CH4yfCEqokRUFFRY_sdMKsp1oXyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHp75VeE4Du29XJV54VWR4CH4yfCEqokRUFFRY_sdMKsp1oXyQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Wolfram Sang <wsa@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-i2c <linux-i2c@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 shuo.a.liu@intel.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

On 05-07-21, 12:38, Andy Shevchenko wrote:
> Because we do not have "uapi" in the path in /usr/include on the real
> system where the linux-headers (or kernel-headers) package is
> installed.
> 
> It's still possible that our installation hooks will remove that
> "uapi" from the headers, but I think it makes things too complicated.

Ahh, right. Yeah, I completely missed that part.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

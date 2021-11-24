Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621A4C433F5
	for <virtualization@archiver.kernel.org>; Wed, 24 Nov 2021 02:49:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DBACF4011B;
	Wed, 24 Nov 2021 02:49:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sNynq1E4QSSM; Wed, 24 Nov 2021 02:49:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6137D400A6;
	Wed, 24 Nov 2021 02:49:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39ED3C001E;
	Wed, 24 Nov 2021 02:49:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35647C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 02:49:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2B9B3403FC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 02:49:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5YaBxLb0cVEr
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 02:49:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A9814403EB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 02:49:17 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id 71so792557pgb.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 18:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w9SdtjSRKyAYQmT41K4AZZGwYb4w19IPMcYn2fMN2dE=;
 b=ic6A7wlPP4NKkUtI3F1gI85ivlPVa2/lSDRF8Q7wubnSu6f7h04uQc/NmShkxWWq1R
 5YVX5PyQS6icvNDeSu+Q5SAFIyD1yWrEohSPRHGAM0U80r/1UVrc1M5tkOzbuMom4O54
 1FLUzZRSXGaQAUxBGkDtbRBlcgI/X1q34NCzbxL0/h1k+OT0m2DEdJxNf5uYBo+yQUWi
 tmtbKwN0VhChOm0hu6sUiBfGI5twjAA/MYoygg7APmhPoWaH/03oMqUw/a4XtP1nLkRy
 COKRo5xekU2xjc7aQKQeECLQQpxXtktld4XRoPYuhnzVfHtuR3OjCxP0rbhzS8FBgJxr
 bd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w9SdtjSRKyAYQmT41K4AZZGwYb4w19IPMcYn2fMN2dE=;
 b=8C0lF+HNCgj/vy0dGVMDEa5i8buqXJtAEpF2jPPpaHalmXq/QVmorOgAIJaJdTWi2r
 P9ha3bAVf4+bxZZjCwEuImc7oGAfi546nJF4X8fGuHZCAIguLLzesN4+zaMWqf/KIhK8
 dzvzeo668ewxP83NSvquMBIpb4mDZH7Z0qn5s0p2wVTEAxsLYhOWi8qrP1cWoHo4VX1V
 LnIBpC1fTXOprsVPPL8z1Pt+OysruoePDXrrgnF5kbxlrWKCBTGMmn0ic2+WxMY6/BUU
 ONx2q+Qos6GSF8BKoVDQb/fprUfHfS9/QY3U/bX7qJfYUnMZVTut9A3+8Sh5gFBHqir7
 pSkw==
X-Gm-Message-State: AOAM531trPMZI7ilCRPC5UPL5URj0+x0paUg/FpjbLaCbK3jSHBK0+IE
 bc2comqy6+xhkaMW/HI4Zbav9dSk68NprLm9QYAR1A==
X-Google-Smtp-Source: ABdhPJzS8LHGzaz1OBnNTW7y/EU5nRSgH9NtL2R6nqEjsoFplqiXZU89WIILPbZV7BRWoAlxpdKj2qQGIACFTFGS2MI=
X-Received: by 2002:a05:6a00:140e:b0:444:b077:51ef with SMTP id
 l14-20020a056a00140e00b00444b07751efmr2420437pfu.61.1637722157095; Tue, 23
 Nov 2021 18:49:17 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-24-hch@lst.de>
In-Reply-To: <20211109083309.584081-24-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Nov 2021 18:49:06 -0800
Message-ID: <CAPcyv4gVTAddA2cGFKgt5yJVTozxfQgstj3kicZAk2mZX+E1Og@mail.gmail.com>
Subject: Re: [PATCH 23/29] xfs: use IOMAP_DAX to check for DAX mappings
To: Christoph Hellwig <hch@lst.de>
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, Mike Snitzer <snitzer@redhat.com>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org,
 linux-xfs <linux-xfs@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
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

On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Use the explicit DAX flag instead of checking the inode flag in the
> iomap code.

It's not immediately clear to me why this is a net benefit, are you
anticipating inode-less operations? With reflink and multi-inode
operations a single iomap flag seems insufficient, no?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

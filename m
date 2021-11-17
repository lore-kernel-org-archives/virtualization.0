Return-Path: <SRS0=9pi5=QE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CF3C433EF
	for <virtualization@archiver.kernel.org>; Wed, 17 Nov 2021 17:44:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01CF861154
	for <virtualization@archiver.kernel.org>; Wed, 17 Nov 2021 17:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 01CF861154
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BADEC80F6C;
	Wed, 17 Nov 2021 17:44:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id plGgnFh3LfEO; Wed, 17 Nov 2021 17:44:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 82E2180CFB;
	Wed, 17 Nov 2021 17:44:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C461C002E;
	Wed, 17 Nov 2021 17:44:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CA6EC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 17:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 89E66401FA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 17:44:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nYM5veWtdke9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 17:44:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 70CB540121
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 17:44:00 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id k4so2797824plx.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 09:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qvHf9aM+bFVV8YG4MJi5X6jszYRFNPnvYw8P8XxAMSs=;
 b=Pv9ANnOgMM3OWe87npnRfFAHy06jY7erPMdRcRc3VaKoizlrQvir6ceQnBEYeLyHYq
 r090jiPNw0sW2/Hep475ohjoYTOQRdpvhHcth1Xy44B2FrZqXQwnGcHV2wnXbXiiNy2O
 MDFnhNTzB1g4/CDk+YjqQXYVRalwhzm8GBHuQpfxBToXDBsfgLgdgSQoTQw5N7NkHGFW
 TO5GeE55hpjrU15s7LrDdGRZzL745vjZFcejg91qo0BT5VlwUF4cAT1X4T2RsJHhvJDD
 yt9A6syUQNrss5NuJD0lDiesCY4CCjNhydNUyUTp9hI7U9JLuZ9oCU9X4sETOzbxu27f
 +aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qvHf9aM+bFVV8YG4MJi5X6jszYRFNPnvYw8P8XxAMSs=;
 b=DvOHKbENJJvbvaWnVtJZ6LYXkgTTq0Kq3oPQqRcqvaFsuf5ltB5tip8ahI6TBtdkC3
 lzGMs7A6BNPZtk19MJuR6rcX/O+FhCJl4rYd9vPjh9Vvdyl3M73ljbWpiSDYZ2Chfvio
 aR8Ppiil1Hd3AtQwEDm6kKUzWs9Og8a8JgBuFoSZhofcMfycJouSfUTfD9v6KSpd8FP+
 M2ij5ledLQ5MkvlPTgbWAqPtB2serWGwq4HnuUMcrXu46KuWdi+H0Wjn/7ZZSiGzi4GP
 glRIzBqrpfhOmmgrnDokno7hK6EAllO6bOo6VkvwdRczucFo8CevSQDKgB/yXqythoqU
 uL3A==
X-Gm-Message-State: AOAM530oLKQrxioz9kPBWiqlDoO4oCAg+58ugnzxJ9o7iqS4mqWE0tM+
 6eBPBhcETTJKPWOiXNlYk+NsDvm2SgeEqinXxbQ+xg==
X-Google-Smtp-Source: ABdhPJzkkUh8z9sNK4035DW8QI/H+P4iSKXjlSdI0PBBNtw2VKYOtUcKXKOrARUi3RsvsZHwUrgnG1t18LSvWsJCfmc=
X-Received: by 2002:a17:902:6acb:b0:142:76c3:d35f with SMTP id
 i11-20020a1709026acb00b0014276c3d35fmr57313687plt.89.1637171039968; Wed, 17
 Nov 2021 09:43:59 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-4-hch@lst.de>
In-Reply-To: <20211109083309.584081-4-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 17 Nov 2021 09:43:46 -0800
Message-ID: <CAPcyv4hzWBZfex=C2_+nNLFKODw8+E9NSgK50COqE748cfEKTg@mail.gmail.com>
Subject: Re: [PATCH 03/29] dax: remove CONFIG_DAX_DRIVER
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

On Tue, Nov 9, 2021 at 12:33 AM Christoph Hellwig <hch@lst.de> wrote:
>
> CONFIG_DAX_DRIVER only selects CONFIG_DAX now, so remove it.

Applied.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867E6C433EF
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 04:17:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3627460623;
	Tue, 23 Nov 2021 04:17:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qZ8GZYpmzAxq; Tue, 23 Nov 2021 04:17:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D143360610;
	Tue, 23 Nov 2021 04:17:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5EDEC002E;
	Tue, 23 Nov 2021 04:17:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD6E0C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 04:17:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9C1F480DE9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 04:17:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KPXiy6ky_uzU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 04:17:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 27EFE80DD7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 04:17:26 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id r130so18130610pfc.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 20:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZQsMyZujMjnowhAwZ2baLD9uO7OCrRs7T2rtVARAjVk=;
 b=r5BttbD0H9Ys+86N0W8OZt6YhGoGDH1OlqQzbeJL1DHVrD2yQYBFcAQpDJZdPp96ld
 u7ZRxawo8C15Rm8P9h/VH5gu3oohxCYJiT1x83EZ7S5DS8ZwExgaHogTmXUfy49vrooy
 uY9QBu9K0yN5b+5oZTDqMIVuo71/tE10X4peb5+q5eiDHecfanupjPCqOSworjGI5IQ5
 Aj7bWFf9mIURtRUlNDfH2tKdJ15j6ud19enU8mc5XfzSZ1qi5lkH5u7vzXmkUNvPZ8ua
 waA1d5UF/uDBNAN49ee3fRWBvihtr0fagsdWiD2SnKCZhsMGyCRgbV3y2BeBkd6hwREP
 GcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZQsMyZujMjnowhAwZ2baLD9uO7OCrRs7T2rtVARAjVk=;
 b=S58jCwiuczkVbPk+micJeLlYRvHWXoHXV0WtDQIRDV2gSA2spCLoZjSoArfLBjOqYN
 rdi31aO1PoeuhJgh+/TaxJO1h1JvwojJPP+nbf5mbneCZN3mhbIhGuDtqyrN2NEeuqiy
 Nc/+uW+dL7K/51nRlW5rV/VhDFJWDu8Y8QaqjUmE6hPfVT9Gk/sdEaTk1U+elsY1WBRZ
 TcgvwG9e+GYOgT5F7qMkiXdTDzx7sZcwdzqaOg/nAtbpUFoZs6Z2ujhYK/EDWni6byWV
 EawzQS9c9vBDJK1Xu4digy0KOtnF7DjQe/5kl7EQutJOvaCU66j+zeBY5jNuZKvJBAfE
 GGdg==
X-Gm-Message-State: AOAM531p+53QoLxVCBssZ1IurhMb30GG5SdcKscE6t5uAJgWyqwv4cz3
 SONu/LCiEOYlMEQG4WDnihxWkjPvAWIJOYLJRUAKog==
X-Google-Smtp-Source: ABdhPJyduKiEJGam42hMgnTTV6OAgsDuX6QGWziIbZi1yEyOpgOf+OAOhzM4qFm0U34fEtUNE/R0JNCPUbjj9GmSWQ0=
X-Received: by 2002:a63:85c6:: with SMTP id u189mr1612542pgd.377.1637641045591; 
 Mon, 22 Nov 2021 20:17:25 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-13-hch@lst.de>
In-Reply-To: <20211109083309.584081-13-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 22 Nov 2021 20:17:14 -0800
Message-ID: <CAPcyv4g_ZeZCZwfSvoAXL_xnnM2dTSCgN8atodfr8vfJTbYOXA@mail.gmail.com>
Subject: Re: [PATCH 12/29] fsdax: remove a pointless __force cast in
 copy_cow_page_dax
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
> Despite its name copy_user_page expected kernel addresses, which is what
> we already have.

Yup,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

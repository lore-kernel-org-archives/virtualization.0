Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA875C433F5
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 02:54:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71A524045D;
	Tue, 23 Nov 2021 02:54:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pJThLIM3ufZ2; Tue, 23 Nov 2021 02:54:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1FA9B40285;
	Tue, 23 Nov 2021 02:54:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF438C002E;
	Tue, 23 Nov 2021 02:54:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F0FFC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 02:54:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F6584010B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 02:54:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aFGL_YLGTxux
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 02:54:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9E9B840103
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 02:54:53 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id o14so15790321plg.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 18:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hzu6WTfZUrCey1J7m6mzu3SyuG3mlb0cV5bc4AfptPs=;
 b=beaUT1FtsNFsra95ne0owHh0REAyyuUzujf6WfZCqbHVqWDCseUjZNBp1imtZrvl25
 Tle8IyUp3iiK6T7rSedrQcl9c/h0UQVa4ff4523mpAef4KYGb1TbGvy3lfGAL4G4Ooqr
 TH0f0Xw5heidYTCEKZrSbgx6eXucck48D1PdG9bQqnHF3xFKgaR12HFK4qLWfYdcBAaW
 hyr06oXivq4GX87hiZVUip/cxW8DPPmY1DWSzEzAGLteKQgqOmlnE0Fzbh+eO2i8dmuO
 d0czzqQ7InLmIRWHjnUfTxiVsP9Xg6prNyjUDIVMDnnmk947ZrGB8bNv0YUysQL48hVn
 bE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hzu6WTfZUrCey1J7m6mzu3SyuG3mlb0cV5bc4AfptPs=;
 b=3O+fWxwLOixG7TaISrObkLHI0p2L0bKnpKPB8jOZn9aIRv0RipzCViL+0wPqwIUeOH
 Q7ylxcPuehdeZiGzQumPzs9XhV3MyKUwWVuMVc8TNUfAvyFnp7bSvjkJKYdiw//Gy6eh
 Lb3W3N20Pflc2pGcy2/ybd/mgTpFiSc6XPmj3jEh2YTH/kJ3RXxFp6Mwix5yHmcpj6bc
 vkPO1rWVvhCGF9fHzcx5JNXLi+yC8nnlElP03iSAO2eS+TlDYb8brJIX097nEvmDFgCX
 ZeYWjOsVNsrR4Zg4AW5laLR8QLS7CM48LsHlAW7xR5raDJAgyo0Hc5RHH30etspeGKhd
 JtaQ==
X-Gm-Message-State: AOAM532LQgC5P0RZ46u/fS6Fl4ql2Og97avCXbjfHFb5+lxIJFDWvfR3
 zoPffK+0+OmTiWg/wq8WR7bdEKEhy4k5dXdffGxAwA==
X-Google-Smtp-Source: ABdhPJxeiX5ifpjvIOpWVxQMDUuHcOe3OIdJeR8Imw/gLHmEQwl4x/JiO/uU+o3bH9o5PQYkURGBJLUFMItHEKRZD78=
X-Received: by 2002:a17:902:a50f:b0:143:7dec:567 with SMTP id
 s15-20020a170902a50f00b001437dec0567mr2776615plq.18.1637636093077; Mon, 22
 Nov 2021 18:54:53 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-4-hch@lst.de>
 <CAPcyv4hzWBZfex=C2_+nNLFKODw8+E9NSgK50COqE748cfEKTg@mail.gmail.com>
In-Reply-To: <CAPcyv4hzWBZfex=C2_+nNLFKODw8+E9NSgK50COqE748cfEKTg@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 22 Nov 2021 18:54:42 -0800
Message-ID: <CAPcyv4g=KgKZR6JF8_=mTs7Ndgq7DSU+5_sTJ7gQuwUgC5dRYg@mail.gmail.com>
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

On Wed, Nov 17, 2021 at 9:43 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Tue, Nov 9, 2021 at 12:33 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > CONFIG_DAX_DRIVER only selects CONFIG_DAX now, so remove it.
>
> Applied.

Unapplied,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

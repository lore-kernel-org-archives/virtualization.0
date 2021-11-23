Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF58C433F5
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 21:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA3EE4056E;
	Tue, 23 Nov 2021 21:17:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tKOEjeIFBiJz; Tue, 23 Nov 2021 21:17:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 764CB40273;
	Tue, 23 Nov 2021 21:17:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 495A1C002E;
	Tue, 23 Nov 2021 21:17:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FE0AC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 21:17:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F2935817A8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 21:17:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JeBUUNrHegd6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 21:17:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 792BC80D3B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 21:17:09 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id p17so235289pgj.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 13:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PQeh1LIqbqFtSovgn5WZ7VLYBwfefd3KuHYAxcJ6bdE=;
 b=z/Kv5aF3II2Q1LX6Aazu4oeYGV1DsHDm6VPftSCm/GsXUqcvpUYlHGhNQfvcAEzM+t
 KHEErzvzy9AE7efI2veDZidjjq+fK6s2UJs7fEhnYmQiPFx9rvXEwel822roodlc/FcK
 DEv5SfZdo4Mf/qMs7Jb75ZFTHTDu0awILjq9sqTvXs+VIsFn7y/1XB/C+/lY4NwLFtHP
 cHAfa2a7eS26AcezybSCXTWBbxiGPri9iUr8Wx/IV+DiOD4YHSNiMvTZGqn4/3tFE8gU
 fEqZVpI1Dt83hXy63DNbfv4vosQWDr6RKn8ZmI1PKEqbMIgBEyzoH/HXIZQqJ3XqzuZq
 V9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PQeh1LIqbqFtSovgn5WZ7VLYBwfefd3KuHYAxcJ6bdE=;
 b=xfXXgIW1VZ6FB3kTFsTqL3Dws+mU2aj3DDygJ9tPJDdd6EsBH0Lgqz77BKitgsVu0W
 MlYGwSI6HHSKtaU9DwLY2ExRr4M8TydoRVYXalGKCx9id6BsZN2Zwa6XB3pCJpDhbpwZ
 mCczr87aYjNEeNy3t1HwY14hH8MH8e5Y4aVvaHmrfQBjaSBLchj+StJJRBikjusYaDJt
 +Jq6avLdZtA6Sh9QqkVBeBRgTs0ULTfo9IDPNXRt8ghE+3T67Y8ZwuBuHBdCaZ8wOgSR
 fVqT0NECzWmUaEpzk52+z7BUjudt+URO/g5AU+p92v4QlWrCgAqcC5M/arfpU4G5uRRK
 NPaw==
X-Gm-Message-State: AOAM530gHfRnE9kTdoGipPWGGnoOcT1hJgqCucYV9LO181c/iA1YqL2q
 0Zk4EOiX/3S8bElIkJ99NIrHvibafBhC00lAOGBqQA==
X-Google-Smtp-Source: ABdhPJxo6xmNJWXyaaVPBEUy4anrM6xGk5zJ5S54bOFTPTbJYWg88+GG8ODe3guk693xmG8x/Zkzy+Ul3gB1uuDCJIA=
X-Received: by 2002:a63:5401:: with SMTP id i1mr6112849pgb.356.1637702228750; 
 Tue, 23 Nov 2021 13:17:08 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-17-hch@lst.de>
In-Reply-To: <20211109083309.584081-17-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Nov 2021 13:16:58 -0800
Message-ID: <CAPcyv4jjvoT=aW+_Ks+8L60HG0ypesSi8A+a5F2JXu1dEWHVCw@mail.gmail.com>
Subject: Re: [PATCH 16/29] fsdax: simplify the offset check in dax_iomap_zero
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
> The file relative offset must have the same alignment as the storage
> offset, so use that and get rid of the call to iomap_sector.

Agree.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

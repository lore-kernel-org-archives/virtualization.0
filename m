Return-Path: <SRS0=fv7C=OC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14458C433EF
	for <virtualization@archiver.kernel.org>; Sun, 12 Sep 2021 00:11:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5955611C0
	for <virtualization@archiver.kernel.org>; Sun, 12 Sep 2021 00:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B5955611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6837C4042F;
	Sun, 12 Sep 2021 00:11:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JVUxzWd871e6; Sun, 12 Sep 2021 00:11:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B1F67400DB;
	Sun, 12 Sep 2021 00:11:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F929C000F;
	Sun, 12 Sep 2021 00:11:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5538BC000D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 00:11:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 30584415EF
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 00:11:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7aBEW2opIjWt
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 00:11:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8DC75415EC
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 00:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631405467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3+SDhPhtAI0lMP2x6bWgWzq+CLAgxnBUNxlCJNh5kE4=;
 b=L2deUqhhQJG0CXS6J1KCqX3RXpEyyAAtLjJx45pNGLrgxdI5OdecjGeW4qrfA9dMxpCrnW
 Yk+mcLp0hOgEN5rRGdMnSqMcoI+n/JfteqAL6whLPafvehQokmgFzOI7ADsMlGlrukULLM
 4Hv35wk6X34WzD8kz3fynS4nfLFB2zw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-5wbNx83iOOupC6iXs--u0w-1; Sat, 11 Sep 2021 20:11:06 -0400
X-MC-Unique: 5wbNx83iOOupC6iXs--u0w-1
Received: by mail-wm1-f71.google.com with SMTP id
 x125-20020a1c3183000000b002e73f079eefso2312624wmx.0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Sep 2021 17:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3+SDhPhtAI0lMP2x6bWgWzq+CLAgxnBUNxlCJNh5kE4=;
 b=ToThR+MnrGAnKEJoVX4ffHsayb0TuIFMz/RWkHidgq6gA+vAFJm0N3YQj0n9tYLZUg
 RdNX1asbtJ/+gaFk2cuRlCmqYRcx2WSlH6eW4s1xgFOj1XwZwV8jpDRy9mXb1yW1PTtR
 C4+bTokCwgJdBRRYaXrEMmTKr/Fzkvd572yNmsFGVQ5DY2W2mP0LCaXgEKgBq4FzYGmM
 yWJAThyJ962HK1QS7tAieVdq1cqz9VdfdVKbjqQmFWFmrGWqZn/M6+30OU9bSgEa6/XC
 abDj3CjrWZl+ra8zHUB+wp/BRis6Jy3CPemINb8ClRD+6aSjvCmCi5I1/YUZeRLCiN2+
 ntGw==
X-Gm-Message-State: AOAM531p/VK2jaTmI0vaf7isqtOqTKOfOOlySGFOJvlrlbINGK5j8wni
 V6nOnRoHwY34n3INb5KexVgo0jsFG0fwSgQPyj4vqr0eiHjJxdiWWZkQrJXNDyGAH51acGGFupA
 NVDphzTMFP0S0r8LVvd6Ifa9ER21Jrj2D8wDDLc70wg==
X-Received: by 2002:a5d:5262:: with SMTP id l2mr5073431wrc.190.1631405465074; 
 Sat, 11 Sep 2021 17:11:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2+nnpLXmYFqlcNrQEQIkvzkPNcBX1WRDEr9J/3GszOIhA0ueiLnvdBJ8sEzBojCIcdylSgw==
X-Received: by 2002:a5d:5262:: with SMTP id l2mr5073418wrc.190.1631405464938; 
 Sat, 11 Sep 2021 17:11:04 -0700 (PDT)
Received: from redhat.com ([2.55.27.174])
 by smtp.gmail.com with ESMTPSA id o13sm214409wri.53.2021.09.11.17.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Sep 2021 17:11:04 -0700 (PDT)
Date: Sat, 11 Sep 2021 20:11:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] virtio,vdpa,vhost: features, fixes
Message-ID: <20210911200508-mutt-send-email-mst@kernel.org>
References: <20210909095608-mutt-send-email-mst@kernel.org>
 <CAHk-=wgcXzshPVvVgGDqa9Y9Sde6RsUvj9jvx0htBqPuaTGX4Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgcXzshPVvVgGDqa9Y9Sde6RsUvj9jvx0htBqPuaTGX4Q@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: mgurtovoy@nvidia.com, lingshan.zhu@intel.com,
 KVM list <kvm@vger.kernel.org>, xianting.tian@linux.alibaba.com,
 Netdev <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Wolfram Sang <wsa@kernel.org>,
 xieyongji@bytedance.com, Viresh Kumar <viresh.kumar@linaro.org>,
 arseny.krasnov@kaspersky.com, Will Deacon <will@kernel.org>, elic@nvidia.com
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

On Sat, Sep 11, 2021 at 02:56:12PM -0700, Linus Torvalds wrote:
> So you are hereby put on notice: next time I get this kind of
> half-arsed garbage pull request, I won't spend the energy on trying to
> figure out what is actually going on. I will just throw it in the
> trash.
> 
> Because honestly, that's where this pull request belonged.
> 
>               Linus

OK so I was worrying about these patches anyway, and that
is why I put them on top. So I just sent GIT PULL V2 which
includes all the same commits except for the last 13 patches,
so they all have been in linux-next.

It's in the tag for_linus_v2 - the point of keeping for_linus
intact was so anyone can compare these two.

Hope that clarifies rather than confuses things even more.

Mea culpa, etc.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

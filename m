Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925D7C4332F
	for <virtualization@archiver.kernel.org>; Wed, 24 Nov 2021 03:48:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2040C40003;
	Wed, 24 Nov 2021 03:48:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iIERmLrPmdWX; Wed, 24 Nov 2021 03:48:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 765F1400A6;
	Wed, 24 Nov 2021 03:48:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A8C5C002E;
	Wed, 24 Nov 2021 03:48:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6D93C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 03:48:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BCF93401BA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 03:48:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wjafg0GICuN4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 03:48:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A8E04013D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 03:48:03 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 y14-20020a17090a2b4e00b001a5824f4918so3879405pjc.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 19:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BQpMJpPq/OIJ1A+jReESOD3pvkOjXmQh8KJADyXTrz8=;
 b=jKMXPC6R380cNIQ/lk6QhOIiLqsp4XKj1eRLbWdIfXDMXjf2sFtM/A4DNKzZle92lO
 3U1GnSeEGBEEzHeeSOTcj6e6Hlhrl2Cgom3C+oy6m84LroLIm83mhibtNhOC9a7kpuLa
 ouXLOQwDClItscEUt0Jtcfsiacpxarhj3trqquFBkBV1VRiZIUVoCcdmCugOwJ+8mJs6
 RFqDPmjgXZyOm3EQaprR9sZoOXJ0YQXXHWkXXD+DsFaSM6qnnUL3vYnF49/xzscWLZfD
 M7pqOQ9uH/J1/XHGYxb48lxo0PQegLqWhqBsHyRYBVi7oUWjdYWmqFepS80LAFQdqtcA
 s5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BQpMJpPq/OIJ1A+jReESOD3pvkOjXmQh8KJADyXTrz8=;
 b=BnEh00oBfapIv5AQ6v4FDd/jaCPfPf/O6P5HPwaXakkmLu25+eSLsA7YsGlIWtQkos
 PFYWn7KxUHDbqoKfRcR0iee/OrJDJKjSshIgUsXRKHa2rMfIwXr6dLGZRIGA0BebcQ/x
 SBX9BREZPw1ko2K28xDUtlktyJIwQNqSeVjyHrXFcT0zxi7YYQuWNKWX1V0C++u++bbc
 Ec2K6VL554RF/m33srtVaustG37q56/ckoJnlZfOT28TtoXMeSyN4cA3TRi9w5lksUX0
 BTuhWTq+HNIyEc/qAOV6B8eWzq5NorAx0R7TEbHYhPFTb+OIwddt3cm2zcaZDKyjqdTS
 OuHg==
X-Gm-Message-State: AOAM532TYrzSW6t2AOak3uDUv3C0U0OuEM4FcEiNqH8VFFQYo9q4G2DU
 JXPqRpogrc5SdAzzlPHMOuX414KIT+PACmCNG98y4Q==
X-Google-Smtp-Source: ABdhPJwXdBqxRTwwq0bi38HdemI3/UrUSQvkef2geUCQrgUs13GwLl6CkzHERiNWivJH+HCOX6YcKKMcXBwB2wDg59I=
X-Received: by 2002:a17:902:6acb:b0:142:76c3:d35f with SMTP id
 i11-20020a1709026acb00b0014276c3d35fmr13991510plt.89.1637725682824; Tue, 23
 Nov 2021 19:48:02 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-28-hch@lst.de>
In-Reply-To: <20211109083309.584081-28-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Nov 2021 19:47:52 -0800
Message-ID: <CAPcyv4jrUAJ28J6Q75jmfQRz2nj4a3v6bZVjFpROd98efuafsQ@mail.gmail.com>
Subject: Re: [PATCH 27/29] dax: fix up some of the block device related ifdefs
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
> The DAX device <-> block device association is only enabled if
> CONFIG_BLOCK is enabled.  Update dax.h to account for that and use
> the right conditions for the fs_put_dax stub as well.

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

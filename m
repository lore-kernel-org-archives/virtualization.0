Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A92EC04FE2
	for <virtualization@archiver.kernel.org>; Thu, 27 Jul 2023 22:59:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8162060EC2;
	Thu, 27 Jul 2023 22:59:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8162060EC2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fromorbit-com.20221208.gappssmtp.com header.i=@fromorbit-com.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=X7pt5Ouy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PBGkgTT-7xb5; Thu, 27 Jul 2023 22:59:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1F7EF60EE9;
	Thu, 27 Jul 2023 22:59:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F7EF60EE9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAAF9C0072;
	Thu, 27 Jul 2023 22:59:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB08FC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 22:59:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C37C241F9B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 22:59:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C37C241F9B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=fromorbit-com.20221208.gappssmtp.com
 header.i=@fromorbit-com.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=X7pt5Ouy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tV2bvflq7JTL
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 22:59:41 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9FEE541F85
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 22:59:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9FEE541F85
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-686ba29ccb1so940096b3a.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 15:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1690498781; x=1691103581;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8CTrna5t3S7P99W+zrM1I2ApZYIkXTVQedDFVAI6oIw=;
 b=X7pt5OuyEbf8f6R9fnvI9dxfnaaqjP1RGRY8ZMiJ1wEZkopGyRUZXV3N7HE87n67xj
 XeLWxsKHlNX6ErnVJUF/xO5BY5VT61hhmCqWCbxit+6W6UUMx7WmvB86s0q+wgGSoL6W
 koucWxrpBOYNBJME5+HxRa/lXlSreJXWQaoDeJrNnWxYMUw7bNkMz2551ucFVRtsjQZW
 0ldvdZqoq1ohkP2t1Jbzv+uf1kwplqapkGN1TtrTmsgZICGsR0gfv1ElN5pvcVjNfGjj
 OPatiCTf9mYCZ8F6QAcUCONXn7kELLjAWaYShbgFOaFFniHTDeIvjRJJRIf4kK+rSYkZ
 RVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690498781; x=1691103581;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8CTrna5t3S7P99W+zrM1I2ApZYIkXTVQedDFVAI6oIw=;
 b=A6k9zJDBseC6cz2BMs4jyfcnZOgilsJ6aJtj5uwPIywZGdGmjOzBKiXN/eAOkfkIdH
 GakDorOoeB2ABzgFy7Wry6hzFJKKRp0njCGknDxDGtwWmx9yTz+V1wrdABaZRYjGHmAd
 PGCMKofHmOu+KW/gEIUeNikZaRYUXdn2n/2qbW5wAK0X7RxatIrUlCAoRPo8XLiTGTCa
 6XdudgSHXPGpi1HAWbncixUvc2+VXB/c31z6OI8E6G0XhDUQ4WZoG5G5kpSa17AyV0DB
 yZxlrPn+mFe3C2lFjzNgFgsEvtsgbL6uiSt/t+eHdTRa/u+PTOb6uYTE7I80a0ZrBD8X
 ml4Q==
X-Gm-Message-State: ABy/qLYC0qR5pGdfD5wlGy+FpEWjfnISad/+alzUnVCluq5W7gcWJZ9x
 JRMCAGFopGiOIxOlrmKe+yHjxg==
X-Google-Smtp-Source: APBJJlGFE8oAcAZu2XvzWjC5bjR81v7OIjjTfZ8m+EaEe6Rjpq3cuwvHN3I08mErFwOZJpneP9Ly1g==
X-Received: by 2002:a05:6a00:17a8:b0:64d:42b9:6895 with SMTP id
 s40-20020a056a0017a800b0064d42b96895mr61072pfg.5.1690498780930; 
 Thu, 27 Jul 2023 15:59:40 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-119-116.pa.vic.optusnet.com.au.
 [49.186.119.116]) by smtp.gmail.com with ESMTPSA id
 p24-20020aa78618000000b0068702b66ab1sm1115813pfn.174.2023.07.27.15.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 15:59:40 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
 (envelope-from <david@fromorbit.com>) id 1qP9xJ-00BKKZ-1O;
 Fri, 28 Jul 2023 08:59:37 +1000
Date: Fri, 28 Jul 2023 08:59:37 +1000
To: Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 28/49] dm zoned: dynamically allocate the
 dm-zoned-meta shrinker
Message-ID: <ZML22YJi5vPBDEDj@dread.disaster.area>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
 <20230727080502.77895-29-zhengqi.arch@bytedance.com>
 <baaf7de4-9a0e-b953-2b6a-46e60c415614@kernel.org>
 <56ee1d92-28ee-81cb-9c41-6ca7ea6556b0@bytedance.com>
 <ba0868b2-9f90-3d81-1c91-8810057fb3ce@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ba0868b2-9f90-3d81-1c91-8810057fb3ce@kernel.org>
Cc: kvm@vger.kernel.org, djwong@kernel.org, roman.gushchin@linux.dev,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 dm-devel@redhat.com, linux-mtd@lists.infradead.org, cel@kernel.org,
 x86@kernel.org, steven.price@arm.com, cluster-devel@redhat.com,
 xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, paulmck@kernel.org,
 linux-arm-msm@vger.kernel.org, brauner@kernel.org, rcu@vger.kernel.org,
 linux-bcache@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Muchun Song <songmuchun@bytedance.com>, yujie.liu@intel.com, vbabka@suse.cz,
 linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org, tytso@mit.edu,
 netdev@vger.kernel.org, muchun.song@linux.dev, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 senozhatsky@chromium.org, gregkh@linuxfoundation.org,
 linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, tkhai@ya.ru
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
From: Dave Chinner via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Jul 27, 2023 at 07:20:46PM +0900, Damien Le Moal wrote:
> On 7/27/23 17:55, Qi Zheng wrote:
> >>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 goto err;
> >>> =A0=A0=A0=A0=A0 }
> >>> =A0 +=A0=A0=A0 zmd->mblk_shrinker->count_objects =3D dmz_mblock_shrin=
ker_count;
> >>> +=A0=A0=A0 zmd->mblk_shrinker->scan_objects =3D dmz_mblock_shrinker_s=
can;
> >>> +=A0=A0=A0 zmd->mblk_shrinker->seeks =3D DEFAULT_SEEKS;
> >>> +=A0=A0=A0 zmd->mblk_shrinker->private_data =3D zmd;
> >>> +
> >>> +=A0=A0=A0 shrinker_register(zmd->mblk_shrinker);
> >>
> >> I fail to see how this new shrinker API is better... Why isn't there a
> >> shrinker_alloc_and_register() function ? That would avoid adding all t=
his code
> >> all over the place as the new API call would be very similar to the cu=
rrent
> >> shrinker_register() call with static allocation.
> > =

> > In some registration scenarios, memory needs to be allocated in advance.
> > So we continue to use the previous prealloc/register_prepared()
> > algorithm. The shrinker_alloc_and_register() is just a helper function
> > that combines the two, and this increases the number of APIs that
> > shrinker exposes to the outside, so I choose not to add this helper.
> =

> And that results in more code in many places instead of less code + a sim=
ple
> inline helper in the shrinker header file...

It's not just a "simple helper" - it's a function that has to take 6
or 7 parameters with a return value that must be checked and
handled.

This was done in the first versions of the patch set - the amount of
code in each caller does not go down and, IMO, was much harder to
read and determine "this is obviously correct" that what we have
now.

> So not adding that super simple
> helper is not exactly the best choice in my opinion.

Each to their own - I much prefer the existing style/API over having
to go look up a helper function every time I want to check some
random shrinker has been set up correctly....

-Dave.
-- =

Dave Chinner
david@fromorbit.com
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

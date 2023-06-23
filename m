Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1678CC001B0
	for <virtualization@archiver.kernel.org>; Fri, 23 Jun 2023 22:19:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7AD6541E6A;
	Fri, 23 Jun 2023 22:19:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7AD6541E6A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fromorbit-com.20221208.gappssmtp.com header.i=@fromorbit-com.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=lhK6GKfD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S-iWoo9DC57l; Fri, 23 Jun 2023 22:19:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AC7E341DD8;
	Fri, 23 Jun 2023 22:19:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC7E341DD8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 861F2C0037;
	Fri, 23 Jun 2023 22:19:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62548C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jun 2023 22:19:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2980881EE1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jun 2023 22:19:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2980881EE1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=fromorbit-com.20221208.gappssmtp.com
 header.i=@fromorbit-com.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=lhK6GKfD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BsTnvSxBM69n
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jun 2023 22:19:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 633FF81EDB
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 633FF81EDB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jun 2023 22:19:20 +0000 (UTC)
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-668709767b1so779071b3a.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jun 2023 15:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687558760; x=1690150760;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mD+HWl2aEG73j6Ak2J3eZjmDfUV1ZAzR4FiFGaQDP6g=;
 b=lhK6GKfDyI3S2QEkidlKI9Ek7fIdf8s37/5sqH0oYikZjcY7jput4UDyCpFr2NTdT8
 zVyRwANCpkSqZtLXi737KASfNRL8jzfb+T40RkB84q+J2KMVe792KQuGyG75zUe1uU9/
 y8KvlnU3EwX/2kXOOlbwtshnDERQlNsq270xMVedNytpu7Z+d6cUbBidgJ6X6DjHIzPN
 7j8fd31lnOvF/aMkMY7bUu4o0IY8LUCtjYfDI1XbfU7cyMWriXOuApAvFBa9TAUUYDHZ
 fQEMipnVJ6GJpcYxmPtjY5bvv9Ob+7MwsmiucWVnjVO5xA+M617znVGuQZS0X5eWOQ0u
 zyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687558760; x=1690150760;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mD+HWl2aEG73j6Ak2J3eZjmDfUV1ZAzR4FiFGaQDP6g=;
 b=cyHmaTmVBJIvg9rxqdXWSA+dxEyQzZJalwGuYBiLdGqrT1lNinuQWIAccLqhUSJdyl
 VLV5dqbDxBOxQ3pt1b1NYIf6QtNmiT3LlG0V6zWDkeuFUkOoPho1/jK5xJdRJdKjfI7Q
 GI6U1vYay8Enkb4TDOlVOjl7WJpdVq+5tgCll0klGRPCFz01J/cWLS+rOaeJ8yG0Pqq+
 zhdMCzWEKx9/vxVhgVy2Fg4ggCmWk+YbeCzY2eGTaF/KQJjy5fZF2xnDNUrFb4AU1rnU
 pPS39dLnpxRjKruQtgRADZ78+5b2Q/ek7suuu5mWLB/l34d9mMSw/NB3DGjxID4Y27TB
 VBQg==
X-Gm-Message-State: AC+VfDwzYLg9hCF0PuK3b0CCui9ZFg6ZKC+e6HGNWrmu1MfPIluteFFo
 SdP+oXy65dJNOON/q/P5/dgd7A==
X-Google-Smtp-Source: ACHHUZ6Wu9ky21UYgtgHUmTHayjznwHVfcTzLH8QgkKVoWewOSRi12/4tLQSsphqEkidSt1h32qo3g==
X-Received: by 2002:a05:6a20:4410:b0:121:7454:be2a with SMTP id
 ce16-20020a056a20441000b001217454be2amr17133223pzb.45.1687558759759; 
 Fri, 23 Jun 2023 15:19:19 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-94-37.pa.vic.optusnet.com.au.
 [49.186.94.37]) by smtp.gmail.com with ESMTPSA id
 b17-20020a170902b61100b001ab0672fc1fsm58552pls.105.2023.06.23.15.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 15:19:19 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
 (envelope-from <david@fromorbit.com>) id 1qCp7a-00FP7U-2k;
 Sat, 24 Jun 2023 08:19:14 +1000
Date: Sat, 24 Jun 2023 08:19:14 +1000
To: Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH 24/29] mm: vmscan: make global slab shrink lockless
Message-ID: <ZJYaYv4pACmCaBoT@dread.disaster.area>
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
 <20230622085335.77010-25-zhengqi.arch@bytedance.com>
 <cf0d9b12-6491-bf23-b464-9d01e5781203@suse.cz>
 <ZJU708VIyJ/3StAX@dread.disaster.area>
 <a21047bb-3b87-a50a-94a7-f3fa4847bc08@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a21047bb-3b87-a50a-94a7-f3fa4847bc08@bytedance.com>
Cc: djwong@kernel.org, roman.gushchin@linux.dev,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, dm-devel@redhat.com, linux-ext4@vger.kernel.org,
 paulmck@kernel.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-nfs@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
 Vlastimil Babka <vbabka@suse.cz>, brauner@kernel.org, tytso@mit.edu,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
 linux-btrfs@vger.kernel.org, tkhai@ya.ru
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Jun 23, 2023 at 09:10:57PM +0800, Qi Zheng wrote:
> On 2023/6/23 14:29, Dave Chinner wrote:
> > On Thu, Jun 22, 2023 at 05:12:02PM +0200, Vlastimil Babka wrote:
> > > On 6/22/23 10:53, Qi Zheng wrote:
> > Yes, I suggested the IDR route because radix tree lookups under RCU
> > with reference counted objects are a known safe pattern that we can
> > easily confirm is correct or not.  Hence I suggested the unification
> > + IDR route because it makes the life of reviewers so, so much
> > easier...
> 
> In fact, I originally planned to try the unification + IDR method you
> suggested at the beginning. But in the case of CONFIG_MEMCG disabled,
> the struct mem_cgroup is not even defined, and root_mem_cgroup and
> shrinker_info will not be allocated.  This required more code changes, so
> I ended up keeping the shrinker_list and implementing the above pattern.

Yes. Go back and read what I originally said needed to be done
first. In the case of CONFIG_MEMCG=n, a dummy root memcg still needs
to exist that holds all of the global shrinkers. Then shrink_slab()
is only ever passed a memcg that should be iterated.

Yes, it needs changes external to the shrinker code itself to be
made to work. And even if memcg's are not enabled, we can still use
the memcg structures to ensure a common abstraction is used for the
shrinker tracking infrastructure....

> If the above pattern is not safe, I will go back to the unification +
> IDR method.

And that is exactly how we got into this mess in the first place....

-Dave
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

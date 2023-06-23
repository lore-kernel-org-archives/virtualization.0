Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61708C001DF
	for <virtualization@archiver.kernel.org>; Fri, 23 Jun 2023 06:29:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E54BB81F10;
	Fri, 23 Jun 2023 06:29:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E54BB81F10
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fromorbit-com.20221208.gappssmtp.com header.i=@fromorbit-com.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=VCN1cKAz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F5q0ebZ3yayF; Fri, 23 Jun 2023 06:29:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8893681501;
	Fri, 23 Jun 2023 06:29:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8893681501
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A469C007A;
	Fri, 23 Jun 2023 06:29:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E3E1C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jun 2023 06:29:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E507541F8A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jun 2023 06:29:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E507541F8A
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=fromorbit-com.20221208.gappssmtp.com
 header.i=@fromorbit-com.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=VCN1cKAz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qQzEiUs7p6_L
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jun 2023 06:29:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E84DF41F81
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E84DF41F81
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jun 2023 06:29:43 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1b50e309602so2203975ad.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 23:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687501783; x=1690093783;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zCEqJX5mm9cbUE56OVCDucRVQniQh/jh7QjO1tCYRyw=;
 b=VCN1cKAzYZWGpOm/hUHuPZp8plVnErZlG9G0OlFzhPpXaNGHYvVufkX79JUDsPqJVj
 SxdYAM9A9ivCYhtFxc3SyvMZr6s5SlnDngyF1CSlxpEdm/HUuOSGwHgmJomuuYgedrRX
 aqax0M2Dw9QUTGwitN8bpL0qLseKhs7EVUc6lepS488qyivLAQHSFGtevNE0LyqUhWPi
 NKkNR95/QZWn2OoaLsjXJllgmMFsp0mHDlbo5o60jR1YeUkdYXlMSdAiD7/jZsXdB48G
 reDdzoxXO5mM4WdQ8i9rMsSwtC5huiBFlnlMXvIXzYTlsiTrC5P7Z8F16npWgNIfnf8B
 ShDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687501783; x=1690093783;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zCEqJX5mm9cbUE56OVCDucRVQniQh/jh7QjO1tCYRyw=;
 b=STy4+rqSVllTNGgFixITkAe02j8AdX4k4jcxiAAA6wcA88Pg3M+IKC3QXJ11i5yizZ
 3zXq8Gn6JQxaUE7xoTvjSD6aJiPM3Zg10AI5+L7K8SJG64jgi6+7RHI+BtzMHBGYg6s5
 gMHToRSvcVRMHWZMghfuxKFBqZE9UK8cuBZBAp4PBCMNbRIgV1juJImt9IkR1ePdzhmZ
 W2v9VAyJpgUaDo7wy/9+ESqHLPPER3iYtsCCB0ULU/7bLqATtDsIQ0GLnLM2xAj+Q0dL
 WCxXzgcEX0XOioDYNOJPqLFHzW/AwlyY1ciWs/LQDfj5xOrNekq1wc6UYjxFzfrkyl4J
 BSJg==
X-Gm-Message-State: AC+VfDxbplnn//S8lNjw2v8QN22hVgQ+IrnT5++ZLMaoHIfRoU/zoawj
 /O8BVnEkpaZabMz1UEMPrmRINg==
X-Google-Smtp-Source: ACHHUZ6xCu/M/0AOwG5LVLb8OX3DoTsqyFTeplRrHsUG1u2SLkBGduWAm9ZrSI41Zhf0Zeq1UunMJA==
X-Received: by 2002:a17:902:8214:b0:1aa:d971:4623 with SMTP id
 x20-20020a170902821400b001aad9714623mr18870991pln.38.1687501783228; 
 Thu, 22 Jun 2023 23:29:43 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au.
 [49.180.13.202]) by smtp.gmail.com with ESMTPSA id
 x5-20020a1709027c0500b001b246dcffb7sm6311389pll.300.2023.06.22.23.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 23:29:42 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
 (envelope-from <david@fromorbit.com>) id 1qCaId-00F8x8-0s;
 Fri, 23 Jun 2023 16:29:39 +1000
Date: Fri, 23 Jun 2023 16:29:39 +1000
To: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 24/29] mm: vmscan: make global slab shrink lockless
Message-ID: <ZJU708VIyJ/3StAX@dread.disaster.area>
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
 <20230622085335.77010-25-zhengqi.arch@bytedance.com>
 <cf0d9b12-6491-bf23-b464-9d01e5781203@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cf0d9b12-6491-bf23-b464-9d01e5781203@suse.cz>
Cc: djwong@kernel.org, roman.gushchin@linux.dev,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 dm-devel@redhat.com, linux-ext4@vger.kernel.org, paulmck@kernel.org,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-nfs@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-bcache@vger.kernel.org, dri-devel@lists.freedesktop.org,
 brauner@kernel.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 akpm@linux-foundation.org, linux-btrfs@vger.kernel.org, tkhai@ya.ru
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

On Thu, Jun 22, 2023 at 05:12:02PM +0200, Vlastimil Babka wrote:
> On 6/22/23 10:53, Qi Zheng wrote:
> > @@ -1067,33 +1068,27 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
> >  	if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
> >  		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
> >  
> > -	if (!down_read_trylock(&shrinker_rwsem))
> > -		goto out;
> > -
> > -	list_for_each_entry(shrinker, &shrinker_list, list) {
> > +	rcu_read_lock();
> > +	list_for_each_entry_rcu(shrinker, &shrinker_list, list) {
> >  		struct shrink_control sc = {
> >  			.gfp_mask = gfp_mask,
> >  			.nid = nid,
> >  			.memcg = memcg,
> >  		};
> >  
> > +		if (!shrinker_try_get(shrinker))
> > +			continue;
> > +		rcu_read_unlock();
> 
> I don't think you can do this unlock?
> 
> > +
> >  		ret = do_shrink_slab(&sc, shrinker, priority);
> >  		if (ret == SHRINK_EMPTY)
> >  			ret = 0;
> >  		freed += ret;
> > -		/*
> > -		 * Bail out if someone want to register a new shrinker to
> > -		 * prevent the registration from being stalled for long periods
> > -		 * by parallel ongoing shrinking.
> > -		 */
> > -		if (rwsem_is_contended(&shrinker_rwsem)) {
> > -			freed = freed ? : 1;
> > -			break;
> > -		}
> > -	}
> >  
> > -	up_read(&shrinker_rwsem);
> > -out:
> > +		rcu_read_lock();
> 
> That new rcu_read_lock() won't help AFAIK, the whole
> list_for_each_entry_rcu() needs to be under the single rcu_read_lock() to be
> safe.

Yeah, that's the pattern we've been taught and the one we can look
at and immediately say "this is safe".

This is a different pattern, as has been explained bi Qi, and I
think it *might* be safe.

*However.*

Right now I don't have time to go through a novel RCU list iteration
pattern it one step at to determine the correctness of the
algorithm. I'm mostly worried about list manipulations that can
occur outside rcu_read_lock() section bleeding into the RCU
critical section because rcu_read_lock() by itself is not a memory
barrier.

Maybe Paul has seen this pattern often enough he could simply tell
us what conditions it is safe in. But for me to work that out from
first principles? I just don't have the time to do that right now.

> IIUC this is why Dave in [4] suggests unifying shrink_slab() with
> shrink_slab_memcg(), as the latter doesn't iterate the list but uses IDR.

Yes, I suggested the IDR route because radix tree lookups under RCU
with reference counted objects are a known safe pattern that we can
easily confirm is correct or not.  Hence I suggested the unification
+ IDR route because it makes the life of reviewers so, so much
easier...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

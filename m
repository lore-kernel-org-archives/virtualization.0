Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60295416134
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798133; cv=none; b=NNSeCd0zg6QMuVrdw8O9OmMOtWdrdr/BGeojACWtNxxnpOxzDlt4kGVrsdqgg/WQRNwh9fF0KLn4m1yLit0SlTUQmTJMNmP9eRbcFgRTN2hjIqnVQ/rYGUD6lN1VupNZYeSrGpIQHnUhNN3/9k/DeuZOV+0AfP8Nm8wDIv5JIv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798133; c=relaxed/simple;
	bh=/r59B+4fbS2XEZA7YWBaen4M7zk7M6FzVG8lMCu5vdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QRTzVj24iM1QYB6J5Qf36deqdclBtXiDxDOg7YKjkEQHv/lC20eHjBnGuYtc4JbjJK3euN44ZClgVn78AfwnDD3ZCu3wcaRZLm9rA3CciW0b0FHnvWMqdiA0a8VV/bqfaygwAi8CBXPzJ22wVqTrjzcHuBEolZ6K4V4sHd0pkxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WYEhTiqR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYEhTiqR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784798129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HFDQsWaV4YVMqaytcd/qULKOMwPiXTV9I3KQpj/1PB4=;
	b=WYEhTiqRlpe1bu5fdwDiuxmU8TBupREdCAej0k/He3vq60p3sPvTPaa8Ru4k1N9BLdg98v
	EZFd7sP1FGQgmYQiMLmUfwN06oQtiy/Qj61jN/PhdRYvT1fjaPgroB1joPjzd8SMVslp6J
	7dY9im7lsqIr7u2uMKgagY55cnL3BpU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-H9qj9NpTMEqg3O7yik_CWw-1; Thu, 23 Jul 2026 05:15:27 -0400
X-MC-Unique: H9qj9NpTMEqg3O7yik_CWw-1
X-Mimecast-MFC-AGG-ID: H9qj9NpTMEqg3O7yik_CWw_1784798126
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4955843c6cdso4706755e9.1
        for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 02:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784798126; x=1785402926;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HFDQsWaV4YVMqaytcd/qULKOMwPiXTV9I3KQpj/1PB4=;
        b=jd/jUMpGGaSHrq80HEK+TZ8j7aThgpruQqTNdIrY/xB9b1XdnwRolPVPZvwJ2HGmUc
         AmDwsXhFgkH0CocwxyGB7FxULpwnjFn3oR9m5ofQdPtpnABO/LFbxwvf6kJcOW1oavBr
         YoN04XPjS8j1DJx32rd9aJ841Dd0Dxk85CxiW/1hTKi5Y0hw1mJcWs1qIOJhprmvaeBA
         X2n4ScnTtfNqxt7LXwKsePVTIFHnT6dwTPbweQHl3BBDPWy+9MpHO/DHYirFeZPD+TPS
         ztvbQim3qFaEby4gD18Yki/EYYaiNS1J8VcD5rIzd0bJBlWZF17XMV35UwSJemXxNExq
         ipWA==
X-Forwarded-Encrypted: i=1; AHgh+Rq316f0ztl6iGzBPmV1rZfPW4XyWDW8cTFsyA+nLlDf9GCOgDQhq41iamnVOf+KrTVNyivdnaFX6hdpogMxNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwogOplZDl4B7UwazyWL1G1Xzosau1p7SdDiR+aCp0SL6Nw8in
	Cm2NBNEMF26Lvimf9d+tZSRCKZ143JdgdRTq28BGFfsDDuK0gdcsNQhYopopyn8pMmcJUlExtB4
	PA0wRPd+wxKvBToMl5tVahQQD9BoPeuggQAJAt68d/SKNo0Wc3WP/FbX3mnvw8oc3Gzd+
X-Gm-Gg: AR+sD11hd40rthZNzt4x6uiTqAViQAf2Vvs3Xe5UU4qgejy+OpPR8hx036wo7hdBHML
	rBvHHMLkUSomBFEe9r9/vKzQlBQbtCFlkNhE2puImqAA5x/y2acvsYOdJ4yo3yNOtp0ko5HaYuq
	FDERAJlv2XHOEME/ZcKbPezHUFQEC4z/DvlGw01uZ4XAYysCN2ScPZPOVTjJPSMmeOD0fS+arsT
	CU33HDgtYRmU1i8FxSagFLageC+FqrD7Y4OJWJDuhT801878YTUX07GsuVGDU66BgFuJjOHltjy
	t0+QPlRnjcVj5+kyYl8Ocy83MHIs3fWFzoRQa+GYwU+kWT4xUpAIjx8ITc2c+yRxhbCMmxNOMvF
	u77d0HyOL4UbPt8X7Ms9hQg==
X-Received: by 2002:a05:600c:548a:b0:493:eb71:5cc6 with SMTP id 5b1f17b1804b1-49573d0eac1mr23927615e9.27.1784798126321;
        Thu, 23 Jul 2026 02:15:26 -0700 (PDT)
X-Received: by 2002:a05:600c:548a:b0:493:eb71:5cc6 with SMTP id 5b1f17b1804b1-49573d0eac1mr23927055e9.27.1784798125726;
        Thu, 23 Jul 2026 02:15:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956b72fac1sm108575995e9.1.2026.07.23.02.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 02:15:24 -0700 (PDT)
Date: Thu, 23 Jul 2026 05:15:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Link Lin <linkl@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, prasin@google.com,
	rientjes@google.com, duenwen@google.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, Ammar Faizi <ammarfaizi2@openresty.com>,
	jiaqiyan@google.com, ahwilkins@google.com,
	Greg Thelen <gthelen@google.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_reporting: use system_freezable_wq to fix UAF
 during suspend
Message-ID: <20260723051327-mutt-send-email-mst@kernel.org>
References: <20260721005603.1710551-1-linkl@google.com>
 <20260722173639.34d3f58413354218b24a5b0d@linux-foundation.org>
 <CALUx4KSfUUud86k4SLwETJAciRc8kZ9QocvBj39KmzXDiQ7J1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CALUx4KSfUUud86k4SLwETJAciRc8kZ9QocvBj39KmzXDiQ7J1g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SfJfe5bx2S0dK77my74Vb30sTBCdwtzgr1734FK5FUk_1784798126
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jul 22, 2026 at 09:07:04PM -0700, Link Lin wrote:
> On Tue, Jul 21, 2026 at 5:36 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > hm, now where did that come from. I can find no such commit and that's
> > the second time this very unusual thing has happened in 30 minutes! I
> > wonder what's going on.
> >
> > I'll use
> > 36e66c554b5c ("mm: introduce Reported pages")
> > OK?
> 
> Yes, that Fixes tag is perfectly OK. I pulled the previous hash from
> an internal downstream tree by mistake. Thank you for catching that
> and correcting it!
> 
> > The bug is very old so I won't fast-track this fix into 7.2-rcX.
> 
> Completely understood and agreed.
> 
> > AI review pointed at a possible pre-existing use-after-free issue,
> > related to virtio-balloon. But I think this is a rephrasing of the
> > issue it flagged against your v2 patch.
> 
> I actually looked closely at Sashiko's flag, and to my surprise, it is not a
> rephrasing—it caught a completely separate, valid edge case.
> 
> My patch fixes the UAF on the PM suspend/teardown path. However, Sashiko noticed
> a UAF on the PM *restore* error path. If virtballoon_restore() fails during
> init_vqs(), it aborts without unregistering the page reporting worker. When
> system_freezable_wq thaws, the reporting worker wakes up and dereferences the
> now-dangling vb->reporting_vq pointer.
> 
> Since it's a driver-specific lifecycle bug rather than a core MM workqueue
> issue, I will write up a separate follow-up patch to address it in
> virtio_balloon.c
> shortly.
> 
> Thank you again for shepherding this fix into -mm!
> 
> Best,
> Link


I suspect rest of work items we have, e.g. update_balloon_stats_work/update_balloon_size_work
all have issues around freeze/restore and error handling.

-- 
MST


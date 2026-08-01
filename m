Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C835353A60
	for <virtualization@lists.linux.dev>; Sat,  1 Aug 2026 00:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785543424; cv=none; b=V4uQ5xAPkLA+SGTH4SMB8W3JMj/ZplOHRPy4iUR0EA+MYsGd14s+183ApPHPDdCD6tT8rQnTkhz6H2pxfhQpNNFgnZqprIdLHle2Y0XeBxt9s40AaO+pCAiLkJdTJVU0sC176rW8lNOxFuCZz/h08feoZ3Dbl8/QRMl0sqcx23Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785543424; c=relaxed/simple;
	bh=AYV6oj9zpGuUjYDdThONODwSdRyt5PjMWy+DUh2trK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YmS4I4urDsnh2HbJ71KNag+WxDejPRqD6uCBfN6lqCRlJVzoh3S5P8wkdxsyE0eb825Wr8eSK1/G5Y5/jMgbD5o174kVW4R3fgdr+75icaIuyc/h3/7Qy3x7N8YoPHhfV9SeU2ZfGCg+qMt7Kocy80HeFRTAWtKxyk/cOOtBuQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zb2KlsDc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zb2KlsDc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785543417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YTUbWgbCMoV9mNudsltxaFWvTkWg6x0Ijnt3ApilYfU=;
	b=Zb2KlsDcu/i6sOY+h56bLgRn1EppUYuALnVGx+DJuJdC2Uc/hPRd9x4eSam5WA8aY6Cx/q
	aWmBwh+3XkHcE7C5lppG0CZL/NwL0qQKenw7DpFdRltRRMm28wbfGbEdWFxNUlAnqn44Sx
	6ss21DAbya3S+L0e918u4ABta4vBi4o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-ioygtf1oPauN7KWM7titYw-1; Fri, 31 Jul 2026 20:16:53 -0400
X-MC-Unique: ioygtf1oPauN7KWM7titYw-1
X-Mimecast-MFC-AGG-ID: ioygtf1oPauN7KWM7titYw_1785543412
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f83416551so1704112f8f.3
        for <virtualization@lists.linux.dev>; Fri, 31 Jul 2026 17:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785543412; x=1786148212;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YTUbWgbCMoV9mNudsltxaFWvTkWg6x0Ijnt3ApilYfU=;
        b=U6Uc7IfFQCoQpHgVH8nkinz/oZ+n+UQVNWyNM8OC9tU7l5ENquNPBAoqMuf05L5uzm
         NkpyD8T4ZHuILpL2XpMiGruSymchMASG86175rj1pol1GVZON8cBf9Eek0x4jqlnDO6+
         +TW1BQPqk2JtMjmXi5LKpOU8Xnj2UR9o7vUbp7LBw5G2Mr0R8YBv9UvJb8XJrwuIcm8g
         VNbMrVX2UwstrsgIHNfuYRFLm0cB7Ox6Vvp589GJixXdV63SHQf3M4dxkDk+CR8Y5l+6
         XrwKMYui3pmKMhjZkzOSNOVhv3F8zYI4MZy7xCrXULHpCnYgw6U/P/LZAQkgStJLXRAu
         mLDg==
X-Forwarded-Encrypted: i=1; AHgh+Ro7ghlBUzeAprMrVrk6lwKzw7HUZ5ieCGH0OTsOOYaCEdNLrry/8xkbYrg5mAuESCrp0Ok7t73SUZRG3vb/rQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3BuiAZgcpapFwINT0ARga8rvFwrgmrzZEwyFDaYiAvJ8aQXZZ
	sp9daAGTNqdbLUOwD5Fg5tj9vldiNvPN2A1DtjHsKmst5T+XyDj6c/YT1txPdVmv+s/5bcX0ksx
	1wpJEhud3VSctNwT58Wm6pX6wtOJz7ndiwN+oz8kQfbFy2E08BEAL//LzK3EtRfrZHljS
X-Gm-Gg: AR+sD10CkSLloAhcP+r1C3ljTXLd3cmtd6GFe+DWn+AKFC/W3uKfk7e+vms7LsSgylJ
	zWciDemKU3g6lzwOJu48WktnCYgPYzaT1hhnJBG3C16hQBjdUoJJ/IPpzDgSi4dweh374BVuaOz
	NNP1Dnn3LbGCynpEgHFetK7/YFIxG2tsJzNMcqy3+fmffkKCy4jXcQWrrZUBrmv8Am4M6Ngq6Af
	Xrt9XPWpr4Ta/tbBKMgklhuFLiHVOf1NcbJ0SKDUre2U7RUCTb48yr93IVs4q5EMmER+LxL7/PS
	GH6w/wVWGEixiJyw6yqWw5TAFyMeAW7v0PAKdrrzF+f9Hb2644NCOzhghfVXKfI0OP6fQAbSDO7
	b2buTJtHCQ82H5GYUhoeCwjM=
X-Received: by 2002:a05:6000:46d8:b0:47f:6a3a:9e6b with SMTP id ffacd0b85a97d-47fd72f1612mr1988325f8f.32.1785543412346;
        Fri, 31 Jul 2026 17:16:52 -0700 (PDT)
X-Received: by 2002:a05:6000:46d8:b0:47f:6a3a:9e6b with SMTP id ffacd0b85a97d-47fd72f1612mr1988296f8f.32.1785543411814;
        Fri, 31 Jul 2026 17:16:51 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm10836910f8f.34.2026.07.31.17.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 17:16:51 -0700 (PDT)
Date: Fri, 31 Jul 2026 20:16:47 -0400
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
Message-ID: <20260731201559-mutt-send-email-mst@kernel.org>
References: <20260721005603.1710551-1-linkl@google.com>
 <20260722173639.34d3f58413354218b24a5b0d@linux-foundation.org>
 <CALUx4KSfUUud86k4SLwETJAciRc8kZ9QocvBj39KmzXDiQ7J1g@mail.gmail.com>
 <20260723051327-mutt-send-email-mst@kernel.org>
 <CALUx4KRoCco0HA=Y_qFzSD=CegbJPUkQkvjRb1Y3UcgRdwQToA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CALUx4KRoCco0HA=Y_qFzSD=CegbJPUkQkvjRb1Y3UcgRdwQToA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dNlrOgepgN2cSF9lTxQRgLMDER5VkoH__2Mb_0sApA0_1785543412
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jul 31, 2026 at 01:21:40PM -0700, Link Lin wrote:
> On Thu, Jul 23, 2026 at 2:15 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > I suspect rest of work items we have, e.g. update_balloon_stats_work/update_balloon_size_work
> > all have issues around freeze/restore and error handling.
> >
> > --
> > MST
> >
> 
> Hi Michael,
> 
> We have indeed discovered a kernel crash in update_balloon_stats_work
> after the balloon driver failed to resume and initialize in our
> production fleet.
> 
> Alex Wilkins <ahwilkins@google.com> diagnosed, root caused, and
> reported this vulnerability.

I wouldn't call this a "vulnerability" just a garden variety bug.

> I am currently drafting and testing a
> 2-patch series to gracefully unregister callbacks and cancel work
> items on resume failure so that the VM continues running without the
> balloon driver instead of crashing with a kernel panic.
> 
> I wanted to follow up and let you know that we are actively working on
> this. I will send out the patches to the list as soon as they are
> sufficiently tested.
> 
> Best,
> Link


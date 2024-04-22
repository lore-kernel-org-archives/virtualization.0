Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E301BC2A
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 20:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713818798; cv=none; b=ZFX54ZRUF89NXENeSCF4xo/ENI/3BNKthcAVq9sBAP8H/Tl5gqXGWY9aXEMqfPpeO5mzYmryhjX5eOkLwOhIliknJX0Fi1u9CpLrL4es4vzYABOBBSb4J2oB8cYTk4ypym0NEYG/jziPh5Breoc6vee/3rfgkYCDCW/epusIm4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713818798; c=relaxed/simple;
	bh=H5Z6SiEa1LqyRln+jIweBVprBsLnwz9LlvdBu4wlfaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JmgvNGXuc/6vTd169naz33+1Se6fyFARO9hoSfe1aEFiSLu+waMQffTzVeAGOHhRHUedInzkUmMI6gBx35CFOKtS86IMRbtd5dK1R7NQqjxMD/blsLEbvF7HtDqMq1lkLYgfDPTs3mr1ogsot8v0r9p7G1bQis4Gzr7h0NIpZjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YsSV7Y4y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YsSV7Y4y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713818796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=40uoZHa8ePOa3oDdTa1uyiavWWTsYBTV5XVebqO3igA=;
	b=YsSV7Y4yswJIa2U3nmKPpPO1tjKm2ai22SJgYE3376rGvC0YgIPYJXREx+TmN2f+ss10qd
	aWsHmQq1ddwhH73ENRQssMPK8bxOx2QCwgu0UX3SSPHBDdg/K8P2bELXJpmVTlRdHLSNHl
	JN2+5WU9o1DPm+7lHGWdwcRNP2Pf3uc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-KmTe0iXaMw-U2SKIww_rJg-1; Mon, 22 Apr 2024 16:46:35 -0400
X-MC-Unique: KmTe0iXaMw-U2SKIww_rJg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343d6732721so3068330f8f.2
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 13:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713818793; x=1714423593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40uoZHa8ePOa3oDdTa1uyiavWWTsYBTV5XVebqO3igA=;
        b=T1aRSOdl1cT/mzshncR9dfXre2Zf32r7XSyH2DRhtM1kNYlL37LNOW6gcY5yx7rqMv
         VUK2rEUJAmLv9mTLfEgsxqdp2/zd7iPAggjQhSr+hGNhkKjT1V8OcypjCbAvv5zUTpiz
         fkyKw+8/oWA2hnm8JP8hNDOh/Ol/KGFoVRxmYL80I2wtTEGWdEqLDrb0vb1DJQ58wJSg
         cAHin27B9U8+8GPi0AlzO/yCN/jJQKfrwKv6wvn0Bz3TzMse4wBr6Mzo5x+YhKkm9pMa
         ZmmK6ZQyP0aEbI0s+/uRUlJJXpRRnrn6oJSi9EEX/h3KwWOJ++smCB3lGvktOrmZtkOr
         wJ+A==
X-Gm-Message-State: AOJu0YzfG8G2kLZrbT9kCiE61RIYEL6sv070l/4zh/2ZWEieRbmWUS9l
	fcTjOtEoRl/sRUb4sfTo48emABXwK/1MRkmkpr0SUsx7YEWbpkVGx7fqPe5/B7xFkRcgV/8HwQM
	/vDiajoaaxjkBaTnWve1RZ5TnclSQ2WG91GtBmiBa9KfYPcdrtwAP2InCQIqpC9nZ5LvLEQW4
X-Received: by 2002:a05:6000:137c:b0:343:eb28:58e9 with SMTP id q28-20020a056000137c00b00343eb2858e9mr8901387wrz.28.1713818792828;
        Mon, 22 Apr 2024 13:46:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwYrlNmXHqbs7mfM2hI9V4wigQlkwDYkE8MhG563Lcf1QV1RtyFe6oM1hW5UppmVzOzcuESA==
X-Received: by 2002:a05:6000:137c:b0:343:eb28:58e9 with SMTP id q28-20020a056000137c00b00343eb2858e9mr8901360wrz.28.1713818792250;
        Mon, 22 Apr 2024 13:46:32 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id z18-20020a5d6412000000b00347ec0469b2sm12878687wru.46.2024.04.22.13.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 13:46:31 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:46:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, will@kernel.org, davem@davemloft.net,
	stefanha@redhat.com, sgarzare@redhat.com, keirf@google.com,
	yihyu@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v3 3/3] vhost: Improve vhost_get_avail_idx() with
 smp_rmb()
Message-ID: <20240422164613-mutt-send-email-mst@kernel.org>
References: <20240328002149.1141302-1-gshan@redhat.com>
 <20240328002149.1141302-4-gshan@redhat.com>
 <20240328052814-mutt-send-email-mst@kernel.org>
 <8faa07aa-d330-4e3f-95b7-26437d448beb@redhat.com>
 <b41d65de-dc43-45f6-ba6c-ae722fbb70a8@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b41d65de-dc43-45f6-ba6c-ae722fbb70a8@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 08, 2024 at 02:15:24PM +1000, Gavin Shan wrote:
> Hi Michael,
> 
> On 3/30/24 19:02, Gavin Shan wrote:
> > On 3/28/24 19:31, Michael S. Tsirkin wrote:
> > > On Thu, Mar 28, 2024 at 10:21:49AM +1000, Gavin Shan wrote:
> > > > All the callers of vhost_get_avail_idx() are concerned to the memory
> > > > barrier, imposed by smp_rmb() to ensure the order of the available
> > > > ring entry read and avail_idx read.
> > > > 
> > > > Improve vhost_get_avail_idx() so that smp_rmb() is executed when
> > > > the avail_idx is advanced. With it, the callers needn't to worry
> > > > about the memory barrier.
> > > > 
> > > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > > 
> > > Previous patches are ok. This one I feel needs more work -
> > > first more code such as sanity checking should go into
> > > this function, second there's actually a difference
> > > between comparing to last_avail_idx and just comparing
> > > to the previous value of avail_idx.
> > > I will pick patches 1-2 and post a cleanup on top so you can
> > > take a look, ok?
> > > 
> > 
> > Thanks, Michael. It's fine to me.
> > 
> 
> A kindly ping.
> 
> If it's ok to you, could you please merge PATCH[1-2]? Our downstream
> 9.4 need the fixes, especially for NVidia's grace-hopper and grace-grace
> platforms.
> 
> For PATCH[3], I also can help with the improvement if you don't have time
> for it. Please let me know.
> 
> Thanks,
> Gavin

1-2 are upstream go ahead and post the cleanup.

-- 
MST


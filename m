Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C62722EEB
	for <virtualization@lists.linux.dev>; Mon,  8 Apr 2024 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712560795; cv=none; b=DDaLBltH3MgZSNlKTDrRUCdXlWaU1CPNxj5AqurdVLDpR1bfDuamUv478ibqMjOrINCyDvKU02rFtQVcK6uSFa+SnspUGZA2PW/iurk+yyvgLLCorUCPrl9DoSveGAezGIL7lBTZHzd2ZPApNx1qmjVidprYG4u93xB2X3a0l3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712560795; c=relaxed/simple;
	bh=eUKziqBBzbrhqWBZ/O72l+OQvAqgubuL+SFhJPQecLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KzrFkbm3lkAAiQererrwPHQmmG/b0QL8eL6PA/1Z/aXpEKFyPX5oZi4QJjItRJq4TeD607QS+I+AV29p5RPPmN8qF0I7aPAO/QqF7dAPbbhMKJejSDpTxEtf0t61G2kemJvCIsN0X8PkXGoO86SHvu2GIsDrPrB5xM9w3CF2bVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aNL54wPo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNL54wPo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712560792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8YA3MygwowqMrDITGbbXDUxPQpip1dfebFGErHe4OpA=;
	b=aNL54wPoEMAqVTuZoz46+59zqSi4LVYnYNIwrE/Rlg7txJW8SZfuSHRWYaFSGt0fQ6uHbV
	q9o2xQ2vuJyulPRhgUOilg5Ia+o2wd3z0d3WHa5KZufTdDSMKTV2FCbwwLWjXL8n2Vhqgk
	wvKSEtdmNxr1ays82XyOFfz4VHOg3Zs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-ERiXLtgLM46noYI_GJ7uqQ-1; Mon, 08 Apr 2024 03:19:49 -0400
X-MC-Unique: ERiXLtgLM46noYI_GJ7uqQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-516ef3189e9so497031e87.3
        for <virtualization@lists.linux.dev>; Mon, 08 Apr 2024 00:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712560787; x=1713165587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YA3MygwowqMrDITGbbXDUxPQpip1dfebFGErHe4OpA=;
        b=MWpS5H/jLQ0FtUB1NfkUVou7Mni0QSF+r/sgQ8vaQwOO/DSCFA0CJWeuOPC6MAA0Om
         3JLWl4EJk+gmyW7qrQpxSzTZluBD6VuNkyKqIUmyUMab+osGBKQANxtelnNLCfxR8VNR
         udRCZTsF7gDwqcSBSaY5ai9hwrRaFNZ2JUOvj4NIRRgKHwCmIm1ZC/4XVZETzvLhvPUg
         rUkW1//4xbHUK5YFsyzcc7Xc3F8V2vINsk1rjcSrjaQIE4s6zlZvnFlbPZfNag2C9tT7
         hPXunD/d55X0t+CDxEFl5uYLvtEKlRhbtNroufCE6uwhtFGRT2r5ZVA9kF05G1cn7hmP
         AIvA==
X-Gm-Message-State: AOJu0Yz4+NHrkAqdfnZ95S1Nj07pN3mRcstuivG+LoxU2mHbRbJrnULg
	JTKk5U3x6TfZ4rKcxbtshuSm8moJsaEaJFvLb+loU9ogBqmTD7en0VU3nxtB8Njg5nVncu1DmH8
	eGkd86rGJaRch7hMro7oCdjRccDRoiPSU1tUT5PFQgT2pR1U10GSbX/+ck6G0Fdar
X-Received: by 2002:a05:6512:3193:b0:513:5971:10c9 with SMTP id i19-20020a056512319300b00513597110c9mr6919925lfe.56.1712560787493;
        Mon, 08 Apr 2024 00:19:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbR0BCsbYb3Uabba61Ahp4qeIPNoBlWIrkVtqaThQquJhajN6V7N8ZV16ym9XreFqJ/6ATOA==
X-Received: by 2002:a05:6512:3193:b0:513:5971:10c9 with SMTP id i19-20020a056512319300b00513597110c9mr6919899lfe.56.1712560786914;
        Mon, 08 Apr 2024 00:19:46 -0700 (PDT)
Received: from redhat.com ([2.52.152.188])
        by smtp.gmail.com with ESMTPSA id s14-20020a05600c45ce00b004162ef30447sm11622842wmo.18.2024.04.08.00.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:19:46 -0700 (PDT)
Date: Mon, 8 Apr 2024 03:19:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, will@kernel.org, davem@davemloft.net,
	stefanha@redhat.com, sgarzare@redhat.com, keirf@google.com,
	yihyu@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v3 3/3] vhost: Improve vhost_get_avail_idx() with
 smp_rmb()
Message-ID: <20240408031900-mutt-send-email-mst@kernel.org>
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

Yes - in the next rc hopefully.

> For PATCH[3], I also can help with the improvement if you don't have time
> for it. Please let me know.
> 
> Thanks,
> Gavin


That would be great.

-- 
MST


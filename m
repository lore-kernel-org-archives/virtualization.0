Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB7925632
	for <virtualization@lists.linux.dev>; Mon,  8 Apr 2024 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712561608; cv=none; b=WKS8VKJUCoQRfUyRZF4f7L4iXg/BcWXbEvra9AlQ2KSxzYNagd+Zxv/LBGM4asADhJFrNoGwKSYQxnRa2FnPShyJFCNRmY/OWaSY1+IzT4eh5d3jV4kXsl//MmTEgBrAx653aezlIMK6DLDA+hK/2GitC6Bgqs6LMb+roQKNpN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712561608; c=relaxed/simple;
	bh=Ni7HvNm5U0I3Dy8ia12IlwiVKh7s5+qpbpTyHOdBxQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cSBQ7IqqPA+KmbgIHVmsxZpVKGuslaGyIVEkVDDbAbo+38Jy1+/AZis2HrAY1jKBg0TrVM3UA3sg0BELYKyIlqtJ6EwCvb8bOIWj7Y9j+MwX6VQXexMA5Sw5dJIuFlPEjIYrOCUgUEJi/08kumU1/zRzaS91shpSk+A0ezNI8iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQk2io91; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQk2io91"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712561606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T1ekjaOH/ZVs1uSejqLbBkJhchKKbAwLuZOoQubtwZA=;
	b=dQk2io919VcK1ovL40245UGwjPWDaVeNjvtKqs6nJmbo9z+9H+b6Kq1Eu54sGPdrl5BTlR
	tWKHQC/Mz+4/TnuQP5m4nfuira3KmLw/GX2Hd1vliu6gU7rVUtm1M9qCf1xhFzAs6SDuZ8
	xa/H2Bh3Ob7+0YSQcvUq5UboO2SfVkc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-TLO9NGjYP9GCfFj3Xc5x4w-1; Mon, 08 Apr 2024 03:33:24 -0400
X-MC-Unique: TLO9NGjYP9GCfFj3Xc5x4w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41663448bcbso3694355e9.1
        for <virtualization@lists.linux.dev>; Mon, 08 Apr 2024 00:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712561603; x=1713166403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1ekjaOH/ZVs1uSejqLbBkJhchKKbAwLuZOoQubtwZA=;
        b=IcrK2ZhLaFW1d70vCKnqjwYHnWOuoqy1/YGNoh18d84v6NTAMIIR5bxMjKeltX1vTm
         kvZEDmmYXMoeDhJ0JK7SZ0EMSlc1s9EvcUDJydhXKTjAX9cdFei6m1FWR6QtW2tgXeQy
         /YKgk7sg8UbbWklUf/ov1Uc9yDJrbClT/3i2LoHPktP3TQeahwnWfMyIlbR7b4i5EG8B
         vLVqgT6/Hw4emV+eold7GWDalMRXS+l2Kz+RivK1aHilA4MkQhOoyKGRTCXNGiH2j284
         eS3SKJVlyIKGIEHlPlMPic0/Q5zyzT6iD7KUUqe6HVvurlMay7jPyit2ueXxbNdV+qim
         Ml0A==
X-Gm-Message-State: AOJu0Yy0RQ0eyxamEzuXIqPjTrjBohHfEFGgpoqz3LE+JJRvkQNwGnuN
	YqdhEB7+DJ71seiqWadcdP1coiSu0L8ADMM8aodmDZwVPrFGDIsIKYsIRr+PITMVq5rq08waOqe
	1vCY+gWQ+1+cac1dgfo0OWJ/fCZNMFDOitTifE0S4uqIQ4mjQeQi5OlzkRZn5oP+q
X-Received: by 2002:a05:600c:450d:b0:416:389d:a4b6 with SMTP id t13-20020a05600c450d00b00416389da4b6mr5091673wmo.12.1712561603387;
        Mon, 08 Apr 2024 00:33:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/SGjudmzbcPixdO5UefgKZZdV+4wdtz6qX0cmlw84R4F3NMtGUXyrFS0IXMbUAGBX/Ln24g==
X-Received: by 2002:a05:600c:450d:b0:416:389d:a4b6 with SMTP id t13-20020a05600c450d00b00416389da4b6mr5091642wmo.12.1712561602800;
        Mon, 08 Apr 2024 00:33:22 -0700 (PDT)
Received: from redhat.com ([2.52.152.188])
        by smtp.gmail.com with ESMTPSA id r19-20020a05600c35d300b004163345d2b4sm9448357wmq.36.2024.04.08.00.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:33:22 -0700 (PDT)
Date: Mon, 8 Apr 2024 03:33:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, will@kernel.org, davem@davemloft.net,
	stefanha@redhat.com, sgarzare@redhat.com, keirf@google.com,
	yihyu@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v3 3/3] vhost: Improve vhost_get_avail_idx() with
 smp_rmb()
Message-ID: <20240408033143-mutt-send-email-mst@kernel.org>
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

The thing to do is basically diff with the patch I wrote :)
We can also do a bit more cleanups on top of *that*, like unifying
error handling.

-- 
MST


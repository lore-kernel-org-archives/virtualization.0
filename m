Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3943D13AD38
	for <virtualization@lists.linux.dev>; Thu,  9 May 2024 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715258430; cv=none; b=TlzxhU/b6qunideb4dvwLxIkZFNL5Zpz+3Ufem9doOYRsHdRnvlRCjuv6UegfL0wl7oqKKIgVVzy1pA5qC25BHTgnaCCzrXrB4aV07/UiNgfXIiJ8d4gH6Csp8njDxMx2ncwuvBa2pFVOho/x0OpFDqmusBGn4/wSOvERWmv/sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715258430; c=relaxed/simple;
	bh=6QAgBGpnLp/Yoi//FhBMNhfCa8BdSTvxkzjMnZW5DAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sfzSDzTm6ykYYJXnYNFB6FwC6JUTO6MPn0/hHmasj238oQY8jgfbO1ot7a8Dbit9KYBa3whKMYslN/7w1BbeurD+m117FZSO/brzm2E07+pWt6z2U/2CwSO+HpyOo8byiTfecg18lIZnvI3lYr/rY7sJ5Vfeyor8HkDZ51DoM2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P116S2//; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P116S2//"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715258427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zq1Bp+XS7zEC6kWJequgultx82349U3M21yYOS7MKek=;
	b=P116S2//te80Ct6ZnUXHupQuZ9d+r57PMUwJffxwye2L5gDo103+ZVgToFG1WkS977paPP
	u1YUtSF6VhcLrvyejtlC9Wm+i8cNMJriIXRJ3vHWe/B2iPaXyic64kRN80cxvnZanfS5B5
	+GGuwQouX3BMwabQnKoCF+QJVzooDS0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-IeQjd5RSPEi4-wIw7YTskg-1; Thu, 09 May 2024 08:40:25 -0400
X-MC-Unique: IeQjd5RSPEi4-wIw7YTskg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41a14cb009eso5625165e9.3
        for <virtualization@lists.linux.dev>; Thu, 09 May 2024 05:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715258425; x=1715863225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zq1Bp+XS7zEC6kWJequgultx82349U3M21yYOS7MKek=;
        b=Qrrdqyd6+JdngdzT7KDKRWUl1GiOKFIQ5dQ7FvXumgKvePeEPvT883mu92K9O5VPgr
         h+jI1m4kks7G1rubZNwFH6/pFuIj4N4JVgsEYwZFiNXlaLEGsw0Tzj4wgj6RYzRA3PA9
         dg6aFZy4zErHHkUyYCFxwDn9EZ/qtZqWLBae65pjSjkL3hLYg9mElAkG4Mg0h1wh6jJP
         w0/DHHqB+61QpFQBhqieI928vsi0vPasp7YNVqYo9mpStDup6xWyibMs7Th+xDeJIwZb
         404hzUtFOM/yNi6ayrVtT7cKvEHG2DWq6VEq9Qa6zMXqB3ndhuIaQNMSZsLF4DQfsqZN
         9ipA==
X-Gm-Message-State: AOJu0YwfH9BvhULCclWqKyUmd8Om4sTNY+huIu6/pDQ/fi/ik92FTU10
	FKLXDpmUGMsBrwN4Fjj6qgVnowRBc6dsNEhTT2ecv2BtJ7/YTVVijVdNtjbccZ0tvPjfCQW9y0t
	trt/BN2gMw0/2q9TNc0b7pR83wNh1m4je6OZCXZ6zcpFbEYIoIOMFuUDSppsE19/q
X-Received: by 2002:a05:600c:3c89:b0:41c:23f3:65fa with SMTP id 5b1f17b1804b1-41f719d6025mr52694975e9.28.1715258424708;
        Thu, 09 May 2024 05:40:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyVg+QJeYPewtRkSBNzWWmfGgOUdx+56uyfHf2/Z5aHyN1ArmPyyp4xMgmEXBIVBnrnczVyA==
X-Received: by 2002:a05:600c:3c89:b0:41c:23f3:65fa with SMTP id 5b1f17b1804b1-41f719d6025mr52694725e9.28.1715258424140;
        Thu, 09 May 2024 05:40:24 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:3cda:4bef:a79:3f22:9a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f8811110asm60824735e9.35.2024.05.09.05.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 05:40:23 -0700 (PDT)
Date: Thu, 9 May 2024 08:40:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Subject: Re: [patch virtio] virtio: delete vq in vp_find_vqs_msix() when
 request_irq() fails
Message-ID: <20240509083909-mutt-send-email-mst@kernel.org>
References: <20240426150845.3999481-1-jiri@resnulli.us>
 <Zjy7g0diPulvEnae@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Zjy7g0diPulvEnae@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 09, 2024 at 02:03:15PM +0200, Jiri Pirko wrote:
> Hi, I'm new in sending patches to virtio tree directly. Do I need to do
> anything more in order to get this fix applied?
> 
> Thanks!

I never had patches with "patch" in lowercase so missed it ;)
Queued now and I'd prefer [PATCH virtio] in the future.
Thanks!


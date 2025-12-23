Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3AB354ADC
	for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 01:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766453356; cv=none; b=ZdliwGvOLOQGIett3xrd3KY6k1oOr4az+WYmy/+WrecEiaT5byqv6cXnUaVaHZ52Q4UwwxOBr2/AD6J/WDGOtY/ue56UbuV8Gt8uWGBW1QWZJR36tCFgTsInQ7EFwDeg0L5CaPN4NmSoHU+CzFix2ZEvVxA3VHUyk2ByrL8FqqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766453356; c=relaxed/simple;
	bh=HxZBIQrNPUtqILX+MUs7BAnpHkmCv3JHX/T4T16NDGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jTZFIyEqWRLZMHY2sQD7fgWATZKUTbUs5LyEFmJ6Fy4Y4V25c+L7vfHWSecEmTU0BJ4Tb0OBnExSgh+LOKGRux7+R8Y92c+6TcbZVOJuSnGwpbSmbdo0biO2xdhmz4u3qm3Rkjuh8EvgDbwuqpuX4gjvVbSunMtrQYMlU+Bn7Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJ3iEN+D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJ3iEN+D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766453354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BD3GjIyrDKH9xeBbUL4g7HcZl7Q4z8Vu90OXxS4FE5E=;
	b=BJ3iEN+DmtvIsDSnfdWX02G/97xR2ZlHx1FjPheZ4uEeCq9ZYar9rZILwvLbdgXPu5Ondm
	6k8kZmP91AK0XtZ/wgV7w+iZx3KoopPjoalrplKvPkBo+xj6NRmQq4kMTg1/y2TyQoSSW/
	c5kSbJx5U36DYa7k3ZzKBdhUaPemuPQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-Xm87yVRcNW-O0aLhxeeX1Q-1; Mon, 22 Dec 2025 20:29:12 -0500
X-MC-Unique: Xm87yVRcNW-O0aLhxeeX1Q-1
X-Mimecast-MFC-AGG-ID: Xm87yVRcNW-O0aLhxeeX1Q_1766453352
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47799717212so47479655e9.3
        for <virtualization@lists.linux.dev>; Mon, 22 Dec 2025 17:29:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766453351; x=1767058151;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BD3GjIyrDKH9xeBbUL4g7HcZl7Q4z8Vu90OXxS4FE5E=;
        b=lxm5On2jyxhxBnw8tgKprATOsO9RIkZHUdmAaC6NygdtetiMJikgoRftR1e+rwtehz
         zf+fv3eGlYsTemky7u70guyOfbSi2KzOwt4Bcy21Hq+xQG2wdoHWgmROR49Lz1Jsv8nt
         j4OiHi4RFEInm1b1XdEDJh+FYAcuG7X2Xs3gsWv8S9MfUyvrvgXKALxhSGXskX+34LbE
         NDHxiKVsgX3ZK92c97x7uqV5XndsWoaahtStxI41jXtitbQTTAsOoy6ke6lJFaSX0y/6
         /Sqimqc2P2WSsInntJbgHxEa1PR1iWPClbrkRB5v4Gk7vDd+lvazTgVurF98qiaQyGTV
         aMhg==
X-Forwarded-Encrypted: i=1; AJvYcCWxKfXRj8fbMiApVx+bmVGidpa2qDay8SQRrVxuUYoLbhlB2SjyaCpbejLwZizXeM2vthSSGqdo9nZBW4EdFg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8CXL4f3U2+jaBQjjqLXRWHvQ5lINezwcEUBi368K4eUihs/7r
	242TUPMln0KqETfhWiPFbsfDpG86cvQa5CmzavugcgjeU8EAT/Mewp3SVfFAikVZLrX4PzrjmV6
	IYFHCpmghTPFEk78Cdeh8ZeyG55EqRd6PHzo0NaFYaerDrf9VqrDhOKyWHZeueicsHa6F0argD8
	yl
X-Gm-Gg: AY/fxX5VRj4s8MV0/Kj3CXGMq0DBwV3oMAdZHLulp8A/LIevYwz+d99afftE4JPF1Q1
	/gmUfIGyxizp5eKdVG87PtiJQm3pov1GieqVl/r6k5fE1w6hK9zT08qvQZgsF5CnUyk0Fl9fbif
	zojEnbffD8D3NO1YokeRHD+C9VVaY0aWRQW7AcmbemFIa1evFvoSJ9Sm8H6oNMKkiNBVS6bC9os
	iPDSUdH8g4mWI7rGloK3+jW1TVijMsMDCbUMDfwJeDLkltyKRAxunmXmKBgWwkiMbk0neWbwsHC
	EHlZjDgrwy1GZYsZpsDYfzJTVYN7R14dhdQLGofdTQAx0eXcNtFn+jtdFB66Fafh0FBI47nmzbW
	iajtI4QfyhvTyjHw9pVL0WK6wwQmSTHBWAw==
X-Received: by 2002:a05:600c:8208:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-47d1958d960mr119134315e9.32.1766453351310;
        Mon, 22 Dec 2025 17:29:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGO+LG2FI8JPMK8jgG+/xJo3+UBYSR7dVKlIQUEA+U3e7FL+sIKeyZHuU+YrwGcYBw8xYWP6Q==
X-Received: by 2002:a05:600c:8208:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-47d1958d960mr119134165e9.32.1766453350851;
        Mon, 22 Dec 2025 17:29:10 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa2bdfsm25512101f8f.32.2025.12.22.17.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 17:29:09 -0800 (PST)
Date: Mon, 22 Dec 2025 20:29:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 00/19] virtio_ring in order support
Message-ID: <20251222202855-mutt-send-email-mst@kernel.org>
References: <20251125070838.70736-1-jasowang@redhat.com>
 <CACGkMEtjvycsK0JJ0G89SRr3FTHgaMTU9nRZNqqv7=yxiTqgAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtjvycsK0JJ0G89SRr3FTHgaMTU9nRZNqqv7=yxiTqgAw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HQfPogPAFqg-8SbsvLc45q-5RUOjFpaHI4T2IpPhkt0_1766453352
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Dec 23, 2025 at 09:18:47AM +0800, Jason Wang wrote:
> On Tue, Nov 25, 2025 at 3:08 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > Hello all:
> >
> > This sereis tries to implement the VIRTIO_F_IN_ORDER to
> > virtio_ring. This is done by introducing virtqueue ops so we can
> > implement separate helpers for different virtqueue layout/features
> > then the in-order were implemented on top.
> >
> > Tests shows 2%-19% imporvment with packed virtqueue PPS with KVM guest
> > vhost-net/testpmd on the host.
> >
> > Changes since V8:
> >
> > - Rebase to vhost.git linux-next branch
> > - Fix issue when indirect descriptor is disabled
> > - use UINT_MAX instead of vq->num to indicate no batching is pending
> > - Tweak the comments for used_entry
> > - Various coding style tweaks and typo fixes
> > - Try to use in_order varianet in in_order ops
> 
> Michael, any chance to make this for this merge window?
> 
> Thanks

want to fix last minor comments?


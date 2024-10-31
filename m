Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844001A3BAD
	for <virtualization@lists.linux-foundation.org>; Thu, 31 Oct 2024 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730393567; cv=none; b=Bg7xqhXa3waWXrPu8XMq9uf0CGj9WQXQLYAV6OAPDfeOnVtBPLeybaC6LKxPg/VWuJsNfsBuX1WD5pnZJPP61kVHh1z+Iq5NzlpLh/q4kd6k/3WV9U7Uvz49kZwcusO02bN7nzUiULpBe7o5zUUC6u/inkjaaFE/WiTmqwbaZYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730393567; c=relaxed/simple;
	bh=BS5hmB3r5JRJgkt8t5hhtdGNi5nweKUfGpf2AXq2PkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uRijeOBwtdDjrLFPoaSiej+3HnoN1dk4b6Aiqb6iWZ7fOzFyqUK7stqmMtez+GCs/zLAchaX/YLuDo2DIoMXnSg+yfkWLi7wXNLFf11QC2xriH6NLrj+9l5sYKf/deOWi/myV9TctMPBM7GiA7SqHaflRSQTqtQo+huL6fZG4WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HaYQim5w; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HaYQim5w"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 16C8940F39
	for <virtualization@lists.linux-foundation.org>; Thu, 31 Oct 2024 16:52:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U97Am2SqtN91 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Oct 2024 16:52:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 37CA640F2C
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 37CA640F2C
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HaYQim5w
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 37CA640F2C
	for <virtualization@lists.linux-foundation.org>; Thu, 31 Oct 2024 16:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730393561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uBDbEsNrPrxBUbz5SD+H7kafj8htjd58kkZqqBBU924=;
	b=HaYQim5wQG+dnIfvtvseiJhywMlMctQ0Dst5l/qQsOuqk3xSVJuJfVGitm9+93rsYUFwgU
	fKYB6FjO136ljWUFBgv396uSXmrybS1XyfAPbCnmD2f18tJevTXVfTzl9ms0WkTqjyg4Oq
	5CdUXY2EEZAWLxwaHz9U/vNGkjTi8zY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586--ymFIdoJOQy0lr5XgkYVPg-1; Thu, 31 Oct 2024 12:52:40 -0400
X-MC-Unique: -ymFIdoJOQy0lr5XgkYVPg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d49887a2cso655189f8f.0
        for <virtualization@lists.linux-foundation.org>; Thu, 31 Oct 2024 09:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730393559; x=1730998359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBDbEsNrPrxBUbz5SD+H7kafj8htjd58kkZqqBBU924=;
        b=DanY/cC8hmfmVU94YNVfziEL8H8Fbm9MVa4nL+oyiazZJU72lbY6vS5rWk/K6faxdv
         LyxMWbTRJ8GWV3guKvyCOXB61+RN5HkJVBsXNUZRGA279coXGwKxgUIZm5FCXiCCBieG
         sIjPEEvRMcgofyy7nN9btIUl+j6Jc3i3UC+I4kWG8b6icn9y4PqyN6+yJeT0LM0sXcO2
         6d0AmvMvT0G1KwIyiRIx/Z4ZAEtp2m1qWYiUBX6QEby/1Pi2JWHJbdnn4L3EqvqCwwv/
         m0oHIAjYX65/L//zoc+d+mGbKaDnp699c1upQJAGehtNyAzr4Cg/skSz+hKO6zlinQW1
         t+nw==
X-Gm-Message-State: AOJu0Yx+AvkDGbQO4iUtuU9GBp+jaR2cVl56edxAHdJbSFUth8BzA80d
	JGNFUBUl89fkJZeptcLb6+71hc30Nq7tNeHa07xjQvAxq24F0zPMfKQ9QXzH5uT7tndA8Iji6om
	HsVK5I5fak4bIDEWRapZ3tObeL4fwSRHEde/pUUrTfeZ5GnKTebT3q61m5Tl5zrQJeHt7GFn8Ad
	0BmV4=
X-Received: by 2002:a05:6000:1868:b0:37c:f997:5b94 with SMTP id ffacd0b85a97d-381c7975472mr696955f8f.12.1730393558880;
        Thu, 31 Oct 2024 09:52:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxrA/u52ZnBx/affBRPSJtIWHijNnQ084ZmuyMZ7Own7T+n6OCGkABBpQLpeViUbOYo3WNnw==
X-Received: by 2002:a05:6000:1868:b0:37c:f997:5b94 with SMTP id ffacd0b85a97d-381c7975472mr696935f8f.12.1730393558537;
        Thu, 31 Oct 2024 09:52:38 -0700 (PDT)
Received: from redhat.com ([2.52.14.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf4fdsm32330435e9.17.2024.10.31.09.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 09:52:37 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:52:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Feng Liu <feliu@nvidia.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	Jason Wang <jasowang@redhat.com>, Bodong Wang <bodong@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH] virtio_pci: Fix admin vq cleanup by using correct info
 pointer
Message-ID: <20241031125215-mutt-send-email-mst@kernel.org>
References: <20241024135406.81388-1-feliu@nvidia.com>
 <39714b40-28d4-91d8-774e-9c8d91461d28@nvidia.com>
 <5045b28d-32e9-349a-fc4d-ae2a995437a9@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <5045b28d-32e9-349a-fc4d-ae2a995437a9@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 31, 2024 at 10:17:00AM -0400, Feng Liu wrote:
> Hi,
> 
> Excuse me. Have any comments for this patch?
> 
> Thanks
> Feng

it's tagged, will be in the next pull. Thanks!


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C12926A1B9
	for <virtualization@lists.linux.dev>; Thu, 10 Apr 2025 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744290877; cv=none; b=Q9AfUnEhDClu22v5mE6qcrn966Gr/CwSehGCuBDbIc4cEdsNUjGaeIMTI2BXcLufeT9W2U3v1Eq6RA0xtypoYB4DAmvKbpbK1/9Hn+aR8r+GJi4q977WGUSqHdVLN6hqU1O5PZh3Q+UPHQClTj4kl+FgAvbhATwuofeM37KYzMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744290877; c=relaxed/simple;
	bh=BcmKMDnLPpAVp3vzSciPmvFfbhWnoxQlSPB9efG3ZPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IRr2gdNRwLTqqDq7N1vKmC5gzBKIj9ocfxB+qg9nBRlDUXNtN4HY3gNckH8Awm6DeYGsk76i6oj+7Wv6MGNHZCCrld5D1Lj1g96V23uD1wzSrvAI21iO5JnzTCsltWh5kKdIh3f567uPDkMurdnllk6zPx0iWudysAU+jT8KMhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a6ioDff5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6ioDff5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744290874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5CWh61VoBeWDkhfINVEgBQUPREI3OeT7vB60AjBLh4k=;
	b=a6ioDff5p4pJ0jNuu8AEUWBsdjKDw3dn9/4up6+cCx/nBCHw0K48EYWD0oMdV3koStCEy1
	JBYHJ67yxRwW8+xOkXPN3jL1IYJXwmYfWCQ2tiK84Ter8Biroov/PlZreiA0fFxqzMMXd5
	/J7qhcUWYjwpC92f6DIVk2jXfaMaXTU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-M7836p6SMtKA9tTX5wL2gA-1; Thu, 10 Apr 2025 09:14:33 -0400
X-MC-Unique: M7836p6SMtKA9tTX5wL2gA-1
X-Mimecast-MFC-AGG-ID: M7836p6SMtKA9tTX5wL2gA_1744290872
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cec217977so5549875e9.0
        for <virtualization@lists.linux.dev>; Thu, 10 Apr 2025 06:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744290872; x=1744895672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CWh61VoBeWDkhfINVEgBQUPREI3OeT7vB60AjBLh4k=;
        b=L7RvqOh47goZki211Wx5fW+Kwseklizx7CBuLrWT/+FhxL1vigcbWa8Sn5+87X66c8
         lsTSoRRGcbSTk40Q//Usk6XigU5hVmyxWctLdtq45kXMzIE9o8Jc7PT8Y4ts7u81i1t3
         bzfaWKvHWiIYasFXPb9+GitHjw3kovjIFprEwYCNYxe6dvXVO3HWw/J1NsgRwgrjOXwt
         8WhgAIlWq3beG9cF1esYDkyX+LT8fggbxWCCM/QL6Gw37LnHRJZtJ6IzbJVXk5Wc8wxZ
         hMstws5ZejpHExcmK928lBxcvw+mpGNhR49g6Y4fI4CzFAwGzcPeevKTVTtfqTKa+x8W
         k0JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCncYdhawh1bsjJKu3cH7yVS2wLK68hRTrQXw63MTCjZTI3fgXQHzTIugvrHRZsCPywCxcbmrAy1pfk1NNPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLU1iPaAZc33l6GnYvW+4Jpx5ldF8b9QpYVBm73zVZIkIK3A50
	Hv/E0x8PA3sPZLijQ5Z/Vakph7Rtni6p1RmjR9wmHc9jCrm44Jbt22NTwiyA176/TyQ15r9jxDB
	cmt3AzLzcELbclF+ZFJ+NK13J0H2tACTOIyqd0u7sNEPhRGbUXbWm7+uL709ivJd9
X-Gm-Gg: ASbGncsOPpgNdlhXQAVDoOcEirjleM5WZSX6nQSvdtnlthK4eaee/WeBpM+aqmjvNNs
	7C/1upbHpmyiFjeGVR5X5YPb9eRg1WRK4d3DEMtr175SooRwLrryx/g0ooaX9ECralZqSrP+c1z
	3/G0heD6/Bqxqj0K9g2tjslnp6ThwQ4eueovH1k4dPbeoeGXgK6l4E+nwg6yH6wc/vqKmrn+EYi
	60Q2a7Lnm7tFsJB9VOPvRBTJToJ1QzWdNdfjaGhuhw/34ksVW/dSFJQjEL4hxAi/7r/Uv3XsaCe
	v1e50Q==
X-Received: by 2002:a05:600c:674a:b0:43c:eeee:b70a with SMTP id 5b1f17b1804b1-43f2d97bc34mr26435655e9.22.1744290871753;
        Thu, 10 Apr 2025 06:14:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV4Lyb/tgfnVcyyFGflhKQfwEnIUsEBhqCrwWvjfkvUDgCHowyRpN3WF1pM6qN8aW55vrjDw==
X-Received: by 2002:a05:600c:674a:b0:43c:eeee:b70a with SMTP id 5b1f17b1804b1-43f2d97bc34mr26435315e9.22.1744290871261;
        Thu, 10 Apr 2025 06:14:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f207aeaccsm53922205e9.33.2025.04.10.06.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 06:14:30 -0700 (PDT)
Date: Thu, 10 Apr 2025 09:14:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
	Eric Auger <eauger@redhat.com>
Subject: Re: [PATCH RFC] virtgpu: don't reset on shutdown
Message-ID: <20250410090619-mutt-send-email-mst@kernel.org>
References: <0d24e539766c9220b2380839472d1dc8739b5322.1744268995.git.mst@redhat.com>
 <07b30329-b4f0-4655-87fb-3ac52f9c64ff@redhat.com>
 <20250410084651-mutt-send-email-mst@kernel.org>
 <f1f3cfb2-86c4-42f9-b540-6feff196d426@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <f1f3cfb2-86c4-42f9-b540-6feff196d426@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oqy7o3hj12pdHxpcHpGXKQxznNnnmsjmCqoUwIvzRvY_1744290872
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 10, 2025 at 02:51:47PM +0200, Jocelyn Falempe wrote:
> > > So it looks like the shutdown is called in the middle of console drawing, so
> > > either wait for it to finish, or let drm handle the shutdown, like your
> > > patch does.

The cleanest approach is actually just fixing surprise removal
of virtio-gpu. Because that's the path the generic shotdown takes -
pretends the device is gone.  I don't feel confident enough to work
on this, though.
Gerd, what's your take on it? Have some cycles to fix it properly?
Now? Eventually? Ack my hack for now?

-- 
MST


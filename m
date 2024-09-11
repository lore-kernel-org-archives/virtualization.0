Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116E5185B7F
	for <virtualization@lists.linux.dev>; Wed, 11 Sep 2024 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064563; cv=none; b=TPuPpm5kX5/B+fI5A//LH3lY/uVWWY3o05vckA/fvL4KLPIUIZHXy/RdzGit4Tbbra8kzKyKF/pf0X0OMB6o49Vb3rIfl7OYGeAS44iGta36nQESFBw5DYUArf0jekD36GsUm+mlpsIDpX1upq9UN1k7f76U1Af/0PZPTID3hWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064563; c=relaxed/simple;
	bh=NOmC9DGMX2GCfVvsOzIC4lI0hPnfqP52+SQnoC29Y8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RAwCNblwGAIqaZjWrS3sVyj4uEhk0dshJ9Puz8aw9Cxrj/gER8YPAktlXrPb63o+5v1JhmedGTKVRsch9utdAnV2CDw+ky6vBulhpmjuP2I73PVq20SmyxnN0Hu2tOK1bE8KjWxUCWMC0leKN9MQ2txLCWZlttxwgsug4vBxB2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MwiWjVK0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwiWjVK0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726064560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KlwlpyR7s9PuNDsrnPWWnbsRUCrVHlg+jk+cktAZqCs=;
	b=MwiWjVK0bPZAGEdoZguJQsMzR6QjhF7vMe/Eh4C6gJsTdt4T3m4hpnXb48UllF99gVl65y
	EX6CiU5iFdCJ259R0P027Ax+TUpVJP+0uabCu6WiOm9A2FqxuO2PdjSTvDc3Pih6iJO2fM
	bulc2JlIkz076TTFOaa/LM7U+LjdWXo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-BTolz0pmMV-0ddyNXYlRlA-1; Wed, 11 Sep 2024 10:22:38 -0400
X-MC-Unique: BTolz0pmMV-0ddyNXYlRlA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cbcf60722so20461065e9.1
        for <virtualization@lists.linux.dev>; Wed, 11 Sep 2024 07:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726064557; x=1726669357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlwlpyR7s9PuNDsrnPWWnbsRUCrVHlg+jk+cktAZqCs=;
        b=iaaMtVWjiBOgMko1aKhhHpU3KnGBv5proQ3laKXxUaYtFWQA8x6csFuB+VROG1ZDVP
         4pgrtMOgSBGqxSxXtMtZrX6bZnpxxK9jE9ekj4kFiDR1TI54OMr8RmDuX4Dvp99xBksf
         QE7jFaE5/tntVXIeoOgyGnRoFW3+O83es+1lo7WQafT5CyYdagrDVQWJMcbxgaio7rPe
         6BPa9L9coElfNfDGpKNPzKBgDIT4sS8qbcXvIatXjpD4SHkVgvlAxErm9hZCWvYAtyQc
         VeT9r1d4b8+gcsUpyo192QQHF11U3Za6w2wPJZEIp5oZzYb7UkN36cw+TcboK4Gb5aie
         WJNw==
X-Forwarded-Encrypted: i=1; AJvYcCVx4dbtVeGAQIH8ifV6UDJlE5NXx7Mmn4sq1ar/esiG+1K7D/dErUPIQr99DPjkuUdK9zcuhtI+Y5OX1oYMmA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPkqVc6EA12u5dnIvAF/cn41Xioue7hTnXOqKAtCNk0rW4+JVU
	+wHuTGDedjE/LBaNOUj+1NbGJSlLzSNcwVAlWIlLjidvqAdJ+GGhhYxBK/UrMadWWJ5U3iBYfKc
	d9dECDcV5jLxpAaZKD3mXTmeWofdz3a/NuGDi69Lnz1y1SYAx+sCv0zSVAQcTLxDB
X-Received: by 2002:a05:600c:4715:b0:428:18d9:9963 with SMTP id 5b1f17b1804b1-42c9f9caad1mr136384415e9.22.1726064557468;
        Wed, 11 Sep 2024 07:22:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9m+J5t19nLZEF6LuLYy62fpUcnJkhDRp+iXgUVIJAMM0Awf3nAfjW/2/dTi9eKk32kN0jhQ==
X-Received: by 2002:a05:600c:4715:b0:428:18d9:9963 with SMTP id 5b1f17b1804b1-42c9f9caad1mr136384075e9.22.1726064556866;
        Wed, 11 Sep 2024 07:22:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:d9bb:9070:1995:8d82:f57f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a279sm11805272f8f.9.2024.09.11.07.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:22:36 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:22:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Darren Kenny <darren.kenny@oracle.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH 0/3] Revert "virtio_net: rx enable premapped mode by
 default"
Message-ID: <20240911102106-mutt-send-email-mst@kernel.org>
References: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>
 <20240910081147-mutt-send-email-mst@kernel.org>
 <m2ed5qnui8.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <m2ed5qnui8.fsf@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Thanks a lot!
Could you retest Xuan Zhuo original patch just to make sure it does
not fix the issue?

On Wed, Sep 11, 2024 at 03:18:55PM +0100, Darren Kenny wrote:
> For the record, I got a chance to test these changes and confirmed that
> they resolved the issue for me when applied on 6.11-rc7.
> 
> Tested-by: Darren Kenny <darren.kenny@oracle.com>
> 
> Thanks,
> 
> Darren.
> 
> PS - I'll try get to looking at the other potential fix when I have time.
> 
> On Tuesday, 2024-09-10 at 08:12:06 -04, Michael S. Tsirkin wrote:
> > On Fri, Sep 06, 2024 at 08:31:34PM +0800, Xuan Zhuo wrote:
> >> Regression: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> >> 
> >> I still think that the patch can fix the problem, I hope Darren can re-test it
> >> or give me more info.
> >> 
> >>     http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
> >> 
> >> If that can not work or Darren can not reply in time, Michael you can try this
> >> patch set.
> >
> > Just making sure netdev maintainers see this, this patch is for net.
> >
> >> Thanks.
> >> 
> >> Xuan Zhuo (3):
> >>   Revert "virtio_net: rx remove premapped failover code"
> >>   Revert "virtio_net: big mode skip the unmap check"
> >>   virtio_net: disable premapped mode by default
> >> 
> >>  drivers/net/virtio_net.c | 95 +++++++++++++++++++---------------------
> >>  1 file changed, 46 insertions(+), 49 deletions(-)
> >> 
> >> --
> >> 2.32.0.3.g01195cf9f


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686321C3F0B
	for <virtualization@lists.linux.dev>; Tue,  1 Oct 2024 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727788397; cv=none; b=XVm8z16dy/O8Baos75a85G++X2G0malMlqULuIYuxpVWr4iMbolnztG/chrSMnQUE/GAn75TaTui/tWUqymMYG2w7x1sWWtj5ZEIDFGCSXNDaLsr1/9pyJ4nZ0nnuqCQigSPVKUTocZEpTVihyw4agH1yNg1lnyibWXs8d6k9ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727788397; c=relaxed/simple;
	bh=UfrnhUQVyo2wO32SN5NdiKROG9kqZ27TtBQLwg/THz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lo9stOvT81CdvFC1suyEvibnyf7GJwGJDc0+PzJD9BUpFj4EPv23WIRi7TBrlGL0wE4PVmkM2XoPfHzSUVoiIT2OM+PRcOGcPgWsMwd0q8gRHFiyJR5mGpmmEvasGNtcdrUBVfRfCA+I1P3P9duLTxMEAGPijiTK6nawAxXKaes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OB9HmBnj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OB9HmBnj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727788394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gTnDU1z73Rnbhrtpq9+SGsnBXv3PyIWuZLF800URvx4=;
	b=OB9HmBnjFx8zTuUHsLwKriKT2X7gA33uP6uBVWv87gqU9C8hsNi1QzI9j9sMz01Odtouzl
	mQTco16EPDZBaTdXPjc+GyM624FeUSxWHRPpFMtVhYr/D8LvJjizSOiHtqHF6XMC2iUKm4
	Ba7odaZXjSrrRmMMici7rkriwO3HgIU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-9ajh-EgFOfGIIEI0gX40BA-1; Tue, 01 Oct 2024 09:13:13 -0400
X-MC-Unique: 9ajh-EgFOfGIIEI0gX40BA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cceb06940so36432405e9.0
        for <virtualization@lists.linux.dev>; Tue, 01 Oct 2024 06:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727788392; x=1728393192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTnDU1z73Rnbhrtpq9+SGsnBXv3PyIWuZLF800URvx4=;
        b=kbE6kVJYXSKr1idlAQ8uU+r5/w55fUM6cEFO8JjecSbRV6crNQ+XmAO39mKGkMlRWv
         wL2Q2q7eXl3EzurAskndaC2HTpy6U6LzXKcnEUhN02RzyIVNpYiu5rdTPMbiNX+2oD9R
         7KUilIYs9O8DgZ1+nieg2qzuIiw7k3C71heCb1iWYIh8reCVFSyfsIoSntcrQEKOt2VJ
         8tSzhNlAOLjdwTcVMQ9oUsUZ9xm/e+hkyc3N2uuQWeCoO3UELCAboXF+MyXGpvJbC8Ox
         lSNFXjZFpJqyZoNugbFgok+6mgV9of3xORrW0eOuxm0kegsL8ZM/OMhllArH26lN9VSx
         Resw==
X-Forwarded-Encrypted: i=1; AJvYcCUJFEsltVP6y9oaC5MJ38de7BqKFytBKqvB92d4W1kxocsbcUhfjZeUJuRk58f67+b69x8fnAkHLXgQVfCMWg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNcQ/oYA3TXm8CDYxKrRNxsQgvyHl9y2baqOgsKj9UairvzMer
	tVIesjcM+adTCeT4ZYJkiWVT6bP59Wd5u/6eS8vl4+qEJu4jYeIyXr6xvoZhEqhTIDZTvKvSU6g
	bEg5OWvYKdY7AhgwWlUVpG1k8izw4L/8kLX6dxpCklUHCwmXSbKGThaO0VSsLXERj
X-Received: by 2002:a05:600c:1c04:b0:42c:b9dd:93ee with SMTP id 5b1f17b1804b1-42f5849763amr112922345e9.34.1727788391964;
        Tue, 01 Oct 2024 06:13:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjWlB5VW/hUIu1yHmQgUpe0gbO0NGbAXuFYpqN1EaUiaOZRTPE0VVZwWGKTs7IiJ4sqC9Z4w==
X-Received: by 2002:a05:600c:1c04:b0:42c:b9dd:93ee with SMTP id 5b1f17b1804b1-42f5849763amr112922085e9.34.1727788391480;
        Tue, 01 Oct 2024 06:13:11 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55e:42b2:2c3a:bdd9:126e:d43a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57dec1c7sm132352525e9.27.2024.10.01.06.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 06:13:10 -0700 (PDT)
Date: Tue, 1 Oct 2024 09:13:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wenyu Huang <huangwenyu1998@gmail.com>
Cc: jasowang@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Subject: Re: Re: [PATCH] virtio: Make vring_new_virtqueue support for packed
 vring
Message-ID: <20241001091259-mutt-send-email-mst@kernel.org>
References: <CACGkMEvieuDTp-DfhQ58EGbeFCvNmn4fUNmUdPHzex6pOetbdw@mail.gmail.com>
 <20241001093051.42703-1-huangwenyuu@outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241001093051.42703-1-huangwenyuu@outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 01, 2024 at 05:30:51PM +0800, Wenyu Huang wrote:
> It used for testing in tools/virtio/vringh_test.c. 
> If vring_new_virtqueue supports packed vring, we can add support for 
> packed vring to vringh and test it.

Pls say this in the commit log.


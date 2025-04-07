Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41FB22ACEE
	for <virtualization@lists.linux.dev>; Mon,  7 Apr 2025 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016310; cv=none; b=Y6MUsH88a+E1JJJ9RiDINVHaurGVC53nzZ7+T6GlgEWGBD4potdTwphLtF9Nc533GZ9Ky0yvLXzfvuoLd8ieQz9W4zULHhiWVQadnjpw8ng75193ciPjda1w4RAZn3GMN8OuREUQfCH9zA7Rii62MLdUrrhCNe8Cikt0MNUYnh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016310; c=relaxed/simple;
	bh=CG8MriHLl4x6ooaR3HqW98i5p2ZNjETviVu5KLjC8Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UEnJH12cIe1R3gLc9rJbslInhko01hNrxTWmVMqfIr4SEzCcnwDOSF0iak70Ov6N7Ep8OGO6oSRs2o4NOdL6Rl+kOObSzzuU4UXq7/Cdq9adVMd5dh/s7Co8+mLJIAhS7QV3jaD4esOk1k4fVB0uE/3jxmi18CVvaLPR53ZBqLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CWAC980Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWAC980Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744016307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZV2HmK5xoNyWQTq3ZOPhBucA+WbSSx9NK0eZZiZro+I=;
	b=CWAC980ZcirJkJGiNUjU2/UbNdAj+PbILPIIUfs6kXkNYAdaj58pSgBb4h4gcNavQnoj5v
	2BZ3SCyWXwEhBg2Y1jF4ffX61MMbVfUgBj4eMCI+gEML/uWznBxfELq9YsbT8ZuT390mJc
	1UDxHbukaEBon70FB5xE+Qxw0OoAjgs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-o7dUw9GMMnqaicGKOzPu3Q-1; Mon, 07 Apr 2025 04:58:23 -0400
X-MC-Unique: o7dUw9GMMnqaicGKOzPu3Q-1
X-Mimecast-MFC-AGG-ID: o7dUw9GMMnqaicGKOzPu3Q_1744016302
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d01024089so34973895e9.1
        for <virtualization@lists.linux.dev>; Mon, 07 Apr 2025 01:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744016302; x=1744621102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZV2HmK5xoNyWQTq3ZOPhBucA+WbSSx9NK0eZZiZro+I=;
        b=Pr78wvSiR3q4AU3A5sufaeoGeo2ttWbVBlDYlFuW8miNH398D7O4mBlsIwlaP2mI6u
         4B5JkI5jlgzA79+NG+udoUQX7kueRMAppCdIB0fDT65eqKBGsqFXxWXAvJ9svh4UbxXJ
         s/Ix5dO77Np0k+pIOgHPvP47cJK1S+F71yvOHn84aeBr9n/6Ry4N1ypKNyDkirJ0LQqQ
         Lrgj7swGwHoRRSV+OzTOFJj1mGAcbmcxAMKAJQcPi3/6gVlBDnZR5rAZ617ukZF20abY
         av7sbWxCdu8XvQSq7UnXsxSnDkmxNNY7MlV/FbjyjfEbhfI0Z7+kIbfFR9nt//SHT0ok
         ug+w==
X-Forwarded-Encrypted: i=1; AJvYcCUBARoV6RG6YXKxucfi1Lno0vD/R0+NDcAncS+LEW0jyQKpQncITxYYrlChyEZVNVkc2dNZloQk0DDJVLZ0WA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+tHvwSUYCGf/sIbOQZ0x99s98khWVDL3+PzCkgnJqbYoNPO0b
	tCZrDMA0HomK69QkxCJqdF/sgNWVEbsiNpXZ/GIMaYxDwTgiDVGSxrEUvS1cuM8kgHWMFT8t2xq
	XrNZQoMXpxm1G9lZ4SG25ZXUzA7HEWWWdY58hVk+6Ta5dJG9g4gcRNXzbp8rG2WPB
X-Gm-Gg: ASbGnct6X8o8T0ub2xI4SPJdozlulGy+zzhHmRqdFgHKu172viLbeVNrt4VlLG2cZHa
	zkQF34vXMaqE9Wd8jdWojkyw5NzQmn+5ngUkWc76CkTLVEvxcx9KrICTNKayBg1nQ+hpjlTcyG/
	uUeriO1o4DorQYiWafjtnDWfRlrKfGrAeI8hZxBpJ2ypuqe3w6oyGmz7n9jTs47WL2pGpou4cUH
	qT+1o1RqenKJlkud5TeIZ9Eq7DJk2NI1KJ4EKYyWJEI6NKIRxK8A1w4y0AqkFVPcAuy7F+RPCxq
	72ztQfKqYQ==
X-Received: by 2002:a05:600c:468c:b0:43c:f75a:eb54 with SMTP id 5b1f17b1804b1-43ecf89dddcmr115800055e9.13.1744016302272;
        Mon, 07 Apr 2025 01:58:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhKuX0mUrFJVEgLqylU9xtfrLnxP9uo0MumXdr880MeHJm8lYFGfF2ifqGSX/2NbtuHhA09A==
X-Received: by 2002:a05:600c:468c:b0:43c:f75a:eb54 with SMTP id 5b1f17b1804b1-43ecf89dddcmr115799665e9.13.1744016301907;
        Mon, 07 Apr 2025 01:58:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342827fsm124494865e9.6.2025.04.07.01.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:58:21 -0700 (PDT)
Date: Mon, 7 Apr 2025 04:58:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, Chandra Merla <cmerla@redhat.com>,
	Stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
Message-ID: <20250407045456-mutt-send-email-mst@kernel.org>
References: <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>
 <20250404160025.3ab56f60.pasic@linux.ibm.com>
 <6f548b8b-8c6e-4221-a5d5-8e7a9013f9c3@redhat.com>
 <20250404173910.6581706a.pasic@linux.ibm.com>
 <20250407034901-mutt-send-email-mst@kernel.org>
 <2b187710-329d-4d36-b2e7-158709ea60d6@redhat.com>
 <20250407042058-mutt-send-email-mst@kernel.org>
 <0c221abf-de20-4ce3-917d-0375c1ec9140@redhat.com>
 <20250407044743-mutt-send-email-mst@kernel.org>
 <b331a780-a9db-4d76-af7c-e9e8e7d1cc10@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b331a780-a9db-4d76-af7c-e9e8e7d1cc10@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y7_ebIi45dvVCIBqCqY4xtyxK68qaU3VUWpJmHDOdRU_1744016302
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 07, 2025 at 10:54:00AM +0200, David Hildenbrand wrote:
> On 07.04.25 10:49, Michael S. Tsirkin wrote:
> > On Mon, Apr 07, 2025 at 10:44:21AM +0200, David Hildenbrand wrote:
> > > > 
> > > > 
> > > > 
> > > > > Whoever adds new feat_X *must be aware* about all previous features,
> > > > > otherwise we'd be reusing feature bits and everything falls to pieces.
> > > > 
> > > > 
> > > > The knowledge is supposed be limited to which feature bit to use.
> > > 
> > > I think we also have to know which virtqueue bits can be used, right?
> > > 
> > 
> > what are virtqueue bits? vq number?
> 
> Yes, sorry.

I got confused myself, it's vq index actually now, we made the spec
consistent with that terminology. used to be number/index
interchangeably.

> Assume cross-vm as an example. It would make use of virtqueue indexes 5+6
> with their VIRTIO_BALLOON_F_WS_REPORTING.


crossvm guys really should have reserved the feature bit even if they
did not bother specifying it. Let's reserve it now at least?


> So whatever feature another device implements couldn't use this feature bit
> or these virtqueue indexes.
> 
> (as long the other device never intends to implement
> VIRTIO_BALLOON_F_WS_REPORTING, the virtqueue indexes could be reused. But
> the spec will also be a mess, because virtqueue indexes could also have
> duplicate meanings ... ugh)

what do they do with vq indices btw?



> -- 
> Cheers,
> 
> David / dhildenb


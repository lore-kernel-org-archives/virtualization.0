Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFD9613D
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721829700; cv=none; b=SRqCG8YmF+nIZDHLE8QXITCBpetBN2hsRjpqTG7WdMpnOzg3sJ96Rc5uq5kHD+vL6LQTbCiLAj+t0Ru8qbPlARPtGqSMRht4rM2bUEzh1jGBwFbSh8IUpmU1MHaWAM/6+tC2Ap63WOZPhTUynTa5U6C8a0LbYkdWENmwieECoyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721829700; c=relaxed/simple;
	bh=7zbYSvMfxQPTM5rStvV9PO4vr7mYiKgSxIueimZutnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XCEJreAyCzI1mFp9qOE12XphbQuRDByX0YUXOdM4QXUpqIYsJglNTjIhrtZs+9d9qWaeKbXKlk/M+wp51iHhvGGFaolsmRZJOfPSpEfWgPM6gvdKqcH4M06PgX6fgrRiuyyszEhs11Uxz/wytWanpZYwkY2e/QDJ7HGqbtLv5bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TpHGyzD+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TpHGyzD+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721829697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NG6SBCD4f6wTxv8P8uRrrWCf5UozNX+yQ9rwJbTAlU8=;
	b=TpHGyzD+PY68sJMTBaQpi0PWw6tLCo45TGfrnqlC2XdqFAEYeXkSthmfunG4GHLVtywl6O
	q9m2UO7GaMsht9ov13DEVL+unD+PoTuOVb9Hpa1g5h6OROYykcVezr07pHVsPkA/9hx6zV
	iVXmM3bXznQvbsAuCHohk4oGge5Xnos=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-G8rpa2DkMcyRm2QZYw16TA-1; Wed, 24 Jul 2024 10:01:35 -0400
X-MC-Unique: G8rpa2DkMcyRm2QZYw16TA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a79d8586cb4so72630466b.2
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 07:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721829693; x=1722434493;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NG6SBCD4f6wTxv8P8uRrrWCf5UozNX+yQ9rwJbTAlU8=;
        b=MbtYrN0hYgWONmfQcf7h0czrwKpPStUIZgchIw7huOktDhAYcS4eRtg9O1qJCJGrH/
         s1RbSqh6mRko92zHtDyvBboN3zFXJaHQ6WPnxYsWaKxHg0oDdk9kV9qRegfcuR26vChb
         mfvlv63viEKEGaPQvn3fhUM1P7lo31wqbuLzhbe4lCwY44YBh1AQHaSKL8fpaHw1fAvP
         cNqmI9PNA01RNpR8Xk5bM4uL+obXNHE6QhWZYV+W5wKlzLV+shX3TZG+snImTKoQBTFw
         lSnD+lT+RfzfPC9ngrit3rXuL0L3+9nxuQkqDrD3CZV297wOqfua2c9YmeueU468oWzx
         krZA==
X-Gm-Message-State: AOJu0YwqBO6LA+sSbaXrd7CFUGQiXl5MRDDDd45G/wxGvtuhswQxMfvv
	SxphENawTnHKQ0IiYkXM0URThdMD01kvOOvAvwqB3iqmJrHz40jduyVArtANUOph5H0F2qJC0SC
	bZCGIu0ErXPprRzDws+jlYTZSZ/1SdoeupeHwKQKQvcq0psF5xpY5HnFh1v5d+br3
X-Received: by 2002:a17:907:3ea1:b0:a75:2495:a6a3 with SMTP id a640c23a62f3a-a7a4c584107mr1015218066b.67.1721829691612;
        Wed, 24 Jul 2024 07:01:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhgOA6+BjIvIUdVRQyeVzmtenjL15Kk2rb7ZqQVZIXNWXQXvfjil7YNkILxsNSInsCeM0C3Q==
X-Received: by 2002:a17:907:3ea1:b0:a75:2495:a6a3 with SMTP id a640c23a62f3a-a7a4c584107mr1015203866b.67.1721829689442;
        Wed, 24 Jul 2024 07:01:29 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f4:6083:a67a:e8a9:2855:2683])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a9f463194sm158866466b.112.2024.07.24.07.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 07:01:28 -0700 (PDT)
Date: Wed, 24 Jul 2024 10:01:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Juan =?iso-8859-1?Q?Jos=E9?= Arboleda <soyjuanarbol@gmail.com>
Cc: virtualization@lists.linux.dev
Subject: Re: [PATCH] virtio: Fix various coding style issues
Message-ID: <20240724100022-mutt-send-email-mst@kernel.org>
References: <Zpn9t5xJCPMhvpZO@fedora>
 <CAJaqyWfU0th74hJ3Vww6QXqewvSyOobgogT=Vt57M+HqaTZ0ig@mail.gmail.com>
 <20240719140906-mutt-send-email-mst@kernel.org>
 <ZpromZpQ7ajhEJHB@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZpromZpQ7ajhEJHB@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jul 19, 2024 at 05:28:41PM -0500, Juan José Arboleda wrote:
> > warnings from which tool?
> 
> Hi! Thanks for taking the time to review this!
> 
> >From the 'checkpatch.pl' script
> 
> Regards,
> -Juan José

As a rule, we don't just tweak coding style by running checkpatch
on existing code. Makes backports harder for little gain.
Code gets tweaked naturally as someone works on it.

-- 
MST


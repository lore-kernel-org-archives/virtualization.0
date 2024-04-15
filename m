Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA9471B51
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192601; cv=none; b=Lyf+iYmdIWqWvgUijNudOdky7EsrlB9TrisJbebVaxL62i9iSiNbTL3zdo8r53jeLWiwQNTh+PR26I5Ewi6QUmmmsys7AduOIMfBaKW12a2L6zKJLyKC9XgSfmUxN2MRxnBSgpvfZzp0CDDzvoNAXIjF4F35Bf2wnYSzCqv2bzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192601; c=relaxed/simple;
	bh=0NzzVoA3Qp/EEjnYZR/2xnbHUOk3Lbuqgo2rAqupN+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=c+N/1s6zx/ScFUkhrA3A1W9uVMsRcjtzikK271Evnym8YOjspZJ29r4hI7AZJ7MRvXELv3cbV59ejNTu7LivQ/v3qMYUsRmHrJqsbcUcVzzsJBRzVmeC5I8FwVVRyxrAB2ROjxqLqAh2yr5mInQXDDaoxIjpUL6BTeLz/DdKNeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TWE/99zy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWE/99zy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713192598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8cn/kmABEOhL+00JIS4JfkabQ7PPgTCnV4hKk5df6tE=;
	b=TWE/99zyFEUd9bCnqk6X7roPv06PCOeJCG13Wzi1l6IUd4e20nmqI9ebIKwe1uQrmayghz
	eR+MwExZqNhuT8F6gqHS6NZ53KgaX6Bc4IWRrOA2HMdeC5bhI/zUH/citnYtjCiQHHiP+O
	a9ueF0t1xvD5v1H7qTov/NSG94ItJOY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-HkO7lF76PwGtZo_jm5gXPA-1; Mon, 15 Apr 2024 10:49:57 -0400
X-MC-Unique: HkO7lF76PwGtZo_jm5gXPA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-416ac21981dso17503425e9.1
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 07:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713192596; x=1713797396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cn/kmABEOhL+00JIS4JfkabQ7PPgTCnV4hKk5df6tE=;
        b=l8usg/Tpm+jSJgq6qfy8oWLDZ5rU6vfP8VZj5Yns4cNwN7gE58bI+fQIEj8L6ik1/P
         zbyEyV+fqFfFZ3krtGzrWB8tY3bxeIDcoyRlSY1TB+9cgFRrv0XHN8bm25TK4y2KCrCg
         k6U4HIdRc0+9p5EKaw94SCEMruZpzMKA6GaEi7p0PEVf6P8TIDxaA+k2q/kmRO6HkLgR
         +0qsDDYZoqlwdSfhuW5Zqoqeo6toB+98RtV+CBjKye5stZfUz6Qz3C1ARywlIsouxzZD
         kVajU8od+uEzplWQU7pvKEnNl5MLbD8Ntc1NFPS+mpakFn4tlxL9DKsjINx+4hx9tOoi
         zCRA==
X-Forwarded-Encrypted: i=1; AJvYcCVsAoK00x0TMCubi7ojtewr2Mh7r2WbVpAmv7vqp3b1mHXvqNDHvU3sLKA1scCCJLQfskb1ANGilQ+k83G0hzGCGPlLFY1KQQykbBQMoJU=
X-Gm-Message-State: AOJu0YwTNHLH8HO5nKuoq2TE570QFw6FHx71FAm2ynH2X4kEKDpjGr63
	8qWEbtU7SOylLZJs0hMFi3pmoHbk76j6sf5Y7eVNWVW7wJRWZwMx78LZqDBXuIqLEhqYeQI8Cr1
	3ixqxYYKu0UhEIUzQkjSmC7JFOOG4hSCF/xY2n+Kq8fRjSZriKNMFQYPv+leVKdEK
X-Received: by 2002:a05:600c:4e93:b0:415:431d:7747 with SMTP id f19-20020a05600c4e9300b00415431d7747mr11204821wmq.7.1713192596005;
        Mon, 15 Apr 2024 07:49:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMgl+RP7skllo8GxOuBb5pOrbGFdg/EBXBQoQOrZn8VxxMClpJT4NhFkFViz0zHyrKFLmM/w==
X-Received: by 2002:a05:600c:4e93:b0:415:431d:7747 with SMTP id f19-20020a05600c4e9300b00415431d7747mr11204797wmq.7.1713192595484;
        Mon, 15 Apr 2024 07:49:55 -0700 (PDT)
Received: from redhat.com ([2a02:14f:172:a95b:a91:79d:72cd:ca48])
        by smtp.gmail.com with ESMTPSA id ay8-20020a05600c1e0800b004181c91d1dcsm10448378wmb.18.2024.04.15.07.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 07:49:55 -0700 (PDT)
Date: Mon, 15 Apr 2024 10:49:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ricardo Ribalda <ribalda@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Igor Mammedov <imammedo@redhat.com>,
	Andrea Righi <andrea.righi@canonical.com>,
	virtualization@lists.linux.dev, stevensd@chromium.org
Subject: Re: ACPI timeouts when enabling KASAN
Message-ID: <20240415104923-mutt-send-email-mst@kernel.org>
References: <CANiDSCtJKZDwSpy3RWW7FPQiJf+LqxrZJs=N7KrvCz0EFjh2wQ@mail.gmail.com>
 <20240414043707-mutt-send-email-mst@kernel.org>
 <20240415145153.21075173@imammedo.users.ipa.redhat.com>
 <CAJZ5v0j3BVUKDFE-_Tdykt42zCiDfYMpSYN54JUqdr2O8a__1w@mail.gmail.com>
 <CANiDSCuvDQWam0v1b3adA=j6w+dA263QruBonsA6TJBvO9XsWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CANiDSCuvDQWam0v1b3adA=j6w+dA263QruBonsA6TJBvO9XsWQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 15, 2024 at 04:18:22PM +0200, Ricardo Ribalda wrote:
> Hi Igor, Hi Rafael
> 
> Yes, it seems that it is just KASAN being extremely slow.
> >From a completely newbie here... Is there a reason why qemu generates
> the table vs returning a precomputed one?

We never saw this being a performance bottleneck?

-- 
MST


Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BC1762EB
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726081341; cv=none; b=BHV6P6HPcp8c+wbkc9FqFiEa6sBFlePZk50+Wyj5fwVCMFqOhi1RtYSJSSU6DEIN4JwxloIechstU5FkefcOpnxxgH1N1VGd3Ro4QIYcyyoXFV2IFY6GWa/Ww4suCuHtwnu6SJpDnUjZDjaASvyTmU4NW9mF2TTJc26+XrmFjk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726081341; c=relaxed/simple;
	bh=OqRWlctVLRA+Uc0IjBjKd06kZ/Gl2JOSWteQyBo8hS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Y/D3lshZ8IQSplpoiBRZhusD6jv8p4s7eXXb43zaFIfj/4GpPLfttMasT8+cwPXdB7CRHji0OR3Kz6J+xqZTuQu6WJUVErNktYsM3oRmOOORw+T+HAAXKq6E05TX4sATI35gE+p3Ge1u5iNJPQ4cCiro1jjlKbR7Ahv1twtBWrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZEob9S6l; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZEob9S6l"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 701114032B
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 19:02:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kAQOBPZTU-hd for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Sep 2024 19:02:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 862994021C
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 862994021C
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZEob9S6l
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 862994021C
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 19:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726081337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e7bU+mVDP6egUv5mM9Pjy0JHa4eeEo68KAivXsZTIBo=;
	b=ZEob9S6lm16Ltwkt8KGvgheKz7DAfzHprPpP4Yz7E9niT1XuBPKNttQSnGTvrx5nmePR+x
	aHpDSSVhpiWB/ioLGoNmZsDSEMTzF1nRlBZtf0kOdKyHm/iDhTH+IEVZlHS0gJCvO1PlEe
	zpWwHtrFcRnXLhObSa0UsXxBP4jxYV0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-MeToepe6MWSs5RjHDazTjg-1; Wed, 11 Sep 2024 15:02:15 -0400
X-MC-Unique: MeToepe6MWSs5RjHDazTjg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb940cd67so724325e9.0
        for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 12:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726081333; x=1726686133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7bU+mVDP6egUv5mM9Pjy0JHa4eeEo68KAivXsZTIBo=;
        b=lJ7fiCmmVF10G695CZ8PBX2S5Oy9sHn0QLWe4lkZb8oAFZwRkUHaKN/xfcIUzwwkxv
         4xwCKD5OUWts2AwA82VPlxYaNiFQsiYyoQAPXvnRw/b1PAxDfl5NmT3BL31vt7pI9QNr
         D6MiXnDvKmPBUc08CWNOxcophphEvYVF8z13hKBXQWWWCs8yQrMpFVRDdbdW7kbIDUw0
         MBTm/a9rf3W6fxSlDElngC34U/qFif2SXcFwrnxmMq3p37BMcpvOyLGrZCHkC3ryakuT
         4CXLBJ2Hnf6IGbTQtK5zUv0nxkvxuvU4xJA7xUQryxXwgvRjvlwp+4gyHiBxh6K4ZXkK
         kA+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMzTWUPOub6nyBj14PGF0piWjIz45PTGBPVBvwbe+5II1Gk+PvsSB+TuUj7mLbCoMPwFV61/LAxnT0GRVZQw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yxu8Ye4Ss3tkJrWlVgV+DzbFlQJwZo8GgE7pAUlNb6AfYK2KltM
	jSezbDXKeVj8Co4K7NCFEURbLbwoBvJBF5RR4C84A1wj1HvAb/VZxxw+f0zD7WDWvPj4KPN5eBR
	5Ra2KQGrIPFdL8kD9lgtQxb/LPSUhvZAu7C4sQJhULDB4DWKy0haRD2tptOfwQsnMulnKflGxfU
	YRCek=
X-Received: by 2002:a05:600c:3551:b0:42c:af5f:c00c with SMTP id 5b1f17b1804b1-42cdb54b242mr4969175e9.21.1726081333302;
        Wed, 11 Sep 2024 12:02:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4ivWpS+X29Q7R9vEaleEKcy9+v90NgsupdcOLk9j2tmo8P8MX/7b3+Rk8xJX92zcVMmn5kw==
X-Received: by 2002:a05:600c:3551:b0:42c:af5f:c00c with SMTP id 5b1f17b1804b1-42cdb54b242mr4968785e9.21.1726081332434;
        Wed, 11 Sep 2024 12:02:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:d9bb:9070:1995:8d82:f57f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb5a66475sm120162365e9.44.2024.09.11.12.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 12:02:11 -0700 (PDT)
Date: Wed, 11 Sep 2024 15:02:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [RESEND PATCH v1 0/7]vhost: Add support of kthread API
Message-ID: <20240911150013-mutt-send-email-mst@kernel.org>
References: <20240909020138.1245873-1-lulu@redhat.com>
 <20240910032825-mutt-send-email-mst@kernel.org>
 <85fb3a90-fbf4-4925-8b53-197f3faa574d@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <85fb3a90-fbf4-4925-8b53-197f3faa574d@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 11, 2024 at 11:20:30AM -0500, Mike Christie wrote:
> If people are ok with something similar as in this patchset where
> we have both vhost_tasks and kthreads, then I can send something.


It would be better, as you say, to modify the vhost_task code so it can
emulate the kthread behavior. However, given that apparently some users
are unhappy, what you describe would be a good stopgap solution
until we have that.

The main difficulty seems to be to describe what the
behaviour is, exactly, so userspace can make informed
decisions on what to use.

-- 
MST


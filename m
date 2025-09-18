Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40237212566
	for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212385; cv=none; b=cVh1ZBDO27sFuvnHk3jH6GBcTAxlR+yqze/UNEQdQN8PKYOYs87o/xqRCQgclMAWKia4tXqZq7qY/Ar3RXAEiT/B6tj7qvgcwZ5fywokHaA8JcTL6McgCNgtCwdhgM2X/4e7IHKlDA52RmojqnllNU4J3paOV8sShKjeM7Vzcng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212385; c=relaxed/simple;
	bh=EFWvOc5eU4ofeSkKNZEI5Kq6UjweP2qNOUO50xD8gVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VhTUUOwfByVvqKuw5cXBdPPCXY8QbjA5Kl8WMXek0Qf8yEGxGZyGuj1BmCHyiT3t9gSJYa4wT2JXHaIvdOtHbrmsjiERf/IKwNae5N8wGc302zQyv5xaPRhEJlVVAwfnM/HunuNEeRh16ko1gpCnbDsIdW//66OnyLVE+DclN1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AKaDOM7N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKaDOM7N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758212382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kcQaTjAvvBmm7x2rEgbh3SMOE0LbLZC8F5+37ZuTXtw=;
	b=AKaDOM7NTwntiU1NTKpSfW2Da4MIkZsTc+RmO64yKSG1M79egszSOHKA9N0gG0WpDvmSfu
	kYPCsKuumxeu3anBr2CECMjZFWvG/aD3GhASRAXOvRGLnU9lyqYdgMPk0404nTQY0BVtOD
	CYXErAoQSJtTllWl9rF9O4NF+Smyc14=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-QzFpH8ZlPmWgd1QhCl6c5Q-1; Thu, 18 Sep 2025 12:19:41 -0400
X-MC-Unique: QzFpH8ZlPmWgd1QhCl6c5Q-1
X-Mimecast-MFC-AGG-ID: QzFpH8ZlPmWgd1QhCl6c5Q_1758212380
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3eae869cb3fso659973f8f.0
        for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 09:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758212380; x=1758817180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcQaTjAvvBmm7x2rEgbh3SMOE0LbLZC8F5+37ZuTXtw=;
        b=v330v47oEvK4zsT0mVJHu9/GflJ0Wxl7CH0QFBvIhNCeiDY9UxJa73UUCSpkA5ZJoz
         4qGNJCC0JO/Nw5dwHIO+eJRZuahg6XtnJcH2mFTu33AD8fE5xkyHd91B9OuG9wwxLHB1
         E6vuAQIwqmDa2cSFY+UGzeKyUCxbDa2MACNMiU1Ncu/a2qspNf52iWaIK8SmgTm9W+eW
         UTp4WG4OpoeR4JfRrPGGgR0zGMr9ivcaWR8zNi0lRpbaY81Gzjg1kL+1eoz1c8z2z06W
         g0GGLSc5YSFlk2dY1EfazFTDrT/x+E/LJc2Wmy1+djfbXWCrL9iNPnxnQ0sn4yEzgn8y
         iC6g==
X-Forwarded-Encrypted: i=1; AJvYcCXzSUuf8mT3szRQLwoqVvZAjSj5uydZs15EbQsb6ZVF5WfT05eT4GwZOABCRnca8GI7OLJOoH9iuew6pN5XIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCQq/0zpv5ymvVUILyYUNrmjmOOP1LNdCzEdiHSNr1yn5mjdR2
	Kqgrch4lePsFmCshuc6s+1VVHHh48mlnv4gTtr42aFFQvmN5gdkUSJ+R7+m+N1/+HRd2fDkw7zQ
	QMvEpYPJCRDXZ122YkhCXYDhdQ1Pcs3vX2q2obDq3s1I/kofMXoq6xAPymKa/zHy/n59I
X-Gm-Gg: ASbGncvIJysz0AqnZ6FSw082dhvRlvaKXAz7ux3bcPTyawwU2rRlpdHTXPLR578T9nf
	XfzYI59rIvqV8UTr7+5B1cBkH0dHZVeEkRLuF1mSFG9ID1nV5SIGG5lZitjU3fB7W/MonrSXvBN
	ZSR5ZIfx5AUNBEhGq0WfbmeROos8Syj6SZ4MIA+UmVvch6fDTOPVGYp2B+9LGYvLRpKM5cMLf/I
	NeFhR85GAjPcLB86LrbK1RcBy92n27iFyZhPVE5qC4XQBvSY/iapUwggbAueNuo283BDhsvAnZ1
	e9K4p0uS8nmXKWELjA6nPaiyC7zIVYGkE7M=
X-Received: by 2002:a5d:5f45:0:b0:3ee:1461:165f with SMTP id ffacd0b85a97d-3ee146119demr1602973f8f.31.1758212379952;
        Thu, 18 Sep 2025 09:19:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3PnU0tA1p+umFkE5BXiLm4CDiDfRh2pQLB+Ug4+MdhzoDSNOstwjT9AY/VoIif+xcobxEvA==
X-Received: by 2002:a5d:5f45:0:b0:3ee:1461:165f with SMTP id ffacd0b85a97d-3ee146119demr1602954f8f.31.1758212379509;
        Thu, 18 Sep 2025 09:19:39 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613e754140sm86493805e9.21.2025.09.18.09.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:19:39 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:19:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: stable@vger.kernel.org,
	Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
	Daniel Verkamp <dverkamp@chromium.org>, Amit Shah <amit@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev
Subject: Re: Backport request for commit 5326ab737a47 ("virtio_console: fix
 order of fields cols and rows")
Message-ID: <20250918121858-mutt-send-email-mst@kernel.org>
References: <f839e710b4ede119aa9ad1f2a8e8bcc7fcc00233.camel@gmail.com>
 <5a9aa16aafbcd8235a70f25249b94de6a897fc14.camel@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <5a9aa16aafbcd8235a70f25249b94de6a897fc14.camel@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aE2N2fpyLow0boEi04l5PizVlAzOW7uA3f2mJylsqqQ_1758212380
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 18, 2025 at 05:58:55PM +0200, Filip Hejsek wrote:
> On Thu, 2025-09-18 at 01:13 +0200, Filip Hejsek wrote:
> > Hi,
> > 
> > I would like to request backporting 5326ab737a47 ("virtio_console: fix
> > order of fields cols and rows") to all LTS kernels.
> > 
> > I'm working on QEMU patches that add virtio console size support.
> > Without the fix, rows and columns will be swapped.
> > 
> > As far as I know, there are no device implementations that use the
> > wrong order and would by broken by the fix.
> > 
> > Note: A previous version [1] of the patch contained "Cc: stable" and
> > "Fixes:" tags, but they seem to have been accidentally left out from
> > the final version.
> > 
> > [1]: https://lore.kernel.org/all/20250320172654.624657-1-maxbr@linux.ibm.com/
> > 
> > Thanks,
> > Filip Hejsek
> 
> Sorry, that patch might actually end up being reverted, so please wait
> until this clears up. We are still debating whether the Linux
> implementation or the spec should be changed.
> 
> Best regards,
> Filip Hejsek


OK I sent a spec patch to make it match Linux. Let's see what is
happening.

-- 
MST


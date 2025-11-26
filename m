Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A526D30C611
	for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 06:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764138477; cv=none; b=Yxq7DI6lsxEPiWDEezFNxasgREfpVuCZqS8+r6/fXcrrPkBKTy4UHNBcJxbObOPDJtKBvWA5PSJugfAdSNPGUdBo7Q+0+tYd2Z/9W1tFRs+U+xPsPVLfh+lvTmBRWoTnOTkWE5aDjqkoWm3G8bEWKglYhFPMkKN7Nm21VJWFFZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764138477; c=relaxed/simple;
	bh=6GBox+U71wd52Kw2/PdLyqreoI+ktndyD42jWbX4uFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iUYaeU2kQHwTRMgQtUvSLVANksXTPgLrqXylhaVLaK/cpGqSknucuRneBuA5bDZAKG4+sMhcg2NicT8hneKGBXtKkeXnPpTI7naQdTnXcGI4C33L0TFoq/EuMYQx79EXYbJb85voj+FEblPak9EBGD1dEJwWdz/K4TS8IY8slsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OcuGuJyr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OcuGuJyr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764138474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ARxIA8tdQWb99qoXW28PLnSr1NCprmRt1PGWJHnjSzg=;
	b=OcuGuJyr91W1OUNQQkOx7IE8HIxXDAfld9TaMtqqp0Q1zE1ZVtppn3GPSezPPv407B3Sru
	J7h3q7nQ2/1q+IncrqhVkivL91qOT3NcddnFZxOZueJutCUY9xhuskUBDfYMl7ocqh4+T7
	tWFjUvqcISzLLirqEoa6sHaW7N4A320=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-iQIc2btePJeU5N81cR3E5g-1; Wed, 26 Nov 2025 01:27:53 -0500
X-MC-Unique: iQIc2btePJeU5N81cR3E5g-1
X-Mimecast-MFC-AGG-ID: iQIc2btePJeU5N81cR3E5g_1764138472
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso39207505e9.2
        for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 22:27:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764138472; x=1764743272;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ARxIA8tdQWb99qoXW28PLnSr1NCprmRt1PGWJHnjSzg=;
        b=H5QhHZxEFygkPZH4JtfTTQcdjmn2nC4DwkMbsDkYOPu+8tx/e6RB2YV34qGrNcyg3M
         KniPQodZkN1hyKdsWEh8m4gLvRQnh1Zqs1dCDgCmM5WM1yDRxCEE4S0Af4uFi6c7RKtV
         0iiMDy37Gsrcd4CpQXRdYrDpbQtXKwjz+UmF+ljd6Ln305kzUNYH9ho00NHU8LPRjQZn
         N6NR4/p4zTSn7k7cLy40GoyFGjZ6Cyyb0213co47Q/LsDwXjjznkNGGPMG4XsS7AxN76
         H4sgtE1WQpjc6Ib1nyUfY3jx9Njc6E/VrTeQ8U+tcRRG80fLF2hczi3ISsTuljG1BYhr
         YthA==
X-Forwarded-Encrypted: i=1; AJvYcCV1OdZzqD+yk79nDyT7XCWO69PKfsSdbVwaDFrBQkew66nPtDKB1QEZlw+dds33IJVU/AhDnKH9qkcQPdCeRA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7pSekmwcjE+T1JCPq63v4ILEIBWRf8henGYgbVWp99SL8M64s
	gbjP6wd5FlkzJRMeChq0p7/u0meimUkJguMXMcE3v38G5z5q/Z39+W+imrcyVnkfA5carhRlh6E
	z3V8L7ScbARmEb11qejfm4wl5UBUI8RGxX/+6dXPIpbs5fWxrL88+2pydxPtFICQhnGNw
X-Gm-Gg: ASbGncttNF/TbfUE1PYZHfGk5M/ffiSKuafQe/LpJ1gu9yKGK1x+MWLtXWdPw1ZCzWt
	JjozZIqVsBqwo8bpvZNozMtJ5CDflYbCJjGFqHxCm5nWwyvR7ov68+VED38p7Z1Xx7TWr2aPnzY
	eUKu0N5SO1qPzgH4QxSwoWpdsSvMCKy++bHVEGuBTW4R4EhKSpcXUs/qFCBh3rCh4xNqakIkLCF
	9aZpTPdY9iIsu5jTtHiyndiIuN1CGQNlt9NpzXeom7SRRKQwUC+VmfzBmLNS6nrd4FjdSGCLl32
	BtmtH2kxffPccHe42NfIvipy0TzkY79D2RLd4BKxEyUY1055MgqFju68D7sZNMocY4o8SRAnedd
	BHm8DYPKh738aw7Xt1nIFdifpHKc9rw==
X-Received: by 2002:a05:600c:4443:b0:46e:53cb:9e7f with SMTP id 5b1f17b1804b1-47904b103e2mr53915435e9.18.1764138471842;
        Tue, 25 Nov 2025 22:27:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0f1u0T3jzKYGdUCWINkcBdum6zqYD5lZ2uzy8Z3cJxh7vJamCVyKXR4UerdY4GLIpXEKe5g==
X-Received: by 2002:a05:600c:4443:b0:46e:53cb:9e7f with SMTP id 5b1f17b1804b1-47904b103e2mr53915225e9.18.1764138471351;
        Tue, 25 Nov 2025 22:27:51 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790adc601dsm26881835e9.1.2025.11.25.22.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 22:27:50 -0800 (PST)
Date: Wed, 26 Nov 2025 01:27:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, eperezma@redhat.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net V2] vhost: rewind next_avail_head while discarding
 descriptors
Message-ID: <20251126012023-mutt-send-email-mst@kernel.org>
References: <20251120022950.10117-1-jasowang@redhat.com>
 <20251125194202.49e0eec7@kernel.org>
 <CACGkMEuCgSVpshsdfeTwvRnMiY8WMEt8pT=gJ2A_=oiV188X0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuCgSVpshsdfeTwvRnMiY8WMEt8pT=gJ2A_=oiV188X0Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VeNAWUTDIBrXhrs6452TXor9Mlo5qZ1as4vivtuJz7Y_1764138472
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Nov 26, 2025 at 02:18:25PM +0800, Jason Wang wrote:
> On Wed, Nov 26, 2025 at 11:42 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Thu, 20 Nov 2025 10:29:50 +0800 Jason Wang wrote:
> > > Subject: [PATCH net V2] vhost: rewind next_avail_head while discarding descriptors
> >
> > >  drivers/vhost/net.c   | 53 ++++++++++++++++++------------
> > >  drivers/vhost/vhost.c | 76 +++++++++++++++++++++++++++++++++++--------
> > >  drivers/vhost/vhost.h | 10 +++++-
> >
> > Hm, is this targeting net because Michael is not planning any more PRs
> > for the 6.18 season?
> 
> Basically because it touches vhost-net. I need inputs for which tree
> we should go for this and future modifications that touch both vhost
> core and vhost-net.
> 
> Thanks
> 
> >


Well this change is mostly net, vhost changes are just moving code
around.  net tree gets more testing and more eyes looking at it, so it's
good for such cases.

-- 
MST


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB24B3E5A20
	for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 22:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792361616; cv=none; b=Owl91gcDfJpba3t5MiuLaRIMi+KYbEkwV//Er/IPVXB4xmTJc8RB1F28BTjzxFYiMFRSGHBzzDxnpdWuk0YM41ia9+erGW12ro3igejQjF+zn79JcMVYGsKlZrsvLYk6zOtn1w+JUSmQSf9sThzVudjBJjfP7W4Qgr75YynVDFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792361616; c=relaxed/simple;
	bh=JBnh6g8/khXfo/xjv3nRYstO4SCCAW5vzbTZ2OoUIp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PFrqMIYWMySwa2ECwYoGKc985Rdjoq/ik2HxuhPW8hZhxraTCXOtLcP15FoiG0/Llc+R1tjaHZ1vO8M2Mu8KtIalryPqa/2xZxoDwEtZPsoBuV3zCR4IjaSrvcBiMGtJ6MOjEXJ9z6cIr0YPI0W8tuvXl9Nk30i/PV8XwNjIe2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsLpHUv6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsLpHUv6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792361614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D2nWTmEzSlPTSS6/bv2DXBvJ1IMAaQG+TiNBhHr6z6k=;
	b=gsLpHUv6XRn7KQb2DbuEhMEV3nhOb/rQk+DoA4pjYS0Iw5sVuo16T4nEk0HZIBNtIUaYbj
	E2J47yTC4/R+IlflrVA9rrGeO86tUOsyF8trKct0jn7dd8sVH2V+sJv8aMmH5uF+Zo5BFz
	Qj4jLTJyXwF53IqbiQwPVLcFXgRg6Co=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-YDT_r1LkPE2nAGU2B1j0Ew-1; Sun, 18 Oct 2026 22:13:33 +0000
X-MC-Unique: YDT_r1LkPE2nAGU2B1j0Ew-1
X-Mimecast-MFC-AGG-ID: YDT_r1LkPE2nAGU2B1j0Ew_1792361612
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48dfdc0f491so725523f8f.1
        for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 15:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361612; x=1792966412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D2nWTmEzSlPTSS6/bv2DXBvJ1IMAaQG+TiNBhHr6z6k=;
        b=Lo5BE4yz8Jco3vaKjmyiKFILUM7TeLAc5pEe1DmahgEgi0Z9h89zHlouup4neWQLms
         7hiyawgkBN6c4srMeXOFM71MS08kBmXgTl2bYJu1NFVHa/VKDDivye697rm/dLRk3WBt
         INGkY0pMpOuc14K4OIBaZP7RvsgpyXpvsyRWtM4bgMYwee2EvZcKqaf3AHP5D0yWAOKT
         LRs9Q65d5o8rYgtAMqEUE6w7bL7xl0iSXi2nfqh4YsrzR9vBUIbxFkGbP1ACfXUK1kcA
         6/P2L6u4loOYmNE1XZh98caYGSm0uboif6pLYfty4Z9RXJFUo/Khz8sLhdNPmG0ak0Jd
         JHUQ==
X-Forwarded-Encrypted: i=1; AKwUvBya97akJSCNS0KNXFyNWyT4a9sT6ri5lnC7x5J94+hGbAbPIh+IQ2TeYwH+6uGowBfGHUSeCc/WMz/yCccxSA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIF32ldBBK+6uUWfmCa9coRhP29rorTYAwpt4E7YfKw+edWNI0S
	GtsctAK10/KGxHP4XTrbjrShRF+2fwz2bujJd3ooNKnzlK/+OGA2R7bhxuZV4ZY/bTDRQFc7giJ
	FPXS6lv7dnppHKrYCdH41S+MK0/9BWN7no4DfoHdesWpvJVqHU/SdHdw9FUEbDu7Xkw/1
X-Gm-Gg: AYBFou1T9cBptExTwdAGWIyh7k+mDHA/18UWmifCmHgQqkAcQeU85JBacFKt0oOZ+ER
	ZY7gU242E6Etjq+b4YB3+N+lkLVFCvPnY/VMoGb+llxlGzphsxRuH/MOsK2oIz6YEVndYVT4/u1
	HgFZLf7QrOjZxhSGZ2ILKvlz3FLdY0RG9rz2+XtqkqRIor/4k4tNTp234WTU801PDD1c6MNHlka
	DDJpfmxjdUVCoEGmQkFT2zCG2AuTHl+b5DaDkrA2jqANDvbRJEVlfVv1lPpdH5fhcW9QOkIW8kT
	LWu6Onq7YzOV64KWlF/jgA4duw7XDcICFqz0UQhdpwUo1GgsWvQ/C2eFdCDMXnsT6b43xg==
X-Received: by 2002:a05:600c:548d:b0:4a1:e250:b191 with SMTP id 5b1f17b1804b1-4a1e250b1c7mr52451165e9.17.1792361611683;
        Sun, 18 Oct 2026 15:13:31 -0700 (PDT)
X-Received: by 2002:a05:600c:548d:b0:4a1:e250:b191 with SMTP id 5b1f17b1804b1-4a1e250b1c7mr52450995e9.17.1792361611317;
        Sun, 18 Oct 2026 15:13:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471a72sm20914904f8f.4.2026.10.18.15.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 15:13:29 -0700 (PDT)
Date: Sun, 18 Oct 2026 18:13:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Haoran Wang <haoranwangsec@gmail.com>, jasowangio@gmail.com,
	KVM list <kvm@vger.kernel.org>, virtualization@lists.linux.dev,
	Netdev <netdev@vger.kernel.org>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Security Officers <security@kernel.org>
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261018181202-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <20261018204838.4080b238@pumpkin>
 <20261018175347-mutt-send-email-mst@kernel.org>
 <CAHk-=wjneFJ7XmZ6ux-LsHq4apDgANcKfERztmAG9sGVY_TxAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjneFJ7XmZ6ux-LsHq4apDgANcKfERztmAG9sGVY_TxAg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2oa9PIlPRtRinm9OWJCEcGa57A_YQuWa3I24zKTxk2U_1792361612
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sun, Oct 18, 2026 at 12:06:36PM -1000, Linus Torvalds wrote:
> >     > > +
> >     > > +           if (!access_ok(uaddr, sizeof(*p)))
> >     > > +                   return -EFAULT;
> >     > > +           ret = __get_user(tmp, uaddr);
> >     >
> >     > Can't that be a normal get_user() call?
> >     >
> >     > David
> 
> 
> >     Ugh, actually no. This is called under local_bh_disable.
> > 
> >     get_user would splat on might_sleep.


> I[ sorry for html - driving around ]
> 
> That's a separate bug, and you really shouldn't use __get_user to work around
> it just because it doesn't check. 
> 
> You should use pagefault_disable() around the access. And if there is still a
> sleep_on() complaint, that should be fixed. 
> 
>         Linus


Thanks Linus, will look into this.

-- 
MST


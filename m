Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85B129E115
	for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751024563; cv=none; b=V+zRxkTk+nCWqOZsoJ9TAGRx38fUvLTdvhqRZ/VPQJIZZaFAUgaw4viqPmno5EULJ8nsZhtDh0ryALmZiLjACqxtpdemORrDiV3s7crX5n23SOkIGFxbwOgbhbt4ZSFesOmjZ94hYrn5XuW45ZHKvCJ+x3TzSxQY1Ng9yeRIWIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751024563; c=relaxed/simple;
	bh=iVuGRVgsqGxyCMlQcTQPYJM2XPrRXIKXOv3tNp4GTIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VjIDNq6/y30tBz2sAqKBmz4wZ6DKxCpxYjSZ9VQb6hDTa4uiKXoHrCdvpX4TUDGa7N8d7E+uKA3Uv+OnvzKFlV2m+GOQLDDCgkHIhW39On4YrZPvZWjqsO8xZuQdghO2md5rXnTpaxTwz9fIUX63POTY9fIYG04vbHyTmuLVpAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLyVJbz/; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLyVJbz/"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso2007847b3a.3
        for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 04:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751024561; x=1751629361; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9YtTg1t58ZELtcEG/y0IgZZ/473yKqIjgodQWzu/94=;
        b=RLyVJbz/Ndcpj5/jBTQae4m1ew5479RjjtyyDecwJGP1fYXHpYU7vr0DxqZgWvSmZX
         ZUNGZ1E+NNrlM9PYGinvZhRTDrasjMYBGqLtcCN4YTIkxXCyEeqgnVoNSxuhZRTar0ow
         /OmOMat6/uduLjncHXTUpQWSru9FrG1TYjrXwBihvMvCTK02456Wqhqb2W7d/HnYnNdG
         +YyVVRUpqPp5kLL1Cv6JpwwjHfCr4LiP3lBhZRIfgIKaiBTnm2UfHKC+Mb9ECH+R7dnc
         XCK5mNmwjNMOJDuAiX/BCFPPvrXeQgEYa+0IPcNS222iaH2pE1byDnHLsubG2sETeXfG
         3ZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751024561; x=1751629361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9YtTg1t58ZELtcEG/y0IgZZ/473yKqIjgodQWzu/94=;
        b=OC/wxaTGKxsjgjYDNG9CiITUHG4tV7Ubs4gpeT4/JTf0yBXj6AK6HlkOOo1PIsHxko
         vj1moff9dFx2dc1gjnu3m8Eg+tUSqU6Bh0dixAtwt2l0XcxZKya2nnbYq5oatb7aF+dC
         VqhQ5BrQDC5xYaB9y706V2B6QJjRpHBD8Ka2k/w6e7JEmBPDMOCKPqA1TDGVFajC2Vv4
         Zdt2n5YVX6R4b2MR9F/pTuCCJ0/zxjGCBS08X95PKOfznA+ne2vqrjVTRkWlMYiZmLgE
         MAlXOxdvDMIB5vh6c+oYW/XXHEypVGaynw1c/kTuUoG7rLnYGz2sVZn/Bp+ZmVoqQsiP
         TGIA==
X-Forwarded-Encrypted: i=1; AJvYcCV81u5P1GL9cLLG4LWRpZ9S9UtWBodihp8kAsDahv6IoYPK6/wd0gWlr05pKsMu3lMDdxcF4awbQaWxZOhbpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzu5/8k5tcN6o55RguB0Eee9KfrjCN4jEkQaTay0Gr0YMeeMvds
	TC3E6+Z8movu8jMvPOaYYRuTq3dDNQAha0i9ChEQRKFZg6eafqWzmVfG
X-Gm-Gg: ASbGncu/p27TiTBP80FTOEw7PxgLEcnZlwU+mZjgKC1i5TEGm6rEFJUZS0IiaBFciX1
	l3V2HKMwdaDoNxWlDU/nVsJ80QjUnfjTbxL8Qd5f81LJAtO+FI34MlwcMfS/J3Tnucc4kvCzjrL
	Zrd37c+0OZHdhpGrRoVu/gO1pssBNDXVUEB7ZE6QU2AIVbaJSyVZ3xFnHfxDvHp86d9YUmo4T4O
	3J347Uro5caCaqasi3XA+9O/Swligq/v9eDCZ6wK+dw7eXN4gPr00BVF/6EbkGThBU/nw9JCb8v
	3xfaS0bQir3FgAv1GiDSgQtltEhgYyTrpwWeI1rBK23MFrUkG5wdFA5y6CRtxb1LeV2Yvy1ueTg
	cfw7E3air
X-Google-Smtp-Source: AGHT+IG3MYN2lSqPm1Q2L10kPTc5dlCvyMRnUX5hH47bSaJ12kP6xa/9UdmlnUhiVnL19oXKhjcflg==
X-Received: by 2002:a05:6a20:748f:b0:215:f656:6632 with SMTP id adf61e73a8af0-220a180a309mr4517364637.29.1751024560724;
        Fri, 27 Jun 2025 04:42:40 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5421c59sm2083067b3a.48.2025.06.27.04.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 04:42:40 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: decui@microsoft.com
Cc: davem@davemloft.net,
	fupan.lfp@antgroup.com,
	haiyangz@microsoft.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	kys@microsoft.com,
	leonardi@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	niuxuewei.nxw@antgroup.com,
	niuxuewei97@gmail.com,
	pabeni@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	virtualization@lists.linux.dev,
	wei.liu@kernel.org,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net-next v3 1/3] vsock: Add support for SIOCINQ ioctl
Date: Fri, 27 Jun 2025 19:42:29 +0800
Message-Id: <20250627114229.96566-1-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <BL1PR21MB3115D30477067C46F5AC86C3BF45A@BL1PR21MB3115.namprd21.prod.outlook.com>
References: <BL1PR21MB3115D30477067C46F5AC86C3BF45A@BL1PR21MB3115.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > From: Xuewei Niu <niuxuewei97@gmail.com>
> > Sent: Wednesday, June 25, 2025 10:02 PM
> > > ...
> > > Maybe when you have it tested, post it here as proper patch, and Xuewei
> > > can include it in the next version of this series (of course with you as
> > > author, etc.). In this way will be easy to test/merge, since they are
> > > related.
> > >
> > > @Xuewei @Dexuan Is it okay for you?
> > 
> > Yeah, sounds good to me!
> > 
> > Thanks,
> > Xuewei
> 
> Hi Xuewei, Stefano, I posted the patch here:
> https://lore.kernel.org/virtualization/1751013889-4951-1-git-send-email-decui@microsoft.com/T/#u
> 
> Xuewei, please help to re-post this patch with the next version of your patchset.
> Feel free to add your Signed-off-by, if you need. 

I'll update my patchset and send it out. Thanks for your work!

Thanks,
Xuewei

> Thanks,
> Dexuan

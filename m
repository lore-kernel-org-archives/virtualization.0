Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83A27F48D
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Mar 2024 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710850918; cv=none; b=VNzjeTNmACcisALh7PoeUNOmIpv31HJFUhB3Y5b7xmgeQa1hqDTo9SGUAR2F3MMUMsYtEqlqORszfEIXrdD/FGnomg8i6bJUXpJchALb1jlZDlgOmMpP4cKrE+94ZpTpdf1Prifjv63blDT5+BFKr78SKXQgKW6nHOwzXAU6/Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710850918; c=relaxed/simple;
	bh=qjqkqT8pZjwVcGcPOjT8S/YwSWCuV7Rv8qOtJCVbWUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oXP9dVUtLTHOXWDMuTt/BD6cnFO5Y0jtL0Ko+Ocgdr0xrHSPkylyJGOFAxi8f46xi19+egmEavrMohgJihjPk09Qr411ZRzRsvIFLaij/vdJ0j4reSfUrYP0x5v5jj2VtqVuzrPOfrSwlKzprodmhL+esvgEa6MzZnmUIxvtqMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W727OLu4; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W727OLu4"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5163B60AE1
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Mar 2024 12:21:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qUVXpE8Lk9uy
	for <virtualization@lists.linux-foundation.org>;
	Tue, 19 Mar 2024 12:21:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 90CB760AA8
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 90CB760AA8
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W727OLu4
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 90CB760AA8
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Mar 2024 12:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710850914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fcURuON76N2jBOBvhQi/fRmFrRjaRgELhmNbazWraRw=;
	b=W727OLu4y/6TQo9Xn7668FoOZwcRclkuXkBRK8FrYpvQIQeDWUebgR4arJ//k/HCOqAgXF
	uWzi6iHES4OtcSUocon794rHtR978+rKdEs4IITrbKCzv78w8Y2Yv2k4edM+GqlmU3E5hA
	XAaMjTlRaLkFtwDJYTyv6ORRgvKazIo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-GKTT4pfPOCClYmI-FWG6Rg-1; Tue, 19 Mar 2024 08:21:53 -0400
X-MC-Unique: GKTT4pfPOCClYmI-FWG6Rg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-513ec050f5cso1637546e87.1
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Mar 2024 05:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710850911; x=1711455711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcURuON76N2jBOBvhQi/fRmFrRjaRgELhmNbazWraRw=;
        b=OgSZI8ZQgRRS2i07rdRfFyquR1OVRxVjLYOlvvAqduO9AJqVHL7ysfdUUCBfbTa5/X
         2zYYH6oHnvIVnN/JqtQXfM+ks8XnhcrpSDMPZyzyyIN8DOxCldjPmlHIpZAtfUOXgWDW
         f5wGMBUbtStM1BarF96yKaniYEmMIKcrsJYPLpJaRQOCN1GksxDg6TSFV867Rm+doxO1
         IVRMl1uWXQeI2Y4iMZtZed+mMDHuhOzT4DPSQCDLlZqVCJ2M+3LuVmzGN5Y0EDY/nveo
         HBlsuJVCezay8eDFpdzO+QT20J0X2hoEXh+FiLM2fzXDplrVAvHBzY59engkdNcQeDTC
         0J3w==
X-Forwarded-Encrypted: i=1; AJvYcCU8HNkBJelV/r9xQ3yB3p092ZuVUUteki8vmnEtswS2xW7G75rnwh6nYywxzI7kcSv/2kSBoSZMpczR4l+Z99ql2IGgmgRCvt0/BtSZ4Q0vCRie3jDWBgJEng==
X-Gm-Message-State: AOJu0Yw/EDh4Ah2KW/QpUXR9wnqp2J7gOQzyr87e6cuAGdrMb0n0vW9t
	SLChqs3pwRmOS/slBk3DBwGkzS9SSfXZ4zhcF3i6itYQ59odnqU8e+MbpdpTlYgHf0ZBiDNMwgt
	8IdghsVuPs0FO5ZtKVmz1BMERuqZKdnbo14P/TZdO53TJgMr07QchDgdae5DeQwCXR820oUnG85
	7+e/I=
X-Received: by 2002:a05:6512:29c:b0:513:1e31:ddec with SMTP id j28-20020a056512029c00b005131e31ddecmr1778313lfp.40.1710850911470;
        Tue, 19 Mar 2024 05:21:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhc9xlMsZwNZSLJmLpjDngn3edaSnQJUFYnLMn1neznXIr75uSIGVCW6AHqadrgQY3NJEJYg==
X-Received: by 2002:a05:6512:29c:b0:513:1e31:ddec with SMTP id j28-20020a056512029c00b005131e31ddecmr1778292lfp.40.1710850910940;
        Tue, 19 Mar 2024 05:21:50 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id f2-20020a7bc8c2000000b00414041032casm442527wml.1.2024.03.19.05.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 05:21:50 -0700 (PDT)
Date: Tue, 19 Mar 2024 08:21:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, david.marchand@redhat.com,
	lulu@redhat.com
Subject: Re: [PATCH v7 0/3] vduse: add support for networking devices
Message-ID: <20240319081938-mutt-send-email-mst@kernel.org>
References: <20240109111025.1320976-1-maxime.coquelin@redhat.com>
 <f25f3c31-c793-4743-a587-0e2063dc2d65@redhat.com>
 <20240201033944-mutt-send-email-mst@kernel.org>
 <27d1fc65-14d2-4a1c-b1fa-c3250ac2356a@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <27d1fc65-14d2-4a1c-b1fa-c3250ac2356a@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 29, 2024 at 11:16:04AM +0100, Maxime Coquelin wrote:
> Hello Michael,
> 
> On 2/1/24 09:40, Michael S. Tsirkin wrote:
> > On Thu, Feb 01, 2024 at 09:34:11AM +0100, Maxime Coquelin wrote:
> > > Hi Jason,
> > > 
> > > It looks like all patches got acked by you.
> > > Any blocker to queue the series for next release?
> > > 
> > > Thanks,
> > > Maxime
> > 
> > I think it's good enough at this point. Will put it in
> > linux-next shortly.
> > 
> 
> I fetched linux-next and it seems the series is not in yet.
> Is there anything to be reworked on my side?
> 
> Thanks,
> Maxime

I am sorry I messed up. It was in a wrong branch and was not
pushed so of course it did not get tested and I kept wondering
why. I pushed it in my tree but it is too late to put it upstream
for this cycle. Assuming Linus merges my tree
with no drama, I will make an effort not to rebase my tree below them
so these patches will keep their hashes, you can use them already.

-- 
MST


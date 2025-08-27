Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315512367D9
	for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 10:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756291765; cv=none; b=sUP4FV5gpjgT+r+7XvmKZ2OZNJcekUrhD++ntZ7+BUA7FzmrMyeRgKh3Rvxmlgx08GKnN67xv/rB4lxtKvKlBepoosNfKSZFnHPLsU4VOuAP7za9CLdNNzkfz6Ll1KMlHDfAeR02fme02MksgdS9Hys64vEfnjKJGrPAblQO820=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756291765; c=relaxed/simple;
	bh=IC7fCUvyHICjYQqihsUvTpBaupm1KvP3zRZoT8zc5As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ee1AQSkjAC7mO7v9UBnlJySPyDV5S/yjeeU/TmkIqnuCUGG980TRmlmBFhOesFcpTQtpmi8AZjcOiUnsvYwEVYwOj4ZzJ5/NNPi15e+zEfX59cnDElcdxlSEoJl0wzSTdYLF6fMFif+UntY88jPDaYTSQq5ZtyM458EkwDx6ef8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=beM2Q4Sw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="beM2Q4Sw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756291763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h5RFPwfFP+Eg1oHSanrF7jLQgxXPAmT3vCxZYmVFSSs=;
	b=beM2Q4Sw+uwef4K8TFdI1B1+/M/Q5UufuPq9dj9ZNzUJ3xfHCheD0WAAM5EjvizGEqAV8b
	Z+A9w7pn026ZKCTpxzYZJmSzhiyMjucD3KkIo+D3Ks6IiUG24pLmf796ibSnHXtlVlQYhc
	akkzG0Qnq/pZ8kiW4ryGuSC5vsnLwwo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-huYkhmkZMZuwQDnE4HG26w-1; Wed, 27 Aug 2025 06:49:22 -0400
X-MC-Unique: huYkhmkZMZuwQDnE4HG26w-1
X-Mimecast-MFC-AGG-ID: huYkhmkZMZuwQDnE4HG26w_1756291761
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3c79f0a5bd5so2968362f8f.0
        for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 03:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756291761; x=1756896561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5RFPwfFP+Eg1oHSanrF7jLQgxXPAmT3vCxZYmVFSSs=;
        b=e7iNIJmf+FF8sXQIpQBbI3hA56yr2RplHB2UXIV7xpn5bDx+8Py2k65JfOoYndJXsG
         u1Nf989ma4BcMjkLLo5f9nrHSHH56wqpA2WG2xTxLW+npdgsFMgltbyvO4WuV0p+hHAf
         PhQTIOUGydY/NhVrHO2HkvrIj0hbWgT28EN5RsMlouKtdQMgdv93kDQlS7XAX96blCH6
         IHuuwafymEL3trUSCzwLUN5p7HWBCrTEBNDdK9OkCha4EQNuQ9ZgNDPvihfMx2eyIwMf
         /wiFtXzxZIWQXFjwtS8Tu4J35oEDTR4aiEPBCQG+5shabCDYdKob/PrxTEA03hJgiAwb
         2GqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHjmnX3AT5vKNzbBB51C2fMWJEvHXViQSSoUvS9VSnykmnJfYh9zfeBZIdD0m4GsVX09btviJz0Siz9yXapg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyf66Bb3RPEzgbvDok/siYVsg4pcTvMcXIxvXcVBypoSuV8NnOZ
	hhF3gSuQxfU+iOcjj06kROYzAUsgWrFqHl3XvnNRfPohHZEx/Po8FXS3HdgnomIIe43pOrbUpCb
	VFMq40jY5yNfZhV10VdPm20Z65tA6qtI1plZoXKC2IHDEFIVRLUQUe8St1U7AgGwaOC96
X-Gm-Gg: ASbGncsN1WvXFowCQy+3Sswb3GRjzoUCVamxYM+93ZjQC6xVRCwxui3H07lhE3nJduH
	z3j2NKyjJGeg44diHh5Hv43UMIYxvLhjWyiPSaOJkFwWvdN3snanJEJwhhbB/i23Ar9AFdsa6KD
	2ImMajw2u9akiWBXSlQYkBEJZaACDqyULFwpmYCJJjirGuASpOmM7d+l/RAnS4hteckezrTS1lq
	qjbwZ8JbMSI82q5ZVWyrpXUec1Z3KGjpRHvDkMuGncWL0XVMg1cp1h0R1dr/lHXuWkToHA5V+fb
	pS/qEcl/bo/RXGcYzYgzNnSES1uOmY0=
X-Received: by 2002:a05:6000:250f:b0:3cd:6477:a3ad with SMTP id ffacd0b85a97d-3cd6486e9c6mr178774f8f.26.1756291760797;
        Wed, 27 Aug 2025 03:49:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf0+K6BppvH8Hb/OqhP9C5oAmG47R8bj5G86xkmW64GR6L8venV4qa54EUuuubVB9HOzRqag==
X-Received: by 2002:a05:6000:250f:b0:3cd:6477:a3ad with SMTP id ffacd0b85a97d-3cd6486e9c6mr178741f8f.26.1756291760292;
        Wed, 27 Aug 2025 03:49:20 -0700 (PDT)
Received: from redhat.com ([185.137.39.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cc98998781sm2603758f8f.49.2025.08.27.03.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:49:19 -0700 (PDT)
Date: Wed, 27 Aug 2025 06:49:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Message-ID: <20250827064404-mutt-send-email-mst@kernel.org>
References: <0cfe1ccf662346a2a6bc082b91ce9704@baidu.com>
 <CY8PR12MB7195996E1181A80D5890B9F1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822090407-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195425BDE79592BA24645C1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095948-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71954425100362FBA7E29F15DC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250824102542-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195EC4A075009871C937664DC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250827061925-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250827061925-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SMQigxq3K7VZLOdJUqiGkz0NhEKaR8K8dxG8Nyl11Ug_1756291761
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 27, 2025 at 06:21:28AM -0400, Michael S. Tsirkin wrote:
> On Tue, Aug 26, 2025 at 06:52:11PM +0000, Parav Pandit wrote:
> > > > > If it does not, and a user pull out the working device, how does
> > > > > your patch help?
> > > > >
> > > > A driver must tell that it will not follow broken ancient behaviour and at that
> > > point device would stop its ancient backward compatibility mode.
> > > 
> > > 
> > > 
> > > I don't know what is "ancient backward compatibility mode".
> > > 
> > Let me explain.
> > Sadly, CSPs virtio pci device implementation is done such a way that, it works with ancient Linux kernel which does not have commit 43bb40c5b9265.
> 
> 
> OK we are getting new information here.
> 
> So let me summarize. There's a virtual system that pretends, to the
> guest, that device was removed by surprise removal, but actually
> device is there and is still doing DMA.
> Is that a fair summary?

If that is the case, the thing to do would be to try and detect the fake
removal and then work with device as usual - device not doing DMA
after removal is pretty fundamental, after all.

For example, how about reading device control+status?

If we get all ones device has been removed
If we get 0 in bus master: device has been removed but re-inserted
Anything else is a fake removal

Hmm?



> -- 
> MST


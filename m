Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E5227CCCD
	for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 10:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756290093; cv=none; b=taY3yg5t6ktawlQua8fTVVG2hP44GHzvu0Bhcr4Z7FC3ephYahzgTBjtzmRXUOdKLH6CoC3GEJL3qloqpuI8szeD9LaxGiVy0RBsoSAOKhlj2u7L4M59F1MG2LNQlFOUvMkDdSkds06LxBCqkKOrgho8bzgc5bY4hKwVn2GsWFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756290093; c=relaxed/simple;
	bh=esf3pW05M6lYQ00AimXfav10o9MWvvAhi0ueNrtACRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eeROmPQ9CpVahvc7Q7gNn/2vTBMQVQkp4llIqfREyNeqWCC4PuKgL5t0Y6USetHmHJ0qOMSM9Lelj+Fg/oVePVyfzD3pyOloFlwRKW++tkwul9mNnrUsIQZll6GyrzfB0cMqhHxDzLyBzqr9F5ha/zD0gQLBYWoWTVzULv/RREs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YC2tYQqN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YC2tYQqN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756290091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XyxfiCP+1G5kZ2DAEzfezCwimO+RIme3KfTRPyKTkF0=;
	b=YC2tYQqN37p4arIPqRFMFlPq+wdo3Y2+pqaVdKjFZzVHugRaQLUZLv9fNmGWeaZ40xtAuj
	hICRM0HJva5vjGbhGcGEF4LVZA6dj3B2ggVKoltIN49l1KDToAHWVZrIyTSaCHHDZYKCCM
	KI2TwIU0F+dxxiLABu5wF5O0PlTeywo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-mbewmU2VOdS_OKZB_GzSzw-1; Wed, 27 Aug 2025 06:21:29 -0400
X-MC-Unique: mbewmU2VOdS_OKZB_GzSzw-1
X-Mimecast-MFC-AGG-ID: mbewmU2VOdS_OKZB_GzSzw_1756290089
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0071c1so35053095e9.0
        for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 03:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756290088; x=1756894888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyxfiCP+1G5kZ2DAEzfezCwimO+RIme3KfTRPyKTkF0=;
        b=dnleK8WWA1j1NhPefBeE2JPW4hWL154LCtCwlT+Ss4N7Z7U4oKIMGMI+j4rLQasMQJ
         F7E11G2Xs+xVOI1bs8xu+ZgiI2XAdcOLplwb1VyWqbreKSY6hfp6FamFLtufEi8qkBqc
         iI4M2r68P4CdZ5m1masKR57fMozFHI51mf7xJ3pgIP+WFDQfLJyCovoMzrNQU8UGC8ws
         nYgagBArJ3IpfoDi+bHunFHXJMCFjno+VOS5EvbazGmZ0Bc3fEYbn5ZQ+wQt8aEI3gcb
         amBlo8R5UqcusGqvd3KYIBxe4Dt50YBAXn4XGXEaeJbgc+PDi+CkMZ3khiE5gSHUChv+
         SEtg==
X-Forwarded-Encrypted: i=1; AJvYcCWVhUtZLYRzBiZvUDnJEqJq2BHB1Kx+DA0WzlecFCrrz+MBvfj7lepaIX87VGFwL4wGObt1HQjvCfK103Zx2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdJhW9sZl+a1bK9vT1qwRkXeaF2O6zKWyDLm72BDxrsia+WQsQ
	9HkcECAMailUfV2c/2nnOmm10v2R1My+rbV0dYcXQXhstxw1zL0bUGukRKKosnEYcPppV1/vf2z
	wiIDrulhSTB0l7a8r+1y5eltb54RSmNi6ayrN+qsi2PUyt/bmKrk8s2trOZ1yErSYtCvZ
X-Gm-Gg: ASbGncttFTYLwXTo0JfzxjAlgbrHsVSC74dpjrQ76iQlh/Y8HM8ka4hpCNkXAUzimnE
	W6lD3XOgCFYrEgDKzxiYXa+1tl5yxHlfh6zUrJeoNpm6yj8VJUWL/FUybZpTyLLNjGaIQNDCh29
	DKLxnWkgecVDQOaNdj/HyNVRzsMEu8Vm0Hi+GoDRDoMyUi6z8mUyAt+06kk/6lbivCOkgyVXm05
	l0oO28fKCrK9YOJ5M25k4AOket/ttDhr4SBvvYta07ngilIZMx6Rgt8NVwKjxfj/tC6e83pPOUS
	Qi8QAbd3P+hgkJnG0kj822I1jDLBLQ0=
X-Received: by 2002:a05:600c:3b25:b0:459:da89:b06 with SMTP id 5b1f17b1804b1-45b517b008dmr235285195e9.16.1756290088580;
        Wed, 27 Aug 2025 03:21:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiT33UYG85Zv6s7SgGE8Jo4L0oXbrtqo8q2OpqMIxgaNeeaSUd15eQcfPIlw8qzssJ22sbDQ==
X-Received: by 2002:a05:600c:3b25:b0:459:da89:b06 with SMTP id 5b1f17b1804b1-45b517b008dmr235284755e9.16.1756290088122;
        Wed, 27 Aug 2025 03:21:28 -0700 (PDT)
Received: from redhat.com ([185.137.39.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cca0dd7014sm2437932f8f.13.2025.08.27.03.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:21:27 -0700 (PDT)
Date: Wed, 27 Aug 2025 06:21:24 -0400
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
Message-ID: <20250827061925-mutt-send-email-mst@kernel.org>
References: <0cfe1ccf662346a2a6bc082b91ce9704@baidu.com>
 <CY8PR12MB7195996E1181A80D5890B9F1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822090407-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195425BDE79592BA24645C1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095948-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71954425100362FBA7E29F15DC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250824102542-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195EC4A075009871C937664DC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CY8PR12MB7195EC4A075009871C937664DC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pSpx335KWMn5cgKJRg4kjJtV_EgP03cjnpBTRp1UP3c_1756290089
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 26, 2025 at 06:52:11PM +0000, Parav Pandit wrote:
> > > > If it does not, and a user pull out the working device, how does
> > > > your patch help?
> > > >
> > > A driver must tell that it will not follow broken ancient behaviour and at that
> > point device would stop its ancient backward compatibility mode.
> > 
> > 
> > 
> > I don't know what is "ancient backward compatibility mode".
> > 
> Let me explain.
> Sadly, CSPs virtio pci device implementation is done such a way that, it works with ancient Linux kernel which does not have commit 43bb40c5b9265.


OK we are getting new information here.

So let me summarize. There's a virtual system that pretends, to the
guest, that device was removed by surprise removal, but actually
device is there and is still doing DMA.
Is that a fair summary?

-- 
MST


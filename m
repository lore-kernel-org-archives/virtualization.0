Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EAD1D63D5
	for <virtualization@lists.linux.dev>; Thu, 13 Mar 2025 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741891750; cv=none; b=d4Ssk/7Tt7XR8KslGe6TAdr1irfzumcQeFDshIPLUIqLiry7KI89k+GHi5ICIO7/gFV8RoYrCGedqRdk81dbuIF7rArMkFXdzno7BHNBUn5PCD0v5KOIL0Nc0l+b/FhizObnjwyQQSGfZXH5sOhAx+B/eC7nzfp8nn2nF2pnWdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741891750; c=relaxed/simple;
	bh=vGaveTKeKgCxAmnC9EQ4sn2CMv/qBrgjuvuYfa1RVkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dTLNny7v11sgnfvNen3t8IZ/F00jJ+FUMET8+pzvjD1DJQa8kYI2Nn9EkZ5U71XwEAfVp13J7piZz5nK5hmci6u3rOVd8ZyyXys2OS88WE0YqEPvLK4R/LWlkxtPmLI6GGh6AgXw3MxWCvOdWDXq0uaqJzaVklURT7mnx9R6H20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OsR2FsKb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsR2FsKb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741891748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9aZe+iaudDpMDo0mPe7/sxlSIcMfnUdZ2EM2OaZ1sk=;
	b=OsR2FsKbcKOIQ2NO4ex2AUaP5RsapStbiaazWEwSaJI3x0ur/4z7BSVRJy4rBGzCH0efS8
	1snKELsbtOIENb1Y8N+LZNabBmNlKE/rr1rAK4CKRTF3UpzOGvTeApt9FD5H+OTL1WSEqJ
	qRjLccObvjzXHRfrobdaIctnzZokzug=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-UJWAnH6BM9WWUoIKvHthXg-1; Thu, 13 Mar 2025 14:49:04 -0400
X-MC-Unique: UJWAnH6BM9WWUoIKvHthXg-1
X-Mimecast-MFC-AGG-ID: UJWAnH6BM9WWUoIKvHthXg_1741891738
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf172ff63so6540835e9.3
        for <virtualization@lists.linux.dev>; Thu, 13 Mar 2025 11:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741891738; x=1742496538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9aZe+iaudDpMDo0mPe7/sxlSIcMfnUdZ2EM2OaZ1sk=;
        b=wNW4KqmpAvnd+a6h35SJxd+jpYpE/2PvLkR9y556vvzrToSGEzttYrkrAG3GZBa2Nh
         irEDdL+gznpur5nvuMXL/4wI3NiJCDSlAmOqLxiqt6+b9PheoMfQxxD4FehGjtjkTmbI
         DdsQ9Lr9f2CsP0vaL7P5Try07IkroYRovP2IKdHymzCWDNottJaBcHrSJlxBRc5GaikF
         qH5TlRsU/xDyMFmDv4Wuzbtcj/zCKRKycAu0vczP7IC1hTrzTjDGSljIJjrP2wN4rfQT
         bU95kboMMfaG31e4RIjPWKve9jFXCLhgCryrcfElPVSyPFz447O8/pDqiPZN3xGi4dJY
         CIGw==
X-Forwarded-Encrypted: i=1; AJvYcCUY3C/4u7NvbOvWZ/EsWtkZiZX+T6jwwU+HvFPiKh9eSLrEB3MA+CzarD8XUpzV3jUcNXXZTTFisU0x3oZfhw==@lists.linux.dev
X-Gm-Message-State: AOJu0YysZAaJutZxMVaHPVXpaEdp28Ho9KSGzOdzgyYHGBlr/RlxXkoi
	3HWuU49ioZzLxIwbyAWF9FZNAfR8SDO590QCRvAUNADpgLSTGWMrsqhfJqMNWkm7HcNf+E1vYNr
	2TslFZf1O3Q5BQM+Sn3PKcgTStgZQnK0uIaIPcfgX/BkImb1bFLK0TgPpWsOi+zzb
X-Gm-Gg: ASbGnctmH6gPAiq/fVMYP7DOGN6Yq/DFJwRoQ4q+ww1DIDslD+R7urbyA1Vd8tRDXQI
	dj2n+3RcHY4kZ677xGowI8hWLZFmkN9ErH7HNvuNX6izMOFcREmWcEEHk7F32Gt35w2AvSRNjIT
	i6TpZ+1pRkNdvgJwdBz7DU7WFyjFF3AHcZuAJf/UUnUN7/AjWWS9Tui438BcCn3D08RNDAOn0Qf
	v3R1YTtEYrkiLhrd/2xlEWV8A3sACO2WoTAa43TDemS05ajujgWGN+Zk4UB4r1RsVPxoV5gg/Di
	SFtiNuTYaQ==
X-Received: by 2002:a05:6000:178b:b0:391:c78:8895 with SMTP id ffacd0b85a97d-396eb8c4c24mr52383f8f.50.1741891738539;
        Thu, 13 Mar 2025 11:48:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFiTFy8KH7Dv3eYYsTrcbBbEoTNapIuB3vn5zSLGQGf/vt0sASshS9p0fTfDPLfBsj9yQoDA==
X-Received: by 2002:a05:6000:178b:b0:391:c78:8895 with SMTP id ffacd0b85a97d-396eb8c4c24mr52362f8f.50.1741891738209;
        Thu, 13 Mar 2025 11:48:58 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df3506sm3076694f8f.11.2025.03.13.11.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 11:48:57 -0700 (PDT)
Date: Thu, 13 Mar 2025 19:48:55 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Harald Mommer <harald.mommer@opensynergy.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Message-ID: <Z9Molw9U+1MYCtFh@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <a366f529-c901-4cd1-a1a6-c3958562cace@wanadoo.fr>
 <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rdYLPlFkR8zIZMMmVgh_AsOtUc9xqFBWXjmhv0vmM6A_1741891738
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 01, 2024 at 07:57:45PM +0100, Harald Mommer wrote:
> Hello,
> 
> I thought there would be some more comments coming and I could address
> everything in one chunk. Not the case, besides your comments silence.
> 
> On 08.01.24 20:34, Christophe JAILLET wrote:
> > 
> > Hi,
> > a few nits below, should there be a v6.
> > 
> 
> I'm sure there will be but not so soon. Probably after acceptance of the
> virtio CAN specification or after change requests to the specification are
> received and the driver has to be adapted to an updated draft.
> 

What are the changes in the specification that should be taken into
account for the next series?

Thanks, Matias.


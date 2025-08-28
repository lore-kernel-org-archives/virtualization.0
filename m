Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCBD3101DD
	for <virtualization@lists.linux.dev>; Thu, 28 Aug 2025 12:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383555; cv=none; b=i+I3p5FTwIDeQrQtGDLfPZqTnaahdKiCrbfFR+Hnnz7qOuK5Dau0EfO4V+i3Eo1J+vwD4aG5DLXnvM5/N6o86ycjZ9TYfn4ufrMwlJqtGMW9jD9JJvyX00ARp685aQCeo3pc/3jkO+EA+jpfVFggqXccaM64laFVwB9dnuKDO6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383555; c=relaxed/simple;
	bh=F+mheq4O2TyVZUQvPtr2Mdpd5dqUvirPgEbavwBKIYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=V23bz5nw+sczETMvofN4DK/TpQ0wteApRhAOgFVqTHSM6sMFikfmO+BauOROtZHwWDPVPxen6VDPFnjuRyi3f1mLH6MJiG6pr+/2IL+ZZEPWQxRCbt6hxbQn8jXdqfhBBq2a2Y851vLIuHCMQZr6YBOGdXmCI/2zxPCkH3IsdEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vol8/bCp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vol8/bCp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756383553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uq9u0cnhGJ/BdyM1GbcnyYUNgnWTAGwoq7wtSCyMB/E=;
	b=Vol8/bCpGY6gJakqBF316q9AxIuwJ4GDDMWxMlFfJ+roOvBa/mRbycSs3jK5Lv8x1bqgaZ
	n1uP8uDyA7+XOyvXO4K5iBUgOZuZLPZWDxdCCN1Hw3ysWBhB0DQ6hdT2zPmx3H3YPNpphm
	10lVzO7Z2lsyP5IjgUuUcmXLRUb40z0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-D8AGoYbdOZ6INY45DMfFbA-1; Thu, 28 Aug 2025 08:19:11 -0400
X-MC-Unique: D8AGoYbdOZ6INY45DMfFbA-1
X-Mimecast-MFC-AGG-ID: D8AGoYbdOZ6INY45DMfFbA_1756383550
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ce5b306365so272172f8f.0
        for <virtualization@lists.linux.dev>; Thu, 28 Aug 2025 05:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756383550; x=1756988350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uq9u0cnhGJ/BdyM1GbcnyYUNgnWTAGwoq7wtSCyMB/E=;
        b=VcMOEwDalzleNTkBk84++HMGOFFXisb/tyjyKd7r3sV4u12Q3oBpQOuf2YCnZ8sWQ1
         +3l/M/BVCRJGfSwQXQRBn5nM7BfnjDNhw2OEEMeJ5yKFXPV2jpSAM4tt2Ma6XMPxznsw
         m96XjqpxPIeqkO9IoFA4IaNE4YhRsth0vdF8o3lVkansQ2TpwszrjZM5VG/Arw4ee4L9
         o1+zrraRssYAMsaNsV5UnsnV5auN/MaPUxsuUCYvoCse6ZnVYtFlCVTu7w8bRf3ODo0p
         4ZDGJdxAoKijpDWH1wUECkZsopCFCFjcfmVCyFA0tmlNYqTaDeGnw2n6A3vz/0Ul4Uxu
         slCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5VXn3x40s2Kt3aW9s5UcoK7jaZjZ90PEpkpGuGY+OsGPk8GPSH3EpwgYlEiCdU7cZUJAOJ1iB9274ndLnHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6cX7FUY4HNB/AYuA+YP/5DGgdKvWf5epPsV8NFVULOaJbgRNS
	Xh28lgg9NhPEwvbjQmm5F3NVlI9zryA1rxm1b0bw0gdVJ/g12rhXV4p7bZW6j/WpFAXOIZMXdJ7
	7X4yjEiR1IQqvXlbiJM09vo/R9f3D04xsAIoSmjBQMAdTfhJsClzdQCB0vK3x+bmnL5Tm
X-Gm-Gg: ASbGncs4TZblirxfLP4Z0QWKW9xY8UHQBtX+M/n9RBFSbk1FLYkHE3EpmueJjYZXA5L
	3dv1OfgAwQQbHGdJcve9rYYneA74SpXeNByY8mBm4+7rgZ1SvacqXc9w4ehFIW6IJ9o8Pq48qVA
	E3O2gLr5TCRxP2Ju6f1S/oOG3YgQ7vNEkm35wvTZjUz0CDF1gXd1QQjFkGMoue7h4sCzFguw1kv
	w++GNydm/hwfjHo6R4nTRWcCjf//K0bxjumHTbP8vc7ERTeTtec62Lvtp7dWxCv6dz9eKDj62aY
	sZNSf7tG81stM1Agn2wLN9jh3lQYZxa7
X-Received: by 2002:a05:6000:402c:b0:3ce:d43c:673f with SMTP id ffacd0b85a97d-3ced43c6c3fmr105119f8f.4.1756383550294;
        Thu, 28 Aug 2025 05:19:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4J85snhq1BAsqwZjK+n9dKliu/Y1mrIx2XDMWIXXrAB06TFT0/Jbg+him3WiQwpHNUEOCTw==
X-Received: by 2002:a05:6000:402c:b0:3ce:d43c:673f with SMTP id ffacd0b85a97d-3ced43c6c3fmr105090f8f.4.1756383549792;
        Thu, 28 Aug 2025 05:19:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7112129b9sm24574050f8f.34.2025.08.28.05.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 05:19:09 -0700 (PDT)
Date: Thu, 28 Aug 2025 08:19:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Message-ID: <20250828081717-mutt-send-email-mst@kernel.org>
References: <20250822090249-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195392690042EF1600CEAC5DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095225-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195C932CA73F6C2FC7484ABDC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250824102947-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71956B4FDE7C4A2DA4304D0CDC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250827061537-mutt-send-email-mst@kernel.org>
 <87frdddmni.fsf@redhat.com>
 <CY8PR12MB7195FD9F90C45CC2B17A4776DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <87cy8fej4z.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <87cy8fej4z.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y_iR_C_KUrVZlFQ_fGhP4_lV3Bzqgmrn5PRjyXOrkEU_1756383550
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 28, 2025 at 02:16:28PM +0200, Cornelia Huck wrote:
> On Thu, Aug 28 2025, Parav Pandit <parav@nvidia.com> wrote:
> 
> >> From: Cornelia Huck <cohuck@redhat.com>
> >> Sent: 27 August 2025 05:04 PM
> >> 
> >> On Wed, Aug 27 2025, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> 
> >> > On Tue, Aug 26, 2025 at 06:52:03PM +0000, Parav Pandit wrote:
> >> >> > What I do not understand, is what good does the revert do. Sorry.
> >> >> >
> >> >> Let me explain.
> >> >> It prevents the issue of vblk requests being stuck due to broken VQ.
> >> >> It prevents the vnet driver start_xmit() to be not stuck on skb completions.
> >> >
> >> > This is the part I don't get.  In what scenario, before 43bb40c5b9265
> >> > start_xmit is not stuck, but after 43bb40c5b9265 it is stuck?
> >> >
> >> > Once the device is gone, it is not using any buffers at all.
> >> 
> >> What I also don't understand: virtio-ccw does exactly the same thing
> >> (virtio_break_device(), added in 2014), and it supports surprise removal
> >> _only_, yet I don't remember seeing bug reports?
> >
> > I suspect that stress testing may not have happened for ccw with active vblk Ios and outstanding transmit pkt and cvq commands.
> > Hard to say as we don't have ccw hw or systems.
> 
> cc:ing linux-s390 list. I'd be surprised if nobody ever tested surprise
> removal on a loaded system in the last 11 years.


As it became very clear from follow up discussion, the issue is nothing
to do with virtio, it is with a broken hypervisor that allows device to
DMA into guest memory while also telling the guest that the device has
been removed.

I guess s390 is just not broken like this.

-- 
MST


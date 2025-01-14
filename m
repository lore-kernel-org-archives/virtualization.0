Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9912C24025B
	for <virtualization@lists.linux.dev>; Tue, 14 Jan 2025 11:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736853975; cv=none; b=WD7lpYa/HIXoIqGc+BZej4k6imN2dF1MAAQpmeX/rS31bjE3tmuvnP2ylne1u4VjL4pmpNMQDLKq+tGGR56VhjE4pWQUjJ4xKyCGNTf0+WyehwV6KLOFQTR0ubhZ+ZhGmO1F0GYrB48staPwMYAao0JjxHHhE4MhVu/FnqlPPg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736853975; c=relaxed/simple;
	bh=P5WOc1gqUz8scmwf5xVMe2cVdYOYl+zpgG91/lMjQ8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Kn7e44mkqSe41gg5jnbpuDMNbFn5Nh3wrmapKkzHt7ZbpZt5STUbwFdY9riTDUgmfxrrrB/f5PFvcPVVZ+OzcYl21GMooS2AhYFlERzDuce+HWYp6bScxXLJMxUzs92ckbCz6sf05JFglFM3+xZqZ+w0MkQbzp9y7Fbw2sGQ5JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cxWKJ36C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxWKJ36C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736853972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MsY6pEzLRQ774Ovx8M1YoG6AKNuIHynFJ8DXSapB998=;
	b=cxWKJ36C2xicuoB0Fo4zeOdovQsNbbeM845YaG4djHem/yNtQhyO2n3FRL3BL3jOD4x/do
	a9od8XLYWrAbN4eOlcVp18CzBoxJ8nmH8cQg3E7OmLREci5A8IFhiCu1yH3ShcAMcUgBNa
	L9oSBqnObdeWRXuo8SULx/RdHlYJPQQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-btE0AhOPM3aNWyzxao_-9w-1; Tue, 14 Jan 2025 06:26:11 -0500
X-MC-Unique: btE0AhOPM3aNWyzxao_-9w-1
X-Mimecast-MFC-AGG-ID: btE0AhOPM3aNWyzxao_-9w
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361eb83f46so42839715e9.3
        for <virtualization@lists.linux.dev>; Tue, 14 Jan 2025 03:26:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736853970; x=1737458770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsY6pEzLRQ774Ovx8M1YoG6AKNuIHynFJ8DXSapB998=;
        b=oWSPZkEYw+x1tA+uHf5dgqKAkP24kNSHoV7QVTKc02STE2eDCUsQ2DwbE6jEHfdAh/
         e6q4mmoDOFi/Q5jaDO52bXxHDDsfsG+IDcH6tZ8y2kGccsMSPpTCzrG5pW9MbadxYMQu
         zHf8YA0jeFQGr5qd0z+wsbn+I2sMyF2u1fuPln6Y1K7aK8iz7dtGu/AZKhx0c+0SgsLH
         ffuifSXhA+VHCtdNJ2o/InirrLMsjxpzkvpGVBS715+FdlHVAUvZQlc4wsEQjya0kiye
         1twQREU+mfkgDFlIXG/A3kPhOIyqJDrcWrDu9mai6crcpngYynsGzFeHO2H2Zc6o2uZ2
         43QA==
X-Forwarded-Encrypted: i=1; AJvYcCUbg6Ex4Ug1qiWMY7rYtrPBOvs6j/BBKbVJpskBZB22rtxV/6472J+H8OeKVHBbWa9fYmHLpKuSjoHjYSYSNA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw23TCvYArvXoxYUDtCS8E1blXJGVXigwhyp3v2AXe8A+nNbOJK
	29vQ3Abd8aE1US66NicwJcFAwWztZGBSFfWVZzqyXxt121paMWznTvILr47LpgWHQpoa3D0e5j0
	ycuqnsUrbYmcgguk4BuNhVrZawW0+ZIOWjPAkh0FX/nUFHn0rIZ0Np9eLMsZYGTSV
X-Gm-Gg: ASbGncscCFVFGmFHQFxpvG3v0g71tEXZxTrb01eF66w4fDgHDALxr6oDZxqhPWRj0LG
	AC9Z9nDaSAI3ujfzjo7iooBWTckbV4plHGDYBmetq8plv+GwXGNGR8go7N75NVnHpyRmgbyiKQ4
	BAMk+E3W3QWO6bMId9M0OE8gl+oqAVJgDDwvcYBS8gskMn7F2xy8J1lKBm/hcXD4bTvnf5FnFHS
	2jWLmb1U/FpOeeJQkFECMOztOUtxR8wl8BFv+gYLP63z7Q+ng==
X-Received: by 2002:a7b:c4c9:0:b0:436:f960:3428 with SMTP id 5b1f17b1804b1-436f96034b3mr87034435e9.29.1736853970039;
        Tue, 14 Jan 2025 03:26:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGArTmmJVNPIIZQEpvn3/I+W40gy72w27dB0r1QO7CEIvxpSiVE4IdF93HeHvTkZVp04ua2Ng==
X-Received: by 2002:a7b:c4c9:0:b0:436:f960:3428 with SMTP id 5b1f17b1804b1-436f96034b3mr87034075e9.29.1736853969706;
        Tue, 14 Jan 2025 03:26:09 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:f243:3731:6014:d7c:f11f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e383882sm14683861f8f.34.2025.01.14.03.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 03:26:08 -0800 (PST)
Date: Tue, 14 Jan 2025 06:26:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: Haoran Zhang <wh1sper@zju.edu.cn>, jasowang@redhat.com,
	pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/scsi: Fix improper cleanup in
 vhost_scsi_set_endpoint()
Message-ID: <20250114062550-mutt-send-email-mst@kernel.org>
References: <20250111033454.26596-1-wh1sper@zju.edu.cn>
 <bae5ca72-c6ff-4412-a317-4649f2d09cdf@oracle.com>
 <481cd60a-d633-4251-bb53-d3026e005930@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <481cd60a-d633-4251-bb53-d3026e005930@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4IEo32IGIX3ZmClK37HtiRdVfs7TM1Nj3M2bG9Hzwhg_1736853970
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 12, 2025 at 03:19:44PM -0600, Mike Christie wrote:
> On 1/12/25 11:35 AM, michael.christie@oracle.com wrote:
> > So I think to fix the issue, we would want to:
> > 
> > 1. move the
> > 
> > memcpy(vs_tpg, vs->vs_tpg, len);
> > 
> > to the end of the function after we do the vhost_scsi_flush. This will
> > be more complicated than the current memcpy though. We will want to
> > merge the local vs_tpg and the vs->vs_tpg like:
> > 
> > for (i = 0; i < VHOST_SCSI_MAX_TARGET; i++) {
> > 	if (vs_tpg[i])
> > 		vs->vs_tpg[i] = vs_tpg[i])
> > }
> 
> I think I wrote that in reverse. We would want:
> 
> vhost_scsi_flush(vs);
> 
> if (vs->vs_tpg) {
> 	for (i = 0; i < VHOST_SCSI_MAX_TARGET; i++) {
> 		if (vs->vs_tpg[i])
> 			vs_tpg[i] = vs->vs_tpg[i])
> 	}
> }
> 
> kfree(vs->vs_tpg);
> vs->vs_tpg = vs_tpg;
> 
> or we could just allocate the vs_tpg with the vhost_scsi like:
> 
> struct vhost_scsi {
> 	....
> 
> 	struct vhost_scsi_tpg *vs_tpg[VHOST_SCSI_MAX_TARGET];
> 
> then when we loop in vhost_scsi_set/clear_endpoint set/clear the
> every vs_tpg entry.

Wanna post the patch, Mike?

-- 
MST


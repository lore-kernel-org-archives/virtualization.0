Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416F32EA486
	for <virtualization@lists.linux.dev>; Fri,  3 Oct 2025 11:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759489693; cv=none; b=rDOt7wdvcnPiSpoZsIACtQtSGuo/AtHW0/h5Svmt8kJ8Lo/XCmRNDm81R+WTmtbZ4aqkqTer2rTIXYdrwmNfpgDhKDTTd747ixFurvfj0hzqWy5KvGHpB0BpJl8+T321K33ldPhN4YFqcAPcbMft3DZ31nsnFOGLzH8rAay30DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759489693; c=relaxed/simple;
	bh=3dJOXmWGWTXkohW5t1g7MDHN1lCRpBDgo4FpFwXMTOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KpFQUHii3awZP2iQ3tbPJiAfDjhST4D4wGk3YVZ93D/lhyE636slVr2jKC+TeKzc9FNisOQbQV6I+WX31NYz0eCDXUBeLsODn55BWTF0QJryw4ymrEj327RVGjN5BR1fpEbIqtvkK3dAqJrcxQbyJwDO+EL9w+Vg0sG+F8VohjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MhpvYcB7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MhpvYcB7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759489689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xtoatduwo5XW/OWrjLtdrbYwdN0kHRW1Zujxno/egPQ=;
	b=MhpvYcB7yN7UPavCA3yClsY3KvSFaSvDUijWf3b8rf68FUjaNagyB9+pusOUkAlkOqj5l9
	2WacCJBO0uLif+/x842P6XjbviiYvzET4iXYf1ipnt+RUBuhZOvkQYSd1Upohu9nbGkLU9
	DMBiDkJbOwR73SLZoykmEJDOsO0pgFE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-7A87kwQ5O8O881TGG3N0iw-1; Fri, 03 Oct 2025 07:08:06 -0400
X-MC-Unique: 7A87kwQ5O8O881TGG3N0iw-1
X-Mimecast-MFC-AGG-ID: 7A87kwQ5O8O881TGG3N0iw_1759489685
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e3ef2dd66so12013075e9.1
        for <virtualization@lists.linux.dev>; Fri, 03 Oct 2025 04:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759489685; x=1760094485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xtoatduwo5XW/OWrjLtdrbYwdN0kHRW1Zujxno/egPQ=;
        b=wnXbG8zcbScrJf4TrWt9shG6sWs4BSUw+ac7kynM6NwbhbzbJoqUZVI5ds04FJVhTL
         vxuxSSNos6tGNQqiTpfVsySBl8fM2Y6iGnVdI4dUPWLLwreCI1YAiHcXvqqZlEUFHJcp
         B0kWJrVCeKSF1GIkeveoXopemJmB+xRyr8Ccbf2AZLG/MEKSGhtvSSllkhH/U6HM7JiD
         1kvmI+7BHgZkt+6Bc0c5J81VZ+g7PQFuCn/ioU1JkR0SlUHWxIpInsR2P3hp7Pj9BmK9
         hESy8+KZuhjYotb6dIEcoxU9oqLvDnO9tHY4xJscY2+P004v+oPxrDY3ly/FWH50VzZD
         iwNA==
X-Forwarded-Encrypted: i=1; AJvYcCXBs06ofkA4yiosBxvSJgG6nOg0SKFuRdhA/DgMJiZZbZxPpawi48N/Giq+mSMDSnzt3kJO3Vl4tSWSuMLcuw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNbeCJ3L0/Fepbhf+dutj9Ab0G0ibJthkCWwhOTzjk/tHj/757
	sbk2sVrEE1/34EcDYd3A50wqQOVyTR/sfwDu+oIXXlsryP+SxOrLYKSEHGR9H6eIIFE1vhncRHi
	OBRbxETVjixXsUmHuq3TG+i0a3R3UJBrPc430yWRrKm/oRApRiGaMLHtjUC0MDT1dW+al
X-Gm-Gg: ASbGncuQvz3YNjqsoGPQgtkzeCt9WFF44AB3JEy50f4GyaPhaVfWU1etjXzokeSRydH
	JAeHQp94FYWIbo+YmkwoAdH9YQSViRNVfwi/mkoY5BWDaInlhX9jSVO0vyVPt9QDDGWXcySYIut
	4uE01I1gsmiApxCb1PJ+wecVN5Fy0RMNZAoWEhDgVzMlM2ogQ9egpyysPzjbVsbCW7PvyaM61YX
	3Twq0aoyxEY4V3/AW3tdE0HQ+5nPcrN4rCDwDWPWvaL9Bt3BnzsZmD6QhuPyBy/OlZkNXBpdUyA
	xV3Niynl7tkw4Y0CSZL/jetKPkfWWUgS9j6seCU=
X-Received: by 2002:a05:600c:4688:b0:458:b8b0:6338 with SMTP id 5b1f17b1804b1-46e70c5c8b0mr23989365e9.6.1759489684734;
        Fri, 03 Oct 2025 04:08:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuHa8uUTYfm17St4zx4T4+dwpgApOvW/hXh/wH8u/C70YRTMI1bzyLC1ZaRawnbggbsccgtQ==
X-Received: by 2002:a05:600c:4688:b0:458:b8b0:6338 with SMTP id 5b1f17b1804b1-46e70c5c8b0mr23989085e9.6.1759489684352;
        Fri, 03 Oct 2025 04:08:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e980dsm8135399f8f.36.2025.10.03.04.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 04:08:03 -0700 (PDT)
Date: Fri, 3 Oct 2025 07:08:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: eperezma@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_vdpa: fix misleading return in void function
Message-ID: <20251003070729-mutt-send-email-mst@kernel.org>
References: <20251001191653.1713923-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251001191653.1713923-1-alok.a.tiwari@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0eDoa08OzvNIe6NXUB7Ezs2RFhqiBPM29LFsVpBJ1j4_1759489685
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 01, 2025 at 12:16:50PM -0700, Alok Tiwari wrote:
> virtio_vdpa_set_status() is declared as returning void, but it used
> "return vdpa_set_status()" Since vdpa_set_status() also returns
> void, the return statement is unnecessary and misleading.
> Remove it.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Fixes: c043b4a8cf3b ("virtio: introduce a vDPA based transport")


> ---
>  drivers/virtio/virtio_vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 657b07a60788..1abecaf76465 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -80,7 +80,7 @@ static void virtio_vdpa_set_status(struct virtio_device *vdev, u8 status)
>  {
>  	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
>  
> -	return vdpa_set_status(vdpa, status);
> +	vdpa_set_status(vdpa, status);
>  }
>  
>  static void virtio_vdpa_reset(struct virtio_device *vdev)
> -- 
> 2.50.1


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0EA13E030
	for <virtualization@lists.linux.dev>; Tue, 14 May 2024 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715694285; cv=none; b=rLuygbr/aydzBZQFYooPw9+IAsUlY0kCb1gtgNX9Dw1GuVk21WVtgNHhRQEDnqH65xLbXQOHN/DnXSQXgP2HV7rAjcje7Ye3apPqtaUlSGtF3se4dfZX0V9fa5WxcJh8gjPPl0mtQy7JGzkvzidbSfskrTpnOqvgppwWqbfZmao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715694285; c=relaxed/simple;
	bh=hBFyXmfU0NivrcJfXUfTEh4K3NW+BkCzpf+LUGEdWKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VzPzDsxSf1/KJUOXQnFxRxHplIdGwApkxlHEDH1vIHy1n3BauMdXv/C3iMgUiDe15Dno3MKS8LH+1FADaiLFv/0boKRre7cCrvg4523BpcgzR0ccOiNRtecjFuhqjJyiGhhkrGHku5KtvZ/j8cj8MDm4/bfXh6vGpX/ohU4RojE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dz/3QimZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dz/3QimZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715694282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z7rBDn6ackmq48NY+VVpR1hlizGR4TMUhaAeJeRy02k=;
	b=dz/3QimZjFs6HZju+1Lx27RcDgmSmcFIKcSEoEG6dHgIIQjACKvlfAZIWcweOkP1Wfe6Ha
	LOUWo2rtSMVQ7mvN8I05BvE7h3wn9ZVYVSNhzjMc6EKuAACMX6TMO8BFrsIQbee6YgiICi
	hO/1hOLIyVBW2NeGCQxW/F1RhYH7XuQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416--sPhpv7aMlW8L5nl6gcAQw-1; Tue, 14 May 2024 09:44:41 -0400
X-MC-Unique: -sPhpv7aMlW8L5nl6gcAQw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-51fb0ba9f6aso3785182e87.0
        for <virtualization@lists.linux.dev>; Tue, 14 May 2024 06:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715694279; x=1716299079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7rBDn6ackmq48NY+VVpR1hlizGR4TMUhaAeJeRy02k=;
        b=dNQnhw9vQlOR7HkJwZrRwfwvlDsKy6bc4X1OQgtEdSp3kmq6smIo8Bz4DxHUSe/xw1
         ysQzjKmpOO9gUsoqoVVJaD5DcjTg2A9te36v19NFlGsww/8CNf9U0ISM+fNUz7Eot5DF
         P0jLPAGpSjpARL/jNtrFRiizewrHhcMG5WdFClzn/jVoJHhT60x4dUfHaiJnQRN//jiL
         /wJZUeOga/P8FKJSKXnHWn2nxXVAarH89CZxklhCrwKxNrata+/F/sQHMAfIn8ZJ53NN
         tTfpUc6nute2nASyj3Yh2sPjxg7c+KKdzmjBYEBdlnPDDTD/UWYBRwClFYFUcPFOFXWQ
         fkcg==
X-Forwarded-Encrypted: i=1; AJvYcCXirJUj89mv8HS5ImcthrsdZ6JeSTnGwfcSHy47PENntXqXNdYG+6aKcelRNRXfjVgfbAj5kPNHOKE/J3UHz4R35OI82AKvesgCB5FLH8M=
X-Gm-Message-State: AOJu0Yxj0T004qQ/nBXmmusJ0lA4HfWWQ/3wbhu9S4ENsUD8fQkvUWWN
	NVkO65E6yHqZG2vKq73uyE+H2RHTDFbEsL7VaaGrmr4Ezdm+LKpzZ8rYaL2TRCc7OXOKKc1nqRU
	6pXhqun2WxL48/IfUJ2Z4eM19aLvWFKAeX9wUtrCAlEGIBY4nn0peOiLWPzdK94X//r+tXykB
X-Received: by 2002:a05:6512:33d2:b0:51f:5c3:2d6e with SMTP id 2adb3069b0e04-5220fc7815dmr10524984e87.17.1715694279064;
        Tue, 14 May 2024 06:44:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6SNwl8ryLQ7RX7MpO+8yYmkYBKvpFt7W9I2TMrFktk7EVRVITL776DZiRvOVarItmov3Rpg==
X-Received: by 2002:a05:6512:33d2:b0:51f:5c3:2d6e with SMTP id 2adb3069b0e04-5220fc7815dmr10524954e87.17.1715694278224;
        Tue, 14 May 2024 06:44:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55e:463:726a:3c7c:48d4:74fe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce1912sm196348555e9.11.2024.05.14.06.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:44:37 -0700 (PDT)
Date: Tue, 14 May 2024 09:44:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, virtualization@lists.linux.dev
Subject: Re: [PATCH] ifcvf/vDPA: ifcvf drives standard virtio pci devices
Message-ID: <20240514094234-mutt-send-email-mst@kernel.org>
References: <20240513212707.9894-1-lingshan.zhu@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240513212707.9894-1-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2024 at 05:27:07AM +0800, Zhu Lingshan wrote:
> @@ -880,7 +881,9 @@ static struct pci_device_id ifcvf_pci_ids[] = {
>  			 VIRTIO_TRANS_ID_BLOCK,
>  			 PCI_VENDOR_ID_INTEL,
>  			 VIRTIO_ID_BLOCK) },
> -
> +	/* standard virtio pci devices */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET,
> +		     PCI_ANY_ID) },
>  	{ 0 },


To summarize, I don't think ifcvf should drive standard virtio devices.
If it can then it sounds more like a reason to try to reuse more code
from virtio core.


>  };
>  MODULE_DEVICE_TABLE(pci, ifcvf_pci_ids);
> -- 
> 2.43.0


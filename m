Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4A437E5CC
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427031; cv=none; b=RMbck3FqAJVKBsdByf3ba+zHVTWyx5UaZyk5Ki4s8WIVHBFa6Qc9jcw3oHUZOh64mLRljbksH9zNMKIRqeL2HUdV8OL4Yk5fSv704pkCrS26fy+JdYHCaIXiuKmSyItjwOpFRLKB6LWvMJnGf6zUCaONodoBjMMkFiigG43RGVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427031; c=relaxed/simple;
	bh=OL+o6VJxKZU1tR+6CQ7kZmrOTd2Cibz+iH5UNVYewkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=V2Z8OvPTtFA3XiJbU4xwOcGR9znn0uHXi/T7TEX07CjDzWsA2bdNDm/igqdT1pojPXIYZZ2V/fULiVTpEH9J0GLMy1sTtrv8a3kui+nwT7/d3RhZQYTAphP4PK0aKt6HVtm5oKADCXnRJQu8k5fP88oVpzcOsJvj3PuKf2m+HW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H5Fxb/0M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5Fxb/0M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788427028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OL+o6VJxKZU1tR+6CQ7kZmrOTd2Cibz+iH5UNVYewkY=;
	b=H5Fxb/0MXKwdkS5njBcv4xkqYHXOwZY1uAgmodtUMO2xRu9w5q8cryjnQh8iS0WFU8nsRW
	qIpKA+pt/ckoGUWUCgGTjHioaPwqm95/ZQEOigyy7vIUF76t8cAMPNdL9TMYtq5gKU0P1d
	s7CXHsIbsb7u+r+jg2066ybj61gfR1w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-kM7OqMHpNOCccJLtXm3cSA-1; Thu, 03 Sep 2026 05:17:07 -0400
X-MC-Unique: kM7OqMHpNOCccJLtXm3cSA-1
X-Mimecast-MFC-AGG-ID: kM7OqMHpNOCccJLtXm3cSA_1788427026
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f4bff865cso1246982f8f.0
        for <virtualization@lists.linux.dev>; Thu, 03 Sep 2026 02:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788427026; x=1789031826;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OL+o6VJxKZU1tR+6CQ7kZmrOTd2Cibz+iH5UNVYewkY=;
        b=ZUdfrcCpDMJlQjpNk7HQWOJnM7RbP/h70VRV4gGcvPS71Zm4KftX55NHJpqOhFsZDC
         oG13hR4ZOfu7hgYLdfCJwolBqb1gLAnKNJ2hPurrqDD31cAITWIAQM58FkuX/ti6+kC6
         +uVvdapDH6uxwOJOxlHvvXlMemKP2Z1DidagIW6E1PUFeUVHo7tGWYkbiUenHXXt6jOD
         vWhMXB7o7xNPsCL/9B9sAyYvzB838C222PxNxBkNKtaYYn3VdAFKYT8eqbz9vNzMIbxf
         n8iR0mvnXU0j0iybCHl6Wjq8gjcLpNwcpsHIHuyUCAxr+3G3Y++pQeBmARh2PIu1TfWk
         iTaw==
X-Forwarded-Encrypted: i=1; AKwUvBwV2zMrHBDKmx4Mb3azVa3Dd2kxO81c7zu7AWd8BSee9He+qChOZZQv2w8qtd1sDdUYhygVyq3Wj2L+iQ/O2g==@lists.linux.dev
X-Gm-Message-State: AFuF++kdshVPypGsvFL2cvrZOnBSXzmHLpIeg4+0ypEcE4W2ydKb+h+c
	ceEpbPC3hQjbJUPYoW0gR/Zlht+uDDVOYOpdCy7Oqus8zbl1fOy4u8jd2FUe/iDt6FKJj9S1hAv
	iW0YSbTpOBtTdT5d4uZdeitrhp/THoE/Kh8xS59RspaLVmPPCOFbf5TwFpfbob79/O25b
X-Gm-Gg: AYBFou30/Cxd8eFmC274fhWbwAnYlDNsSl4QrMf+1I9zcxSlCx2QiFWW7qAz8Vr+k3U
	SS16WceRbbdL1EbLmxnSHby05D1DjL1W+OgAdXrpLgBSSJ2fPArmpcFh6VHQaSC9qTPsEkJ1M+n
	rRrm9LHsu8+FYiIuaau2GQBpHob0g9nnGD4jhva1BlKFIhRFzvDEiEV80PhIlpf+s8QM/OCYRqr
	5dY5kxRn9pii1shYEyVAQJF8cwVmBps1u+YZnjV9CjbNQBsNQR48JhjhePxifci+SS8Hq1dX/gz
	wg+KT0+su/59+Vi3hSBGQ9lCU128IWaGpSHqhQ7DZbbghzq6ujeSefqMv2JRoo0NN4gcaWajB2C
	e5vkjJA==
X-Received: by 2002:a5d:5e87:0:b0:485:8101:dc40 with SMTP id ffacd0b85a97d-4858101dd2amr1666500f8f.9.1788427025861;
        Thu, 03 Sep 2026 02:17:05 -0700 (PDT)
X-Received: by 2002:a5d:5e87:0:b0:485:8101:dc40 with SMTP id ffacd0b85a97d-4858101dd2amr1666366f8f.9.1788427025353;
        Thu, 03 Sep 2026 02:17:05 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.169.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e80798sm11736036f8f.13.2026.09.03.02.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:17:04 -0700 (PDT)
Date: Thu, 3 Sep 2026 11:17:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, jen@redhat.com, Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH v2] virtio: add Eugenio =?utf-8?B?UMOpcmU=?=
 =?utf-8?Q?z?= as Maintainer
Message-ID: <apk69gcFCbt8hDcp@sgarzare-redhat>
References: <20260903081831.2129729-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260903081831.2129729-1-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5rf9wtY_ar-2A5bpxAhEBRk0C6Uo_GxEZRb4iQ3h2As_1788427026
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Sep 03, 2026 at 10:18:31AM +0200, Eugenio Pérez wrote:
>Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>---
>v2: Reorder entries so M entries are ordered before than R.
>---
> MAINTAINERS | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


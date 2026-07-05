Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5455366045
	for <virtualization@lists.linux.dev>; Sun,  5 Jul 2026 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783240541; cv=none; b=ZDA5kHKnksfx5H9+EHTMCG6sVBtBVXI+0fkkrgx9J47LcXcQ+QuuKtMfg/q1LqLt1TUH9ldeepJYuJtpqhOZxwaO8TxOEY1jm/8g0ggRI1ilAsOHDXEO6zuSrQdOsozT1XTYD/BN1jr/71y1BYrHA9vz1/qSTfKqFhquS3Es3RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783240541; c=relaxed/simple;
	bh=8zu1GQKDq5ZrShEYTtokpdtb1cdZbJOpkDs6mpvam0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=F/11z/yXpaV2skEjRa7PeBo+OK8NWQuZg7hTncimsNTZke/eS1RPIJiwI0lP8KOzkbzlvuGYghqM3nMKTg9YK/pyPw7ffjR/9eYlA/Or0G7xoSU/C4dObQ1rZJ/ty+kRaAElm1byUJCLdW/ehJ5lO5+wBY52lb3+Z3uTF7ZDci8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f/xrMq4q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/xrMq4q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783240538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dFQDBZsIuu7dJK0KUEdBQ3FE5XnU6Bp1zoNA3OFVPPc=;
	b=f/xrMq4q/uxk4t+cAshvkqMW/IeU1n/2oEOrqZgdKWh6X1LfSMMHJILa09uQjiGAge+9tL
	VsqDbhm2+papshg1hBGGSHWduUth7zX/YnKEiBMiCIR7rZdnyB9Z/bBrXyyYOGt0ymDnqK
	NpJ/pGBbzQtoE4VQ546O6ShYwjsctuI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-ARVDLXxRMVK1CPy6KUrPig-1; Sun, 05 Jul 2026 04:35:37 -0400
X-MC-Unique: ARVDLXxRMVK1CPy6KUrPig-1
X-Mimecast-MFC-AGG-ID: ARVDLXxRMVK1CPy6KUrPig_1783240536
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-473941177b0so1550608f8f.1
        for <virtualization@lists.linux.dev>; Sun, 05 Jul 2026 01:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783240536; x=1783845336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFQDBZsIuu7dJK0KUEdBQ3FE5XnU6Bp1zoNA3OFVPPc=;
        b=ouYRc4a7vYiMyUTrHHynVucjTyy8aG/Lkwe6gWzl3BRkwz+q22lm8rv9PMITTYJk/f
         QAUeHywgURaCl2UChhzo+KkMdDZz/8vujKbTiIF1WoHh3u4r3UZ4PhZDfgplE1lp/28a
         Xm+yN9UuHSmMIdPUabQs4JWfJyVHihdNUX5Xyn5bmMmeNhJNKaWMqDCVIPvTzCwTZHkP
         IvP5d+g36mLulMyUnNAW7CPJ587e0J4eo/Y30ukRtrG0EPeEkgCRQrIYS+4WXy/XmhYi
         TB+le7vESz/mptmZemKbSenhJx30sKubZfwNVp22qUSw6ayJ53GLDBOIXn2P10N4xfgu
         oyPw==
X-Forwarded-Encrypted: i=1; AHgh+RpJpR5qcKqNW3lxtx5OeExoc/4m7H8qW7NDc7kQ2BTgmeLBMYCTG+/NLNILZsDMKiODXFxYdSVmYpee1XX4GA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXo2eNPcy9RIp1ITTnLxYR8K+jdxVc5GeGTlKsJbEPIFGOtyGo
	9zv1HHCn7oalFLGRFP8DXCa/18t7m0ZI2Bm2IxmaU2kIpv4RZHidnPAzkX+30iCOlfARvbTZgbN
	wDG/gHOCCb41+PvGDc/dIzoncPlzm8Xg1g3We+RjG1zhT7IKAkpGoK051f6vm/Cws8pXJ
X-Gm-Gg: AfdE7cmERqrkvzbG7jvh+i4rQKPF1m3Vz3BqEkA637m6jplgY0JJpvy5nWxTgzI9cYp
	HO+GmAgkkf4bimLM97ieEIIfMz4sPwUNSJeURzHhZS4SCI6odUMYlms8YtPRmSV7P2/t78zB+bV
	PlbroabPlJtO3TBQCUCvl9tbN3ojXcZXDIohKs783olekSTphYt1bW3UrID4JF3tjFwecspMyQZ
	OlMd4kK8Arv8Tasa0+OY8kNgOSv7Si2hnEn+OZEZZzOeJICt57XSnI9+FhtlfEI6NvfkIf+coqF
	WC6urWxrvcgD3BMe1Dt2ap40vlGdyTbVUoxGS1uDz9+GargStG+yicx+Wn6vOsIKPnOBZeDTyWT
	thlYY/P4t2wi7Xnf0ilk6WdP7gGLcEp8f
X-Received: by 2002:a5d:5d83:0:b0:474:13ac:a91b with SMTP id ffacd0b85a97d-47aabe3096emr6401641f8f.32.1783240536178;
        Sun, 05 Jul 2026 01:35:36 -0700 (PDT)
X-Received: by 2002:a5d:5d83:0:b0:474:13ac:a91b with SMTP id ffacd0b85a97d-47aabe3096emr6401613f8f.32.1783240535738;
        Sun, 05 Jul 2026 01:35:35 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a558easm14222697f8f.27.2026.07.05.01.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:35:35 -0700 (PDT)
Date: Sun, 5 Jul 2026 04:35:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: schalla@marvell.com, vattunuru@marvell.com,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa: octeon_ep: add missing MODULE_DEVICE_TABLE()
Message-ID: <20260705043510-mutt-send-email-mst@kernel.org>
References: <20260705002546.85004-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260705002546.85004-1-pengpeng@iscas.ac.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PNrQySBYNY4XqEr1uYYwwfEWRnd273uDGpBzuX9JLco_1783240536
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 05, 2026 at 08:25:46AM +0800, Pengpeng Hou wrote:
> The driver has a match table for the pci bus wired into its driver
> structure, but the table is not exported with MODULE_DEVICE_TABLE().
> 
> Add the missing MODULE_DEVICE_TABLE() entry so module alias information
> is generated for automatic module loading.
> 
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the driver registration structure, and the missing module alias
> publication.

what does this paragraph mean?

> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/vdpa/octeon_ep/octep_vdpa_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> index 31a02e7fd7f2..9bedcd81a174 100644
> --- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> @@ -884,6 +884,7 @@ static struct pci_device_id octep_pci_vdpa_map[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_VDPA_DEVID_CN103K_VF) },
>  	{ 0 },
>  };
> +MODULE_DEVICE_TABLE(pci, octep_pci_vdpa_map);
>  
>  static struct pci_driver octep_pci_vdpa = {
>  	.name     = OCTEP_VDPA_DRIVER_NAME,
> -- 
> 2.53.0


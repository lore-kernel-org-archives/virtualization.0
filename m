Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007531A2397
	for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433890; cv=none; b=itVpgvKCYsX6vzI6YqXqXsjr+v2jO2AWZ1WDV0f/jMWRu4f3ch42imHbfJpRxr+1vmDsEmlFVOXUC4RjpxzxaYxdmgrSCVRkUa2MCZnggpk4Eyxs5FrxfVf22eypSq6ORu3mrFV68sABuL9BSi37MbBO4qao4hixzjb2Hf+KSig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433890; c=relaxed/simple;
	bh=zkF5hc0cK80WJWcCdicuqbNp3sujPPZYziecsBeVhl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MBCx1p3OmmoHyC3wfE55slCFwmO4f5fQ/1+BnVfLwy6pK4H0wRYCLZJ20yQnd6iQEdMq/jrbNengbhUEdrXsRk7mAdSPjNM+z3MuTK1QvMZ9JyVO7oPPrN1C4y8bUNglYyCr664kYH5H2X+glMQxX6G6AW9HwZRHStuthNEQLis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VTpea/Ke; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTpea/Ke"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740433887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PYw3iOFdpjI7CWdvocKoz0dXbPHM+ovEK+NkNh9AWKc=;
	b=VTpea/KetpT9eXXuaQ5V1jSSjo5OoVbPIeIaxYn+2WaMsotttezmlm6I2F97ikDkmBlozo
	XBPP88cAsXr2HZreQmagLhmNyR3UhsOAlObaXHkMDxirEZrDMFHdaPyWGh58MZyzf2Nw6S
	sUlTvpDTOvFQzqB/tpoQklTp/pYy1/k=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-aaJl3OszPByP3dehbcKemg-1; Mon, 24 Feb 2025 16:51:25 -0500
X-MC-Unique: aaJl3OszPByP3dehbcKemg-1
X-Mimecast-MFC-AGG-ID: aaJl3OszPByP3dehbcKemg_1740433884
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-abb87e3a3c9so517194866b.2
        for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 13:51:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740433884; x=1741038684;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYw3iOFdpjI7CWdvocKoz0dXbPHM+ovEK+NkNh9AWKc=;
        b=m6KaokM+lCpuyJd38u1hnMMyGUtBoi3RmuwbrS5Mcr7N060sX+2y/ae530snQ6Q4al
         pHUc3E/Y3ogLwP21qoBPNb7FgMbkHvaoud8UGpWRi1JBjG9HIaR3/5+ROzNkwt3fv2t0
         6e36njHAdmkgOn8gMQK+b0QJBCK4EUVHuVvYCra3jPTCowTLCxpyTPoqNraeIrenWmqg
         LqSemfCFP2lPqfYaJWrsuuMTYLuBqjdEnpEgwsFk1129riBFzv/srMHgQvmt/bXDt+rr
         g9oe9Mht225eLjSpk7yR9Bq+il4kq9afXTBlBrJUE8tj1RVpH3vkC0aobig9upC+IkRs
         qMMw==
X-Gm-Message-State: AOJu0YwKlLN2pEKmJtUXchZxwJIWh7ZFrz1C1Eriif0RPASFZOy0D56G
	2f1xtAV2XpiT3ix0Z0qkOkfX6aqGjUYeD6ApR30ZKPW/y6CeiHCQA7U+MpMg7I+ym/Fipm54InI
	g/7YkLYzO6oYc1cTzvrByJ3sRyYXrz3xYe9WKvEzLImIYXCdgzrjfTvdfPloy6332
X-Gm-Gg: ASbGncupcAJ2G4A5DjAFKV3ZtPqHePzheke8zcJxIDoMj9ran3SH6bc4Jzx/HIR8kzw
	NfdBU1+WQMn5+WuEbzkiDkfuggi5yP5+E9auMyxyblP1h9zl+U1RxzoCxI80D7/TPl4KyxqiKSv
	awpNxT/hVaDk1615BPJ+uR3m3tnLNCoDWx4H2Cx8qqkbUYMds+UXktZJcFfyz8D3Pg1rZJfcs6z
	FFN/ADzFRj7YPEWynpOPGS+XmEM27Cfkn1RPe0nw7KUg0zabMlNvImkwh1Vh19nfVq/0o6z+srR
	KR/btHGh+g==
X-Received: by 2002:a17:907:86a3:b0:abe:cecc:727 with SMTP id a640c23a62f3a-abececc0781mr173141666b.53.1740433884496;
        Mon, 24 Feb 2025 13:51:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtaHW83Wgo/05/4WrDIXvGAbbq8f7q4IYZXTHaNGr0H2AqSCU/tm1tMIVm3RT1FmuY14Wc/A==
X-Received: by 2002:a17:907:86a3:b0:abe:cecc:727 with SMTP id a640c23a62f3a-abececc0781mr173139966b.53.1740433884105;
        Mon, 24 Feb 2025 13:51:24 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:441:1929:22c5:4595:d9bc:489e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2053e88sm26766766b.134.2025.02.24.13.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 13:51:23 -0800 (PST)
Date: Mon, 24 Feb 2025 16:51:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hanna Reitz <hreitz@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	German Maglione <gmaglione@redhat.com>, stefanha@redhat.com
Subject: Re: [PATCH] vduse: add virtio_fs to allowed dev id
Message-ID: <20250224164956-mutt-send-email-mst@kernel.org>
References: <20250121103346.1030165-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250121103346.1030165-1-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n3jlNKtMMKdRPLXBivrhLJrJcKthKJUA7Jj79ZNKUp4_1740433884
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jan 21, 2025 at 11:33:46AM +0100, Eugenio Pérez wrote:
> A VDUSE device that implements virtiofs device works fine just by
> adding the device id to the whitelist.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>


OK, but the commit log really should say why
you are doing this. And also why is it safe.

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 7ae99691efdf..6a9a37351310 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -144,6 +144,7 @@ static struct workqueue_struct *vduse_irq_bound_wq;
>  static u32 allowed_device_id[] = {
>  	VIRTIO_ID_BLOCK,
>  	VIRTIO_ID_NET,
> +	VIRTIO_ID_FS,
>  };
> 
>  static inline struct vduse_dev *vdpa_to_vduse(struct vdpa_device *vdpa)
> --
> 2.48.1


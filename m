Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010473;
	b=iXTzafyNUSYn3c15mKMggRjk3SQ2BWd+ZpERxCACkNuOJUc9bVahHiRpawVNKyYMgvUY
	 O4Nq7UjZzVZ7mCsi4vPU76WWkb+JNfBWcCXLRgQhTpSpiwMcw+EDP/Q0vGXLJ5ZnXqyIp
	 Fa6I5Eo7MdC9fVDhTV9TXcTVFv177DutNcj0Uyp2ASOS3TDym6Y//JmYv2JAIDkp5yWIm
	 ru8YWwT5xe+WrfafZtE4PG2hfcnhDt3YKfVSK2kbHeyMbjGPhe0XMPP7dnO1CVN2Hj5Lh
	 P4ftWDSJbaZKmuY6gqUUvc4ePqULtvD6UhXnyZTnxvuLDCWY9X2GNvxCtnHsEZo9VWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010473;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=bh0VMe2Rmm+7gUOYc0+0D8DAZImYcthIyBuGozvhEwo=;
	b=VeA22w01U2MmcLfE/3ulmBjyiRlvkOFrmtUMus5nDDjXYngHxB3J50xshPZsg//5RfB0
	 U94plooFWoS3HOc+CjGyqF301zniK4hryKB43fZkjPwDMwOzF19znXGj6atNlpMfuDNMX
	 bD6oa9nlnn6FCYDkm5g7+OuNvgaurpK5KJTgN4cDXdO2WRuvHKsada5RCyqn2eRvjx6/Q
	 Dbe9IdkRL6aD+bbc+YFXN+LTyQFSTo4laVTTXL1nlLoxM3QGPywfluY06QbuwCqV0wMao
	 +pv+aNB7JiixyQmCGw1n6xeSg7D34H/ORJIoKaZcqGVb2zHk5PlJTQ4YN63I0KHMGyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Khda7wlK;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4916606A31F
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 10:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4916606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Khda7wlK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793010471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bh0VMe2Rmm+7gUOYc0+0D8DAZImYcthIyBuGozvhEwo=;
	b=Khda7wlKgBX1HquEHaj8T+sZqOpGHk5kuuw7ZHI2WFLxo5xOpHzBax3m7mEopkaEw3q314
	8+/WISFV3ROJyc/1GXSleRn8TNHJ4QEBWqylZne/hPKkFpAARDFwOFXTAXMO1r19zCKgQw
	GZBr7Vc2zLOwN0Luk8M42HpXqx8Md/s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-FO-jGtSeNSK19k1AT_50OA-1; Mon, 26 Oct 2026 06:27:50 -0400
X-MC-Unique: FO-jGtSeNSK19k1AT_50OA-1
X-Mimecast-MFC-AGG-ID: FO-jGtSeNSK19k1AT_50OA_1793010469
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e0c896d05so2634111f8f.1
        for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 03:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793010469; x=1793615269;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bh0VMe2Rmm+7gUOYc0+0D8DAZImYcthIyBuGozvhEwo=;
        b=S5lf7jEJ6Rk6uy+ENUoJROGUR0Pl+GkZo3lmDllazT2KELkTu7j8fUuCEnsnLsdtZS
         E2YSqLUIEJSKRlrvNpuNQ7lczf9SL8TajF75RCicPn504JMwJU1paqjQgKWI5ifcWpT3
         ldZHohOmROhxAKOloGKSSn86hLcvJsJDRh6EcjwDLkGeBtHnfibxD0jWH1EjVXAcwkr5
         8ZNpBqsWB7VSQMsZ8HiL46qKJ8XjJPpr0KWWQHKDV7G40upMVEjs7eO7PVuD5fhcLp8B
         RrdUr1jvnsaHB2p3tKaBb7b9m3jfOlfSAHd+Oh+a3504OP1wDcOHi10IgjESvI7MUt6n
         c9Kw==
X-Forwarded-Encrypted: i=1; AKwUvBxuBdh8z5RAnSR7Cz9fqCKtuljVeMRfzKZ3hUsaYfMxMcWsO+RWnlAtTFffK0NSm5vIxNjEO60FdtfET/+dyA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLUvc6qPMYb5yP6OlLRmvOiPHiTh/4Upa3+1FHdbkg3RO0B4UHo
	T9wkJ/gQNSdDP9MFgj16go6tUz5NLbTgdvpsTV9utBAWBA/84qOvUsX0nf9VhXnHFzfKSKoywOI
	eIm/dwOZsA5THhc8XVP9MHMzT8JJmSVgX/C9F/4Pjj126z59xJYlSWAwIKNxa33TgAz4M
X-Gm-Gg: AYBFou3EbkVmRtuPb436cN7JDkyImAhegaHRQH4X+/4QeWFGU10ViF6vJOI4zb75YNg
	9UFXzxXoRxROhnfjriIg/wcKrYhK4rl+E3M/0I5MTJ8g12WsUSKNRZA5y2hlFmgIGjs4fsGlhTy
	QPIT9EHCKMCjk2DyQn4054KGToXunhvxkwt5llq8nUyGukbA4Xw0eVE6OOO11GYGAJbL7OVHMJu
	IubuW+v/VoUC3j/6Iq1lIN+0cJ2K+dwXcOXVf/X1okE5puIaSGXhkWnCy42N1W6fxBeq0bJKR7L
	1WblUGdS5gY7NBsej/jxhLxjsSNwQlLxiLUrkXViBFaxZoqk5QfGFmqzGoknQu1FJes=
X-Received: by 2002:a05:6000:220a:b0:48e:20ed:27f9 with SMTP id ffacd0b85a97d-48e3eac10b1mr11919734f8f.0.1793010468953;
        Mon, 26 Oct 2026 03:27:48 -0700 (PDT)
X-Received: by 2002:a05:6000:220a:b0:48e:20ed:27f9 with SMTP id ffacd0b85a97d-48e3eac10b1mr11919670f8f.0.1793010468317;
        Mon, 26 Oct 2026 03:27:48 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecde7easm15899811f8f.52.2026.10.26.03.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:27:47 -0700 (PDT)
Date: Mon, 26 Oct 2026 06:27:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Flemin Jose <flemin.jose@oss.qualcomm.com>,
	Mahadevan P <mahap@oss.qualcomm.com>,
	virtualization@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v2 18/23] virtio: Add Qualcomm Platform Services Firmware
 Interface ID
Message-ID: <20261026062229-mutt-send-email-mst@kernel.org>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-18-7cf014efdee1@oss.qualcomm.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-18-7cf014efdee1@oss.qualcomm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hWC1hDn4CBEW7WpgrWZ7NPAr2UBonvJq1nYkhqHu83w_1793010469
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 26, 2026 at 11:51:28AM +0530, Jayant Shekhar wrote:
> The Qualcomm Platform Services Firmware Interface (QPSFI) is exposed
> as a VirtIO device with device ID 52. Define VIRTIO_ID_QPSFI in the
> common VirtIO ID header so transport and function drivers use the
> shared identifier.
> 
> Assisted-by: LLM
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> ---
>  include/uapi/linux/virtio_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index f9056af0c622..6c6f283733b1 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -70,6 +70,7 @@
>  #define VIRTIO_ID_GPIO			41 /* virtio gpio */
>  #define VIRTIO_ID_SPI			45 /* virtio spi */
>  #define VIRTIO_ID_MEDIA			48 /* virtio media */
> +#define VIRTIO_ID_QPSFI			52 /* Qualcomm Platform Services Firmware Interface */
>  
>  /*
>   * Virtio Transitional IDs

virtio IDs are allocated through the virtio TC.


Reserving this spcific one as a generic VIRTIO_ID_VENDOR is now under
discussion on the virtio-comments mailing list:

https://lore.kernel.org/all/20261022091645-mutt-send-email-mst@kernel.org/

Please
- switch your driver to use that + qualcomm vendor id +
  validating the device through the DT
- do not merge this yet, before the virtio TC has reserved the
  device ID.



> -- 
> 2.43.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED20B2DA75C
	for <virtualization@lists.linux.dev>; Sun,  8 Feb 2026 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770571939; cv=none; b=VOSrxm/uOJy/0p8+KQDhICHPBP/gL9kGO6S4oY03gpMoBZyneyUsXaNm9fcz7FgBVZm3LmIGtbn8UdNzqAsgz15JJUixfnadOFA++3gnexZvJO5xAl/3JVpYu7wx6vRuSb/g8t9STfOVRKHGYb4RhewEbjJgyDlcKhTKbqSxMrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770571939; c=relaxed/simple;
	bh=AEvdSTNs1SsDl6pEhRmUA1UXlMIvLZZpo5LQw/yYq7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ifuk8QZBsoHcyRd23+wlLokxy4hhEk9q4Co0n2S35mYVx13qPyUyxzTs4eBJbTvwx/LkLQr/pLFHGV7pQLFcZeXuP0Zv1tfkf6TIhjiQ3upijGixVFMqJ5XlY3O/0S5SKZ23cvrf8piC5SCCrXZaFVB0Rrv9RmYsm9mXcQST6do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dHrvdMnq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHrvdMnq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770571938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OenOUUyuTg99CmX32A/sK68Oz1m4ee6pqVCMdR0xc20=;
	b=dHrvdMnq+swab2dZmc79f4HddLsu1RXLye8cM55+wo2vHn5LYfpmjcvDG7AI1q2IltDbVu
	ZuIfgJVJ9Z57NHkN8O5tLD2Z1FO7CdSczBvXZ/Gp0IDnYnCx+iI50hd+CKFlKiL3d6q4LM
	7zY638ufcYMcFBzriKgCh7okVjl2nOk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-GlsjGZ4fO7m_RbYx7mZRzg-1; Sun, 08 Feb 2026 12:32:16 -0500
X-MC-Unique: GlsjGZ4fO7m_RbYx7mZRzg-1
X-Mimecast-MFC-AGG-ID: GlsjGZ4fO7m_RbYx7mZRzg_1770571935
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48071615686so37368975e9.1
        for <virtualization@lists.linux.dev>; Sun, 08 Feb 2026 09:32:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770571935; x=1771176735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OenOUUyuTg99CmX32A/sK68Oz1m4ee6pqVCMdR0xc20=;
        b=F+UHddfhcx/0aEZyTVKqlrtYytQj4/Sd2fitadG8FKknFpQx5jXaGJroyj7hP15qxB
         /9t8PwQzNA2R8LSl6r/Djt6BS6Dk6lBNuIaOI+RsgXfh0AfE7ogXzY52AUoNHqeDpR+h
         PwHHtuPzK9U6SHg+IxUJAqJJTaVziVSLF+flDaBrBAfrpY9O96s2riwpJ8AuQL37gcdD
         UQL+P5Do7Mp6FuHIbA/1Tnh1epvZh1ssHqjl0IpEBV8Kbc58nei2A3JRGaCSsbCCTuMm
         BwuoXSMgzhp4COi5zniTelEWiWL97VB89XYUGyTvGd5X40GJ/CiaVFWV/lC7coqheR7k
         41ag==
X-Forwarded-Encrypted: i=1; AJvYcCWhY0l4WYZkLmrJpcgpRd405RIY13xO55vR6tIwLg4FpTNQTKOf+RtiXS5TQFFGbrupNH1+4EW71ihTeIxVSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxR0O9u+wGiTUweybrbkibtTQ8RyC3x5UAgArIK+KjKiDkmkAEu
	C1K1eex0MmPaLJuyjRnBLJChzW6+YTHKCQH8ApgHR7EZu6G7oUJBtDLyMt8R29k5dm7jyR3EYwU
	OaUqBeWz/+gM24dafnYM3tZf4H3j8CGaskghdU4A0jRqKMHQ6ZSCD8Q8UH08yOsnyl6a/
X-Gm-Gg: AZuq6aKdWGqE7D9XAP/YUyB85idOBXmt737W4dlcI3mBo77s0w1PdSKGor3cN0i2hLp
	Q3fo+GPK0LZUCLti+/4GgkJ/YsaV7KRxLKDZ62KHClU0ikY9W5HTjktXikqgZMtEIdB6r+ihOqd
	VitfBT0tQ+YswRgIG2zQxtMMTvEyJNgAkqt+xhvhjFEOgSkgL/FAtoSOl1na6ektPlNiRITU96q
	6QvGzm2WT6Ap5dcqPvEPDpPUq/VS/HT0LPlp0yAhjsmibHTkIbYWm4u48ZMIRhcvxrMqwiccnQY
	fBYYGTSfJ0GrJd2jGY67mealRTVQY8y2VEjCNuTT7c1jGhcsDi4shJUr0HMEWj9u5GKL1aodDTK
	GWXh92nYNaN1l5s4sjEXh7HSKAzLwQ9p/YA==
X-Received: by 2002:a05:600c:5253:b0:480:1e9e:f9b with SMTP id 5b1f17b1804b1-483201eead3mr146871495e9.16.1770571935089;
        Sun, 08 Feb 2026 09:32:15 -0800 (PST)
X-Received: by 2002:a05:600c:5253:b0:480:1e9e:f9b with SMTP id 5b1f17b1804b1-483201eead3mr146871275e9.16.1770571934705;
        Sun, 08 Feb 2026 09:32:14 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d345c2sm391883135e9.6.2026.02.08.09.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 09:32:14 -0800 (PST)
Date: Sun, 8 Feb 2026 12:32:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/3] uapi: vhost: add vhost-net netfilter offload API
Message-ID: <20260208123029-mutt-send-email-mst@kernel.org>
References: <20260208143441.2177372-1-lulu@redhat.com>
 <20260208143441.2177372-2-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260208143441.2177372-2-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: x4CAE0SJUsOPFDRImuIi_gjyb2w24Xj7jYUmqgu9cTM_1770571935
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 08, 2026 at 10:32:22PM +0800, Cindy Lu wrote:
> Add VHOST_NET_SET_FILTER ioctl and the filter socket protocol used for
> vhost-net filter offload.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  include/uapi/linux/vhost.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index c57674a6aa0d..d9a0ca7a3df0 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -131,6 +131,26 @@
>   * device.  This can be used to stop the ring (e.g. for migration). */
>  #define VHOST_NET_SET_BACKEND _IOW(VHOST_VIRTIO, 0x30, struct vhost_vring_file)
>  
> +/* VHOST_NET filter offload (kernel vhost-net dataplane through QEMU netfilter) */
> +struct vhost_net_filter {
> +	__s32 fd;
> +};
> +
> +enum {
> +	VHOST_NET_FILTER_MSG_REQUEST = 1,
> +};
> +
> +#define VHOST_NET_FILTER_DIRECTION_TX 1
> +
> +struct vhost_net_filter_msg {
> +	__u16 type;
> +	__u16 direction;
> +	__u32 len;
> +};
> +
> +
> +#define VHOST_NET_SET_FILTER _IOW(VHOST_VIRTIO, 0x31, struct vhost_net_filter)
> +
>  /* VHOST_SCSI specific defines */

can we get some info on what this is supposed to be doing, pls?
it belongs here where userspace devs can find it, not hidden
in code.


>  
>  #define VHOST_SCSI_SET_ENDPOINT _IOW(VHOST_VIRTIO, 0x40, struct vhost_scsi_target)
> -- 
> 2.52.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331592;
	b=UIlVEU32SJErKYeNSDnGb/ZRYFQ+nDporfKex1tYbDb0rPQHOnWcRTPzCSwuJjjo0tJi
	 c1vgvlBpfnME4tMMHVC0MSM4vzHjOh5QrPkrAdRTX6mIeuclBduJ/x7sRaYiXb+NIFqq6
	 ere87SyHqDa7YTj4dy6pGMibvgYRfIFs6D8Uo3kw4f5StCkKGAx8lCmBfJncHRBCuOVA0
	 pYILRgYbZ4e0XNa57EYE4eVFR2CtsUs5SYVKRDbqyvVQdMUBousMJ0kjIJ/Q9l5/EClO5
	 jQTbaTX7YDJob5l4QNfg1TA312dPPkdH6QHja7c/zNPpZjyNVGdwFekxJqi+A+AVbrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331592;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=EKRRknjMWCPzWVN1v0/d1lk7IVipZL2/q4GtTn0t/go=;
	b=aViD3AYdqtHXErIS7LChOEy08HudMlowUoWGKQKjwrq+WIFTkBW0562eDlO+m8g4O5fL
	 GQDDhjEm5dcJvlkPX+wsdsouNVQNDHESsdtubyB6RULz/1xyoj1gElosy1ckG846rEzT3
	 yD/eyKwzJgoqvWC/+hKHbsnRPIE+C+r5Kc32WEOjsm5YWeEKH+LE5O/WvlEVJ1pjX69oa
	 LL3CfjsLlcPD7I2ukMWPmqfY3t5MBg56AWXoS34PLxzmV/my3O8vR/rvICRMyiEAerXYX
	 /9mguKqcT6p8OHpc0WMLucvWUjPdG1FKDaWjl9GmGWT7Yz0C76unvd31t2r3xuDb4Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tj0skr00;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EE9606A32A
	for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 17:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61EE9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tj0skr00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794331591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EKRRknjMWCPzWVN1v0/d1lk7IVipZL2/q4GtTn0t/go=;
	b=Tj0skr00V0eP7+ylUEUve3V3jWtNU9QQKLshaxMAP19ngaQ6Hu+jxVt8BTR+4h5HelsV2T
	ZQMaJuK79fYpuv8nJmpynWjXknDAvRNIQpmrrYJU8GGZYgCyqGV8eFkCC9vnIK3bAeLbyT
	QL4IJKhwU6uYI1QYw10mdZq97Ujqs1A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-VY3Mlmo2MJeZeuIN6vutRg-1; Tue, 10 Nov 2026 12:26:29 -0500
X-MC-Unique: VY3Mlmo2MJeZeuIN6vutRg-1
X-Mimecast-MFC-AGG-ID: VY3Mlmo2MJeZeuIN6vutRg_1794331588
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e4d1e29f3so2192077f8f.3
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 09:26:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794331588; x=1794936388;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EKRRknjMWCPzWVN1v0/d1lk7IVipZL2/q4GtTn0t/go=;
        b=luK482cK2xWHF8kQQrR7Fo6oXpRm8tC4bBRb98F78rk99vJwBjpfI76ZAP5wcc/Exg
         i0jwDWyFlN5HMkM4SU7ZSGoUKi6k+08Cit41HauU2yDV8HWpmN+KHZPXtCgoIB3avp7C
         sG0T7ZqRtecN3klgkw/sCvxhcjhgF5sZd/7arpc5P5pML5Fc1k7NpuGhp9Kx8/3AJlox
         C5d0yHp7DEiM2dw3efowAi4z9cn7BDXiY/MTgAS8S6NgUWjmCdXSMN/9RJ7MgnmuW6m1
         XwPyxTcKUqpbG1yKk/z0aRKEoZHWvoKIKM3xiZwq9c2/ODAfJ0Cd7PjnBuSWdm4iCWQK
         tVRQ==
X-Forwarded-Encrypted: i=1; AL+hErEWVjZxoMhJFW3zLooU2g/yduPq2SuqJORQ2fhGmgq/XKi+1F8tv24ArJf0O5sRvHhVPKtgT1HmSLQgSiYbZQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/dseaQ7o0gcGp1Z1ZHJei6/9t7KPBHAPAnKX1UV6ZU3n8JzPwu
	b6XiIyRIQuXa8qrhPAV/pbpRSshKTmXVrssguTvgNk/5LxuxHYebiTzA1H00K+sjq0DrtnuxEoF
	RLpikvvV0rexDAWleKgDhDe8/c3ZkkfWYvPNdbX9RytKI5vY2ZGXjgdIcn8epMApTkFtU
X-Gm-Gg: AYBFou0k+ozMb6NV3nWxMqfKWEY9RqqyLXZx0GsEtO7LsuO+x1t4W/tH46qOYGvVpeP
	42owzRgekpgMwbwUXaJYZ8fQJtnsMLXU68lvj7xHHh9D4ySyrOiZwZIlaFBjIs3FyEzOd7EYtZA
	TvPZEqKaZJE1VvLM+G3WW10Ki5yUpq56A2RgV3Ypi4w/7CSCiRWWMbGGC3yQFeG/pSYgpwmn9VQ
	nG75l712nCgCLS65C7PL6uKSmPpjm2/FkyRvjANJXiSvVjZ97zRhuTvUxbq3J+XPiHVY6ujpDUM
	GITXSjS6jbEcf9GTaNItPgfxUWIMbrHB1GOtw1QHfZew2YIkUffpYXlAiMggmLDyq49HumSEPSy
	2vsNPXj83qckI4UbndevkN5k77jm9QjCLHLrAczvR9w==
X-Received: by 2002:a5d:5f86:0:b0:491:f34b:49b4 with SMTP id ffacd0b85a97d-498309aeeb5mr6440913f8f.44.1794331588070;
        Tue, 10 Nov 2026 09:26:28 -0800 (PST)
X-Received: by 2002:a5d:5f86:0:b0:491:f34b:49b4 with SMTP id ffacd0b85a97d-498309aeeb5mr6440867f8f.44.1794331587415;
        Tue, 10 Nov 2026 09:26:27 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498365ccbccsm6152831f8f.44.2026.11.10.09.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:26:26 -0800 (PST)
Date: Tue, 10 Nov 2026 12:26:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: forfortuna@naver.com
Cc: Harald Mommer <harald.mommer@oss.qualcomm.com>,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	Francesco Valla <francesco@valla.it>,
	virtualization@lists.linux.dev, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH] can: virtio: fix virtqueue use before DRIVER_OK
Message-ID: <20261110122457-mutt-send-email-mst@kernel.org>
References: <20261111-virtio-can-ready-v1-1-0b4dd020af0b@naver.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261111-virtio-can-ready-v1-1-0b4dd020af0b@naver.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o3cbYSiRX0NViutf-VT2gXvJIcqeDIK845CFEBoJFcw_1794331588
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 11, 2026 at 02:11:13AM +0900, Seonghyeon Lim via B4 Relay wrote:
> From: Seonghyeon Lim <forfortuna@naver.com>
> 
> virtio_can_probe() and virtio_can_restore() fill the RX virtqueue and
> kick it before the device is set DRIVER_OK. The virtio specification
> does not allow the driver to notify the device before DRIVER_OK.
> 
> In restore, if the interface was up, virtio_can_open() then sends a
> START control message and waits for the reply. DRIVER_OK is only set
> by the virtio core after restore returns, so the device may never
> handle the request and the wait never completes, which hangs system
> resume. In probe, an ndo_open() right after register_candev() can
> likewise send the START message before DRIVER_OK.
> 
> Call virtio_device_ready() before the first virtqueue use in both
> probe and restore, as virtio-net does.
> 
> Fixes: 083082a4e6d8 ("can: virtio: Add virtio CAN driver")
> Signed-off-by: Seonghyeon Lim <forfortuna@naver.com>

however, device ready means you can get callbacks: config
and vq.


did you audit the driver to make sure this is safe while
probe did not yet populate and register the device?

> ---

> Tested with QEMU 8.2 + vhost-device-can: with the CAN interface up,
> suspend/resume (pm_test=devices) hangs without this patch and
> completes with it. No new lockdep warnings.
> ---
>  drivers/net/can/virtio_can.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/can/virtio_can.c b/drivers/net/can/virtio_can.c
> index f67d0bf09681..ae35a00b784b 100644
> --- a/drivers/net/can/virtio_can.c
> +++ b/drivers/net/can/virtio_can.c
> @@ -912,6 +912,9 @@ static int virtio_can_probe(struct virtio_device *vdev)
>  		err = -ENOMEM;
>  		goto on_failure;
>  	}
> +
> +	virtio_device_ready(vdev);
> +
>  	virtio_can_populate_rx_vq(vdev);
>  
>  	err = register_virtio_can_dev(dev);
> @@ -966,6 +969,9 @@ static int __maybe_unused virtio_can_restore(struct virtio_device *vdev)
>  		virtio_can_del_vq(vdev);
>  		return -ENOMEM;
>  	}
> +
> +	virtio_device_ready(vdev);
> +
>  	virtio_can_populate_rx_vq(vdev);
>  
>  	if (netif_running(ndev)) {
> 
> ---
> base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
> change-id: 20261111-virtio-can-ready-85cefff06a84
> 
> Best regards,
> --  
> Seonghyeon Lim <forfortuna@naver.com>
> 


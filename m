Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D60B6A8D2
	for <virtualization@lists.linux.dev>; Fri, 29 Mar 2024 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729332; cv=none; b=WLC50qpGn6buMUkryl7eZ/xhp4iY6GAOLmhqs7hlRfCXWKpq8bVxTkkQmjvKXKeJEagPP6t/Y0a45/7wDq3ViMZS9HVvfh0cftLhESLbmSbXZNBFs0AS4AixFXJsb4ZxI92nyhYSaUSstn+3ClRHu/axW8y2i2TgKNqbhayOyoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729332; c=relaxed/simple;
	bh=riODE1dPTaLbQpz/0beewzGEpd2nIe52VyxmuEiuHaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SK8Y6yIJfvrJ7bqYjN02vkprVI3jqLqJCkultulEb1GfLTDqaTNv4w2SNa4bPY9Z2SKJSERRrAP+/RP6HshQmZ2KpFDXXynv4N0j6K5uCrP5Np/XTbck/o8Uc7ymzZ7lkcVAUh9Ig1hKl1UyMpduID86wSCezGjLST/qKHq1maY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QPnBiOpv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPnBiOpv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711729328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fmEyRcPuEinvJiX6Dq129jlFJ6SCvYGxlVcOYHlmNDQ=;
	b=QPnBiOpvZPl+IxEG23vr79YEVKdSzecPfBlJPHQuv/0zPdsmAzPSHiw6bvTcXw1QQelBax
	eOClarPaczPG9zbr+zk0XOUBHw3dJRKxMkoQlmHVr8ejacbGqlDEXDf4aVBzOpO04vMSf/
	Zqyp5FRL2joWKHKtxIONvXsyRHsTrOY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-OFcdqF0pOZGfKia9BkNIBg-1; Fri, 29 Mar 2024 12:22:06 -0400
X-MC-Unique: OFcdqF0pOZGfKia9BkNIBg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41545a3eb12so8855565e9.0
        for <virtualization@lists.linux.dev>; Fri, 29 Mar 2024 09:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711729325; x=1712334125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmEyRcPuEinvJiX6Dq129jlFJ6SCvYGxlVcOYHlmNDQ=;
        b=glbTqsG3C8WVUJQAZP4G4P8TkjIrwFGWFNkDHsvqiX5AsgvAysNVhxfjsM7xuUSQ8F
         LR3cI6Mc5AqGKnEUQMAP54SnAKGHLS8OrB193I3hY6bxyotiOvFP8aBmKp5z10eNxqyS
         9RqLSW5z2oomGM2oYqKLg9vBgeyqiw3y5stFlIt9pNrkUi64B+3czZp2iC2UHRrnSBhV
         X+Je9BZE3r/coYCyaF3yetxQWM/TtUi9La0t55RYteJwTMyUKvzSBGhflBJwApdJKmeQ
         65Jcxb+0NLnX+2GZan+mkgCDz1+yeGWbYIQFIAwUHP8LZhgXYXSCTjMT9ImQwF7YHDF6
         iMXA==
X-Forwarded-Encrypted: i=1; AJvYcCX4B3cP3eJPwAUmJqHN2VepkVyCYvatQyeO8i+ussKKKaKPEpTiud5D7nErq2hLkaM1AjkkPZp+IMyvqm+j89ojbrSpRly7prT1qlY9zUo=
X-Gm-Message-State: AOJu0YwnPtx5kH5Z0R7CMygXVi5T1o74ObocMyr7dQjqjwzIBVOYS4La
	OMsK3YCGuGzskQ85u2q0VtWSPMJvUen7xJS8IVU51iSsFPhCUiyJ75W/1KQbCVkyEwSzQCPE+VB
	Gyl+nYKumAOhwDEnuDjfadcklJGjD0XVHvDEpeEvRk35LM8DU9221ivOTsnHLShJJ
X-Received: by 2002:adf:f810:0:b0:33e:7750:781d with SMTP id s16-20020adff810000000b0033e7750781dmr1813666wrp.56.1711729325176;
        Fri, 29 Mar 2024 09:22:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbg6+AHNtlfHpBhKeqnWBXMq04cVofQNecZMc0Hx1QL8O3mLHrvSVma3HCLwksp4G60St5Bw==
X-Received: by 2002:adf:f810:0:b0:33e:7750:781d with SMTP id s16-20020adff810000000b0033e7750781dmr1813641wrp.56.1711729324802;
        Fri, 29 Mar 2024 09:22:04 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id u4-20020adff884000000b00341d9e8cc62sm4478654wrp.100.2024.03.29.09.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 09:22:04 -0700 (PDT)
Date: Fri, 29 Mar 2024 17:22:00 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Marco Pinna <marco.pinn95@gmail.com>
Cc: stefanha@redhat.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, ggarcia@deic.uab.cat, jhansen@vmware.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vge.kernel.org
Subject: Re: [PATCH net v2] vsock/virtio: fix packet delivery to tap device
Message-ID: <tglqxtqa47wu53idfssswmrb6ulhnkdlavt27qoxhp2hniwgxc@j3fmzh5wowbc>
References: <20240329161259.411751-1-marco.pinn95@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240329161259.411751-1-marco.pinn95@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Mar 29, 2024 at 05:12:59PM +0100, Marco Pinna wrote:
>Commit 82dfb540aeb2 ("VSOCK: Add virtio vsock vsockmon hooks") added
>virtio_transport_deliver_tap_pkt() for handing packets to the
>vsockmon device. However, in virtio_transport_send_pkt_work(),
>the function is called before actually sending the packet (i.e.
>before placing it in the virtqueue with virtqueue_add_sgs() and checking
>whether it returned successfully).
>Queuing the packet in the virtqueue can fail even multiple times.
>However, in virtio_transport_deliver_tap_pkt() we deliver the packet
>to the monitoring tap interface only the first time we call it.
>This certainly avoids seeing the same packet replicated multiple times
>in the monitoring interface, but it can show the packet sent with the
>wrong timestamp or even before we succeed to queue it in the virtqueue.
>
>Move virtio_transport_deliver_tap_pkt() after calling virtqueue_add_sgs()
>and making sure it returned successfully.
>
>Fixes: 82dfb540aeb2 ("VSOCK: Add virtio vsock vsockmon hooks")
>Cc: stable@vge.kernel.org
>Signed-off-by: Marco Pinna <marco.pinn95@gmail.com>
>---
> net/vmw_vsock/virtio_transport.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 1748268e0694..ee5d306a96d0 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -120,7 +120,6 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> 		if (!skb)
> 			break;
>
>-		virtio_transport_deliver_tap_pkt(skb);
> 		reply = virtio_vsock_skb_reply(skb);
> 		sgs = vsock->out_sgs;
> 		sg_init_one(sgs[out_sg], virtio_vsock_hdr(skb),
>@@ -170,6 +169,8 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> 			break;
> 		}
>
>+		virtio_transport_deliver_tap_pkt(skb);
>+
> 		if (reply) {
> 			struct virtqueue *rx_vq = vsock->vqs[VSOCK_VQ_RX];
> 			int val;
>-- 
>2.44.0
>


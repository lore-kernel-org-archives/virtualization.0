Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B240D32A3CC
	for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764093476; cv=none; b=IFeGfOjqZ/7U9DrNRhx2ifDyOiqF9KcY3Nz8nE2DSvPgLy0j/TkVHBNoNw15ZyviT0/22l+7/E/idzIi7+Fvmq3MpNYkviNpxirJh2BWbF9tt6W11NC64lSQqiKFv9cArk5LsGDq/KPRKxI4Lp8qlttFztVNdZY08JE2b26urPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764093476; c=relaxed/simple;
	bh=Fs83rTTPnZoefNeB88lzRj2Zrxjcng2SgqTDnxbSr4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=T1gtI4OXt/7Q4SOcSQrtba5dxYelXkbIllo7HObVWTcaARG3HfAJDENby+Yo/kJRR0kvk39Jv1lcjONBqvExL2OSmS94sP18m7Ip0kGTnDhLpr5in6rfMjpVQUJ7qn8vE7QAIJNUsxfgeY7NBg1/9wxQ4k4NDsIqijt1WeBW3rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G7Caciyi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7Caciyi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764093473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBBNljc5iFCuzwl9ZqmN5RW/+AydF/L+sgiYuUnYeUI=;
	b=G7Caciyi2ZOJPOC7DRfy/R232fVrQRoRssk9MfPqVjeWyumgb3rRDmCltpNmLtSEbHuB7s
	lqjlWHIXnItJUfC8kYlkCIe0x5wbW2LMBwFGUkq8Md9NAF2OtTbpBa6CAN3quBYnx7JSe0
	lj7dLkrP5yICZ0l/R49izRdboTmvtkk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-3rzwInOZMyWWLRQjguGJ4w-1; Tue, 25 Nov 2025 12:57:52 -0500
X-MC-Unique: 3rzwInOZMyWWLRQjguGJ4w-1
X-Mimecast-MFC-AGG-ID: 3rzwInOZMyWWLRQjguGJ4w_1764093471
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429cceeeb96so3549607f8f.1
        for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 09:57:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764093471; x=1764698271;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBBNljc5iFCuzwl9ZqmN5RW/+AydF/L+sgiYuUnYeUI=;
        b=q8M4eiq7sC+f4cl5gX2RMitwUhVP18VC91R5eWtQP1HKj9WHT9UvMG9JXDICLidXBp
         wScLsqcIVkkRzrIz3E1ZilDmMdFItwQRGPlG0vzOj7yqpLhIvisMIKODAb3CqIxKsHWl
         6tIszaZ8hr5Wc+7tVTgW1wp2raJch/jDn1gdbbbT7Ypb5Bi/ELjXV2ERlj161f4M08aR
         58S+RkN+yuDZdD2f4UM/BUrjFlg+KXuAAkGokXG8uo8XXfwchrZPTK7t6cDEB/FGUleG
         heIrf9hO+c+tW6wCVfDC8uxvflF2zyDdHzh+bX7Gn5rS8ugXo15tDkaNXr5qGF7xhYnn
         bh2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUYYrpCtrFyPO1a1MOeTJBP/ik91EmaIemNvlXqv4uv0O8GuEck6tw9Gl3ax4IfpcYouucy/Kag8gYjav4dw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPJg0VFvau9xGAyv+tbmukz9s/bYr9ZvAYD95sVMLGPx3UvYBh
	RquCzLxTQ7bvPdGI7eM4hEzxD1k6HlANutQMW6rIzGht1ApjrFRL+x4YRJlH3G9ZqgiATTQjGOx
	ZtyiheKHXRHTHsUGF+TOcHpfeCV/7BiDI6wH1es2ihVdr243lqjnRB5/nFCUfG8QzMfb6
X-Gm-Gg: ASbGncuU7r+IG0P/wdrMzZKeF8qENFzIH/MUEIkSnPjGCigaeCYxUcO+xNhrqFZGSWG
	/QgIaFoYEaAnzSOWHOuxjFyYzZnj92MirEnoY5ps+Bf3HoCMS7xOloaozjX7o1Efm1kpXHJ2hlv
	XtVkOCsWqToUVMgVVGfgUDmF/cHWCxvMzSYUvXQXqwKonOEbiXh5Vg4KrMioSil2YSKSPw0UHsu
	q2rl/ELlMbc/aOm2OQj/4W3fIgIdy8ienKDlnAI/W7CvOKKLf2co5O0Scqr9LFCdZgQ5JvPeLhI
	mlmKsCnieWWyLV4f9LRKnQnX3cBTzVpXvQy8nwEohQuM+UAyfnHN7FiBDAh+gTv7QVyhmsIc5gg
	=
X-Received: by 2002:a05:6000:430a:b0:42b:3246:1681 with SMTP id ffacd0b85a97d-42cc1accdd6mr17107052f8f.18.1764093470975;
        Tue, 25 Nov 2025 09:57:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHo3snX1o9Z22+ePohjUgGpFTEU10kI9WW/GDIDglDYteMzSXiD2riD2Rl+m2cCB65iYkPtyg==
X-Received: by 2002:a05:6000:430a:b0:42b:3246:1681 with SMTP id ffacd0b85a97d-42cc1accdd6mr17107029f8f.18.1764093470584;
        Tue, 25 Nov 2025 09:57:50 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa3a76sm35703266f8f.24.2025.11.25.09.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 09:57:50 -0800 (PST)
Message-ID: <276828c5-72cb-4f5c-bc6f-7937aa6b6303@redhat.com>
Date: Tue, 25 Nov 2025 18:57:49 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] virtio-net: avoid unnecessary checksum
 calculation on guest RX
To: Jon Kohler <jon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251125175117.995179-1-jon@nutanix.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251125175117.995179-1-jon@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nPWC_6DiinBPgQE_9CDpeo3APiXkdRLE-MVMoZk3rAs_1764093471
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

CC netdev

On 11/25/25 6:51 PM, Jon Kohler wrote:
> Commit a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP
> GSO tunneling.") inadvertently altered checksum offload behavior
> for guests not using UDP GSO tunneling.
> 
> Before, tun_put_user called tun_vnet_hdr_from_skb, which passed
> has_data_valid = true to virtio_net_hdr_from_skb.
> 
> After, tun_put_user began calling tun_vnet_hdr_tnl_from_skb instead,
> which passes has_data_valid = false into both call sites.
> 
> This caused virtio hdr flags to not include VIRTIO_NET_HDR_F_DATA_VALID
> for SKBs where skb->ip_summed == CHECKSUM_UNNECESSARY. As a result,
> guests are forced to recalculate checksums unnecessarily.
> 
> Restore the previous behavior by ensuring has_data_valid = true is
> passed in the !tnl_gso_type case.
> 
> Cc: Paolo Abeni <pabeni@redhat.com>
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
>  include/linux/virtio_net.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index b673c31569f3..570c6dd1666d 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -394,7 +394,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
>  						    SKB_GSO_UDP_TUNNEL_CSUM);
>  	if (!tnl_gso_type)
> -		return virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
> +		return virtio_net_hdr_from_skb(skb, hdr, little_endian, true,
>  					       vlan_hlen);
>  
>  	/* Tunnel support not negotiated but skb ask for it. */

virtio_net_hdr_tnl_from_skb() is used also by the virtio_net driver,
which in turn must not use VIRTIO_NET_HDR_F_DATA_VALID on tx.

I think you need to add another argument to
virtio_net_hdr_tnl_from_skb(), or possibly implement a separate helper
to take care of csum offload - the symmetric of
virtio_net_handle_csum_offload().

Also you need to CC netdev, otherwise the patch will not be processed by
patchwork.

/P


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905CB3955C6
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016669; cv=none; b=mZJUwvqVIVWHJHPLmF5a5IBO7Y10QbDpBuQHJC7Gb7BGz2jcEKq4X4WPEKr/UnOiVQ+z9+ni47AEGcLEfa2Tcu17NOrA8M0HSSuF7ujvFZ0hyFXzYDX8Ra0s9uzMg1S0rhDb6jfuXyiZlYVhWxohHTm71RtNjUx/w7H8JB9Pk78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016669; c=relaxed/simple;
	bh=gWQ/Il4P4t0zTHBxAJZA63W9tJWeyjxCRza7HeFyBSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LY4lV92dppGzdgOk5PXmgjQwzI8cBO4ZcDdVxAA3ak8G5HFeDp5SEvjwDjAWpFk7by+IwbhMIBK9cw91mUqc3fXT8HZ/8tdbW73b2BbFoiS1h9mzSnFxVn0kyahF8iBSXX83pt4EH56z2SPwxvRzq76Ul4cZ3wH7oAVWtFPT2Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TL0oz9oI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TL0oz9oI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781016663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LzesbWGj4YTo1y0et+ljf+77fl9oQ9V4yKu6m9JZpcY=;
	b=TL0oz9oID5yHWYjQ2wrJyGFEPTnrl025s2E7U64WihCHjJUkCi6NVSEWvEXnHCL8BuIbEm
	1/krOTzCsWnrjrqkQwvzapFz76ZUIeH9ajw8+sU6k4pP99FsfMhVc4WSlkhQFex2x5Z8gZ
	8ic8fpGoy4DHivrAsLYUjUYp+3pQz8I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-n5ayTnYRPii6tAInk-AkQA-1; Tue, 09 Jun 2026 10:51:02 -0400
X-MC-Unique: n5ayTnYRPii6tAInk-AkQA-1
X-Mimecast-MFC-AGG-ID: n5ayTnYRPii6tAInk-AkQA_1781016661
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef3aeeb41so3691454f8f.1
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 07:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016661; x=1781621461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzesbWGj4YTo1y0et+ljf+77fl9oQ9V4yKu6m9JZpcY=;
        b=BIAUy4plMoehjM3W2yuPspq7UfhB4uo9o+SH3pPuW3JWIQVhzMPhvoE5+EHIwpX7Tx
         shgotkw7YIeyFAwFM2yUcJurl9ZreIq6ijcUx5QaL9u1K1cAQAUL5jMILV71mWexzxs3
         F+55XzRfRkqif9yqi1HC5qBI/G9pzWwdqKo1aA+F4Px36hXbZgTYAhGZ6A8tWB5+wPCq
         05oCWkvMHOpgx8g2dCQqmnKLxdLDOrPAC99CoJgVDjPvy7iYlDqhcuPuNJdmIO9DUXY8
         ps20s2sAT0LfNx/MGX1eTraNMUTHPr6gBVEILCvAgYf/AFsKzJDDdmKO7OqSjLzitb53
         fhng==
X-Forwarded-Encrypted: i=1; AFNElJ98j7BRgbCZxGWt2nK3AgwDUvxnIW1E20xj6Unm/bzbxuz/ACgTJQ2k90nuTpUPHeUG9zZUPOI659K8+9en6g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9K46Wa8AJmdbuyfg/VAWJBAEAPK9uHbkG/VHKB7LbPeWsz/3G
	5YkZNZDw/Wrkb7wp4NQ0Hh7RGTcU/jPQuHS4jVsngmsh4HixxVcajVigjfQopKbTtiQrr5bs4hW
	34z1P/AjLizLZqP5qkwxR+ie660HJCIBUM/ELasdoGPGfUJHvcpfkgdiBgXD3h7Uwn/xW
X-Gm-Gg: Acq92OGpp5jOFKD1mIN/hLAzLeXXlUvfVIl6YETmMAnTbA7EDwm+3BYU3cPHf+whdfC
	epWtxD+tQhWDOhCL5QytTXNEQP987EZJaeCNyidsRqRFNb/ooL89uFlRF10gKZrVoEmbUtc2WT6
	HTIOClfUhpgqv+2KZNrSXkm91NLncWaRBDMJQoyh7wh+8Kny8RZTvWc8AoCQnse/xDMlKfTvurJ
	vMv1P9XpS9uQXGeJUTAzlOLkpf1JT/Ay75vPGPdYLpEtEoiF1DTTzK4FCa6Djl8SfHRmGykVewj
	BEP/LHvp4BKWFabdsQ/AGD384v92VgphpoiPw8OIO12G4W6g/3U4ySEUBlKCD0UeNJyLYXM/WgO
	UjiDOhwJYPDPaCPz7JrTL/q1oXpxl4X99/QeAPE55FJiLnOGTA0600Q==
X-Received: by 2002:adf:e608:0:b0:44a:2cb3:b633 with SMTP id ffacd0b85a97d-460304fae53mr23680411f8f.12.1781016660814;
        Tue, 09 Jun 2026 07:51:00 -0700 (PDT)
X-Received: by 2002:adf:e608:0:b0:44a:2cb3:b633 with SMTP id ffacd0b85a97d-460304fae53mr23680357f8f.12.1781016660290;
        Tue, 09 Jun 2026 07:51:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35133csm60643986f8f.25.2026.06.09.07.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:50:59 -0700 (PDT)
Date: Tue, 9 Jun 2026 10:50:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net] virtio_net: do not allow tunnel csum offload for non
 GSO packets
Message-ID: <20260609105050-mutt-send-email-mst@kernel.org>
References: <38d33d63ce5d1aee486bd6c7c47345040d526e35.1781016169.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <38d33d63ce5d1aee486bd6c7c47345040d526e35.1781016169.git.pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6gcudFIS8UcLAfhoNdNg0iDR5ovFwREiKmif9fRxzwE_1781016661
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2026 at 04:44:26PM +0200, Paolo Abeni wrote:
> Fiona reports broken connectivity for virtio net setup using UDP tunnel
> inside the guest and NIC with not UDP tunnel TSO support in the host.
> 
> Currently the virtio_net driver exposes csum offload for UDP-tunneled,
> TCP non GSO packets. Such packet reach the host as CSUM_PARTIAL ones
> with the 'encapsulation' flag cleared, as the virtio specification do
> not support this specific kind of offload.
> 
> HW NICs with UDP tunnel TSO support - and those drivers directly
> accessing skb->csum_start/csum_offset - are still capable of computing
> the needed csum correctly, but otherwise the packets reach the wire with
> bad csum on both the inner and outer transport header.
> 
> Address the issue explicitly disabling csum offload for UDP tunneled,
> non GSO packets via the ndo_features_check op.
> 
> Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
> Reported-by: Fiona Ebner <f.ebner@proxmox.com>
> Closes: https://bugzilla.proxmox.com/show_bug.cgi?id=7627
> Tested-by: Fiona Ebner <f.ebner@proxmox.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..07b8710639f9 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6222,6 +6222,18 @@ static void virtnet_free_irq_moder(struct virtnet_info *vi)
>  	rtnl_unlock();
>  }
>  
> +static netdev_features_t virtnet_features_check(struct sk_buff *skb,
> +						struct net_device *dev,
> +						netdev_features_t features)
> +{
> +	/* Inner csum offload is only available for GSO packets. */
> +	if (skb->encapsulation && !skb_is_gso(skb))
> +		return features & ~NETIF_F_CSUM_MASK;
> +
> +	/* Passthru. */
> +	return features;
> +}
> +
>  static const struct net_device_ops virtnet_netdev = {
>  	.ndo_open            = virtnet_open,
>  	.ndo_stop   	     = virtnet_close,
> @@ -6235,7 +6247,7 @@ static const struct net_device_ops virtnet_netdev = {
>  	.ndo_bpf		= virtnet_xdp,
>  	.ndo_xdp_xmit		= virtnet_xdp_xmit,
>  	.ndo_xsk_wakeup         = virtnet_xsk_wakeup,
> -	.ndo_features_check	= passthru_features_check,
> +	.ndo_features_check	= virtnet_features_check,
>  	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
>  	.ndo_set_features	= virtnet_set_features,
>  	.ndo_tx_timeout		= virtnet_tx_timeout,
> -- 
> 2.54.0


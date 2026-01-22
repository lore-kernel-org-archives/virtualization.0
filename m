Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEE43D3015
	for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076955; cv=none; b=GIOvpfEOsVCD7kwlFwLTuivAFi3x7c1kmZ49JomdM5VqyUBVxsY/HhecLc/aaWPv1fxO24skBWIgd+sNseR6QAeGDn1hZuocTPGi6n7gvH3yPwp9ndrYXL6eJl4a7CiNNR/iWgn68YOJyihS7R2C20j8gCmxorZuSZOrKC2Ow3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076955; c=relaxed/simple;
	bh=cLWD5StyzKOyO7yoCmi6CCtfpC4wozVdHrKYhZlWRqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KPgQ/MOLyfoLW6gcRdiGHxZhKzrKofkIi4/JNYcsTSIMHgiV12dpmVvZU5qgzmsgvsu80ldb17F43d+QFAmCSKzehzxFVJygJPTG1KOB4gCO60AS6jlK3CvL93qpBKsZbpvg3tIohiaEyoC6jHEN6uqDhJoN5U3Sq9Vqr7aYQ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PCkcmMJb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCkcmMJb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769076953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6TlFQ4aqfsVGvAfPKjF05UStD/LMGRRXDrUJQq0z6pY=;
	b=PCkcmMJbfhgKSxtY29LgB6bdjT/rGIAqa1sYvWiQ3/oKaOS1PzRoQuL5ekxDKaUSj8D9K+
	OljA1H8dKgllTcs6yjvsv8XDNRnfIO36AOeHcd/gR4p+uJhEkTVQLE5VHGkiEv115u3+la
	eCR1gO7PD9xeNDkdSWDYZ9Ql/bZz70g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-sm7cp9yaOXGdwiEQxR6NEg-1; Thu, 22 Jan 2026 05:15:50 -0500
X-MC-Unique: sm7cp9yaOXGdwiEQxR6NEg-1
X-Mimecast-MFC-AGG-ID: sm7cp9yaOXGdwiEQxR6NEg_1769076948
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d3c9b8c56so15030705e9.0
        for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 02:15:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769076948; x=1769681748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TlFQ4aqfsVGvAfPKjF05UStD/LMGRRXDrUJQq0z6pY=;
        b=BjxypGQCR8zuOlUoZRbyAoct68LNwDgmBjaOONoj/6FgkJYDp5cfYbciVyJDL3+BMJ
         Fj9AMqprmQJgGNL9IzR10U8aeh09Y6AT3aSjAwEZwKuBmjSDXOSTGHxheqy/Gs7suXLy
         WoJAEreounT0QXR+fK+vWj90Ax6MuNK938X2WhZFdpi3RpVjzQVhRnvlmW5NLRZNKOox
         HzzLUO1D8snH+rqvDqe5I7c8pHP9ghtjWZnEtTlq0wqMO/m5Y1xlFZXty1LwEpFC4e2z
         SgaW4s8e4GSwdGMiEUTJnuGYtLWhieWRLHMnOGlxbwohmO04cKZacyywHvpJRNzOrsCU
         PE4A==
X-Forwarded-Encrypted: i=1; AJvYcCWJXe3vrTl/Y/0wKdjnLsRttyxLfyj2YInGWTM6OMUYGNIG2UyrSR7vIrUoLFz3lyVlvfE7B56FmBLWIEuIeA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzH46UHcdgEOfLluEo6aCNdc2OzZiy/AulNBk0YdvgPZTAoyx4H
	NXREJ/VWkAJw9m5n2tQx0gLwXzzWAb4Y7qutYMbdEuxYaP3dcdA2mVe9lfo5f+h8GMCRoXQRQLH
	+WtHV7NC3CUmrXlzifFBnQt+Z2RPZHw2z4sTRYKh+K9xXhfu8FxBbMxpOX4TbNU91XkCB
X-Gm-Gg: AZuq6aIzwFQ4Mzmy3oZw4kqSNRk+Ee62V2C4V7/i2iDD4JTPL+LO8X4vst0Qzkbs0HZ
	YxuXCtNmNYDkvy5JzSU5TxazPGQgCh72raPDw8/kvHaBBi3ADp6Z3ExKCzYT3xqKkzPhSvlKoJa
	TUwuLslpO8YKK2J1hqux5P1vC7bVnKOLpMWSWhw5VZuXdcO0+3oTIiIdyRYz2vtKYpM+Zk9g51q
	m7ls8qjJZ1nJkVfFhx7nd9eE2bIp0rJLExviaAL05uyYZZZaZbBnJzt57kUGMfcEMhUvHCA/WsQ
	DEZlskKpoNX05DbFl1VWz0d6/OWyXKoBwcoONRIW3fqRKbJxFVMZWo8HZn3xusyAcRMr2olV4HY
	KELmLUJNQq3KAW1FKyYE7phFeHIQuZ0WGUg==
X-Received: by 2002:a05:600c:45d1:b0:480:1d16:2538 with SMTP id 5b1f17b1804b1-4801eb03358mr249608825e9.23.1769076947691;
        Thu, 22 Jan 2026 02:15:47 -0800 (PST)
X-Received: by 2002:a05:600c:45d1:b0:480:1d16:2538 with SMTP id 5b1f17b1804b1-4801eb03358mr249608225e9.23.1769076946866;
        Thu, 22 Jan 2026 02:15:46 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804703b5b4sm55737715e9.5.2026.01.22.02.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 02:15:46 -0800 (PST)
Date: Thu, 22 Jan 2026 05:15:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	pabeni@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, ndabilpuram@marvell.com
Subject: Re: [PATCH net-next] virtio_net: Increase RSS max key size to match
 NETDEV_RSS_KEY_LEN
Message-ID: <20260122050904-mutt-send-email-mst@kernel.org>
References: <20260122091527.339180-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260122091527.339180-1-schalla@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4mR0I_-jfI8V3BCgTXh-IxgptnoR4F0Y7Ra_pvshaIk_1769076948
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 22, 2026 at 02:45:27PM +0530, Srujana Challa wrote:
> Increase VIRTIO_NET_RSS_MAX_KEY_SIZE from 40 to 52 bytes to align with
> the kernel's standard RSS key length defined by NETDEV_RSS_KEY_LEN.
> 
> The virtio specification requires devices to support at least 40 bytes
> for the RSS key size.

Indeed:
	The device MUST set \field{rss_max_key_size} to at least 40, if it offers
	VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT.



> However, devices may support larger key sizes
> up to 52 bytes (as reported by the device's rss_max_key_size config
> field). This change allows such devices to work properly.
> Previously, devices reporting rss_max_key_size > 40 would fail with
> an error during initialization.

This one, yes?

                if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
                        dev_err(&vdev->dev, "rss_max_key_size=%u exceeds the limit %u.\n",
                                vi->rss_key_size, VIRTIO_NET_RSS_MAX_KEY_SIZE);
                        err = -EINVAL;
                        goto free;
                }


Hmm but why do we do it like this? I suspect we just got confused with
the spec: > vs <.


Can't we just do:
min(vi->rss_key_size, VIRTIO_NET_RSS_MAX_KEY_SIZE)


If yes I'd like that fix in addition to the increase.



If we are validating rss_key_size  against 40, I think we should clear the
feature rather than failing init completely.






> The driver already handles variable key sizes dynamically through
> vi->rss_key_size, so increasing the maximum limit is safe and
> maintains backward compatibility with devices that support smaller
> key sizes.
> 
> Signed-off-by: Srujana Challa <schalla@marvell.com>
> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db88dcaefb20..5f06cbc058d7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -381,7 +381,7 @@ struct receive_queue {
>  	struct xdp_buff **xsk_buffs;
>  };
>  
> -#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE     52
>  
>  /* Control VQ buffers: protected by the rtnl lock */
>  struct control_buf {
> -- 
> 2.25.1


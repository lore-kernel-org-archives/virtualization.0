Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C734CF471
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792195066; cv=none; b=kIPRDjx2rQvbL+HoCrdvJhgxaEebknMMvqSaMtvA0nkdyTy7yi65I3rcov7jeVu4XpAFbl+A4JUOi26d2dy1SnZPlbB0shfWbElOTy2YuRJH23yoVCpd85VYhyW4J9AkFtQSWl4OKpgz02+/6gtTkI7Trq9GAukMYCTyiERnOEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792195066; c=relaxed/simple;
	bh=SYwBoc6lridL/+OSfqP6JQDDklUqd07zyUUHXQrJ4q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MbSCG85dh/9BqOPeCUsTUj2gKG3w6FJTGtBRplH1Qx6dxOn2Sh5l8ewoyPSK/O7Yds3dJfBphAAHTqG67GMzFgk9FLy94UmBlezZDr40fw4mS5tsLzcnXU9KlCxzGamiqfgvfvHVU9xZeq9yOKzppZtsjEfG3R9f9N6Q3DpjEwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bv945dHc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bv945dHc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792195063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qOKVAt0on4azaGyL+2yuKkrJq6J+UyxVY0ZXT9K1Dc0=;
	b=bv945dHcP0ziwlUR9NGUI5jTCf9qWAJrzWpZgiA1OGD+/+ECwMCQcVeSMeNEW9Pm/wj/0V
	F7PMoZoG4QYKDOuKpCPETcVBlBOdMqXYfQJPdN61xTNILT5M0hAldGEG9p4z11mpO/cpw9
	6hF5ykPst8PQxT63gHPT1Vqk/phCI74=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-_ZqUg0FAOjuF72qZzPPCIw-1; Fri, 16 Oct 2026 23:57:41 +0000
X-MC-Unique: _ZqUg0FAOjuF72qZzPPCIw-1
X-Mimecast-MFC-AGG-ID: _ZqUg0FAOjuF72qZzPPCIw_1792195061
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48af5a07314so154448f8f.2
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 16:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792195060; x=1792799860;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qOKVAt0on4azaGyL+2yuKkrJq6J+UyxVY0ZXT9K1Dc0=;
        b=t/h5lW6ICotlk9i+d/KQHdZCpL+IycdNFkLIIRCTJEOw1vNrZbTSMyyYc24c3sjDO2
         kW9iQdQq67uT8zRD6o6i8w8lANyO/e5H+1GPM3bVqk82JgLNTHH0cNeCmdu3D+iG0/EU
         KATG88zJPeyyGkz6wpDGG775W8cO+suhsGWcjS7p7Isc5uVf/iBN2hSDMC1h2WRXXFn/
         k+xi2XHw+MVhJJkTO2VkgqfT5ADc/FX61KVIEPEJZ9MZaJD0bqCSb9QpMp1UQmEypiIj
         9WRE6efWivo4XyvIfu29wejXuPRkIzdR+SdqkONrDNs55RaHSwiuuuHLnX2y8CNt5UeW
         do9g==
X-Forwarded-Encrypted: i=1; AKwUvBzrRcTLY8fbWMMpEa10GhyJyldYBl/UJ0IB93hbGoNP2qO3K5F4OJDUUvIu+eLdroV/UaK53pJvSasi1+A5+Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYLQSo4LNTU5TNPcTiEEgYR6+fqwGKvZXGh1HVWNoPqv26S4Rn0/
	SOybRvBhd6mxWzYBfBvnOXo3ihZbdATDYJBZiqD8diYEJMzu0M4BbhC4OgVxtOZq0F4/Z9Y2ovv
	iyZgbVOakwPEkpmXC8YAAH3exw1+RYQakqmPg7D2MlnKefOl4/YQaqKALEIKEQ4cmpiPk
X-Gm-Gg: AYBFou1h99vopMMsyC14WsNI8CSW6P1pCiYSnFhIpsm2C7OlXjujBTAWruRy1+i9x+9
	GLHHnOyA124cBuj0YjQ0LlU9jfHwL1Cbtx4tsmQHZjfNyUghoqpZa5VafZA8Iw96TBf/U1ag0Mc
	rq+CWShtQMM08Q4FMRlN1X7WOGjEAg72AAWQpBoG7OqyWmK/WJ+ePG8XbW/ssUA4CkA/5BRe/9v
	9Ob5+kixbrEkFz/ujyEWe1Gm6oOPVIChP/IHMWC3BqHxlgj+3aC9cqbIurl9Oz3+R3KAriNN199
	ezppE5f+UXd1XIKQO9D/Ly2RuVt+L/SJwS/kPWmBJd18RGzT6gyu1XtizF/ywuGWBHu5WRU=
X-Received: by 2002:a05:6000:41cb:b0:48b:10c8:2181 with SMTP id ffacd0b85a97d-48e07f9a2b1mr2014690f8f.27.1792195060427;
        Fri, 16 Oct 2026 16:57:40 -0700 (PDT)
X-Received: by 2002:a05:6000:41cb:b0:48b:10c8:2181 with SMTP id ffacd0b85a97d-48e07f9a2b1mr2014659f8f.27.1792195059909;
        Fri, 16 Oct 2026 16:57:39 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73fb:d100:601d:d7d4:d03f:527b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4d4dddsm8072055f8f.22.2026.10.16.16.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 16:57:38 -0700 (PDT)
Date: Fri, 16 Oct 2026 19:57:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Megane Hebo <hebomegane@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	jasowangio@gmail.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, willemdebruijn.kernel@gmail.com,
	habte.yibelo@gmail.com
Subject: Re: [PATCH net-next] virtio_net: validate csum_start before
 installing partial state
Message-ID: <20261016195543-mutt-send-email-mst@kernel.org>
References: <CAJPVW+=TP73rBavAGTJVqXVN4Uer6JwOi210+2V8nDsH=H=BcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJPVW+=TP73rBavAGTJVqXVN4Uer6JwOi210+2V8nDsH=H=BcQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IxaYAN_gsyh0sc0Jrx_ZYin7gvIzvmTvEBaY4Bb5v54_1792195061
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 16, 2026 at 02:25:31PM -0700, Megane Hebo wrote:
> __virtio_net_hdr_to_skb() currently installs untrusted NEEDS_CSUM
> metadata into the skb with skb_partial_csum_set() and only then checks
> that the resulting transport offset is beyond the minimum network
> header length.

and? why does it matter, the packet is dropped.

> Validate the raw csum_start first. Successful packets are unchanged,
> but malformed metadata is rejected before it can transition the skb to
> CHECKSUM_PARTIAL state. This deliberately does not replace the broader
> ingress validation being discussed for virtio checksum metadata; it only
> narrows the state transition at the existing check.
> 
> Link: https://lore.kernel.org/netdev/20260922030310.8684-2-habte.yibelo@gmail.com/
> Signed-off-by: tonegawa <kiyotaka.tonegawa@gmail.com>

what is the point?

> ---
>  include/linux/virtio_net.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index d6466f96cdd00c..c8180f1222f492 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -102,9 +102,9 @@ static inline int __virtio_net_hdr_to_skb(struct
> sk_buff *skb,
>  		if (!pskb_may_pull(skb, needed))
>  			return -EINVAL;
> 
> -		if (!skb_partial_csum_set(skb, start, off))
> +		if (start < nh_min_len)
>  			return -EINVAL;
> -		if (skb_transport_offset(skb) < nh_min_len)
> +		if (!skb_partial_csum_set(skb, start, off))
>  			return -EINVAL;
> 
>  		nh_min_len = skb_transport_offset(skb);
> --
> 2.51.0


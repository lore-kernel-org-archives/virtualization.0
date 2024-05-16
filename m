Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0994D1E516
	for <virtualization@lists.linux-foundation.org>; Thu, 16 May 2024 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715862802; cv=none; b=S5WzWZF7t1OSfGXUb7Z7XUkJF5R8UYUcsqz9cdt18KRC/oC01jL5nJs+77ZDFRagBvSCl5ZL4x416t5Nq+VDmpjYqgqnzn8pqu/RKtN2Webi7EvciyyCg1Sk2zCEexpumFBSkHUNoiGBVXpB0RsW2G2nEr8Y6AvrAXXmNnU/QBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715862802; c=relaxed/simple;
	bh=kG4YbPhbEHf2GsE98OI9GeD5VDcN/gjk8FDCVUgYQOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KInzJRFm4Uf2QUFMz5JBbrhN0aaVFwaiM1whm+/QuBPbciqi8rQeHEZzgyaUCMLBIbA2lxtwGvlraZrKwVciPzc4gxeWzqcPcTebDs7o8D8L/FJ80gSWS25+4Gni36sXjAuxngsuFpMnePZcCWCNVu6NcJw6LhvNYhukfL+rKuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yf4x5SsI; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yf4x5SsI"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A517B40B2D
	for <virtualization@lists.linux-foundation.org>; Thu, 16 May 2024 12:33:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CmsUlsID_yTj for <virtualization@lists.linux-foundation.org>;
 Thu, 16 May 2024 12:33:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D77D1403C0
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D77D1403C0
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yf4x5SsI
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D77D1403C0
	for <virtualization@lists.linux-foundation.org>; Thu, 16 May 2024 12:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715862798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8tTC7ohyTAFY3GRYmUhC1nAYpxmmnw9+Ospuc7sYSlA=;
	b=Yf4x5SsIQDsjTl5PZrPGk/skHif2d87fnKOGYvl7NBMYcKzbOiv/Woy2AIAA3kH8f5twst
	qJBISd1ZVJ0yBPhqXLfsmUO1A6VWwrbGkt84pQCy7OO6+twxKQns/zNfSeP0T5S1l3slFN
	EUzF9xGKL+cvnG0jXSeb1ieh9oDyLfE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-UFnJtUr0N9aFPF6bTlDoow-1; Thu, 16 May 2024 08:33:17 -0400
X-MC-Unique: UFnJtUr0N9aFPF6bTlDoow-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-572babec6c6so3384639a12.0
        for <virtualization@lists.linux-foundation.org>; Thu, 16 May 2024 05:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715862796; x=1716467596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tTC7ohyTAFY3GRYmUhC1nAYpxmmnw9+Ospuc7sYSlA=;
        b=pBGipbda1mssrytDAp2iiInjyV4+CLfO0CQldqsSonfaNpw7s6Oy/qfe82zpJTg+AS
         wvcSH91AdaB2401sM/8/I6yrAnHyYp2XxN+9lJR4G146Ile231ZdorDp5GonBkar9G+p
         r+R6fvEUu3dNXjtBoe33z1yqgvaEiRV7RsLumx7zI57eH/P1XM0bCgVek2PltGucFL6b
         qvPhx/xoD80PpuwOLRJwCcvoM9XTi+vwaOW2VIu7KYm5cE62bxw6rG8z2qG4a+ZxMVW6
         l0WxiBYrpfOol0BSgDv/Trkb4vNeadAeqSx8neXIs2qvGLFOyURDxnalfy7Lm6hyvW50
         KRqw==
X-Forwarded-Encrypted: i=1; AJvYcCWpCoPZKP041Vb7H9/S9h+iy+TnxMolJ7oEd2WZAkWJpskXgUW5c2c1At6DagTpjKOUD98PK56W1iyoNWPTSXvleVl5ng7cDdgRSox00175UIzQV7B4kKvxwA==
X-Gm-Message-State: AOJu0Yy/oDXAp6sl1Sp11CKQth1trk34rN18pktvJJGgb07AHImYkiBB
	5KztHgotbh5PCKF5j7z3ZgJOIqaxO9psP2sw4WRAecrUVTAQ6PPs20NJ4xv1TNYhHso5gc9iMef
	yqcwZlCUQkNeqVNG8o/qbHK3P+YIYhd/Zcv3SZBA8GzbrXlXA5PfWFroeRfFAVQK+6+E3HPc/he
	e0ojY=
X-Received: by 2002:a05:6402:13d3:b0:572:b83e:e062 with SMTP id 4fb4d7f45d1cf-57332686076mr22078711a12.3.1715862796058;
        Thu, 16 May 2024 05:33:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCxXOUkrsCcpZ7D9SIlwb/5j8SMjlf2OmY4LpAd4O74EkS4uDCh+dxB/DAz92Y/peO5r9Xkw==
X-Received: by 2002:a05:6402:13d3:b0:572:b83e:e062 with SMTP id 4fb4d7f45d1cf-57332686076mr22078674a12.3.1715862795469;
        Thu, 16 May 2024 05:33:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:443:357d:1f98:7ef8:1117:f7bb])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733beb89e7sm10768239a12.21.2024.05.16.05.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 05:33:14 -0700 (PDT)
Date: Thu, 16 May 2024 08:33:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org,
	eperezma@redhat.com, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] vhost: use pr_err for vq_err
Message-ID: <20240516083221-mutt-send-email-mst@kernel.org>
References: <20240516074629.1785921-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240516074629.1785921-1-peng.fan@oss.nxp.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2024 at 03:46:29PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Use pr_err to print out error message without enabling DEBUG. This could
> make people catch error easier.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

This isn't appropriate: pr_err must not be triggerable
by userspace. If you are debugging userspace, use a debugging
kernel, it's that simple.


> ---
>  drivers/vhost/vhost.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index bb75a292d50c..0bff436d1ce9 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -248,7 +248,7 @@ void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
>  			  struct vhost_iotlb_map *map);
>  
>  #define vq_err(vq, fmt, ...) do {                                  \
> -		pr_debug(pr_fmt(fmt), ##__VA_ARGS__);       \
> +		pr_err(pr_fmt(fmt), ##__VA_ARGS__);       \
>  		if ((vq)->error_ctx)                               \
>  				eventfd_signal((vq)->error_ctx);\
>  	} while (0)
> -- 
> 2.37.1


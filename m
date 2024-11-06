Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0741D0BBB
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 07:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878411; cv=none; b=K2K8yPbuHKxQrjn/QlKI5NLTRLs7DgMw2YchDJdDJ0tCzkVI33MAU/XOO+5kfeOfvulCHnH+OYWqwCJfHbfudnQInTAEiCWHRsMqjzOD5QeIKRvotIxnk9ll7J/3V67F01yqwfB5uIQOoAOw8YyRQFEj3AB4AZE9+VSgto2lrsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878411; c=relaxed/simple;
	bh=33aKOFG3TZuLLl1fcejK3AuJF9J2u973ZT6qcLpNFXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rFByTe9BTu7FR2itkJx2CruZnGsEIkuLj7JLPXbHdiyph7RqzDRcMMoMtvwB19WMhPFV+nP6Oja6KylhmM2GekvMV1OUmkBPAVZlihAl9izO8UYGamzQiWCAZlxhaiSEIP1Eeaf3+oxkyXIuX0oXgli6fyD/NZNqfQNMvWRPszA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AzdSXh5Z; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzdSXh5Z"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E39D4059F
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 07:33:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jp99uK3ps0Jg for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Nov 2024 07:33:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5BF06403D1
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5BF06403D1
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AzdSXh5Z
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5BF06403D1
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 07:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730878408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tFJLAGQHtCF4YbMkyw4tzz7KxDHd+W5Q6WXk9sFF0eA=;
	b=AzdSXh5Z3+lGg7+Tdw3thDxHGh2DBCbC/xmXV4tj0QgNcZjXKj1P/C+jRKa1t46Ey0fy1r
	ZXL5QudBXFnTjmzmRsob5cXUuPDAAW/I48JL1q+yyiQSP/6W1nK/WA+8KA5TQrrPW4K3/c
	YBNBo5uLu5LxKDnJrPAiW/067voptL4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-qfK32TJYOl-tyDv6R_PLJg-1; Wed, 06 Nov 2024 02:33:24 -0500
X-MC-Unique: qfK32TJYOl-tyDv6R_PLJg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43157cff1d1so46692035e9.2
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Nov 2024 23:33:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730878403; x=1731483203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFJLAGQHtCF4YbMkyw4tzz7KxDHd+W5Q6WXk9sFF0eA=;
        b=w/3eQOTPbXG9cTSRrqCHmjVW8LBMKlhWK/7ZZEzSO63UfGAxkOs22WXIddMth5W+oq
         JOswvHf+WfajLbE75bsAnktxTSLTw0HN6TNCDRvY0MM6yYM8kox1Q08Q+0Zjrr4Cfyqy
         Rbjj8TWg5DW9kK6Dy/NkoGDTqsW/eVQYa/4ikJfzM4/cZLd23cIBOzuId19Q6XkJLwU1
         HcF0HI0V71e1RduaIq23CAU/5FI0jNW5V9WrRdgfYbphtmN9InTdhm8ZfN3iwHOfb1ut
         cfSmXoktZ1P6GGOrQorYiMI4jF7EDZoFaT9W9KCmg84JUCh5Vm4MG98nko73jgC7rhx/
         P+0w==
X-Forwarded-Encrypted: i=1; AJvYcCVsZTOE8BAZ/TeTOz24Nsi+ARn420Jj0UlptTv5n6Y8e8jyrep5BkKwG+ZYoJMFxlJaZb71/5io9wb+ZwfO1w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwrPaYm1RncPbMpCP//PkDjwToMV6b4JxAv9DEHHUYNH0xwX/fH
	04J8RI4NlduUOakrKjLoBszcbokLOcuwbr/YijwwLmx0vByV1hO4RQkw4/moko+GMg3w6xNkVEu
	STnfb8Fj545VVeFoFr1F0+tsyvsyXUHn+grnuQmneP5ybcm6TdGwWCkDg34UiopxY+jaf6zziX1
	/5qUI=
X-Received: by 2002:a05:600c:1f91:b0:426:66a2:b200 with SMTP id 5b1f17b1804b1-4327b6c79f7mr206065285e9.0.1730878403600;
        Tue, 05 Nov 2024 23:33:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/ntsLATwJkkyCIm9/l8825ZGF3r9/sWcOfHZUV3jZ4XNMPDEncs1UxJK3Vl0G5wdr3PGgfQ==
X-Received: by 2002:a05:600c:1f91:b0:426:66a2:b200 with SMTP id 5b1f17b1804b1-4327b6c79f7mr206065085e9.0.1730878403275;
        Tue, 05 Nov 2024 23:33:23 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa52e658sm12280525e9.0.2024.11.05.23.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 23:33:22 -0800 (PST)
Date: Wed, 6 Nov 2024 02:33:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 7/9] vhost: Add new UAPI to support change to task mode
Message-ID: <20241106023302-mutt-send-email-mst@kernel.org>
References: <20241105072642.898710-1-lulu@redhat.com>
 <20241105072642.898710-8-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241105072642.898710-8-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2024 at 03:25:26PM +0800, Cindy Lu wrote:
> index b95dd84eef2d..1e192038633d 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -235,4 +235,6 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
>  					      struct vhost_vring_state)
> +
> +#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, bool)


set with no get is also not great.

>  #endif
> -- 
> 2.45.0


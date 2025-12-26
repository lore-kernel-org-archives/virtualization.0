Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2823F277CA5
	for <virtualization@lists.linux.dev>; Fri, 26 Dec 2025 19:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766776390; cv=none; b=Onxj3+cpkKlbOcjpJhPznzb9h1PWJA19d2JoJ0fJ35CMStpHMzruCO75E/0W6uHoooiTe6EumF//D8LFZposE57nTmCrH5pDl6bjkU4FShuDIbsMfEIwpfh/jQLxCgnV0x3KOTcP1YO1zrtcwBFYR9Q8TguebO4kbSsrCDgh6nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766776390; c=relaxed/simple;
	bh=lUMCmuczKMUXW6eGw5YTX4sf8AJhio3FKYtAAVRjSoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BAXKnBm8RtRc1OlTpc8Y9edoCrqFvPQPNPXIXcORyET2v2Fd7xYMPb0tQuhiSdvZYLq3kJRnqSV98jeLFV2b+n3mswy7upPTROzYIigdkyFXro0u1V6VkaBDgp3p21v75JmefP0mHV4Vun1unTG9Q/tQ6T/uPF6YLK2PisY4nTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c1ICGmy7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c1ICGmy7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766776387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jCJExQzqs637ugyXIzruHJz549Yv0YnLyqIpS8e/QQE=;
	b=c1ICGmy7CE5mZdJ06TLsyU2tn5MoeOLKtEJsrVwWzPih2uosmUjo2oydKNb8J5vLkTuH7X
	128YOPA/chfS39rFTRHbU4jBb1oEJeqQLrhJNGlwMFKIYwsUFT3FhTodeiDSZ+psM+DKeS
	usUAn5rFSgONrsS1sJaGqwGNfuUR3ko=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-m_fc302wOV-Gvtw58Gwvlw-1; Fri, 26 Dec 2025 14:13:05 -0500
X-MC-Unique: m_fc302wOV-Gvtw58Gwvlw-1
X-Mimecast-MFC-AGG-ID: m_fc302wOV-Gvtw58Gwvlw_1766776384
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d28e7960fso18048785e9.0
        for <virtualization@lists.linux.dev>; Fri, 26 Dec 2025 11:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766776384; x=1767381184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCJExQzqs637ugyXIzruHJz549Yv0YnLyqIpS8e/QQE=;
        b=WfcUNZXeH0bmLZz9EILE8dXqOniFtZjiT7aHg+FPzj6xAck0WHbx7TOr4aMHbe4WYS
         eI3rNIIyKsbxrHAVYTjhC242NBQyuOYyuKX7Nkv1hADQ7iR++SgqY7ZPctxcPgF7BGHc
         9qOwWe3bJJGNiQq1QNE7dTOqRhl4v9up+jCnYLLVp5dMaWEoUP2k67p5XUrgFKHHjORU
         UdFGhPZH/rNRCy7xcZ+20rcJQgLKJ9kDQsOq5L+5FsGdGO3dUgWVVD6ZhE93DWkwGNXX
         eejJwmyC9+c286kEk/0ysN2t1a/loIrITuleGQ4GjOE/5LpmOjefGHqMW1GU4WZsJGnr
         x/IA==
X-Forwarded-Encrypted: i=1; AJvYcCUhFRf7TzgmmzgOQcVAi1a3P23LM6b/1rX1NDgJmqr1MCuuDPVx7lK1nfP2SzXbCuhJBhKY4hs6bBPecJJRXA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzebnOF4ZpE9HjMttW4WKuSBunhnHway49ZilugZw0iCYqYbcFh
	DzuebmbNjuzQfNHlOZPB34jksj+ej/GZZ+b4TBiHTwy56nm+EOiyGKmUMhDqqZGqOlrgnSLrYW/
	fDQguTcbuMkSu0H76hP5E6BIORdGJqdNWWyUILbwIrL5vfqLILM6eeM5cNRGTCpag13Dj
X-Gm-Gg: AY/fxX6pB+lCmL9quRDXL2gFs6I0YfJJGDgaIYKI5OLzpvDBAZ+u06AcBylUGy7T/q7
	1YE5F3mZ798e5BxjzWsSp/2L0JsBPzC2Wln5XygUV9qiYarnel5Z3d2A3E9cu9AaLN3EDBY1dwB
	9V2Q9iQFlV1Wwh9iMmLrHOHsXCM9t5Tj0wIm9XkEil3WTQN1reiqol0Ow95vFHoY9fkyc61Fin5
	xWVfOHevoSzXCIrgXoRsOTijrm8H8ek/hNpYD160BZUyYQo/XELo1a/at51HdbJxlCxEdzNPuoC
	ZEHJxpM3tSAsL9BswYIaaS55lQrf8Hq5VP3RLIW3O5wYC4s+t9HhjSONk+wX8beijESL3goDu+2
	6N2ZDnWrgGDR//9j7OnwWOTlPkfpO6oTx3g==
X-Received: by 2002:a05:600c:4746:b0:479:33be:b23e with SMTP id 5b1f17b1804b1-47d34de4cacmr152042935e9.17.1766776384254;
        Fri, 26 Dec 2025 11:13:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaJOGoIgep+VQjNLBDcLc9sEzjktuiVWY5kDlSwfdV30VOKaMZG2W2eFwHzlOC0f0TIvKVjQ==
X-Received: by 2002:a05:600c:4746:b0:479:33be:b23e with SMTP id 5b1f17b1804b1-47d34de4cacmr152042655e9.17.1766776383751;
        Fri, 26 Dec 2025 11:13:03 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19346d33sm413964195e9.3.2025.12.26.11.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 11:13:03 -0800 (PST)
Date: Fri, 26 Dec 2025 14:13:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Virtualization <virtualization@lists.linux.dev>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH v2] virtio: Describe @map and @vmap members in
 virtio_device struct
Message-ID: <20251226140725-mutt-send-email-mst@kernel.org>
References: <20251219031647.25264-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251219031647.25264-1-bagasdotme@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3Mvd4tJsmOjtMFhWybh3uFMWfPWOoUcQXQ1uEntX8Wk_1766776384
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 19, 2025 at 10:16:47AM +0700, Bagas Sanjaya wrote:
> Sphinx reports kernel-doc warnings:
> 
> WARNING: ./include/linux/virtio.h:181 struct member 'map' not described in 'virtio_device'
> WARNING: ./include/linux/virtio.h:181 struct member 'vmap' not described in 'virtio_device'
> 
> Describe these members.
> 
> Fixes: bee8c7c24b7373 ("virtio: introduce map ops in virtio core")
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>


Well I was going to apply and now I have second thoughts.
The patch does describe the members, it just does not
describe them well.
for example,


> ---
> This patch is split from kernel-doc fixup series [1].
> 
> Changes since v1 [2]:
> 
>   - Apply review trailers (Michael, Jason)
> 
> [1]: https://lore.kernel.org/lkml/20251215113903.46555-1-bagasdotme@gmail.com/
> [2]: https://lore.kernel.org/lkml/20251215113903.46555-7-bagasdotme@gmail.com/
> 
>  include/linux/virtio.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 132a474e59140a..68ead8fda9c921 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -150,11 +150,13 @@ struct virtio_admin_cmd {
>   * @id: the device type identification (used to match it with a driver).
>   * @config: the configuration ops for this device.
>   * @vringh_config: configuration ops for host vrings.
> + * @map: configuration ops for device's mapping buffer

there's no "mapping buffer" that needs configuration.
the type tells it all:
 * struct virtio_map_ops - operations for mapping buffer for a virtio device


>   * @vqs: the list of virtqueues for this device.
>   * @features: the 64 lower features supported by both driver and device.
>   * @features_array: the full features space supported by both driver and
>   *		    device.
>   * @priv: private pointer for the driver's use.
> + * @vmap: device virtual map

this one is not a "virtual map" either.
more a "device or domain used for mapping memory"

>   * @debugfs_dir: debugfs directory entry.
>   * @debugfs_filter_features: features to be filtered set by debugfs.
>   */
> 
> base-commit: ea1013c1539270e372fc99854bc6e4d94eaeff66
> -- 
> An old man doll... just what I always wanted! - Clara


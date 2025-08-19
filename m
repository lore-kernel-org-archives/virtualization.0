Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23E927876E
	for <virtualization@lists.linux.dev>; Tue, 19 Aug 2025 11:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602555; cv=none; b=gQGS2kToaLpLTo0ITKFF3ovTxqyD8GPLxdHGhENNC4cGkWIhiHqQAPDZ+D9i428oHU/STxxV+8E5pFI7ES8sAsM/JDpxzDj72iMqxkMCGsP93l60ha0ZddHXHy3m5xKsMlQRX/4oU/fAvI1nhPKnsFUfnTzry1FoEZmCVi9ZBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602555; c=relaxed/simple;
	bh=ljNmmhgO9RaVR5EfsrA+jtClGqwH4Ncw0+lLHEpMKhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gBqb2sMb9jJyABTTsvzHYQ+5HHu2rVdpJysbOsrvfHWFtcMbfVq3wuzmQxRTsihpIvU9NkvMFuaUerhP9Gkqc3Fg06ybZEG9QH25miju2V2Jv/EUXD+Ih3zzUqBKphVvb1F5ZAV4tL87BTBrzb5+SZs8iy1qbrCCL99FAxOcb9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJBkTHKC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJBkTHKC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755602552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdBinzdAYenwJX8OAfplMqIPm3EH+LTM0TGcBywLoj0=;
	b=hJBkTHKC7xxyZ4/aReLPGO6dnGHI0VuzD9ue40LzqzTUCaFa22oEO+Aee5LY4H7avjoocK
	xy4G/qOfFTpBUgzk4wz+fb4Ijnogh/P5EFr5ruyD8aC0fO2nbR9qlcaTvhMt3M93UAZm+W
	VIQn9OPz+nipXbShXDeQqGDr5t1csLY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-eVkt1-boPgOAod7dSoHZfQ-1; Tue, 19 Aug 2025 07:22:31 -0400
X-MC-Unique: eVkt1-boPgOAod7dSoHZfQ-1
X-Mimecast-MFC-AGG-ID: eVkt1-boPgOAod7dSoHZfQ_1755602550
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9edf34ad0so2728679f8f.3
        for <virtualization@lists.linux.dev>; Tue, 19 Aug 2025 04:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755602550; x=1756207350;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdBinzdAYenwJX8OAfplMqIPm3EH+LTM0TGcBywLoj0=;
        b=bsC/rxC/+cAsVfKE6GEDKnm3gF2ZMz5lOBK6eSn0PCI9fGYDuPBH2P4xLr/QFLmr7O
         1JbbysIhay+aseiQVEll8FoYQlJ42AyC56S4LHxao2Z2boerpOICei1Fo07TPAe4UXlX
         DReKgBDqnhQ8jmv1sW4zlwXFtj2Sla0fQqtMbRNNx1bQrsdTRKKpBw8B98KKv6OF5HTF
         8dnrn9/IxAv6IvLzQVOppOmZoCyjB9a8gjGpa+H+JvF2mVANlSi7yQVzkLxvpxS4SF4F
         IT9kT3H+b1SiXKsdKIkSa4f2j51/+8wWn7gVWH6EusqBZjxddZh7YHJ306QIvWpQHo+/
         vApw==
X-Forwarded-Encrypted: i=1; AJvYcCWaC4ntO2Nrj0r0qCRRS7Mrbk9QSE8O2SpDC/Jv/toHn0anTgZA1mn2bBwe1p/2YDoVl0Kl87NWrqht/GKAyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTXNsKJ9+5JiAdMG00DF5dkZ3cWiy3Pp4PKEkS1yony4/Eckp6
	a7DHIxFVxifWItxv+GFvg6DnwQcB5Nzb21Ou2vRCYI1BaO9W5SQ8X6C3d+T85AuLu8wPnMk30Fd
	tpFU84aBtrFtkTRDTAsFC+m5uNS3BFgJKXkYf5gk+rPQuYOosp7uVY5QJ5bJFT5oFbHqW
X-Gm-Gg: ASbGnct7R8vUqwQKVVZ0ld+/ZLvVDC7JIsAH5+l8W7p9xsh9tWAhyEdmhlIUi4OeNOu
	PNtSq+hJ0/QPz8tA6zmh9LVRgDJ27/LS++0uJVfSxWLz2SeK+RGJIFp8oFFnKd8qzLoKXGdZA8x
	2PyyEomzlIPbP8Zpkr7rz05FhMzSACfjvwZVB9ez3YD/bIeOHKRslyrS9JRnj3+FtXdQic49GdP
	sZQLigblChkHJJi9lplSUepa3lqTEFEuCkm3zQtc/So/HoD3lCT6Ne9mu7sdeqK/J6MjcyfDb0O
	V6si0hSbTxXiFPLmo4ZmUkHyCVPDhjUJ
X-Received: by 2002:a05:6000:2387:b0:3b7:9aff:ef22 with SMTP id ffacd0b85a97d-3c0ecc3206dmr1914961f8f.27.1755602549980;
        Tue, 19 Aug 2025 04:22:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv8ySp3Cp9nuKkaFnxvZbN6GvUwPZexJl3kz+HR/Y9XxHDTyVom8LjTJyyFuYXs6XeX/e9Gg==
X-Received: by 2002:a05:6000:2387:b0:3b7:9aff:ef22 with SMTP id ffacd0b85a97d-3c0ecc3206dmr1914938f8f.27.1755602549506;
        Tue, 19 Aug 2025 04:22:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b42a84417sm36364775e9.13.2025.08.19.04.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:22:29 -0700 (PDT)
Date: Tue, 19 Aug 2025 07:22:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-perf-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] vhost: Fix ioctl # for VHOST_[GS]ET_FORK_FROM_OWNER
Message-ID: <20250819072216-mutt-send-email-mst@kernel.org>
References: <CACGkMEvm-wFV8TqX039CZU1JKnztft5Hp7kt6hqoqHCNyn3=jg@mail.gmail.com>
 <20250819063958.833770-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250819063958.833770-1-namhyung@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xhUXyawEK8MBTmsQavmiBoNStAHfMmvoo_QVJXdQo34_1755602550
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Aug 18, 2025 at 11:39:57PM -0700, Namhyung Kim wrote:
> The VHOST_[GS]ET_FEATURES_ARRAY ioctl already took 0x83 and it would
> result in a build error when the vhost uapi header is used for perf tool
> build like below.
> 
>   In file included from trace/beauty/ioctl.c:93:
>   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c: In function ‘ioctl__scnprintf_vhost_virtio_cmd’:
>   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c:36:18: error: initialized field overwritten [-Werror=override-init]
>      36 |         [0x83] = "SET_FORK_FROM_OWNER",
>         |                  ^~~~~~~~~~~~~~~~~~~~~
>   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c:36:18: note: (near initialization for ‘vhost_virtio_ioctl_cmds[131]’)
> 
> Fixes: 7d9896e9f6d02d8a ("vhost: Reintroduce kthread API and add mode selection")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Applied, thanks a lot!

> ---
>  include/uapi/linux/vhost.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index 283348b64af9ac59..c57674a6aa0dbbea 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -260,7 +260,7 @@
>   * When fork_owner is set to VHOST_FORK_OWNER_KTHREAD:
>   *   - Vhost will create vhost workers as kernel threads.
>   */
> -#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> +#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x84, __u8)
>  
>  /**
>   * VHOST_GET_FORK_OWNER - Get the current fork_owner flag for the vhost device.
> @@ -268,6 +268,6 @@
>   *
>   * @return: An 8-bit value indicating the current thread mode.
>   */
> -#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x84, __u8)
> +#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x85, __u8)
>  
>  #endif
> -- 
> 2.51.0.rc1.167.g924127e9c0-goog


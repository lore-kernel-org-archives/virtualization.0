Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C6316BE0D
	for <virtualization@lists.linux.dev>; Thu, 17 Oct 2024 07:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148499; cv=none; b=KKEzzF6CeS5WZBKNDyS6dWeBUfBeEHnWSQrU01Se6Bsy3NEOsmYspWWjDqLuYY54j+5NZHJFINN4iXLtv4rHn31NBaqmO7OuTaXNHVSusWfaYggQYGJw41cSfv4JZdjVnFrsLqqxtXW1ceh1lBfyRR1uik++E1pWSS6mdiuE3nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148499; c=relaxed/simple;
	bh=ptrDT5yKmft1N/p1HVAwK2vX29TKKA2kcd6VcHBkASs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzdixzqIu1Ff8qvRIhQGjstAFYEbB9vqQhAXs0f8auHynstSnyhriQ+6CR+bckURIQA0xfkPSeOs3tOFyvA9Iu32FUSdt1Qhxv7PV125KxcH6tBui7bpnuAphHI0Hdbi7Es3mBH46An3LEe29mhS57EPRGIHi5dV8qflOTVnQDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LfM5MBhd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LfM5MBhd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729148495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptrDT5yKmft1N/p1HVAwK2vX29TKKA2kcd6VcHBkASs=;
	b=LfM5MBhdgqFtTc0eeNzUwWi55zy8ZzFATDlvMH8PeL6BLYfyxZfzyIDpuLyfkASTxofJgV
	dj7qaBM5MUr2aNNIWAZp4SewSwBI6Zuyk64pO579SXKbzQwWAfWsOOxw3OsJkJC8BvBFzY
	cNlUZbrvUw61WA74iA/QD4nZuazlU/o=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-wqYE8OJIP-W0_W5ZGuzJbQ-1; Thu, 17 Oct 2024 03:01:32 -0400
X-MC-Unique: wqYE8OJIP-W0_W5ZGuzJbQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2e2a6f9438eso808097a91.3
        for <virtualization@lists.linux.dev>; Thu, 17 Oct 2024 00:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729148491; x=1729753291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptrDT5yKmft1N/p1HVAwK2vX29TKKA2kcd6VcHBkASs=;
        b=nqSpZ/+EA4FGLXiSXwgysmKQlfaHrOoK0ZkHEOJn2/ZHJecIkYjLeUpiS8n5sYRCqc
         xafUYMsH7nqwQBTMiDquPwvHdgdGffi2PwlGDr7arcAPSr1pP527b7KoaKVT+bZnLifk
         wjhxSBUT1Ij2ThzVCyQZYlOd8wW6MBdXtCDVvh54zNfkghDOAZPDze0y+gzfPfT9CzHu
         UYUhVS9OIoxY+y4m2OAC7PohBHHRkaA1eqUx/9PgwwbRhJgWRQK17bPYOkMjvhVKCcob
         +KdDB4tv6QiTQRTOr5zdTbMutOctNYRKCR//3iBYFs8GD5486p/yl2KxW9+PbEVrjas8
         nYaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnfmEts6x7mLnTj1hsYjyK/Z3SGAMgBKaKKH4BquIXsKIReyILi/3b4Pa7v7wvlpK9+J4SirJZVuYArCTJTw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNm4e/KDOw4WGHRrFVeTP2fDm0LmSCTcDTpmGb3XcJlMzyeyXC
	sVNV7wNc6uBWxdMCmzvwkgjD1TzQaeHMspKbhyFI1ujm4ily0Mku7taUImEaexcjqT4rGVrKnqs
	p1YymsjZ7d+rrWTnFxrjzKAL+CiscBpfIrQg0tNGJ8hpbyPVnycf1lwWr11JuBhL5szRTp7U9iL
	mAeoV6bfkLHe0UxKbmsTZ6CUKi7BmX+8t7IoNZ8f4=
X-Received: by 2002:a17:90a:dd86:b0:2e0:99bc:6907 with SMTP id 98e67ed59e1d1-2e3152c8361mr21483685a91.15.1729148491210;
        Thu, 17 Oct 2024 00:01:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrBlnJbOKhQQK6QuG1u9VQfSftdSelf73brpFPmwNfOjiHRV1dKB+7crdUJzW4jEtREoYKtEK/yTwEpenhcmA=
X-Received: by 2002:a17:90a:dd86:b0:2e0:99bc:6907 with SMTP id
 98e67ed59e1d1-2e3152c8361mr21483663a91.15.1729148490793; Thu, 17 Oct 2024
 00:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241017013812.129952-1-yuancan@huawei.com>
In-Reply-To: <20241017013812.129952-1-yuancan@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Oct 2024 15:01:19 +0800
Message-ID: <CACGkMEsUoVPfn+kab18yTvGqEnqDyFZvivKMFLzU1UkSRd7aEQ@mail.gmail.com>
Subject: Re: [PATCH] vDPA/ifcvf: Fix pci_read_config_byte() return code handling
To: Yuan Can <yuancan@huawei.com>
Cc: lingshan.zhu@kernel.org, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, xiao.w.wang@intel.com, tiwei.bie@intel.com, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 9:51=E2=80=AFAM Yuan Can <yuancan@huawei.com> wrote=
:
>
> ifcvf_init_hw() uses pci_read_config_byte() that returns
> PCIBIOS_* codes. The error handling, however, assumes the codes are
> normal errnos because it checks for < 0.
> Convert the error check to plain non-zero check.
>
> Fixes: 5a2414bc454e ("virtio: Intel IFC VF driver for VDPA")
> Signed-off-by: Yuan Can <yuancan@huawei.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


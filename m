Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBDD3B4EBD
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 22:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789166971; cv=none; b=GmUzApVDwH9L4edhjD2YDGqUOKMP/snpOH26FOXXD4TnnB5VVBBZzU9moew4VyBgp8IdrJ0bbEYPWzvIt5lnCoG7YtRO4S4Vsz7ZoXlNifUxCVLs58/8I4fr0n7QQ4WV7l6ggm7DBIiXUZxTpx+ABeU5is1AHaHnp6kslFa7hg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789166971; c=relaxed/simple;
	bh=r7gJUmlNhu91hRTpaNPKWXWjU0T1D5vdR1MPcCbBlXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPDQEjiNvBeK5Ugj+dIRakxeyHAtk6+z2wQEfutujRMl1RcXL11pUacFqrFUOkPSZVY6ZLhjpNN1uVu90I9RxQPvqwDBMmLxIRGbDmfvfEKk14djZKQH/el2ntOXCLGF3cH6P+15UxJwWcBVbAP3lTPD5HsijsOSpqz9xG7urBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQCSZxCh; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQCSZxCh"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso17806525e9.3
        for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 15:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789166968; x=1789771768; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QBxB2AmGJkKp9i5tKgUFrxZA33MoBn9KXbxevCCY/UU=;
        b=eQCSZxChZOipvTFJn8Ot4hgKuQ1c3TNCCXEVsZJpCL4y2WXrnj6ma9aUOUmIc7D7he
         i+KlgvrVSst7IgbjfCGjBdjGhFJOrdERsDgPCpgs2FULhD975EYoeAFDCMiG6XKCInSu
         i1XIfKc0zO8bKnRf8JC5JeI3RvSXhfMK1Y/v8Ov0+lBvic6Xjc7aY313hkJK5e4w0bm6
         dea/taHjVfyEBcepZX0f6NlfqsKkbrEnv2jP+Fd3cctpuAo1kH+U9QYqP2sRaG1r8Ij6
         9+KKqWqPUzhq18JD0Rb3WO8ACVADvAUAutKPUfu8ffR3azioLwHGo4GsD03lfA1f/oSm
         ELZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789166968; x=1789771768;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QBxB2AmGJkKp9i5tKgUFrxZA33MoBn9KXbxevCCY/UU=;
        b=nkxZe87KxYguxYYebApWFhfLnYpMl7oHB6TX9uyG/CFMUCYWuP/xJc0uj4l+Fqv5rD
         YknHmMo5nocORir6h218AK/9UPXFCUI5UWbmlmTRHbSlsBMd3Rp7IDeOGAaAEwt1BCyv
         GhgpJk8lXoyxsrnfNauTdx66qucD83dOuElbu+EBJYOaqLIPTX7XYIAVX74vOMhv7TgN
         zcfqrIDVZX/5njQKPg5pgRRqWfIHy+OxeecGX0weDHC1pPDDdQlhSBoe9JD5ZoOxWDUb
         mzPLuPoETgAp1PoMmrrIkS5ubxMD6oZCNc9RIwqMC8EFLcDFgnNQlVxuT3vkdHR7c+9C
         BD/w==
X-Gm-Message-State: AFuF++m63fXoD79TVbFdouumDzN2YvqHhJM8F6xwPRxacZXt9ia1kZid
	2giFHShUwjr61/C31V0Ukd/QozCocO7WA3FGGkXwWKMhJlDYgQR78Y+O
X-Gm-Gg: AYBFou313UH1KNwtXVt7vDrJPBlJl63rK22BA3mustWvIxwaZGzIkjO1l9AeDDU8OtT
	rwhTHuc1zUJcbbVhnas/1pybKJtfxYQkS8T7ScQjcD8MnfSIsbGF7ZIqoF0dFgSSKnnypv5ZpDA
	AD70utLEz27/D/kGIHVc2NsQXLS4XUYWmF4aK8CUepxvWwQhG983mcWbkY5M3vbKAiEx4PZuEIf
	0oRDAV7xAlfT2Y353aKSZ/xH9U2v5lsQQ9RGByFngrAbO2EYoKAjtrEFETmDl6aX+5cChIeLs6Y
	WyQpEgxZ1fSsOpZqZMBrD/NAbPO4kFfr+3MO9GZNuP2ul3j+SWt14XvGYDQHJzM105l/m1tJvDk
	4G0/VsIosGJXX7D5zLOZrL0rEftb85a+/ZBzIM0ymJLIW/0wAb5VjDZn5hSBLUG5bWN1UkALIw4
	JlSw/a6onxen80Bf198NES847Be1NFwQmkeu+oW0BTIoBy78GTR2c0X4cddsvHq4E6spHGnkzlo
	2sU6CUsOSInK64tjCSqPG08y+mt0iEPq8CLlVaCf2jdw0fCRPLviZEB8Dpo/JXMU/evlIMpDyVt
	deBrLOkQKagOByGqfqXSqo3ircvcl4UCSQ==
X-Received: by 2002:a05:600c:1385:b0:49c:fc6e:8cbd with SMTP id 5b1f17b1804b1-49e619e86c6mr62588065e9.33.1789166967648;
        Fri, 11 Sep 2026 15:49:27 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-095-114-033-154.95.114.pool.telefonica.de. [95.114.33.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb36e4a6sm9132172f8f.37.2026.09.11.15.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:49:26 -0700 (PDT)
Date: Sat, 12 Sep 2026 00:48:54 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, jiri@resnulli.us, 
	sashiko-bot@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] virtio_pci_modern: move avq cleanup from reset to
 del_vqs
Message-ID: <aqSDrWpFy84CxCoP@gmail.com>
References: <cover.1789160982.git.mst@redhat.com>
 <d0b3de807c800befe9adce1cefb2d064d9fe0bec.1789160982.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0b3de807c800befe9adce1cefb2d064d9fe0bec.1789160982.git.mst@redhat.com>

On Fri, Sep 11, 2026 at 05:20:15PM +0100, Michael S. Tsirkin wrote:
> New in v3. v2 dropped sync from modern vp_reset in one combined
> patch, leaving avq_cleanup in vp_reset. v3 moves avq_cleanup out
> of vp_reset entirely into vp_del_vqs, fixing the race. Adds NULL
> check for admin_vq.info for find_vqs error paths.
> 

I think patch 3 introduces a use-after-free in the MSI-X setup error
path.

With VP_VQ_VECTOR_POLICY_EACH, vp_setup_vq() stores the admin queue's
info pointer before request_irq(). If request_irq() fails, vp_del_vq()
frees info but leaves admin_vq.info set.

vp_find_vqs_msix() then calls vp_del_vqs(). vp_del_vqs() now calls
vp_modern_avq_cleanup() first and dereferences the freed pointer:

    vq = vp_dev->admin_vq.info->vq;

No interrupt needs to fire.

I reproduced this on v3 with KASAN by returning -ENOMEM only for the
admin queue's request_irq():

    BUG: KASAN: slab-use-after-free in vp_modern_avq_cleanup+0xf4/0x110

KASAN shows the allocation in vp_setup_vq(), the free in
vp_find_one_vq_msix(), and the access in vp_modern_avq_cleanup(). Adding
*p_info = NULL after vp_del_vq() made the same test fall back and boot
without a KASAN report.

Thanks,
Karl

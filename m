Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B728541CB5A
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828136; cv=none; b=C43BavmeE7bMBwIaDZrJbSYMMW4ry1Da7UYQ5d4gxBFBHPdaRQuwSUl4iuicm6/WT47nvwzxYmWds5HtO0nLxF7ffpalv4Rs0EFgZjRb0NkdMlFmWQps/9+HeM0eWm+tULEXQAf2SmufIxPWR9+CL603WLGUbXiBjWAspBrJb8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828136; c=relaxed/simple;
	bh=UUYnb43zrsIRjQyh4cfSLY2E5YTZmiqA5Rf9inckewU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=utnhZ67JtmawBn1zMf2nfarqncKr1TRJnvpvNSO7CpPRA46g8BrEw+5dtTGjI5sGraQyImIUNCDB2M0UtR3Srbi+ZJpADqX516Z5PyOhP4MkMrLaF5rvnAC5s0h33W8KYBtEaBrX9G/4Kfm2YEqnXLenjgFD5deIuhR9pXtwTdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDNkPccf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDNkPccf"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cf50c6f235so47984565ad.0
        for <virtualization@lists.linux.dev>; Tue, 04 Aug 2026 00:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785828134; x=1786432934; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L3hkg6nazx4psD5by6/6KEzR0mdVEatjkbankMbYLBE=;
        b=PDNkPccfalRef44ydYNO+6TEdOg5d34WbCGQKLQ3/Vddu510lIcJgAIxW//tSUtQsK
         frC9SmRxZgDCqnHHdaUITObu0afkqBvXcyfPiiAY6Esngg44DWV9rOXgLKn0CXpcSb9p
         TiChOT+K7V3l+xl6FVm+nJo68Us/kmsR2I6YEpCsnzF24x3iju40WTIdIGMj50LoF8lU
         06rhtatAdqeWNi7KgcQLj+QgXJnLFbFXX+EeTnISlgY/1pO5iJmlzfU0MitMyBCcs/Ki
         Msmr36VxaRl4dhPrsMaoFu9dAHLYDTtJ2qnJTBDqE27oC2QeRjLktq8R2y+CTnO9euES
         TmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785828134; x=1786432934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L3hkg6nazx4psD5by6/6KEzR0mdVEatjkbankMbYLBE=;
        b=Xda/AtkEoLDnNvc2C1LlqoDhNo26SAf2S3N0OIdBEydE3aX47bJb79Iioru8hsqcik
         lXF4CX00CsdztScylpCGibImPGCq5D/oxpJ8l9dT6f5xeKXILvMvwttiOF7EsnnYNCPF
         JO+e7ZtZGwF+s9/xGcxCGojiU40Mjjwal8LThKYAVVm+8ddTXkxW55bPogP5cuR6SSno
         Sw2CDDT4UJJFHCbAXpEvUx6yimLJN0cgo7ssEgnUDpbU3CsBlFrcR+DlRhsSkbw5nBpd
         Zv4cDw04v3M4ufxx+hrf32w0U2Rqk28uoc0Jae9xcy2vv38b5EMszHrFkaVwLCok09IX
         H2aQ==
X-Forwarded-Encrypted: i=1; AHgh+RrMfbPeh5gYORgC3Vjdaw0XGHETXO+s8FDbF7IiehJe0omA4qI+UqYuoFHhIL0XgeC6RY6RY15G//qYoZkVhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0MT1hYGPuBN/48KguFcMNCrdYTNisUXKXDnVbllznXHbmEEEB
	yaCBOYgjhRxtCKuiNq67uefdWw9KSbOaYazQgPNCwp9zg+f8kSk227ra+vd4hFp/SzI=
X-Gm-Gg: AR+sD12NK/ovKeGaZZNIN86uMZbVjCb9+h7y6O1ZrJKF3YNUPEWFwYg6Adz3Auxrcdv
	uC5d5X3QhBeYlYoZDA68bHwbnSiQVjn8eRN4yA5TPFlHfvS2CZvT3aKxyJajNIf2/jbWBQ0lJ9f
	c8zjBscOqy38LIu/r86p9pR7DjS7iXzHQAvflXfktsuUoLtNr0O5NFAittnkjIEbiNzccDy4zAJ
	fR9BkbhdfVvxHujms72IFNh1BoQHCANV0jaITLSRCgmc90bSElbR/NWbvB6HJqd8XKRAJFz9+uU
	VltE3CuGKhGg3kAsoHZw62NUabPE9PCf0GN5NcN5C3+vaHwfCBCD0k44RpvVXp9vA+HsWMIy9JT
	ZHHhx2p9hQimuMTU6iRud/j+btK3Jx1/HGjm6XyOs1zbpyqWqfI6YgZ5d/yZ6NSET72NJeBX/BN
	pjIV5Pzup4ge6wtJsu1YT4BerXTmnNmYECdtj2LKtReDEEW+y5saWwmOKV3T6H0ck=
X-Received: by 2002:a17:903:2407:b0:2cc:9a86:9c42 with SMTP id d9443c01a7336-2d0524ac403mr140766925ad.45.1785828133758;
        Tue, 04 Aug 2026 00:22:13 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0a9f9371asm1669495ad.13.2026.08.04.00.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 00:22:13 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: stefanha@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 1/2] vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Tue,  4 Aug 2026 15:21:59 +0800
Message-Id: <20260804072159.7506-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803231405-mutt-send-email-mst@kernel.org>
References: <20260730104857-mutt-send-email-mst@kernel.org>
 <20260731103414.1746316-1-physicalmtea@gmail.com>
 <20260731103414.1746316-2-physicalmtea@gmail.com>
 <20260803231405-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 03, 2026 at 11:18:50PM -0400, Michael S. Tsirkin wrote:
> Why lock down all vqs like this?  Would this work just as well instead?
>
>       iotlb = vsock->dev.iotlb;
>       vsock->dev.iotlb = NULL;
>
>       for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
>               mutex_lock(&vsock->vqs[i].mutex);
>               vq = &vsock->vqs[i];
>               vq->iotlb = NULL;
>               memset(vq->meta_iotlb, 0, sizeof(vq->meta_iotlb));
>               vq->acked_features = features;
>               mutex_unlock(&vsock->vqs[i].mutex);
>       }
>
> and if no why not?

Let me add a little more detail to my earlier reasoning. Locking the VQs
one at a time does reduce lock hold time and avoids blocking one queue
while waiting for another. However, the additional blocking from taking
all VQ mutexes is confined to the `VHOST_SET_FEATURES` transition and
does not add any steady-state data-path overhead. vsock has only two VQs,
and once the locks have been acquired, the critical section only updates
a few pointers, metadata caches, and feature fields.

`dev->iotlb` is shared by all VQs, while `vq->iotlb`, `meta_iotlb`, and
`acked_features` are per-VQ state protected by that VQ's mutex. A kick
handler only holds its own VQ mutex. The following interleaving therefore
seems possible:

```text
worker: holds vq->mutex with the old vq->iotlb
ioctl:  sets dev->iotlb = NULL
ioctl:  waits for vq->mutex
worker: continues processing with the old per-VQ state
```

During this window, the state can be:

```text
vq->iotlb          = old_iotlb
vq->meta_iotlb     = old mappings
vq->acked_features = ACCESS_PLATFORM enabled
dev->iotlb         = NULL
```

`vq_meta_prefetch()` may still use the old `vq->iotlb` and metadata
cache, while `translate_desc()` sees `dev->iotlb == NULL` and falls back
to `dev->umem`. The same handler could therefore access the vring through
the old IOTLB and then interpret a descriptor address as a GPA when
translating the payload.

If that IOVA has no corresponding GPA mapping, `translate_desc()`
returns `-EFAULT` and aborts the current queue-processing pass. If it
happens to fall within a valid GPA mapping, the translation may produce
an iovec for a different HVA.

Clearing `dev->iotlb` is also different from replacing one mapping table
with another under the same address model, since it changes the address
interpretation from IOVA to GPA.

As I mentioned in my earlier reply, I do not see any check in the
vhost-vsock `VHOST_SET_FEATURES` ioctl path that guarantees all VQs are
stopped or otherwise quiesced, so I thought the transition also needed
to be safe while a VQ may still be active.

Please let me know if I am missing such a guarantee elsewhere. Thanks.

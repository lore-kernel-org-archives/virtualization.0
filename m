Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A9310942
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 04:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752812647; cv=none; b=M7Tr1WziGTq8CBml7h09fCETdEuSGkjvyW7jYaDtm/FtTFjHBg+O/rpdZFrDYkwfMq+fdolf3j9dMIVyRWJ8ccqb3wrxMomL7W2NUoLcKAuVJitIgIf64DKy//9OkmtPZlMvTKvRQGBAJ+fcm5mqCHmLYrHeqTUf4AQbEMOkoHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752812647; c=relaxed/simple;
	bh=bP9ZLG0iMRbSbbXDLIl6KsPIkhhkQkia54iDIuk8NyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wbgmf8KFxP1x7BtGbmQUxDoYjY4vxEtEYdbOnGYyRaYFc+FKR1bP6kA9AMMR2zYtgak1AxjKofzMmR+BBBO/qqkQHygDCncERsoL45FF4j7G9icVX9i7l07RecAStSiy3xjCCSc+m82vwX1N5NERNr55DV/OAbz/Gt7A7HfI0lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T87uBuJT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T87uBuJT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752812644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bP9ZLG0iMRbSbbXDLIl6KsPIkhhkQkia54iDIuk8NyQ=;
	b=T87uBuJTRamAwbQ9BcBo4sLuFwzFpwmth28WyRvTY3yRmjtzIqhI6n5U38HavHbwVYi+Fv
	ix+H/Q8obaqQ9+6KEUpStVESjHwbxQqSym5QBGGD3e/KjBpgQ3gZU1t2Oc5T3L+f2wa5PV
	Px69OQYy5eqYquDEmnuGccdyBkQ2MUc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-GTmBMLhkOiOS2yWh2Qm_1w-1; Fri, 18 Jul 2025 00:24:03 -0400
X-MC-Unique: GTmBMLhkOiOS2yWh2Qm_1w-1
X-Mimecast-MFC-AGG-ID: GTmBMLhkOiOS2yWh2Qm_1w_1752812642
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-311e7337f26so1779009a91.3
        for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 21:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752812642; x=1753417442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bP9ZLG0iMRbSbbXDLIl6KsPIkhhkQkia54iDIuk8NyQ=;
        b=abI2E0Qt7jkyVdtqKgPdo6RyrXHXXyUmkkP8OrvGspvsaXOYs8C3XqC8yTTex/FzcW
         uxl2Q3LbOaVoP7CYWR54fCgdtx0X5KL19a+TENpzu+bCMP78Sy60OAD8YPTtvWESVMOo
         2u7rpBSfzD2f1rJMdBv3JpMeIJZJoxTg/xKknBiLqzHPifLOgQfDUboq+W5oUHMHa7+S
         ydKjUc5HJQmtGEoCbsGxI0jvknVmsFkZJs++psQsb9Jkk4XLrBCgOxNBvDizVtV0xuzK
         unmMn8IC4QUD3JIv5G9My71HhPqsoKC0v7BIus/EH3wkFVjMaTKHYBA/46uRlToo0wJb
         ePTA==
X-Gm-Message-State: AOJu0Yy1mvk6D60rp42hLsyPxBODz8I0b5mUcu+jXH/w3VKp6Tgu89z1
	h4eqODfqPO2AJD44HX6rzTSVH7whGEYr4pEEqcZ0uB1Sjmcu9Q5hX9CCEJ/CCOXjSgzW/V4H5S9
	69LJWWRVCFLS29wqOCVkdGtEEki0DTJtgK/PskLk4u8ss6M3yrrxBgiwap0epAptrJpFD60MFTC
	z12+IQcqK4evp/Kjw3lX6AeyF3zWu/Oj3fXDkHGP2D7ls=
X-Gm-Gg: ASbGnctA4dRZApmeP8QLfwqPZ3Yrt+zN5GfLhaqn8TwvomFYBbluZh3FGK/02n8hmmM
	7j/mAOM5eQgXswK2vhOHm39IHzkyVJ/tdCn41CjkI2pJERSogMrQiK9CrD2SQ6yOtMPrCrNokQJ
	k4sbT/gagpF7ELTP1/eEI=
X-Received: by 2002:a17:90a:e7d1:b0:31c:15d9:8ae with SMTP id 98e67ed59e1d1-31c9e794cacmr17217332a91.33.1752812641718;
        Thu, 17 Jul 2025 21:24:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFTABS1VyQszM4ycca2J4eYIUXCBAg65E328RjW5VMSmXKjT1pTz78wINPZRZtYuSt8E1bUYA4GvbvKT36LTI=
X-Received: by 2002:a17:90a:e7d1:b0:31c:15d9:8ae with SMTP id
 98e67ed59e1d1-31c9e794cacmr17217298a91.33.1752812641261; Thu, 17 Jul 2025
 21:24:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250718023758.36866-1-jasowang@redhat.com>
In-Reply-To: <20250718023758.36866-1-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Jul 2025 12:23:49 +0800
X-Gm-Features: Ac12FXxXqJu_XuApRH9tll_gYyvDb2HOoOtwSwilERWijHOoqxoPR85sxyP3Qqo
Message-ID: <CACGkMEsPPxVB5mgcT4=6xL5trBHn33_P1pqxgti-4FSqdYZ5vQ@mail.gmail.com>
Subject: Re: [PATCH V3 0/9] Refine virtio mapping API
To: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev, hch@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I_ytZnJFwyH-ck4Q3FTwqNxYPmWCCcBdnOtTOfyCQbE_1752812642
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 10:38=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> Hi all:
>
> Virtio used to be coupled with DMA API. This works fine for the device
> that do real DMA but not the others. For example, VDUSE nees to craft
> with DMA API in order to let the virtio-vdpa driver to work.
>
> This series tries to solve this issue by introducing the mapping API
> in the virtio core. So transport like vDPA can implement their own
> mapping logic without the need to hack with DMA API. The mapping API
> are abstracted with a new map operations in order to be re-used by
> transprot or device. So device like VDUSE can implement its own
> mapping loigc.
>
> For device that uses DMA (for example PCI device), the virtio core
> will still call DMA API directly without the need of implementing map
> ops per device/transport.
>
> Please review.
>
> Changes since V2:
>
> - Drop VDUSE dependenct for HAS_DMA and ARCH_HAS_DMA_OPS

I just realized V2 has been merged. So I will post an independent
patch to do this on top.

Thanks


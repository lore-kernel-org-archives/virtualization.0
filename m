Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB243E2AD1
	for <virtualization@lists.linux.dev>; Fri, 26 Jun 2026 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782489064; cv=pass; b=mDy7TxcUWvVgGNiL0zyhyun3suM5CZ9eC2BBtfzvZhcLBgfAXmWTnBEC7nS5CYQR8owhQeCoTFVu0CM2cEmJ8TuYC70hdTxlbutY17jOVOBddRIA56aq2CJNMpwCmDhhyBb2F7hLnVsKUsX8LvAuY/LVxHZOWFn4kA0jqDn1/uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782489064; c=relaxed/simple;
	bh=ZPHcJuGGWfpRD9VuT0tHbZH9ElUJLMcAe7aNwn77y7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PINZeBb1YTf6bqrgRgIQ/ZluYGqVRCWhwjVNif4MS8uT7Cmfe6retuRZOspoGYRvgtJZ4iq3JCCowhWBOPFXJc+YcPYnLXa2m9KzeSh75TW8M9iloAnO4no4ldcAMX9ghgDxuWLQC0QFs7d6tO6rw5sl9RDduebLgZro9YhMWV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oEPkGg4k; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oEPkGg4k"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c813c62821so52725ad.1
        for <virtualization@lists.linux.dev>; Fri, 26 Jun 2026 08:51:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782489061; cv=none;
        d=google.com; s=arc-20260327;
        b=iOmBaoJOqq/FFy/UCHZXjXY4vK0ujRbNZkCycrCm/FpCB+XjKLTpag8NGIb9k7SbXM
         /QmYtzukTfHnWFQ9xiBfz3Ec96MPJAqOz9WRLrp28iefkDfM5H963iynNSgqfq/ShxxB
         5P4Z3DQuugEP0T5AG+CtQ0kmQmSlFAzlLieXUdPUHk+cNjlVnI1VKo4lghCsPxDM1V66
         7N/baif9kuLaGr4tVWoM7Uom/2UEOjUvskAnKQy8tJkyLrflVMko4nu/gtUXcYkC19iw
         pAahgLQ6JYrBpXw6zrKNnR/5/mPYgReZfHWwvyubUlBgTIUB1ETMEnGIjzCMQAWhWfaI
         U8+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZPHcJuGGWfpRD9VuT0tHbZH9ElUJLMcAe7aNwn77y7U=;
        fh=tH+rDyxX8l4FmLjBJDPgoi/M8rI3ORdIhhGAC5muG+U=;
        b=CiBRXTAD7AIXYRuXvRtyWGL3vRivT1Zytj7V0MsHfhk7QMcrm55YWf0E7xkJG8mYG9
         MWdOPgSMgANdcPDdMcUu4ZkUCdxguNug+Akm7BkYFmEWq5KPZCJ/Y3U6Ovc1GmMebJWn
         02YYuGn1zQVKUBaKsNvlWFtW81omzhL/faCemGf9ix+P8dN+3TNgt3+Awa8/lRP69H1i
         pJrEJ2SHjS9xp/wRDDMBMKNM8dDYtl4es4RnMNetC/WmQkLBCXuo4LXIdpXQ7f2NACDA
         uJD5mOQTi1eRYnlB2CMY9K7hcKwMX9O4fvJK704c8zJVa2gmrTluOFkPDStMVsbXwQNI
         v0QA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782489061; x=1783093861; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZPHcJuGGWfpRD9VuT0tHbZH9ElUJLMcAe7aNwn77y7U=;
        b=oEPkGg4kDDxAYr8rRwUN5KtlIEMmGBm9DM5spI/9Vq3qtkAuXBUtV2XoLxI+HUYhYF
         9pcT0T1gRZvadpnLknUSmyT9PNanbUGEJDLuqMkc3vsdilHv8MUsVBizGn0CF7iUTX+a
         ZM0ih3oRlLQ9Qgo6+0c75oUsDSXQtZTsjE5EAutTmZFey9RU5QFPDiWOUjV6drtHeOaQ
         I3Uclw8qBMOmAQRnfewXJlAEftmrr/I27spwpQAxXz/3BE6ZdCBDrTJrRXzMbXSQBD5/
         LLeaeEIUM2Ja/SkE2qgDt6J3svzCx6gUszz5wcZTt9gx0ebXocEAG39tmUiDvPV4t5up
         YxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782489061; x=1783093861;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZPHcJuGGWfpRD9VuT0tHbZH9ElUJLMcAe7aNwn77y7U=;
        b=jkyvaq5d+tWmKkOzIRcSOSCg9zRoe/BuN8xjFvo6p/sJY4Oehuqs/nflYUUYHxOpaT
         cKksc3+h1krQWxjDjqfsrih6JMvb1KBX6hSLk/lkvC1TPwsg+/mLIeTbPZtSRzMFwsds
         0XcC+xiYFjZLubAvFsxPOS3MQx0ULK30c8uHYoF3ZiLBfT3wunYH3Y82hQuakKoNZKWe
         plybsn8iGCEaXMVr/Q2rma8S9amxRleLiQqvmCTCGZBdueFlu2fWZpOEWpBzH2/OheJh
         sceYPoaR/vyr+vztzZEnnymRQyt6SUApVBSTEka3sEmI/EX8NHNot1gfeS80WInZNjY9
         1/kA==
X-Forwarded-Encrypted: i=1; AHgh+RpH5Qy0KsgZdG6Ubf09tjrq9bCr17QFTlv450M4+x/peGEcevsectI70OcJszm5FJOAOS4p72f+FmLzw4ybyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYZx3OVQWbBXk/SQpFXnVNyOEbiRwQI6hYpjp+48OF9agxgQvH
	4QWfvWZNol8tFj1ZXu1DSVQD3fRGCySEcav/sMx3P8fKJvT36wahk4snqM8H+/XZjUPekl+BFdm
	dsl0/wPEw92n8nmceDE04ZxAavAzm1HburGuMayw=
X-Gm-Gg: AfdE7cnBQGIG1jrkhLVfyDJm/ChjvbAsFmEI0PVyheH3mPAueAustwMHBrVDzaNpQaL
	sH1sl3qIkJhTM2wAayGx4d2PKAKdDVUYSM2dO7o6ip/rkUOi+KZqj7q00mBnQA3auN7kOi660Kh
	ync051Mrirg8Z19whkmYIl+zP9iH7F6Gv3fdJ2LX0esjZn3G96KSupRX34szMNWuz0KmjHCZVCw
	YplCjFfHZ37vnPOirGhBNP3SMC1UYuA3OnSsEtxB42n4Ghs9GEl2QLW7dsGf1+OzRfJhfg=
X-Received: by 2002:a17:903:4b0c:b0:2bd:6dad:7ccd with SMTP id
 d9443c01a7336-2c99855966emr229385ad.25.1782489060232; Fri, 26 Jun 2026
 08:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <V9qMNHLlezBTRwOQsdz9qWQfAsMwBr9PR4tKnaHWUJz7GVS5ttNlNILtzxYh1Rxd6_nL8p8Ffk9F7OqcHBYF3g==@protonmail.internalid>
 <20260625202412.2986772-1-briandaniels@google.com> <fe970394-176b-4add-be68-74f6074ba78c@kernel.org>
In-Reply-To: <fe970394-176b-4add-be68-74f6074ba78c@kernel.org>
From: Brian Daniels <briandaniels@google.com>
Date: Fri, 26 Jun 2026 11:50:47 -0400
X-Gm-Features: AVVi8CcaG32oQ98-BwXSiQ-X6hlARwE9_bW6g1z1koV_pEWAyvNHcVBb8psrX4I
Message-ID: <CAD4i_GQaUvCH1SD3Dk5V8XTFQHpmSYqWFV5-hr-8_urx+jtGww@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] media: virtio: Add protocol
To: "Bryan O'Donoghue" <bod@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, acourbot@google.com, adelva@google.com, 
	aesteve@redhat.com, changyeon@google.com, daniel.almeida@collabora.com, 
	eperezma@redhat.com, gnurou@gmail.com, gurchetansingh@google.com, 
	hverkuil@xs4all.nl, jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mst@redhat.com, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 8:51=E2=80=AFPM Bryan O'Donoghue <bod@kernel.org> w=
rote:
>
> On 25/06/2026 21:24, Brian Daniels wrote:
> > I'm not an expert here, but taking a look at those files, the vast majo=
rity of
> > those reserved fields appear to be padding to ensure the struct has 64-=
bit
> > alignment, which matches the use here in virtio-media as well.
> >
> > virtio_pci appears to be the only device that explicitly states the
> > reserved bytes are for future extensions. Unless there's a good a reaso=
n to
> > expect a future use case where more space is needed, I would prefer to =
not add
> > more at this time.
>
> I'm querying why just the one though ? Why not say four ?
>
> Perhaps something you could address in your commit log.
>

Sure I can add a note in v5. But yeah the reason is the total struct
needs to be 64-bit aligned. So it can't be an arbitrary number.
And all the current reserved fields add the minimum number of bits to
ensure the existing structs are 64-bit aligned.
Adding more means extra bytes are transferred every exchange without
adding any value, which is inefficient.

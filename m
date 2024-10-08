Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024F31BF37
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Oct 2024 01:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728352729; cv=none; b=JfbWMGffzwla8mFDr4ydm1A69ji8rFAjh1rB+TA6Ovxecr6dZ30LjwIhO0+nsGBax8bfU/GUGb21cy1kOT4hEOcxF5OosqwFtdki6h393WUptxuOcA6em77jBPHtz8aFrF/zkosjJlHID/YO7EbCW3wqlvxWk4keJXBrToYRAPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728352729; c=relaxed/simple;
	bh=iR1AABhP2SeY8og6YbsbxDnGo7LF6IaoaOuu/o/b7Tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Chv6nPiGWBFrWFmwFXgsKQxh/NsF1Ued0AVU2bmbwrGp7pkHopm+Kk+A2lqYeyKtFNgfktFkgkW4CZrDWAZ/udAN27pRliqY+bpLsaB6BbrZ/VzqBxdp4N1n8kptSug9YEc6fIKVH8FDvz8dcsZ2Zvum+xFYBKuea8+AIFcG+1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Jkdz6Fyx; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jkdz6Fyx"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D1F5401CA
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Oct 2024 01:58:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XEngQIlluXtQ for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Oct 2024 01:58:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=dverkamp@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 09B1440152
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 09B1440152
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Jkdz6Fyx
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 09B1440152
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Oct 2024 01:58:45 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-42cae563348so8353535e9.0
        for <virtualization@lists.linux-foundation.org>; Mon, 07 Oct 2024 18:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728352724; x=1728957524; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iR1AABhP2SeY8og6YbsbxDnGo7LF6IaoaOuu/o/b7Tk=;
        b=Jkdz6Fyx5U1/Xsydzz/7Ww+yXwnbs9PsKS8Rc++1Ue+Es5jGayLbkyknHOZ0HoMKEs
         EDX3ohk75X+/j7rFNmzsV226xZ9ykCPmaRmSNquo717ZjD5eOeoNM3r4LiR8PaBZn7gG
         7e5he9y6s1KWeyTCfkNT+xirxKeosA4EmgZXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728352724; x=1728957524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iR1AABhP2SeY8og6YbsbxDnGo7LF6IaoaOuu/o/b7Tk=;
        b=iuD5gdy+hnL4VCVBK/vnQLQ9GSlleikahrfw5V3PzI+k7dYEpEUmJ4kEXNq5OrRkvr
         YLm32vE2WXjjXrTV8IljhXb8SuJRSdBobcD9+xVZjHHLY6HKsP1dvRYNx0ME/8T3CWmp
         MmYozLC2+aX4/Y4Ipe9uhVL4017oLjWd8ApLNxHGd6gh+AxJrKESl541SkoUIKHH3bSu
         fMuAQ24C++Rtfk0gprLmif2COV6q8ccl2khL2XyfcQSAp1dRFz8EtnvT5KFV/0CLnoN+
         +vy5zAW+vwuQLK/ATEy5YDtdw3gh/hfC299IRBzkc6rzj7uGVPZQZhTTXDR3uDZFQ15L
         mCWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/WjTmfdWwIesn95kFsIfveVmhQlORNGmRcw3fdHPtnWzoyQC4CPSzjsPQywLBdW0AI2+l0xZ1NTIYc7a8fQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yzv9qwRdJQV7eS1VuV1+gX7Imfe9MFuS6+aBlIk52lkuMdER09J
	Eoeqdx7LgVWPO3wYzcFjNzngKtmyVLNedrnmSOgKRTnzW1fsbs3pBYE6I2B5lUivazOK+cwca0Y
	=
X-Google-Smtp-Source: AGHT+IFiul84jPbY66stybjuimvKq9mwl9xF/Xmi1+DsRz0m0tYnWUi0NP3dygKVB6WomYNNCvbVvA==
X-Received: by 2002:a05:6000:178b:b0:376:2e3e:e6d4 with SMTP id ffacd0b85a97d-37d0e6f5315mr3864654f8f.5.1728352723516;
        Mon, 07 Oct 2024 18:58:43 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994a857739sm293945166b.58.2024.10.07.18.58.42
        for <virtualization@lists.linux-foundation.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 18:58:42 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a86e9db75b9so782514166b.1
        for <virtualization@lists.linux-foundation.org>; Mon, 07 Oct 2024 18:58:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUea76B+Q6JJ5UmRkH4w8I53kOlp6W/PMBeXaAC+uCmrmP2uFdfxpH0wZHGFwXQ+x9hN9xEF00w9mUk1Twlwg==@lists.linux-foundation.org
X-Received: by 2002:a17:907:3f17:b0:a99:446e:3b5f with SMTP id
 a640c23a62f3a-a99446e4104mr885416766b.50.1728352721735; Mon, 07 Oct 2024
 18:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240925145228.27953-1-mgurtovoy@nvidia.com> <CABVzXAntBt+5L4a1ntud_7j_EHiB4yG6FuskNaPBirOfLJ7i6w@mail.gmail.com>
 <ca954af2-4c61-41f5-8cf0-69a1233704ba@nvidia.com> <CABVzXAma4T+=meTSRNKhq70w4imc=A5imy2zofX2ndJz-XVByg@mail.gmail.com>
 <adf195c4-6d7e-47ff-ac62-dc4c0f463f21@nvidia.com> <CABVzXA=wov8OgADXbDiVVnhncc=zgET4MAGd3H1pr26XS38JBw@mail.gmail.com>
 <CABVzXAmxuVngKjNvc9AsnkuNcOK+7JeEuBE9CDaMxAA=b3f=fw@mail.gmail.com> <80c82271-b29c-4f56-b90c-e72a4ea7f3cf@nvidia.com>
In-Reply-To: <80c82271-b29c-4f56-b90c-e72a4ea7f3cf@nvidia.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Mon, 7 Oct 2024 18:58:15 -0700
X-Gmail-Original-Message-ID: <CABVzXA=7a9YxEHJxj8c_q71BSYM+DasG09MF6fXkdTFpWsQopQ@mail.gmail.com>
Message-ID: <CABVzXA=7a9YxEHJxj8c_q71BSYM+DasG09MF6fXkdTFpWsQopQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio-blk: Add description for blk_size field
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, 
	stefanha@redhat.com, virtio-dev@lists.linux.dev, oren@nvidia.com, 
	parav@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 4:36=E2=80=AFAM Max Gurtovoy <mgurtovoy@nvidia.com> =
wrote:
>
>
> On 03/10/2024 2:56, Daniel Verkamp wrote:
> > On Mon, Sep 30, 2024 at 6:45=E2=80=AFPM Daniel Verkamp <dverkamp@chromi=
um.org> wrote:
> >> On Wed, Sep 25, 2024 at 4:42=E2=80=AFPM Max Gurtovoy <mgurtovoy@nvidia=
.com> wrote:
> > [...]
> >>> I'm curious if you've encountered any actual implementations where
> >>> drivers send non-block-size-aligned requests to block devices. I neve=
r
> >>> saw such implementation.
> >> I don't know of any real-world implementations like this, but the
> >> point of the spec is to allow interoperability without having to know
> >> about every implementation.
> > I did find at least one existing real-world driver implementation that
> > ignores blk_size and VIRTIO_BLK_F_BLK_SIZE - the u-boot virtio-blk
> > driver: https://github.com/u-boot/u-boot/blob/master/drivers/virtio/vir=
tio_blk.c
> >
> > So this is not just spec language lawyering; this driver depends on
> > the ability to read/write at arbitrary 512-byte sector addresses and
> > data sizes, and it seems like it should be allowed to do that based on
> > my reading of the spec.
> >
> > (Perhaps u-boot's driver does not work with the QEMU's virtio-blk
> > device with certain storage configurations, per Stefan's note, but
> > that is again just one device implementation.)
>
> Vague specifications and inconsistent interpretations should be avoided.
>
> I'm trying to make the situation better.

Thanks, I do want to improve the situation as well, and hopefully we
can reach that while keeping compatibility.

> I'll send a V2 according to the comments.
>
> BTW, Are you familiar with some virtio-blk device that implements the
> buffer-cache logic you've described ? or is it only a theoretical
> discussion ?

The most straightforward (software) implementation of a virtio-blk
device on a Linux host system would be a raw disk image stored as a
regular file on a filesystem, opened in the normal (non-O_DIRECT) way,
with the device implementation translating VIRTIO_BLK_T_IN/OUT
requests into [p]read/write syscalls; arguably, the host operating
system's fs/mm code would be handling the buffering in this case, so
it's not really part of the block device implementation per se, but I
would still count it.

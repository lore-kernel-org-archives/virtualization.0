Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741393CB542
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784139946; cv=none; b=N/DtK9YNLP4XWoDwsz/b5QlYBHvGRs2Ftz4Bw8lR7PVQOAffHkV9e8G5o44Wo1ADhr1eFWfutwwgHS5WmMoSKX8FGqqRO80RrgjvbhyGpiVIsf9EmbJ1eJgfaTxDccyEs70Qo+tZMKSdM2NorgSURpPXCrK3d+eLm6nP8UXNFNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784139946; c=relaxed/simple;
	bh=DRwysxMywiK5ujH9sdqFUZ+KdT3HQ5nuOGYd5rSddew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCrCv4o9tnAIHFmuCfMAa08/DfN2Qr3FlaBGYmRY84baTmTNnlmHIqkYuFqZrNhOrQZSOKptDfHRO9SK/l7Hn1BZAYQZx+c1y6rJ5+PYJP91BHRvmlCV+ea+BOgbQRW1Gh3QY3BcoC4eB9xLTgGSJ2MyCvoSMPgACr5YvVYYu74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjdgU91Z; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjdgU91Z"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cee9b74ee1so24033175ad.3
        for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 11:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784139931; x=1784744731; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EObXVbLcL4fdK7Ek+PIS7uUxJgkB9+Ku7XE2jyg9/4A=;
        b=kjdgU91ZdwQNU2Jfd+HBfckXBwwWys77iylqhQ2kAqBfvEXj+QdtZumwFnTxKK43oZ
         un8ZhT/nckuL7a3aftsgJGXU/RZg61o1+s7x1osrCewxUXB55hQarW7mWMMrahXhl08X
         iIA34smvMn2AM/zsOGznro6eP4QU+C7XW+hhMTKBF/yPtyQyCbYplGoUVfCoJSNTrMM6
         iIV5LKxcknYnFKQA4OThjAwkFdI1748eppM7qOpaFbTZXfVgcDqngrcl7G2cqynEUKCW
         sxgb2I27eHzoja8WznkC49CXRG/Kl+cKYiT2gqzjmt3jkGOkAWv9AT7jKrKV5xPb8inS
         LSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784139931; x=1784744731;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EObXVbLcL4fdK7Ek+PIS7uUxJgkB9+Ku7XE2jyg9/4A=;
        b=DTfrOuaQA5YTFj9LIS0cMFDiOPNzQrbn9LA5ZXqeZuFWOkktRhxe6EDSTZ0bcD4Zrm
         +nrPjoEL7xMYa6wy5BwtGcrAAZUc4F9fBQUG6DGc25DGD6X5ouI9bfJaByg8en+20x2w
         fLvoKyiXBUMaU+x4NE96A+N5gCSK/RkQUYwgEO1KwQRFqZMYLg4frISOvuVyfNgd48CY
         9HoksJb6+aJNrqNala+LiDk3EMPoFh1Au4MnJSzB1He2C3jbS2sso6DqP0Sp5XSGNl+B
         IQHopXFYEyVvWODb0vLMy2eiDTm4/iRO1qIvQR3sRA6UP8COFWCRga/Qooz6TPHkFi0A
         CZvw==
X-Forwarded-Encrypted: i=1; AHgh+RqGvGN4n8o39AmMyN7T1+Gfc8kfv3FQjyZE17P/hSRhEs7nZR+wGdZMkOLN0foxzo3zE4XQvWWTu5dLBreeng==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqDH8OYArOJEg4yf/ZGCWiLPoPPxI+MrKfV8FO6eKFx3yELiYa
	ggH4d8thbKLv2xCrHqJpjtqlStP/Iibe8vdynLC55+L1HTTKVY923VdF
X-Gm-Gg: AfdE7cmA1KPvzjpkDwViGsRNeZIGoZcCooiLRHNlXDFKaet2QQKwB9FVAbi4fwdRoVg
	UQPZCOhPKBSxRC++tfOqP1ctW9pxw9VYcfL34rLLOoFInSkbbLo6unwmMfgUZo5PCVqpJSj/8VU
	5cz0UnPGxnZBwZXte+Lmzm4HDm1DDXXfi8p3ZXjaXRUzAB3X59uoyIfDYK6zPIH2LoI1mWkvN8i
	PEmAMPuNHQQu/R8ykRTmF3bJ1gGB0hnuuoUUMuTQDLegV9ECR/Eq9e/UKPqiswCi2OiOSm3BYHL
	tYZEmNOQKS3WIaKsKsjjHwoTaSSr4mg2fm6TWA2ictiBueksleC9YpJPMljvcPIpOjsOXbbLVFX
	u13rt2ywum8HdJNYlXLggitXEz5A+QnuTHu6q6chU1iROZQnc0zCPv6YGHuTqdFjKjIVu7rfZ1k
	RSfXONUxY8QgcGZAswRULpSddwfLhZVeackvN1VYc8mM5csiEQOPp/
X-Received: by 2002:a05:6a20:c793:b0:39f:24a5:3065 with SMTP id adf61e73a8af0-3c36c0f8f74mr3900110637.7.1784139931134;
        Wed, 15 Jul 2026 11:25:31 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:575a:5ca:2b13:aa89])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e4fcd26sm3077101eec.5.2026.07.15.11.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 11:25:29 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:25:27 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Hari Mishal <harimishal1@gmail.com>, Amit Shah <amit@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	David Hildenbrand <david@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 2/4] virtio_input: validate device-reported multitouch
 slot count
Message-ID: <alfPcWKMGL-S9BRl@google.com>
References: <20260715142337.22811-1-harimishal1@gmail.com>
 <20260715142337.22811-3-harimishal1@gmail.com>
 <20260715115018-mutt-send-email-mst@kernel.org>
 <CAMmC+=AnE-p7B=DbBPYeNzJdcdiBf7q=5bfcuV0VQrPRK+pmug@mail.gmail.com>
 <20260715120911-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260715120911-mutt-send-email-mst@kernel.org>

On Wed, Jul 15, 2026 at 12:11:12PM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 15, 2026 at 06:07:56PM +0200, Hari Mishal wrote:
> > On Wed, Jul 15, 2026 at 5:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Wed, Jul 15, 2026 at 04:22:41PM +0200, Hari Mishal wrote:
> > > > nslots is derived from the ABS_MT_SLOT maximum reported by the
> > > > virtio device. A device could report a bogus maximum (e.g. -1)
> > > > making nslots = 0, which input_mt_init_slots() does not reject;
> > > > it returns success without allocating any slot storage, silently
> > > > leaving the device registered as multitouch capable with no
> > > > backing state.
> > >
> > > So let's disable multitouch instead?
> > >
> > 
> > So rather than failing the whole probe, just warn and clear
> > ABS_MT_SLOT from absbit in that case, so the rest of the device
> > still registers? I took my lead from input_mt_init_slots(), which
> > has its own internal cap and returns -EINVAL when the device
> > reports more than 1024 slots.
> > Shall I modify that case to get the same "warn and disable
> > multitouch" for consistency, or is a hard failure better there since
> > it's a different type of bad device data?
> 
> I don't really know enough for sure but generally if the device can
> kinda work it's better than not working, and adding
> a capability to a device that driver can't use should
> generally just ignore the capability, not fail probe.

What is the failure mode if we keep the ABS_MT_SLOT capability? Does the
kernel crash? And if this can cause crash then we should fix
input_mt_init_slots() to reject requests for 0 slots with -EINVAL.

Thanks.

-- 
Dmitry

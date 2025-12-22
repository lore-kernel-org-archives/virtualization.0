Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7DF3148DD
	for <virtualization@lists.linux.dev>; Mon, 22 Dec 2025 22:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766441916; cv=none; b=MXUiTd6l0me+neXBO8U/8h21yO7RZyGq+oIV/oRhOrfKYR+CsNH4pGTOKA55+OkYw+zdMVmDeCPx/N0T3h5mq+KnpCE1n+NPzpLRKprENW1h7U5Ozw1aso4VT2NNMi6ustpBpHQlbMS2MropywCKDHK0Zvb1Rf1J9zexNlAEt0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766441916; c=relaxed/simple;
	bh=fEUMhHxeSwminA/lpNh31LkYhzWLAOIwT4he5PZamVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WVQIaxoMk6H+75Ksi4qn58LPdyi6Ikxd7IEV8t5Rw3qZ2XEpTuEb3vij1mzhkoBqt3kt2qPAfve5PGgCwd0vFzCcomuLxd9L4gmmiV6rLcd+Z5mxPLXB3auN0bJM3S3nrYPsbyM2imPiI73Gg6zekP8RO3iK7fvo/mfeVPp2CD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TrMXRrFF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TrMXRrFF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766441913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=baQtHdFzu48XzxJedKWBE8MiYiBmE5aODElt4QVekp8=;
	b=TrMXRrFFe1EFBQSLq2l6lQf+W6zfq86IqBVYyVNVwRNp59M61PWxOEUOnqqImQkxkqxEhy
	wPCtJh/HumRXls1/GTrxQRCnY3J2BE75nqZLytlXaoG1pRgaHMhNZy1p72Uz61TxcjVjT8
	E6KEw/S8oiwbwtGF5zlAu+aoY33CVTs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-hcI2EjR9OfKJvTlmP5zvXw-1; Mon, 22 Dec 2025 17:18:32 -0500
X-MC-Unique: hcI2EjR9OfKJvTlmP5zvXw-1
X-Mimecast-MFC-AGG-ID: hcI2EjR9OfKJvTlmP5zvXw_1766441911
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-432586f2c82so1527555f8f.0
        for <virtualization@lists.linux.dev>; Mon, 22 Dec 2025 14:18:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766441911; x=1767046711;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=baQtHdFzu48XzxJedKWBE8MiYiBmE5aODElt4QVekp8=;
        b=xTo/UeaHyHifHBQb+SQPeSQotOET4ZDkPyR36qIrilTs+zEdzayYyV4WwVFhWp/WZ+
         YbTS7UhfZfXzwtjQbDd03Ya4ssmKxNez1RSZ0f9alKE3GUNZ2CJhiLZessUMNMFELIkO
         E4se4eSYN3KXPeSrbw6MXJQBdKxLJZWjxnFU0Jqf9z3LhDTz6S+nb35IYhCmlScmQ24s
         MUy8UN8XaOifSMpWW+vIdqrpkolaH1NtX+c0naAic4WQN4C3z4LIjYRssmpxXhbMQr2d
         YSM4VKpQ5iTerUqFKowpVf/bRY2IoXH5FpNCIT//LmTkwT9SnSCdL1THBzR1leJp7YGR
         doHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrewyTxJzUUj9gRC1249nJfE9XQG1JwnG5cAolyXycKhEEmxBznRsBGxljQuRpIA+8Mt7S7bKbVLB9K4fJXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxq7DqY3nfG/P3I+MrUi/seocHtTXWFKRrrS10fm948R9hx2Tii
	4qQVs2B2TIpezOZn2RMDJsnusFNgygDyOdt6b2IcS2xpXl9pLGcMEKTb76t+nk+HbeWAFP54kEp
	tWHOhMudY1Fvi2S8PFbTJ7j3x2058Plb5ePC03nHpnNsTejImfFTIEp5CAFRySlefd8Pm
X-Gm-Gg: AY/fxX4DO7pcV6Lfz12FAH6+nQAsxUvyDSe530Nz8zkHq4+gbcpRn2hdmBhlz7zeFOu
	ZsSaCDw5mr47xySUl0BToHTCv7y6ZDrf8zH+SUyfgn+HRPZArCgOQ/ZT4kz/7QVpPLNsliM5YID
	Zm2imK6YWmPZEdK/LcIiCUY7C58u03A1yWHU0ADwIx0aBaKBY20Oh45EEh41xJ/sRk2zj7vMXJk
	ne04t/tH+W+gdr4YUUSF568RAeHTGpam2ju3yCKvOvk7mCZCD7xx6ALGMAARhPkeaOH4mhiYn7U
	NZ2KrJa2bdnyTLkGYgguTFdOkJmVsel5FDmfA4P23qNgdzksVZt07x6tiWYYtul7LdnhMGE2k4q
	FLaQDZq0PCdHpnWn2QGHJC8NNbN5urqpO/w==
X-Received: by 2002:a5d:5888:0:b0:431:307:21fc with SMTP id ffacd0b85a97d-4324e42e79emr15948889f8f.23.1766441910876;
        Mon, 22 Dec 2025 14:18:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5lxuAUi2eLxexBNOCp+Rn8R0fHS47riPDOd9eqpxxHDGTvYtGJLP1Z3qs5yMU65szhlGTPw==
X-Received: by 2002:a5d:5888:0:b0:431:307:21fc with SMTP id ffacd0b85a97d-4324e42e79emr15948873f8f.23.1766441910467;
        Mon, 22 Dec 2025 14:18:30 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea82feasm24055548f8f.24.2025.12.22.14.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 14:18:29 -0800 (PST)
Date: Mon, 22 Dec 2025 17:18:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] virtio: uapi: avoid usage of libc types
Message-ID: <20251222171742-mutt-send-email-mst@kernel.org>
References: <20251222-uapi-virtio-v1-1-29390f87bcad@linutronix.de>
 <20251222033807-mutt-send-email-mst@kernel.org>
 <20251222111044-611cdccb-327c-4ed8-a75b-1a65aa353802@linutronix.de>
 <20251222052818-mutt-send-email-mst@kernel.org>
 <20251222114303-6d63eff5-792c-4727-8bb1-61a024884616@linutronix.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251222114303-6d63eff5-792c-4727-8bb1-61a024884616@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KKIcIKVyq4tiwdRI0ca9n_PYjC0Cp_zhhdIjyNFzqUw_1766441911
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Dec 22, 2025 at 11:43:52AM +0100, Thomas Weiﬂschuh wrote:
> On Mon, Dec 22, 2025 at 05:28:30AM -0500, Michael S. Tsirkin wrote:
> > On Mon, Dec 22, 2025 at 11:22:16AM +0100, Thomas Weiﬂschuh wrote:
> > > On Mon, Dec 22, 2025 at 03:39:12AM -0500, Michael S. Tsirkin wrote:
> > > > On Mon, Dec 22, 2025 at 09:00:33AM +0100, Thomas Weiﬂschuh wrote:
> > > > > Using libc types and headers from the UAPI headers is problematic as it
> > > > > introduces a dependency on a full C toolchain.
> > > > > 
> > > > > On Linux 'unsigned long' works as a replacement for 'uintptr_t' and does
> > > > > not depend on libc.
> > > > > 
> > > > > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > > > 
> > > > 
> > > > are you fixing other uses of uintptr_t ?
> > > 
> > > I am focussing on UAPI headers which include libc headers.
> > > virtio_ring.h seems to be the only such header which uses uintptr_t.
> > > There are a few other UAPI headers which reference uintptr_t, but only
> > > in comments or macros.
> > > 
> > > uintptr_t in regular kernel code is out of scope for me.
> > > While it is iffy, it doesn't actually hurt.
> > > 
> > > 
> > > Thomas
> > 
> > And other uses of stdint.h?
> 
> If they are in UAPI headers I will look at them.
> I also have a series prepared to prevent new users from creeping in.

I don't mind picking this but I'm just curious what's driving all this
effort.

-- 
MST


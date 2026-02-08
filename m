Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925EB354AFA
	for <virtualization@lists.linux.dev>; Sun,  8 Feb 2026 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770551736; cv=none; b=iN3vtcUWvTHF/6okVU2/uE35X/7cBO/jecxacWT/vNNRYqgtRxoytp8JtZvd+PHtzRhELpbAxm9U1pvZxi/v+W+fRfYRTCCrhVBB/OFoEtB8vmJMe2+RoRXut/TxGb+8Y31heMnnU1lLCkifOFrzAqqITLnY71S9hTFgm8ytxJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770551736; c=relaxed/simple;
	bh=C2SiIeGc0fc4JT8osnVgKzv3KFzn9+HInliVRVkG8KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uPAlPBviY4L4PJUDJ3E00ftY/A+RPOTzLy+nn0WDerwrzeZKu8U9Vuhko2sNZvAwTUUUcbaMVwbe/nNtQldWAK1x4suyNAWTKaDD2mXpM8nzpi9KrrdkWkbptth/RXTqp7dIfbnDF5WJRlTkLf2lVBIebFJ18F+etE37Q123oqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fm2E+Vqy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fm2E+Vqy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770551735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vaUt4fCaJFu3DVhgxoFsiUS0J+gHh91/ueXneDoVYuQ=;
	b=fm2E+VqyuyEQSS96YJy68r9q0fU6EJ/01zn+GkahX86kQTvd+JGfaax19su7IdycTxIZjg
	aUqaaWHvovEAGMKnzoVcsk9PTxYRD1ErgWA9T0ugT0mNhJiYyacK1yi7DZUJuRDY+AVYRx
	lG8OrtEPtyGUpW33kkmYolCNGCwuV3k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-yCaUj0apN5ezxVG1VZ1G_g-1; Sun, 08 Feb 2026 06:55:33 -0500
X-MC-Unique: yCaUj0apN5ezxVG1VZ1G_g-1
X-Mimecast-MFC-AGG-ID: yCaUj0apN5ezxVG1VZ1G_g_1770551733
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-435af2d3144so1462028f8f.3
        for <virtualization@lists.linux.dev>; Sun, 08 Feb 2026 03:55:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770551732; x=1771156532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaUt4fCaJFu3DVhgxoFsiUS0J+gHh91/ueXneDoVYuQ=;
        b=vPe9Tl8xQnG4GBfSdf5Z1/aId7zJYCyDke7HH+Fe85m9+sgHblRFYCiZcSOC4tQevr
         kQvt1JZ+lG9lUsxGGortigNmMQw1x/wrwsg47nyrwBVJ6sIZ9MNqMuIYRqNWrato8O4g
         KRBlD/0kZ6+Nes09MDqqBAIeTsKnd7ppuPVl8T/mq6l97MHMWsN2q/ceiyv+Cdz+PqrH
         S2QQx08sGGNJvvomEpfd3GyW0b0s68BCdu7+31Up+QlNO/sylfiyUNbjJcPSDCtfd+oa
         X+Y6Bdk7rCxp9IV2PLuaLeMgx+FwPdWmVikVYmUKJlGTetX63CgBR19Cs4Zaxx5O5vip
         isZw==
X-Forwarded-Encrypted: i=1; AJvYcCWkWSbTX9MTxzcdyivfdSqGNJU2LBqH/qekMgS2VJFjIHJIc5a4d2vI07k8u2XsimnbTKypwrgwcYrnrlfDkg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPw8nuXKny6lmrvkZZRAKfJgqhjU7b7WO5OwmdKN/MkJSWTeyp
	DCvvUerlC6dGmHFu60LyFnP10mqJitWmgx9loYByf9nwQn1qcxBVZk1vizBwH4jW+PAPQ5lXHv5
	QmP3g+ZQJ4Fp8qT9/r/SlPtmLRADW/2fh5MG7cV0TtjgSw50rqCgIoiTxXhyLBR9zB+sC
X-Gm-Gg: AZuq6aJp7eStonskzeU74cRDH6uza+0iXkw/72isVrhbPkmGhIdNi+YFOZbgBkLuf0W
	dq9Uqv6Lr8GitqYhD5XL339/5TI1WTwG9/i5/lww+98b6BeHlP5nIAMT3T9CxXOgf6dzuaJ4iPx
	T1eUWZHDynaQp3uPXHS37syPxvsLs0brblYv8ueW/GClB1mTa7DFQx9FbEbk85eB9t0kIb7ume3
	6v1yaFBk9kdiGWRYtwYYl7QWChavDYXah/4++UYkIMSNdr7CcNaPqZaQ6nC47bpPf9xqD3u6obQ
	PHE2POzy7p9mAQIVysgqqrbfnZ05GYU5FLPPbQaookbO8rkCecvcNbQRsR1L+Yk81DLjATHi4gJ
	ykz5BokTekrtmF9Uc3hW11nw4I93xPyx6/g==
X-Received: by 2002:a05:6000:3101:b0:437:6c1f:de27 with SMTP id ffacd0b85a97d-4376c1fe075mr1070806f8f.37.1770551732461;
        Sun, 08 Feb 2026 03:55:32 -0800 (PST)
X-Received: by 2002:a05:6000:3101:b0:437:6c1f:de27 with SMTP id ffacd0b85a97d-4376c1fe075mr1070775f8f.37.1770551731952;
        Sun, 08 Feb 2026 03:55:31 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43768d07fa7sm6062112f8f.35.2026.02.08.03.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 03:55:31 -0800 (PST)
Date: Sun, 8 Feb 2026 06:55:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v20 00/12] virtio_net: Add ethtool flow rules
 support
Message-ID: <20260208065456-mutt-send-email-mst@kernel.org>
References: <20260205224707.16995-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260205224707.16995-1-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fVfa_DtoNjeVVj4tJgtesduTdgkPf8W0TB_XamOYPyU_1770551733
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2026 at 04:46:55PM -0600, Daniel Jurgens wrote:
> v15:
>   - In virtnet_restore_up only call virtnet_close in err path if
>     netif_running. AI

what was this AI specifically?


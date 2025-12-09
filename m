Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4AB21CC44
	for <virtualization@lists.linux.dev>; Tue,  9 Dec 2025 04:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765254715; cv=none; b=ueMGNPR0CuuxTcRdrzxaxsXPAzxMo57TZouQCEymh9WADA0T++ZbWImJO2ErZkJpiGwbNIa34UEpHl+1nbt68jho/anb7Af/r+BJLNx1Rywft6BzE0nzg6x+yklntAZGa0+8/Hpv/sVLUghrnnDX2vEUJugU73gBdta0SLNP8+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765254715; c=relaxed/simple;
	bh=9tmXfHJq0QVXqDhHx3V0hpna8uVRq5KY1OcI6d6XAb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CP87GbMedDLYwy9ylaJQEW5vBG96byFBtQySkrgP4xtALYMZmrFDcnLbxz6+x3eb/oa96cUEoKQbJoUhDSuU5EBoCsDuzt/JdzTtzxDUvT81ks4edEB83NBB8XRMkMPmvB87hFr/JoRwQngsA1WgBr5q26wU9jkR/A1Z5h1NwOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+ZWprK5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+ZWprK5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765254712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9tmXfHJq0QVXqDhHx3V0hpna8uVRq5KY1OcI6d6XAb4=;
	b=K+ZWprK5fp7I9imu7SGdcjiCEwF6YOHWXnlpSiGsoOxgyvE0ItpGfxZ+Uk8R2PdN6hHB2A
	w4vcC5VDw1iSjE7DUVUNKubIGyIcppr077Z6kzMslVwhoU50moh+Ihb7NFOifSRA6XJb1Z
	ZNBvJaUlC5iZHPlwXZkQrDA5QMRTrk0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-1J3Q1b0WPaWR7QnxQYD2Dg-1; Mon, 08 Dec 2025 23:31:51 -0500
X-MC-Unique: 1J3Q1b0WPaWR7QnxQYD2Dg-1
X-Mimecast-MFC-AGG-ID: 1J3Q1b0WPaWR7QnxQYD2Dg_1765254710
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-343daf0f38aso6410569a91.3
        for <virtualization@lists.linux.dev>; Mon, 08 Dec 2025 20:31:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765254710; x=1765859510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9tmXfHJq0QVXqDhHx3V0hpna8uVRq5KY1OcI6d6XAb4=;
        b=Wiw8knVV1J12d3mMzVagjwx7asnoA9WImR2OyupWgyoQyeDhrM0HLl7CYQ/cF9jWXQ
         hfy8O/DTSSlLXO/inLJiigbP4RsuKWT+OrhN6JByCeAM73HPjlHfC/CA8l62bFcRfEhJ
         pRgeg24icZMNX6smA2mK7yjKCGUKTrl4bhgLIvge3dkkf8W5mrdGf8SdjXrz9zZwWhWO
         pqKFNUIDOMk1jNqpMOzqaTNM27xgUN5MBOIZwUJy6EmWin/t++mwzDqBnhyoNGtUy169
         QCGoHiCHRcCyDjVIBvr3guldm2vQDe2RI86P+GVeHoP5rTccxlgc2AXrPXMBDVKdv0FH
         coGA==
X-Forwarded-Encrypted: i=1; AJvYcCXgKc8RBaqQKYMdTT5VVfFqaw9da2clrFqeO3tYK7WHdpRX/BtXmUYO7nG15MU36ONHcWYLoOsRXoXnziPoQw==@lists.linux.dev
X-Gm-Message-State: AOJu0YycyrV6Ggfu1/rzZH+0gp5QHAz7vjnA4MuaMtUbQkpioGTRw8EV
	LJ/vZx1UUZcockg7SGmZ2Nn3CcrXqVFZeGbUy20NKCpmAx6lyyfH5EqTZrDWns9mkoAz4cUs0xc
	bmAFMIzSpfZziGb7AUqVmufW8dfjtURIWwWoporxgbLFtlfkN+7FFPNs0Lz38q9REDw2s02wJdj
	6uZU357yuV5n0UCePZm+Xv9tRyAuhCIri4KgZqtw5ivEM=
X-Gm-Gg: ASbGncvRUJ4Gl/0z5ZR8LH5yi2Wv/+hJM39MmOmApBWvJDFTNDIPbf5WEC9fdvrxmFL
	EMSEluJbPaYMQ4gHLJoLo9soN050wObG1ib+8eZyCpHQeb7GtJ/DbHJoNWUNQCHO6jl3niSqeiP
	0Bc0ppusDfC+NP4tN2NL7i601OqV0lVxNHQ5alOEhy8tdo2JTqe21uAkf6mWakY3H9Yg==
X-Received: by 2002:a17:90b:1fc6:b0:327:9e88:7714 with SMTP id 98e67ed59e1d1-349a260cd80mr8868157a91.37.1765254710093;
        Mon, 08 Dec 2025 20:31:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFagAAGBSIWmzncNsxEEwGIidmm4QE94jTVbMl759ESR/ChF09NNZHQVDtrpBmXJlpRB/zIr6Mggn3wUbwJ7vY=
X-Received: by 2002:a17:90b:1fc6:b0:327:9e88:7714 with SMTP id
 98e67ed59e1d1-349a260cd80mr8868139a91.37.1765254709673; Mon, 08 Dec 2025
 20:31:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251209015951.4174743-1-maobibo@loongson.cn> <20251209015951.4174743-3-maobibo@loongson.cn>
In-Reply-To: <20251209015951.4174743-3-maobibo@loongson.cn>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Dec 2025 12:31:38 +0800
X-Gm-Features: AQt7F2pZ0rzBBD0Uxig88MPBNmx1a0sCvffl8bC7YDxWOQkpVfaZ_NVPBNCGzo4
Message-ID: <CACGkMEs8E9DYzmZ8k4fH7h=fxC07wMsHizyDAE3wiKmQhkW3Uw@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] crypto: virtio: Remove duplicated virtqueue_kick
 in virtio_crypto_skcipher_crypt_req
To: Bibo Mao <maobibo@loongson.cn>
Cc: Gonglei <arei.gonglei@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	virtualization@lists.linux.dev, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5U-8A5D3v_tu69VjUAUFkEsw5JLrKKMHNQHWvNNUkRs_1765254710
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 10:00=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> With function virtio_crypto_skcipher_crypt_req(), there is already
> virtqueue_kick() call with spinlock held in funtion

A typo should be "function".

> __virtio_crypto_skcipher_do_req(). Remove duplicated virtqueue_kick()
> function call here.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716272;
	b=1dg2okRDp+/WrSNpZwBBI04H60vy6nr38E1st3BZDdBsF2kH9aue4PdIIT32OdRcPuS7
	 93ZbQPUIr5brP/LchX8/E2U7kRIXwGQztxWKME6PGlJPSZa+d8egzN2yUbjfuydjdQpn6
	 N55jt/gZDr98c0T4M1V/qgI3v5dntgXVIJDi5ldgxa6J4JHEpVFhNfE1WEMle6jP4xuXs
	 2eQIo+pPpCHRaiqT9TlnXO4ZWFU4obbifmMsL5wQDeYjU1JqL+sms5SiwY6Www+XFP+Z1
	 bX/0KY3GbCxMgxgF3GCTC2EZURHJW4F7gWy0bhgkv1+q8JqZ42oI5w8Kx0PuUOjFOJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=gJM0tAyN19ozTNsT7Q0jTKA95QkMzgeT7FdAvzFKoO8=;
	b=zPJmGPYJArPWmBuFNSsiJUIxZcq2wL68HFL+2qv3KXZvDR6wAJkU6xNbXMl7a1HdAsXl
	 zKt3qXuPPTM9Ly7qINN6EnYP2ombIeFcqlimwLtkwGqvyU3G91w17XNVyTWA32R5anpl1
	 bp1FQNvNtfVpMfF9vMsQehSRBRCjEq+PtpgxD+p+bdMSmGMZkekaGk8t6DnPmXUOIBE1z
	 Lnfyqe/75jY1pNIqUoBes2bROtnfYciryi8S0GQIi5DVxJC356vYEKjbKf5kZdu0AHH6z
	 kjI44+Nehf4C6clgWV/iSdzCjcQgt/JFx26xHl2FdNAm/uG/Bfs9WBSBjkhCcaBOL2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="VNiNg/BF";
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2709B606EE83
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 14:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2709B606EE83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VNiNg/BF
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a2af4c8d00so6270555c88.0
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 06:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716271; x=1794321071; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gJM0tAyN19ozTNsT7Q0jTKA95QkMzgeT7FdAvzFKoO8=;
        b=VNiNg/BFMilaO/9RHxu/XaDUV94OHX6NH9bf8tIbWlhW23YG8GOuHg+zpcdI893F4R
         be2G3VDsCdmDQJ9hIQCphm+2/mPnomw9zZXYN1NIQYTppZTUFPY1rCAZEagxXKBuSkul
         16nZcZMYt+52L8M2pEKZihtsjFpdqrNuvrb+EYoV8Pl3Tr9sSMvgGy9rjHT4gmIIRE17
         j8BwmFwLXfZzjaWz6X21fSSew/0+Timnne8Gfc48QKCFjLWxt6x3nX+xQ5yh1A8ylp2H
         ueSXxl+0pTAanV0NzPO8q/UjpDPYCvzhllQPtV1QZyZqiQzpJrD0iWT6kbFB/aU9BaxF
         ToTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716271; x=1794321071;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gJM0tAyN19ozTNsT7Q0jTKA95QkMzgeT7FdAvzFKoO8=;
        b=mLVoorIw/2qWxwSIEJ7STQ7kGo9kBrv1uLaHdri9qScmy8WoHoVLMbXRMnLWD9BTwm
         1te6ZbEwvHRREu1qy6WJ4tVv5y6aAPDSn+YYUzkKInnNvO/p42qRH/wsVFX2oOocP3MH
         CLrK9PNXxAFX/8G0sDNXTE621x+EFlZ82ywGxBoJtywfr9kWJmVS+ekf3u/OTbw8Wun1
         aCDrJSdm7TxR/IXgo4kO5mxmGDAG/sb/I9lC2wHY5pkcRwDo+/tzDrQ2lTN5KWn2eI/2
         j0pUP/LqJZLnDdVja4E4RWByT5ZPNQjPtSu2KITT7wL+3c7uJsOnR/MYnxtZbxPTb/hs
         EaHA==
X-Forwarded-Encrypted: i=1; AKwUvBzN7Xf+aQ0DetSgIT9QdnMyPA0pDT3E/iZlUDVrEh11xtI+HAYzkPiOpf9HQazSTIOTmgeKpbBrPpY43CrzHQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+NBR+QKv7PGXNL60dMIso93eqleToxp6ueaCnB4sRaSrbC1KX+
	kLSwZlOooEb2Lzcg9jK1iNh26VLb1hxLz1lNcBgtUm4MgaG92Ltz6ZueubVXy2oJH1A=
X-Gm-Gg: AYBFou3LEo0d+1tBeCOezFcC/zOdCREN14xNk2JMjdNcflqLPCDBcE0MayczdyZ3C5S
	61Kf4KtZifuLd8HMCJKRoUqTqHrnRW/61lojQI34VlJs8NvVNGp1bYgV8Y00VnSZ7uwoAhEk3rd
	novS1GMiU3Nvp+N2Pu20yt540ayUsluXW4GhXXDDC4iUe+x+DCxTvP0SvasiJntwOFjCL6ubLVa
	g0Eb+v3fgI2GHqnn89Skfef1oDBLfF9+kVrV6RyTtNIktOGWyMPm5E7aYhclEhx++lvITVGI1iE
	avIE9C3wvwI2J766VpRM10i/DEYtC9ukt/fdSt1yzeEOAJhFQhiYn7nJXtZiy07KNl/B/uhdFIh
	Y+nYQtW0R04sOSuOHpysEObg1+Cr5bRszy3OeFURrw7EKKdNYH6dHUpQme9RH0fvYCgz37NJSqX
	FZHqHlFyl3ZNV18YLZmvK+WQfrC3rhJ/WopGL8hJirsyzDW9WuCp+8N6D2Kl7Sa6muISfOcVQA7
	slraCqQPVaQXKSG6Wxu2vPfJwWtbj/lQeFwcq5uvCyZuRgBCXGYraNGRcdpaQTI6UOOOf/0Jahe
	2D8e5mr2kvJsFORt8K8nmg1AHZo+fuHRMKsJTIHzGLXWG8Fj7esGgv/kHcztDd9RsLgZYO/koIR
	6HbNuMaqJrOE4
X-Received: by 2002:a05:7022:258a:b0:18c:e014:6f1d with SMTP id a92af1059eb24-1ac55f2d3cemr24516668c88.1.1793716270505;
        Tue, 03 Nov 2026 06:31:10 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: mst@redhat.com, jasowangio@gmail.com, virtualization@lists.linux.dev, 
 shao.mingyin@zte.com.cn
Cc: pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com, 
 hch@lst.de, dlemoal@kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <202610261955196384aSLGuy3_0MiTvlYXVdiC@zte.com.cn>
References: <202610261955196384aSLGuy3_0MiTvlYXVdiC@zte.com.cn>
Subject: Re: [PATCH] virtio-blk: Fix zone append sector reporting in
 batched completion
Message-Id: <179371626856.3691261.9118119964005322830.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:08 -0700
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 26 Oct 2026 19:55:19 +0800, shao.mingyin@zte.com.cn wrote:
> For zone append, the block layer copies req->__sector back into the
> bio in blk_zone_append_update_request_bio(), so the driver must update
> req->__sector with the sector reported by the device.
> virtblk_request_done() does that, but the batched completion path used
> by virtblk_poll() only unmaps and cleans up the requests before calling
> blk_mq_end_request_batch().
> 
> [...]

Applied, thanks!

[1/1] virtio-blk: Fix zone append sector reporting in batched completion
      commit: 08a6572441a4e646c96c2b8d8ead9eea0e458332

Best regards,
-- 
Jens Axboe




Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB9A31D366
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 01:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791855914; cv=pass; b=b/b4i9S+nKmdbHn5bzKVBr2GlN+OnF5brmbC9fnRli3qejsCljopEme2T/7iHm6ceDvbl9Kczi63hDNqugKEN2Jw9f73DDqJkbjkZV8hsFy1436NRSjW64mKGhAlHTdb0D3+9fDaZR5pm8cmQLVdbHh1N/Kfnm/N9vdP5eJkb8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791855914; c=relaxed/simple;
	bh=cz+gED3n3VMR1ENKlJ+1/sgawu/JrM1+H8MqpXBZQP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJd2HH2A5701jqNA3hB3mIcWd2emTDnIUWWFgntuZLmNcw8xSJqrbOiepZsylX2B5FfgVfK7s+8G0ud0IfTTtNyVJ12n2s3FWyFCfnXvB7R0xK+5sY589PYZFzGd396h80G1Ul4F8uPe9k/MHJSNBUHFhyf8LXA1NyLJO+ZEdC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKs3W6y9; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKs3W6y9"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5339733feb9so23565051cf.0
        for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 18:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791855911; cv=none;
        d=google.com; s=arc-20260327;
        b=a3dZjkTGUXo3sXmNVgAAVN4/Ered8Euiz2uA3bxLZU8EU457CJ+1tufadUqEZsTqMA
         MrjpScvRmILavEb4FcTRnn4LyEL3v5pZnyONIyGLkVm0HTQAfYppPA5Kb+CRYRjt9MaG
         RnaiwvdCAFWoQwByGGrL2pK4QY+nDePV9doQWZ8FvlnhUNbhQrGq73c9UxXHPGBtNCF6
         evwTXw3HLavXMqey/8Q6ZwboRV6dFYRo1xFdlkb3HvDbGCmvyMHD3hTUyW0Jnr4QUWaV
         7ZVX9DnqdOY8MjnanZC82n3Kl3SYoe892dsZo7WVxHoO2aD5/4l6i5owj3u+sBSuKWIT
         xoBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cz+gED3n3VMR1ENKlJ+1/sgawu/JrM1+H8MqpXBZQP4=;
        fh=8toEVcvNgg2bC0o+9rrEjvaPCyfmdRAX3yKBwSLZ8/Y=;
        b=N3/DRZhHgbwafb2pq1LV9O00RmMNFdQQ3uoDa0HU69d/AwLKJWVI8ViGH85r57th9f
         GsxA6t9qD8mAXE9EhJzI4VuFJsnVeaeD622RArs5X4FOE5ve0KH/74BEjuefRiAc1LUI
         h+UiSUKBsUcLXpeJmJR6jBIem9rA9Uyz7vPkU1BdG8k7a5vlKQKrGlUuXc01WuOVAFtx
         nnVuOBgPShUXrfMS2MUCPsohwAI85wASmXFgpYTDt3n9F7GK+5rTtL0eHjhASIWhmWNJ
         lTIWOLIyCe6QEC2xXsVLt9RDlJLa9hyEsIEeyZfhcbV6Kno1spGO/4jgKFRX3xI8+M3g
         lJ4w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791855911; x=1792460711; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cz+gED3n3VMR1ENKlJ+1/sgawu/JrM1+H8MqpXBZQP4=;
        b=CKs3W6y9ckUqjnvscMm9xc3RkR1YVFQbktfH/+3lxp2NkaiBEfgRYbd8OTJ8IkCq7J
         GDyqd/2fHjFIpB95T4g+J7YHvxHqTbO/ezHma2ga/OYMdGriADDEfvh0kmmh3i8xlv1H
         E1nF/Y7x/xkxOXYMUOA89hpJ4pJOJGRy07SHl5B46WXEhBqaWUITPUJtl7n5JKZbbIYX
         DcFwnFrX6lXQ8Pp4Ue2aFQCrtF5ODubnCl4dBKizR8/7pT7x5RZOhmzkxplPHvCaQtoX
         tfCFVagSmdi81KqYL9P3ABPdQZqUNQC4vRwxUP0SdNTXGrJPUTOec9UgGZK6w/pjz2bE
         73Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791855911; x=1792460711;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cz+gED3n3VMR1ENKlJ+1/sgawu/JrM1+H8MqpXBZQP4=;
        b=blVOqIJBiX52oapfHracqi9uPlfNGBVFkfdrGyrEvsglfFlPaDbmKv8goSZdue4F+9
         wlYK+6bUB8xaawNlFtYLllbp785P9mavOZqMITIfleTuMdkKhRhr1duBrPqafvUfsfxM
         qbSDcpIPeS+ZpjDuAoi1h+bIGdUXfA7AQE9HzwrZMT4XNlZqD2ZhI8cb24Cu8Ozvq6Yb
         pcYx1O/3B/PbwnhGQab6N43Y+6bGVKyyRFTMcDupc1lC3xO8A1t2hC2+EIKQctECTaXL
         BU/Vg56tjC+wsSGiAkUecNeHQi+J+msEPE/m0n0ZTemvMSqtZnp3IgwVfqyrK/tcMRVD
         PPxw==
X-Forwarded-Encrypted: i=1; AKwUvBxpb6NuAKghL6VVwumCuWswRVcf+wKQelVvBXJ7MpGI3cluBQ1k1KqkIuoF8iVBItebZ1lA3pucwMX2NrY3XA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLoaGS6Hdhu9Q4275ARJrOeJaRh4RKYmJmLJ+rDVtIQZJt8k2zs
	yZCIBCcwjKWBhGoYCIROZqCmuxK4xFZ+rHLZ95JlzBkcsArLKrPw5ggbUX2K4LytN+swQTepUOi
	YgFE3LGuWuBLWCI/jfuOs7GMsX8GA2ho=
X-Gm-Gg: AYBFou2OEXzzx7gWijLcZqGTbFGU/Ck8tj5kjTFnTpW0XGTYDPRIibu0YbgFXLMDfGc
	Biz9KMQaTWnlEzIn9/2sEFFlgEaJLSS2lTzKeblVhJViw9XUrs3SNs7XUAMhiIWxSmYUpIqkpp2
	zwL7ofURcsTCGYku3UOlXO060m/Sibu+0L6GNiVJq8AFuLWn+f5p6sFM5G4cgnLqqiUnCQe6XKg
	mQw4YIldJrW6rz7VzmreurNzWGpD1oelr8uAkg8MGT8vaJVILHbDKlXTGEE3Pg/8l6cdkZhdieZ
	gioJ91CkXFCsQkT8/LXy3tMfPa1dFwaxDmS7ONeUzALxqF2gz58ObfACJQJRwt0mgQ5A1T219Ys
	sf+PSVupgMQmyOdxuILEuwPaRTujqzhdnGQIl1OP6JYEbCtbEbgblC1XRohFPWCiZYOE8iQ==
X-Received: by 2002:a05:622a:342:b0:530:430d:87f7 with SMTP id
 d75a77b69052e-5359fba77f7mr196535301cf.47.1791855910479; Mon, 12 Oct 2026
 18:45:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261012-vsock-guest-ns-v3-0-b32447c66b23@meta.com> <20261012-vsock-guest-ns-v3-4-b32447c66b23@meta.com>
In-Reply-To: <20261012-vsock-guest-ns-v3-4-b32447c66b23@meta.com>
From: Daniel Pereira <danielmaraboo@gmail.com>
Date: Mon, 12 Oct 2026 22:44:55 -0300
X-Gm-Features: AclHuK-kA8q05fe6Esk_oixM2BCHb47BieLQLjZDYfiDhY6CS2aMRdOMVHtXa5s
Message-ID: <CAMAsx6fKVQaYLzkK34v5DRkmQS5Ym-XqwNh-+Jj_Uue8NJCNUg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/7] vsock: add a netlink command to assign
 the g2h device to a netns
To: bobbyeshleman@meta.com
Cc: sgarzare@redhat.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, stefanha@redhat.com, mst@redhat.com, 
	jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	shuah@kernel.org, rdunlap@infradead.org, donald.hunter@gmail.com, 
	edumazet@kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com, 
	bobbyeshleman@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em seg., 12 de out. de 2026 =C3=A0s 19:51, Bobby Eshleman
<bobbyeshleman@meta.com> escreveu:
>
[...]
> + Movement to an unreachable local namespace results in sockets being
> + closed with ECONNRESET. Peers are not guaranteed to be notified via
> + an RST.

This reads a bit differently from the sysctl documentation in the same
patch, which says:

Connections established before the move, from a namespace that can no
longer reach the device, are closed with ``ECONNRESET``.

The net.rst wording also covers moving the device back to init_net from
a local namespace, which this sentence does not. Maybe use the same
wording here:

Connections established before the move, from a namespace that can
no longer reach the device, are closed with ECONNRESET. Peers are not
guaranteed to be notified via an RST.

Daniel

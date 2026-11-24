Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795518852;
	b=cnfSE5W4FL3RzQXKsL2xeyNDi5x1mXPJLXyLSFRoqHod5MEnCvG5DyglAXVfjJLTfDHt
	 6a/SlVS+4iZb6XhdBDoDGofAE0ivhUAjVKAODQwv0x7fu34IQO1i1EuOg5kHCHJrUHVvC
	 4upJUZCC9Ohvd5HfIQwnN5HrezkGf7VLa76SPJU/jbIsl1uD9M60n7HPG/oskflFNp1Hp
	 C8e2mCOCy0OlW/puI+1ss+oNA8o++k0FLB6rBIjjZRqrZ4XD9bPMW9GrHwC7krotWbAIV
	 4fGUbp8UNPfzMny8BS2tsk+vkSkoa8xLxtXotw784sVbXMEzwCGq5FpPowxPFveviig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795518852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=YxcSWKYnItj3yo5FCFqsfm26g9ItY5gHtNPYg7zw1LA=;
	b=eXueb7kK7jbw65YyMh8SQxY0ICPoly9v7x9SIrxnuplKAl8c0v7LQbRJxDq6ITIWQDtL
	 faq1lHkmoWotYwVBSpywISMhxP0lDXiufkYwa+exwbWQzuZF+itjcOWfJYDqcdDZLhTH8
	 8kpV/Qf0Dixyeb1VfO7UB6drGBEMfoRavtMQM2cgCwzN8OK61Pbjcyit6MYwKM46TNdNw
	 H5kwFbk6TKN96nTAWy0bHhFSmmhKVh/0Npg5nfhxmegixU4bo15N7+no1c0bneAuVGxFs
	 rcjm5Cc6ICfG+03LL+IIlnilTPGflWBwoFhUy79fsf2Lvd43OcWhjpy+L2JpN4te9Lw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szeredi.hu;
	spf=pass smtp.mailfrom=szeredi.hu;
	dkim=pass header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=GMzzcfBv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292B2606A33D
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 11:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 292B2606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=GMzzcfBv
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93a40a9a01aso642485585a.0
        for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 03:14:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795518851; cv=none;
        d=google.com; s=arc-20260327;
        b=lOTLAQUFvZR3yEhqor5IWe/97Xe3dnbmDBuRwL0EnOZe+TXvNc2/F7OOrFh4hhFGLS
         T3heAl3DYcXatlMjjxaxswDdvfwmGEPnBknm2LhNsttPr1Ch5NYmQ2mhkH1dztmQgCWZ
         +V0vuZ/xM+bRXEeo8Xb7kNQq7e53u4PPi7RKI3RsMDobxK+oL6OZ+/0vAaSE9pq0Ynaq
         qGxG+CZRvF4bqQU/rOobomBoHor+lwTgHHnAxmKO9CCWlwSHD16g8XE+HwF1At0omH+U
         Lb3kpcA+iAubELt+/OVw0mwCde03VZdngooDfqsr0sw5PFTEM6zEbAbDIdr1n7acPDz0
         /rOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YxcSWKYnItj3yo5FCFqsfm26g9ItY5gHtNPYg7zw1LA=;
        fh=6PY2xdcIfen2RxHig82hzevPixrvJhL2rX28UgEDC/M=;
        b=FOvEp6xRLU5eae0EGWpUyqQzV1ImOkpXySplDxhjaY/y+8A+1sXx/jbxdLm3fF64Hm
         W6cp2JICNvZqPrgJlbWAuMUEReYkTWOoFuK6ZBgG9gwGxCvtmj2sYgwsrIQKgbsvU6rm
         Y0VTyWxpI5kJBCQTTUz+H2L2VHjp4BUh1nGC5aKDmAD3HjqwT3rAaDapDVNETkWg2PVV
         AFEXn1Hd3wGWKyPGkzvTojCZokZTn6+fqqneYMTwBmwFYwya393Ri2KTUB+WVpslex79
         yYlzeNnktNJMxgNKvrshaIep58WCtK9CT4awmofk21hsfAE373k+RHEpG9OEVRvIA/I9
         Um6w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1795518851; x=1796123651; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YxcSWKYnItj3yo5FCFqsfm26g9ItY5gHtNPYg7zw1LA=;
        b=GMzzcfBvw+aONBCpWkjfANJ6eTt7SCTdxcTNrqAbFsQlXUww+E75+oNRQxShLUNA/3
         LihFRUw40zgScK/aVX9Ex3KN8pBKx+Htdt0R6r6WhHeHSAEgvOsZP79+JNtSiVABjTL2
         tgwMkgP+cx/csM/Y5yW24w498WmHXnLlB7J5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795518851; x=1796123651;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YxcSWKYnItj3yo5FCFqsfm26g9ItY5gHtNPYg7zw1LA=;
        b=sCEoMCFXJl7PwbkY3D+p9duvFdHJX40vO74bFWuJWRxjby64knGCcQ4C0SOyln80ba
         J2kbid4wOFgiFxkT2n+Ck2gCljIhkqDBwDCpds2TkrDumnZTdF4XB5onqE2wSLDlWkSH
         gs1yMk7VSj69ta8B3vdQBdXazJXP0/AZkYp7tz+N04UQeI+Fx21qcGHE4zMuikJcqjh+
         x6kZPiQ8j7dgP5Uryhp7RKSK0hbOOYQMMvqdPWayZvK8C5FqWPkCb1wFUGblUleggBdq
         hdF4y5n2EFNZ2BbmRMCMBzreWHkFvEvEQHookMP6/XzqziTIKz1QUDtG7NDOf/1tmTas
         qR1w==
X-Forwarded-Encrypted: i=1; AL+hErEYkWIGoOeLHhuexAEnRM8KPNRkWkmPnlZQ88TrZjXaciYfUBanJrcbtu9wUsPOXxqsWjYfuiLgDXv2KEJC4A==@lists.linux.dev
X-Gm-Message-State: APuU4Z8Chfgo92IHVxgVE1mZTdZEGhlLQVuaMf9B5DIjSsCzvUs/F4Ub
	VopgSu+KNehkhVqN9fgOlFxzr3O5JWf9mpyDc6a0p912ipmK7MX5ceqjgt/8fdybna00qD/dzUb
	v9XJgDIhU4MNxZKBVDzbfr8cl/1ktvL3eDLyoc6oA0g==
X-Gm-Gg: AZFdTZd+PQm3fZVjB7005tFrCqSobmhbNBM8fF/ybBpg3G2+iwItKk7TVgIWMWk/AwT
	XhQlH4JiIVxUZRzfKdxBpbq+0kXOL5GGaNolj7sD/1bhugzqWMEbn126eCDIipaJuTBqoxI0FOr
	NAfK5r8vljEfQIC58qwoGN9NilBoHNCOnJ42I/tpvTlMrbTkEYtlY/52qaS9+mX79yCc0C996M4
	qWlDrm5PDv4hd3eVK9QQqCipw5SMryHY9LgtVT2J0EMLlPWer8lod5/yUfsV4uswhDcjQ8pvo5f
	b1CNSP3cgZKw6TxTvdcdgPjobyRingQNLEpVIlaGFIZuj5Eq/yA7UM2zQagzLXnLc4MapP5Vbxk
	+Q+oDwg2VO6Xt2hXmZfTtEeZnDexoTrV2sSD0wQtA6TuoqrJbCbCJLpRNcN8hKnYoEA==
X-Received: by 2002:a05:620a:199a:b0:949:aceb:b77f with SMTP id
 af79cd13be357-949b36034edmr2558799785a.30.1795518851115; Tue, 24 Nov 2026
 03:14:11 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261123095455.88622-1-liwang@kylinos.cn>
In-Reply-To: <20261123095455.88622-1-liwang@kylinos.cn>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 24 Nov 2026 12:13:59 +0100
X-Gm-Features: Aa3M54pbj8-6gfE1d-Xj-d2hBGWMonaIctmbDSe8aODDQN2gLU60G5Esc5wLwmc
Message-ID: <CAJfpeguSMMaBuELCVtUpEvCZZCRZK-xvs_TMMD8r_KuuzzQoaQ@mail.gmail.com>
Subject: Re: [PATCH] virtiofs: fix potential unmount or device removal hang
 due to stuck FORGETs
To: Li Wang <liwang@kylinos.cn>
Cc: German Maglione <gmaglione@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, fuse-devel@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, virtio-fs@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Nov 2026 at 10:55, Li Wang <liwang@kylinos.cn> wrote:

> After the FORGET is dropped, return 0 so this same worker invocation
> continues with the rest of queued_reqs.  A full queue still returns 1.

Applied, thanks.

Miklos

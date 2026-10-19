Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792453624;
	b=wUUJC/fbKN9664QVHpwv0/rAa758krm/xeaHxsAqKpY3WrH7ZrdHIEiK2KGJ/2UANOuH
	 25pG2oGEP/Snz7nk3D9xuhJuN8gqBxaf8L/GVFW3Yi7V3/CXHxXtOZ0SfSBh8R3NSzI38
	 h6GQCeRXVj8zva8Z2GHUIEScIeOLXfkxOhfgAhluxaApL5uIF1f2STM+Jem1GtTm3Yyf3
	 zl3puQ3zTCPEhB2J3f1HKrb5MQecNNc/1IEfQ2Hb6421iK/u+L6haMppgAjqRdlajeax0
	 f7rt41e8T3tnZywURYeGaMoCh8Fw9AdRKI1HwmcZON+/tAXBx/AxCdnHNUd3VYdXCvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792453624;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ypCU1E5MKpp7DyfKc2E/egobrXvy2R64su9DcxdosVA=;
	b=ZPlcWfSGUNc+t6BUHEAA8wYwPSEXZyeikHPKrR57iEsDCpM5q06K2c8HEHzO5MTWKZMO
	 T0HWaKViWrZqua+wpa7GTK6FLWBX7v5ubR/Dx1J3ZjcuF2TIoC3KqslPC9lz1Dzunbw9Q
	 ultKsKgkEflSpdK1beLa8ElevZ1pqozhk44sb0C/wP8IT0A9OmRVNDWFc7c9cVmnqbix3
	 Bdl+YO6q+zDDZbiIclS1yqMqpnXBc/guAr9fpjq/q4ACxfeCiRJ9R3kKPHYTYefAKrPdq
	 8Td2crlcZd0kWTcFDET8jcdJvL0x5+NKGj2QsO9mgUMxD1djJjETMp9edlmO2ClieVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IpCAD0tC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90CF606A319
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 23:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E90CF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IpCAD0tC
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3ab46699a09so8281271fa.0
        for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 16:47:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792453622; cv=none;
        d=google.com; s=arc-20260327;
        b=haSC+neoTEL4DoikOO1IkyAAF6lWXRpv5Ryh3hBtn0GO7+SJ94r94g3DHMf8/3O+s7
         Kte6UPh5EzmFBMrsxMN3Tppv+6MStsNMP89iZOL6BR6h7jjdGVo0M2uiKUFZ6gtAamEO
         M4L+zERBLuE3LsKD2Yha07jFFLbUS7AOuC6hI4AXCy+fATMCBAMLDk3EJt6X+52l7aAX
         xNWjSVVJW8N8OUkpnDeJUM3n/Ga+i0ACm8f/htpPfT9UCNNBEeA3em743UHDz2tjQ3ZY
         ryAcdvjbN7DT7XI2eB3MSAkbIUumrs2cAapwqefu1V9bKWb8+pwPuk2ApW+ku9XlxjyK
         lQQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ypCU1E5MKpp7DyfKc2E/egobrXvy2R64su9DcxdosVA=;
        fh=xD6SFKOGkW0gPY8GvBGYuZCFStgBo/hHpIoSnWmZBno=;
        b=ITqE9lTqulTRRT2skuAxvBscD3ta6ovyWmbr+KpaFzCWyrTh4gMksFixpwG86xocGU
         +6QDTDSy0i6g+0+lEHdEqYzFiG4gC9X8sa9kI+THvoXYpqJcLW5HQCFllZWp0FFRbK7b
         +T6KfCW6jrSXn3wzM1Qh8g/dvk1yU9eDuBcjJNV+DW9+ERs9SLAuBpgFEevbtBTh0U8v
         VnMNKsOJw9ZA7PTXiJyNlGPNLfNToMohyjwhNHLBu4eLz4mnYRwJm+b4TATJRanz+C30
         DHKpR42lWyN6qihrY5JiLBMSN1YqUAyfbeSUFmhhJEGUM+BlO2185KARnBkL79xgCQMo
         CCLA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792453622; x=1793058422; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ypCU1E5MKpp7DyfKc2E/egobrXvy2R64su9DcxdosVA=;
        b=IpCAD0tCZz+6wJYSVqiCyWQ50QJY3K4V9T/0OXQSHDjVGwgq+9hdRQ+00gK1znJ7CY
         ZXil4kGEI4YE0Cg3gTe82Ffkl9+ntfJDMbsQzTkb77ovjtArqthccfvsyJ+62i/7yJFQ
         0DReVtyF/dgTBUmP2i3Be1RYU2JQwLYJARor6T+5LsJkeeRTNZJSehfRws04yvMmskJh
         H9n3w1vKExp8M6nrzWfepxc5wEV1AcTk06qLx/0Z0x9LkFX4b4TY1p04DxknfZpNjuB0
         SDIOB/o8t75qiM0X7cc2QqNg3edKoim/KLUMryQkzp3Xxb+hA5JQiyGjeeWH1slhCjJg
         73FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792453622; x=1793058422;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ypCU1E5MKpp7DyfKc2E/egobrXvy2R64su9DcxdosVA=;
        b=I1uXyaqhNidAik7VD5t8cGiidGXWzyaSenEiEHmM2DpecCC05wlbV2eCbHYq/glB9w
         9zYnWVh1HDqcK0X292m7dEq6oEW0qShAtu575+G2UMK6Iwtb4xHrEUTuH+QDLNzf8b7q
         w6/b3smyu2pGKfs1ih4Yi2B06ctmPXxDHAorN4T09go55FsNk+ssl+gh5EqVLuS3QVsd
         7+gOeaBdcOLHKzt/uYEJZd3bupijxss7jYS8/oi0oADFOA16y9XCMPAcPHn6/ub9xfYu
         oCKE7YqEeed8USc8goqZYYcgCVTM/UDkXAj7uh3p7knr7cy2UBQ7TX3o2g2foe1aCBrt
         UOXg==
X-Forwarded-Encrypted: i=1; AKwUvBz9wi44f5GZgZEH+ajVbAraxslEOquE/it7dHAuQBQib7+DfJvvHqlfULWe3yIr85zOKyrylo1xg+oSXIVItQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJDMmJpEffY9CU/nTdipAJoJiul9k18ZFv50dNk9lYag8sbMQ/2
	uJLAmGNgJZZHAnLlbbzT2GrqKo9UEZnNe5fHaYipopH4xloZY6FJax34vIBi5mv/2SneJheUl2p
	Ol4rPXYBERX2YHgwxt1OmyQ/vpJO47gI=
X-Gm-Gg: AYBFou2qW9ZDqUeLR5LQLkgImzhXhKzbqXFX77ZHuIq8YBwYqFo5opagDQRdKMjyB6U
	QC76uF3ZuwhRH9vqaITOnJ3NPx2zCgtJsdvL7Nel6yM5hxsfHMHHmVK3JNTW1ry5f6xUHpPhrVU
	avjQGJmdIVp/c5vOFDWnZvPvjSPL77y2+5Kb7PyR/OG/+ALegLbx8wYlVyXEkXFUfDu4T22YwzY
	yfHBToti/+U2T6Fl5hPUqltWv+UJo6BVsUxOXA/q7DoFqc9sMpkRm2LGuV0lLeOApwWLK+RveHT
	5TU2xSM+ffis3gYjwyhmU7UpR2WLJRSnuQYu4thKGzDn2MJAhnvszg==
X-Received: by 2002:a05:651c:510:b0:3ab:2d74:71e with SMTP id
 38308e7fff4ca-3ab2d742b84mr17797071fa.10.1792453621900; Mon, 19 Oct 2026
 16:47:01 -0700 (PDT)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261016023521.747447-1-oss.patchbox@gmail.com> <25a35fa8-9540-4892-8375-1788e6795dfb@kernel.org>
In-Reply-To: <25a35fa8-9540-4892-8375-1788e6795dfb@kernel.org>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Mon, 19 Oct 2026 19:46:50 -0400
X-Gm-Features: AclHuK-d2lDGIbO0nMDnG4pSmt2gfW-rFmLHGdUc2vgLpFp-z405iCYiTrPxDos
Message-ID: <CAGG=RgDUFpDqtbws4YO4T8A3pS4Dr9twVqP9hSD3J_zP5Dc_mQ@mail.gmail.com>
Subject: Re: [PATCH v1] virtio-mem: only mark the device ready in kdump mode
 with vmcore support
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Oct 2026 at 09:05, David Hildenbrand (Arm) <david@kernel.org> wrote:
>
> Which kdump kernel exists that does not enable CONFIG_PROC_VMCORE?
>
> IOW, why should this be stable material?

I tagged it because a9403425b3cf has been in releases since v6.14 and
PROC_VMCORE can still be turned off with CRASH_DUMP enabled, so the
-EBUSY path is reachable in a valid configuration. But as no practical
kdump kernel disables it, I'll drop the Cc: stable in v2.

> LGTM, but I am pretty sure it does not make any difference in practice?

Right, nothing is queued on that path, so the device has nothing to
access.

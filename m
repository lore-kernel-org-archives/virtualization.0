Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E493F287502
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Aug 2025 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080165; cv=none; b=Ffd8sL5Ocermt0WPwdAmO67EL3Jw8fF89expFRZrWVTLC+jeFFUGeUuUv6N9ToaQSf6g5VZlB9XlgcDkjp1bwvWbFs1c5/BOxu6RWhVBZvURz4YsJzFE8+oyTzl0TDs7chUsWTfjkh8B5NGzzr1VXjSuVCqPrt1Gfhxc4x8mcP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080165; c=relaxed/simple;
	bh=ft1GtVlHTumH5n9zAoqypec1LBFsX5MTL+yaj3JjcSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHhsU5WUo48E3ocHruCQ5H9W8y6PbJHoXuRJgd8tvp/bqOYeHlhsy6XT+p4bi/CbdXtixtDVbn5RFqR/cECKurpeA5DIAMAHnvabZ11zuxnmnEFJN7zfB3z/e0RJKG32yIj2OimB5+XWZhGb3xEuGdpijL3GNT2730HPHpZDu5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VFWKYoj8; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VFWKYoj8"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 65EDC828F7
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Aug 2025 20:29:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.751
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8xGWIfUYG98T for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Aug 2025 20:29:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BDD9682784
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BDD9682784
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=VFWKYoj8
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BDD9682784
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Aug 2025 20:29:21 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-adfb562266cso414044666b.0
        for <virtualization@lists.linux-foundation.org>; Fri, 01 Aug 2025 13:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754080159; x=1754684959; darn=lists.linux-foundation.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QXkdEcm3dcCFEHiiyHz9se6bX6iRUxFV0EivrOFS6/U=;
        b=VFWKYoj8cNN3/DC1gWefAVDdvMPC4VjSK9uPmdnmPyqK7DFLUxAwj5ma5aud42kJKK
         048NXmxDfAKldOluN70InA1Abn6Nrs/BBwMBZvAvRIHl0hvcu9H7IdCsV8b4HzIKEjWk
         BSHZ08EG0luQV/JyAUvSqzZZx28cpiiFlgM4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754080159; x=1754684959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXkdEcm3dcCFEHiiyHz9se6bX6iRUxFV0EivrOFS6/U=;
        b=LLoRc5Ct/I2fOWKQo/TKp9PSaxHchia+E1dmLx7nN0z3JRy4WuWuyevjy3ykXOO3+c
         ahiEHpX/3/th8Qrvpuni3lcpZg5yN+0XKTJFx4+knZKxDN8pzahznpYBV7qbGPkdjYix
         W9tINqfPRdhLB+4vrdcYiSxTx8AM0Vs83Nn9a602X/m2xLphF1AxcN8xFoeSMSGx2Bvq
         wcLx3m11pjHmFZQwgE7L/KEYgcjfuNooI7/AmxdUrTIWFnxgAMot9rqN/+kT/1vUIe8I
         UlS4//cb7mwcRNG4jhcAeT3Cfo5gFaKMdD0NXv3h08vvv25H4jvCLHNXfJW6ksUzpata
         yaEw==
X-Forwarded-Encrypted: i=1; AJvYcCUYcC8n/Y+J7bpuahwSFiv85nk3XQBQ23AaX3ttTwSrzjd35hbTZIEJumN34hGaw5f/j/Kv6MuEzfGYvtbYcg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwxeS020UuT6vhBTomR7SusKUEyon/3BGnbQXY1O0aPkVgDWLei
	zltUpTGqtyYzyhKce4sVICdAkBAHpUV+gz0r4DFx/bqBEf/S5Ci2QdH1aku0nLBrPbYPSXlV4o3
	gRretcbbF6Q==
X-Gm-Gg: ASbGncsNl0w9ok3S3KuDWPeEhQLnXomuIKHSA/m9Q0tHXU65oQBCu/gQoOcMGok+KUL
	m2O+j3bdmKm3cplRl2R9V0FsDKqNU7G9taQ78CGose77b1TJsppFdFm76XhcYpAyzdCNs8ZW4GW
	xdsl4/UcEU/71aNuE/YhTYI96NDi4UeaA2M9u/hDprXK3jVWXcLh+hvGxgTfeUAwPsPF1cKUe15
	oK2tHjYENke2E7br+tyX0T8Sh07pKu40calAS5lzarAj7mo9+mATRSjrFhUOpINs/FfSbGuPwRa
	vaUbmoyJSqVtfzlm5mXZ8pCCxSbREFIgr2qZS5HoPO2kzkz4L51woUD7qwKSUB3cPTWs+XV1Pea
	UD8OoBcN/m77/Q32bYvfco13GDrPjfIM7W8vtzOkAQUdvwo0/QHQWNVphrrNSZHJBeOkMeaoj
X-Google-Smtp-Source: AGHT+IF/1omOmfSL9vJ34xxhGS0rZtwcVh/TAkGc2YdlCYnwylCytpahGCH0MX8OpVxe4nEJQ0Sw6Q==
X-Received: by 2002:a17:907:724e:b0:af9:2f26:4f7c with SMTP id a640c23a62f3a-af94023410bmr112577166b.51.1754080159364;
        Fri, 01 Aug 2025 13:29:19 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af93d62bc97sm60051466b.80.2025.08.01.13.29.18
        for <virtualization@lists.linux-foundation.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 13:29:18 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-615d1865b2dso1658252a12.0
        for <virtualization@lists.linux-foundation.org>; Fri, 01 Aug 2025 13:29:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgYmuvzif5K7syvzxmVyvXEMm2bFhYyP9oHVnmBnpyPBrhNytc7EKl/kXtYpJ6LGEhroAzpYJL8mL5IulR9A==@lists.linux-foundation.org
X-Received: by 2002:aa7:cb0d:0:b0:615:8012:a365 with SMTP id
 4fb4d7f45d1cf-615e715f7a6mr469886a12.25.1754080158122; Fri, 01 Aug 2025
 13:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250801091318-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250801091318-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Aug 2025 13:29:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whgYijnRXoAxbYLsceWFWC8B8in17WOws5-ojsAkdrqTg@mail.gmail.com>
X-Gm-Features: Ac12FXxywlhxHC92NneGnmmt5Hm9rlPrKO5mJOfIsb2I5ZMf5olIOr9KL1pDLfc
Message-ID: <CAHk-=whgYijnRXoAxbYLsceWFWC8B8in17WOws5-ojsAkdrqTg@mail.gmail.com>
Subject: Re: [GIT PULL v2] virtio, vhost: features, fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alok.a.tiwari@oracle.com, anders.roxell@linaro.org, dtatulea@nvidia.com, 
	eperezma@redhat.com, eric.auger@redhat.com, jasowang@redhat.com, 
	jonah.palmer@oracle.com, kraxel@redhat.com, leiyang@redhat.com, 
	linux@treblig.org, lulu@redhat.com, michael.christie@oracle.com, 
	parav@nvidia.com, si-wei.liu@oracle.com, stable@vger.kernel.org, 
	viresh.kumar@linaro.org, wangyuli@uniontech.com, will@kernel.org, 
	wquan@redhat.com, xiaopei01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Aug 2025 at 06:13, Michael S. Tsirkin <mst@redhat.com> wrote:
>
>         drop commits that I put in there by mistake. Sorry!

Not only does this mean they were all recently rebased, absolutely
*NONE* of this has been in linux-next as fat as I can tell. Not in a
rebased form _or_ in the pre-rebased form.

So no. This is not acceptable, you can try again next time when you do
it properly.

            Linus

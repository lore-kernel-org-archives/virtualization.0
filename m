Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A4A1C84CD
	for <virtualization@lists.linux.dev>; Wed,  7 May 2025 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638590; cv=none; b=LJpZSCCVo23tlb7lxIOLBn3xeCMsnp/f8puyA7uUE0hxef66V+1ls4fSCC34Up79NHTXHFNG8C0jr3szASVtyA6N5J0fQiayNVv8/QahMuHu4wXufwcpQ4Bmp4IJKIQ18mR1fFKzgaE7UOwmLVNvIbO8cpmNNtOFIx8Hs980fdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638590; c=relaxed/simple;
	bh=x1gyXbT/S+B28a6G/kIRZZpjDr3aUMVX/8e55YIp0z8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oYP2TiNn/1a/GkF8LNfQjBeZ6CGdzVvpk8gzdJu+itZp5096YxA+mxM9jqsn4dEUJXibklBBPvd8V1MQG0BllCC7bGGq9eV/luKYEGdUILXBqOFyToJR6BrMl+iGSCPBNcVEyyVY1qxO2iHMnKHype38G8RF6bvYdZq0fr3Uf9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qz7CrJn7; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qz7CrJn7"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-476977848c4so740581cf.1
        for <virtualization@lists.linux.dev>; Wed, 07 May 2025 10:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746638587; x=1747243387; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epvtqXvzVJ35ldYX1WXocWaJsX9TF2V7woAutSOPuUU=;
        b=Qz7CrJn7nXBLee8XVdd7TuNORhJiHKEf/BTN9nA2TD60JoUBX9ri18uonTrH81IdBp
         Wn3onOMXD48amtox8f1Y9oOQSTV4++r+vEqOgdLfC/yEwJSGCCPJXRCobhH8q1/V6M94
         sn7N+B7B/CjmOJitKkd7bJohtFFYNzD+chygzrzcJcdkB0Kb7erqGgDa5ukeIZAdSK0P
         /+mGp8Wr6+dLeRep3d/HW6M6g8EXITrnQO0qsHe9C86NRQToAfpIIL3KbRS3ezwFppde
         5WUZezqAsNE+2J8Y6kiISUPkkCQb+aPBAOPdQlQwtMGJLFmd/MDu0MlNop2Gz5NKrGJS
         EXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746638587; x=1747243387;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=epvtqXvzVJ35ldYX1WXocWaJsX9TF2V7woAutSOPuUU=;
        b=cmnFoHWOJxppNd0K2MsT6Gfn6fAu2Yw3EA/+cnuwSiBdkrUpL/DzQ6gFCX0fP4t5VL
         2Tjm6yAOW3MDSwrxnHINL2tv2Xv2XhEmDFLOTfsg8RRqnqTN0j4ve7NDzdf9LrzgRarE
         lIEHn5kGNjdGqunNhiEQ4lwOlEV4s4tYoCQXNSe8O1yJTNO2iWQ4BYUOIQrOw/WYT8Wi
         efCq+8rHZ4gJAJ5GtJtrddYPZm68S0BEUqsItMN8VMXp52J0aedpt9/sTm2x/52KLkF3
         rPoTMv89ADOkF0F70WSLZl2S9aAo8pbG2RHCD+9r/eNho6Wcx0LaBVWrs5y+wU+iV156
         rWqg==
X-Forwarded-Encrypted: i=1; AJvYcCVO9YXpFXHzdfVLPfs1wSPile4w3Z4E6wQfczfEa4xAXqbmVjj4LpQCZpmBb76zcFwLgqcrOPDb5f5lwaQFjQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhCjuwtM/RTBlfC3Gna5nVplWiuhwAu8HqXaXMm6QK59HGHjbM
	qPiPRXAhQX/3NnN/Qmp8u1qQRMFq/KetWRGWyGtZK4GhqnslTJ6l
X-Gm-Gg: ASbGnct1D9fEJI00UxNB/jk8RcQke5SUwR6irmAttld5ogYOFZ6vo2Pf9SBEREVGnuO
	noTE1P82OjGbCuWEyoS6o9UY67UwI6uk0yYkJKDyB+U4vH8PsfcVB5s6i4ZDFCGcMzpbF6/oQLQ
	q9r5D29rSnfRg+M8l1cnbJhow89lg8D0EDANgj5HUvLnbgY8EL6UF57Grr092MsLvTqxXgp1NqF
	XsugxSypuaWsFlU/5ZbS0vPvxGjeujfQz1xc9VYnnwAwj26MFi4f6EOuwvDxjB8snSU1g9OGprq
	AnYzbQxd3tav+HgUDh5Rgg2rtwfARPfKs0+PVutHZbM+PwcWhUjw7I70wwNo6gxrIH7gMXwlm4h
	4zzoPbiVwYpjEpkCwlhaH
X-Google-Smtp-Source: AGHT+IHu8OzU2UsytBp5/yY37eO2UZ14MoH8HE3a/AeEucjj4iFUT5vX0fIqAM5Q3dMu0UjZdyS4yw==
X-Received: by 2002:a05:6214:301c:b0:6ed:cea:f63c with SMTP id 6a1803df08f44-6f54c37347cmr1080196d6.6.1746638587212;
        Wed, 07 May 2025 10:23:07 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f54264e206sm16721906d6.34.2025.05.07.10.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 10:23:06 -0700 (PDT)
Date: Wed, 07 May 2025 13:23:06 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jon Kohler <jon@nutanix.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>
Message-ID: <681b96fa747b0_1f6aad29448@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250507160206.3267692-1-jon@nutanix.com>
References: <20250507160206.3267692-1-jon@nutanix.com>
Subject: Re: [PATCH net-next] vhost/net: align variable names with XDP
 terminology
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jon Kohler wrote:
> Refactor variable names in vhost_net_build_xdp to align with XDP
> terminology, enhancing code clarity and consistency. Additionally,
> reorder variables to follow a reverse Christmas tree structure,
> improving code organization and readability.
> 
> This change introduces no functional modifications.
> 
> Signed-off-by: Jon Kohler <jon@nutanix.com>

We generally don't do pure refactoring patches.

They add churn to code history for little gain (and some
overhead and risk).


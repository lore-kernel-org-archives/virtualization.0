Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DDD1B4231
	for <virtualization@lists.linux.dev>; Thu, 26 Jun 2025 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750952268; cv=none; b=lGeY6UJAphZY7cGUdSDTxTtL95OC4QpAnLRa5xWdrrPgoPC8TwldFjlvMVfJ3K0MECTLU/YtaCpLRHrGXfmNei21NEWk4ICUmgUIXpt3hoz+2uqAYPw5/0mDKm1hXTRjJrNQqLQCcblN2Yc8ktJa7E3bTsMMS0lL+iYmuYlJfUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750952268; c=relaxed/simple;
	bh=1kTchX7hydmdDHaIeR4b7vCB4DidJo22IPgQr6l+BIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkys7LPlGDpx/Kj7YQnebrw+0wEu/f2b+frm4MtXL+0+P6Rt+OvdTYDKU27XBs1Y5CS/OSD3LJg52atnaHJH4dKU8umbV20Tlrw+OUOeJlgUtdlrJkyjVuHZUKH0DlH0ai5RtvcGIeaYE2i684dakld6om6EL9VVadulilV/jsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1AfhhQ6; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1AfhhQ6"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23508d30142so17937275ad.0
        for <virtualization@lists.linux.dev>; Thu, 26 Jun 2025 08:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750952266; x=1751557066; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WBS6+tGrLYEgP8XOrgQa7cC9L5XmsRCAXvGJg8Wcsyc=;
        b=c1AfhhQ6rbMvgRo1xCyNrqatYHfl/9gSrMRs6zhjhaJJoi8HYvUzHE7YZlcC1R7Izc
         jF5eS5txU/hcgzPZtzwmDxUa3xEzkkGPfr8E4JoK0381+Vif35DG+jUpgmKTnSiXCZJX
         jMZtV2S5F79Cmn+SNheF0XSQgow3WG9rTMlq+sCJ+YGYE2ww7IpEpkZA9QrH4L4joUJw
         te7N7PEuYVkjN3MXmFrHUaRhFk/OMFFuBX64Ly6LsezB1zkLJDjXc4p9M1edCJ7LSB5B
         Y7qdk9r+DR5J48bV/Ixfd2yHeeed0ejz3D92YBOD+QU1VT/FXbQWCzxeA4muDpvwRXOu
         MVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750952266; x=1751557066;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WBS6+tGrLYEgP8XOrgQa7cC9L5XmsRCAXvGJg8Wcsyc=;
        b=YoOOE1V7T9qp6hHKYBg9sBApIUAM2wAm3y0NaqYi16Ap/Oh6SxB7mifzYDqgOSvVSB
         h1buRRgVB4TBO8dZqBqekmxEDd1h+6+7ww/pKB6tQlxmzXdjWLO6a1914iiZhduxjZ6r
         8VF9LfD7DE25ukYY2ork2tMiGIqWw68XOiB3CXmsNsvi0JALTpP7IRaE/Nxh4Z/U888t
         Aw/lyhGNb2Vg3SVAgAHwLHnZAO2hF9Ydqrpq8KW/x2lMiAttmyEKa4g5/xi02WUE266J
         AslySjPDmRVKeVm/Vjb+MBghwExbrCBda+dhYARaPGM63OkS7ipOgVtAgyR2n+m1UBm0
         vDgw==
X-Forwarded-Encrypted: i=1; AJvYcCWX1HEr22ajt65DFXvEXqLRXeoUMiSxiTsk90rte57xEKzDwg1bcQjE3fwabI26jo3kOMcIy+VIZyNKOsL/2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWICkxOkPc14h3chmF18xCFrxarwpVvFZfPwCAWQ/wqeYdTBOU
	+H/x42u77lg2eDkAtKIP0L/Nvy9oZTPZdeDj7/+5SAXhF16/YLVg2Uiz
X-Gm-Gg: ASbGnctLRqSZZxuCVgq/Ik9FMw9OYUvgkJ1eUohdFyldkp8Ff97JpYncuCG88WzpKn1
	msR9FiOx9GeE4BP3Riio0L32MHCaHlO2kNto3RRyhnzsYjWLdZMB3EE/L7QfNbbL1Vm3aiMCbTX
	wgri58AzVoSdwGDRXGhmLohzKPMcHyvFSu3z7yTutA2KFYLpYCiB2z6jwCPlbQzWuRPHrifII98
	LhIYznzZCIBQUWMX4LGjBQiMWCmHW5CxonO/DWAT8MtetiCbzTPU8GalRt7GgYGZt/BvTDEFlmI
	qGjLFwUxx9I5KbylmM9pMIhkKAzBdmbQGrg/xVE4eMBXZiiavtqDjcrdJO1TFnrWlb8OOWB08gv
	DhKdClEHslu3PMTMblMy1IqRQ244uvQdI6rtgnXk=
X-Google-Smtp-Source: AGHT+IE9HZQVIg9J0bGTauaoFxunVzdT6LAv+3ddjqizR0AY608ymj/oowE40lSal+PsH63zgCKDHQ==
X-Received: by 2002:a17:903:2a87:b0:235:711:f810 with SMTP id d9443c01a7336-23823fe4dd9mr121698455ad.23.1750952266162;
        Thu, 26 Jun 2025 08:37:46 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:2b9f:aa14:497d:25f1? ([2001:ee0:4f0e:fb30:2b9f:aa14:497d:25f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23abe329d23sm1164745ad.54.2025.06.26.08.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 08:37:45 -0700 (PDT)
Message-ID: <8f0927bf-dc2f-4a20-887a-6d8529623dd7@gmail.com>
Date: Thu, 26 Jun 2025 22:37:38 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/4] virtio-net: create a helper to check received
 mergeable buffer's length
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250625160849.61344-1-minhquangbui99@gmail.com>
 <20250625160849.61344-4-minhquangbui99@gmail.com>
 <CACGkMEvY9pvvfq3Ok=55O1t3+689RCfqQJqaWjLcduHJ79CDWA@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEvY9pvvfq3Ok=55O1t3+689RCfqQJqaWjLcduHJ79CDWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/26/25 09:38, Jason Wang wrote:
> On Thu, Jun 26, 2025 at 12:10 AM Bui Quang Minh
> <minhquangbui99@gmail.com> wrote:
>> Currently, we have repeated code to check the received mergeable buffer's
>> length with allocated size. This commit creates a helper to do that and
>> converts current code to use it.
>>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> I think it would be better to introduce this as patch 1, so a
> mergeable XDP path can use that directly.
>
> This will have a smaller changeset.

I'm just concerned that it might make backporting the fix harder because 
the fix depends on this refactor and this refactor touches some function 
that may create conflict.

Thanks,
Quang Minh.


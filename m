Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BB218A6AB
	for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745309792; cv=none; b=CsOCtmEeslSvorIQl2ge2Lo0O/3KWTDyg/ainX8KRtY7envhMqzQr3wWiYgnKJKRFHzMX6pvrRIgz0Qy8YI6QuCJidbeWKqKOfsz7VA4ByvGYfFms4g4SpS/T6qvZsBw/3hB2Vq5uR+cyxjtNQnno1lh2PNiiRuOU9iAPKxMEj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745309792; c=relaxed/simple;
	bh=IxR9R4dznHC7A3UhAAi8NByT8Ge6lacYIRr4lsdjXE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWMzOz7hEA5laGuiV4IF7y48uC/o9n+5VuONFx/tbw0mvDpk4ZcM96Yfi2K0lzogGFanMRnrBqmU1iKTx1xCf3lDsnjr5N7z9/u9pWaIr2sw539fItMYWr2dDf4p1hWEWJ7cHzJKMAsrWqOY5QLJMTN8CaLPkscWXmLkj5py/wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9NF9tkP; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9NF9tkP"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac339f53df9so828304366b.1
        for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 01:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745309789; x=1745914589; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cOlwuce44vKtv1OuDBF9isVVZKdS5EgivWfm0t2JhLQ=;
        b=M9NF9tkPyXpoxB+jcOyYl4rjVrHVNCWXMqpLGzsJPu38qtFnOtrSeh/CxRFrGiDs/i
         lZmEP/f2rbZVQLEgDYr+HqBG7+9dlV/AJGrFlYn6AdbViAilCtng868JjiUZCQetk0a8
         0QNrqp46z8V7KWIOeZQuiNTEdb6fFZ/tVO9kaxZmDV4McQBGHPJh8t4w+AxlbtF5FPNf
         dAOuEHAMv2i3p0NZHSrUZE/4MUa9kxd7My59qWtmLkxeKzjLhtsRq6z0jGzPecUTmCHX
         vH3tSzFinc69hD2eBV28tDVfFwT7zxxG8lTysvSn822kOtE2yuG+DFMhA/nfDuoyobLK
         FXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745309789; x=1745914589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOlwuce44vKtv1OuDBF9isVVZKdS5EgivWfm0t2JhLQ=;
        b=vtGnhksrvQp7fcuivmxcnYY9xCE4JUqdgrKMpEHL7LgBW4KdkQ5u7JXXEKipjn4WQy
         xkZ1kSP/ZVFX0Jzkfq3wm3vMOi9Y3CWah/ss9LNnWe+afZbrXKQoUvL5LUKxJOweYwxL
         zy7YpCS4xtLJh12vmHCLhuT7uJZxNB7anPeyNjbaUCrXx+GF9WfWh3jEWn6UxRcTj/fI
         +rG+lx447PsDfj2P69Py+UtfIcPso5WhsUI0hphIPC68TmLhTCL0mQqKrc7+dTphYQoh
         cHTAiGXjWesnq2dUDuwAi+R9nVGdFbm+VpCSFkwUCNLsqD4Ls28+mraig2YpNO+SuJyx
         BnpA==
X-Forwarded-Encrypted: i=1; AJvYcCU977CpCAT8KZ9bE0Xo/qsmWFQsXDeUgOPco2mnBdL4G8DVPlB/YJ1SLuvLSrMFsjgW4g4OTxWqppunRUPA7w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFCpQld1QgsEDCESXqI0g2RfHx/QjEEcbsfdWbvc3j8WIOgNkQ
	1Rcpbyvgq5xE58KfMK02Wv9TFopzryg0HTXyvbiWsgyC2CkOx+mo
X-Gm-Gg: ASbGncveZKEis9R4wZGvmtofWvsHxcWUtDZqtdoEsqV4ulce/hvAbV+2xceXudDs6/i
	n0D106Q2Y7A4gpIwfgRHmDEt2VzZu/3ea4MS1uv7cA//XP+pfugsmZz+7bpI57pIt14szbF5L/i
	Lv1wGUizKXU6Kx2Bcgz7blWSc7b7n8/CQkyGnPMbib8TXDaNxu5m0sNCchlRzo/jx6a1RW97BmH
	TrW8EIS3K0ZIsy4Ks3vf1nh95elhrv9bNQcMhVlaEO2YPsIDbJ9XuCz43RypwiCp1BNXwUHINik
	vKwOJjBSVeT0Bb6uALdnBxOOzy1j45mxZPzZTXMVibR0k9MT06/zcg==
X-Google-Smtp-Source: AGHT+IEoDhdUk4JqptbNDk1DSYTZqleRkQiE6D7lLk3MmjHoZyxA8pbW4BbGT1g4lHeJT+lVTudacg==
X-Received: by 2002:a17:907:7f88:b0:acb:5f9a:72f4 with SMTP id a640c23a62f3a-acb74b8368dmr1158109666b.30.1745309788661;
        Tue, 22 Apr 2025 01:16:28 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::158? ([2620:10d:c092:600::1:558d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb8cca2323sm471150066b.181.2025.04.22.01.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 01:16:27 -0700 (PDT)
Message-ID: <f7a96367-1bb0-4ed2-8fbf-af7558fccc20@gmail.com>
Date: Tue, 22 Apr 2025 09:17:43 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 1/9] netmem: add niov->type attribute to
 distinguish different net_iov types
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 io-uring@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn
 <willemb@google.com>, Jens Axboe <axboe@kernel.dk>,
 David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
References: <20250417231540.2780723-1-almasrymina@google.com>
 <20250417231540.2780723-2-almasrymina@google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250417231540.2780723-2-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/25 00:15, Mina Almasry wrote:
> Later patches in the series adds TX net_iovs where there is no pp
> associated, so we can't rely on niov->pp->mp_ops to tell what is the
> type of the net_iov.

That's fine, but that needs a NULL pp check in io_uring as well,
specifically in io_zcrx_recv_frag().

You can also move it to struct net_iov_area and check niov->owner->type
instead. It's a safer choice than aliasing with struct page, there is
no cost as you're loading ->owner anyway (e.g. for
net_iov_virtual_addr()), and it's better in terms of normalisation /
not unnecessary duplicating it, assuming we'll never have niovs of
different types bound to the same struct net_iov_area.

-- 
Pavel Begunkov


Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC4528541C
	for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745345989; cv=none; b=BWnrhLSwaNg5u/Zkdc4FIpNBQ2hTjUI0UbeeKjtqtCbZH5VyfuaxUSuFeEdOk2zSNrLZjfCNNnaxsEmH6vg3sAJp/MsWB3MOj0+SWtVN7elEMZBffLa/yEIMgUsVFbyUtu54PAnYzrenjht4zFWd/SfaelNTPWzw8ygse47YbJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745345989; c=relaxed/simple;
	bh=8wYCXgZqpbTDarUW031W7MRIpH1sLDyCBxxD/Ri5fVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvjIBfT0r70IrK53zYIB3mj1zPNkZ+xQI2flM3Pqqu5c6G8o+teNkogr18wsueL37pDTsRnbLW7IPl7ad7ium3LSk5OqPRfA62txIcTyO1rcexfGRBTNQuQrIGGK4nbeP/ucMeQz1z6wZ25m/rOzdEHmdOnZqKhSRDjo2fHukxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuCA3zjK; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuCA3zjK"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c31e4c3e5so3829710f8f.0
        for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 11:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745345986; x=1745950786; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V4wU0CuSU6YOeYRo+NJ/4ERb7AGDM75DMO3ccWS5aBc=;
        b=RuCA3zjKZBrxf3oT23QfSeblNFKluks6gC5H7+H2FiHgKylCuLs+QACSuieG3UevDI
         /75pWbqSdiRxRTeuu5OQZ3zaAWY6E4zW4loOo9kif0LkSG7tZnMZD9b8QWYUjaySyzrh
         qAMP7W0mlkb5nsEyDN6zIlFtmIJoeHZaDXqQnl+6zbMLK7rmpZmkTGRCyinTjCp3T9Zs
         +Ow+mNbrmnmbrvg1hfESIhsxlRY1bjoWwAoQx9vWX74yqgyfvhu7iGLHSdtFKOBhGqAA
         fth22KsN6gL4ijxW7QFuzq6oFg+IcRgwVWZ9u5PKu1UEhtKTQyJTwWpzNuh+wqqCoVHo
         /j4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745345986; x=1745950786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V4wU0CuSU6YOeYRo+NJ/4ERb7AGDM75DMO3ccWS5aBc=;
        b=XSJiFPyilWK6u61wsWYfJ+DSf//6wAo2YZXURzsAak1KIFx4ct40+T0kOKKWZ+k1G5
         wERiXyeuv7UEk+cXut9NmPJnhDD5siObqd571wtzIyWnpXWNd747w6N0Vlyte0H/ggh9
         M+KO9pPegMzJ4iCTQ6046U7pD3/hHHck9YXSsA8YCsKE7fH3UBw3ge1YTBl59kJ9eOsv
         8I9Uah8wv2rSIiFFSqOmYH+F7stf1xuWT5pwYeP97OUadXhVRoJ6iABgkvMxBy20vnlk
         zopEGJBAaDhSwxJTrA8lV4pNwia0YRhfQpKvxkwTR8mrDPe/UTa6Tp0+W/FWIXx6r82V
         i73w==
X-Forwarded-Encrypted: i=1; AJvYcCU3U+ouWoo5E7CB3cO3b3pUANd7dmivp2E7aUDSbS5aYdHqS0tIHWznL3hw5X+2lSgoPMd+3wc7VkoCBReQUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywkyd3FxfVowIyvgbrU7O4DCg28f543G6O86mTcBwi8wxb817Op
	3XNuQ7lsyVvOWnfxpliFcOZwqSg7pgxeVb5pojzV63vCvyPn4tOA
X-Gm-Gg: ASbGncvzUH3RCUsYpt3id2L6MQDK2BwHVQp20BdU0V2EZ+niicxLG0xQP8hbiAyvzjf
	/my6OcG8cNePo/2R8JZVFvPeEvO/J9wVkNxn/NNiZqtZx/m9Nz6Abc2b1mtIpRpVQIMg0RQpUq/
	oxbg+JIGMCAPFG2kq3DPBW1rfxCffhbvzetqcXB4oXHcaLpzO5f1IsbfL55rgtxOPMjG606XqaL
	Yjmgah6M4EkSr8v6Nu3YxAASPRVCkkgYQ9QgrQiXbR3+nxsh435VC7C+krtbnOQdSmtihQpmdFv
	yykkjk8GxSO+HiL9q0gILx7e32h/U9CODdCDgEMpSoCTExW4
X-Google-Smtp-Source: AGHT+IGsGcBMmgVltHKkfzj/5mF0Ny9f6RgMByhyMlB833FKD6rDdwvWOUJDBJsAjsbBce/iJtRETg==
X-Received: by 2002:a5d:584e:0:b0:39c:140c:25e with SMTP id ffacd0b85a97d-39efba560b1mr12910171f8f.24.1745345986104;
        Tue, 22 Apr 2025 11:19:46 -0700 (PDT)
Received: from [192.168.8.100] ([85.255.235.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa42082csm15911065f8f.3.2025.04.22.11.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 11:19:45 -0700 (PDT)
Message-ID: <957b74ed-f29c-4bb8-b819-af4e1168d6c1@gmail.com>
Date: Tue, 22 Apr 2025 19:20:59 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/9] net: add get_netmem/put_netmem support
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, io-uring@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
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
 <20250417231540.2780723-3-almasrymina@google.com>
 <484ecaad-56de-4c0d-b7fa-a3337557b0bf@gmail.com>
 <CAHS8izPw9maOMqLALTLc22eOKnutyLK9azOs4FzO1pfaY8xE6g@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izPw9maOMqLALTLc22eOKnutyLK9azOs4FzO1pfaY8xE6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/22/25 14:56, Mina Almasry wrote:
> On Tue, Apr 22, 2025 at 1:43 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 4/18/25 00:15, Mina Almasry wrote:
>>> Currently net_iovs support only pp ref counts, and do not support a
>>> page ref equivalent.
>>
>> Makes me wonder why it's needed. In theory, nobody should ever be
>> taking page references without going through struct ubuf_info
>> handling first, all in kernel users of these pages should always
>> be paired with ubuf_info, as it's user memory, it's not stable,
>> and without ubuf_info the user is allowed to overwrite it.
>>
> 
> The concern about the stability of the from-userspace data is already
> called out in the MSG_ZEROCOPY documentation that we're piggybacking
> devmem TX onto:

Sure, I didn't object that. There is no problem as long as the
ubuf_info semantics is followed, which by extension mean that
any ref manipulation should already be gated on ubuf_info, and
there should be no need in changing generic paths.

-- 
Pavel Begunkov


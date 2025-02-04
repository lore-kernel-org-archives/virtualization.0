Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D1F216601
	for <virtualization@lists.linux.dev>; Tue,  4 Feb 2025 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691790; cv=none; b=Y/Wpr7CzPCEy0zfsT0+FZqW/C4g4le0l5JY9CtiyeEbSqwzjHsnjT2lB4EIbf7SDe+85MdAwyW8pKDyAR13efjmNEvvlwo+IH1oc0h4Ts7t9k1GMQanI2fLkP8XJHfezvu+kpDgq/ozHgnkmpu1U9lv//Z0G2zlpR8tXmJHSDYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691790; c=relaxed/simple;
	bh=m670b6vZ0EmsoJkmownLJxz8JU2YptA7G45HSbgfDp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ljb62DsdY7Mh1/Qny3ui83PwUFh0JxzsNQxWo641kpq/HKIjsnuLlRTpeL4wUr8tsOZ/J2AXaPi/Zlbma3HMxxlHKHO8fA3atxoG1oHLQJ0qno+95wdHeho3n4OGERHAQqzX1LMr1W0GGZOYvmCgnFU/wn7v86ug1ChoIIqcQ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQi01E8U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQi01E8U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738691787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y7rTv22+08/qF0nM+ECThVkoy0LVlXk9luYfrRe54qs=;
	b=EQi01E8UDzMvKDkPClqCqFdC8Pg0czYOskEYuswbXMw0W8Eji7upIXJDZEOWMgjSqu+aJ1
	DLdA7VNvOcNo9whmW37w2/5vqtb7IVrYNArTMTAnMsnjob87HfEM8d9SAKNcDeBw4ErVAq
	jIVJV6BbKWxbxlEcs2UtwnXaly+p4HI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-VInPdTPJOmyH2Y3eRSa6Ug-1; Tue, 04 Feb 2025 12:56:26 -0500
X-MC-Unique: VInPdTPJOmyH2Y3eRSa6Ug-1
X-Mimecast-MFC-AGG-ID: VInPdTPJOmyH2Y3eRSa6Ug
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-436723db6c4so42212065e9.3
        for <virtualization@lists.linux.dev>; Tue, 04 Feb 2025 09:56:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738691785; x=1739296585;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7rTv22+08/qF0nM+ECThVkoy0LVlXk9luYfrRe54qs=;
        b=LotU6gXF3mOF8A6fvdxuZfRU8eDXDi8O4Esr487g9N0mGw5HmU50SVgNfSeIbusCun
         fC6JrkTAu7/oNqCHYNsNgI9035bLH3wQgVUT13XCq176UZccCYyt9V2AwnPyAxJuBEkQ
         wUMN7vTYRppZDdpsi4Dg1HxwWFDtroIk5fU4DzdE3L9EOl38CJsJUmBvE4oNa5oWGGuw
         K6i7p/MK4jp9ydcCa7i3bNLKkYR+KzcDskkkSFVMm9rCUkPLUv7o0ZpSYIY8nMNh3fKV
         o5MVSK3V1dX+kJ2CCmkqdN9Y2NS1+YkprAiZXy+JvULiSrbq2psIv0nVw+56wkEI4rJg
         i2Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXCsN7c1KkE/n4/GjtaHo0s6fS7eyG8NaYkBCk4bLLgsTBUbiuvC8q/qFNCNsZ4A8I3DX8w9EsT22p+28azKA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPYydulfe5V+S8d3+lglJqMtHmqFRRTDUq5kpbCOlsy3Oljzt8
	/bvFJJT2LTBErFmEeiNG4T1qSkCpJt4knYZzLFroB2eW3seNByXo8q3+CW0L8vFLsytfJXku8oV
	NwwYxswoWYjgobUOrU0mrfSAt7vLD4AuoAwI1tbf+NmCMtofY0eqB/1LwLVyafv8b
X-Gm-Gg: ASbGncuUYbmS8dykMexhVKfZRhVQ1iIhXPu7cZ2l3CrDgV2qMzn5CUYFSdZHjV/+ssH
	F0QfY+DVC7sJ2V+KUN3CQbE/+TcvlNx2Sjgo5A6TKpqOcNiluZXvO7RuxC7XJ97Xsfp/yFDigkw
	bIejoHgVagnDer1onUZXn6GB3RFJKYrwkBMZfjuz4Pd403b7Wcb7QQe1kwBok+BQobnU1bAIiY+
	wQwSAHdw2c/eDIXeu9RqLyDuhXJt0o88SnfX3McraFnA1WPt7SH6PirwJV4qFEwC6TSid3GVWAh
	k9xldCtE/J1t7r0r6NdFKtiX3ojOA/yjCUU=
X-Received: by 2002:a7b:c347:0:b0:436:6460:e680 with SMTP id 5b1f17b1804b1-438dc3cc9e6mr253180965e9.16.1738691785268;
        Tue, 04 Feb 2025 09:56:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCE1OD75AvFxX4Ocn0Vn8riU+bmAUBASRVK771tFjkbz9SV1IT6+srLah/Dv8CbvHWMOv8og==
X-Received: by 2002:a7b:c347:0:b0:436:6460:e680 with SMTP id 5b1f17b1804b1-438dc3cc9e6mr253180785e9.16.1738691784822;
        Tue, 04 Feb 2025 09:56:24 -0800 (PST)
Received: from [192.168.88.253] (146-241-41-201.dyn.eolo.it. [146.241.41.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e245efbcsm193857215e9.33.2025.02.04.09.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 09:56:24 -0800 (PST)
Message-ID: <71336d4e-6a75-4166-9834-7de310df357e@redhat.com>
Date: Tue, 4 Feb 2025 18:56:21 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/6] selftests: ncdevmem: Implement devmem TCP
 TX
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Neal Cardwell <ncardwell@google.com>,
 David Ahern <dsahern@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk,
 Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>,
 Pedro Tammela <pctammela@mojatatu.com>,
 Samiullah Khawaja <skhawaja@google.com>
References: <20250203223916.1064540-1-almasrymina@google.com>
 <20250203223916.1064540-3-almasrymina@google.com>
 <c8dd0458-b0a9-4342-a022-487e73542381@redhat.com>
 <CAHS8izOnrWdPPhVaCFT4f3Vz=YkHyJ5KgnAbuxfR5u-ffkbUxA@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAHS8izOnrWdPPhVaCFT4f3Vz=YkHyJ5KgnAbuxfR5u-ffkbUxA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O4dH0Sn6vhMLgwwKcDhFXMzkfLle4iYdSURZPvkHTXo_1738691785
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/4/25 6:35 PM, Mina Almasry wrote:
> On Tue, Feb 4, 2025 at 4:29 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>>  .../selftests/drivers/net/hw/ncdevmem.c       | 300 +++++++++++++++++-
>>>  1 file changed, 289 insertions(+), 11 deletions(-)
>>
>> Why devmem.py is not touched? AFAICS the test currently run ncdevmem
>> only in server (rx) mode, so the tx path is not actually exercised ?!?
>>
> 
> Yeah, to be honest I have a collection of local bash scripts that
> invoke ncdevmem in different ways for my testing, and I have docs on
> top of ncdevmem.c of how to test; I don't use devmem.py. I was going
> to look at adding test cases to devmem.py as a follow up, if it's OK
> with you, and Stan offered as well on an earlier revision. If not no
> problem, I can address in this series. The only issue is that I have
> some legwork to enable devmem.py on my test setup/distro, but the meat
> of the tests is already included and passing in this series (when
> invoked manually).

I think it would be better if you could include at least a very basic
test-case for the TX path. More accurate coverage could be a follow-up.

Thanks,

Paolo


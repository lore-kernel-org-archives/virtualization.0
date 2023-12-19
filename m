Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA1418653
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="B046QO+U"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6BD260BAB
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 12:16:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C6BD260BAB
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=B046QO+U
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0mFGhR_idKIS
	for <virtualization@lists.linux-foundation.org>;
	Tue, 19 Dec 2023 12:16:40 +0000 (UTC)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3030E605EA
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 12:16:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3030E605EA
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-28b4d7bf8bdso1193982a91.3
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 04:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702988199; x=1703592999; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pdERbfWd8axs3o2A8KOivOOsBTH7eU7jDtQCQU5TR64=;
        b=B046QO+Uyfz41F+cn9Fpm+5j0seZXoavVUBXW/beMvCjeRccgJojRfF1iwOz0Y5He5
         lUN2qbZaTi2/FFU6UpWb02FcqmCfm1VGWrb+1D3Io4H+28qn4EbU3FzpyloWc+gNqlwc
         UJ+vhb42eepKaW6zuvrYiXmT6YEQkE/r+F3jsCczfyQkqZxYYCxRHWaeVzpfVyeaVGA7
         3TznEdcGrrpl7ubLAzOoMoU1g2tYP7amsADEqvXOPNgu31gXZZQUIohR87NZoZUwHIfM
         Yi/0IGKrxMsrOA7qg8D5TPUAwDVVvs9BTebE0J6kQBAOIap0xgCUU5ahpp7RmIcZU1vN
         MRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702988199; x=1703592999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pdERbfWd8axs3o2A8KOivOOsBTH7eU7jDtQCQU5TR64=;
        b=Ns1G/gwmNws3xQg7p0i81B7A4FY+8Q8ACLC9Q9Av87Rf7yN/cUOEL15N5ouBLiGx+P
         7qGCJO1FeRdO/4JtzBqG5rpSY2erdMLfsxkSwQCawVpUTBk9iCBJau0qYB4vPmogTAFf
         2+pDddmAGiN1F41XbMD20jc/vX7p+7SMY+u2bmq5m4txkOeM0K3MCz1Nb6nRuTNZB2Po
         mZbX0rZj9c6ah4S/MkKNxksHBqDlzB86XAyBfYek6+cZtQ8EyZqZUue21+UL1iF16DtE
         2sEYElhEP9h+0DPR9F075B1JDHYG6l389c0ik8FAiGhufPI9FPtOjq6kno7CSqC+K17c
         An9w==
X-Gm-Message-State: AOJu0YwyffD+HsofTE/xj1/Q/ne5IeIMLXnwJnkvMD3TCRcGlHBmWtGo
	f/ODbs3CfHst5n1A4mXPHVodmQ==
X-Google-Smtp-Source: AGHT+IFYjl+Fut6DF10AvB+rC8c9j309BtUc82beTcI2OpnuUGu9er2HNCKWhRNTJ7qi3gFQPi0b+g==
X-Received: by 2002:a17:90a:303:b0:28a:f0bc:2a9f with SMTP id 3-20020a17090a030300b0028af0bc2a9fmr2996731pje.21.1702988199587;
        Tue, 19 Dec 2023 04:16:39 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
        by smtp.gmail.com with ESMTPSA id g15-20020a17090a4b0f00b0028bb87b2378sm1385953pjh.49.2023.12.19.04.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 04:16:39 -0800 (PST)
Message-ID: <87ae3eae-84b4-40eb-a637-b65161bdc1ed@daynix.com>
Date: Tue, 19 Dec 2023 21:16:32 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should I add BPF kfuncs for userspace apps? And how?
Content-Language: en-US
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Yuri Benditovich
 <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>,
 Benjamin Tissoires <bentiss@kernel.org>, bpf <bpf@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, kvm@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
References: <2f33be45-fe11-4b69-8e89-4d2824a0bf01@daynix.com>
 <CAPhsuW6=-FK+ysh_Q1H7ana=A6v9d0Rsn+2hpJpm5n2dB_A1Qg@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAPhsuW6=-FK+ysh_Q1H7ana=A6v9d0Rsn+2hpJpm5n2dB_A1Qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/12/19 4:56, Song Liu wrote:
> Hi Akihiko,
> 
> On Tue, Dec 12, 2023 at 12:05 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
> [...]
>> ---
>>
>> I'm working on a new feature that aids virtio-net implementations using
>> tuntap virtual network device. You can see [1] for details, but
>> basically it's to extend BPF_PROG_TYPE_SOCKET_FILTER to report four more
>> bytes.
> 
> AFAICT, [1] adds a new program type, which is really hard to ship. However,
> you mentioned it is basically "extend BPF_PROG_TYPE_SOCKET_FILTER to
> report four more bytes", which confuses me.
> 
> Can we achieve the same goal by extending BPF_PROG_TYPE_SOCKET_FILTER
> (without adding a new program type)? Does this require extending
> __sk_buff, which
> is also not an option any more?

It is certainly possible to achieve the same result by extending 
BPF_PROG_TYPE_SOCKET_FILTER.

It is not required to extend __sk_buff; we can repurpose the cb member. 
But I think such an API will be error-prone than new members dedicated 
for this particular purpose.

Regards,
Akihiko Odaki

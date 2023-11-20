Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B486BE549
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Nov 2023 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="cKgT9aYY"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 368CE60AE9
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Nov 2023 08:05:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 368CE60AE9
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=cKgT9aYY
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SR93qd9WpAsv
	for <virtualization@lists.linux-foundation.org>;
	Mon, 20 Nov 2023 08:05:48 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 09B24607FF
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Nov 2023 08:05:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 09B24607FF
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6c115026985so4251681b3a.1
        for <virtualization@lists.linux-foundation.org>; Mon, 20 Nov 2023 00:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700467547; x=1701072347; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n4NoqTxZnppS8i0nP/xGCXWB/hxXsx67zIl1hkFjXDo=;
        b=cKgT9aYYLzM1+MSrVDTso8/zKoc025bzcDtVfDGXGrng5s5nLWROReMcpQtQkEwOxB
         9n97gID8YF8vQhu5yylNw7t3+TO2DI//5OHIq5exRrHzYTrYfeLz2oCf7Ufr9wBBofr1
         2MNOsM22+Q/CzA0Lg1a3iitBiGPRdgzPRIAqo21C+VNwdCR4r+h/zw9S6szPqRj8uZKP
         4I9Z3HtihuYRDFN2GcPad2rFnicDDtnm+YXKT38cUo0hjaRABSGxnYc7C2j+iY/w2yJG
         M3utAAo4gw/kbCeZ9S0bSPHIDmf5e9ygvlOyA18tXYeyBLjXsNaIAIrdJytH2PTGtGOi
         +LKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700467547; x=1701072347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4NoqTxZnppS8i0nP/xGCXWB/hxXsx67zIl1hkFjXDo=;
        b=WFq1xJYValoQfFjwQiAicjAqtIKf/ziaiNrhOm2X3NSITD3abhFh7MBWsh/UwUqqWX
         +DMRIwEBwyn2PKklf67db2jvhM2/zeDXi3f6PK3J3jX3cTasU/AV1vDGdchZeLjQWqYL
         9v+jxup/Ow5GCBzDJ8sUiWW81Di5QiKGRJbodFO6gb8/hot8B9XV34RA1x46pDee8Mci
         d295lCT75ZzI4bWiDe0irezgYIUoUHjh2M4qmAULegE2HiaJ8yl/OjlaYslP+zZqXwPT
         S9EJzoxVRcmWm5TzM1pFXq8yrafF/EgZ0IdTaVRE8HjrCCPVcqJhL4w/JJoZhYXPbABr
         7CvQ==
X-Gm-Message-State: AOJu0YyhbChNx4ogVsdFb/nM0ckokS6mNQDVltMU2XAJ+6Oi+yVTykJu
	RngWRtQRchhTRfqHHUJ4UmepEg==
X-Google-Smtp-Source: AGHT+IGssdhQXa2d+roUN7IT+TTU6LwlrMuPiMYOCQM48dnmpaA4XEU9k505dahywkNiyYYGiT6THg==
X-Received: by 2002:a05:6a00:80a:b0:6cb:910a:c6fe with SMTP id m10-20020a056a00080a00b006cb910ac6femr3670261pfk.7.1700467547194;
        Mon, 20 Nov 2023 00:05:47 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
        by smtp.gmail.com with ESMTPSA id f32-20020a056a000b2000b006c5da63556dsm5673415pfu.178.2023.11.20.00.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 00:05:46 -0800 (PST)
Message-ID: <a1f09866-a443-4f74-8025-6cdb32eb1d2c@daynix.com>
Date: Mon, 20 Nov 2023 17:05:40 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/7] bpf: Introduce BPF_PROG_TYPE_VNET_HASH
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
 Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>
References: <20231015141644.260646-1-akihiko.odaki@daynix.com>
 <20231015141644.260646-2-akihiko.odaki@daynix.com>
 <CAADnVQLfUDmgYng8Cw1hiZOMfWNWLjbn7ZGc4yOEz-XmeFEz5Q@mail.gmail.com>
 <2594bb24-74dc-4785-b46d-e1bffcc3e7ed@daynix.com>
 <CAADnVQ+J+bOtvEfdvgUse_Rr07rM5KOZ5DtAmHDgRmi70W68+g@mail.gmail.com>
 <CACGkMEs22078F7rSLEz6eQabkZZ=kujSONUNMThZz5Gp=YiidQ@mail.gmail.com>
 <CAADnVQLt8NWvP8qGWMPx=12PwWWE69P7aS2dbm=khAJkCnJEoQ@mail.gmail.com>
 <9a4853ad-5ef4-4b15-a49e-9edb5ae4468e@daynix.com>
 <6253fb6b-9a53-484a-9be5-8facd46c051e@daynix.com>
 <CAPhsuW5JYoM-Mkehdy=FQsG1nvjbYGzwRZx8BkpG1P7cHdD=eQ@mail.gmail.com>
 <dba89d4b-84aa-4c9f-b016-56fd3ade04b2@daynix.com>
 <CAPhsuW5KLgt_gsih7zi+T99iYVbt7hk7=OCwYzin-H3=OhF54Q@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAPhsuW5KLgt_gsih7zi+T99iYVbt7hk7=OCwYzin-H3=OhF54Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/11/20 6:02, Song Liu wrote:
> On Sun, Nov 19, 2023 at 12:03 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
> [...]
>>
>> Unfortunately no. The communication with the userspace can be done with
>> two different means:
>> - usual socket read/write
>> - vhost for direct interaction with a KVM guest
>>
>> The BPF map may be a valid option for socket read/write, but it is not
>> for vhost. In-kernel vhost may fetch hash from the BPF map, but I guess
>> it's not a standard way to have an interaction between the kernel code
>> and a BPF program.
> 
> I am very new to areas like vhost and KVM. So I don't really follow.
> Does this mean we have the guest kernel reading data from host eBPF
> programs (loaded by Qemu)?

Yes, the guest will read hashes calculated by the host, and the 
interface is strictly defined with the virtio-net specification.

> 
>>>
>>>>
>>>> Unfortunately, however, it is not acceptable for the BPF subsystem
>>>> because the "stable" BPF is completely fixed these days. The
>>>> "unstable/kfunc" BPF is an alternative, but the eBPF program will be
>>>> shipped with a portable userspace program (QEMU)[1] so the lack of
>>>> interface stability is not tolerable.
>>>
>>> bpf kfuncs are as stable as exported symbols. Is exported symbols
>>> like stability enough for the use case? (I would assume yes.)
>>>
>>>>
>>>> Another option is to hardcode the algorithm that was conventionally
>>>> implemented with eBPF steering program in the kernel[2]. It is possible
>>>> because the algorithm strictly follows the virtio-net specification[3].
>>>> However, there are proposals to add different algorithms to the
>>>> specification[4], and hardcoding the algorithm to the kernel will
>>>> require to add more UAPIs and code each time such a specification change
>>>> happens, which is not good for tuntap.
>>>
>>> The requirement looks similar to hid-bpf. Could you explain why that
>>> model is not enough? HID also requires some stability AFAICT.
>>
>> I have little knowledge with hid-bpf, but I assume it is more like a
>> "safe" kernel module; in my understanding, it affects the system state
>> and is intended to be loaded with some kind of a system daemon. It is
>> fine to have the same lifecycle with the kernel for such a BPF program;
>> whenever the kernel is updated, the distributor can recompile the BPF
>> program with the new kernel headers and ship it along with the kernel
>> just as like a kernel module.
>>
>> In contrast, our intended use case is more like a normal application.
>> So, for example, a user may download a container and run QEMU (including
>> the BPF program) installed in the container. As such, it is nice if the
>> ABI is stable across kernel releases, but it is not guaranteed for
>> kfuncs. Such a use case is already covered with the eBPF steering
>> program so I want to maintain it if possible.
> 
> TBH, I don't think stability should be a concern for kfuncs used by QEMU.
> Many core BPF APIs are now implemented as kfuncs: bpf_dynptr_*,
> bpf_rcu_*, etc. As long as there are valid use cases,these kfuncs will
> be supported.

Documentation/bpf/kfuncs.rst still says:
 > kfuncs provide a kernel <-> kernel API, and thus are not bound by any
 > of the strict stability restrictions associated with kernel <-> user
 > UAPIs.

Is it possible to change the statement like as follows:
"Most kfuncs provide a kernel <-> kernel API, and thus are not bound by 
any of the strict stability restrictions associated with kernel <-> user
UAPIs. kfuncs that have same stability restrictions associated with 
UAPIs are exceptional, and must be carefully reviewed by subsystem (and 
BPF?) maintainers as any other UAPIs are."

Regards,
Akihiko Odaki

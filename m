Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39A914285
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Dec 2023 08:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="u3QvUgW/"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FEEB42183
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Dec 2023 08:15:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7FEEB42183
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=u3QvUgW/
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id szNe8nFfgXxs
	for <virtualization@lists.linux-foundation.org>;
	Sat, 16 Dec 2023 08:15:48 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E05CE420E5
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Dec 2023 08:15:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E05CE420E5
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6ceb93fb381so1067354b3a.0
        for <virtualization@lists.linux-foundation.org>; Sat, 16 Dec 2023 00:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702714547; x=1703319347; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j34U3DbBJyUmmhCTSIWekoWpOW5ZdWSwa2YWU4yaUK4=;
        b=u3QvUgW/VWS/CA6NMvQEvfh8ZraYFWz7uY5pvSNu3vAXDAUq7c+hJV7teex3a83pA4
         x1fih46dkn7MbJ7+JPBkg5xgkl8uUB8g3gPG1YrZLFDrFhSh/X3EEWFPwKLDrapFI4gL
         Pk+CFmCM11rQj4BDSNAr0sMkynaVa+tntLiPfHqSEbq2ERX3Is1WZD1YGGJi0/RreXGz
         VvLLwrpCyk+9/mib/5c8tNXzYnd1HqEFnni/xMJKaadMsOSYroyJ630zRBCg4zfD4Skl
         GW4Y8XbbKrbXF8S2+o4uEq24+yvGKiRFMSAEQBjfRLhlcCMVazgThxDeRidG1jGMt7dB
         hiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702714547; x=1703319347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j34U3DbBJyUmmhCTSIWekoWpOW5ZdWSwa2YWU4yaUK4=;
        b=UEYBAxM4A9AVhh5DlQpRjqnD3/c3Otaf97KaYoVs5g8IymrHCxwwXCMUIw875YCiVP
         YDAW7HfuBTfCvjdvyyJiTsnru5zzY3AJllY7lWBfR1KjVbfnrkl5GYwQ5DRD78ycEdKV
         6pVxsFbxeSBj+942VAxDy+F91SjZlymw/WkDRpqfNrACNS/Hbz6mV2wDQHS8+ssOP4ni
         fJsFnPoVjJyRaIRYp3wXGfNeAUFwZRapsuDNnFM22uvPT8KMRYB240YfeaEa2rnRs3Gj
         bdpjALhRBEeCuyJrUr0Jvwe1u34UIY3Ws1C4Q5lLloxLJInh1jP9Jfce6mSvosi5v9aj
         oPQQ==
X-Gm-Message-State: AOJu0Yw0LGmX/XO9QxZv1s+1QWU9Gjd2z63iZKuF5lwRuwZjgBBcmHUO
	Ay/7TbkLXdc15h7RxHPivb95Sw==
X-Google-Smtp-Source: AGHT+IEeuPfCOabIrvg0uS3E2YqqLjNkgjJjHCcIA2x49ExvIgKwxCgYmGKVjZEUpfIORWU2Bd9Yug==
X-Received: by 2002:a05:6a00:198b:b0:6ce:78c9:5979 with SMTP id d11-20020a056a00198b00b006ce78c95979mr17324911pfl.18.1702714547181;
        Sat, 16 Dec 2023 00:15:47 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
        by smtp.gmail.com with ESMTPSA id p18-20020a056a000b5200b006ce835b77d9sm14707733pfo.20.2023.12.16.00.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 00:15:46 -0800 (PST)
Message-ID: <11507101-ca4f-486d-9fb8-a5d4de0b1b85@daynix.com>
Date: Sat, 16 Dec 2023 17:15:39 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should I add BPF kfuncs for userspace apps? And how?
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
 <CAO-hwJJhzHtKrUEw0zrjgub3+eapgJG-zsG0HRB=PaPi6BxG+w@mail.gmail.com>
 <e256c6df-0a66-4f86-ae96-bff17920c2fb@daynix.com>
 <CAO-hwJKMrWYRNpuprDj9=k87V0yHtLPEJuQ94bpOF3O81=v0kA@mail.gmail.com>
 <0d68722c-9e29-407b-9ef0-331683c995d2@daynix.com>
 <20231214094042.75f704f6@hermes.local>
 <72b8e198-7058-469a-a1e0-17f48330deca@daynix.com>
 <20231215083644.4dd9a323@hermes.local>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231215083644.4dd9a323@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/12/16 1:36, Stephen Hemminger wrote:
> On Fri, 15 Dec 2023 14:49:56 +0900
> Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> 
>>>> It is exactly what BPF_PROG_TYPE_SOCKET_FILTER does, but it lacks a
>>>> mechanism to report hash values so I need to extend it or invent a new
>>>> method. Extending BPF_PROG_TYPE_SOCKET_FILTER is not a way forward since
>>>> CO-RE is superior to the context rewrite it relies on. But apparently
>>>> adopting kfuncs and CO-RE also means to lose the "we don't break user
>>>> space" contract although I have no intention to expose kernel internals
>>>> to the eBPF program.
>>>
>>> An example is how one part of DPDK recomputes RSS over TAP.
>>>
>>> https://git.dpdk.org/dpdk/tree/drivers/net/tap/bpf/tap_bpf_program.c
>>>
>>> This feature is likely to be removed, because it is not actively used
>>> and the changes in BPF program loading broke it on current kernel
>>> releases.  Which brings up the point that since the kernel does
>>> not have stable API/ABI for BPF program infrastructure, I would
>>> avoid it for projects that don't want to deal with that.
>>
>> It's unfortunate to hear that, but thanks for the information.
>> I'll consider more about the option not using BPF (plain ioctl and
>> in-kernel implementation).
> 
> With libbpf, things are much better. It is just that projects like
> DPDK have to support wide range of kernels including older versions of RHEL.

I have checked DPDK documentation. It says it supports the oldest LTS 
kernel:
https://doc.dpdk.org/guides/linux_gsg/sys_reqs.html#system-software

My use case is QEMU, which has much more relaxed compatibility 
requirement that refers to recent distribution versions instead of LTS 
kernels:
https://qemu.readthedocs.io/en/v8.1.0/about/build-platforms.html

That said, I'm not really concerned about the case running QEMU on older 
kernels. QEMU developers can just pay extra efforts to support those old 
kernels if necessary.

The more concerning scenario is that a newer kernel breaks compatibility 
with older QEMU versions; such a scenario has not been considered before 
AFAIK.

QEMU already uses libbpf to load a BPF_PROG_TYPE_SOCKET_FILTER program.

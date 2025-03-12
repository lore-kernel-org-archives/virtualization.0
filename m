Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6C91DF975
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Mar 2025 05:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741758945; cv=none; b=oWO1vKzfMsVVb4o4FGyTKbEbQ7eKStLmDpBfvZ+9c+HTOnRjnq+RpBo+scibysCfT9Z3sluOeOAOrtLizhGnm+qji+gHzbG+uUzVGs6M7zjCmrK8MUJUy5mtHteq/+ZUu1EyDf2+ksasn1mI7o4kOt9xOOJhMxjW5R6CVrhhrR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741758945; c=relaxed/simple;
	bh=alhU20ihOlc5cJCMuHBajEc7EUqehBtkqo5iRv29oVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/ErbSbBUGcb1RL+LytvP72LPmL8Z5DrCtQgL8bL1P/SNCZoUpKMtLlG2totMXuvK/eMmUk1ln6iVaxrgwo1IV22rOWndDi6Ag0CKUWG6U6CBGjTb2KZhJldb+OY2LvF7Up8+RP7K6BgvGocHuMMH9AbhHzO03AofxiyuZxugu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=gzmpj6z1; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="gzmpj6z1"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A65640908
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Mar 2025 05:55:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RYgxRK7av_H7 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Mar 2025 05:55:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5797A40DCE
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5797A40DCE
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=gzmpj6z1
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5797A40DCE
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Mar 2025 05:55:42 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-300fefb8e06so3344911a91.0
        for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 22:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741758941; x=1742363741; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oSOfwAcbQA4fo8Ww+ZUfjP/u2KZyMzcNTNHmT2zLzAs=;
        b=gzmpj6z1mNuoxJQA4WmTgGjP+t6GqBMeG5CXZ01Ba1DLKAqjtGfQ4TELJHEb0vmkSo
         TiyYmEaC8JAQ4F57mD53r5d+QiIaQBTrFkoglRoqY0NSTXQC+00kH7bdppWF5kXQ7pCt
         txT5bkGvcBnqwWRqPmVp+C6HtvpywQ9SvgdE+QhHe7+HDgxneA2uqPP6inE5OZT0enO0
         HMGSWy3e0KxOoZharWMB7DOKSnxBQ3Ge7K3pifDCGZL52+q7YUd83keerd170fcICGev
         0BXU0KiVj3PIp4EryVeV1LmsGb9sIZdio7eD013hHVY8+e/rQX71FpAVlGF98vhz3OyC
         mbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741758941; x=1742363741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oSOfwAcbQA4fo8Ww+ZUfjP/u2KZyMzcNTNHmT2zLzAs=;
        b=aWbYZwJNtZce/SM+fN3AvL+wsI9RRqUJcST7YYumV8trVAWYWlab9aOF1jKwAFxYo1
         w3TY958uwwNuN2Kd7pscZU4b9wHTnr/MAHRTHQwGEKVzUP9i6cObavRGLuo1QKhhw9Yj
         Soc5kI2wYM80by2e/tzFApVV79vPIEjCY2JXESVvdN1TcRbBpMOC6jfuzyONlNtnAy5b
         XKf0c4AwhDHt1zTHGRUeoI6/2Vs/QIKGEu7BzZ2GLL5/xukwSs5Wvb2ddn1AawtWrWfV
         p/bvJAztLc5qmI+hhyOSVjktkvgD8zexyKLXfuhT0Go0btERgw0z/Vpm/T6GZlPT1IxB
         MKNg==
X-Forwarded-Encrypted: i=1; AJvYcCXPQGBbMjAeuUclYXqnDKKgIxOvgtLGnSYDqg2w4o5SgWGqvencFUcwU/Gv8cyea39E0OzcJGfjjulEjGYe4w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwgbSvFAVo6epiWubO6l6QzIl0lNwSBoMyth/bCfMv3A9/AsXui
	5S1hHcGfeBjB3M225BD4+17f7NEH6H6XdelIdonGtw7vhvc+53Bplkfb/0cMttA=
X-Gm-Gg: ASbGnctkyTNC2i3cQfVVZazRzfCgMEW3XETMraBjT9i4YFmAXHJ4muB93YIIIRuvLtF
	wQhaBVGBzJ15DUYdwczI3qr805p0lZzQ/3Zl80DXDl2BWHYZT6hGGRouloQ7EGY9xhROfQ05z0k
	bHJTi7LQPf4xgJx4VdNuYvb9Q9uS2AD6NDkO1r0IbF+IkmQRERLAaBiS1Zf9pLZREr9hQdcprJo
	Fw1lNIhLyjqt4iEeK/Km7oRFE9QhNdIrjAQCP2jpkEFAQ4WW7kEyVEDoLbTr3r+pSBe6gGazpT/
	9zhfI0wpDOCBA9JGwZTtg1zGU1mXGU3IvKME1WadFV17wmKdNW0J95tiRg==
X-Google-Smtp-Source: AGHT+IEnYwIq0Gmg9aXj/gdoHcpx7iSAd8arSmzyKfzCe7K3tIJUhpfLuzs4l56U190AWHzReGvYOg==
X-Received: by 2002:a17:90b:48cc:b0:2ee:d371:3227 with SMTP id 98e67ed59e1d1-300ff104f1emr9530678a91.17.1741758941650;
        Tue, 11 Mar 2025 22:55:41 -0700 (PDT)
Received: from [157.82.205.237] ([157.82.205.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190bbd78sm748839a91.39.2025.03.11.22.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 22:55:41 -0700 (PDT)
Message-ID: <39c059c9-fe67-46e4-8c81-854a3de8d726@daynix.com>
Date: Wed, 12 Mar 2025 14:55:36 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 3/6] tun: Introduce virtio-net hash feature
To: Jason Wang <jasowang@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
References: <20250307-rss-v9-0-df76624025eb@daynix.com>
 <20250307-rss-v9-3-df76624025eb@daynix.com>
 <CACGkMEsNHba=PY5UQoH1zdGQRiHC8FugMG1nkXqOj1TBdOQrww@mail.gmail.com>
 <7978dfd5-8499-44f3-9c30-e53a01449281@daynix.com>
 <CACGkMEsR4_RreDbYQSEk5Cr29_26WNUYheWCQBjyMNUn=1eS2Q@mail.gmail.com>
 <5e67a0a6-f613-4b0a-b64e-67f649e45c3e@daynix.com>
 <CACGkMEv83iR0vU00XGOGonL1fkd=K1b-shCcNb1K8yJ9O+0BDQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEv83iR0vU00XGOGonL1fkd=K1b-shCcNb1K8yJ9O+0BDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/12 11:59, Jason Wang wrote:
> On Tue, Mar 11, 2025 at 2:17 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/03/11 9:38, Jason Wang wrote:
>>> On Mon, Mar 10, 2025 at 3:45 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2025/03/10 12:55, Jason Wang wrote:
>>>>> On Fri, Mar 7, 2025 at 7:01 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> Hash reporting
>>>>>> ==============
>>>>>>
>>>>>> Allow the guest to reuse the hash value to make receive steering
>>>>>> consistent between the host and guest, and to save hash computation.
>>>>>>
>>>>>> RSS
>>>>>> ===
>>>>>>
>>>>>> RSS is a receive steering algorithm that can be negotiated to use with
>>>>>> virtio_net. Conventionally the hash calculation was done by the VMM.
>>>>>> However, computing the hash after the queue was chosen defeats the
>>>>>> purpose of RSS.
>>>>>>
>>>>>> Another approach is to use eBPF steering program. This approach has
>>>>>> another downside: it cannot report the calculated hash due to the
>>>>>> restrictive nature of eBPF steering program.
>>>>>>
>>>>>> Introduce the code to perform RSS to the kernel in order to overcome
>>>>>> thse challenges. An alternative solution is to extend the eBPF steering
>>>>>> program so that it will be able to report to the userspace, but I didn't
>>>>>> opt for it because extending the current mechanism of eBPF steering
>>>>>> program as is because it relies on legacy context rewriting, and
>>>>>> introducing kfunc-based eBPF will result in non-UAPI dependency while
>>>>>> the other relevant virtualization APIs such as KVM and vhost_net are
>>>>>> UAPIs.
>>>>>>
>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>> Tested-by: Lei Yang <leiyang@redhat.com>
>>>>>> ---
>>>>>>     Documentation/networking/tuntap.rst |   7 ++
>>>>>>     drivers/net/Kconfig                 |   1 +
>>>>>>     drivers/net/tap.c                   |  68 ++++++++++++++-
>>>>>>     drivers/net/tun.c                   |  98 +++++++++++++++++-----
>>>>>>     drivers/net/tun_vnet.h              | 159 ++++++++++++++++++++++++++++++++++--
>>>>>>     include/linux/if_tap.h              |   2 +
>>>>>>     include/linux/skbuff.h              |   3 +
>>>>>>     include/uapi/linux/if_tun.h         |  75 +++++++++++++++++
>>>>>>     net/core/skbuff.c                   |   4 +
>>>>>>     9 files changed, 386 insertions(+), 31 deletions(-)
>>>>>>
> 
> [...]
> 
>>>>> Let's has a consistent name for this and the uapi to be consistent
>>>>> with TUNSETIFF/TUNGETIFF. Probably TUNSETVNETHASH and
>>>>> tun_vnet_ioctl_gethash().
>>>>
>>>> They have different semantics so they should have different names.
>>>> TUNGETIFF reports the value currently set while TUNGETVNETHASHCAP
>>>> reports the value that can be set later.
>>>
>>> I'm not sure I will get here. I meant a symmetric name
>>>
>>> TUNSETVNETHASH and TUNVETVNETHASH.
>>
>> TUNGETVNETHASHCAP does not correspond to TUNGETIFF. The correspondence
>> of ioctl names is as follows:
>> TUNGETFEATURES - TUNGETVNETHASHCAP
> 
> TUNGETFEATURES returns the value set from TUNSETIFF. This differs from
> TUNGETVNETHASHCAP semantic which just return the capabilities.
> 
> +static inline long tun_vnet_ioctl_gethashcap(void __user *argp)
> +{
> +       static const struct tun_vnet_hash cap = {
> +               .flags = TUN_VNET_HASH_REPORT | TUN_VNET_HASH_RSS,
> +               .types = VIRTIO_NET_SUPPORTED_HASH_TYPES
> +       };
> +
> +       return copy_to_user(argp, &cap, sizeof(cap)) ? -EFAULT : 0;
> +}
> 
> TUNGETFEATURES doesn't' help too much for non-persist TAP as userspace
> knows what value it set before.
> 
>> TUNSETIFF - TUNSETVNETHASH
>> TUNGETIFF - no corresponding ioctl for the virtio-net hash features
> 
> And this sounds odd and a hint for a incomplete uAPI as userspace
> needs to know knowing what can set before doing TUNSETVNETHASH.

You are confused with TUNGETFEATURES and TUNGETIFF. Below is the code 
that implements TUNGETFEATURES:
if (cmd == TUNGETFEATURES) {
	/* Currently this just means: "what IFF flags are valid?".
	 * This is needed because we never checked for invalid flags on
	 * TUNSETIFF.
	 */
	return put_user(IFF_TUN | IFF_TAP | IFF_NO_CARRIER |
			TUN_FEATURES, (unsigned int __user*)argp);
} else if (cmd == TUNSETQUEUE) {

Regards,
Akihiko Odaki

> 
>>
>> Regards,
>> Akihiko Odaki
>>
> 
> Thanks
> 


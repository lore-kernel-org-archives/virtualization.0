Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F53218ADD
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 06:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742191714; cv=none; b=PLMJqwY48dPP4H2Ew9skaAAyLwKKXGWJ75OyM5OkDtGb/V4752WHd1yOixDfZJ6BTtT8xeDvkx5ekE7QHlNHnPCT55g+PMMj0zVGK0b9LT3BFqOSYRWg5LsbNpdPVBy2wf6xi26z9CcrBqNk3JrEh108Jp29AVde3paIGTw8Ttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742191714; c=relaxed/simple;
	bh=IvNJR1CXhaIBt4hzQw1toiWztLSbiCGrla6GsFJVXKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYi/6AZ/3PjmYCyaHedC7yHKYJ3WL8Ki6u0OzMMBw6C5XfpIsu8pWOu215HbV355fPLz7sSysGyEyKRjRM/jKmANeDJKpeIc/02bTndofVynHGSjXTXKb8n92PHIHu/hIHF2YB6knMctDeekVUSJdyj1v2UxA6TwN6IpZfuYzJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=E4fbUJIJ; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="E4fbUJIJ"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 621D081FAB
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 06:08:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HBF5ZPs0HJLa for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Mar 2025 06:08:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CA7A181FAA
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CA7A181FAA
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=E4fbUJIJ
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CA7A181FAA
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 06:08:30 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-22438c356c8so67153535ad.1
        for <virtualization@lists.linux-foundation.org>; Sun, 16 Mar 2025 23:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742191710; x=1742796510; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wBWUop9hBNztgWdtuzQCjGkKpdUlBMvpymPGtusXugE=;
        b=E4fbUJIJOhLlBchUXC7QtQPyC9cgNUGe7ZwWDnY8tZLRA+5r64PD9C71bkmI9Of0xj
         +WC9hGggSkRyIx8+Udha6qcJd551Mo2VSUi5wYN5NXfid4yOlqpE+j3TfVOyjJceuniQ
         PZt5dUOiBNK2/pTt1omIcuHhPDd5yXEOHs5g+65DmF5GHLyVriPiMNT8mMFY7/l2d4f2
         ddWMywHK7CTVeuUEb8iPcKLoMoLN4z8ldY5AdT12Ocp05y+oUmYA7eumlLI63sLawOeu
         JYrKqt9Ufnkq35lzzKKERO8a+GGmJpUpEbLEI1XNm4lKO1hsrSrAfHUU5G5S/RR6JEQu
         5FRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742191710; x=1742796510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBWUop9hBNztgWdtuzQCjGkKpdUlBMvpymPGtusXugE=;
        b=UYmCbIgtZokpg8wbstupw14Gb4dH5hc3hR994MdGGubwBbRu82wThfWNA/0PfdwMk3
         gi2tQi1vaDSeSymprnL5Q1kZVeJJkFXFRr5/oA3/rC8LIJD5N6HvejOLXcHcSlgwSK+P
         sCuyzUI+P6djyeUvTUhkUzs2oFe4HPTkXdYlQNZST8vh236zme+l1g9uyecWiR1AzBct
         PUrddHXhIhnfHMkAPm1SbuJyR2o/SIvVHHqSbi74pzxEvM7n7ig/142TLqFoUnh7Upq7
         5UYbxjElESmr5R+9eZu6jbOgnuZuqadFXrVRtrkd1UVbYz+3zKtKaTwVH/bohn2CjewD
         SUjw==
X-Forwarded-Encrypted: i=1; AJvYcCW5RvyLoiIUP8aMLXM9UnLZcBeNyXta4b9upMeWgJYhzl5fFRy4GhXiwa7mkVL4kQOsa56+IEzZ2JgRYOB4hw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzbabmlfvucspTdnldSm8yHTp7ZwcjOWtS/TN5WPevytMHvF5kI
	6R059YE+GjM1bMgUgkPZQPuSxEmdVA6X1k2m+XA04wwHth9RoYReBScC72GzEpY=
X-Gm-Gg: ASbGncuyzptHA64zcZszES8jYvcKnU9c5b6gUYK9dihwMXzEdVANgomw2cykHRgKt4e
	qTHTEbXlriEyyv1BE9cIz6Zl/7iVR6TeGIVXc1X3DlmMVYNxfvk6XtifAqs6a1AeyXcPYl0p+6Z
	Dgzy00kdw2rNzh24J2Naj30WLRMilhYQP2fv5Ml1Pv9XRBRH27PE8H0d4+HywpBNnCLXjAeTMvm
	NjXN3TD4/G+aa+EmRDt8NNTpD6o12YAxZglOzpRxZz3AZX4BNwRqcMO24HhxV26RxM557V3LIgE
	3EZgh+D1b0ohutj3Jyjo49AeZPNOGnERU1QOf2AT8enNIy9TvKxpTAxrsQ==
X-Google-Smtp-Source: AGHT+IGoQLPthZhSthgnNJ0I5Yj2jn7eld4kAuLi8jvyiFCGmV6WYXwPCIBZuiv2agvX1E5gEnyKQg==
X-Received: by 2002:a17:903:18e:b0:223:325c:89de with SMTP id d9443c01a7336-225e0a5282bmr127005685ad.1.1742191709771;
        Sun, 16 Mar 2025 23:08:29 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a6dfesm67327865ad.71.2025.03.16.23.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Mar 2025 23:08:29 -0700 (PDT)
Message-ID: <cf4bf799-3a6e-44dc-96ca-fa8d616e6ba7@daynix.com>
Date: Mon, 17 Mar 2025 15:08:24 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 1/6] virtio_net: Add functions for hashing
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
 <20250307-rss-v9-1-df76624025eb@daynix.com>
 <CACGkMEvxkwe9OJRZPb7zz-sRfVpeuoYSz4c2kh9_jjtGbkb_qA@mail.gmail.com>
 <2e27f18b-1fc9-433d-92e9-8b2e3b1b65dc@daynix.com>
 <CACGkMEssbh0-BKJq7M=T1z9seMu==4OJzmDPU+HEx4OA95E3ng@mail.gmail.com>
 <26592324-c1f0-4ff5-918b-7a9366c4cf71@daynix.com>
 <CACGkMEtapdjiXCPd1JZUF8JP3F1Ks-AtrbFBNGtORYnXPPrBEQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEtapdjiXCPd1JZUF8JP3F1Ks-AtrbFBNGtORYnXPPrBEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/17 10:24, Jason Wang wrote:
> On Tue, Mar 11, 2025 at 1:49 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/03/11 9:47, Jason Wang wrote:
>>> On Mon, Mar 10, 2025 at 2:53 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2025/03/10 12:55, Jason Wang wrote:
>>>>> On Fri, Mar 7, 2025 at 7:01 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> They are useful to implement VIRTIO_NET_F_RSS and
>>>>>> VIRTIO_NET_F_HASH_REPORT.
>>>>>>
>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>> Tested-by: Lei Yang <leiyang@redhat.com>
>>>>>> ---
>>>>>>     include/linux/virtio_net.h | 188 +++++++++++++++++++++++++++++++++++++++++++++
>>>>>>     1 file changed, 188 insertions(+)
>>>>>>
>>>>>> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
>>>>>> index 02a9f4dc594d02372a6c1850cd600eff9d000d8d..426f33b4b82440d61b2af9fdc4c0b0d4c571b2c5 100644
>>>>>> --- a/include/linux/virtio_net.h
>>>>>> +++ b/include/linux/virtio_net.h
>>>>>> @@ -9,6 +9,194 @@
>>>>>>     #include <uapi/linux/tcp.h>
>>>>>>     #include <uapi/linux/virtio_net.h>
>>>>>>
>>>>>> +struct virtio_net_hash {
>>>>>> +       u32 value;
>>>>>> +       u16 report;
>>>>>> +};
>>>>>> +
>>>>>> +struct virtio_net_toeplitz_state {
>>>>>> +       u32 hash;
>>>>>> +       const u32 *key;
>>>>>> +};
>>>>>> +
>>>>>> +#define VIRTIO_NET_SUPPORTED_HASH_TYPES (VIRTIO_NET_RSS_HASH_TYPE_IPv4 | \
>>>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_TCPv4 | \
>>>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_UDPv4 | \
>>>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_IPv6 | \
>>>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_TCPv6 | \
>>>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_UDPv6)
>>>>>
>>>>> Let's explain why
>>>>>
>>>>> #define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
>>>>> #define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
>>>>> #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
>>>>>
>>>>> are missed here.
>>>>
>>>> Because they require parsing IPv6 options and I'm not sure how many we
>>>> need to parse. QEMU's eBPF program has a hard-coded limit of 30 options;
>>>> it has some explanation for this limit, but it does not seem definitive
>>>> either:
>>>> https://gitlab.com/qemu-project/qemu/-/commit/f3fa412de28ae3cb31d38811d30a77e4e20456cc#6ec48fc8af2f802e92f5127425e845c4c213ff60_0_165
>>>>
>>>
>>> How about the usersapce datapath RSS in Qemu? (We probably don't need
>>> to align with eBPF RSS as it's just a reference implementation)
>>
>> The userspace datapath RSS has no limit.
>>
>> The reference implementation is the userspace datapath. The eBPF program
>>    is intended to bring real performance benefit to Windows guests in
>> contrary.
>>
>> The userspace implementation does its best to provide defined RSS
>> capabilities but may not be performant. Parsing all IPv6 options have a
>> performance implication, but it is fine because it is not intended to be
>> performant in the first place.
>>
>> The performance problem is inherent to the userspace implementation,
>> which adds an extra overhead to the datapath. The eBPF program on the
>> other hand does not incur such overhead because it replaces the existing
>> steering algorithm (automq) instead of adding another layer. Hence the
>> eBPF program can be practical.
>>
>> That said, it is not that important to align with the userspace and eBPF
>> RSS in QEMU because they are still experimental anyway; the eBPF RSS has
>> potential to become a practical implementation but it is still in
>> development. The libvirt integration for the eBPF RSS is still not
>> complete, and we occasionally add fixes for RSS and hash reporting
>> without backporting to the stable branch.
>>
>> I'm adding interfaces to negotiate hash types rather for the future
>> extensibility. The specification may gain more hash types in the future
>> and other vhost backends may have a different set of hash types
>> supported. Figuring out how to deal with different sets of supported
>> hash typs is essential for both the kernel and QEMU.
>>
>>>
>>>> In this patch series, I add an ioctl to query capability instead; it
>>>> allows me leaving those hash types unimplemented and is crucial to
>>>> assure extensibility for future additions of hash types anyway. Anyone
>>>> who find these hash types useful can implement in the future.
>>>
>>> Yes, but we need to make sure no userspace visible behaviour changes
>>> after migration.
>>
>> Indeed, the goal is to make extensibility and migration compatible.
> 
> So I see this part:
> 
> + uint32_t supported_hash_types = n->rss_data.supported_hash_types;
> + uint32_t peer_hash_types = n->rss_data.peer_hash_types;
> + bool use_own_hash =
> + (supported_hash_types & VIRTIO_NET_RSS_SUPPORTED_HASHES) ==
> + supported_hash_types;
> + bool use_peer_hash =
> + n->rss_data.peer_hash_available &&
> + (supported_hash_types & peer_hash_types) == supported_hash_types;
> 
> It looks like it would be a challenge to support vhost-user in the
> future if vhost-user supports hash feature others than source?

The vhost-user backend will need to retrieve the supported hash types 
with VHOST_USER_GET_CONFIG as the vhost-vdpa backend does with 
VHOST_VDPA_GET_CONFIG.

> 
>>
>>>
>>>>
>>>>>
>>>>> And explain how we could maintain migration compatibility
>>>>>
>>>>> 1) Does those three work for userspace datapath in Qemu? If yes,
>>>>> migration will be broken.
>>>>
>>>> They work for userspace datapath so my RFC patch series for QEMU uses
>>>> TUNGETVNETHASHCAP to prevent breaking migration:
>>>> https://patchew.org/QEMU/20240915-hash-v3-0-79cb08d28647@daynix.com/
>>>>
>>>
>>> Ok, let's mention this in the cover letter. Another interesting thing
>>> is the migration from 10.0 to 9.0.
>>
>> The patch series is already mentioned in the cover letter. A description
>> of the intended use case of TUNGETVNETHASHCAP will be a good addition.
>> I'll add it to this patch so that it will be kept in tree after it gets
>> merged.
>>
>> Migration between two different QEMU versions should be handled with
>> versioned machine types.
>>
>> When a machine created in 9.0 is being migrated to 10.0, the machine
>> must set the hash type properties to match with the hash types supported
>> by the existing implementations, which means it sets the property for
>> VIRTIO_NET_HASH_REPORT_IPv6_EX to true, for example. Because this hash
>> type is currently not included in TUNGETVNETHASHCAP, the machine will
>> keep using the implementation used previously. The machine can be also
>> migrated back to 9.0 again.
>>
>> A machine type with version 10.0 cannot be migrated to 9.0 by design so
>> there is no new problem.
> 
> I meant migrate qemu 11.0 with machine type 10.0 to qemu 10.0 with
> machine 10.0 etc.

Let's assume QEMU 10.0 will support this new ioctl while QEMU 9.0 doesn't.

The description in my previous email was wrong. Checking the patch 
series again, I found I bumped the version number of 
vmstate_virtio_net_rss. So migrating QEMU 10.0 with machine type 9.0 to 
QEMU 9.0 will result in an error.

We can remove this error by introducing a compatibility property, but I 
don't think it's worth. As I noted in the previous email, the RSS 
feature is still in development and I don't think we need to support 
migrating to older QEMU versions. It gives an error instead of silently 
breaking a migrated VM at least.

Regards,
Akihiko Odaki

> 
>>
>>>
>>>> This patch series first adds configuration options for users to choose
>>>> hash types. QEMU then automatically picks one implementation from the
>>>> following (the earlier one is the more preferred):
>>>> 1) The hash capability of vhost hardware
>>>> 2) The hash capability I'm proposing here
>>>> 3) The eBPF program
>>>> 4) The pure userspace implementation
>>>>
>>>> This decision depends on the following:
>>>> - The required hash types; supported ones are queried for 1) and 2)
>>>> - Whether vhost is enabled or not and what vhost backend is used
>>>> - Whether hash reporting is enabled; 3) is incompatible with this
>>>>
>>>> The network device will not be realized if no implementation satisfies
>>>> the requirements.
>>>
>>> This makes sense, let's add this in the cover letter.
>>
>> I'll add it to the QEMU patch as it's more about details of QEMU.
>> The message of this patch will explain how TUNGETVNETHASHCAP and
>> TUNSETVNETHASH makes extensibility and migrattion compatible in general.
>>
>> Regards,
>> Akihiko Odaki
>>
>>>
>>>>
>>>>> 2) once we support those three in the future. For example, is the qemu
>>>>> expected to probe this via TUNGETVNETHASHCAP in the destination and
>>>>> fail the migration?
>>>>
>>>> QEMU is expected to use TUNGETVNETHASHCAP, but it can selectively enable
>>>> hash types with TUNSETVNETHASH to keep migration working.
>>>>
>>>> In summary, this patch series provides a sufficient facility for the
>>>> userspace to make extensibility and migration compatible;
>>>> TUNGETVNETHASHCAP exposes all of the kernel capabilities and
>>>> TUNSETVNETHASH allows the userspace to limit them.
>>>>
>>>> Regards,
>>>> Akihiko Odaki
>>>
>>> Fine.
>>>
>>> Thanks
>>>
> 
> Thanks
> 


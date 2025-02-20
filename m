Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A4E1F8EFF
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740062063; cv=none; b=iDoMAPft5/9kX8jGIHMcuq69Fp1AFuc/tS4TfasOqVC58hhx7Eseb3sVuY4G3HyMoNMm0GEfXpuwaiB9MqzDgPAkjNWOreF5VXqfFQ8wRq5VEXMr2uBC/ckMZh5vwWo3PBsWihHnEDA+SPLzPgYBfOoVD0ihbGDFplKacRXE/E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740062063; c=relaxed/simple;
	bh=mCeM6ZuSrmKm5oF0yVYgvsfU9qZcRpt1hmqobG0b78s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3CF0EqPZhw3k1MLfuA9wQbW777RQUWnbP9F5eRVL6hHiIQaYrYFU63UiMey7VQ8YhRNMHPP4uLzbqtOyP0QJEfyggETW9uAXd3oMRKNks6AcNrseXxCbXTBSuYt0CFVDV8idb4OlA1ipR0c50oC2V1oIBYGh6NkBdebG+R4dXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieBAHiOr; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieBAHiOr"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abb81285d33so208192966b.0
        for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 06:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740062059; x=1740666859; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SP8RnIeDpNVsIFAjPLo7muMaD4lYKk7nMDIuTCOWn10=;
        b=ieBAHiOrtsXFhkSAEHzdzOzcYAZAF63Z9kBDejuOlMVklHUgFEPNPAKsytUai3NKep
         jQ8AoQn8hEV40qCHk9uCj1F1tjFG80P4WmdhziCeOzUeadZ45xtHuisuwh43AqYjX2sE
         lMxAxFreC2tAbKZH91ZqD3EsQHVwkawKTG84wv/qB6KaOjEFSbH3kMAaJbhqtDm3TjiD
         iaELWVrVD1OFuoXzeks86YQKV+KNJ3sA7zkL9th5t9LcLRWwj2WKuivID/2vCPyo9NKY
         Rt8CLbzAZ40DOSRNc2kiKWXldOQo721ORMRoARIEgbEkpveMouneGc/2Mg520UAiV5dS
         S/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740062059; x=1740666859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SP8RnIeDpNVsIFAjPLo7muMaD4lYKk7nMDIuTCOWn10=;
        b=R9eTI+6x44cIavLnipZC9xJu7uLtSVAut0w/L7u2L0CwTyoAOd78Fl6gpMiaMQt53D
         KHIfYAjePIFZkaauQMdjtv/wTtgClaUWozw14XKFWLZgRcra/Vj8V/F5yjSx6OosKE2E
         8eZVkbZmtoMLPaCElajY95DKdKxdhAnokQ/K7WduBSNJvZhaNt0ZiLpVYQHsJEak+4ks
         z9kYXc1yyqQrJ0/CJu0vfGfBgUeAHaHtIZA2LEsuuV1FXeQvvZmmcyl2vpR5zcJ21gZi
         D481Uy+mGafo7sxoNWWmpS2UNKL3fdKVmMUWZVeWOTUXUSobaGKI4tWacGEiy4I9VjqM
         5FLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm02xU18/EDLjUPIn9KOSLJo4M0R6OvV/KhJDpiTlKHqj42/gnPUEpF3woboD33ce/SslbVMCd7DIWcNm7MQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmcWJ7WkLBBGVElzPdhRtfz5bhb5VY2Wd6FVKEvVLVjECwNQnj
	G6s2gfaEujwDpU3WWfs7Zuis4ks5vbRsxKU42di9syx9jcehZlCN
X-Gm-Gg: ASbGncsOTLiXweQDYxLe9V1p/FKFLVVZp6XZk/N4UIHSghnZg0i5/AfNE0hm/w72Sy7
	Mt5/gFn0/T8W+CJIO1vYXvC1xrxpOdQ/BS78/x8yHvehAbmfzj7jVy+eoQ0lTyVWNmkmLcR0ws5
	1XTQOHm94kg/rbEnIENDTGhJhzskCY3NMwUvMhFN8SjJPxh7/ZJCfKR6jPO6LCBW7goN3hmW6+f
	Rd94Snjrp7HHpXiR8jWVYi40k0tTJo/eFrrZ/g3Tw6Xe5PXDKxYZEOpclvmzwUIbDZ1XGXJnJh8
	CO+6XMPTCzBsvPtD7Z4Q3DsJaqvviSjKSwrYBmP9HWqKpZfc
X-Google-Smtp-Source: AGHT+IEUnYvTNKsvY9MrM+eSrclwuFXi6u43e2ImceV18idD0uHP1IUpkxxK3L69vw0GspWuGL/SmA==
X-Received: by 2002:a17:907:c293:b0:ab7:5fcd:d4de with SMTP id a640c23a62f3a-abbf3d0c598mr285469666b.50.1740062059127;
        Thu, 20 Feb 2025 06:34:19 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:f455])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbaa56026fsm665714466b.113.2025.02.20.06.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 06:34:18 -0800 (PST)
Message-ID: <e38090b0-f990-4347-b4bf-6f33f36bb851@gmail.com>
Date: Thu, 20 Feb 2025 14:35:20 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/6] net: devmem: Implement TX path
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
References: <20250203223916.1064540-1-almasrymina@google.com>
 <20250203223916.1064540-6-almasrymina@google.com>
 <abc22620-d509-4b12-80ac-0c36b08b36d9@gmail.com>
 <CAHS8izNOqaFe_40gFh09vdBz6-deWdeGu9Aky-e7E+Wu2qtfdw@mail.gmail.com>
 <28343e83-6d93-4002-a691-f8273d4d24a8@gmail.com>
 <CAHS8izOE-JzMszieHEXtYBs7_6D-ngVx2kJyMwp8eCWLK-c0cQ@mail.gmail.com>
 <9210a12c-9adb-46ba-b92c-90fd07e1980f@gmail.com>
 <CAHS8izPHtk5x-W05_svxU53X-V4+++PiYErCgfr-3iDGgEaUig@mail.gmail.com>
 <4cdfaff8-0623-4d3a-9204-5165ccbb84db@gmail.com>
 <CAHS8izNHT_VjztrDk6t-OJoX=zB3vV81w2CYZTKA1yGB06tY-Q@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izNHT_VjztrDk6t-OJoX=zB3vV81w2CYZTKA1yGB06tY-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/20/25 01:46, Mina Almasry wrote:
> On Wed, Feb 19, 2025 at 2:40 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 2/17/25 23:26, Mina Almasry wrote:
>>> On Thu, Feb 13, 2025 at 5:17 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>> ...
>>>>>>> It's asserting that sizeof(ubuf_info_msgzc) <= sizeof(skb->cb), and
>>>>>>> I'm guessing increasing skb->cb size is not really the way to go.
>>>>>>>
>>>>>>> What I may be able to do here is stash the binding somewhere in
>>>>>>> ubuf_info_msgzc via union with fields we don't need for devmem, and/or
>>>>>>
>>>>>> It doesn't need to account the memory against the user, and you
>>>>>> actually don't want that because dmabuf should take care of that.
>>>>>> So, it should be fine to reuse ->mmp.
>>>>>>
>>>>>> It's also not a real sk_buff, so maybe maintainers wouldn't mind
>>>>>> reusing some more space out of it, if that would even be needed.
>>>>>>
>>>>>
>>>>> netmem skb are real sk_buff, with the modification that frags are not
>>>>
>>>> We were discussing ubuf_info allocation, take a look at
>>>> msg_zerocopy_alloc(), it has nothing to do with netmems and all that.
>>>>
>>>
>>> Yes. My response was regarding the suggestion that we can use space in
>>> devmem skbs however we want though.
>>
>> Well, at least I didn't suggest that, assuming "devmem skbs" are skbs
>> filled with devmem frags. I think the confusion here is thinking
>> that skb->cb you mentioned above is about "devmem skbs", while it's
>> special skbs without data used only to piggy back ubuf allocation.
> 
> Ah, I see. I still don't see how we can just increase the size of
> skb->cb when it's shared between these special skbs and regular skbs.

The approach was not to increase ->cb but rather reuse some other unused
in the path sk_buff fields. Though, looking at __msg_zerocopy_callback(),
maybe it's better not to entertain that, as the skb is queued into the
error queue. But again, not like you need it.

>> Functionally speaking, it'd be perfectly fine to get rid of the
>> warning and allocate it with kmalloc().
>>
> 
> More suggestions to refactor unrelated things to force through a
> msg->sg_from_iter approach.

Mina, you're surprising me. Neither I suggested to do that, just
trying to help with your confusion using analogies, nor I said that
it'd be welcome, nor it's somehow "unrelated". And "forcing"
is a misstatement, so far I've been extending a recommendation
on how to make it better.

...
>> If you've already done, maybe you can post it as a draft? At least
>> it'll be obvious why you say it's more complicated.
>>
> 
> I don't have anything worth sharing. Just went down this rabbit hole
> and saw a bunch of MSG_ZEROCOPY checks (!msg->msg_ubuf checks around
> MSG_ZEROCOPY code) and restrictions (skb->cb size) need to be
> addressed and checks to be added. From this thread you seem to be
> suggesting more changes to force in a msg->sg_from_iter approach
> adding to the complications.

To sum up, you haven't tried it.

>>> The complication could be worth it if there was some upside, but I
>>> don't see one tbh. Passing the binding down to
>>> zerocopy_fill_skb_from_devmem seems like a better approach to my eye
>>> so far
>>
>> The upside is that 1) you currently you add overhead to common
>> path (incl copy),
> 
> You mean the unlikely() check for devmem before delegating to
> skb_zerocopy_fill_from_devmem? Should be minimal.

Like keeping the binding in tcp_sendmsg_locked(). The point is,
as you mentioned overhead ("adds more checks to the fast
MSG_ZEROCOPY paths"), all things included the current approach
will be adding more of it to MSG_ZEROCOPY and also other users.

>> 2) passing it down through all the function also
>> have overhead to the zerocopy and MSG_ZEROCOPY path, which I'd
>> assume is comparable to those extra checks you have.
> 
> Complicating/refactoring existing code for devmem TCP to force in a
> msg->sg_from_iter and save 1 arg passed down a couple of functions
> doesn't seem like a good tradeoff IMO.
> 
>> 3) tcp would
>> need to know about devmem tcp and its bindings, while it all could
>> be in one spot under the MSG_ZEROCOPY check.
> 
> I don't see why this is binding to tcp somehow. If anything it makes

I don't get what you're saying, but it refers to devmem binding,
which you add to TCP path, and so tcp now has to know how to work
with devmem instead of all of it being hidden behind the curtains
of ubuf_info. And it sticks out not only for tcp, but for all
zerocopy users by the virtue of dragging it down through all
helpers.

> the devmem TX implementation follow closely MSG_ZEROCOPY, and existing

Following closely would be passing ubuf just like MSG_ZEROCOPY does,
and not plumbing devmem all the way through all helpers.

> MSG_ZEROCOPY code would be easily extended for devmem TX without
> having to also carry refactors to migrate to msg->sg_from_iter

Don't be afraid of refactoring when it makes things better. We're
talking about minor changes touching only bits in the direct
vicinity of your set.

> approach (just grab the binding and pass it to
> skb_zerocopy_iter_stream).
> 
>> 4) When you'd want
>> another protocol to support that, instead of a simple
>>
>> ubuf = get_devmem_ubuf();
>>
>> You'd need to plumb binding passing through the stack there as
>> well.
>>
> 
> Similar to above, I think this approach will actually extend easier to
> any protocol already using MSG_ZEROCOPY, because we follow that
> closely instead of requiring refactors to force msg->sg_from_iter
> approach.

-- 
Pavel Begunkov


Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FD1274FE3
	for <virtualization@lists.linux.dev>; Sun, 14 Dec 2025 06:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765694308; cv=none; b=uGiy0oW5VUct+cxc0pSiHK0ThI5ZNYghkc34CinlXF1iFnmWMuICbtJIGN3IbE3KXj0Bjjpjj/Iz1hrrPu/kYMdTD4+dWBJjxmNN9nOGDmhhw7bduLryLmhNjJgfgvENxK9Iv5IU2zeWsWQLLoBZqjWafzEJTFKP/adbk6WX4ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765694308; c=relaxed/simple;
	bh=yLpYmY+EhSy4abAWbhr3gJTq77TsZsZuhspXQY+yB4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sPfrnrNjbiNPgFsNJc4QS1G+WjEBzYLwXZ4J63Hb8UpBN4No8PNmn64RvHoE3ha291tP26y4GS5SqSenNrWtGhYShlwGtmsvY8G3UrWCMsWpr9Xp+s6GPHTWeQHXMI0cVUqvPzhsiF+eeVGCR7LZCTT46gfxz+lg4mQtbiRkVk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mS+WUnaY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mS+WUnaY"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso19107505e9.2
        for <virtualization@lists.linux.dev>; Sat, 13 Dec 2025 22:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765694305; x=1766299105; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=axrQHkzxz0KpEHvUlLXeQIagSIg4MG47QjW3/6LfZU0=;
        b=mS+WUnaYxhBcsJMJDjliDHOfZZ4tvjJadeCZbIwJmEdZQioZbvI/YnF67ixiXfqNGZ
         Hi0MpUgUt5Mobi0qwDFT0y8liNEQ55EO/izfX/7htAIdJmFLxH17UiKScUMbA1CSvw5p
         1d9mF1FCwb0ZYsVE8+A5BwhkAl0TwyFgSOE8aJDk7ldoFHP0yO+GiQ/zyaWtGrkWxQAI
         fptosLjbPUm8eKBRxuKAJ2ubIZ7Bcgq3ReqhGyQXh3OO6Ae/4Bgy9n/ZdDcQw6PdNYJL
         QgTadGI6SdhHmXik6hLiPLy9+M6LtW5I+8KGNep8yW0jpTiRsFOYXjJTSu+AT3VIkPIh
         dPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765694305; x=1766299105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=axrQHkzxz0KpEHvUlLXeQIagSIg4MG47QjW3/6LfZU0=;
        b=eQvbQGm4mzLocgglgWd8D626T0Vq7T1DJZunWbjLytpcMjsUFQdJRvI/s8Dqz8YifG
         zji8RRZy/wLgdgOJNRZlkz1d9wBSPWaYlNc4KJ7OEwyvdx2xAvbxIQA7Nb8WZdW2qvc9
         qyc/P71u1aqzCUaugQs8J3XEeXPrAvmNJK5UZh8hPR0hRPrWG6q4SgF32sAnmAxbRARd
         MjGTuvhp3IlDH+nnWAnHF4ckZJvn0xP1jcF+8IwNNNGcL/d6otD0f9dvaAKXeAH4orMN
         EjvFcTgruerhE5gBOzRfNoYytaL7Et06PlQ3CnFfHUDZoEH1Y+j7jYRwqxFbpOrq59pz
         P9Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWT7cgxtYv45wUUZPVJ6PTXpd7BfQNZL6nYcEj3Yllo/dvhjiKc0JQaq2ae8Ac7TrYg2LmoDzXbLmZtzsVaOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2fhD/NgUy+6b/aMhEgvhbN5dQ5DNl4rke/eRgrX7riC4kL4m6
	WrnPChKRKoWrDLDdOLdIoOJ2r6WCaD9rb/avRW7irdSFeLLbETfntMUY
X-Gm-Gg: AY/fxX4lwWArupp96gbTDZTBpxuBuM7WTMWzQvgWzgZenc2z4z7Mn71tO2YySvMuAop
	CdmvwTdxZTXYg0SiA2fniVEM5z8e4osGD8872QBnbO/39Ru8qrfWAoZZQ9UDqq3/ZSshqy77ELX
	B/STRDQ/C7TwWDQBO6qk4/DZ532ND9kBkqginbo23puL+5t9Vo4Dxyn0kR/azhDpQgMFLKR6Kvy
	x9EE4BM7vW17mZkYPNSHKRy6MEKzxi4eOFsVhHIoA2F9WRFLmCmCgzQMRyT0OJC/HHnMRIWqrU5
	5+iWjRJsk9HNxqsKezP4EIFZMF0DtoKOqi7kWeqlpUyM4QAMx2rbGEr81LZ1s4OSJ1y1klx/AVW
	uadVSGlhtWzCUnCz/GSsGqxFV4Wbrc5nFz/zPdgX+LeSuOoiUWyh0DDwmh4XOLeCNqelZlIklNL
	BkMe5Ni87glYyNSnh4rVP1DAmylcHyrFaDlTQS/xhTd1bkOaTTuTuoomjuypZ0KliYXAbubn1Gh
	23FAI8=
X-Google-Smtp-Source: AGHT+IG9JoSb6msVo1qCxcATC1m0efC94+Z21fe2Smru+QlOODZum3iTG70a6YMjFsBcs3efW3tTXQ==
X-Received: by 2002:a05:600c:6291:b0:479:3a2a:94e7 with SMTP id 5b1f17b1804b1-47a8f8b1449mr72294215e9.10.1765694304770;
        Sat, 13 Dec 2025 22:38:24 -0800 (PST)
Received: from [192.168.0.173] (108.228-30-62.static.virginmediabusiness.co.uk. [62.30.228.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430f7475895sm2899972f8f.33.2025.12.13.22.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Dec 2025 22:38:23 -0800 (PST)
Message-ID: <24b9961d-7e0d-4239-97b3-39799524909f@gmail.com>
Date: Sun, 14 Dec 2025 06:38:22 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] vsock/virtio: cap TX credit to local buffer size
Content-Language: en-GB
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com,
 kvm@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
References: <20251211125104.375020-1-mlbnkm1@gmail.com>
 <20251211080251-mutt-send-email-mst@kernel.org>
 <zlhixzduyindq24osaedkt2xnukmatwhugfkqmaugvor6wlcol@56jsodxn4rhi>
 <CAMKc4jDpMsk1TtSN-GPLM1M_qp_jpoE1XL1g5qXRUiB-M0BPgQ@mail.gmail.com>
 <CAGxU2F7WOLs7bDJao-7Qd=GOqj_tOmS+EptviMphGqSrgsadqg@mail.gmail.com>
 <CAMKc4jDLdcGsL5_d+4CP6n-57s-R0vzrX2M7Ni=1GeCB1cxVYA@mail.gmail.com>
 <bwmol6raorw233ryb3dleh4meaui5vbe7no53boixckl3wgclz@s6grefw5dqen>
 <deccf66c-dcd3-4187-9fb6-43ddf7d0a905@gmail.com>
 <tandvvk6vas3kgqjuo6w3aagqai246qxejfnzhkbvbxds3w4y6@umqvf7f3m5ie>
From: Melbin K Mathew <mlbnkm1@gmail.com>
In-Reply-To: <tandvvk6vas3kgqjuo6w3aagqai246qxejfnzhkbvbxds3w4y6@umqvf7f3m5ie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/12/2025 12:26, Stefano Garzarella wrote:
> On Fri, Dec 12, 2025 at 11:40:03AM +0000, Melbin K Mathew wrote:
>>
>>
>> On 12/12/2025 10:40, Stefano Garzarella wrote:
>>> On Fri, Dec 12, 2025 at 09:56:28AM +0000, Melbin Mathew Antony wrote:
>>>> Hi Stefano, Michael,
>>>>
>>>> Thanks for the suggestions and guidance.
>>>
>>> You're welcome, but please avoid top-posting in the future:
>>> https://www.kernel.org/doc/html/latest/process/submitting- 
>>> patches.html#use-trimmed-interleaved-replies-in-email-discussions
>>>
>> Sure. Thanks
>>>>
>>>> I’ve drafted a 4-part series based on the recap. I’ve included the
>>>> four diffs below for discussion. Can wait for comments, iterate, and
>>>> then send the patch series in a few days.
>>>>
>>>> ---
>>>>
>>>> Patch 1/4 — vsock/virtio: make get_credit() s64-safe and clamp 
>>>> negatives
>>>>
>>>> virtio_transport_get_credit() was doing unsigned arithmetic; if the
>>>> peer shrinks its window, the subtraction can underflow and look like
>>>> “lots of credit”. This makes it compute “space” in s64 and clamp < 0
>>>> to 0.
>>>>
>>>> diff --git a/net/vmw_vsock/virtio_transport_common.c
>>>> b/net/vmw_vsock/virtio_transport_common.c
>>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>>> @@ -494,16 +494,23 @@ 
>>>> EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
>>>> u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 
>>>> credit)
>>>> {
>>>> + s64 bytes;
>>>>  u32 ret;
>>>>
>>>>  if (!credit)
>>>>  return 0;
>>>>
>>>>  spin_lock_bh(&vvs->tx_lock);
>>>> - ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>>>> - if (ret > credit)
>>>> - ret = credit;
>>>> + bytes = (s64)vvs->peer_buf_alloc -
>>>
>>> Why not just calling virtio_transport_has_space()?
>> virtio_transport_has_space() takes struct vsock_sock *, while 
>> virtio_transport_get_credit() takes struct virtio_vsock_sock *, so I 
>> cannot directly call has_space() from get_credit() without changing 
>> signatures.
>>
>> Would you be OK if I factor the common “space” calculation into a 
>> small helper that operates on struct virtio_vsock_sock * and is used 
>> by both paths? Something like:
> 
> Why not just change the signature of virtio_transport_has_space()?
Thanks, that is cleaner.

For Patch 1 i'll change virtio_transport_has_space() to take
struct virtio_vsock_sock * and call it from both
virtio_transport_stream_has_space() and virtio_transport_get_credit().

/*
  * Return available peer buffer space for TX (>= 0).
  *
  * Use s64 arithmetic so that if the peer shrinks peer_buf_alloc while
  * we have bytes in flight (tx_cnt - peer_fwd_cnt), the subtraction does
  * not underflow into a large positive value as it would with u32.
  *
  * Must be called with vvs->tx_lock held.
  */
static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs)
{
	s64 bytes;

	bytes = (s64)vvs->peer_buf_alloc -
		((s64)vvs->tx_cnt - (s64)vvs->peer_fwd_cnt);
	if (bytes < 0)
		bytes = 0;

	return bytes;
}

s64 virtio_transport_stream_has_space(struct vsock_sock *vsk)
{
	struct virtio_vsock_sock *vvs = vsk->trans;
	s64 bytes;

	spin_lock_bh(&vvs->tx_lock);
	bytes = virtio_transport_has_space(vvs);
	spin_unlock_bh(&vvs->tx_lock);

	return bytes;
}

u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
{
	u32 ret;

	if (!credit)
		return 0;

	spin_lock_bh(&vvs->tx_lock);
	ret = min_t(u32, credit, (u32)virtio_transport_has_space(vvs));
	vvs->tx_cnt += ret;
	vvs->bytes_unsent += ret;
	spin_unlock_bh(&vvs->tx_lock);

	return ret;
}

Does this look right?
> Thanks,
> Stefano
> 
>>
>> /* Must be called with vvs->tx_lock held. Returns >= 0. */
>> static s64 virtio_transport_tx_space(struct virtio_vsock_sock *vvs)
>> {
>>     s64 bytes;
>>
>>     bytes = (s64)vvs->peer_buf_alloc -
>>         ((s64)vvs->tx_cnt - (s64)vvs->peer_fwd_cnt);
>>     if (bytes < 0)
>>         bytes = 0;
>>
>>     return bytes;
>> }
>>
>> Then:
>>
>> get_credit() would do bytes = virtio_transport_tx_space(vvs); ret = 
>> min_t(u32, credit, (u32)bytes);
>>
>> has_space() would use the same helper after obtaining vvs = vsk->trans;
>>
>> Does that match what you had in mind, or would you prefer a different 
>> factoring?
>>
>>>
>>>> + ((s64)vvs->tx_cnt - (s64)vvs->peer_fwd_cnt);
>>>> + if (bytes < 0)
>>>> + bytes = 0;
>>>> +
>>>> + ret = min_t(u32, credit, (u32)bytes);
>>>>  vvs->tx_cnt += ret;
>>>>  vvs->bytes_unsent += ret;
>>>>  spin_unlock_bh(&vvs->tx_lock);
>>>>
>>>>  return ret;
>>>> }
>>>>
>>>>
>>>> ---
>>>>
>>>> Patch 2/4 — vsock/virtio: cap TX window by local buffer (helper + use
>>>> everywhere in TX path)
>>>>
>>>> Cap the effective advertised window to min(peer_buf_alloc, buf_alloc)
>>>> and use it consistently in TX paths (get_credit, has_space,
>>>> seqpacket_enqueue).
>>>>
>>>> diff --git a/net/vmw_vsock/virtio_transport_common.c
>>>> b/net/vmw_vsock/virtio_transport_common.c
>>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>>> @@ -491,6 +491,16 @@ void virtio_transport_consume_skb_sent(struct
>>>> sk_buff *skb, bool consume)
>>>> }
>>>> EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
>>>> +/* Return the effective peer buffer size for TX credit computation.
>>>> + *
>>>> + * The peer advertises its receive buffer via peer_buf_alloc, but 
>>>> we cap it
>>>> + * to our local buf_alloc (derived from SO_VM_SOCKETS_BUFFER_SIZE and
>>>> + * already clamped to buffer_max_size).
>>>> + */
>>>> +static u32 virtio_transport_tx_buf_alloc(struct virtio_vsock_sock 
>>>> *vvs)
>>>> +{
>>>> + return min(vvs->peer_buf_alloc, vvs->buf_alloc);
>>>> +}
>>>>
>>>> u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 
>>>> credit)
>>>> {
>>>>  s64 bytes;
>>>> @@ -502,7 +512,8 @@ u32 virtio_transport_get_credit(struct
>>>> virtio_vsock_sock *vvs, u32 credit)
>>>>  return 0;
>>>>
>>>>  spin_lock_bh(&vvs->tx_lock);
>>>> - bytes = (s64)vvs->peer_buf_alloc -
>>>> + bytes = (s64)virtio_transport_tx_buf_alloc(vvs) -
>>>>  ((s64)vvs->tx_cnt - (s64)vvs->peer_fwd_cnt);
>>>>  if (bytes < 0)
>>>>  bytes = 0;
>>>> @@ -834,7 +845,7 @@ virtio_transport_seqpacket_enqueue(struct 
>>>> vsock_sock *vsk,
>>>>  spin_lock_bh(&vvs->tx_lock);
>>>>
>>>> - if (len > vvs->peer_buf_alloc) {
>>>> + if (len > virtio_transport_tx_buf_alloc(vvs)) {
>>>>  spin_unlock_bh(&vvs->tx_lock);
>>>>  return -EMSGSIZE;
>>>>  }
>>>> @@ -884,7 +895,8 @@ static s64 virtio_transport_has_space(struct
>>>> vsock_sock *vsk)
>>>>  struct virtio_vsock_sock *vvs = vsk->trans;
>>>>  s64 bytes;
>>>>
>>>> - bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>>>> + bytes = (s64)virtio_transport_tx_buf_alloc(vvs) -
>>>> + ((s64)vvs->tx_cnt - (s64)vvs->peer_fwd_cnt);
>>>>  if (bytes < 0)
>>>>  bytes = 0;
>>>>
>>>>  return bytes;
>>>> }
>>>>
>>>>
>>>> ---
>>>>
>>>> Patch 3/4 — vsock/test: fix seqpacket msg bounds test (set client 
>>>> buf too)
>>>
>>> Please just include in the series the patch I sent to you.
>>>
>> Thanks. I'll use your vsock_test.c patch as-is for 3/4
>>>>
>>>> After fixing TX credit bounds, the client can fill its TX window and
>>>> block before it wakes the server. Setting the buffer on the client
>>>> makes the test deterministic again.
>>>>
>>>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/ 
>>>> vsock_test.c
>>>> --- a/tools/testing/vsock/vsock_test.c
>>>> +++ b/tools/testing/vsock/vsock_test.c
>>>> @@ -353,6 +353,7 @@ static void test_stream_msg_peek_server(const
>>>> struct test_opts *opts)
>>>>
>>>> static void test_seqpacket_msg_bounds_client(const struct test_opts 
>>>> *opts)
>>>> {
>>>> + unsigned long long sock_buf_size;
>>>>  unsigned long curr_hash;
>>>>  size_t max_msg_size;
>>>>  int page_size;
>>>> @@ -366,6 +367,18 @@ static void
>>>> test_seqpacket_msg_bounds_client(const struct test_opts *opts)
>>>>  exit(EXIT_FAILURE);
>>>>  }
>>>>
>>>> + sock_buf_size = SOCK_BUF_SIZE;
>>>> +
>>>> + setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
>>>> +    sock_buf_size,
>>>> +    "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
>>>> +
>>>> + setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>>>> +    sock_buf_size,
>>>> +    "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
>>>> +
>>>>  /* Wait, until receiver sets buffer size. */
>>>>  control_expectln("SRVREADY");
>>>>
>>>>
>>>> ---
>>>>
>>>> Patch 4/4 — vsock/test: add stream TX credit bounds regression test
>>>>
>>>> This directly guards the original failure mode for stream sockets: if
>>>> the peer advertises a large window but the sender’s local policy is
>>>> small, the sender must stall quickly (hit EAGAIN in nonblocking mode)
>>>> rather than queueing megabytes.
>>>
>>> Yeah, using nonblocking mode LGTM!
>>>
>>>>
>>>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/ 
>>>> vsock_test.c
>>>> --- a/tools/testing/vsock/vsock_test.c
>>>> +++ b/tools/testing/vsock/vsock_test.c
>>>> @@ -349,6 +349,7 @@
>>>> #define SOCK_BUF_SIZE (2 * 1024 * 1024)
>>>> +#define SMALL_SOCK_BUF_SIZE (64 * 1024ULL)
>>>> #define MAX_MSG_PAGES 4
>>>>
>>>> /* Insert new test functions after test_stream_msg_peek_server, before
>>>>  * test_seqpacket_msg_bounds_client (around line 352) */
>>>>
>>>> +static void test_stream_tx_credit_bounds_client(const struct 
>>>> test_opts *opts)
>>>> +{
>>>> + ... /* full function as provided */
>>>> +}
>>>> +
>>>> +static void test_stream_tx_credit_bounds_server(const struct 
>>>> test_opts *opts)
>>>> +{
>>>> + ... /* full function as provided */
>>>> +}
>>>>
>>>> @@ -2224,6 +2305,10 @@
>>>>  .run_client = test_stream_msg_peek_client,
>>>>  .run_server = test_stream_msg_peek_server,
>>>>  },
>>>> + {
>>>> + .name = "SOCK_STREAM TX credit bounds",
>>>> + .run_client = test_stream_tx_credit_bounds_client,
>>>> + .run_server = test_stream_tx_credit_bounds_server,
>>>> + },
>>>
>>> Please put it at the bottom. Tests are skipped by index, so we don't 
>>> want to change index of old tests.
>>>
>>> Please fix your editor, those diffs are hard to read without tabs/ 
>>> spaces.
>> seems like some issue with my email client. Hope it is okay now
>>>
>>> Thanks,
>>> Stefano
>>>
>>
> 


Received: from mx4.sberdevices.ru (mx4.sberdevices.ru [152.89.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420E53F1ACD
	for <virtualization@lists.linux.dev>; Tue, 19 May 2026 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.89.196.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187234; cv=none; b=YPr5OtaoSCg5VGay5jJiw4e6DYncSvIUDJ2A14xz+iAQ1bdZk8RjlgQNxzY8neSAfE83X8zvRZYlAnKNg01mpq++SH9QU1M/1cLkfSGwg3uVJqSoLp00i07mIwmyyF46ca175uSytwmTOlWoYHh4/KeeDJ1+yJoGUz02+U802h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187234; c=relaxed/simple;
	bh=1DDPEQ6Ad+zkc7CbGn3iTPqfeWsmlCnU2S/NaEW3rjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XipddL59bm1yvflM4HcOVrVgYGgdFr/rg9WXrohL2rimVdRFS59o0fbRaVfIbPUDEyq1QkqiQjeshDDnnBITBhxSKGpeb0dXCJ+VN06yg1umseuBtFEn+KK94zmkBfpoJ+HwAAW+xKfRWU4K3I1neGGPhb05pvBQXrjaoWT+H1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=QTLzPnxY; arc=none smtp.client-ip=152.89.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="QTLzPnxY"
Received: from p-antispam-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx4.sberdevices.ru (Postfix) with ESMTP id B33A740016;
	Tue, 19 May 2026 13:40:28 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx4.sberdevices.ru B33A740016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1779187228;
	bh=dQ9xHtZ7tzYnOTboAdIpbJmWJfaj5XbwXVJmG5/3vLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=QTLzPnxYDxxlPG8sixs+G8eEMZPgXxe0sDYdFEXBtPaDmpzXwmk9uwLWVn/tRNaon
	 Z1d4Xo2HWhf78s+EFxWF36PRIzQlb7/N2afnF6XqGEL5ZKeCrRA/ihJLLJAOS2dU/C
	 ZvNWBfvFSUJ8NaVbxXTNDNKoeQj/8Ha1p5NPHoLfPqG4XKj9aYlNlgFUuGdaNWKze7
	 vqJppw6eeml7CuZC3AmskNMMZYq7sN541J9KVEjuupY7lQI6vq5+C6x/TzG7DC5wMG
	 C1OKMENojcjJIMn8V2kGWmmyMSjRUtCYvzuoQlKzKv9mIkafLim+PWD4dH2CgvlFaa
	 V+7UGrGF6WuIg==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R12" (not verified))
	by mx4.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 19 May 2026 13:40:26 +0300 (MSK)
Message-ID: <9da0992f-207e-4d40-8f12-c98fea299414@salutedevices.com>
Date: Tue, 19 May 2026 13:40:24 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vsock/virtio: fix zerocopy completion for multi-skb
 sends
Content-Language: ru
To: Stefano Garzarella <sgarzare@redhat.com>
CC: David Laight <david.laight.linux@gmail.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Stefan
 Hajnoczi <stefanha@redhat.com>, <kvm@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, <virtualization@lists.linux.dev>,
	"David S. Miller" <davem@davemloft.net>, Jason Wang <jasowang@redhat.com>,
	<linux-kernel@vger.kernel.org>, Maher Azzouzi <maherazz04@gmail.com>
References: <20260514092948.268720-1-sgarzare@redhat.com>
 <20260516125329.7b699c6f@pumpkin> <agrXvCtNRlySlwgx@sgarzare-redhat>
 <20260518053223-mutt-send-email-mst@kernel.org>
 <agrg1GVzoJWtNuSd@sgarzare-redhat> <20260518115005.5f13bd2b@pumpkin>
 <20260519053951.1C60440015@mx4.sberdevices.ru>
 <aea2227c-3011-4457-b909-d16de1596a6d@salutedevices.com>
 <agwwxuQlIWjwXtMN@sgarzare-redhat>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <agwwxuQlIWjwXtMN@sgarzare-redhat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-exch-cas-s-m2.sberdevices.ru (172.16.210.3) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-AntiPhishing: NotDetected, bases: 2026/05/19 09:18:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 105 0.3.105 c7fb587251b1312ef0d9243823bef7335f8fcbef, {Tracking_phishing_log_reg_50_60}, {Tracking_uf_ne_domains}, {Tracking_arrow_http}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;git.kernel.org:7.1.1;salutedevices.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 203250 [May 19 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/05/19 08:45:00 #28204055
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected, bases: 2026/05/19 09:18:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5



On 19/05/2026 12:49, Stefano Garzarella wrote:
> On Tue, May 19, 2026 at 09:37:23AM +0300, Arseniy Krasnov wrote:
>> On 18/05/2026 14:08, Stefano Garzarella wrote:
>>> On Mon, May 18, 2026 at 11:50:05AM +0100, David Laight wrote:
>>>> On Mon, 18 May 2026 11:54:19 +0200
>>>> Stefano Garzarella <sgarzare@redhat.com> wrote:
> 
> [...]
> 
>>
>> Hi guys! Just some replies after quick look:
>>
>>>>> >> > Surely that block should only be done if can_zcopy is true?
>>
>> I guess no, since TCP also allocates uarg even if zerocopy is impossible -
>> it just sets uarg_to_msgzc(uarg)->zerocopy = 0;
>>
>>>>> >> > And shouldn't something unset it if info->op != VIRTIO_VSOCK_OP_RW ?
>>
>> Hm, we can't enter block 'if (info->msg) {' when 'info->op' is not equal to 'VIRTIO_VSOCK_OP_RW',
>> because 'msg' is not NULL only for 'VIRTIO_VSOCK_OP_RW'. But anyway You point to right thing - check for
>> 'VIRTIO_VSOCK_OP_RW' could be removed here. Just with comment why.
>>
>>>>> >> > If the msg_zerocopy_realloc() fails then can't you just set can_zcopy to false.
>>
>> Here I guess it is better to follow TCP way to make same behaviour, because exact
>> logic for MSG_ZEROCOPY is not documented. TCP also returns error and stops tx loop.
>>
>>>>> >> >
>>>>> >> > It info->msg->msg_buf is already set then I think you have to disable zero-copy.
>>>>> >> > The caller has already requested a callback - and you can't add another.
>>
>> In TCP implementation if 'msg_ubuf' is set they just use it and check for zerocopy in
>> the same way as 'msg_ubuf' is NULL.
>>
>>>>> >> >
>>>>> >> > In any case by the end of this can_zcopy and have_uref are really the same flag.
>>>>> >>
>>
>> Need to check it more. But 'can_zcopy' means that we fill frags in skb, have_uref means that we
>> allocated completion (but it could be reported with not set 'SO_EE_CODE_ZEROCOPY_COPIED' if
>> 'can_zcopy' was false).
>>
>>
>> @Stefano, I guess current implementation differs from TCP in two cases (at least from first
>> view):
>> 1) When 'msg_ubuf' is set: in TCP, already set 'msg_ubuf' is passed to 'skb_zerocopy_iter_stream()'
>>   (if zerocopy is possible) where it is used as in vsock in call 'skb_zcopy_set()'. In vsock case if
>>   'msg_ubuf' is not NULL we will pass just NULL to 'skb_zcopy_set()'. Yes this is will be
>>   no-effect call today (due to checks in 'skb_zcopy_set()'), but anyway - in future may be not.
>> 2) Also i see that 'skb_zerocopy_iter_stream()' in TCP version has some extra checks which are
>>   missed in vsock - we only just call '__zerocopy_sg_from_iter()' to fill skb in zerocopy way.
>>
>> But, I think, instead of trying to compare vsock and TCP versions best way is to just copy
>> current TCP flow as close as possible:
>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/net/ipv4/tcp.c#n1144
>> 1) Use same flow of checks for 'msg_flags', 'msg_ubuf', SOCK_ZEROCOPY etc.
>> 2) To copy data we can use 'skb_zerocopy_iter_stream()'.
>> 3) The only thing that we don't need in vsock is dev mem related code from TCP implementation.
>>
>> I can take this task, but pls need some time - may be two/three weeks due to another tasks.
>>
>> What do You think?
> 
> If you can work on it, please go head. They seems all pre-existing, so 2/3 weeks are fine. Please let me know if you can't and I'll try to allocate some time.

No problem I'll take it. If something goes wrong or stuck - i'll let you know

Thanks

> 
> Thanks for the help!
> 
> Stefano
> 


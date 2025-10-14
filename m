Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6039327280E
	for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 06:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424477; cv=none; b=HRScPshSue9laRhpsk32j9JLGakdEy2HcveQJnkwcFDMtA11nB/sVbTdX2p9c2ycHIcCoGSP/TOhzxTNdieUuLJvVxaHxIbUcaftpU5OTz5YVECJT9i5AHcaBVF86ptPymSPjsM0+TT+DdoO3MajWA2HAr0TA8XMwUP4+5cH3Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424477; c=relaxed/simple;
	bh=T0wMiqSGwmsqLWJtb2GwPRS4IxEUHW2oFQEZ+rO9EU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPNiQw3lnmv4wXEXVNa+6g9ysUwGNZEJHc+Hu6ocggXnd9H4UJ2yi1ckW/0xQfz48sB9SJCdYh74r5VzSilzCr1wSzwojWTVxiQoe0F8qfrepLPz3pS/Wcls9TbBL3w5rWhCf0nQWmAGIxPs7TiNn9fygO8zcohj+MKXD6Amo18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aCRvgqMe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCRvgqMe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760424475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HrRglR29VgZ69mKZr7Dx3Gx+zA5R/Z6gBu9e7njrIMA=;
	b=aCRvgqMezeprUYEyrrwhxniYL3N36C8gVg6r90oImwY0Ym+FMgn4gcXQEmQMasVEwtzAgx
	Ky3qXSz7X/R1erZP6OWz0F8t3GErXj+dacrJ20/s4BjkfUFyqNB1Ar6eZD2KYUOSJNQXRT
	L8Tw0jbauQ9mPS+uPuYTLRHB5z/6i5U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-W1ZbE2-eOWiDUV_1rh_XQQ-1; Tue, 14 Oct 2025 02:47:53 -0400
X-MC-Unique: W1ZbE2-eOWiDUV_1rh_XQQ-1
X-Mimecast-MFC-AGG-ID: W1ZbE2-eOWiDUV_1rh_XQQ_1760424473
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ece14b9231so4301502f8f.0
        for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 23:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760424472; x=1761029272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HrRglR29VgZ69mKZr7Dx3Gx+zA5R/Z6gBu9e7njrIMA=;
        b=ZQcqrDt3sz7kL2ccCYt/k/PrFgymt2FsXgLIqZjMkgXKxFVy5b2ppxSOl620cTRKxZ
         G/B46omH2ZtBlDaQoO/61GqiID6871ZxkA/Jva+6JccvZr68Y8vVuJ7NA8ME5xsPSsW4
         OXulyAx+28AXzF3rur1bfLSmBWqL/o1oIcTP0MtvI/87F1r9XCyUv7rj8a9iZU5T+Ouf
         LZ48IJ6dtMFOtHEdKLgg1jVZP3/ci14FLqgYGzSsfJ5F0IZvNqA2GUzBpm3mhO5hhM6I
         Z+tDzC45yU9IGBl/g2VshM1nkCTu5LVMfHtzgnGJJhb4217MAX9xHz0wIx8dHsMMt+u+
         OssQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtMBq/eOza2j3CLV47JuS0ICdTg11mZRLujn6qMwUNg0dE+I3R9tkFe9+33O5J4JsAqRrmnk03U3Rbm3O/kQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlP0e2jxPQIW8hIDgDQqt2qggl5w6+5gGhN0sP7huQZCHN6o6d
	ONxtd6RB6lpcO8MzYTeg814wAKhMT6/yY10iAZn5TQGNyCZ+tjF7JyLr3tqLskPvmMeLeZybgwT
	0sqHEAWM7e1uc1+TZrrPp7u5YFhEouoZ/Vwqkzb0HXbhCx3oWxDq7GqQcZ6OEMtzOrwp4
X-Gm-Gg: ASbGnct/nfMVzgo4Cm547efv5x9S/8UIfTt1qt7IDbX1TxeSFvkxDOsFrIVJC8HOJ2V
	OjUj0BqeK0YumegYN3qibrRBHz/X9p0rpKjR0OGpTipJNueQzccJBE051ROxyGRSfQ/vYoKP4kO
	JLGbQWd13ZCtAZiQQ/oiz+NeWpWkSft95F7JlpVh7x+F/8QP/zzw4QKhzx36uUf1uUwD2VLwXiI
	q99ih6yWs+9OB5stQhdoLpV4FHamsn2lO0PjvflX26PGaa+Q/7BQnJ5Hz3UZQky9CHjlgU8psb9
	q4x5WG3rQbZgjqfQTlhZDgrv3NydVs6KczOgbrNhTqILRKmTwr0DyYXwfcGlbFC7znxwNEPsySu
	jwF83eY616LiQ
X-Received: by 2002:a05:6000:2601:b0:3ec:b899:bc39 with SMTP id ffacd0b85a97d-4266e8e9004mr15793131f8f.58.1760424472539;
        Mon, 13 Oct 2025 23:47:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5JBS5UabB7QBXlAcwMrnWLbumJrspsJwc1HLfqZTziEYqtV5mFLLmgXxo6U+XgcAZ2uXW5A==
X-Received: by 2002:a05:6000:2601:b0:3ec:b899:bc39 with SMTP id ffacd0b85a97d-4266e8e9004mr15793115f8f.58.1760424472129;
        Mon, 13 Oct 2025 23:47:52 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e81d2sm22202178f8f.49.2025.10.13.23.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 23:47:51 -0700 (PDT)
Message-ID: <376fd3de-eb27-48ce-bdd5-86b0bca85ba7@redhat.com>
Date: Tue, 14 Oct 2025 08:47:50 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [virt?] upstream test error: KMSAN: use-after-free in
 vring_map_one_sg
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 syzbot <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com>,
 eperezma@redhat.com, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev,
 xuanzhuo@linux.alibaba.com
References: <68e96ebf.050a0220.91a22.0177.GAE@google.com>
 <CACGkMEtnrayDWKFdJ1P22QyCrZuDK0C2LihhOtvhUyTOKSp_HQ@mail.gmail.com>
 <CACGkMEt0aJh1yAj+q1UNnXToLa_yGc9fT_HfeNptHsOQ7vXG+w@mail.gmail.com>
 <CACGkMEsh_j9wCAv-LwOVxLjvUzEuKuu+7ZGMGcdJr7ettdBYTQ@mail.gmail.com>
 <0f20cd6a-d9aa-4837-a120-1e2e7dbdc954@redhat.com>
 <20251013040810-mutt-send-email-mst@kernel.org>
 <3480dcc9-a41a-4ae6-960d-4a13eed359e2@redhat.com>
 <CACGkMEucE6c=50egk=Hryie2fxZaEjFt22mLX20+T=68rFLNnw@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEucE6c=50egk=Hryie2fxZaEjFt22mLX20+T=68rFLNnw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g211NEe9q6aSw0I9PWCuQT2g8upTBZpBsRfqq5BTT7c_1760424473
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/14/25 4:41 AM, Jason Wang wrote:
> On Mon, Oct 13, 2025 at 4:17 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 10/13/25 10:08 AM, Michael S. Tsirkin wrote:
>>> On Mon, Oct 13, 2025 at 09:37:29AM +0200, Paolo Abeni wrote:
>>>> On 10/13/25 9:20 AM, Jason Wang wrote:
>>>>> On Mon, Oct 13, 2025 at 1:29 PM Jason Wang <jasowang@redhat.com> wrote:
>>>>>> On Sat, Oct 11, 2025 at 3:40 PM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>
>>>>>>> #syz test
>>>>>>>
>>>>>>> On Sat, Oct 11, 2025 at 4:38 AM syzbot
>>>>>>> <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com> wrote:
>>>>>>
>>>>>> Paolo, it looks like the GSO tunnel features will leave uninitialized
>>>>>> vnet header field which trigger KMSAN warning.
>>>>>>
>>>>>> Please have a look at the patch (which has been tested by syzbot) or
>>>>>> propose another one.
>>>>>
>>>>> Forget the attachment.
>>>>
>>>> I have a few questions. The report mentions both UaF and uninit; the
>>>> patch addresses "just" the uninit access. It's not clear to me if and
>>>> how the UaF is addressed, and why/if it's related to the uninit access.
>>>
>>> I'd like to understand that, too.
>>
>> Somewhat related: the syzbot dashboard reports that the issue is no more
>> reproducible on plain Linus' tree:
>>
>> https://syzkaller.appspot.com/bug?extid=ac856b8b866cca41352c
> 
> Interesting.
> 
>>
>> """
>> * repros no longer work on HEAD.
>> """
>>
>> Possibly there was some external problem?
> 
> I think at least we need to make sure no information as we did in
> virtio_net_hdr_from_skb():
> 
> static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>                                           struct virtio_net_hdr *hdr,
>                                           bool little_endian,
>                                           bool has_data_valid,
>                                           int vlan_hlen)
> {
>         memset(hdr, 0, sizeof(*hdr));   /* no info leak */

I agree it makes sense to fully initialize the
virtio_net_hdr_v1_hash_tunnel struct. I would prefer to individually
zero the related fields (as in your initial patch). Hopefully the
compiler is smart enough to generate a single 64bit store instruction.

Still the backtrace reported by syzbot makes little sense to me: "uninit
created" at skb free time?!? UaF ?!? I suggest avoiding explicitly
marking the syzbot report closed with the formal patch.

Thanks,

Paolo



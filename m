Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7E3A5E98
	for <virtualization@lists.linux.dev>; Fri,  8 May 2026 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778232407; cv=none; b=qKBryZ6dqHAElOnbVYVITr62hQ8RLgvmeus4ttaJ1cuSva7F6xKTtijqjx/7U7ACKR8TxjgcnFaUpp9yOTRExwYhtpBCkUoujchj6pOtAqkn0dcF1Hbm9m2cuMq1lRf2LzbVPvf8zVeI4qKrsdvzrfVQQV6kLtR1ZMSyRZYQBZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778232407; c=relaxed/simple;
	bh=dFpHflt42hNwpcFXetPq0ce3vtQOlld7tM+YE9V2C4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HJViY2HwJda13ef8nUPqhLP5sGc38kO+B/4q4zP7yMSSApVuzOCMSvFRfeVf+2S19THw/PnF6aHczRpD0ALhawXF3xlCImQS0ZtzORnJ/i8Yu243W8qta5ic3wObfREL2V0Jk4DzdQACsvCyHFRutAHdvvgvDpy7oM5J0zop+Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EXkWz1Bg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXkWz1Bg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778232404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AAq8IYPWybCHpSWifDil8mvZspvdO1nQAax4s7IttiU=;
	b=EXkWz1BgBFazmJ7WlTCgdYGSPqGHPokhriqXWbHdkrNjW+ipMB7DG1V6FICPXsSNwz0uEe
	p80Xbe1vlsrbN78H1uEmncVdm1rQm8d/JsOWlA+Vmf0PN//Ct+upgOEtnbX8/mY4Bggtx4
	9blJsTdH3RmOi8UxyhWccHHcVeZLvQo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-qoFBEh3mP3u-Wr8FNfLpsQ-1; Fri, 08 May 2026 05:26:43 -0400
X-MC-Unique: qoFBEh3mP3u-Wr8FNfLpsQ-1
X-Mimecast-MFC-AGG-ID: qoFBEh3mP3u-Wr8FNfLpsQ_1778232402
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4470d6d2a4fso1796487f8f.1
        for <virtualization@lists.linux.dev>; Fri, 08 May 2026 02:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778232402; x=1778837202;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AAq8IYPWybCHpSWifDil8mvZspvdO1nQAax4s7IttiU=;
        b=XET8ktMSgM8y5GrGw102Y4yDiuHzkqWFN1ZrE+vbHlw4JoILuz9cJDqbSOpqasDA6U
         dE/L5F4zAUj2QKjoxMmMbOME9klPSHrGnVo2X9aQuwCjFuJJ7xW9arAtURBMUeatfYeT
         fRGbdpJ+SvSJ/u7i2aAYTHBSwpQDrqtD2uywsnsm+lzo3kZ+w+cvL6nSbJN3eZsfqMS6
         WxSzHKYomj/zJivfMbfE0ZwWvcoVdtr7AC/qTDNG+Zo3VDjoqv5gyPrMjyr/fuH4uQlH
         7mDRoVPOrQGBeE+wCM2i8NRi79WMDJXYo0Epe7dSroznVQYQTFb1+MZTd4qPVERU/6Bx
         izOg==
X-Forwarded-Encrypted: i=1; AFNElJ/qNndXnRAeuUmyeXRfUnQ+G7JD7Co83cZ4eWVnnoD0eoYRl0X/+CFts9gZdlnOhdJKIn7/JXG3bljuGppAVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhugVNhyHu3kQcqbJiNcuiGhoKoO0dpSCKuPUADkRgw+oV9NvM
	o80TeLUlKQJKnvSg+tikzk2Jx1/R0zHy2za04Bh4tLoOPiZVNW2KOFRoOLShV/6ShJI/tBAjF1d
	yZnH8068bOErpj8aormRYeC7ghQjBX4HHyrJcAK3KANSKPXbX69N0kEf8ufDjxiLyIRvG
X-Gm-Gg: Acq92OHv36+3KuAj/QUncLkvuYdW71MuheQ898aQa+bLybr13iZ4O4dbSeQmuv6UUzh
	mDw2zdbwX26VmVka2bz8nJWrg4RWYwOaqOowmD8ezpvzvQ/alPEXE//mMbuSqhvrO3VwlOOoclJ
	82z0e3b3jhila9ww1UXgSIGT0RP0FqsRSEMxU7nN2r8FHLSTgWKoGCvie64crc/qEgAec+RwnN/
	2RLd47BZG0H8h79NxZJYYd6iGWOH1dF0MgpGKwyXsUejONejBegN/3Obcl6eQgxi/ktfk9uvab9
	SBjUk42ZosMlE/Hmb5b9/Tpnztd7xAT44fWBA8EuNI47Kv5yDOmyvuGJ/vCS3S/BTPyOnaURkEd
	9PGSmF6RSZg4gD6INDa9XSfVG8pYRpzhUL8yptg/TH6WDwptFQ42zqLrdhfzvLvQ=
X-Received: by 2002:a05:6000:2403:b0:43f:e9ee:5610 with SMTP id ffacd0b85a97d-4515df65daamr18435808f8f.43.1778232402118;
        Fri, 08 May 2026 02:26:42 -0700 (PDT)
X-Received: by 2002:a05:6000:2403:b0:43f:e9ee:5610 with SMTP id ffacd0b85a97d-4515df65daamr18435739f8f.43.1778232401549;
        Fri, 08 May 2026 02:26:41 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6b071sm2967434f8f.14.2026.05.08.02.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:26:40 -0700 (PDT)
Date: Fri, 8 May 2026 11:26:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <af2sHIO-9-wvmVxe@sgarzare-redhat>
References: <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
 <20260506113554-mutt-send-email-mst@kernel.org>
 <afxVH2So9BbZ3Gta@sgarzare-redhat>
 <20260507074113-mutt-send-email-mst@kernel.org>
 <afyMCyBvZpzWrLtO@sgarzare-redhat>
 <20260507073340.0604667d@kernel.org>
 <afyy9CeniTBF3o2I@sgarzare-redhat>
 <CANn89iJ+qOFPSUACvda7djOVKGM8t+FfwdA5Ymjxe+g_tJtmnA@mail.gmail.com>
 <20260507101805.6c3335d0@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260507101805.6c3335d0@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IiC6G2-NZeXroUyp-coifiTtS9GWhOx3oc4GPtt1_Iw_1778232402
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, May 07, 2026 at 10:18:05AM -0700, Jakub Kicinski wrote:
>On Thu, 7 May 2026 09:32:24 -0700 Eric Dumazet wrote:
>> On Thu, May 7, 2026 at 9:05 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> > On Thu, May 07, 2026 at 07:33:40AM -0700, Jakub Kicinski wrote:
>> > >We can revert if you think that the risk of regression is high..
>> > >Please LMK soon, we can do it before patch reaches Linus.
>> >
>> > Some tests in tools/testing/vsock/vsock_test.c are failing with this
>> > patch applied.
>> >
>> > Test 18 are failing sometime in this way (I guess because we are
>> > dropping packets):
>> >
>> > 18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
>> >
>> > Test 22 is failing 100% in this way:
>> >
>> > 22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
>> > Resource temporarily unavailable
>> >
>> >
>> > With my followup patch adding also advertisement to the other peer
>> > (still draft locally, waiting for Michael proposal) I saw 22 failing,
>> > because tests expects that can use the entire buf_alloc, but now we are
>> > reducing it.  So IMO we should do like in `__sock_set_rcvbuf()` and
>> > double the buffer size, or at least digest an overhead equal to the
>> > buffer size set by the user via SO_VM_SOCKETS_BUFFER_SIZE (yeah,
>> > AF_VSOCK has it owns sockopt since the beginning :-().
>> >
>> > With that approach tests are passing, but I'd like to stress a bit more
>> > that patch. I'll send it tomorrow as fixup of this patch, or if you
>> > prefer to revert, I'll send as standalone.
>>
>> A plain revert is a big issue, now users now how to crash hypervisors.
>>
>> This vulnerability allows a compromised guest (controlling
>> virtio_vsock_hdr fields)
>> to continuously flood the host's vsock receive queue without
>> triggering any memory
>>  accounting limits or reader wakeups, resulting in unbounded host
>> kernel memory consumption (Host DoS via OOM).
>>
>> A vulnerability where a KVM guest can crash or deadlock its host is
>> classified as a KVM DoS.
>>
>> Am I missing something?
>
>Alright, let's leave it.
>

I posted a potential fixup: 
https://lore.kernel.org/netdev/20260508092330.69690-1-sgarzare@redhat.com/

Thanks,
Stefano


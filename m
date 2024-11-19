Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E277219D07A
	for <virtualization@lists.linux.dev>; Tue, 19 Nov 2024 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732005006; cv=none; b=cmnUL8mxi0GIRM82tBCIvgA1Dg5J0GbPyKedw7F5taXmaVtIOj0PQhjBDFGCUp7uoxjcLMMmL/ijTjtTXNYHMwqi4WdV13lxH5Jca2y0U690Rntj8iO3qSc8qnHmO1rFbonTSYsiWNmUtLKDuVAREzX82/sDSiM9W3uoY9awy7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732005006; c=relaxed/simple;
	bh=+xKCrPwQVHWM0r18FvOpIwNqva/kAUIiweoFAE7ZwzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SIAA9odjz8uTmWodOg3lZy6H12GotjZt78lkQ78+NMqMWFRIzVh2+fQGrVNFrOtESyNAcSKrlHJkzlyKsX2nzw6jLTXtSfy5BiyjDxXcc19QAZ+GKIhfCfqbUId+DrPJUuQVmsIzS9asayjm1blnYDu6bwn1wyiEgklNNC2m9jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GGTtAHDG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGTtAHDG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732005002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xTLxAWYQ1JNcTU0UUWCX6oUrShuLfa8MUCD9ctjzgKA=;
	b=GGTtAHDGoa4//IKKyRRDqxZ1KbJ6UnluMRm/sPuc0S2gq1cwPRT8PWChHW8MXxwuwIVE9l
	yx6g8cO+ZxtBHMrkM+CxoE52UtPTTOXZEKJH8F2nzK53tRlWXMdQ5FrTGc+jr1xZv4zirc
	D1SB5sifdJKJsPLOdOUeJq8fxSF4APs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-E0HI7416N3mKzFxJMz9cfw-1; Tue, 19 Nov 2024 03:30:01 -0500
X-MC-Unique: E0HI7416N3mKzFxJMz9cfw-1
X-Mimecast-MFC-AGG-ID: E0HI7416N3mKzFxJMz9cfw
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a99f43c4c7bso38128666b.0
        for <virtualization@lists.linux.dev>; Tue, 19 Nov 2024 00:30:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732005000; x=1732609800;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTLxAWYQ1JNcTU0UUWCX6oUrShuLfa8MUCD9ctjzgKA=;
        b=PrqVfTXixihaSkKHFv+8+FcJCEsRN8Ctx7TMUq0Q56ZhPpxsTQyNyNsNrXweY6x/Is
         Bu0RhIl6Y8dv5lQIRiYZR0mYfkiMzpcd+4EEViuD+TX6CYbhyAY98NCxbE6nbv4ga4j3
         DRBe0kfW2XweALUcgNg/N6sxkvia3HY3KWdd9BS05t4mtAgyDgfexRyAcSjpuXSatd+d
         er4g6fADNSUlOgcLAJqjJX2wbuzrIE1n+84ykPJoAyd2/mGqPE7CT9UqLk9/liSubgde
         G2oSioxdWp11gnjzWRjDmZ2/AaNUi/N9AI7RvZG7ZMQNCNvjXLj5lBNuqTVJRbmV1HuR
         BalA==
X-Forwarded-Encrypted: i=1; AJvYcCUApC/hdoG/O2xMdcVzLg9pYxBVsHUkQFO+iNSy2gggBR7Z8OTUI+bpq0pU1nkq3S7wogA1VUtP40FBSQGcwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqWuo5UdMWQHLvYjHuQf7ENbYYxRDdShtiQAH78FcerZ7ziO71
	ets4otNg3r325rO38RmA4s26xNbyKbHqxT9SwfB6MqVCcsOP7jcq6+nn0rhWgwaaxiVil/iMeUb
	EeEk4ujOdHv15LFsVYG156L7RBNUf+pUqRimNiyWA7tCO7rrOAcKv/c/E+7P/3loT
X-Received: by 2002:a17:907:d19:b0:a9e:b5d0:4ab7 with SMTP id a640c23a62f3a-aa483556727mr1382681566b.52.1732005000128;
        Tue, 19 Nov 2024 00:30:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxd7z957UsxaATiVx0EDfbn0BFQH51aHLzQfor6HWy4iT3aPDneL8plKb/5vnwG3RSEd0qgw==
X-Received: by 2002:a17:907:d19:b0:a9e:b5d0:4ab7 with SMTP id a640c23a62f3a-aa483556727mr1382676566b.52.1732004999357;
        Tue, 19 Nov 2024 00:29:59 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-129.retail.telecomitalia.it. [79.46.200.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df4e7bfsm624064866b.42.2024.11.19.00.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 00:29:58 -0800 (PST)
Date: Tue, 19 Nov 2024 09:29:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexander Graf <graf@amazon.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, Asias He <asias@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] vsock/virtio: Remove queued_replies pushback logic
Message-ID: <efsbknrsmen47tlay7cjrbo5qvmu4bcrmi2lvploi6qq5wpwet@wuu5mfgc3a34>
References: <20241115103016.86461-1-graf@amazon.com>
 <yjhfe5bsnfpqbnibxl2urrnuowzitxnrbodlihz4y5csig7e7p@drgxxxxgokfo>
 <dca2f6ff-b586-461d-936d-e0b9edbe7642@amazon.com>
 <CAGxU2F6eJA+vpYVbE0HNW794pF6wLL+o=92NYMQVvmFWnpNPaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAGxU2F6eJA+vpYVbE0HNW794pF6wLL+o=92NYMQVvmFWnpNPaA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UqQMHQoQUaDfhkZV2Q20loHY-3leCh_c9lS8wJXmQaY_1732005000
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Nov 18, 2024 at 03:07:43PM +0100, Stefano Garzarella wrote:
>On Fri, Nov 15, 2024 at 4:49 PM Alexander Graf <graf@amazon.com> wrote:
>>
>> Hi Stefano,
>>
>> On 15.11.24 12:59, Stefano Garzarella wrote:
>> >
>> > On Fri, Nov 15, 2024 at 10:30:16AM +0000, Alexander Graf wrote:
>> >> Ever since the introduction of the virtio vsock driver, it included
>> >> pushback logic that blocks it from taking any new RX packets until the
>> >> TX queue backlog becomes shallower than the virtqueue size.
>> >>
>> >> This logic works fine when you connect a user space application on the
>> >> hypervisor with a virtio-vsock target, because the guest will stop
>> >> receiving data until the host pulled all outstanding data from the VM.
>> >
>> > So, why not skipping this only when talking with a sibling VM?
>>
>>
>> I don't think there is a way to know, is there?
>>
>
>I thought about looking into the header and check the dst_cid.
>If it's > VMADDR_CID_HOST, we are talking with a sibling VM.
>
>>
>> >
>> >>
>> >> With Nitro Enclaves however, we connect 2 VMs directly via vsock:
>> >>
>> >>  Parent      Enclave
>> >>
>> >>    RX -------- TX
>> >>    TX -------- RX
>> >>
>> >> This means we now have 2 virtio-vsock backends that both have the
>> >> pushback
>> >> logic. If the parent's TX queue runs full at the same time as the
>> >> Enclave's, both virtio-vsock drivers fall into the pushback path and
>> >> no longer accept RX traffic. However, that RX traffic is TX traffic on
>> >> the other side which blocks that driver from making any forward
>> >> progress. We're not in a deadlock.
>> >>
>> >> To resolve this, let's remove that pushback logic altogether and rely on
>> >> higher levels (like credits) to ensure we do not consume unbounded
>> >> memory.
>> >
>> > I spoke quickly with Stefan who has been following the development from
>> > the beginning and actually pointed out that there might be problems
>> > with the control packets, since credits only covers data packets, so
>> > it doesn't seem like a good idea remove this mechanism completely.
>>
>>
>> Can you help me understand which situations the current mechanism really
>> helps with, so we can look at alternatives?
>
>Good question!
>I didn't participate in the initial development, so what I'm telling
>you is my understanding.
>@Stefan feel free to correct me!
>
>The driver uses a single workqueue (virtio_vsock_workqueue) where it
>queues several workers. The ones we are interested in are:
>1. the one to handle avail buffers in the TX virtqueue (send_pkt_work)
>2. the one for used buffers in the RX virtqueue (rx_work)
>
>Assuming that the same kthread executes the different workers, it
>seems to be more about making sure that the RX worker (i.e. rx_work)
>does not consume all the execution time, leaving no room for TX
>(send_pkt_work). Especially when there are a lot of messages queued in
>the TX queue that are considered as response for the host. (The
>threshold seems to be the size of the virtqueue).
>
>That said, perhaps just adopting a technique like the one in vhost
>(byte_weight in vhost_dev_init(), vhost_exceeds_weight(), etc.) where
>after a certain number of packets/bytes handled, the worker terminates
>its work and reschedules, could give us the same guarantees, in a
>simpler way.

Thinking more about, perhaps now I understand better why it was
introduced, and it should be related to the above.

In practice, "replies" are almost always queued in the intermediate
queue (send_pkt_queue) directly by the RX worker (rx_work) during its
execution. These are direct responses handled by
virtio_transport_recv_pkt() to requests coming from the other peer (the
host usually or sibling VM in your case). This happens for example
calling virtio_transport_reset_no_sock() if a socket is not found, or
sending back VIRTIO_VSOCK_OP_RESPONSE packet to ack a request of a
connection coming with a VIRTIO_VSOCK_OP_REQUEST packet.

Because of this, if the number of these "replies" exceeds an arbitrary
threshold, the RX worker decides to de-schedule itself, to give space to
the TX worker (send_pkt_work) to move those "replies" from the
intermediate queue into the TX virtqueue, at which point the TX worker
will reschedule the RX worker to continue the job. So more than avoiding
deadlock, it seems to be a mechanism to avoid starvation.

Note that this is not necessary in vhost-vsock (which uses the same
functions as this driver, e.g. virtio_transport_recv_pkt), because both
workers already use vhost_exceeds_weight() to avoid this problem as
well.

At this point I think that doing something similar to vhost here as well
would allow us not only to avoid the problem that `queued_replies`
should avoid, but also that the RX worker monopolizes the workqueue
during data transfer.

Thanks,
Stefano

>
>>
>>
>> >
>> >>
>> >> Fixes: 0ea9e1d3a9e3 ("VSOCK: Introduce virtio_transport.ko")
>> >
>> > I'm not sure we should add this Fixes tag, this seems very risky
>> > backporting on stable branches IMHO.
>>
>>
>> Which situations do you believe it will genuinely break anything in?
>
>The situation for which it was introduced (which I don't know
>precisely because I wasn't following vsock yet).
>Removing it completely without being sure that what it was developed
>for is okay is risky to me.
>
>Support for sibling VMs has only recently been introduced, so I'd be
>happier making these changes just for that kind of communication.
>
>That said, the idea of doing like vhost might solve all our problems,
>so in that case maybe it might be okay.
>
>> As
>> it stands today, if you run upstream parent and enclave and hammer them
>> with vsock traffic, you get into a deadlock. Even without the flow
>> control, you will never hit a deadlock. But you may get a brown-out like
>> situation while Linux is flushing its buffers.
>>
>> Ideally we want to have actual flow control to mitigate the problem
>> altogether. But I'm not quite sure how and where. Just blocking all
>> receiving traffic causes problems.
>>
>>
>> > If we cannot find a better mechanism to replace this with something
>> > that works both guest <-> host and guest <-> guest, I would prefer
>> > to do this just for guest <-> guest communication.
>> > Because removing this completely seems too risky for me, at least
>> > without a proof that control packets are fine.
>>
>>
>> So your concern is that control packets would not receive pushback, so
>> we would allow unbounded traffic to get queued up?
>
>Right, most of `reply` are control packets (reset and response IIUC)
>that are not part of the credit mechanism, so I think this confirms
>what Stefan was telling me.
>
>> Can you suggest
>> options to help with that?
>
>Maybe mimic vhost approach should help, or something similar.
>
>That said, did you really encounter a real problem or is it more of a
>patch to avoid future problems.
>
>Because it would be nice to have a test that emphasizes this problem
>that we can use to check that everything is okay if we adopt something
>different. The same goes for the problem that this mechanism wants to
>avoid, I'll try to see if I have time to write a test so we can use
>it.
>
>
>Thanks,
>Stefano


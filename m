Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0FF2586D8
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Feb 2025 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739206354; cv=none; b=ibr8Un9r7SHeqVwNZuVBI4PY9zMO0BiSendqT2u5WfZh+j3A+mO/j4YUPRuKCmoxI05c8tYKJeBd2zOBOkITEzFdOHEjS3I1dDv/C2XT0JXLdDvUaa8Ka6xD6Jqw/MMmDSA1ryLhWwsfdtfMEA2ELZcE9aQ5OorBznzwQZbasg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739206354; c=relaxed/simple;
	bh=0D7FejxdMSdNwq4d8Iw/FTH+8Vh58GxW2QYBqWIyCxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DJScs8Tgsv0KoZDLlTc1LNBwUnZ2v5OJ3e2uJP5z9hj1sdqLXz5GI5f9f1nPOV+edLGiWQqf+cN/oXr3g3f6U11SnknTB+qiKzQflImq1oEayqvPkZj8ifveE4jA9waOIGe9wE4mRaNUiLXhMWI6ANorx/1XCdL3eRXLy6FvZvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gvlJLmSY; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvlJLmSY"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9E20405AD
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Feb 2025 16:52:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3zTULao1VW8Q for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Feb 2025 16:52:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B0AFD4054E
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B0AFD4054E
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gvlJLmSY
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B0AFD4054E
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Feb 2025 16:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739206350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jobaAwA+Fk2dqvWn152x6BfQDd/w8Mf+7rUPoxAJHww=;
	b=gvlJLmSYOOvN0BcOAlILD4mv/+VhDydJ/G8VwTRXCqZUlkKNFKhTiT7wsljXyAsZ9O+iuj
	H8+ThSoNzST1P6Kjiqg4ouAOx1HJTzM3dzzlYsXbmBB2j80a/Gco47KFxsn3fU4taXjKD3
	V+iDj01+jtUiB6UuAzvGoimiATUOsVU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-CdwMDlXiNeKb1Of-JfJ7GQ-1; Mon, 10 Feb 2025 11:52:29 -0500
X-MC-Unique: CdwMDlXiNeKb1Of-JfJ7GQ-1
X-Mimecast-MFC-AGG-ID: CdwMDlXiNeKb1Of-JfJ7GQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43947979ce8so4925355e9.0
        for <virtualization@lists.linux-foundation.org>; Mon, 10 Feb 2025 08:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739206347; x=1739811147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jobaAwA+Fk2dqvWn152x6BfQDd/w8Mf+7rUPoxAJHww=;
        b=ToCZqQ4U8bRBsypwV9icSVfR65+btVb7Chekv+ZLWYEUihwaVK6DHrEE0Q56Q1C9bi
         mnO4mMZjXkJ98XpbYVz3tUaAD69U2EV4F+h7VMz4obj+4jwDDb6CrnIs9xKgiPEs7/PG
         6bFOQZaAnkTDu6dE6l0lWitOY1RwTo3JMQMhy2b2vFTsIKLo76D5vaOK0Hc3bm/5FKv8
         HswPlYjl+EvcZ1lXN9SuNiPp5WH4oGNeN6jTxTJz/7Syyct6hudtit11O509F6PdsrHg
         YAmh5ytSxGsNECOOopEu7v8A6K+ozvirtnzbx+5GAh5Sz9qyHlQ0Cm+c0kiZwI9UWks8
         Q8ow==
X-Forwarded-Encrypted: i=1; AJvYcCVUO7oBwkZnJ3uliiqR1z3Du0B7KmSetcV2CwR0lebPrK0PPfLxXFgq34/kHLOuPcpiK9iHi/I+IYynNmCqDg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yyy27ztTK0EAD6G2HM8q8BRT7a9wmZjIZk2L06Ny9fYVfC7f2ht
	QcDgLB7zHLDEDpSCUcSKSN9SyptDcW0tWshSzb8ca5u2dvokr6FxG7lZpX2Ul7OV323lrG1zZhO
	o5AUXo8pfUBlHoraYoNqk1+43pKiQXWqOZKvj9vsep3SVWw+ezN5N1I6aE9KWfUirvI8P+Ur+9F
	Su1vBcLwUaVjc=
X-Gm-Gg: ASbGncs1SGispdLs7BDC8LY86AVkemSl+sK6BAGqUN+ILIcxLqhBqf2rpiUCQSovNm8
	PlrWgceUqgktP+8VHITvIdRSzdDYavUTUQDfKjo+TPhnLfbV0nqq1Q247UkpuCEVQkXAyIQhyYe
	B+RT0Y9zG0aftgn+BM0X4QHRFhnJMsOzNsOYr59S5n0VOQQw/plDh8wmvsOt45/LEjvDcZ60AKK
	hKUE/nwF4dcnQfnR90BRMMicxQSX6l5EsRIuKkoJ8Fh0EXYpaFnFNmw3fmg3gYcFPLnhjbzOMHv
	ewlZr3+9SYbSJQI7DPecqQjZT65BWP2jkdZLNThuYZ7uJuLtIeT9Hw==
X-Received: by 2002:a05:600c:4589:b0:434:f609:1af7 with SMTP id 5b1f17b1804b1-4394c808849mr5820105e9.4.1739206347628;
        Mon, 10 Feb 2025 08:52:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzQ/jMNKz482G2FvYPl7tsnY56iQpM2aodBvtMBbJOao7+wP//TbIwcCW+7o1f40GNOhLyTA==
X-Received: by 2002:a05:600c:4589:b0:434:f609:1af7 with SMTP id 5b1f17b1804b1-4394c808849mr5819735e9.4.1739206346931;
        Mon, 10 Feb 2025 08:52:26 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcb88d5e6sm9636306f8f.1.2025.02.10.08.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:52:26 -0800 (PST)
Date: Mon, 10 Feb 2025 17:52:19 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: leonardi@redhat.com, Junnan Wu <junnan01.wu@samsung.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, mindong.zhao@samsung.com, 
	q1.huang@samsung.com, ying01.gao@samsung.com, ying123.xu@samsung.com
Subject: Re: [PATCH 2/2] vsock/virtio: Don't reset the created SOCKET during
 s2r
Message-ID: <iv6oalr6yuwsfkoxnorp4t77fdjheteyojauwf2phshucdxatf@ominy3hfcpxb>
References: <20250207052033.2222629-1-junnan01.wu@samsung.com>
 <CGME20250207051946epcas5p295a3f6455ad1dbd9658ed1bcf131ced5@epcas5p2.samsung.com>
 <20250207052033.2222629-2-junnan01.wu@samsung.com>
 <rnri3i5jues4rjgtb36purbjmct56u4m5e6swaqb3smevtlozw@ki7gdlbdbmve>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <rnri3i5jues4rjgtb36purbjmct56u4m5e6swaqb3smevtlozw@ki7gdlbdbmve>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AScUnnq7klf7R0mkacZXf-GAp_wdTHth3m4W4R1B4eg_1739206348
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Feb 10, 2025 at 12:48:03PM +0100, leonardi@redhat.com wrote:
>Like for the other patch, some maintainers have not been CCd.

Yes, please use `scripts/get_maintainer.pl`.

>
>On Fri, Feb 07, 2025 at 01:20:33PM +0800, Junnan Wu wrote:
>>From: Ying Gao <ying01.gao@samsung.com>
>>
>>If suspend is executed during vsock communication and the
>>socket is reset, the original socket will be unusable after resume.

Why? (I mean for a good commit description)

>>
>>Judge the value of vdev->priv in function virtio_vsock_vqs_del,
>>only when the function is invoked by virtio_vsock_remove,
>>all vsock connections will be reset.
>>
>The second part of the commit message is not that clear, do you mind 
>rephrasing it?

+1 on that

Also in this case, why checking `vdev->priv` fixes the issue?

>
>>Signed-off-by: Ying Gao <ying01.gao@samsung.com>
>Missing Co-developed-by?
>>Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>
>
>
>>---
>>net/vmw_vsock/virtio_transport.c | 6 ++++--
>>1 file changed, 4 insertions(+), 2 deletions(-)
>>
>>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>>index 9eefd0fba92b..9df609581755 100644
>>--- a/net/vmw_vsock/virtio_transport.c
>>+++ b/net/vmw_vsock/virtio_transport.c
>>@@ -717,8 +717,10 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
>>	struct sk_buff *skb;
>>
>>	/* Reset all connected sockets when the VQs disappear */
>>-	vsock_for_each_connected_socket(&virtio_transport.transport,
>>-					virtio_vsock_reset_sock);
>I would add a comment explaining why you are adding this check.

Yes, please.

>>+	if (!vdev->priv) {
>>+		vsock_for_each_connected_socket(&virtio_transport.transport,
>>+						virtio_vsock_reset_sock);
>>+	}

Okay, after looking at the code I understood why, but please write it 
into the commit next time!

virtio_vsock_vqs_del() is called in 2 cases:
1 - in virtio_vsock_remove() after setting `vdev->priv` to null since
     the drive is about to be unloaded because the device is for example
     removed (hot-unplug)

2 - in virtio_vsock_freeze() when suspending, but in this case
     `vdev->priv` is not touched.

I don't think is a good idea using that because in the future it could 
change. So better to add a parameter to virtio_vsock_vqs_del() to 
differentiate the 2 use cases.


That said, I think this patch is wrong:

We are deallocating virtqueues, so all packets that are "in flight" will 
be completely discarded. Our transport (virtqueues) has no mechanism to 
retransmit them, so those packets would be lost forever. So we cannot 
guarantee the reliability of SOCK_STREAM sockets for example.

In any case, after a suspension, many connections will be expired in the 
host anyway, so does it make sense to keep them open in the guest?

If you want to support this use case, you must first provide a way to 
keep those packets somewhere (e.g. avoiding to remove the virtqueues?), 
but I honestly don't understand the use case.

To be clear, this behavior is intended, and it's for example the same as 
when suspending the VM is the hypervisor directly, which after that, it 
sends an event to the guest, just to close all connections because it's 
complicated to keep them active.

Thanks,
Stefano

>>
>>	/* Stop all work handlers to make sure no one is accessing the device,
>>	 * so we can safely call virtio_reset_device().
>>-- 
>>2.34.1
>>
>
>I am not familiar with freeze/resume, but I don't see any problems 
>with this patch.
>
>Thank you,
>Luigi
>


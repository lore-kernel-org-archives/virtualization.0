Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFF61F03F3
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Feb 2025 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739262934; cv=none; b=e+w6cr9FYjiFwCEesdJONrdhRAzlqC28XHshiSZmFSS+223wyIT7dLwn7BEssbMq7BGrqzJ8muorj3BdNQ0IobQYJhOsEJa4hCyHImUA2CiNgrd21pLvW8sY0wp88G9nxWOUc6aWk8OfVG0tirJ8vLUgui4GdOaeeV6jtr/eopk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739262934; c=relaxed/simple;
	bh=V3QdcOzW5nRVAyJE8rvdfUKn5EoRfyLWiocy8q2n7EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Yx9CJiXneMEd56sHxCPUjk0+hUPnlOsBNMuHyLAlHtXJQQd5huiH2uAg4qyRlOymV8c+I3jq1yRLW3RoUoeSYiDOq0xXP124NeqLDa7OIFe2iBwGh7qbHxowNHp3+AAWnGW0d5Id9K5MQysksSSEw2NBvG/PAT0aLL49t5FkZ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GduRKtmK; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GduRKtmK"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35A0F60EB2
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Feb 2025 08:35:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xwLvlsBE33_q for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Feb 2025 08:35:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D1D6960EA2
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1D6960EA2
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GduRKtmK
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D1D6960EA2
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Feb 2025 08:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739262928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1hsPs51aQDhcKaZDqd2q3rCXtgips3jnz2T73sNW3XA=;
	b=GduRKtmK5w+++C7dAQhlQdM0BhHvgEDJxHKLKuaafYxFkGDIvJXT+Er1B+DZbNy5e/7hCV
	EQy6Ouzd0KX3HGOIoGS4dEVd5+1XXhyJo21bIYvdADV+SXZUPi9wwlKpi63fEYcL6d8JU5
	9iuqneD6PM0lcARf7uqDc6j52bucrek=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-yLItbqkkOfKvLXi99Zn6iw-1; Tue, 11 Feb 2025 03:35:27 -0500
X-MC-Unique: yLItbqkkOfKvLXi99Zn6iw-1
X-Mimecast-MFC-AGG-ID: yLItbqkkOfKvLXi99Zn6iw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38de0201875so824630f8f.0
        for <virtualization@lists.linux-foundation.org>; Tue, 11 Feb 2025 00:35:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739262926; x=1739867726;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hsPs51aQDhcKaZDqd2q3rCXtgips3jnz2T73sNW3XA=;
        b=iK957WraJoCtEksqb/JdOLkowMgkdG8u1zvMN23zkVP8+FAtRQJNv14iHBVFwZpiib
         0YU1Q+8NxYi7S9DaxmIah8rAL89Flg9Bf9XOzi0TS7FypOA4Ym3oQxEm1gXfJPkXiRVF
         ChnwK4AfFfk2B1/+wyd7Y90GpC5Iml99tYodKUu981qZ37TeCGWRO1JjRew7jx/TvEAb
         PW07g8e/59MRk3seFWjsOvNegFc9YovRH6X3Hj9hfV31wKRU9KOZ6MBK+G5YZ39KCJo+
         ERplcgWPT9WPd8U5BnLqV+xJ+Xgn9r2aqTKihObBP2nLnspZDo4vtDtjjPPV+KU0ZS9k
         mYqA==
X-Forwarded-Encrypted: i=1; AJvYcCXHRhSFBRO57X1pGHVdf+LHZhJptNt7++ytQK9q1kRTkFGo3ZkIgMEiI85dOHIZ+1w+jAjEOvXdlKodXRjCDA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YypYo9v1KmjnSe+bMa3zXShgKcGqKmJVsvKWKsWTUceQWwTdiOa
	zJXUojl+Cn+NMW57BJDN3MzlSxvUYkdI0w5t8v2CcHNytMdaqe/yg06Flixk5h9tnHxMGIuMB8A
	Wm19FGUzftUrSiQ8dvHlbcMR7SZ6bsyCwnC7j24ySpNZLGBJW4A2NIAlw5Tg5D12Af0dfnE6lg4
	EyZoU=
X-Gm-Gg: ASbGncuyJGhbFaMsNfI8RX7VLQDaRnkNYdhODAjOfgV1CNC+C//He+OLB6ivLRvfWRU
	qU7sbEn15Hz/KiX289GQBc+rx3VCq/4dcoXPQPlRO4+8ern7+YJ5Y8tBwsWKE2L9Me3fmYxmFbL
	Glm/g+WVz/Nkh+6d9GR4w6j/nhK3sLXnx6jlTqF9HlchUd9rNIiZ0KklNdkfgFSM/SUMzp1ym8w
	bbym6X4qiZLJsqtmhWIcxoHaaSE9og4DgG6DDAUpgZ224h6kGcykyB6tBPd1lPGvELR7+AEF1Hy
	sD/wEHYGcganHMJios9g9HgGVDHlZ9sujHWlZKQwTMDdjehXC3IY4w==
X-Received: by 2002:a05:6000:2aa:b0:38d:daf3:be60 with SMTP id ffacd0b85a97d-38ddaf3c056mr8384286f8f.48.1739262925804;
        Tue, 11 Feb 2025 00:35:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0lvwzRuDdX6uLk3DS1OFucOOxrT8iUXSo+t+JkMTiV38r5oDUEc5COqeJZJ8ONxqDPxhEWA==
X-Received: by 2002:a05:6000:2aa:b0:38d:daf3:be60 with SMTP id ffacd0b85a97d-38ddaf3c056mr8384236f8f.48.1739262925118;
        Tue, 11 Feb 2025 00:35:25 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d94d40csm203435315e9.9.2025.02.11.00.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:35:24 -0800 (PST)
Date: Tue, 11 Feb 2025 09:35:20 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: junnan01.wu@samsung.com
Cc: "leonardi@redhat.com" <leonardi@redhat.com>, 
	"stefanha@redhat.com" <stefanha@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	=?utf-8?B?6LW15rCR5qCL?= <mindong.zhao@samsung.com>, =?utf-8?B?6buE6Z2S?= <q1.huang@samsung.com>, 
	=?utf-8?B?6auY6Iux?= <ying01.gao@samsung.com>, =?utf-8?B?6K646I65?= <ying123.xu@samsung.com>, 
	=?utf-8?B?546L56OK?= <lei19.wang@samsung.com>
Subject: Re: Re: [PATCH 2/2] vsock/virtio: Don't reset the created SOCKET
 during s2r
Message-ID: <CAGxU2F6KYsAdedHVpopNz1vCMeduiy570_7LLysdKeBb74d9iw@mail.gmail.com>
References: <20250207052033.2222629-1-junnan01.wu@samsung.com>
 <20250207052033.2222629-2-junnan01.wu@samsung.com>
 <rnri3i5jues4rjgtb36purbjmct56u4m5e6swaqb3smevtlozw@ki7gdlbdbmve>
 <CGME20250207051946epcas5p295a3f6455ad1dbd9658ed1bcf131ced5@epcms5p5>
 <iv6oalr6yuwsfkoxnorp4t77fdjheteyojauwf2phshucdxatf@ominy3hfcpxb>
 <20250211052329epcms5p59e06212e74a6e54cefe0633661a4b0d3@epcms5p5>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250211052329epcms5p59e06212e74a6e54cefe0633661a4b0d3@epcms5p5>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YeevsFi1BGOiyBpkICmKGW2QUtuStdtyb3RwZHXGnMY_1739262926
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Please read the links we already shared with you!!!

No MIME, no links, no compression, no attachments. Just plain text

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#no-mime-no-links-no-compression-no-attachments-just-plain-text


On Tue, 11 Feb 2025 at 06:24, 吴俊南 <junnan01.wu@samsung.com> wrote:
>
> Hello leonardi  and  stefanha：
>
>     Thanks for your review. And I will add other maintainers CCd in 
>     next push. And I want to discuss more about the second patch.

Why are you sending a v2 if we didn't reach an agreement on the second 
patch?

>
>
>     Firstly, we think our scenarios are quite different.

These are the information that should be put in the commit description.
We are not oracles imagining scenarios....

> Our scenario is  virtio-vsock deployed in embeded environment, and 
> suspend to ram is for order to allow system run at low power 
> consumption. In this scenario, the AF_VSOCK socket is created by Guest 
> upper application and don't close after driver freeze. Once restore, 
> the connection which are communicating before will be failed. It will 
> cause that upper application based on vsock connect failed. In this 
> mode, guest haven't received the event to close all connections.  
> That's difference with you metioned.

I mentioned the second scenario just as an example.

>
>
>     Secondly, refer to socket based on virtio-net device, they don't 
>     close connected during freeze.
>
>     Here we did a test that:
>
>    Start iperf server based on virtio-net in Host.
>    Start iperf client based on virtio-net in Guest and keep 
>    communicating with server.
>    Suspend Guest
>    Resume Guest.
>
>     Here in virtio-net, the iperf communication is still working after 
>     these steps. But iperf based on vsock will fail. We think it 
>     should keep same reaction with virtio-net

I agree that it would be cool, but this patch is not the right way as I 
explained in the previous email.

virtio-net can easily discard packets because it's an ethernet device.
As I already explained, virtio-vsock guarantees ordering and delivery of 
packets via virtqueues, if these disappear, you have to add something on 
top that keeps track of undelivered packets.

>
>
>     Thirdly, accroding to virtio-spec, vsock facilitates data transfer 
>     between the guest and device without using the Ethernet or IP 
>     protocols.

What does this have to do with packet loss?
It simply says that vsock does not need a classic TCP/IP stack, but 
directly connects guest and host sockets via virtqueues.

>
>     Therefore we think packets lost is acceptable for it, and it is 
>     not necessary to keep those packet during suspend flow.

Where did you read that packet loss is acceptable?

From https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-4800006

  5.10.6.2 Addressing

  ...

  Currently stream and seqpacket sockets are supported. type is 1
  (VIRTIO_VSOCK_TYPE_STREAM) for stream socket types, and 2
  (VIRTIO_VSOCK_TYPE_SEQPACKET) for seqpacket socket types.

  #define VIRTIO_VSOCK_TYPE_STREAM    1
  #define VIRTIO_VSOCK_TYPE_SEQPACKET 2

  Stream sockets provide in-order, guaranteed, connection-oriented
  delivery without message boundaries. Seqpacket sockets provide
  in-order, guaranteed, connection-oriented delivery with message and
  record boundaries.


Please explain in the commit description how this change ensures the 
requirements of the specification: "in-order, guaranteed, 
connection-oriented delivery".

Thanks,
Stefano


>
>
>  Best Wish
>
> --------- Original Message ---------
>
> Sender : Stefano Garzarella <sgarzare@redhat.com>
>
> Date : 2025-02-11 00:52 (GMT+8)
>
> Title : Re: [PATCH 2/2] vsock/virtio: Don't reset the created SOCKET during s2r
>
>  
>
> On Mon, Feb 10, 2025 at 12:48:03PM +0100, leonardi@redhat.com wrote:
>
> >Like for the other patch, some maintainers have not been CCd.
>
>
> Yes, please use `scripts/get_maintainer.pl`.
>
>
> >
>
> >On Fri, Feb 07, 2025 at 01:20:33PM +0800, Junnan Wu wrote:
>
> >>From: Ying Gao <ying01.gao@samsung.com>
>
> >>
>
> >>If suspend is executed during vsock communication and the
>
> >>socket is reset, the original socket will be unusable after resume.
>
>
> Why? (I mean for a good commit description)
>
>
> >>
>
> >>Judge the value of vdev->priv in function virtio_vsock_vqs_del,
>
> >>only when the function is invoked by virtio_vsock_remove,
>
> >>all vsock connections will be reset.
>
> >>
>
> >The second part of the commit message is not that clear, do you mind
>
> >rephrasing it?
>
>
> +1 on that
>
>
> Also in this case, why checking `vdev->priv` fixes the issue?
>
>
> >
>
> >>Signed-off-by: Ying Gao <ying01.gao@samsung.com>
>
> >Missing Co-developed-by?
>
> >>Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>
>
> >
>
> >
>
> >>---
>
> >>net/vmw_vsock/virtio_transport.c | 6 ++++--
>
> >>1 file changed, 4 insertions(+), 2 deletions(-)
>
> >>
>
> >>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>
> >>index 9eefd0fba92b..9df609581755 100644
>
> >>--- a/net/vmw_vsock/virtio_transport.c
>
> >>+++ b/net/vmw_vsock/virtio_transport.c
>
> >>@@ -717,8 +717,10 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
>
> >>        struct sk_buff *skb;
>
> >>
>
> >>        /* Reset all connected sockets when the VQs disappear */
>
> >>-        vsock_for_each_connected_socket(&virtio_transport.transport,
>
> >>-                                        virtio_vsock_reset_sock);
>
> >I would add a comment explaining why you are adding this check.
>
>
> Yes, please.
>
>
> >>+        if (!vdev->priv) {
>
> >>+                vsock_for_each_connected_socket(&virtio_transport.transport,
>
> >>+                                                virtio_vsock_reset_sock);
>
> >>+        }
>
>
> Okay, after looking at the code I understood why, but please write it
>
> into the commit next time!
>
>
> virtio_vsock_vqs_del() is called in 2 cases:
>
> 1 - in virtio_vsock_remove() after setting `vdev->priv` to null since
>
>     the drive is about to be unloaded because the device is for example
>
>     removed (hot-unplug)
>
>
> 2 - in virtio_vsock_freeze() when suspending, but in this case
>
>     `vdev->priv` is not touched.
>
>
> I don't think is a good idea using that because in the future it could
>
> change. So better to add a parameter to virtio_vsock_vqs_del() to
>
> differentiate the 2 use cases.
>
>
>
> That said, I think this patch is wrong:
>
>
> We are deallocating virtqueues, so all packets that are "in flight" will
>
> be completely discarded. Our transport (virtqueues) has no mechanism to
>
> retransmit them, so those packets would be lost forever. So we cannot
>
> guarantee the reliability of SOCK_STREAM sockets for example.
>
>
> In any case, after a suspension, many connections will be expired in the
>
> host anyway, so does it make sense to keep them open in the guest?
>
>
> If you want to support this use case, you must first provide a way to
>
> keep those packets somewhere (e.g. avoiding to remove the virtqueues?),
>
> but I honestly don't understand the use case.
>
>
> To be clear, this behavior is intended, and it's for example the same as
>
> when suspending the VM is the hypervisor directly, which after that, it
>
> sends an event to the guest, just to close all connections because it's
>
> complicated to keep them active.
>
>
> Thanks,
>
> Stefano
>
>
> >>
>
> >>        /* Stop all work handlers to make sure no one is accessing the device,
>
> >>         * so we can safely call virtio_reset_device().
>
> >>--
>
> >>2.34.1
>
> >>
>
> >
>
> >I am not familiar with freeze/resume, but I don't see any problems
>
> >with this patch.
>
> >
>
> >Thank you,
>
> >Luigi
>
> >
>
>
>  
>
>  
>
>


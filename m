Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C19C7EE24
	for <virtualization@archiver.kernel.org>; Mon,  5 Jun 2023 08:23:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96F4C60804;
	Mon,  5 Jun 2023 08:23:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96F4C60804
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EP468ZgP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2mzVEUTseQjG; Mon,  5 Jun 2023 08:23:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0DA8D60BBE;
	Mon,  5 Jun 2023 08:23:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0DA8D60BBE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA833C007A;
	Mon,  5 Jun 2023 08:23:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 803FCC0029
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 08:23:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 47B6A403AA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 08:23:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47B6A403AA
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EP468ZgP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KyDzXUFYCzr9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 08:23:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8CD3740158
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8CD3740158
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 08:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685953401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=86ZFh5GA/RExUbbWyiQyYGG1RAfzp4GnwzXEclA8Onk=;
 b=EP468ZgPl7/58+tN0Fpe0PkBKZtgkHCT+NQEKLhX3Y2w5nbTKq6DE7IAidLo06SRWwvivY
 CocpdhpvqN6imKoo/Eyuv/JG+/D2rvtzliS0yC4gi7oqyOUi9CIb7zWH1ZZ2U1kH0SGyHE
 uLiboD8bb+x4Bt0RrFKkcNh2+LNQS7E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-Z2WgYvMRNRCcE0FYyhiQng-1; Mon, 05 Jun 2023 04:23:19 -0400
X-MC-Unique: Z2WgYvMRNRCcE0FYyhiQng-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f613f5d290so79563205e9.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jun 2023 01:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685953398; x=1688545398;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=86ZFh5GA/RExUbbWyiQyYGG1RAfzp4GnwzXEclA8Onk=;
 b=CLV8K7mmTIGZRlioix1RXL6B+Kf/BOrRsie8H+G9/YF/W/D0x7u1nxuHneJveMr3Qw
 b6cw8hzkSfX0Mna8VCxA7nV39Xh+i4XGucZDgEwpSLUzsl240iah4JHXY7vrBpQ2yAIo
 rM12+aeKNIkOFMSakz/vgUBl0QEnjeuH+R+nfAbDX+IpzYZgS5roH3+RYly7dTUSbCvM
 6QW+BE5ndEshOEZRBiDs3iD1/3iRLAlTKxhqAhWA2z+DUKHdOiZ/9yNE+gBtJ7i2Aw73
 /+AxNMheAboURC2ZI9jDO5zrnikUwd1bgtka2DCUeeLKAYkVe7a1qHqr0JTuku+q6kgF
 XkHw==
X-Gm-Message-State: AC+VfDwqRrIv8lMN+E1ybMbABDjvLl7umW7YHAffoOmthe643cpVbh8R
 /J6NvrkUBwvuUKDJKvBm1cDzZbKdyum+0FTMYEyOHcTCszvHMgCcAcqq5ZOmxTWAwvauaAMkFIK
 LNda020DBlAzF3b2RSYX3AskGxTk/vf8u4TovX3smmg==
X-Received: by 2002:a1c:4b07:0:b0:3f7:e58b:5898 with SMTP id
 y7-20020a1c4b07000000b003f7e58b5898mr882441wma.33.1685953398472; 
 Mon, 05 Jun 2023 01:23:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6hVUnkxH+oJQ5oRiCoXFpO2zFIJ+WKZK6BlZQOQyvptTL7dZg8WRGJTwHG8y88m8Yq1Ixktg==
X-Received: by 2002:a1c:4b07:0:b0:3f7:e58b:5898 with SMTP id
 y7-20020a1c4b07000000b003f7e58b5898mr882423wma.33.1685953398180; 
 Mon, 05 Jun 2023 01:23:18 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.94.106])
 by smtp.gmail.com with ESMTPSA id
 d24-20020a1c7318000000b003f18b942338sm10015504wmb.3.2023.06.05.01.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 01:23:17 -0700 (PDT)
Date: Mon, 5 Jun 2023 10:23:14 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net] virtio/vsock: fix sock refcnt bug on owner set failure
Message-ID: <nn4zy6aop35ljmf4vg6nelxwo45abvv7rvit62abjvd3eypwpz@kgiusizdyigd>
References: <20230531-b4-vsock-fix-refcnt-v1-1-0ed7b697cca5@bytedance.com>
 <35xlmp65lxd4eoal2oy3lwyjxd3v22aeo2nbuyknc4372eljct@vkilkppadayd>
 <ZHbAgkvSHEiQlFs6@bullseye>
MIME-Version: 1.0
In-Reply-To: <ZHbAgkvSHEiQlFs6@bullseye>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, May 31, 2023 at 03:35:30AM +0000, Bobby Eshleman wrote:
>On Thu, Jun 01, 2023 at 09:58:47AM +0200, Stefano Garzarella wrote:
>> On Wed, May 31, 2023 at 07:47:32PM +0000, Bobby Eshleman wrote:
>> > Previous to setting the owner the socket is found via
>> > vsock_find_connected_socket(), which returns sk after a call to
>> > sock_hold().
>> >
>> > If setting the owner fails, then sock_put() needs to be called.
>> >
>> > Fixes: f9d2b1e146e0 ("virtio/vsock: fix leaks due to missing skb owner")
>> > Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>> > ---
>> > net/vmw_vsock/virtio_transport_common.c | 1 +
>> > 1 file changed, 1 insertion(+)
>> >
>> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> > index b769fc258931..f01cd6adc5cb 100644
>> > --- a/net/vmw_vsock/virtio_transport_common.c
>> > +++ b/net/vmw_vsock/virtio_transport_common.c
>> > @@ -1343,6 +1343,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>> >
>> > 	if (!skb_set_owner_sk_safe(skb, sk)) {
>> > 		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
>> > +		sock_put(sk);
>>
>> Did you have any warning, issue here?
>>
>> IIUC skb_set_owner_sk_safe() can return false only if the ref counter
>> is 0, so calling a sock_put() on it should have no effect except to
>> produce a warning.
>>
>
>Oh yeah, you're totally right. I did not recall how
>skb_set_owner_sk_safe() worked internally and thought I'd introduced an
>uneven hold/put count with that prior patch when reading through the
>code again. I haven't seen any live issue, just misread the code.
>
>Sorry about that, feel free to ignore this patch.

No problem ;-)

Maybe we should add a comment on it.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

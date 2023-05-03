Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52890C77B78
	for <virtualization@archiver.kernel.org>; Wed,  3 May 2023 07:39:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C26D44081F;
	Wed,  3 May 2023 07:39:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C26D44081F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T2VgQdYo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TNAeGbdGgdEo; Wed,  3 May 2023 07:39:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0103240624;
	Wed,  3 May 2023 07:39:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0103240624
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF16EC0036;
	Wed,  3 May 2023 07:39:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08604C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 07:39:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DDF16403AF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 07:38:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DDF16403AF
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=T2VgQdYo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s9cod-QiQ4qU
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 07:38:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 202CA40164
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 202CA40164
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 07:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683099537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pAxcZhu4o2HVjJymB9Go0qnCuRBV6q3xEK19fZLvIig=;
 b=T2VgQdYoYNmdh1F0ck2OEOIvIY70qm9x1Xell678xpxKXgFfJZ/gTtz5/ykPOKCiFyfVQi
 TGRmxNxeCJvYtfT+ZnMz/pSzLgQNcMtQ/5/mDuXkBrSNhnbQRs15Bk0hhovD6i3/kKq77k
 tNgU/f7YWkoXSd18SIzHUPFQABVccuk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-hSCReIs7NOyb-FNLlx-hXw-1; Wed, 03 May 2023 03:38:56 -0400
X-MC-Unique: hSCReIs7NOyb-FNLlx-hXw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30641258c9eso153784f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 May 2023 00:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683099535; x=1685691535;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pAxcZhu4o2HVjJymB9Go0qnCuRBV6q3xEK19fZLvIig=;
 b=KueJZxV1Czye4zb3ym/augLSVI8pT1CH2QXLcSsua4uTktyG7G/NTRUAm0mrCU3mt4
 IbS6Gx+cPPxdVUiP2Z3i7TCYmwRdepL2n0LyLIKUOCxO/AzEMeYzRMMuIjFp28qw23ZT
 ws4Ckic9HRtvBayhMisSeGx3wqWADaKD+sqEAR6PQjJ0LmKbKA2uucX4XPLodzi/bR1k
 wCd+aYqg1ywIMqkEd7vGz8+4ozrhEvTduIiX/TK3QboRXPi1OkVxE/A9fs4iPETZAWxb
 o/keXlfc5p8lQ6q8vfvu8ejUpvVe+pzS6aSQLlPhe8vs9hJMxTALf8fZ8qoPlS+PF/Vf
 7khQ==
X-Gm-Message-State: AC+VfDxUeavbtnmla9GCXkW4HgWOwPJ9zLQo+65QlFSYVDHEIRKrsr86
 fsIE6oVLT0t5PMxB7j0gw8toTZrapDD6gk9Pdy8dk/D+fD7P3vMBkPOnm2X+HV4HvaZ8uBXUXNS
 Dx3z4b+BaL+1OclXL0mNCBTddUD49Ho6w+J+gqlOIUQ==
X-Received: by 2002:a5d:6446:0:b0:306:401d:8ce1 with SMTP id
 d6-20020a5d6446000000b00306401d8ce1mr1039277wrw.11.1683099535215; 
 Wed, 03 May 2023 00:38:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4jS0rZK7zlXJSzh5byjzY89SiMYSDdqr7AlXInY7R+ycQXbuLMQVtQxwRIla52w9LsJ/EcZA==
X-Received: by 2002:a5d:6446:0:b0:306:401d:8ce1 with SMTP id
 d6-20020a5d6446000000b00306401d8ce1mr1039260wrw.11.1683099534906; 
 Wed, 03 May 2023 00:38:54 -0700 (PDT)
Received: from sgarzare-redhat ([185.29.96.107])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a5d4e50000000b002c7066a6f77sm32959330wrt.31.2023.05.03.00.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 May 2023 00:38:53 -0700 (PDT)
Date: Wed, 3 May 2023 09:38:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [Patch net] vsock: improve tap delivery accuracy
Message-ID: <occeblxotmpsq4gqjjued62ar5ngqxehmmrj7jg3ynzsz2vfcy@4jzl7slmqkft>
References: <20230502174404.668749-1-xiyou.wangcong@gmail.com>
 <20230502201418.GG535070@fedora> <ZDt+PDtKlxrwUPnc@bullseye>
MIME-Version: 1.0
In-Reply-To: <ZDt+PDtKlxrwUPnc@bullseye>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Cong Wang <cong.wang@bytedance.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>
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

On Sun, Apr 16, 2023 at 04:49:00AM +0000, Bobby Eshleman wrote:
>On Tue, May 02, 2023 at 04:14:18PM -0400, Stefan Hajnoczi wrote:
>> On Tue, May 02, 2023 at 10:44:04AM -0700, Cong Wang wrote:
>> > From: Cong Wang <cong.wang@bytedance.com>
>> >
>> > When virtqueue_add_sgs() fails, the skb is put back to send queue,
>> > we should not deliver the copy to tap device in this case. So we
>> > need to move virtio_transport_deliver_tap_pkt() down after all
>> > possible failures.
>> >
>> > Fixes: 82dfb540aeb2 ("VSOCK: Add virtio vsock vsockmon hooks")
>> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> > Cc: Stefano Garzarella <sgarzare@redhat.com>
>> > Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>
>> > Signed-off-by: Cong Wang <cong.wang@bytedance.com>
>> > ---
>> >  net/vmw_vsock/virtio_transport.c | 5 ++---
>> >  1 file changed, 2 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>> > index e95df847176b..055678628c07 100644
>> > --- a/net/vmw_vsock/virtio_transport.c
>> > +++ b/net/vmw_vsock/virtio_transport.c
>> > @@ -109,9 +109,6 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>> >  		if (!skb)
>> >  			break;
>> >
>> > -		virtio_transport_deliver_tap_pkt(skb);
>> > -		reply = virtio_vsock_skb_reply(skb);
>> > -
>> >  		sg_init_one(&hdr, virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(skb)));
>> >  		sgs[out_sg++] = &hdr;
>> >  		if (skb->len > 0) {
>> > @@ -128,6 +125,8 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>> >  			break;
>> >  		}
>> >
>> > +		virtio_transport_deliver_tap_pkt(skb);

I would move only the virtio_transport_deliver_tap_pkt(), 
virtio_vsock_skb_reply() is not related.

>> > +		reply = virtio_vsock_skb_reply(skb);
>>
>> I don't remember the reason for the ordering, but I'm pretty sure it was
>> deliberate. Probably because the payload buffers could be freed as soon
>> as virtqueue_add_sgs() is called.
>>
>> If that's no longer true with Bobby's skbuff code, then maybe it's safe
>> to monitor packets after they have been sent.
>>
>> Stefan
>
>Hey Stefan,
>
>Unfortunately, skbuff doesn't change that behavior.
>
>If I understand correctly, the problem flow you are describing
>would be something like this:
>
>Thread 0 			Thread 1
>guest:virtqueue_add_sgs()[@send_pkt_work]
>
>				host:vhost_vq_get_desc()[@handle_tx_kick]
>				host:vhost_add_used()
>				host:vhost_signal()
>				guest:virtqueue_get_buf()[@tx_work]
>				guest:consume_skb()
>
>guest:deliver_tap_pkt()[@send_pkt_work]
>^ use-after-free
>
>Which I guess is possible because the receiver can consume the new
>scatterlist during the processing kicked off for a previous batch?
>(doesn't have to wait for the subsequent kick)

This is true, but both `send_pkt_work` and `tx_work` hold `tx_lock`, so 
can they really go in parallel?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

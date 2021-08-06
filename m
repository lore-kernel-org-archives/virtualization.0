Return-Path: <SRS0=epgR=M5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B510C4338F
	for <virtualization@archiver.kernel.org>; Fri,  6 Aug 2021 08:48:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5FA760F59
	for <virtualization@archiver.kernel.org>; Fri,  6 Aug 2021 08:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B5FA760F59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 748A3400C9;
	Fri,  6 Aug 2021 08:48:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IpohIto_WODh; Fri,  6 Aug 2021 08:48:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ACB83400C2;
	Fri,  6 Aug 2021 08:48:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EE78C001A;
	Fri,  6 Aug 2021 08:48:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6483C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 08:47:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AF0B8404F9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 08:47:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hcupH7vW8JJd
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 08:47:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6913240403
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 08:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628239677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uIBiZswclAmZAKEwOl2WxxnVqDtJu5o7jYDul8dvWmY=;
 b=MYbKyuMBYOp1zrhYcod/BvIYXXLLnXEdP/YZISXm07ci1tMy2ycl3k00OUZcw8BGciAuV1
 LZKSoBtNC/4YZgnQBj5v1NWxoNM1+vgIvravNrRZY0F05m1R4IF9FkS4jn2+VC72QPiN2W
 3P3I2eqWpnzqWIU8Xsxg/nkKhamYRIY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-B_2dQ-QBOAW4OjDYQaKZpQ-1; Fri, 06 Aug 2021 04:47:56 -0400
X-MC-Unique: B_2dQ-QBOAW4OjDYQaKZpQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 gg35-20020a17090689a3b0290580ff45a075so2906938ejc.20
 for <virtualization@lists.linux-foundation.org>;
 Fri, 06 Aug 2021 01:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uIBiZswclAmZAKEwOl2WxxnVqDtJu5o7jYDul8dvWmY=;
 b=ZETxKmLdccpdGn6Vmu98ePtvNjoTUzaZ4jKPAqGQMIJ89CxFYmayytAWKfEfpT/8io
 pgeSRm0PUlkwuyF4yqVNXGXGOKtPyS1Gx2gVet+qtazCWnpG7E5zBblgS5cLkb3uIWn8
 7/rW39esindI0TRPFsZDfXOQW42ZycHSYSnf6EcMQ1mg8rXyPMIr/o2qX2AQOQW1haSw
 W5NiVffEE0OQZIbxmXFAiWBBZ4xedHWdb6Ic7BOO4JExpwDcm7DUAeGGOQfulZCfjv0D
 9JFVeAk2AMmztUuBAkfRzI6BskcCy+f2lV4gYsBhcagHPJjRrVClVfWpTA/jIsYUoR0u
 qDUQ==
X-Gm-Message-State: AOAM531Qjw6kQL+MmiWJ/cPe9TVPyjRddcpGOGhXjuk8ZZEUQwDFI8rh
 rK1Z2psp0t4decE8AbriRAXHjw9YGehuDAz4opIja7YZSwzHiSPiKfudUvWPqsAzjjgL4+iMoqW
 uaunOJX9JlPDGE1r1LSaxVHaJytULi1Uu080kI+pAmw==
X-Received: by 2002:a05:6402:18c1:: with SMTP id
 x1mr11474528edy.145.1628239675036; 
 Fri, 06 Aug 2021 01:47:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTd0o4WvYl5mo4LnOpxaZnn897ViX2mbmfnK91Gcgr5jxHNl8+wZOELsM+8EHXJ3B1tc7yGA==
X-Received: by 2002:a05:6402:18c1:: with SMTP id
 x1mr11474504edy.145.1628239674906; 
 Fri, 06 Aug 2021 01:47:54 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id w13sm3610023ede.24.2021.08.06.01.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Aug 2021 01:47:54 -0700 (PDT)
Date: Fri, 6 Aug 2021 10:47:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v1 3/7] vhost/vsock: support MSG_EOR bit processing
Message-ID: <20210806084752.vzzucocjg3wvpukr@steredhat>
References: <20210726163137.2589102-1-arseny.krasnov@kaspersky.com>
 <20210726163341.2589759-1-arseny.krasnov@kaspersky.com>
 <20210806072849.4by3wbdkg2bsierm@steredhat>
 <40a1d508-c841-23b7-58d5-f539b2d98ae1@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <40a1d508-c841-23b7-58d5-f539b2d98ae1@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

On Fri, Aug 06, 2021 at 11:40:38AM +0300, Arseny Krasnov wrote:
>
>On 06.08.2021 10:28, Stefano Garzarella wrote:
>> Caution: This is an external email. Be cautious while opening links or attachments.
>>
>>
>>
>> On Mon, Jul 26, 2021 at 07:33:38PM +0300, Arseny Krasnov wrote:
>>> It works in the same way as 'end-of-message' bit: if packet has
>>> 'EOM' bit, also check for 'EOR' bit.
>>>
>>> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>>> ---
>>> drivers/vhost/vsock.c | 12 +++++++++++-
>>> 1 file changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>>> index 3b55de70ac77..3e2b150f9c6f 100644
>>> --- a/drivers/vhost/vsock.c
>>> +++ b/drivers/vhost/vsock.c
>>> @@ -115,6 +115,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>>>               size_t iov_len, payload_len;
>>>               int head;
>>>               bool restore_msg_eom_flag = false;
>>> +              bool restore_msg_eor_flag = false;
>> Since we now have 2 flags to potentially restore, we could use a single
>> variable (e.g. uint32_t flags_to_restore), initialized to 0.
>>
>> We can set all the flags we need to restore and then simply put it
>> in or with the `pkt->hdr.flags` field.
>>
>>>               spin_lock_bh(&vsock->send_pkt_list_lock);
>>>               if (list_empty(&vsock->send_pkt_list)) {
>>> @@ -188,6 +189,11 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>>>                       if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOM) {
>>>                               pkt->hdr.flags &= ~cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
>>>                               restore_msg_eom_flag = true;
>>> +
>>> +                              if (le32_to_cpu(pkt->hdr.flags & VIRTIO_VSOCK_SEQ_EOR)) {
>>                                                                 ^
>> Here it should be `le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOR`
>>
>>> +                                      pkt->hdr.flags &= ~cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
>>> +                                      restore_msg_eor_flag = true;
>>> +                              }
>>>                       }
>>>               }
>>>
>>> @@ -224,9 +230,13 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>>>                * to send it with the next available buffer.
>>>                */
>>>               if (pkt->off < pkt->len) {
>>> -                      if (restore_msg_eom_flag)
>>> +                      if (restore_msg_eom_flag) {
>>>                               pkt->hdr.flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
>>>
>>> +                              if (restore_msg_eor_flag)
>>> +                                      pkt->hdr.flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
>>> +                      }
>>> +
>> If we use a single variable, here we can simply do:
>>
>>                         pkt->hdr.flags |= cpu_to_le32(flags_to_restore);
>>
>> Stefano
>
>Thanks, i'll prepare v2 both with spec patch. About spec: i've already sent
>
>patch for SEQPACKET, can i prepare spec patch updating current reviewed
>
>SEQPACKET? E.g. i'll include both EOM and EOR in one patch.

Yep, since spec is not yet merged, I think make sense to have all 
seqpacket stuff in a single patch.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

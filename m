Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83140C61DA4
	for <virtualization@archiver.kernel.org>; Thu,  9 Mar 2023 16:32:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2B6841990;
	Thu,  9 Mar 2023 16:32:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E2B6841990
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JF8MxmmQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yuSXItKM3IWM; Thu,  9 Mar 2023 16:32:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 260B54198B;
	Thu,  9 Mar 2023 16:32:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 260B54198B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06418C0035;
	Thu,  9 Mar 2023 16:32:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BD29C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 16:32:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06415613F3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 16:32:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 06415613F3
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JF8MxmmQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kj_6vUgHr9iP
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 16:32:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A6B1607CA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0A6B1607CA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 16:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678379529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OhtE1bGBZ1SlZ7+wLdUpGqS+X/sS9BNBWD0AiRRx31M=;
 b=JF8MxmmQIQd3cnhdOD9G8wjrozJUp3QxJafRwzKV7Fe29xXnUgZVg6l0sWBiEEWcnpswP5
 yV1lWwXrzAvOnNsLafDAdEt/DhtkBP8y+ccGRc7vCVmhedwonif/RBR/o9PnXaHo0kixz3
 pUq+99VmpNTvfQ6htDEK/u/g8LKbF/4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-SrGiClJ1Owmwtjn3ZGcq7Q-1; Thu, 09 Mar 2023 11:32:06 -0500
X-MC-Unique: SrGiClJ1Owmwtjn3ZGcq7Q-1
Received: by mail-qt1-f200.google.com with SMTP id
 w16-20020ac843d0000000b003bfe50a4105so1351113qtn.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Mar 2023 08:32:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678379526;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OhtE1bGBZ1SlZ7+wLdUpGqS+X/sS9BNBWD0AiRRx31M=;
 b=uuu0F+9oLGeLajlcOdfr58jbirOAfkwd0i+86IXYGwfOi2whiP2qINJPutn1OZ4DNA
 85NiANOCXP1Ezr4STNMfaP/aeFZl834hoU5AedCEuqYttBmLtAEijFx2BasbACeRKum6
 T5B261FVeOM/YaZkBUyU7IU+wLPdgbfmfCJIr5DfqYyOhkVNp9O9wK5zkxv3Vh4EbFUv
 bRz4SKZZK/puXdmh0ZGenP6K3KdJjQK5joUfUQHX7engnSnmocdNDFd87DOvxtRksolW
 zMs/GZ47uKV29veIDRRrap+vGtA2EnRSi/GST5RQB80SDCOKmp+MyZTjgANCT/Qa7yB2
 SNcA==
X-Gm-Message-State: AO0yUKXk8oz7OsqM43gBoCTAJCgoSdGMi4sap1bYCoTih1Pi/ldmM7rA
 4DfR+kC3u0LvfAY73YXF7NQNTJqjLiHZRoylPzbNMOPC35QBoaynXlaKqWI4CeQSBoBT2AWTS6H
 mzTpApCO3SuMR0IuePob9ybW7xYVD+wUDDcvknnuIgA==
X-Received: by 2002:ac8:5a4b:0:b0:3bf:d00a:2eae with SMTP id
 o11-20020ac85a4b000000b003bfd00a2eaemr38124789qta.47.1678379526085; 
 Thu, 09 Mar 2023 08:32:06 -0800 (PST)
X-Google-Smtp-Source: AK7set9xKlCfrkruhxAK7QF576WQLTA90MiAGXjylmK3sCO1SvBxFAjAgjIt/fQoszp9URGRyn+5OQ==
X-Received: by 2002:ac8:5a4b:0:b0:3bf:d00a:2eae with SMTP id
 o11-20020ac85a4b000000b003bfd00a2eaemr38124756qta.47.1678379525784; 
 Thu, 09 Mar 2023 08:32:05 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 s188-20020a3745c5000000b00742bc037f29sm13579401qka.120.2023.03.09.08.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Mar 2023 08:32:05 -0800 (PST)
Date: Thu, 9 Mar 2023 17:32:00 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 0/4] several updates to virtio/vsock
Message-ID: <20230309163200.lq6dzop724diafpf@sgarzare-redhat>
References: <0abeec42-a11d-3a51-453b-6acf76604f2e@sberdevices.ru>
 <20230309162150.qqrlqmqghi5muucx@sgarzare-redhat>
 <a1788ed6-89d4-27da-a049-99e29edea4cb@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <a1788ed6-89d4-27da-a049-99e29edea4cb@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel@sberdevices.ru, Jakub Kicinski <kuba@kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Mar 09, 2023 at 07:20:20PM +0300, Arseniy Krasnov wrote:
>
>
>On 09.03.2023 19:21, Stefano Garzarella wrote:
>> On Thu, Mar 09, 2023 at 01:10:36PM +0300, Arseniy Krasnov wrote:
>>> Hello,
>>>
>>> this patchset evolved from previous v2 version (see link below). It does
>>> several updates to virtio/vsock:
>>> 1) Changes 'virtio_transport_inc/dec_rx_pkt()' interface. Now instead of
>>> =A0 using skbuff state ('head' and 'data' pointers) to update 'fwd_cnt'
>>> =A0 and 'rx_bytes', integer value is passed as an input argument. This
>>> =A0 makes code more simple, because in this case we don't need to udpate
>>> =A0 skbuff state before calling 'virtio_transport_inc/dec_rx_pkt()'. In
>>> =A0 more common words - we don't need to change skbuff state to update
>>> =A0 'rx_bytes' and 'fwd_cnt' correctly.
>>> 2) For SOCK_STREAM, when copying data to user fails, current skbuff is
>>> =A0 not dropped. Next read attempt will use same skbuff and last offset.
>>> =A0 Instead of 'skb_dequeue()', 'skb_peek()' + '__skb_unlink()' are use=
d.
>>> =A0 This behaviour was implemented before skbuff support.
>>> 3) For SOCK_SEQPACKET it removes unneeded 'skb_pull()' call, because for
>>> =A0 this type of socket each skbuff is used only once: after removing it
>>> =A0 from socket's queue, it will be freed anyway.
>>>
>>> Test for 2) also added:
>>> Test tries to 'recv()' data to NULL buffer, then does 'recv()' with val=
id
>>> buffer. For SOCK_STREAM second 'recv()' must return data, because skbuff
>>> must not be dropped, but for SOCK_SEQPACKET skbuff will be dropped by
>>> kernel, and 'recv()' will return EAGAIN.
>>>
>>> Link to v1 on lore:
>>> https://lore.kernel.org/netdev/c2d3e204-89d9-88e9-8a15-3fe027e56b4b@sbe=
rdevices.ru/
>>>
>>> Link to v2 on lore:
>>> https://lore.kernel.org/netdev/a7ab414b-5e41-c7b6-250b-e8401f335859@sbe=
rdevices.ru/
>>>
>>> Change log:
>>>
>>> v1 -> v2:
>>> - For SOCK_SEQPACKET call 'skb_pull()' also in case of copy failure or
>>> =A0 dropping skbuff (when we just waiting message end).
>>> - Handle copy failure for SOCK_STREAM in the same manner (plus free
>>> =A0 current skbuff).
>>> - Replace bug repdroducer with new test in vsock_test.c
>>>
>>> v2 -> v3:
>>> - Replace patch which removes 'skb->len' subtraction from function
>>> =A0 'virtio_transport_dec_rx_pkt()' with patch which updates functions
>>> =A0 'virtio_transport_inc/dec_rx_pkt()' by passing integer argument
>>> =A0 instead of skbuff pointer.
>>> - Replace patch which drops skbuff when copying to user fails with
>>> =A0 patch which changes this behaviour by keeping skbuff in queue until
>>> =A0 it has no data.
>>> - Add patch for SOCK_SEQPACKET which removes redundant 'skb_pull()'
>>> =A0 call on read.
>>> - I remove "Fixes" tag from all patches, because all of them now change
>>> =A0 code logic, not only fix something.
>>
>> Yes, but they solve the problem, so we should use the tag (I think at
>> least in patch 1 and 3).
>>
>> We usually use the tag when we are fixing a problem introduced by a
>> previous change. So we need to backport the patch to the stable branches
>> as well, and we need the tag to figure out which branches have the patch
>> or not.
>Ahh, sorry. Ok. I see now :)

No problem at all :-)

I think also patch 2 can have the Fixes tag.

Thanks,
Stefano

>
>Thanks, Arseniy
>>
>> Thanks,
>> Stefano
>>
>>>
>>> Arseniy Krasnov (4):
>>> =A0virtio/vsock: don't use skbuff state to account credit
>>> =A0virtio/vsock: remove redundant 'skb_pull()' call
>>> =A0virtio/vsock: don't drop skbuff on copy failure
>>> =A0test/vsock: copy to user failure test
>>>
>>> net/vmw_vsock/virtio_transport_common.c |=A0 29 +++---
>>> tools/testing/vsock/vsock_test.c=A0=A0=A0=A0=A0=A0=A0 | 118 +++++++++++=
+++++++++++++
>>> 2 files changed, 131 insertions(+), 16 deletions(-)
>>>
>>> --=A0
>>> 2.25.1
>>>
>>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

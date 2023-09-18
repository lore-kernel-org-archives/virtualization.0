Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0498BC46CA1
	for <virtualization@archiver.kernel.org>; Mon, 18 Sep 2023 14:50:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 716B0812D3;
	Mon, 18 Sep 2023 14:50:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 716B0812D3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AZmP+PPm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YOj4le4b-R-q; Mon, 18 Sep 2023 14:50:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D11E9812C6;
	Mon, 18 Sep 2023 14:50:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D11E9812C6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9CFBC0039;
	Mon, 18 Sep 2023 14:50:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A204C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 14:50:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E4F31812BA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 14:50:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E4F31812BA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Iqf9K0b5x1pJ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 14:50:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 81F64812B2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 14:50:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 81F64812B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LcTISZgyQz7Bvk45tsdOeOYi0IZTcEbOF6L8io0wv6s=;
 b=AZmP+PPmdGbBADR5nqYOagxezbjYlqEiLBwqYoLZfz1fBK0NyUzlIOBdcorqD/pkSkpJM2
 qo80A/G0ww9r97TTAj5grrHjuR/Q8j217ihD24PTSrq4q3RVIFj5Nx/QbfHXSVy0+jMRR0
 KnLa8veoRlQA3ImtxwfW2bmzE+UiY0M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-nPSDjoXRNFKXpD6KmFYLcg-1; Mon, 18 Sep 2023 10:50:10 -0400
X-MC-Unique: nPSDjoXRNFKXpD6KmFYLcg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-314256aedcbso3113449f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 07:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695048610; x=1695653410;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LcTISZgyQz7Bvk45tsdOeOYi0IZTcEbOF6L8io0wv6s=;
 b=kTtl91X0qVqUnQxUFgvrKlRXhAwYu9eXvmydrq4JvtdVo/dDiaOmrt4JIjL0a0TqYV
 LlA1V5hZZ4gOQ6uyoGTHgSxcqT3HR5S0cd1QxML/a7s/Juw2L5MIqh2X8M3AyauxHRM+
 ioiEBIVI3dB4XEWNa6lFChAEqfRLwX6/ReWXQqQypVWo6nBweRCngUJzNbgixhsxr3o2
 L50JCziU7D4q5XMcRrBMEZtUq59B2lV3XzBlB82VTb4kBwLaUcBexpetq5CfEjzCG22/
 wvsFqVx+esjGO5GfwIPmM1Qvr+YDLpb5Es3QVQDIaKGAs+MaPeuU1ZnzfV5E5tRO+kYa
 21xQ==
X-Gm-Message-State: AOJu0YwDySuU8zi0EiUUtPOdFpaJl8gxAkUwhiIGkXk48F+sbP2TFeoa
 KtCxoynylPXyU3BtU1aN6tPfd/kT2Sov7QIBUd4T+dxmjVJpl0AsapNs68OyfcU3f/VZPWzVV/j
 28f4N3VdmQZRS0LtDxwCtWl8qQ+osv1b2cqyMl7sExA==
X-Received: by 2002:a5d:4941:0:b0:319:72f8:7249 with SMTP id
 r1-20020a5d4941000000b0031972f87249mr7183138wrs.66.1695048609813; 
 Mon, 18 Sep 2023 07:50:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMpvQ2Hg0cP8tmtAOT3D6mlDBNWBlCvpd7g68aXHEpraHiZGH8Wu30Hj0RA2msYaZmefhIrA==
X-Received: by 2002:a5d:4941:0:b0:319:72f8:7249 with SMTP id
 r1-20020a5d4941000000b0031972f87249mr7183112wrs.66.1695048609417; 
 Mon, 18 Sep 2023 07:50:09 -0700 (PDT)
Received: from sgarzare-redhat ([46.222.42.69])
 by smtp.gmail.com with ESMTPSA id
 m6-20020adfe946000000b0031980783d78sm12772049wrn.54.2023.09.18.07.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 07:50:08 -0700 (PDT)
Date: Mon, 18 Sep 2023 16:50:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v9 4/4] vsock/virtio: MSG_ZEROCOPY flag support
Message-ID: <fwv4zdqjfhtwqookpvqqlckoqnxgyiinzhs5mq5pevl7ucefrt@hgd67phghec6>
References: <20230916130918.4105122-1-avkrasnov@salutedevices.com>
 <20230916130918.4105122-5-avkrasnov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20230916130918.4105122-5-avkrasnov@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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

On Sat, Sep 16, 2023 at 04:09:18PM +0300, Arseniy Krasnov wrote:
>This adds handling of MSG_ZEROCOPY flag on transmission path:
>
>1) If this flag is set and zerocopy transmission is possible (enabled
>   in socket options and transport allows zerocopy), then non-linear
>   skb will be created and filled with the pages of user's buffer.
>   Pages of user's buffer are locked in memory by 'get_user_pages()'.
>2) Replaces way of skb owning: instead of 'skb_set_owner_sk_safe()' it
>   calls 'skb_set_owner_w()'. Reason of this change is that
>   '__zerocopy_sg_from_iter()' increments 'sk_wmem_alloc' of socket, so
>   to decrease this field correctly, proper skb destructor is needed:
>   'sock_wfree()'. This destructor is set by 'skb_set_owner_w()'.
>3) Adds new callback to 'struct virtio_transport': 'can_msgzerocopy'.
>   If this callback is set, then transport needs extra check to be able
>   to send provided number of buffers in zerocopy mode. Currently, the
>   only transport that needs this callback set is virtio, because this
>   transport adds new buffers to the virtio queue and we need to check,
>   that number of these buffers is less than size of the queue (it is
>   required by virtio spec). vhost and loopback transports don't need
>   this check.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v5(big patchset) -> v1:
>  * Refactorings of 'if' conditions.
>  * Remove extra blank line.
>  * Remove 'frag_off' field unneeded init.
>  * Add function 'virtio_transport_fill_skb()' which fills both linear
>    and non-linear skb with provided data.
> v1 -> v2:
>  * Use original order of last four arguments in 'virtio_transport_alloc_skb()'.
> v2 -> v3:
>  * Add new transport callback: 'msgzerocopy_check_iov'. It checks that
>    provided 'iov_iter' with data could be sent in a zerocopy mode.
>    If this callback is not set in transport - transport allows to send
>    any 'iov_iter' in zerocopy mode. Otherwise - if callback returns 'true'
>    then zerocopy is allowed. Reason of this callback is that in case of
>    G2H transmission we insert whole skb to the tx virtio queue and such
>    skb must fit to the size of the virtio queue to be sent in a single
>    iteration (may be tx logic in 'virtio_transport.c' could be reworked
>    as in vhost to support partial send of current skb). This callback
>    will be enabled only for G2H path. For details pls see comment
>    'Check that tx queue...' below.
> v3 -> v4:
>  * 'msgzerocopy_check_iov' moved from 'struct vsock_transport' to
>    'struct virtio_transport' as it is virtio specific callback and
>    never needed in other transports.
> v4 -> v5:
>  * 'msgzerocopy_check_iov' renamed to 'can_msgzerocopy' and now it
>    uses number of buffers to send as input argument. I think there is
>    no need to pass iov to this callback (at least today, it is used only
>    by guest side of virtio transport), because the only thing that this
>    callback does is comparison of number of buffers to be inserted to
>    the tx queue and size of this queue.
>  * Remove any checks for type of current 'iov_iter' with payload (is it
>    'iovec' or 'ubuf'). These checks left from the earlier versions where I
>    didn't use already implemented kernel API which handles every type of
>    'iov_iter'.
> v5 -> v6:
>  * Refactor 'virtio_transport_fill_skb()'.
>  * Add 'WARN_ON_ONCE()' and comment on invalid combination of destination
>    socket and payload in 'virtio_transport_alloc_skb()'.
> v7 -> v8:
>  * Move '+1' addition from 'can_msgzerocopy' callback body to the caller.
>    This addition means packet header.
>  * In 'virtio_transport_can_zcopy()' rename 'max_to_send' argument to
>    'pkt_len'.
>  * Update commit message by adding details about new 'can_msgzerocopy'
>    callback.
>  * In 'virtio_transport_init_hdr()' move 'len' argument directly after
>    'info'.
>  * Add comment about processing last skb in tx loop.
>  * Update comment for 'can_msgzerocopy' callback for more details.
> v8 -> v9:
>  * Return and update comment for 'virtio_transport_alloc_skb()'.
>  * Pass pointer to transport ops to 'virtio_transport_can_zcopy()',
>    this allows to use it directly without calling virtio_transport_get_ops()'.
>  * Remove redundant call for 'msg_data_left()' in 'virtio_transport_fill_skb()'.
>  * Do not pass 'struct vsock_sock*' to 'virtio_transport_alloc_skb()',
>    use same pointer from already passed 'struct virtio_vsock_pkt_info*'.
>  * Fix setting 'end of message' bit for SOCK_SEQPACKET (add call for
>    'msg_data_left()' == 0).
>  * Add 'zcopy' parameter to packet allocation trace event.

Thanks for addressing the comments!
>
> include/linux/virtio_vsock.h                  |   9 +
> .../events/vsock_virtio_transport_common.h    |  12 +-
> net/vmw_vsock/virtio_transport.c              |  32 +++
> net/vmw_vsock/virtio_transport_common.c       | 250 ++++++++++++++----
> 4 files changed, 241 insertions(+), 62 deletions(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

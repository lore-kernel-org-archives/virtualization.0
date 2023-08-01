Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AB6C0015E
	for <virtualization@archiver.kernel.org>; Tue,  1 Aug 2023 13:11:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B51F76112D;
	Tue,  1 Aug 2023 13:11:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B51F76112D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AXwEBElR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bQpNHE2iChuV; Tue,  1 Aug 2023 13:11:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2722F6113C;
	Tue,  1 Aug 2023 13:11:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2722F6113C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 043D8C0071;
	Tue,  1 Aug 2023 13:11:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2128C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 13:11:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C132A402AC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 13:11:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C132A402AC
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AXwEBElR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SzLCGTTRlB83
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 13:11:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B87B14010E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 13:11:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B87B14010E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690895505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=275Dw8Wk/DeUcEpEfed6nKJoKGfcWzXg7rnjKC97r6E=;
 b=AXwEBElR2nhpkAhLqOGu28SjGxK/kz4CYhGiPfLTEzZKRNKKgIdx3VioD1/aXSwDRb8kAW
 pYs+c875Nza2y1MdfKZveiWX5jvjVtwpilAaXlsBtwz09jByn7rdW0NRhiVuFyga5S4hm9
 Y9I0nIj8gfnE+wVhok1s5Vmg7P4j/Zw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-uV8l5XwgPeeZKCpJL0h5cQ-1; Tue, 01 Aug 2023 09:11:44 -0400
X-MC-Unique: uV8l5XwgPeeZKCpJL0h5cQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-76c8e07cbe9so98328285a.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Aug 2023 06:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690895503; x=1691500303;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LZPGMYFD95A8uiN976D445h5APBCC9ED+naAIlPhoHg=;
 b=Kv4NFQN1pwKdyG4nkxPL3kqVvjV5xBedQDG8i8Evnf2TDf32/fUe1fao5nj0+jFcli
 7uLP/jvjNEuoE+7TewnFaRcv2wQhVs75+ddrf20TMaRXHtWQ+XUcOgmj/59rh3yCQwPV
 U0cJ4Bi7JZwGw0D3h6a8t5lMkyDd01Z7+0PQZKrSkx/zX4zbhnwQw+Q47S6AOJlS1dh8
 guNWnUwDwUb3Ej8+vG1ddtPSlJmG3IU8ilELHbub7djZO62a9jmrFx+qzJdaGLMWPRtU
 cS5/6qZ36efQNrnDVPNJLxcm9l4kGq+yOU71fkon+Y2jLPM8VlP/qGXIlMiCiZmuJjzD
 NDcg==
X-Gm-Message-State: ABy/qLacxAmKjxXqP6wzE8uiETpufa0gnfRlUcM9aJOlojEpYQaKjypn
 8cIMRtPOkUGRBQjCvwmj+QG75twwFVbvm9IPWeEF4K41xzO/6q5BCAl2Xe143oL3nlcNwFJooPb
 fcMhA6NC5CZxPT0lTpp2HYkOYKmMfmRJCO60cQyOUhQ==
X-Received: by 2002:a05:620a:1a11:b0:767:a7c1:e776 with SMTP id
 bk17-20020a05620a1a1100b00767a7c1e776mr11186392qkb.2.1690895503108; 
 Tue, 01 Aug 2023 06:11:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF4WPKBYnm5c1SYuFP+zCzJTJpn6DkKmUmEfzMFnNuT7F0grWUkB9zMAi1HQjUppRuuFnBO+g==
X-Received: by 2002:a05:620a:1a11:b0:767:a7c1:e776 with SMTP id
 bk17-20020a05620a1a1100b00767a7c1e776mr11186374qkb.2.1690895502779; 
 Tue, 01 Aug 2023 06:11:42 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-251.dyn.eolo.it.
 [146.241.225.251]) by smtp.gmail.com with ESMTPSA id
 j27-20020a05620a001b00b00767d05117fesm4127068qki.36.2023.08.01.06.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Aug 2023 06:11:42 -0700 (PDT)
Message-ID: <8972ac7df2298d47e1b2f53b7f1b5d5941999580.camel@redhat.com>
Subject: Re: [PATCH net-next v5 1/4] vsock/virtio/vhost: read data from
 non-linear skb
From: Paolo Abeni <pabeni@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Stefan Hajnoczi
 <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>
Date: Tue, 01 Aug 2023 15:11:38 +0200
In-Reply-To: <20230730085905.3420811-2-AVKrasnov@sberdevices.ru>
References: <20230730085905.3420811-1-AVKrasnov@sberdevices.ru>
 <20230730085905.3420811-2-AVKrasnov@sberdevices.ru>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 kernel@sberdevices.ru
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sun, 2023-07-30 at 11:59 +0300, Arseniy Krasnov wrote:
> This is preparation patch for MSG_ZEROCOPY support. It adds handling of
> non-linear skbs by replacing direct calls of 'memcpy_to_msg()' with
> 'skb_copy_datagram_iter()'. Main advantage of the second one is that it
> can handle paged part of the skb by using 'kmap()' on each page, but if
> there are no pages in the skb, it behaves like simple copying to iov
> iterator. This patch also adds new field to the control block of skb -
> this value shows current offset in the skb to read next portion of data
> (it doesn't matter linear it or not). Idea behind this field is that
> 'skb_copy_datagram_iter()' handles both types of skb internally - it
> just needs an offset from which to copy data from the given skb. This
> offset is incremented on each read from skb. This approach allows to
> avoid special handling of non-linear skbs:
> 1) We can't call 'skb_pull()' on it, because it updates 'data' pointer.
> 2) We need to update 'data_len' also on each read from this skb.

It looks like the above sentence is a left-over from previous version
as, as this patch does not touch data_len. And I think it contradicts
the previous one, so it's a bit confusing.

> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  Changelog:
>  v5(big patchset) -> v1:
>   * Merge 'virtio_transport_common.c' and 'vhost/vsock.c' patches into
>     this single patch.
>   * Commit message update: grammar fix and remark that this patch is
>     MSG_ZEROCOPY preparation.
>   * Use 'min_t()' instead of comparison using '<>' operators.
>  v1 -> v2:
>   * R-b tag added.
>  v3 -> v4:
>   * R-b tag removed due to rebase:
>     * Part for 'virtio_transport_stream_do_peek()' is changed.
>     * Part for 'virtio_transport_seqpacket_do_peek()' is added.
>   * Comments about sleep in 'memcpy_to_msg()' now describe sleep in
>     'skb_copy_datagram_iter()'.
> 
>  drivers/vhost/vsock.c                   | 14 +++++++----
>  include/linux/virtio_vsock.h            |  1 +
>  net/vmw_vsock/virtio_transport_common.c | 32 +++++++++++++++----------
>  3 files changed, 29 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 817d377a3f36..8c917be32b5d 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -114,6 +114,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>  		struct sk_buff *skb;
>  		unsigned out, in;
>  		size_t nbytes;
> +		u32 frag_off;

IMHO 'offset' would be a better name for both the variable and the CB
field, as it can points both inside the skb frags, linear part or frag
list.

Otherwise LGTM, thanks!

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929D1C64EC4
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 09:09:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 34CBF401D2;
	Fri, 10 Mar 2023 09:09:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 34CBF401D2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UL39DSEH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PXZgmliBbFbi; Fri, 10 Mar 2023 09:09:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B6BD940123;
	Fri, 10 Mar 2023 09:09:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B6BD940123
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C3D4C0035;
	Fri, 10 Mar 2023 09:09:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1626C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C807A8200F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:09:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C807A8200F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UL39DSEH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nlTkAtsJGEcD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:09:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0937782006
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0937782006
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678439386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lsjkU85N4FNU0o/oNblF3pwjNhend/N5SR9L0EvjGbM=;
 b=UL39DSEHzOdFBmWK5nEpwXbq2Rsb3o6MeHWfVjfj13kHDFw+DCKnCorcUUqNhs0P+e32Is
 wD0cSZxZC7vEk5gOUBhzE9/o695rrlDwhPYPh5Yj/t7CQJ/AwuSUibrSEvQpkxiMaXf8qT
 mmdqyffrtEOAA/Y988R4CnyL7KGyFEg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-rCp-w6Y1OUOjONcoBbyJyg-1; Fri, 10 Mar 2023 04:09:42 -0500
X-MC-Unique: rCp-w6Y1OUOjONcoBbyJyg-1
Received: by mail-wm1-f72.google.com with SMTP id
 s18-20020a7bc392000000b003deaf780ab6so1743771wmj.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 01:09:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678439381;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lsjkU85N4FNU0o/oNblF3pwjNhend/N5SR9L0EvjGbM=;
 b=c8P+fasG/Nra5HYFj7JuKXsUSQGZrZcaXvFwAGhC/RVtJLAigPPDK1yXljZibkUH4n
 177er+sOSAzo2ybJMxWhdxEvEEfo+K64/diVWXaVqG6XEYLCIrHSIx50SB6ymF8cOukH
 XwF7pSOJBcMaj6ARlyKBn/T1SjvXLS5hHq8ksuFVK12qBnq+ZU/1EofPIThyaKhCi6TC
 JBeUfO4V32zrpYcdfxJlzPAltOWKrqlRwQTzNDXodGSSDLqEAypbGJlwZgoOaabm73CO
 /U4OaS/6FPIBABOfi2/1zaQfZACnRv3Ln+u8fociq0x07t/u9E2YWohSuAcHiflZU+KQ
 /HRw==
X-Gm-Message-State: AO0yUKWr5tWTFpX2D66la2z+0xjThxxe7X38uGhSfa0cfYlOSdRAyw4u
 MNC8PaQWtFk7KYH1R1USqmN/MPyKIVtE/+PyRadPVMHpx7D8rB3Hp1sU4pffmQUMYY7RzCDLOHe
 UvTd3bwPac7MUfxqqzqWF//Ygthw7jLdSlN2dIQ3loQ==
X-Received: by 2002:a05:600c:5493:b0:3ea:edc7:aa59 with SMTP id
 iv19-20020a05600c549300b003eaedc7aa59mr1966018wmb.32.1678439381608; 
 Fri, 10 Mar 2023 01:09:41 -0800 (PST)
X-Google-Smtp-Source: AK7set82DcNAbEYxkRgzwkXhtStyGRG6ScEq9WaLV3HetEFKZK8m0CtX+X41h5pDK46UpFBKYqStZQ==
X-Received: by 2002:a05:600c:5493:b0:3ea:edc7:aa59 with SMTP id
 iv19-20020a05600c549300b003eaedc7aa59mr1965990wmb.32.1678439381344; 
 Fri, 10 Mar 2023 01:09:41 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 n12-20020a5d67cc000000b002c8476dde7asm1539421wrw.114.2023.03.10.01.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Mar 2023 01:09:40 -0800 (PST)
Date: Fri, 10 Mar 2023 10:09:37 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [RFC PATCH v4 0/4] several updates to virtio/vsock
Message-ID: <20230310090937.s55af2fx56zn4ewu@sgarzare-redhat>
References: <1804d100-1652-d463-8627-da93cb61144e@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <1804d100-1652-d463-8627-da93cb61144e@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: oxffffaa@gmail.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Arseniy,

On Thu, Mar 09, 2023 at 11:24:42PM +0300, Arseniy Krasnov wrote:
>Hello,
>
>this patchset evolved from previous v2 version (see link below). It does
>several updates to virtio/vsock:
>1) Changes 'virtio_transport_inc/dec_rx_pkt()' interface. Now instead of
>   using skbuff state ('head' and 'data' pointers) to update 'fwd_cnt'
>   and 'rx_bytes', integer value is passed as an input argument. This
>   makes code more simple, because in this case we don't need to update
>   skbuff state before calling 'virtio_transport_inc/dec_rx_pkt()'. In
>   more common words - we don't need to change skbuff state to update
>   'rx_bytes' and 'fwd_cnt' correctly.
>2) For SOCK_STREAM, when copying data to user fails, current skbuff is
>   not dropped. Next read attempt will use same skbuff and last offset.
>   Instead of 'skb_dequeue()', 'skb_peek()' + '__skb_unlink()' are used.
>   This behaviour was implemented before skbuff support.
>3) For SOCK_SEQPACKET it removes unneeded 'skb_pull()' call, because for
>   this type of socket each skbuff is used only once: after removing it
>   from socket's queue, it will be freed anyway.

thanks for the fixes, I would wait a few days to see if there are any
comments and then I think you can send it on net without RFC.

@Bobby if you can take a look, your ack would be appreciated :-)

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

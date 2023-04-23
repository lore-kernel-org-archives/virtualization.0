Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98488C6FD18
	for <virtualization@archiver.kernel.org>; Sun, 23 Apr 2023 20:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D96FF415FB;
	Sun, 23 Apr 2023 20:42:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D96FF415FB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gb+HIoUe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rLTgEsxLvb8p; Sun, 23 Apr 2023 20:42:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E7684415ED;
	Sun, 23 Apr 2023 20:42:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E7684415ED
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8EB1C0036;
	Sun, 23 Apr 2023 20:42:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F12BC002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 20:42:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 51199606E6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 20:42:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 51199606E6
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gb+HIoUe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nja9Po5nuP_P
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 20:42:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 952EF60E44
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 952EF60E44
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 20:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682282536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7QcY3a3kH0+Rq9gUuMPOzuma/qnGDgBISD5Gp0wCqpU=;
 b=gb+HIoUeLIOBkEaAgTXw+1aqqmGvqynD/h0OChsbYhCORq2nt4fRWj8a7ixuvxsiimNykq
 9PWiS7J/NhRMjmylD8uwLpXV4Lv6q3NFsTNlur2/Y9Un60iz61CllVsnz/KAEQ2Pv55Z2i
 6SFiOkkFeGJcOVkLwDsgmyOKgzq6p0c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-i0URGhrpMy2Ko9J59kBCXQ-1; Sun, 23 Apr 2023 16:42:15 -0400
X-MC-Unique: i0URGhrpMy2Ko9J59kBCXQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30479b764f9so121824f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 13:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682282534; x=1684874534;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7QcY3a3kH0+Rq9gUuMPOzuma/qnGDgBISD5Gp0wCqpU=;
 b=ZHN9pqLsuQ1Zl0BSkZBjFrbbfqL9JAGdjvVU4p5pYJgToTTy6niNqdbPtgWLNJi1wI
 vDTPCYAI7WtNk/iV2IRJdsTIgTMZ1NdLrrTRYkIytWjhmE8qBEvFkmKcj1gP2btQDYrO
 ux1DiojOTD1+O0DKR1ri9DGf2TUBOIDWIE5aRKxaZrZ/wghYilcwl6Tbw52inJB7Ap3S
 BA4RX1ToSSru6jltMatEx3I/NlaIyqWJWx7Dn+EQsDtsc0OyF/98JRnAVcjE9aoTNKYj
 KzzX4AwP/RhOq650TTRlCoMdw84LQm/BS85IpWqfysdHJoruXMbXojzHJ7Lp1ts5/Alu
 hcRQ==
X-Gm-Message-State: AAQBX9cxcJ+qZPiB7vgPL072G/1cIOO06o5nSifdlRmatDASchiy+0SB
 Af7VUKhR5rDhyahvKGuaKBrtOqmfE8LW6bYjDKodmQ/LTOeXqhcsJD3VqK1L9f8tVEcCUdxQjS0
 NlAlnzGLIzhdCeIJZogEbi0nGBEZ/Pnv4riFDJUmeVw==
X-Received: by 2002:a5d:4e01:0:b0:304:6715:8728 with SMTP id
 p1-20020a5d4e01000000b0030467158728mr4236855wrt.18.1682282533890; 
 Sun, 23 Apr 2023 13:42:13 -0700 (PDT)
X-Google-Smtp-Source: AKy350YdnKi+ZHb6STgweUlm/aZE45mVPCJXP21umah/V38ji93a8lhhwXhK5QKMqTIOSKpR49O6oQ==
X-Received: by 2002:a5d:4e01:0:b0:304:6715:8728 with SMTP id
 p1-20020a5d4e01000000b0030467158728mr4236836wrt.18.1682282533574; 
 Sun, 23 Apr 2023 13:42:13 -0700 (PDT)
Received: from redhat.com ([2.55.17.255]) by smtp.gmail.com with ESMTPSA id
 c1-20020a5d4f01000000b002fc0de07930sm9307913wru.13.2023.04.23.13.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Apr 2023 13:42:12 -0700 (PDT)
Date: Sun, 23 Apr 2023 16:42:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net-next v1] xsk: introduce xsk_dma_cbs
Message-ID: <20230423161828-mutt-send-email-mst@kernel.org>
References: <20230423062546.96880-1-xuanzhuo@linux.alibaba.com>
 <ZETUAMqKc8iLhTk3@kroah.com>
MIME-Version: 1.0
In-Reply-To: <ZETUAMqKc8iLhTk3@kroah.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

On Sun, Apr 23, 2023 at 08:45:20AM +0200, Greg KH wrote:
> On Sun, Apr 23, 2023 at 02:25:45PM +0800, Xuan Zhuo wrote:
> > The purpose of this patch is to allow driver pass the own dma callbacks
> > to xsk.
> > 
> > This is to cope with the scene of virtio-net. If virtio does not have
> > VIRTIO_F_ACCESS_PLATFORM, then virtio cannot use DMA API. In this case,
> > xsk cannot use DMA API directly to achieve DMA address. Based on this
> > scene, we must let xsk support driver to use the driver's dma callbacks.
> 
> Why does virtio need to use dma?  That seems to go against the overall
> goal of virtio's new security restrictions that are being proposed
> (where they do NOT want it to use dma as it is not secure).

Yes, they exactly use dma, specifically dma into bounce buffer.



_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

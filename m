Return-Path: <SRS0=15I4=NC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FD7C4338F
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 09:09:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1BFD60FC0
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 09:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B1BFD60FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 695B7404F2;
	Wed, 11 Aug 2021 09:09:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nRs2-TNq90Jy; Wed, 11 Aug 2021 09:09:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 06A7C404A2;
	Wed, 11 Aug 2021 09:09:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C83C3C001A;
	Wed, 11 Aug 2021 09:09:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D7E6C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:09:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8B172402E5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:09:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BYvhjyQ5tOtu
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:09:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2B16D402E0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628672948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JLjNDQUWebauLItmfnlQ+Tjthn4pJvLabefx75OaW6Y=;
 b=KbKy2lzWr3YkRHCEohOAq0kD/V8j1sThxlXUECjI6qN4J+32ilbkSWLr0gPFbddBoo1678
 Ah5wM2FitoIOgcknEOMhP3VJRNo8FABbJAz3L/GnD9guUTb9dShgAu90n+fl4qRaxK9Ict
 9IGCWHTIBElxjvuhyp4FhpDb2A2fTW4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-l_iLElGsN2WySmaezbdLtA-1; Wed, 11 Aug 2021 05:09:07 -0400
X-MC-Unique: l_iLElGsN2WySmaezbdLtA-1
Received: by mail-ed1-f69.google.com with SMTP id
 cm18-20020a0564020c92b02903bc7f21d540so892807edb.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 02:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JLjNDQUWebauLItmfnlQ+Tjthn4pJvLabefx75OaW6Y=;
 b=kRCASKitdM5X1/xI2cpcATuEeP4qTqGvNFIJ9t53OdD5MdaJyA30UMEXC2J88quMG0
 RD8SWHkHz3+XAduZKMjY2+xbDOVoYFjIltxhKWwksZaQcpS3XBgnjo8jBDGxtDI4r9QC
 u6QYvnjL3wCfahkFldtjuGR8CyJ+/w9rfDx2rjs3c/UlWzc+Iu9DUZNzB4NUklMCD6Cb
 3duaWtcgLAFasDjn+WoscCyomkegD255v70CrJzPsVEhgHyUO49yMVwuCbXaW89BTAlz
 hehKtdv1CmIm6+ICtI8xPdGKiV0K7joOOC7aE8gDRK0Ujkq2IPJEbRwJ0+gSE5nyXE4j
 0giA==
X-Gm-Message-State: AOAM533wRUUP4jxH5hRi8vcOEl9RK494/9gM+p5t/0DQI5uyMK68Yal3
 nlVXa/Su8sfNPDAvA4BqLS2dH6sC3l/b7ewLy5TE7HdH2k9967cEtYrVcwmDuN/EfJgF/AoDAWh
 91wpRijg6BY/lCr1+I+n8s2UVmnNPMzAW6OTjN5gqbw==
X-Received: by 2002:a17:907:35d0:: with SMTP id
 ap16mr2641397ejc.456.1628672946563; 
 Wed, 11 Aug 2021 02:09:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw62doxoYPXhN9D22tEpGdIMeHAaw1IFlIKoYlluOKCXwbBvIxBAtg09tZOA20KjkBX0c0KiA==
X-Received: by 2002:a17:907:35d0:: with SMTP id
 ap16mr2641373ejc.456.1628672946373; 
 Wed, 11 Aug 2021 02:09:06 -0700 (PDT)
Received: from steredhat (a-nu5-14.tin.it. [212.216.181.13])
 by smtp.gmail.com with ESMTPSA id p23sm11040297edw.94.2021.08.11.02.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Aug 2021 02:09:06 -0700 (PDT)
Date: Wed, 11 Aug 2021 11:09:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v2 3/5] virito/vsock: support MSG_EOR bit processing
Message-ID: <20210811090903.27tcokpqofujhhgp@steredhat>
References: <20210810113901.1214116-1-arseny.krasnov@kaspersky.com>
 <20210810114035.1214740-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210810114035.1214740-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, stsp2@yandex.ru,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Colin Ian King <colin.king@canonical.com>,
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

On Tue, Aug 10, 2021 at 02:40:32PM +0300, Arseny Krasnov wrote:
>If packet has 'EOR' bit - set MSG_EOR in 'recvmsg()' flags.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 4d5a93beceb0..59ee1be5a6dd 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -76,8 +76,12 @@ virtio_transport_alloc_pkt(struct virtio_vsock_pkt_info *info,
> 			goto out;
>
> 		if (msg_data_left(info->msg) == 0 &&
>-		    info->type == VIRTIO_VSOCK_TYPE_SEQPACKET)
>+		    info->type == VIRTIO_VSOCK_TYPE_SEQPACKET) {
> 			pkt->hdr.flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
>+
>+			if (info->msg->msg_flags & MSG_EOR)
>+				pkt->hdr.flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
>+		}
> 	}
>
> 	trace_virtio_transport_alloc_pkt(src_cid, src_port,
>@@ -460,6 +464,9 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
> 		if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOM) {
> 			msg_ready = true;
> 			vvs->msg_count--;
>+
>+			if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOR)
>+				msg->msg_flags |= MSG_EOR;
> 		}
>
> 		virtio_transport_dec_rx_pkt(vvs, pkt);
>-- 
>2.25.1
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

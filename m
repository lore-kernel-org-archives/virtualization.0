Return-Path: <SRS0=TAdK=JJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6A4C433B4
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 22:05:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBDE66124B
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 22:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDE66124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9295A402E7;
	Mon, 12 Apr 2021 22:05:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7K-EfENeDQvi; Mon, 12 Apr 2021 22:05:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19AD24052B;
	Mon, 12 Apr 2021 22:05:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E309DC000C;
	Mon, 12 Apr 2021 22:05:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F8F2C000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:05:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9985460B32
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:03:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xRs7ckBIcQMV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:03:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D943F60B31
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618265032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=leWNWd+JCLyGmHEQBEQfB/cGYdo6+6fwiBlPQ2IHRak=;
 b=hl36wYhBXvhQWsXBGHh7IrKgNVPpOKB4l36ua20KYnzpHH5pMIYMZ/6sNY5Vefe/Cab0HS
 s2LSCftgVAcN8OWnVfThAXVK9axafHTOEng1dMaobJP2LCYXSW8uhbBg1v+0L3xxdBDggX
 wj8ScGuGRatVjr4vMdniiSV/C7/t36k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-fzrAhTzxO_WgwVSxDpf5aA-1; Mon, 12 Apr 2021 18:03:51 -0400
X-MC-Unique: fzrAhTzxO_WgwVSxDpf5aA-1
Received: by mail-wm1-f72.google.com with SMTP id
 x20-20020a7bc2140000b029012bb4d2b5d6so249192wmi.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 15:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=leWNWd+JCLyGmHEQBEQfB/cGYdo6+6fwiBlPQ2IHRak=;
 b=K5RYfPH0bcCbl+O2XXhS4TeozFcm/UcN84eMSdAD+A+3rVu9lpef834bIAPRTnLe5y
 fkVv4i2ue9SsDcRyyTapeB27G1GIB5GVOlAjj+G7v9zXPV2g8cljS45sYh9ImVfTD3wc
 M0h2sEzxNE4HwXu8cpBDFu4RJ9WY0Le46iqEGtgh2cGoOeY89ZtDyIcixWPy8lWpUelT
 k1+wwEwodH6sUSGEO6CmGoLrBau1JSwr7NexaTCVX7fJVRGadQr4gcS/yPGsweaMGF9e
 d4hJwXQi0SGjBzdTI0Od5nrQPazjfagfZjVM0ssa09/mubcVxplH6U0nLX/UpUCk/h8L
 yAOg==
X-Gm-Message-State: AOAM533FL9tEskuPVaT4x/HBq38umLZDHeQsoJe6Xm8b1AiZoTuLTpNw
 +s+xQQkCurdDLsS1ljVf/9GawlRb9g5SU+N78oK2pE7xw9fQb3U2uALJ9JIQHyTjWm6tzgQvZdY
 QLElSAvJFQH0t5NcdSDrqOTk8Z/tz0nfaHD9Q+Pjr8A==
X-Received: by 2002:a05:6000:12cb:: with SMTP id
 l11mr13400868wrx.267.1618265030132; 
 Mon, 12 Apr 2021 15:03:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweg8UOE2ZsiZfHi1qDoF06GNmIO7OCOuwIxcOmOr8OtmbITf2h/rMoSuTHu57FodKRe0dBcQ==
X-Received: by 2002:a05:6000:12cb:: with SMTP id
 l11mr13400850wrx.267.1618265029935; 
 Mon, 12 Apr 2021 15:03:49 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id u3sm535389wmg.48.2021.04.12.15.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Apr 2021 15:03:49 -0700 (PDT)
Date: Mon, 12 Apr 2021 18:03:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: virtio-net: locking in tx napi
Message-ID: <20210412175341-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Willem de Bruijn <willemb@google.com>,
 virtualization@lists.linux-foundation.org
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

I was working on the spurios interrupt problem and
I noticed something weird.

static int virtnet_poll_tx(struct napi_struct *napi, int budget)
{       
        struct send_queue *sq = container_of(napi, struct send_queue, napi);
        struct virtnet_info *vi = sq->vq->vdev->priv;
        unsigned int index = vq2txq(sq->vq);
        struct netdev_queue *txq;

        if (unlikely(is_xdp_raw_buffer_queue(vi, index))) {
                /* We don't need to enable cb for XDP */
                napi_complete_done(napi, 0);
                return 0;
        }

        txq = netdev_get_tx_queue(vi->dev, index);
        __netif_tx_lock(txq, raw_smp_processor_id());
        free_old_xmit_skbs(sq, true);
        __netif_tx_unlock(txq);
        
        virtqueue_napi_complete(napi, sq->vq, 0);
        
        if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
                netif_tx_wake_queue(txq);
        
        return 0;
}       

So virtqueue_napi_complete is called when txq is not locked,
thinkably start_xmit can happen right?

Now virtqueue_napi_complete

static void virtqueue_napi_complete(struct napi_struct *napi,
                                    struct virtqueue *vq, int processed)
{
        int opaque;

        opaque = virtqueue_enable_cb_prepare(vq);
        if (napi_complete_done(napi, processed)) {
                if (unlikely(virtqueue_poll(vq, opaque)))
                        virtqueue_napi_schedule(napi, vq);
        } else {
                virtqueue_disable_cb(vq);
        }
}


So it is calling virtqueue_enable_cb_prepare but tx queue
could be running and can process things in parallel ...
What gives? I suspect this corrupts the ring, and explains
why we are seeing weird hangs with vhost packed ring ...

Jason?


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

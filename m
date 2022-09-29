Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D675CC04A95
	for <virtualization@archiver.kernel.org>; Thu, 29 Sep 2022 07:21:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5400E40562;
	Thu, 29 Sep 2022 07:21:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5400E40562
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eZeTkx23
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4hA34IWQ4CVQ; Thu, 29 Sep 2022 07:21:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D5A164031D;
	Thu, 29 Sep 2022 07:21:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D5A164031D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A55BAC0033;
	Thu, 29 Sep 2022 07:21:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E629C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:20:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6F57B61050
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:20:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6F57B61050
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eZeTkx23
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SU56RNLBd8j4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:20:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ADF9760FA7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ADF9760FA7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664436057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yxu15vAKQS2WXD0gsXTOOLgZWkPdFYG9v1N46mFFXC0=;
 b=eZeTkx23+iOCTrmsiBJcKEuRiSJv2Rx8QST5JIHuwzdCcPbO/J+c4ycgbaSq7leyP8R9V3
 OiYMCO7NRRiSeCSU20QAPmmZeTYPAKaEgu8z2Ngn0jznAJxrgM24zfmiVfhkWnOe1Nhs0r
 EHm7cOZNIZxE6BKyoEUlOThOznPc8I4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-79-uTl3E5XKNhKqVfx1SLIsuQ-1; Thu, 29 Sep 2022 03:20:56 -0400
X-MC-Unique: uTl3E5XKNhKqVfx1SLIsuQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 g27-20020adfa49b000000b0022cd5476cc7so162323wrb.17
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 00:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=Yxu15vAKQS2WXD0gsXTOOLgZWkPdFYG9v1N46mFFXC0=;
 b=RL4xYLeE+NaBpH8aoYjoaZIEqb0PAsGmR795f2szg1RpTpgxVNqp2PxxkB2BKtYyKz
 hre6iHiye63LRrzuM3uJZZnbQUXaf/Df7FrQXABKrnqMNrHK2EjPvZGxP1fq7kbrmjyl
 RAaNFb5eP+G88GIVyNoXzkgn+JrzCsJQgsrGexnByIQAZTQMHvY9Nh5F14tr/FH6+Ose
 GHmud9gNAx2NWV6gN9/JyTOxPaNBH+QwZxfZcNWA3woE+ijZ6JucLIbtQKWqci31+uoN
 WwLIoUj8X36R/0LDu0qpRqXkHRMHch+31zYUbyYVyKJ6bzhDcaCZmf2aJK6XMlXA0C7l
 8nig==
X-Gm-Message-State: ACrzQf3/Gbkg+1Q7sz64rEEmtgxhOX0xZAXj51gOGVYpdK2tNGTVGHrL
 IOMpkbbxP4YKn19kLwwG+b+yNYePYFwBzKuGsP0dQa4Ww+2OjU4xNYbqFml87LwTnK2J+/rECmd
 cvcyPnPvsBaPuTCOBnRGX7obAJCPSW+L6Z7JStiaMxw==
X-Received: by 2002:a5d:504c:0:b0:228:db0e:a4c9 with SMTP id
 h12-20020a5d504c000000b00228db0ea4c9mr1131263wrt.272.1664436054955; 
 Thu, 29 Sep 2022 00:20:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Lv67ReK3M+Rk6mB4cCy/9C7m/j2G4paBf0iR0OSUz63VsmnQMskPm6jefPhoMdNf5x+y/oA==
X-Received: by 2002:a5d:504c:0:b0:228:db0e:a4c9 with SMTP id
 h12-20020a5d504c000000b00228db0ea4c9mr1131247wrt.272.1664436054644; 
 Thu, 29 Sep 2022 00:20:54 -0700 (PDT)
Received: from redhat.com ([2.55.47.213]) by smtp.gmail.com with ESMTPSA id
 q17-20020a05600c46d100b003b56be51138sm3428003wmo.31.2022.09.29.00.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Sep 2022 00:20:54 -0700 (PDT)
Date: Thu, 29 Sep 2022 03:20:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH v3] virtio_blk: add SECURE ERASE command support
Message-ID: <20220929032021-mutt-send-email-mst@kernel.org>
References: <20220921082729.2516779-1-alvaro.karsz@solid-run.com>
 <YyyfJQo7N/iMPLNP@fedora>
 <CAJs=3_BXGpu-kDq1_bJSanh-iY63uwpc2tZtH6jOYcqBUptsNA@mail.gmail.com>
 <20220928091512-mutt-send-email-mst@kernel.org>
 <CAJs=3_CmKjhS=Y3JHujws9y5KmN-AbSRXTnt1aZOhDzMuK7g3Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_CmKjhS=Y3JHujws9y5KmN-AbSRXTnt1aZOhDzMuK7g3Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
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

On Thu, Sep 29, 2022 at 10:13:47AM +0300, Alvaro Karsz wrote:
> > Could you explain this last part? Why are they used without
> > VIRTIO_BLK_F_DISCARD?
> 
> 
> Sure,
> 
> If both  VIRTIO_BLK_F_DISCARD and VIRTIO_BLK_F_SECURE_ERASE are negotiated:
> q->limits.max_discard_segments =
> min(virtio_blk_config->max_discard_seg,
> virtio_blk_config->max_secure_erase_seg)
> 
> If VIRTIO_BLK_F_DISCARD is negotiated and VIRTIO_BLK_F_SECURE_ERASE isn't
> q->limits.max_discard_segments = virtio_blk_config->max_discard_seg
> 
> If VIRTIO_BLK_F_SECURE_ERASE is negotiated and VIRTIO_BLK_F_DISCARD isn't
> q->limits.max_discard_segments = virtio_blk_config->max_secure_erase_seg

OK so virtio_blk_config->max_discard_seg is unused without
VIRTIO_BLK_F_DISCARD.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

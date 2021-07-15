Return-Path: <SRS0=ciji=MH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4854C07E96
	for <virtualization@archiver.kernel.org>; Thu, 15 Jul 2021 11:22:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E431613BA
	for <virtualization@archiver.kernel.org>; Thu, 15 Jul 2021 11:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E431613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 287C660B58;
	Thu, 15 Jul 2021 11:22:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wu4lA3t1xCDi; Thu, 15 Jul 2021 11:22:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A697860600;
	Thu, 15 Jul 2021 11:22:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 840F8C001A;
	Thu, 15 Jul 2021 11:22:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0098C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 11:22:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C838982416
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 11:22:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dy5MKAjgTUgD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 11:22:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C57DD81D88
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 11:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626348146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n3XMjsLqmL6fZAAA+JBtyt58Zb9isCAphRrAoufbmyY=;
 b=gGqXWSAqUdtKoN5RqiXiSDJUUylntgAneUf/dCPJRUcfVFBGKTyeYzC+KF+S5ICn2Uxv71
 wW6MXE/U+n4CJ/OJyy6NLmGm0TtR5TyvIWkBCXTS7j5zbIEj70iSxQQkRFH0pdRTmFgWnb
 HdIjhrOEZoNnoHrcpO8QW9cFSpP4kmM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-NhDqJVU0Mw2jLiTTlJAnqw-1; Thu, 15 Jul 2021 07:22:25 -0400
X-MC-Unique: NhDqJVU0Mw2jLiTTlJAnqw-1
Received: by mail-wr1-f70.google.com with SMTP id
 d8-20020adf9c880000b0290141a87409b5so2336336wre.16
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 04:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n3XMjsLqmL6fZAAA+JBtyt58Zb9isCAphRrAoufbmyY=;
 b=ghyyjGPJPCMsUqccApyMQaMwgqgrfKthSR4iEmPcQTrcEbETQvFR9YLdJI6g3IlyNp
 tmQVW+AyFtaD6SsTQsL8pbFHnES8s0W8YScp/Ztezr0abXHNJ+U8FzKzqa8Z/dkq0VDm
 PPaaM3VGFxvR/GF2E0+0CKa/4LC/GCDjh9W5UUdY+NFe2JQrUkYUpq0UZ6tcKzJ9/brG
 V9+j37qWtZAjVJkyEXzpdRVHAnJAcyMxZNb9PHD7vLV0BCUhGXClRgeaP9HHOLiQCjy6
 WL79L3XrDfg9kuNEfbcFk7cpnbGY2SApTQu8EMmt5LPdiCC2ZZSCz3MgXRlIvFVRCXgW
 E9/g==
X-Gm-Message-State: AOAM532f7Cpj3TQjkf9OfiGZjhyBf/xPinJJzbCQsysI74DkrpMxRPuN
 ex+i/iR/n6kDn+zYzSn+lER63Bp0XbcUSO38Rho9dBR3xjkiZaB+k8GwQRddKUJOOMUE69WN6Xs
 /pCz56Gb5tymG/YkHFbAiMOi/2PHOoKu10N3AGKb58Q==
X-Received: by 2002:a5d:52d0:: with SMTP id r16mr4822765wrv.323.1626348143924; 
 Thu, 15 Jul 2021 04:22:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxUBHhfe+A3WtzBYo5eZtyU+fS1EBqnOvDIUROVv21BrPU/0Ixxe0AbzLRTePqxWt25P3MgA==
X-Received: by 2002:a5d:52d0:: with SMTP id r16mr4822740wrv.323.1626348143761; 
 Thu, 15 Jul 2021 04:22:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a?
 ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
 by smtp.gmail.com with ESMTPSA id w15sm8708936wmi.3.2021.07.15.04.22.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jul 2021 04:22:22 -0700 (PDT)
Subject: Re: [PATCH 1/1] virtio: disable partitions scanning for no partitions
 block
To: Yury Kamenev <damtev@yandex-team.ru>, mst@redhat.com,
 jasowang@redhat.com, stefanha@redhat.com, axboe@kernel.dk, hch@lst.de,
 cand@gmx.com, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210715094707.19997-1-damtev@yandex-team.ru>
 <20210715094707.19997-2-damtev@yandex-team.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9bd3c75a-63b3-427c-c54c-cd12587ba58b@redhat.com>
Date: Thu, 15 Jul 2021 13:22:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715094707.19997-2-damtev@yandex-team.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

On 15/07/21 11:47, Yury Kamenev wrote:
> +#ifdef CONFIG_VIRTIO_BLK_NO_PART_SCAN
> +	if (unlikely(partitions_scanning_disable))
> +		/* disable partitions scanning if it was stated in virtio features*/
> +		if (virtio_has_feature(vdev, VIRTIO_BLK_F_NO_PART_SCAN))
> +			vblk->disk->flags |= GENHD_FL_NO_PART_SCAN;
> +#endif
> +

Has this been added to the spec?  It doesn't seem like a good idea, as 
pointed out by Stefan[1], Christoph[2] and myself[3].

Paolo

[1] 
https://lore.kernel.org/linux-block/20210524145654.GA2632@lst.de/T/#m2697cb41578490aad49ed1d8fa6604bf0924b54d
[2] 
https://lore.kernel.org/linux-block/20210524145654.GA2632@lst.de/T/#mc59329fd824102f94ac2f6b29fe94a652849aca0
[3] 
https://lore.kernel.org/linux-block/20210524145654.GA2632@lst.de/T/#mee6787c4fd87790b64feccc9e77fd5f618c2c336

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

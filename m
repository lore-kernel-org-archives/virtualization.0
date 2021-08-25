Return-Path: <SRS0=Jt+z=NQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4970C432BE
	for <virtualization@archiver.kernel.org>; Wed, 25 Aug 2021 09:56:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5438F61163
	for <virtualization@archiver.kernel.org>; Wed, 25 Aug 2021 09:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5438F61163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DA574073E;
	Wed, 25 Aug 2021 09:56:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u7-UvTURD2zB; Wed, 25 Aug 2021 09:56:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BB67C4071F;
	Wed, 25 Aug 2021 09:56:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9564BC001A;
	Wed, 25 Aug 2021 09:56:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CDDBC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 09:56:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C35581B70
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 09:56:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TE1E_tG0oxj9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 09:56:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6A48D81B84
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 09:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629885404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IbX2EecV5LBWjWsi1lKWDf6E0aOIheSxNWCS75bBS1I=;
 b=LtgLSJGPTxg8Y+25T1JJz4LFWiwbU2vNjjnKuEBzviVT3msb35Pu6HBfwOgOpR6G/ClE8g
 EkgEFeIkJaRlsQ78SKtj30e2wzLxryy9IK53OFXpnHnyf6c/+aRu4wqXSydvdsD/ZIMlPk
 UHeKz3MCSk45kPwkmhl526Xu4FoO+D8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-HY6KowXWM2OsnEy6EZc51g-1; Wed, 25 Aug 2021 05:56:43 -0400
X-MC-Unique: HY6KowXWM2OsnEy6EZc51g-1
Received: by mail-wm1-f69.google.com with SMTP id
 j33-20020a05600c48a100b002e879427915so1608227wmp.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 02:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:organization:subject
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=IbX2EecV5LBWjWsi1lKWDf6E0aOIheSxNWCS75bBS1I=;
 b=HdAZh9d7QX8siI/spFLf888Geeu+r8H4LiBcF42rO/LAi8NofzQl63Zkw16S0kNdmB
 PTg5JTbyF/wzKgvWCKHZU5PmmhmY00y+GdtEcjjB5xQe25m+Nbv6LyCFPR/K2uNpmFgd
 HqRD/556RxGtZQUUlxm50Kg2QwRDU9jf5fc+kt9tsAd5xrsw1VHTK7GTgh2cDjkGz6AU
 Td4DVlftYJmtzW3MmwM3xVuHSEceOY3vS1wQUjqDjDZIVjnzi28RsXws1+74YJvkUOx9
 aMani6qwmEcDc/4ywVmZVzEC9J3sIdksEmedV1xvM6MvBo4iPwPbp8nfYuGDvg1Iy4er
 LFcA==
X-Gm-Message-State: AOAM532p0HWcbnPaET373LgO0qF8QtnbhaZ/CLwNQvjX1cHi+1vG4EZC
 MM5F9bG6iQzYQkLehTFGMtOzWNMy4cRXrFcAQdy5I3SGatOExX2r64TjNeJ++hGuqOQmqq2mLmN
 BzbRjEVu1pZ+VS70hOFs2RXMfVKtyijiGhsqmtNsUtICvehG7XcO5BRvat9DTH4ea7paCSq7cPD
 AnObNyWQ22FuFEiQ==
X-Received: by 2002:a7b:cc0a:: with SMTP id f10mr8506814wmh.32.1629885401822; 
 Wed, 25 Aug 2021 02:56:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2aVs6FOtt5CLl3BKWQpw5n+0fwgrNW046pl6dWUX0aOn50Mknm3MHnZcOznm14rqNY1Mvew==
X-Received: by 2002:a7b:cc0a:: with SMTP id f10mr8506799wmh.32.1629885401567; 
 Wed, 25 Aug 2021 02:56:41 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23d6b.dip0.t-ipconnect.de. [79.242.61.107])
 by smtp.gmail.com with ESMTPSA id y11sm25017992wru.0.2021.08.25.02.56.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Aug 2021 02:56:41 -0700 (PDT)
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20210825094053.GA31594@kili>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [bug report] virtio-mem: use page_offline_(start|end) when
 setting PageOffline()
Message-ID: <cd0aff44-ba5f-2b9c-8154-072a65b65cc1@redhat.com>
Date: Wed, 25 Aug 2021 11:56:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210825094053.GA31594@kili>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org
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

On 25.08.21 11:40, Dan Carpenter wrote:
> Hello David Hildenbrand,
> 
> The patch 6cc26d77613a: "virtio-mem: use page_offline_(start|end)
> when setting PageOffline()" from Jun 30, 2021, leads to the following
> Smatch static checker warning:
> 
> 	drivers/virtio/virtio_mem.c:1072 virtio_mem_set_fake_offline()
> 	warn: sleeping in atomic context
> 
> drivers/virtio/virtio_mem.c
>      1069 static void virtio_mem_set_fake_offline(unsigned long pfn,
>      1070 					unsigned long nr_pages, bool onlined)
>      1071 {
> --> 1072 	page_offline_begin();
> 
> virtio_mem_online_page_cb() is holding rcu_read_lock() so calling
> page_offline_begin() here is sleeping in atomic bug.
> 
>      1073 	for (; nr_pages--; pfn++) {
>      1074 		struct page *page = pfn_to_page(pfn);
>      1075
>      1076 		__SetPageOffline(page);
>      1077 		if (!onlined) {
>      1078 			SetPageDirty(page);
>      1079 			/* FIXME: remove after cleanups */
>      1080 			ClearPageReserved(page);
>      1081 		}
>      1082 	}
>      1083 	page_offline_end();
>      1084 }

Ah, thanks for that report!


diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 09ed55de07d7..9e9922c60da4 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1242,12 +1242,19 @@ static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
                         do_online = virtio_mem_bbm_get_bb_state(vm, id) !=
                                     VIRTIO_MEM_BBM_BB_FAKE_OFFLINE;
                 }
+
+               /*
+                * virtio_mem_set_fake_offline() might sleep, we don't need
+                * the device anymore. See virtio_mem_remove() how races
+                * with device removal are avoided.
+                */
+               rcu_read_unlock();
+
                 if (do_online)
                         generic_online_page(page, order);
                 else
                         virtio_mem_set_fake_offline(PFN_DOWN(addr), 1 << order,
                                                     false);
-               rcu_read_unlock();
                 return;
         }
         rcu_read_unlock();


Will send out a patch shortly.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

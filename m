Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC1BC76188
	for <virtualization@archiver.kernel.org>; Mon,  3 Apr 2023 17:36:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFC4C60A9E;
	Mon,  3 Apr 2023 17:36:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BFC4C60A9E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MqUxAv3q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FxrWJGs5y4Oj; Mon,  3 Apr 2023 17:36:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 42C8A606B0;
	Mon,  3 Apr 2023 17:36:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42C8A606B0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C4D7C0037;
	Mon,  3 Apr 2023 17:36:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22E3CC002F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 17:36:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DDBAF409B5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 17:36:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DDBAF409B5
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MqUxAv3q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GkfvFpYH3MG8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 17:36:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F09E409B0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F09E409B0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 17:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680543373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kRxa0YKbguBcG37lL5IXPmAB9UHNR9qC66djwGg5+XY=;
 b=MqUxAv3qbBTN9tH/Rt+Lu3UlsmCcb+h7fQgOqjoJ1aUfsKFYD+FlIMgDc6HIHEibypqbia
 wfa15tXOUJG4DhjVU9ajNytqfcGiMuad5sQHh73iucRY7Z1WqAzFavgHtnin64HECpletb
 ltOFzCr6UJY47R3jLrytj7jp5eBl8f8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-rWmfUV4DNhWBufMsmIHOCg-1; Mon, 03 Apr 2023 13:36:07 -0400
X-MC-Unique: rWmfUV4DNhWBufMsmIHOCg-1
Received: by mail-ed1-f72.google.com with SMTP id
 j21-20020a508a95000000b004fd82403c91so41917657edj.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Apr 2023 10:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680543366;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kRxa0YKbguBcG37lL5IXPmAB9UHNR9qC66djwGg5+XY=;
 b=jn9WRBYU4HfTb5ExYimsJiz2AEutDR6BA0CuIWknhhRJO3pdoxqfkL3VgCUElY9w2L
 aSOuSUeULWjW4DJ/CVeX6os+ML3G1JXp9ETaq88feN0FulPQGvBP7XT1tr8WwWhdDec4
 3eNryXH1yLOof2bGnU+wUqh76O9iMcCIBG5dCCQQMtT84sQr2GvtOOTqZoQV7l9b+ixn
 T9cbdtfxYPnUOhRvToHik2fmylYgipMfHAKW28uNwke4EPgSYCHJZRC0seUv+I/7+Fpu
 N7OGS9o1wpDuSx0zHCk7ciaCJINUQ7O0hn5BhQAIQu5LidQRr3288Vg283sjOuc6t/LZ
 sqxQ==
X-Gm-Message-State: AAQBX9eS/wHtyWFaN0f6ZOV1ZRWXGPUBxxTPfhzih7aPiZEkLej5zJyL
 tT0HCiQH9C2/BQ1jUvTkdsj+y9+Cp9N/efBGJT9ehvxNnZ5YbL3C+FwUSYqE3S8+USiotQY7BFb
 JLXX7m/t/sOxzrBiXyZShtIpkj+UKAMksw6riexrBOw==
X-Received: by 2002:a05:6402:68a:b0:500:47ed:9784 with SMTP id
 f10-20020a056402068a00b0050047ed9784mr18115778edy.14.1680543366041; 
 Mon, 03 Apr 2023 10:36:06 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZeBwpH/XQY7l9EvuJLwM3aTGzHzseeXKXbq/GXuvWXoXuy0gvDUtkeWJVcJ9D9wmn4rGwqSA==
X-Received: by 2002:a05:6402:68a:b0:500:47ed:9784 with SMTP id
 f10-20020a056402068a00b0050047ed9784mr18115771edy.14.1680543365798; 
 Mon, 03 Apr 2023 10:36:05 -0700 (PDT)
Received: from redhat.com ([213.152.162.235]) by smtp.gmail.com with ESMTPSA id
 m2-20020a50d7c2000000b004fe924d16cfsm4903827edj.31.2023.04.03.10.36.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Apr 2023 10:36:05 -0700 (PDT)
Date: Mon, 3 Apr 2023 13:35:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/2] virtio-blk: migrate to the latest patchset version
Message-ID: <20230403133334-mutt-send-email-mst@kernel.org>
References: <20230330214953.1088216-1-dmitry.fomichev@wdc.com>
 <20230330214953.1088216-2-dmitry.fomichev@wdc.com>
 <ZCrtjrYQHnppV8gN@infradead.org>
MIME-Version: 1.0
In-Reply-To: <ZCrtjrYQHnppV8gN@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, virtio-dev@lists.oasis-open.org,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Sam Li <faithilikerun@gmail.com>, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org
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

On Mon, Apr 03, 2023 at 08:15:26AM -0700, Christoph Hellwig wrote:
> What is "migrate to the latest patchset version" even supposed to mean?
> 
> I don't think that belongs into a kernel commit description.

I think this should be something like "update to latest interface version".

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A697C4321E
	for <virtualization@archiver.kernel.org>; Mon,  5 Dec 2022 18:25:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D8DE41686;
	Mon,  5 Dec 2022 18:25:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7D8DE41686
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=8GuqePAT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WO9wqFK-x9mA; Mon,  5 Dec 2022 18:25:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D4E2041603;
	Mon,  5 Dec 2022 18:25:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D4E2041603
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 929BDC0033;
	Mon,  5 Dec 2022 18:25:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05D7FC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 18:25:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C6DE360742
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 18:25:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C6DE360742
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com
 header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=8GuqePAT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 41iCJ1yaBK_s
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 18:25:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 375B06068F
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 375B06068F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 18:25:06 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id 82so11263294pgc.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Dec 2022 10:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ImidpIQm24xC230ns//vzB+kQ7xYkel7WPj+tXR6tek=;
 b=8GuqePATHeBdjIjB00TbgRxhjgSPMawtU2wrtMW9YV2SFZq8p01ldTEAEDJdXmVdMQ
 aKPQa9ow3SZfxPLVddZSdd1Vmiivd8Xsns2MQXSSv+HZEwMB1AkPzU6/prRYqgG7kBx1
 pFwb6vkT/NsseKhCFBT2+xNiqVxZUMuF074XfMTL9Gx4DluIfSQ7QPpppgw373tGuZ5f
 xVs1yKe34IQP9m0MTefim8eR8AQhvmWGrY892kFb9Pe9xk1DbtOZd1fthb/96tnSraR5
 hLHHIQR60waW9xkALD7Ke5rkzmfw0e/dorvR7w9+noJkFwmrrhy7A1sDDF8SwAYzoYsH
 S2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ImidpIQm24xC230ns//vzB+kQ7xYkel7WPj+tXR6tek=;
 b=AxgEaHPuwZCDZpe7DeV5miLWG51GBhgvNXjxuULKaouNjZCx9xKA33/N/WX/hGzJlH
 5yOSSePC5aoCjh8tC29MHAKcR1gfP229+a3BDcv+4/5/9GkAHUZkZPhIzoxRLAdtLOSC
 SQ+gg7cP/iCfOJKdhwvtaRmeBef/iPzvPPkV5Rc8gmIVjkEaU9uH4eXl/+IrD/ZgdjKJ
 7k6LEEfzviXzgDTbdiCloNhmrMWZkLxxf2+wQq7bBfLzaBzYs07BAmUIZoUirr834AoI
 9PNESp5lZ8nZh/VU+k6wsjax80JJD/42MD+QSRs4P/MnlrkZgSY/JVt0VpcYlZpA2sjs
 MYIw==
X-Gm-Message-State: ANoB5pncLFhsW6vu/Fu1/yodOfOw13M+bXepCi5soCNIrYJnFIUYm6Nx
 y2HgnYcP2VP+okLqoXaoqC9F/Q==
X-Google-Smtp-Source: AA0mqf6LXB3TBL6QfztXAdNGDz+SFYGDjGPt38SvDGSzimZxm0Mc+GjiJQds8/JFTJ/UbjqS/ZkzWQ==
X-Received: by 2002:a63:ce43:0:b0:476:fdde:9ac8 with SMTP id
 r3-20020a63ce43000000b00476fdde9ac8mr57775329pgi.164.1670264704207; 
 Mon, 05 Dec 2022 10:25:04 -0800 (PST)
Received: from ?IPV6:2600:380:4a37:5fe7:dac6:a7fe:6a6b:c11a?
 ([2600:380:4a37:5fe7:dac6:a7fe:6a6b:c11a])
 by smtp.gmail.com with ESMTPSA id
 ik7-20020a170902ab0700b00189529ed580sm10917190plb.60.2022.12.05.10.25.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Dec 2022 10:25:03 -0800 (PST)
Message-ID: <759f50d0-75c4-7970-b145-469e87f6acc5@kernel.dk>
Date: Mon, 5 Dec 2022 11:25:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Content-Language: en-US
To: Alvaro Karsz <alvaro.karsz@solid-run.com>,
 virtualization@lists.linux-foundation.org
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
Cc: linux-scsi@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 dm-devel@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gMTIvNS8yMiA5OjIw4oCvQU0sIEFsdmFybyBLYXJzeiB3cm90ZToKPiBJbXBsZW1lbnQgdGhl
IFZJUlRJT19CTEtfRl9MSUZFVElNRSBmZWF0dXJlIGZvciBWaXJ0SU8gYmxvY2sgZGV2aWNlcy4K
PiAKPiBUaGlzIGNvbW1pdCBpbnRyb2R1Y2VzIGEgbmV3IGlvY3RsIGNvbW1hbmQsIFZCTEtfTElG
RVRJTUUuCj4gCj4gVkJMS19MSUZFVElNRSBpb2N0bCBhc2tzIGZvciB0aGUgYmxvY2sgZGV2aWNl
IHRvIHByb3ZpZGUgbGlmZXRpbWUKPiBpbmZvcm1hdGlvbiBieSBzZW5kaW5nIGEgVklSVElPX0JM
S19UX0dFVF9MSUZFVElNRSBjb21tYW5kIHRvIHRoZSBkZXZpY2UuCgpzL1ZCTEtfTElGRVRJTUUv
VkJMS19HRVRfTElGRVRJTUUKCmZvciB0aGUgYWJvdmUuCgotLSAKSmVucyBBeGJvZQoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==

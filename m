Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E062C61DA4
	for <virtualization@archiver.kernel.org>; Wed, 22 Feb 2023 04:01:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C783340459;
	Wed, 22 Feb 2023 04:01:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C783340459
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HGXQudng
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d_Tpx3QsnfuO; Wed, 22 Feb 2023 04:01:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5EAA440138;
	Wed, 22 Feb 2023 04:01:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5EAA440138
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 340A2C0033;
	Wed, 22 Feb 2023 04:01:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A5D2C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 04:01:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E543C40459
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 04:01:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E543C40459
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ez0ANkKHc5IJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 04:01:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 73B4E40138
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 73B4E40138
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 04:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677038460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fmRayasExJeNhhzK+HSfTytMdHkE5pgyyCiwSyMtjIA=;
 b=HGXQudnguWtSD6fGRvakeB5veCZp1X4nBQcqMaxhuoTio9XzIx32N6hIscmEZR9rOEB4SG
 JH22GRSq093Ch1mbBIWgogUpMdFwNAzYofJYBbCb2XWUiw3ga4+83RiJ3dOKflCKHCDxsZ
 nNQ6S/LOoXIACdGLNQojWxikZwBbuuE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-311-URcflP3oMcSy0Kf58dS4vw-1; Tue, 21 Feb 2023 23:00:58 -0500
X-MC-Unique: URcflP3oMcSy0Kf58dS4vw-1
Received: by mail-pj1-f69.google.com with SMTP id
 i6-20020a17090a974600b0023487c793d0so3249936pjw.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 20:00:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fmRayasExJeNhhzK+HSfTytMdHkE5pgyyCiwSyMtjIA=;
 b=BBidU2R6qd3Lopr5VjCR9QRNGl7tWGkvX/5FxPlWhHF3i6rRW3valB7Lm6SRs1GIK0
 m3qtkpdgbYWGcmfvFKNkX2FoUm9zEdJkf1bfmKN5ADfhbeRyVKRrjcArpbWTAkXADjil
 DOhhwm+Q8MI24jmf1bWSd0XG5Yw7BrQwxbY80W0L4UyY2+ifHmHE8btp6pFMWPJvpctH
 /JoDFNr+WYEG0dKxyKEMPCCnZbahWYYfkT7p6NfD1hs2Vt6sj5Hq8RsPIx7aU2LaJtkR
 Sw64saCEjWTQpAcffNv9JmmuY0ZksuM4PR0vyVUq1wp8M6IxPCJtCUe4LfVc8nyaRpJj
 jJ4A==
X-Gm-Message-State: AO0yUKWzqq2CBuzElC3TTHcDWChS75ySy/S4p6c8NeS4OHDQEGwVDFMx
 ZMjamrSzwqNRbh0Rr5R+n8w+2iU24Enm8MaX0A206gF83G8wsuuGrQrKgSHw+eTXcoWFmC1B/Y3
 eJ2lfSLIGBgTBgifgD56CUQl+CMmap+TXVj6owYPlnw==
X-Received: by 2002:a17:902:d4cb:b0:19a:b033:2bb0 with SMTP id
 o11-20020a170902d4cb00b0019ab0332bb0mr10410793plg.46.1677038457466; 
 Tue, 21 Feb 2023 20:00:57 -0800 (PST)
X-Google-Smtp-Source: AK7set/pqa7UCHaDJihAZdavmu87pdCyEwLp/aYzCk/mPBK8E7A3NJteJReXb07+0MI8F4XPc6po1w==
X-Received: by 2002:a17:902:d4cb:b0:19a:b033:2bb0 with SMTP id
 o11-20020a170902d4cb00b0019ab0332bb0mr10410765plg.46.1677038457197; 
 Tue, 21 Feb 2023 20:00:57 -0800 (PST)
Received: from [10.72.13.76] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 p2-20020a1709026b8200b0019c61616f82sm5188337plk.230.2023.02.21.20.00.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Feb 2023 20:00:56 -0800 (PST)
Message-ID: <de141eaa-6cc4-e942-9fff-de4dcee8625f@redhat.com>
Date: Wed, 22 Feb 2023 12:00:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 09/13] vdpa net: block migration if the device has CVQ
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20230208094253.702672-1-eperezma@redhat.com>
 <20230208094253.702672-10-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230208094253.702672-10-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gautam Dawar <gdawar@xilinx.com>, virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Lei Yang <leiyang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 longpeng2@huawei.com, Shannon Nelson <snelson@pensando.io>,
 Liuxiangdong <liuxiangdong5@huawei.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIzLzIvOCAxNzo0MiwgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IERldmljZXMgd2l0
aCBDVlEgbmVlZHMgdG8gbWlncmF0ZSBzdGF0ZSBiZXlvbmQgdnEgc3RhdGUuICBMZWF2aW5nIHRo
aXMKPiB0byBmdXR1cmUgc2VyaWVzLgoKCkkgbWF5IG1pc3Mgc29tZXRoaW5nIGJ1dCB3aGF0IGlz
IG1pc3NlZCB0byBzdXBwb3J0IENWUS9NUT8KClRoYW5rcwoKCj4KPiBTaWduZWQtb2ZmLWJ5OiBF
dWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiAtLS0KPiAgIG5ldC92aG9zdC12
ZHBhLmMgfCA2ICsrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQo+Cj4g
ZGlmZiAtLWdpdCBhL25ldC92aG9zdC12ZHBhLmMgYi9uZXQvdmhvc3QtdmRwYS5jCj4gaW5kZXgg
YmNhMTNmOTdmZC4uMzA5ODYxZTU2YyAxMDA2NDQKPiAtLS0gYS9uZXQvdmhvc3QtdmRwYS5jCj4g
KysrIGIvbmV0L3Zob3N0LXZkcGEuYwo+IEBAIC05NTUsMTEgKzk1NSwxNyBAQCBpbnQgbmV0X2lu
aXRfdmhvc3RfdmRwYShjb25zdCBOZXRkZXYgKm5ldGRldiwgY29uc3QgY2hhciAqbmFtZSwKPiAg
ICAgICB9Cj4gICAKPiAgICAgICBpZiAoaGFzX2N2cSkgewo+ICsgICAgICAgIFZob3N0VkRQQVN0
YXRlICpzOwo+ICsKPiAgICAgICAgICAgbmMgPSBuZXRfdmhvc3RfdmRwYV9pbml0KHBlZXIsIFRZ
UEVfVkhPU1RfVkRQQSwgbmFtZSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHZkcGFfZGV2aWNlX2ZkLCBpLCAxLCBmYWxzZSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIG9wdHMtPnhfc3ZxLCBpb3ZhX3JhbmdlKTsKPiAgICAgICAgICAgaWYgKCFuYykK
PiAgICAgICAgICAgICAgIGdvdG8gZXJyOwo+ICsKPiArICAgICAgICBzID0gRE9fVVBDQVNUKFZo
b3N0VkRQQVN0YXRlLCBuYywgbmMpOwo+ICsgICAgICAgIGVycm9yX3NldGcoJnMtPnZob3N0X3Zk
cGEuZGV2LT5taWdyYXRpb25fYmxvY2tlciwKPiArICAgICAgICAgICAgICAgICAgICJuZXQgdmRw
YSBjYW5ub3QgbWlncmF0ZSB3aXRoIE1RIGZlYXR1cmUiKTsKPiAgICAgICB9Cj4gICAKPiAgICAg
ICByZXR1cm4gMDsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

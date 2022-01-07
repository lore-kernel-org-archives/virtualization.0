Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D3EC433EF
	for <virtualization@archiver.kernel.org>; Fri,  7 Jan 2022 05:50:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49F566FC64;
	Fri,  7 Jan 2022 05:50:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yCQqlxIFuscJ; Fri,  7 Jan 2022 05:50:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 022A86FC33;
	Fri,  7 Jan 2022 05:50:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA07BC002F;
	Fri,  7 Jan 2022 05:50:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1C00C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:50:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CDBBA6FC5C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:50:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SrRRDeoma84M
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:50:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B3DC6FC33
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641534620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+I6UoC0m8cLpXBLxRC0qHrz/qfvrKWcRtGUiCECvfXg=;
 b=h8jF9zJB7idW85oOTXnTNUE0YjgfGDJIHWeowW4itWmpGH1UM6AIyPWv3ERKFO2n2HGoJN
 ZRfIgb0cRG+WkyvZIeF3NRjPs4sHajJI7lpVxaey6a/ulqR4tS2ZmnpqOlzjnGh2dY9V5w
 PRMSEc7/YRkQ4iIeV3kWcZQGIb/dD1g=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-fpvsxJjuPkizik8Ca18WDA-1; Fri, 07 Jan 2022 00:50:19 -0500
X-MC-Unique: fpvsxJjuPkizik8Ca18WDA-1
Received: by mail-pf1-f199.google.com with SMTP id
 n4-20020aa79044000000b004bcd447b6easo3143658pfo.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jan 2022 21:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=+I6UoC0m8cLpXBLxRC0qHrz/qfvrKWcRtGUiCECvfXg=;
 b=1+NlxCEYC6wvwonEiY5RZsFqqqPD8KT1/8zecSoynY3sycFqxoTAEFcHAALyowd93U
 oJuMS9A+HzyraNlAOnCqCJw0zyAOdcWcx8J8PTP4egL/YfwhQpyPg0h5smKK7mPHq4Nf
 MtPxsD4ScbPArZnaz3euaiel7IWsAOGdM/femnpphvAa7maSZmtLbCLnMwEU65pZTo2i
 VOGqp1jDISK0gnxkFwLVPdOBCUgoBJpgRCE6Zy98Gr1bYbYbbKUL01hDHyOqXQN8YM56
 8y4HrVtiAdMIDBnciBp0bqe8DWwkQrnoKnkJAcFmhy1s6CJsOp3IGuLaNCGotvheDWU9
 +LZw==
X-Gm-Message-State: AOAM533iZW74Wb2DlhV6V5jUIX2YPo5f/euDSqSlQsk2FE3Rm1uBz7HH
 a/rBPv1CRiapqL2IQcZ5Mtuy6SAO2Cn0yeJXSwVo8HUwPMHGWO7JRdNrKPF7UtB84/fEYjeKONH
 JTYuHyVzJDQWQY5joL1vLDO/rnT0HUGNzXxJAfefRiA==
X-Received: by 2002:a17:903:110d:b0:149:a833:af21 with SMTP id
 n13-20020a170903110d00b00149a833af21mr32828358plh.14.1641534617949; 
 Thu, 06 Jan 2022 21:50:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsoQGg1/mx7qOOZGkqR2AzNwd5z/dx9BNSyXU1kXR2w150nhQUo175JWhVOWmTORvDAlxChw==
X-Received: by 2002:a17:903:110d:b0:149:a833:af21 with SMTP id
 n13-20020a170903110d00b00149a833af21mr32828345plh.14.1641534617731; 
 Thu, 06 Jan 2022 21:50:17 -0800 (PST)
Received: from [10.72.13.245] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b11sm4815512pfv.39.2022.01.06.21.50.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jan 2022 21:50:17 -0800 (PST)
Message-ID: <99f2becd-2d33-352f-339d-a1618387dbd9@redhat.com>
Date: Fri, 7 Jan 2022 13:50:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v7 12/14] vdpa/vdpa_sim: Configure max supported virtqueues
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-13-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220105114646.577224-13-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: lvivier@redhat.com, eperezma@redhat.com, si-wei.liu@oracle.com
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

CuWcqCAyMDIyLzEvNSDkuIvljYg3OjQ2LCBFbGkgQ29oZW4g5YaZ6YGTOgo+IENvbmZpZ3VyZSBt
YXggc3VwcG9ydGVkIHZpcnRxdWV1ZXMgb24gdGhlIG1hbmFnZW1lbnQgZGV2aWNlLgo+Cj4gU2ln
bmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+CgoKQWNrZWQtYnk6IEphc29u
IFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS92ZHBh
X3NpbS92ZHBhX3NpbV9uZXQuYyB8IDEgKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5j
IGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5jCj4gaW5kZXggNzZkZDI0YWJj
NzkxLi40NmFhYmM3MzI2M2EgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3Zk
cGFfc2ltX25ldC5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5j
Cj4gQEAgLTE5MSw2ICsxOTEsNyBAQCBzdGF0aWMgc3RydWN0IHZkcGFfbWdtdF9kZXYgbWdtdF9k
ZXYgPSB7Cj4gICAJLm9wcyA9ICZ2ZHBhc2ltX25ldF9tZ210ZGV2X29wcywKPiAgIAkuY29uZmln
X2F0dHJfbWFzayA9ICgxIDw8IFZEUEFfQVRUUl9ERVZfTkVUX0NGR19NQUNBRERSIHwKPiAgIAkJ
CSAgICAgMSA8PCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTVRVKSwKPiArCS5tYXhfc3VwcG9ydGVk
X3ZxcyA9IFZEUEFTSU1fTkVUX1ZRX05VTSwKPiAgIH07Cj4gICAKPiAgIHN0YXRpYyBpbnQgX19p
bml0IHZkcGFzaW1fbmV0X2luaXQodm9pZCkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

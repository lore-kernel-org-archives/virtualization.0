Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0ECFC433F5
	for <virtualization@archiver.kernel.org>; Fri,  7 Jan 2022 05:51:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E680401DE;
	Fri,  7 Jan 2022 05:51:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lXGHgsPuR51n; Fri,  7 Jan 2022 05:51:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C73E2429B4;
	Fri,  7 Jan 2022 05:51:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A99FEC002F;
	Fri,  7 Jan 2022 05:51:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C6FCC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:51:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B27080EE8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:51:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pLDQIPQWtuFh
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:51:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C617680E42
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641534700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T8xfwtAzXAUWGoZjHizUY2eRsKiiEWrJX2CrziTjfpo=;
 b=Q9yQ+ksQiWKhsPr8NVwEv/KP5HSBsg9HUT1RATdoAPkC5+P6At5AvLSzJHtrP3y6Dk9B+G
 o3DPRmXph1ufHpdGeYZ2CwHASSshbwHdcxXCciYG0OWUFI0Cs8eX171Ct765hKSZ1AFxgR
 TGfjm4SHy1lzOk1G4s32nwdZxqZz3lc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-kZnOmBX9M7WNUrc71xzI6A-1; Fri, 07 Jan 2022 00:51:37 -0500
X-MC-Unique: kZnOmBX9M7WNUrc71xzI6A-1
Received: by mail-pf1-f200.google.com with SMTP id
 t128-20020a628186000000b004bac607ec25so3172902pfd.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jan 2022 21:51:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=T8xfwtAzXAUWGoZjHizUY2eRsKiiEWrJX2CrziTjfpo=;
 b=SwTwia0FvEn2pza5EFOg75uY5uvXlGr3gb7ynwMEOB0VdHvdsw68/p/1BW1N8msxo7
 ooDORCJ90eP7QkKoi7WkPa7oUqP76PF9Hbt4E4YRSUxa2znwUSAKql+tdSo4EsJpCJjY
 0o/zYqVl2xRBGNzOqDVlQhcTTUi1/EeIdOja7vmELmR+P5JgKCmeHKU6aAwj1lQ+f/6U
 KODVmA4awYmn2rNraKEWJ+N6ANst2OdwViavXQmo4DvUV7I/o4Vh7iklC5P09we+55Gr
 DBB1JIGA9/KZ26kWy5o8PYDDr37L+bC7YK77YOZhx9+JldI43Fhyc5OSgkJdW2jiKeCm
 /8mw==
X-Gm-Message-State: AOAM532O1+nUCcYf49bYP6BapmFXIbEZ93KRLEdXMXSZ7TtpJ3pABmWS
 A7bu3662YvSkge3ASU/CgGHDR5vjp53KwcFMarpHmnbFIFdYLbkj7JJ/CXAmCH/DryuZaPK0Xnm
 BA9Fpxh2RBzmw7wUZqh27ayhp3e5XPno8mSxvawKKbA==
X-Received: by 2002:a63:7148:: with SMTP id b8mr32831757pgn.616.1641534696659; 
 Thu, 06 Jan 2022 21:51:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyq+7Zeb7iGVGE1rnzYosb532DaD2Ee4aQ3gVXNlEXmCy7v+YjmLcnGIzP9I2dfN5TPqqiU9Q==
X-Received: by 2002:a63:7148:: with SMTP id b8mr32831744pgn.616.1641534696406; 
 Thu, 06 Jan 2022 21:51:36 -0800 (PST)
Received: from [10.72.13.245] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id t21sm3451181pgn.28.2022.01.06.21.51.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jan 2022 21:51:35 -0800 (PST)
Message-ID: <66b79417-191d-8d71-16b0-2f9307cb3342@redhat.com>
Date: Fri, 7 Jan 2022 13:51:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v7 14/14] vdpa/vdpa_sim_net: Report max device capabilities
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-15-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220105114646.577224-15-elic@nvidia.com>
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
YXggc3VwcG9ydGVkIHZpcnRxdWV1ZXMgZmVhdHVyZXMgb24gdGhlIG1hbmFnZW1lbnQgZGV2aWNl
Lgo+IFRoaXMgaW5mbyBjYW4gYmUgcmV0cmlldmVkIHVzaW5nOgo+Cj4gJCB2ZHBhIG1nbXRkZXYg
c2hvdwo+IHZkcGFzaW1fbmV0Ogo+ICAgIHN1cHBvcnRlZF9jbGFzc2VzIG5ldAo+ICAgIG1heF9z
dXBwb3J0ZWRfdnFzIDIKPiAgICBkZXZfZmVhdHVyZXMgTUFDIEFOWV9MQVlPVVQgVkVSU0lPTl8x
IEFDQ0VTU19QTEFURk9STQo+Cj4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52aWRp
YS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAt
LS0KPiAgIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9uZXQuYyB8IDEgKwo+ICAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBh
L3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5jIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2lt
X25ldC5jCj4gaW5kZXggNDZhYWJjNzMyNjNhLi5kNTMyNGY2ZmQ4YzcgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5jCj4gKysrIGIvZHJpdmVycy92ZHBh
L3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5jCj4gQEAgLTE5Miw2ICsxOTIsNyBAQCBzdGF0aWMgc3Ry
dWN0IHZkcGFfbWdtdF9kZXYgbWdtdF9kZXYgPSB7Cj4gICAJLmNvbmZpZ19hdHRyX21hc2sgPSAo
MSA8PCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFDQUREUiB8Cj4gICAJCQkgICAgIDEgPDwgVkRQ
QV9BVFRSX0RFVl9ORVRfQ0ZHX01UVSksCj4gICAJLm1heF9zdXBwb3J0ZWRfdnFzID0gVkRQQVNJ
TV9ORVRfVlFfTlVNLAo+ICsJLnN1cHBvcnRlZF9mZWF0dXJlcyA9IFZEUEFTSU1fTkVUX0ZFQVRV
UkVTLAo+ICAgfTsKPiAgIAo+ICAgc3RhdGljIGludCBfX2luaXQgdmRwYXNpbV9uZXRfaW5pdCh2
b2lkKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u

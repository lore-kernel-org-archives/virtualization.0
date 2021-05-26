Return-Path: <SRS0=MQJa=KV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651F4C47087
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 01:07:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0181061417
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 01:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0181061417
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADB7383DBC;
	Wed, 26 May 2021 01:07:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sm3S2p2zSrf1; Wed, 26 May 2021 01:07:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5259B83DB7;
	Wed, 26 May 2021 01:07:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 318F9C000D;
	Wed, 26 May 2021 01:07:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 818C0C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 01:07:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 593AB4062B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 01:07:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DsjmMUMoW2JK
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 01:07:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EFCF740606
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 01:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621991223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wodWiuTTjVvJeppQlgse+2mrtiAeVgbTGPL1iJuG7Qg=;
 b=QGgUM3yuC9ZElD8XQAr9/xoKa/tyfSeiWj3ry26B8duzaf8ZNnfJ5Y0ZxuMXXRBfrp+d9L
 MAfSYV4QQ/HWB3xsknq/AG/g+asUBCtKEKbqmnQ+ncMXoSU+tw3CAta+9FMwkhlVkl2iKn
 OMYjlOSQpL0+CdlPtMXBCcnAUAN9J9U=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-cXEdQHFgOvSUgsBcvuQM2g-1; Tue, 25 May 2021 21:07:01 -0400
X-MC-Unique: cXEdQHFgOvSUgsBcvuQM2g-1
Received: by mail-pf1-f199.google.com with SMTP id
 g21-20020aa787550000b02902db9841d2a1so18860622pfo.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 18:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=wodWiuTTjVvJeppQlgse+2mrtiAeVgbTGPL1iJuG7Qg=;
 b=YP0GsDjfCuJF0/nfltExln8mF4nnhJcdkovw1ceG1PE9R6hhgbCzzvhn+ZzpS3i6nb
 yuwR+VrRSqkEjik3sKs9qOfLkftluoWnLekV8XsGqqooGtqZCkPEuKzgANesFJcQpB9c
 8+wk92s+Y2YxUsHDltsSegNxAyfumrZpFGTSTlMo5pS3s/g0PYgNKlTZWj55wC+gO6qr
 7LyD23Z8wMI5kkzGodrRjV31K7pYCJyAAakLejuCEQNgQSfULLHqw9axFgnO6P1YB0+X
 /tcKg986qGfC1ifM7fWgFXnKs5Ji+l5mCLRP+q8rO8L7PAR1AipD2tjnB6MkM78KcdH8
 Ep+Q==
X-Gm-Message-State: AOAM530jEawsNIpPVytg+afpsKCMWgi3eN6Xw5fEYUkx983X2BE0xyqs
 TGtUYyR+twZBd5D1rCyMlskgu0y8AxM5gRpVEmMkvRVznj2WjQFzWXI7CyI2+zHawGZJ3kg9dz2
 WsLo/sZfZwiTMaFvGcERdQHNFTEZjMxQ6wL4MAUcLhINajEo33c0V2jQ2LRL+YMjyIzuF3owdXB
 fi3x4ljs5NDQJn+8Jrmw==
X-Received: by 2002:a63:5b0e:: with SMTP id p14mr21474346pgb.110.1621991220445; 
 Tue, 25 May 2021 18:07:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxszp4dUhckfW0D05y+B1LtbLTL3QorVVEutcyW3Q/n7dk4XHLAd0g42hztIA6zUI66bKdX0g==
X-Received: by 2002:a63:5b0e:: with SMTP id p14mr21474297pgb.110.1621991219950; 
 Tue, 25 May 2021 18:06:59 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id i8sm15604421pgt.58.2021.05.25.18.06.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 May 2021 18:06:59 -0700 (PDT)
Subject: Re: [RFC v3 06/29] virtio-net: Honor VIRTIO_CONFIG_S_DEVICE_STOPPED
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20210519162903.1172366-1-eperezma@redhat.com>
 <20210519162903.1172366-7-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e64b9813-66e5-2417-3feb-65f0376db7e0@redhat.com>
Date: Wed, 26 May 2021 09:06:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210519162903.1172366-7-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Eric Blake <eblake@redhat.com>, Michael Lilja <ml@napatech.com>
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

CuWcqCAyMDIxLzUvMjAg5LiK5Y2IMTI6MjgsIEV1Z2VuaW8gUMOpcmV6IOWGmemBkzoKPiBTbyB0
aGUgZ3Vlc3QgY2FuIHN0b3AgYW5kIHN0YXJ0IG5ldCBkZXZpY2UuIEl0IGltcGxlbWVudHMgdGhl
IFJGQwo+IGh0dHBzOi8vbGlzdHMub2FzaXMtb3Blbi5vcmcvYXJjaGl2ZXMvdmlydGlvLWNvbW1l
bnQvMjAyMDEyL21zZzAwMDI3Lmh0bWwKPgo+IFRvIHN0b3AgKGFzICJwYXVzZSIpIHRoZSBkZXZp
Y2UgaXMgcmVxdWlyZWQgdG8gbWlncmF0ZSBzdGF0dXMgYW5kIHZyaW5nCj4gYWRkcmVzc2VzIGJl
dHdlZW4gZGV2aWNlIGFuZCBTVlEuCj4KPiBUaGlzIGlzIGEgV0lQIGNvbW1pdDogYXMgd2l0aCBW
SVJUSU9fRl9RVUVVRV9TVEFURSwgaXMgaW50cm9kdWNlZCBpbgo+IHZpcnRpb19jb25maWcuaCBi
ZWZvcmUgb2YgZXZlbiBwcm9wb3NpbmcgZm9yIHRoZSBrZXJuZWwsIHdpdGggbm8gZmVhdHVyZQo+
IGZsYWcsIGFuZCwgd2l0aCBubyBjaGVja2luZyBpbiB0aGUgZGV2aWNlLiBJdCBhbHNvIG5lZWRz
IGEgbW9kaWZpZWQKPiB2cF92ZHBhIGRyaXZlciB0aGF0IHN1cHBvcnRzIHRvIHNldCBhbmQgcmV0
cmlldmUgc3RhdHVzLgo+Cj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1h
QHJlZGhhdC5jb20+Cj4gLS0tCj4gICBpbmNsdWRlL3N0YW5kYXJkLWhlYWRlcnMvbGludXgvdmly
dGlvX2NvbmZpZy5oIHwgMiArKwo+ICAgaHcvbmV0L3ZpcnRpby1uZXQuYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8IDQgKysrLQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3N0YW5kYXJkLWhlYWRl
cnMvbGludXgvdmlydGlvX2NvbmZpZy5oIGIvaW5jbHVkZS9zdGFuZGFyZC1oZWFkZXJzL2xpbnV4
L3ZpcnRpb19jb25maWcuaAo+IGluZGV4IDU5ZmFkM2ViNDUuLmIzZjZiMTM2NWQgMTAwNjQ0Cj4g
LS0tIGEvaW5jbHVkZS9zdGFuZGFyZC1oZWFkZXJzL2xpbnV4L3ZpcnRpb19jb25maWcuaAo+ICsr
KyBiL2luY2x1ZGUvc3RhbmRhcmQtaGVhZGVycy9saW51eC92aXJ0aW9fY29uZmlnLmgKPiBAQCAt
NDAsNiArNDAsOCBAQAo+ICAgI2RlZmluZSBWSVJUSU9fQ09ORklHX1NfRFJJVkVSX09LCTQKPiAg
IC8qIERyaXZlciBoYXMgZmluaXNoZWQgY29uZmlndXJpbmcgZmVhdHVyZXMgKi8KPiAgICNkZWZp
bmUgVklSVElPX0NPTkZJR19TX0ZFQVRVUkVTX09LCTgKPiArLyogRGV2aWNlIGlzIHN0b3BwZWQg
Ki8KPiArI2RlZmluZSBWSVJUSU9fQ09ORklHX1NfREVWSUNFX1NUT1BQRUQgMzIKPiAgIC8qIERl
dmljZSBlbnRlcmVkIGludmFsaWQgc3RhdGUsIGRyaXZlciBtdXN0IHJlc2V0IGl0ICovCj4gICAj
ZGVmaW5lIFZJUlRJT19DT05GSUdfU19ORUVEU19SRVNFVAkweDQwCj4gICAvKiBXZSd2ZSBnaXZl
biB1cCBvbiB0aGlzIGRldmljZS4gKi8KPiBkaWZmIC0tZ2l0IGEvaHcvbmV0L3ZpcnRpby1uZXQu
YyBiL2h3L25ldC92aXJ0aW8tbmV0LmMKPiBpbmRleCA5NmEzY2M4MzU3Li4yZDNjYWVhMjg5IDEw
MDY0NAo+IC0tLSBhL2h3L25ldC92aXJ0aW8tbmV0LmMKPiArKysgYi9ody9uZXQvdmlydGlvLW5l
dC5jCj4gQEAgLTE5OCw3ICsxOTgsOSBAQCBzdGF0aWMgYm9vbCB2aXJ0aW9fbmV0X3N0YXJ0ZWQo
VmlydElPTmV0ICpuLCB1aW50OF90IHN0YXR1cykKPiAgIHsKPiAgICAgICBWaXJ0SU9EZXZpY2Ug
KnZkZXYgPSBWSVJUSU9fREVWSUNFKG4pOwo+ICAgICAgIHJldHVybiAoc3RhdHVzICYgVklSVElP
X0NPTkZJR19TX0RSSVZFUl9PSykgJiYKPiAtICAgICAgICAobi0+c3RhdHVzICYgVklSVElPX05F
VF9TX0xJTktfVVApICYmIHZkZXYtPnZtX3J1bm5pbmc7Cj4gKyAgICAgICAgKCEobi0+c3RhdHVz
ICYgVklSVElPX0NPTkZJR19TX0RFVklDRV9TVE9QUEVEKSkgJiYKPiArICAgICAgICAobi0+c3Rh
dHVzICYgVklSVElPX05FVF9TX0xJTktfVVApICYmCj4gKyAgICAgICAgdmRldi0+dm1fcnVubmlu
ZzsKPiAgIH0KPiAgIAo+ICAgc3RhdGljIHZvaWQgdmlydGlvX25ldF9hbm5vdW5jZV9ub3RpZnko
VmlydElPTmV0ICpuZXQpCgoKSXQgbG9va3MgdG8gbWUgdGhpcyBpcyBvbmx5IHRoZSBwYXJ0IG9m
IHBhdXNlLiBXZSBzdGlsbCBuZWVkIHRoZSByZXN1bWU/CgpUaGFua3MKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

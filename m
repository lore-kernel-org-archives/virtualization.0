Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F70BC27C40
	for <virtualization@archiver.kernel.org>; Thu, 24 Aug 2023 03:24:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 310DF61301;
	Thu, 24 Aug 2023 03:24:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 310DF61301
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YUcZrJDx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vPjfnpGayylE; Thu, 24 Aug 2023 03:24:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AF94C612FA;
	Thu, 24 Aug 2023 03:24:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AF94C612FA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73018C0039;
	Thu, 24 Aug 2023 03:24:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36EA3C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Aug 2023 03:24:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EFBBC41883
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Aug 2023 03:24:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EFBBC41883
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YUcZrJDx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IwzRmfmO4zhb
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Aug 2023 03:24:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C07FE417B4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Aug 2023 03:24:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C07FE417B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692847447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yPglN9jWCOWkDHiaVESzd3fbifjjVGG3Y2tLlmCAqyw=;
 b=YUcZrJDx4MKgaE6mggOC/NfxnV8JswraF0my3vZzvliflbdcTLtVXsL1O7pH+lx2RavZJQ
 y8KgM+xKXYtUNhRZetCOrs74BTxu+vI4H6qWiM636jhRaLhjB551bMKUKhq/HzVt5iFZRl
 N1qxYh3k8P3QCegLtY4rY8Vs7WfT+MI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-cTBN5TAYMkuKZr4Hl5k82Q-1; Wed, 23 Aug 2023 23:24:04 -0400
X-MC-Unique: cTBN5TAYMkuKZr4Hl5k82Q-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b9fa64dba8so68761191fa.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Aug 2023 20:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692847443; x=1693452243;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yPglN9jWCOWkDHiaVESzd3fbifjjVGG3Y2tLlmCAqyw=;
 b=UaOlf4/ju7gzZm7/S5yEuui8fJraXOj4y4gbri6yCGT96e82pBqxKQ3zK0Tyj3ER2P
 1g44hKPr0xzYfnMB+kObX8c4l0TDvzTVegTNifYTxnm2yJB46OSMY7PcYeUxVNMfpMH1
 JCeGp0Ksb9eE5l36BcH8Ae0vLUviRTjJoaTuP4Sfj/xIdhGT/HK6X2ym+EoxSFMQjr43
 96jxL93fKxoTw2IYlFEefGsOdKz9vPTMpqUSKlm8g634Mo9veR90dRRt2lebFedGVD6f
 Mz6iVHrjE7qOxf2gmlKa+eoIANdhgpNeCbOBI8DM8sH847efZF1Kt9z+UbSgtKCmcpRF
 sA5g==
X-Gm-Message-State: AOJu0YxZ598Hidq/3f8LPhsKI7Z6BMJ5eNV0gkfn+4NSKqmn9uM5t3jy
 OOWVqqhbPk63NKsEIZa23V7Rx5il+/uBT3O76KQV4FWhmFAG7dtH/kAyk+g53YDGXwizAYtfk0Q
 WGgBaL/LyNT253O/PJbR7oa/jxuV+EfIJWp6lrHCkaWGi+HbdeR5GpSnCzw==
X-Received: by 2002:a2e:b710:0:b0:2b5:80e0:f18e with SMTP id
 j16-20020a2eb710000000b002b580e0f18emr11256985ljo.3.1692847443057; 
 Wed, 23 Aug 2023 20:24:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjkeGqdviCPH5wTUExjQLr+CqEbEiWt/ba0nY6S4lLgHFwDlCy0ER84ojf2Z39Sci9dtg33fDr0zJFePv+spQ=
X-Received: by 2002:a2e:b710:0:b0:2b5:80e0:f18e with SMTP id
 j16-20020a2eb710000000b002b580e0f18emr11256978ljo.3.1692847442724; Wed, 23
 Aug 2023 20:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230823153032.239304-1-eric.auger@redhat.com>
In-Reply-To: <20230823153032.239304-1-eric.auger@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 24 Aug 2023 11:23:51 +0800
Message-ID: <CACGkMEseBgbQx1ESA+QV_Y+BDdmwYPVg1UjUu2G0S2B6ksDeyQ@mail.gmail.com>
Subject: Re: [PATCH] vhost: Allow null msg.size on VHOST_IOTLB_INVALIDATE
To: Eric Auger <eric.auger@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mail@anirudhrb.com, elic@nvidia.com, kvmarm@lists.cs.columbia.edu,
 eric.auger.pro@gmail.com
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

T24gV2VkLCBBdWcgMjMsIDIwMjMgYXQgMTE6MzDigK9QTSBFcmljIEF1Z2VyIDxlcmljLmF1Z2Vy
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gQ29tbWl0IGUyYWUzOGNmM2Q5MSAoInZob3N0OiBmaXgg
aHVuZyB0aHJlYWQgZHVlIHRvIGVycm9uZW91cyBpb3RsYgo+IGVudHJpZXMiKSBGb3JiYWRlIHZo
b3N0IGlvdGxiIG1zZyB3aXRoIG51bGwgc2l6ZSB0byBwcmV2ZW50IGVudHJpZXMKPiB3aXRoIHNp
emUgPSBzdGFydCA9IDAgYW5kIGxhc3QgPSBVTE9OR19NQVggdG8gZW5kIHVwIGluIHRoZSBpb3Rs
Yi4KPgo+IFRoZW4gY29tbWl0IDk1OTMyYWIyZWEwNyAoInZob3N0OiBhbGxvdyBiYXRjaGluZyBo
aW50IHdpdGhvdXQgc2l6ZSIpCj4gb25seSBhcHBsaWVkIHRoZSBjaGVjayBmb3IgVkhPU1RfSU9U
TEJfVVBEQVRFIGFuZCBWSE9TVF9JT1RMQl9JTlZBTElEQVRFCj4gbWVzc2FnZSB0eXBlcyB0byBm
aXggYSByZWdyZXNzaW9uIG9ic2VydmVkIHdpdGggYmF0Y2hpbmcgaGl0Lgo+Cj4gU3RpbGwsIHRo
ZSBpbnRyb2R1Y3Rpb24gb2YgdGhhdCBjaGVjayBpbnRyb2R1Y2VkIGEgcmVncmVzc2lvbiBmb3IK
PiBzb21lIHVzZXJzIGF0dGVtcHRpbmcgdG8gaW52YWxpZGF0ZSB0aGUgd2hvbGUgVUxPTkdfTUFY
IHJhbmdlIGJ5Cj4gc2V0dGluZyB0aGUgc2l6ZSB0byAwLiBUaGlzIGlzIHRoZSBjYXNlIHdpdGgg
cWVtdS9zbW11djMvdmhvc3QKPiBpbnRlZ3JhdGlvbiB3aGljaCBkb2VzIG5vdCB3b3JrIGFueW1v
cmUuIEl0IExvb2tzIHNhZmUgdG8gcGFydGlhbGx5Cj4gcmV2ZXJ0IHRoZSBvcmlnaW5hbCBjb21t
aXQgYW5kIGFsbG93IFZIT1NUX0lPVExCX0lOVkFMSURBVEUgbWVzc2FnZXMKPiB3aXRoIG51bGwg
c2l6ZS4gdmhvc3RfaW90bGJfZGVsX3JhbmdlKCkgd2lsbCBjb21wdXRlIGEgY29ycmVjdCBlbmQK
PiBpb3ZhLiBTYW1lIGZvciB2aG9zdF92ZHBhX2lvdGxiX3VubWFwKCkuCj4KPiBTaWduZWQtb2Zm
LWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+CgpDYzogc3RhYmxlQHZnZXIu
a2VybmVsLm9yZwoKSSB0aGluayB3ZSBuZWVkIHRvIGRvY3VtZW50IHRoZSB1c2FnZSBvZiAwIGFz
IG1zZy5zaXplIGZvcgpJT1RMQl9JTlZBTElEQVRFIGluIHVhcGkuCgpPdGhlciB0aGFuIHRoaXM6
CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKPiBG
aXhlczogZTJhZTM4Y2YzZDkxICgidmhvc3Q6IGZpeCBodW5nIHRocmVhZCBkdWUgdG8gZXJyb25l
b3VzIGlvdGxiIGVudHJpZXMiKQo+IC0tLQo+ICBkcml2ZXJzL3Zob3N0L3Zob3N0LmMgfCA0ICst
LS0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3Qu
Ywo+IGluZGV4IGM3MWQ1NzNmMWM5NC4uZTBjMTgxYWQxN2UzIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvdmhvc3Qvdmhvc3QuYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+IEBAIC0xNDU4
LDkgKzE0NTgsNyBAQCBzc2l6ZV90IHZob3N0X2Nocl93cml0ZV9pdGVyKHN0cnVjdCB2aG9zdF9k
ZXYgKmRldiwKPiAgICAgICAgICAgICAgICAgZ290byBkb25lOwo+ICAgICAgICAgfQo+Cj4gLSAg
ICAgICBpZiAoKG1zZy50eXBlID09IFZIT1NUX0lPVExCX1VQREFURSB8fAo+IC0gICAgICAgICAg
ICBtc2cudHlwZSA9PSBWSE9TVF9JT1RMQl9JTlZBTElEQVRFKSAmJgo+IC0gICAgICAgICAgICBt
c2cuc2l6ZSA9PSAwKSB7Cj4gKyAgICAgICBpZiAobXNnLnR5cGUgPT0gVkhPU1RfSU9UTEJfVVBE
QVRFICYmIG1zZy5zaXplID09IDApIHsKPiAgICAgICAgICAgICAgICAgcmV0ID0gLUVJTlZBTDsK
PiAgICAgICAgICAgICAgICAgZ290byBkb25lOwo+ICAgICAgICAgfQo+IC0tCj4gMi40MS4wCj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==

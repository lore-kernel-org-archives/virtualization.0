Return-Path: <SRS0=GMN+=KG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9676EC433ED
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 06:47:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D6E616EA
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 06:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D6E616EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EF8FF4014E;
	Tue, 11 May 2021 06:47:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O2UkgK8kVuwB; Tue, 11 May 2021 06:47:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id A13F940173;
	Tue, 11 May 2021 06:47:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A3F4C000D;
	Tue, 11 May 2021 06:47:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E982CC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 06:47:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CACC9844CC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 06:47:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PMPnJDMam5qk
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 06:47:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EAB3783EF9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 06:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620715636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sx7nPbuFzoppkZ1L0KO8BbiXNbbmx+wsvBNBIIout20=;
 b=MuQf+ICsW5uAH/LDQdThW0QAnzmYwlQCBaR6VKSPr3fNHW1PipTEMKRKA2QbeGysV2guET
 LRW1yqr92q3c1lCH+eHzeFdS6flpey/ceOrA6yF2Vs1agFl2FXIPi2OWLD6652Grk+gh6Q
 DSVxBA4vbCMEqepkEnlqihV0OGJEmU0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-hsNP_YR1O32Y_D4RB6U85g-1; Tue, 11 May 2021 02:47:12 -0400
X-MC-Unique: hsNP_YR1O32Y_D4RB6U85g-1
Received: by mail-pl1-f200.google.com with SMTP id
 31-20020a1709020022b02900eeddd708c8so7145988pla.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 23:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=sx7nPbuFzoppkZ1L0KO8BbiXNbbmx+wsvBNBIIout20=;
 b=ibZjv+ioJH+GaNmYPvox64i6jpJuyhUjlbFDoE2m3vovDvvt0bxakkWyIycH3iCq1u
 EwgocLvtOVdGelix/vcgq4TSoidx5B1JKkapq5gjZmnwc4HyuH+7JLxCT/NkmPurohG/
 PGkZsZWlvwoRXzI83aGdWgMth3RBuSqmAs6l/GKTzi2O/ViO3IPbFylg5opT0J1i5Lqc
 u5k3MBntkUInvi1LdajcdrpS1emr87X3HEn6dvD/guLM9FQgU0N69/Sq8tQrlVMB/1l4
 Y4eVXhHI1Qk8hTDk5lbQTMpmEQFy34mPvhux2bHXigsc9SAvOBKanJQLgXg3XPdW0P+i
 +Rng==
X-Gm-Message-State: AOAM531Fk3a4TU/RXJfcS1umyEGQ7ulCDOgWYVgxirFGI45u1O0ysiIt
 o046wY5e1mrrDGh0RxTvYM0YEIxqPK1JoXla0Tmj4snGgsJsWPbQH+NGPfOEUn8nbNnEWv1Pb+4
 7CB/zf2hLC/kOsLJ5rN6ObP8SLI76nLNhDBwC18CaeQ==
X-Received: by 2002:a63:4a44:: with SMTP id j4mr28981023pgl.283.1620715631787; 
 Mon, 10 May 2021 23:47:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4Y68wI4Mxy05AHpRaptwpa5l3QU8whi/1YTywzoMGIWFR/WITTxyH3t+IdjkN5CZAtIhfpw==
X-Received: by 2002:a63:4a44:: with SMTP id j4mr28981001pgl.283.1620715631488; 
 Mon, 10 May 2021 23:47:11 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id ml19sm1607366pjb.2.2021.05.10.23.47.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 May 2021 23:47:10 -0700 (PDT)
Subject: Re: [PATCH 1/4] virtio-net: add definitions for host USO feature
To: Yuri Benditovich <yuri.benditovich@daynix.com>, davem@davemloft.net,
 kuba@kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-2-yuri.benditovich@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <40938c20-5851-089b-c3c0-074bbd636970@redhat.com>
Date: Tue, 11 May 2021 14:47:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511044253.469034-2-yuri.benditovich@daynix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: yan@daynix.com
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

CuWcqCAyMDIxLzUvMTEg5LiL5Y2IMTI6NDIsIFl1cmkgQmVuZGl0b3ZpY2gg5YaZ6YGTOgo+IERl
ZmluZSBmZWF0dXJlIGJpdCBhbmQgR1NPIHR5cGUgYWNjb3JkaW5nIHRvIHRoZSBWSVJUSU8KPiBz
cGVjaWZpY2F0aW9uLgo+Cj4gU2lnbmVkLW9mZi1ieTogWXVyaSBCZW5kaXRvdmljaCA8eXVyaS5i
ZW5kaXRvdmljaEBkYXluaXguY29tPgo+IC0tLQo+ICAgaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRp
b19uZXQuaCB8IDIgKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPgo+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX25ldC5oIGIvaW5jbHVkZS91YXBp
L2xpbnV4L3ZpcnRpb19uZXQuaAo+IGluZGV4IDNmNTVhNDIxNWYxMS4uYTU1NmFjNzM1ZDdmIDEw
MDY0NAo+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fbmV0LmgKPiArKysgYi9pbmNs
dWRlL3VhcGkvbGludXgvdmlydGlvX25ldC5oCj4gQEAgLTU3LDYgKzU3LDcgQEAKPiAgIAkJCQkJ
ICogU3RlZXJpbmcgKi8KPiAgICNkZWZpbmUgVklSVElPX05FVF9GX0NUUkxfTUFDX0FERFIgMjMJ
LyogU2V0IE1BQyBhZGRyZXNzICovCj4gICAKPiArI2RlZmluZSBWSVJUSU9fTkVUX0ZfSE9TVF9V
U08gICAgIDU2CS8qIEhvc3QgY2FuIGhhbmRsZSBVU08gcGFja2V0cyAqLwo+ICAgI2RlZmluZSBW
SVJUSU9fTkVUX0ZfSEFTSF9SRVBPUlQgIDU3CS8qIFN1cHBvcnRzIGhhc2ggcmVwb3J0ICovCj4g
ICAjZGVmaW5lIFZJUlRJT19ORVRfRl9SU1MJICA2MAkvKiBTdXBwb3J0cyBSU1MgUlggc3RlZXJp
bmcgKi8KPiAgICNkZWZpbmUgVklSVElPX05FVF9GX1JTQ19FWFQJICA2MQkvKiBleHRlbmRlZCBj
b2FsZXNjaW5nIGluZm8gKi8KPiBAQCAtMTMwLDYgKzEzMSw3IEBAIHN0cnVjdCB2aXJ0aW9fbmV0
X2hkcl92MSB7Cj4gICAjZGVmaW5lIFZJUlRJT19ORVRfSERSX0dTT19UQ1BWNAkxCS8qIEdTTyBm
cmFtZSwgSVB2NCBUQ1AgKFRTTykgKi8KPiAgICNkZWZpbmUgVklSVElPX05FVF9IRFJfR1NPX1VE
UAkJMwkvKiBHU08gZnJhbWUsIElQdjQgVURQIChVRk8pICovCj4gICAjZGVmaW5lIFZJUlRJT19O
RVRfSERSX0dTT19UQ1BWNgk0CS8qIEdTTyBmcmFtZSwgSVB2NiBUQ1AgKi8KPiArI2RlZmluZSBW
SVJUSU9fTkVUX0hEUl9HU09fVURQX0w0CTUJLyogR1NPIGZyYW1lLCBJUHY0IFVEUCAoVVNPKSAq
LwoKClRoaXMgaXMgdGhlIGdzb190eXBlIG5vdCB0aGUgZmVhdHVyZSBhY3R1YWxseS4KCkkgd29u
ZGVyIHdoYXQncyB0aGUgcmVhc29uIGZvciBub3QKCjEpIGludHJvZHVjaW5nIGEgZGVkaWNhdGVk
IHZpcnRpby1uZXQgZmVhdHVyZSBiaXQgZm9yIHRoaXMgCihWSVJUSU9fTkVUX0ZfR1VFU1RfR1NP
X1VEUF9MNC4KMikgdG9nZ2xlIHRoZSBORVRJRl9GX0dTT19VRFBfTDTCoCBmZWF0dXJlIGZvciB0
dW50YXAgYmFzZWQgb24gdGhlIApuZWdvdGlhdGVkIGZlYXR1cmUuCgpUaGFua3MKCgo+ICAgI2Rl
ZmluZSBWSVJUSU9fTkVUX0hEUl9HU09fRUNOCQkweDgwCS8qIFRDUCBoYXMgRUNOIHNldCAqLwo+
ICAgCV9fdTggZ3NvX3R5cGU7Cj4gICAJX192aXJ0aW8xNiBoZHJfbGVuOwkvKiBFdGhlcm5ldCAr
IElQICsgdGNwL3VkcCBoZHJzICovCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

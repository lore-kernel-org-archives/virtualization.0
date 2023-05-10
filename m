Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01100C77B7C
	for <virtualization@archiver.kernel.org>; Wed, 10 May 2023 15:23:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BDBD60AC9;
	Wed, 10 May 2023 15:23:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7BDBD60AC9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ik8ESORA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C6ZFs45vrVG9; Wed, 10 May 2023 15:23:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DE8E060A79;
	Wed, 10 May 2023 15:23:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DE8E060A79
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B331CC0037;
	Wed, 10 May 2023 15:23:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5CA1C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 15:23:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 72F8A8425A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 15:23:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 72F8A8425A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ik8ESORA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PvAcLSn3Crmc
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 15:23:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2178B841E2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2178B841E2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 15:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683732200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iQz0FmqJ0fhhQVp092YrUUlwTUhSHWlf9UDAQ/T7kzA=;
 b=ik8ESORAgyBVZDpyLxhJY3PK7uCOvT0siu1pWv7LUwXSO0jgfSexOWLkENCvkWMl4NFUFg
 pu3YVAERnJnsSjvt02odRlUvUcCE9ChhZd+Fd6cxqZ9LS+SGpmVaq2FlgEddwg/PxiyJ3N
 RE+tA7IzKn/dcwNYsJ+PAvHf2UroflE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-5fBNgTksNweYObRbVkQaZQ-1; Wed, 10 May 2023 11:23:19 -0400
X-MC-Unique: 5fBNgTksNweYObRbVkQaZQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30640be4fd0so2632458f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 08:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683732198; x=1686324198;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iQz0FmqJ0fhhQVp092YrUUlwTUhSHWlf9UDAQ/T7kzA=;
 b=UWNfN3s8prVhNu1BfCJIxMlp4IQ61Dxuu54GzJ9CUokahRvuL6ZOyfOAObTV7iVvCi
 YPY9AzTwz0yhui83/D6Jdz8zpDMb739h3tUMOI4u8VH2oVVfQQLsCqQDQwOVaNtZ7Dvb
 hZIvvblOkdB4teUNNcXZbptSrVxbyCgF1+/cM1Nq3pZ6euOCCFzcjf5JqljqepEdgZiJ
 lN5ieqqsNlNwKETVm0Y7OC39XQG8Q/IZZatKu4sAK31qLTFFYyGttyz8COm52xSLtqvK
 wZ4EzJc6bSd14fmcGJv7gENVWsuxashbGV2JUIflmlunGRvM3v0Y2fZFomfa6t2a3PaO
 VdWQ==
X-Gm-Message-State: AC+VfDxGF/y4qe1zgI/VmJET2DAu2mFA4aJ/zxHOB8R/RQ64AiEih0+H
 jVUdfuZUffIdTW+m2DOiH/HqKmN7LNcbddZ+tezH00wXhW5gve7EYalbCsyq3fsQaPTIhvtJWp7
 QSi31X7NbQlqZGiABq1I6YbG7SSsg+qrXXkhebxTAHw==
X-Received: by 2002:a5d:668c:0:b0:2fe:2775:6067 with SMTP id
 l12-20020a5d668c000000b002fe27756067mr13070920wru.28.1683732198397; 
 Wed, 10 May 2023 08:23:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5OVnaJRiAA0cQBb92KuhDH69k4SVMEoaKebUn/GNPF4wmy0jKK0SNfVankDjgdH6JTuuX5bw==
X-Received: by 2002:a5d:668c:0:b0:2fe:2775:6067 with SMTP id
 l12-20020a5d668c000000b002fe27756067mr13070898wru.28.1683732198056; 
 Wed, 10 May 2023 08:23:18 -0700 (PDT)
Received: from sgarzare-redhat ([217.171.72.110])
 by smtp.gmail.com with ESMTPSA id
 c17-20020adffb11000000b003075428aad5sm17481409wrr.29.2023.05.10.08.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 May 2023 08:23:17 -0700 (PDT)
Date: Wed, 10 May 2023 17:23:14 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zhuang Shengen <zhuangshengen@huawei.com>
Subject: Re: [PATCH] vsock: bugfix port residue in server
Message-ID: <ftuh7vhoxdxbymg6u3wlkfhlfoufupeqampqxc2ktqrpxndow3@dkpufdnuwlln>
References: <20230510142502.2293109-1-zhuangshengen@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20230510142502.2293109-1-zhuangshengen@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, jianjay.zhou@huawei.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-pci@vger.kernel.org, longpeng2@huawei.com
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

SGksCnRoYW5rcyBmb3IgdGhlIHBhdGNoLCB0aGUgY2hhbmdlIExHVE0sIGJ1dCBJIGhhdmUgdGhl
IGZvbGxvd2luZwpzdWdnZXN0aW9uczoKClBsZWFzZSBhdm9pZCAiYnVnZml4IiBpbiB0aGUgc3Vi
amVjdCwgImZpeCIgc2hvdWxkIGJlIGVub3VnaDoKaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2Mv
aHRtbC92NC4xNy9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5odG1sI2Rlc2NyaWJlLXlvdXIt
Y2hhbmdlcwoKQW55d2F5LCBJIHN1Z2dlc3QgdG8gY2hhbmdlIHRoZSBzdWJqZWN0IGluCiJ2c29j
azogYXZvaWQgdG8gY2xvc2UgY29ubmVjdGVkIHNvY2tldCBhZnRlciB0aGUgdGltZW91dCIKCk9u
IFdlZCwgTWF5IDEwLCAyMDIzIGF0IDEwOjI1OjAyUE0gKzA4MDAsIFpodWFuZyBTaGVuZ2VuIHdy
b3RlOgo+V2hlbiBjbGllbnQgYW5kIHNlcnZlciBlc3RhYmxpc2ggYSBjb25uZWN0aW9uIHRocm91
Z2ggdnNvY2ssCj50aGUgY2xpZW50IHNlbmQgYSByZXF1ZXN0IHRvIHRoZSBzZXJ2ZXIgdG8gaW5p
dGlhdGUgdGhlIGNvbm5lY3Rpb24sCj50aGVuIHN0YXJ0IGEgdGltZXIgdG8gd2FpdCBmb3IgdGhl
IHNlcnZlcidzIHJlc3BvbnNlLiBXaGVuIHRoZSBzZXJ2ZXIncwo+UkVTUE9OU0UgbWVzc2FnZSBh
cnJpdmVzLCB0aGUgdGltZXIgYWxzbyB0aW1lcyBvdXQgYW5kIGV4aXRzLiBUaGUKPnNlcnZlcidz
IFJFU1BPTlNFIG1lc3NhZ2UgaXMgcHJvY2Vzc2VkIGZpcnN0LCBhbmQgdGhlIGNvbm5lY3Rpb24g
aXMKPmVzdGFibGlzaGVkLiBIb3dldmVyLCB0aGUgY2xpZW50J3MgdGltZXIgYWxzbyB0aW1lcyBv
dXQsIHRoZSBvcmlnaW5hbAo+cHJvY2Vzc2luZyBsb2dpYyBvZiB0aGUgY2xpZW50IGlzIHRvIGRp
cmVjdGx5IHNldCB0aGUgc3RhdGUgb2YgdGhpcyB2c29jawo+dG8gQ0xPU0UgYW5kIHJldHVybiBF
VElNRURPVVQsIFVzZXIgd2lsbCByZWxlYXNlIHRoZSBwb3J0LiBJdCB3aWxsIG5vdAoKV2hhdCB0
byB5b3UgbWVhbiB3aXRoICJVc2VyIiBoZXJlPwoKPm5vdGlmeSB0aGUgc2VydmVyIHdoZW4gdGhl
IHBvcnQgaXMgcmVsZWFzZWQsIGNhdXNpbmcgdGhlIHNlcnZlciBwb3J0IHJlbWFpbgo+CgpDYW4g
d2UgcmVtb3ZlIHRoaXMgYmxhbmsgbGluZT8KCj53aGVuIGNsaWVudCdzIHZzb2NrX2Nvbm5lY3Qg
dGltZW91dO+8jGl0IHNob3VsZCBjaGVjayBzayBzdGF0ZSBpcwoKVGhlIHJlbW90ZSBwZWVyIGNh
bid0IHRydXN0IHRoZSBvdGhlciBwZWVyLCBpbmRlZWQgaXQgd2lsbCByZWNlaXZlIGFuCmVycm9y
IGFmdGVyIHNlbmRpbmcgdGhlIGZpcnN0IG1lc3NhZ2UgYW5kIGl0IHdpbGwgcmVtb3ZlIHRoZSBj
b25uZWN0aW9uLApyaWdodD8KCj5FU1RBQkxJU0hFRCBvciBub3QuIGlmIHNrIHN0YXRlIGlzIEVT
VEFCTElTSEVELCBpdCBtZWFucyB0aGUgY29ubmVjdGlvbgo+aXMgZXN0YWJsaXNoZWQsIHRoZSBj
bGllbnQgc2hvdWxkIG5vdCBzZXQgdGhlIHNrIHN0YXRlIHRvIENMT1NFCj4KPk5vdGU6IEkgZW5j
b3VudGVyZWQgdGhpcyBpc3N1ZSBvbiBrZXJuZWwtNC4xOCwgd2hpY2ggY2FuIGJlIGZpeGVkIGJ5
Cj50aGlzIHBhdGNoLiBUaGVuIEkgY2hlY2tlZCB0aGUgbGF0ZXN0IGNvZGUgaW4gdGhlIGNvbW11
bml0eQo+YW5kIGZvdW5kIHNpbWlsYXIgaXNzdWUuCj4KCkluIG9yZGVyIHRvIGJhY2twb3J0IGl0
IHRvIHRoZSBzdGFibGUga2VybmVscywgd2Ugc2hvdWxkIGFkZCBhIEZpeGVzIHRhZzoKaHR0cHM6
Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC92NC4xNy9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hl
cy5odG1sI2Rlc2NyaWJlLXlvdXItY2hhbmdlcwoKVGhhbmtzLApTdGVmYW5vCgo+U2lnbmVkLW9m
Zi1ieTogWmh1YW5nIFNoZW5nZW4gPHpodWFuZ3NoZW5nZW5AaHVhd2VpLmNvbT4KPi0tLQo+IG5l
dC92bXdfdnNvY2svYWZfdnNvY2suYyB8IDIgKy0KPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKPgo+ZGlmZiAtLWdpdCBhL25ldC92bXdfdnNvY2svYWZfdnNv
Y2suYyBiL25ldC92bXdfdnNvY2svYWZfdnNvY2suYwo+aW5kZXggNDEzNDA3YmI2NDZjLi5lZmI4
YTA5MzdhMTMgMTAwNjQ0Cj4tLS0gYS9uZXQvdm13X3Zzb2NrL2FmX3Zzb2NrLmMKPisrKyBiL25l
dC92bXdfdnNvY2svYWZfdnNvY2suYwo+QEAgLTE0NjIsNyArMTQ2Miw3IEBAIHN0YXRpYyBpbnQg
dnNvY2tfY29ubmVjdChzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHIgKmFkZHIs
Cj4gCQkJdnNvY2tfdHJhbnNwb3J0X2NhbmNlbF9wa3QodnNrKTsKPiAJCQl2c29ja19yZW1vdmVf
Y29ubmVjdGVkKHZzayk7Cj4gCQkJZ290byBvdXRfd2FpdDsKPi0JCX0gZWxzZSBpZiAodGltZW91
dCA9PSAwKSB7Cj4rCQl9IGVsc2UgaWYgKChzay0+c2tfc3RhdGUgIT0gVENQX0VTVEFCTElTSEVE
KSAmJiAodGltZW91dCA9PSAwKSkgewo+IAkJCWVyciA9IC1FVElNRURPVVQ7Cj4gCQkJc2stPnNr
X3N0YXRlID0gVENQX0NMT1NFOwo+IAkJCXNvY2stPnN0YXRlID0gU1NfVU5DT05ORUNURUQ7Cj4t
LSAKPjIuMjcuMAo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

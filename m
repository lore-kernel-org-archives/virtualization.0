Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9092DC433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 02:42:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23B1E61039
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 02:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 23B1E61039
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD508403DE;
	Tue, 26 Oct 2021 02:42:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id noNs9dtS3N5w; Tue, 26 Oct 2021 02:42:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6A9A940368;
	Tue, 26 Oct 2021 02:42:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45009C0019;
	Tue, 26 Oct 2021 02:42:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3354C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 02:42:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B10B84013D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 02:42:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JXPwTNSyvrK0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 02:42:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CA482400E1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 02:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635216146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FdD2jYiTLkWh1i3uVag1O1QA1CQoWpWVgh7yC5XpK20=;
 b=LYxbU289m7gQC/qr4Nzu5GaCjIB9XBZi7czEBiYNWbL18fTRUS6i7HoKpfWQdET+Vg4i18
 5ZP4s5mZ9nximn7Pm0hJJXKreyHx+c+UVFO63zl9cMcqlTVHvKhFF6PTyKHiClgAZx14cH
 XKNGpJcebryA4fvfnt2wMX3OTQbxisM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-KcjiJ9aFPAuUkJY8eiLEoA-1; Mon, 25 Oct 2021 22:42:25 -0400
X-MC-Unique: KcjiJ9aFPAuUkJY8eiLEoA-1
Received: by mail-pl1-f197.google.com with SMTP id
 m5-20020a170902bb8500b0013a2b785187so4408251pls.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 19:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=FdD2jYiTLkWh1i3uVag1O1QA1CQoWpWVgh7yC5XpK20=;
 b=6PEUVILsBgCi2kInM6zVwC7WFRXahkQbjSW7168g/Xv1rxRz8NmQpBINTpfjcj80EJ
 ZwYMBoJIrK0Jlq21Avdbq6mzUsLJMBJn/z/BPBGQv+Jo2GzkyybpmZJhusuRtkXTWbz7
 zZHAicqC7YxFGW1U5anQtzHDoS6ECRLjQTBR0GBSiT4UVqN0E37eYhT2M6TAWo/KNia3
 YAvKp+/m4RQfgnEy5oPFSukiFbfVLLcpq5rR7+zDAb9feuV5NLf/yjdKHdVMuE/71IcZ
 YfoYypnACYrY4tlZ5LgxzGb9HyhnyOHNX0SSbiwTsmSD/YsRdHdAzICwLO86YCZvDCOC
 vnhA==
X-Gm-Message-State: AOAM532wHUzMyK4myZORZ8frhOlzMYsXzJZb4PRdL4dJW0M/ujok7Xj7
 ZR4bXUApC5NJvSNTYJS6fSQwYtQavSNpa7/ZBldOKuZTXA6UeQqPV9dMLtiiXD2p1lNFfqpTR2J
 txMteD0QrXTfw5ZLVET+pUGztlJDCztJHkXIEPYvd1A==
X-Received: by 2002:a63:7542:: with SMTP id f2mr16656582pgn.64.1635216144069; 
 Mon, 25 Oct 2021 19:42:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxARotogAt5XGfbv2rsn7Mk9Z8bObDfXye5qxC3Gav/DaAI16nIpv03dgDiEuhkbC4H2RUbIw==
X-Received: by 2002:a63:7542:: with SMTP id f2mr16656554pgn.64.1635216143668; 
 Mon, 25 Oct 2021 19:42:23 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id a25sm841389pfl.115.2021.10.25.19.42.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Oct 2021 19:42:23 -0700 (PDT)
Subject: Re: [PATCH linux-next v4 6/8] vdpa/mlx5: Fix clearing of
 VIRTIO_NET_F_MAC feature bit
To: Parav Pandit <parav@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20211021163509.6978-1-parav@nvidia.com>
 <20211021163509.6978-7-parav@nvidia.com>
 <53c1e41b-cac2-2419-9bd9-e40163e98dad@redhat.com>
 <PH0PR12MB5481233AF957874DF60575CEDC839@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1d2a05d5-48af-89e2-ec7d-8ae0018ffa7a@redhat.com>
Date: Tue, 26 Oct 2021 10:42:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481233AF957874DF60575CEDC839@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>
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

CuWcqCAyMDIxLzEwLzI1IOS4i+WNiDM6MDgsIFBhcmF2IFBhbmRpdCDlhpnpgZM6Cj4KPj4gRnJv
bTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPj4gU2VudDogTW9uZGF5LCBPY3Rv
YmVyIDI1LCAyMDIxIDEyOjM1IFBNCj4+Cj4+IOWcqCAyMDIxLzEwLzIyIOS4iuWNiDEyOjM1LCBQ
YXJhdiBQYW5kaXQg5YaZ6YGTOgo+Pj4gQ2l0ZWQgcGF0Y2ggaW4gdGhlIGZpeGVzIHRhZyBjbGVh
cnMgdGhlIGZlYXR1cmVzIGJpdCBkdXJpbmcgcmVzZXQuCj4+PiBtbHg1IHZkcGEgZGV2aWNlIGZl
YXR1cmUgYml0cyBhcmUgc3RhdGljIGRlY2lkZWQgYnkgZGV2aWNlIGNhcGFiaWxpdGllcy4KPj4K
Pj4gVGhpcyBpcyBub3Qgd2hhdCBJIHJlYWQgYXQgbGVhc3QgZnJvbSBtbHg1X3ZkcGFfZ2V0X2Zl
YXR1cmVzOgo+Pgo+PiBzdGF0aWMgdTY0IG1seDVfdmRwYV9nZXRfZmVhdHVyZXMoc3RydWN0IHZk
cGFfZGV2aWNlICp2ZGV2KSB7Cj4+ICAgwqDCoMKgwqDCoMKgwqAgc3RydWN0IG1seDVfdmRwYV9k
ZXYgKm12ZGV2ID0gdG9fbXZkZXYodmRldik7Cj4+ICAgwqDCoMKgwqDCoMKgwqAgc3RydWN0IG1s
eDVfdmRwYV9uZXQgKm5kZXYgPSB0b19tbHg1X3ZkcGFfbmRldihtdmRldik7Cj4+ICAgwqDCoMKg
wqDCoMKgwqAgdTE2IGRldl9mZWF0dXJlczsKPj4KPj4gICDCoMKgwqDCoMKgwqDCoCBkZXZfZmVh
dHVyZXMgPSBNTFg1X0NBUF9ERVZfVkRQQV9FTVVMQVRJT04obXZkZXYtPm1kZXYsCj4+IGRldmlj
ZV9mZWF0dXJlc19iaXRzX21hc2spOwo+IE5vdCBzdXJlIEkgZm9sbG93LiBGZWF0dXJlIGJpdHMg
YXJlIGRlY2lkZWQgYnkgdGhlIGRldmljZSBjYXBhYmlsaXRpZXMgZXhwb3NlZCBieSB0aGUgTUxY
NV9DQVBfREVWX1ZEUEFfRU1VTEFUSU9OLgo+IE90aGVyIGZpZWxkcyBiZWxvdyBhcmUgcHJldHR5
IG11Y2ggc3RhdGljLgoKCk9rLCBzbyBJIHRoaW5rIGluIHRoZSBjb21taXQgbG9nIHdlIG5lZWQg
YWxzbyBtZW50aW9uIHRoYXQgdGhlIApWSVJUSU9fTkVUX0ZfTUFDIGlzIGRldGVybWluZWQgYW5k
IHN0b3JlZCBpbiBkZXZpY2UgYWRkaW5nLgoKVGhhbmtzCgoKPgo+PiAgIMKgwqDCoMKgwqDCoMKg
IG5kZXYtPm12ZGV2Lm1seF9mZWF0dXJlcyB8PSBtbHhfdG9fdnJpdGlvX2ZlYXR1cmVzKGRldl9m
ZWF0dXJlcyk7Cj4+ICAgwqDCoMKgwqDCoMKgwqAgaWYgKE1MWDVfQ0FQX0RFVl9WRFBBX0VNVUxB
VElPTihtdmRldi0+bWRldiwKPj4gdmlydGlvX3ZlcnNpb25fMV8wKSkKPj4gICDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbmRldi0+bXZkZXYubWx4X2ZlYXR1cmVzIHw9IEJJVF9VTEwo
VklSVElPX0ZfVkVSU0lPTl8xKTsKPj4gICDCoMKgwqDCoMKgwqDCoCBuZGV2LT5tdmRldi5tbHhf
ZmVhdHVyZXMgfD0gQklUX1VMTChWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0pOwo+PiAgIMKgwqDC
oMKgwqDCoMKgIG5kZXYtPm12ZGV2Lm1seF9mZWF0dXJlcyB8PSBCSVRfVUxMKFZJUlRJT19ORVRf
Rl9DVFJMX1ZRKTsKPj4gICDCoMKgwqDCoMKgwqDCoCBuZGV2LT5tdmRldi5tbHhfZmVhdHVyZXMg
fD0KPj4gQklUX1VMTChWSVJUSU9fTkVUX0ZfQ1RSTF9NQUNfQUREUik7Cj4+ICAgwqDCoMKgwqDC
oMKgwqAgbmRldi0+bXZkZXYubWx4X2ZlYXR1cmVzIHw9IEJJVF9VTEwoVklSVElPX05FVF9GX01R
KTsKPj4KPj4gICDCoMKgwqDCoMKgwqDCoCBwcmludF9mZWF0dXJlcyhtdmRldiwgbmRldi0+bXZk
ZXYubWx4X2ZlYXR1cmVzLCBmYWxzZSk7Cj4+ICAgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIG5kZXYt
Pm12ZGV2Lm1seF9mZWF0dXJlczsgfQo+Pgo+Pgo+PiBUaGFua3MKPj4KPj4KPj4+IENsZWFyaW5n
IGZlYXR1cmVzIGJpdCBjbGVhcmVkIHRoZSBWSVJUSU9fTkVUX0ZfTUFDLiBEdWUgdG8gdGhpcyBN
QUMKPj4+IGFkZHJlc3MgcHJvdmlkZWQgYnkgdGhlIGRldmljZSBpcyBub3QgaG9ub3JlZC4KPj4+
Cj4+PiBGaXggaXQgYnkgbm90IGNsZWFyaW5nIHRoZSBzdGF0aWMgZmVhdHVyZSBiaXRzIGR1cmlu
ZyByZXNldC4KPj4+Cj4+PiBGaXhlczogMDY4NjA4MmRiZjdhICgidmRwYTogQWRkIHJlc2V0IGNh
bGxiYWNrIGluIHZkcGFfY29uZmlnX29wcyIpCj4+PiBTaWduZWQtb2ZmLWJ5OiBQYXJhdiBQYW5k
aXQgPHBhcmF2QG52aWRpYS5jb20+Cj4+PiBSZXZpZXdlZC1ieTogRWxpIENvaGVuIDxlbGljQG52
aWRpYS5jb20+Cj4+PiAtLS0KPj4+ICAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
YyB8IDEgLQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKPj4+Cj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+PiBiL2RyaXZlcnMv
dmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4gaW5kZXggY2EwNWY2OTA1NGI2Li4wYTJiNzk4
ODcwODUgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMK
Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4gQEAgLTIxOTIs
NyArMjE5Miw2IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX3Jlc2V0KHN0cnVjdCB2ZHBhX2Rldmlj
ZQo+PiAqdmRldikKPj4+ICAgIAljbGVhcl92cXNfcmVhZHkobmRldik7Cj4+PiAgICAJbWx4NV92
ZHBhX2Rlc3Ryb3lfbXIoJm5kZXYtPm12ZGV2KTsKPj4+ICAgIAluZGV2LT5tdmRldi5zdGF0dXMg
PSAwOwo+Pj4gLQluZGV2LT5tdmRldi5tbHhfZmVhdHVyZXMgPSAwOwo+Pj4gICAgCW1lbXNldChu
ZGV2LT5ldmVudF9jYnMsIDAsIHNpemVvZihuZGV2LT5ldmVudF9jYnMpKTsKPj4+ICAgIAluZGV2
LT5tdmRldi5hY3R1YWxfZmVhdHVyZXMgPSAwOwo+Pj4gICAgCSsrbXZkZXYtPmdlbmVyYXRpb247
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=

Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403D7C47098
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 07:12:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC5B360230
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 07:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5B360230
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9DAD5404F9;
	Thu,  3 Jun 2021 07:12:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S5oiPntil3LJ; Thu,  3 Jun 2021 07:12:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 41421404F6;
	Thu,  3 Jun 2021 07:12:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1493FC000D;
	Thu,  3 Jun 2021 07:12:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0E9BC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 07:12:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 97A6F404F6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 07:12:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QapaKc8Sxn72
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 07:12:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 92F99402CD
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 07:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622704321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/mZg6Rd+caE13qcrgBT5LqErzvWPmG8WQ41iAFGpAiA=;
 b=Da+BNEAqAZIwMAEVztddlXyI8coqCVzCluTndsHklipseYiDx24F/Yom1Dxe8WQrVLo++Q
 C2sOUCMa5Kojo/hmryzIWI+BNxKDZ9zREY2VAntD23hCVX7ChQleU07W4cUqLsMJytvZPm
 sVaEfQavXnngW4xvW58sZEHKKB8s+9k=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-DBiK8Y3BPWalEKq-202MYA-1; Thu, 03 Jun 2021 03:11:59 -0400
X-MC-Unique: DBiK8Y3BPWalEKq-202MYA-1
Received: by mail-pl1-f200.google.com with SMTP id
 p7-20020a170902e747b02900ef00d14127so1486321plf.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Jun 2021 00:11:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=/mZg6Rd+caE13qcrgBT5LqErzvWPmG8WQ41iAFGpAiA=;
 b=PkoCZ/cCDosfXcgO32JTQL/4Yj+BsnSQpUrWJmxq9atm7lBVWYZ5Bgcd072fGA1kpw
 Yk/UDv55/QbucyZ+X2BsaLpbZodlWlSHnJo2nnuZjl/7OAGvcXTUrSANcrAeu8uH4fJz
 rRuJ4FoLFngfoN7aZJCyeWLO0iSpSx79G18/6iv5/Zg3xTC1NREY/ddnEPi1uSBKqzcz
 jxPpdYu6zrai10lpV27Td3URqwYhWlqQuII/7QgyKE0/4OseQmWhfKhVBxdwzf+DGTMw
 ddhtRKAcA+uhkCHzzhy2qBt+bWb3s/4XJojtjMTOdAHYjSR0W1a31nQnGNw7FKk5HE/w
 AvEg==
X-Gm-Message-State: AOAM5328rVhJ047r88bu3wBoP1/LHoSivfkiI4/KkciWVMD5et3DvyYc
 dY1CddwIgOZPR7VuLXrMf4PgNR0U4w7tVVGrs6QDfbHi7icVIR/503f2GHOjf/h4Z7bw8f6n+V0
 L2+RbAuLZ9gfA2QHcxoP45R1hFixroTTB6mMAishBqg==
X-Received: by 2002:a65:4286:: with SMTP id j6mr37621877pgp.11.1622704318604; 
 Thu, 03 Jun 2021 00:11:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJws8WyQDRQptqrThLm0iy+MBLiH7cbhLCecXzxmkaKE5c7hr5ROL7i8/p2U51RCVi/D5NwLYA==
X-Received: by 2002:a65:4286:: with SMTP id j6mr37621845pgp.11.1622704318264; 
 Thu, 03 Jun 2021 00:11:58 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 60sm1300265pjz.42.2021.06.03.00.11.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jun 2021 00:11:57 -0700 (PDT)
Subject: Re: [PATCH v1] vdpa/mlx5: Add support for doorbell bypassing
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210602095358.83318-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f99c6019-3b7a-8a91-27fc-7db70e9f1c1c@redhat.com>
Date: Thu, 3 Jun 2021 15:11:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602095358.83318-1-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNi8yIM/Czuc1OjUzLCBFbGkgQ29oZW4g0LS1wDoKPiBJbXBsZW1lbnQgbWx4NV9n
ZXRfdnFfbm90aWZpY2F0aW9uKCkgdG8gcmV0dXJuIHRoZSBkb29yYmVsbCBhZGRyZXNzLgo+IFNp
bmNlIHRoZSBub3RpZmljYXRpb24gYXJlYSBpcyBtYXBwZWQgdG8gdXNlcnNwYWNlLCBtYWtlIHN1
cmUgdGhhdCB0aGUKPiBCQVIgc2l6ZSBpcyBhdCBsZWFzdCBQQUdFX1NJWkUgbGFyZ2UuCj4KPiBT
aWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPiAtLS0KPiB2MCAtLT4g
djE6Cj4gICAgTWFrZSBzdXJlIFNGIGJhciBzaXplIGlzIG5vdCBzbWFsbGVyIHRoYW4gUEFHRV9T
SVpFCj4KPiAgIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmggfCAgMSArCj4gICBk
cml2ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jIHwgIDEgKwo+ICAgZHJpdmVycy92ZHBh
L21seDUvbmV0L21seDVfdm5ldC5jICB8IDE3ICsrKysrKysrKysrKysrKysrCj4gICAzIGZpbGVz
IGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEv
bWx4NS9jb3JlL21seDVfdmRwYS5oIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEu
aAo+IGluZGV4IDA5YTE2YTNkMWIyYS4uMDAwMmIyMTM2YjQ4IDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9j
b3JlL21seDVfdmRwYS5oCj4gQEAgLTQyLDYgKzQyLDcgQEAgc3RydWN0IG1seDVfdmRwYV9yZXNv
dXJjZXMgewo+ICAgCXUzMiBwZG47Cj4gICAJc3RydWN0IG1seDVfdWFyc19wYWdlICp1YXI7Cj4g
ICAJdm9pZCBfX2lvbWVtICpraWNrX2FkZHI7Cj4gKwl1NjQgcGh5c19raWNrX2FkZHI7Cj4gICAJ
dTE2IHVpZDsKPiAgIAl1MzIgbnVsbF9ta2V5Owo+ICAgCWJvb2wgdmFsaWQ7Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvcmVzb3VyY2VzLmMgYi9kcml2ZXJzL3ZkcGEvbWx4
NS9jb3JlL3Jlc291cmNlcy5jCj4gaW5kZXggODM2YWI5ZWYwZmE2Li5kNDYwNjIxM2Y4OGEgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9yZXNvdXJjZXMuYwo+ICsrKyBiL2Ry
aXZlcnMvdmRwYS9tbHg1L2NvcmUvcmVzb3VyY2VzLmMKPiBAQCAtMjUzLDYgKzI1Myw3IEBAIGlu
dCBtbHg1X3ZkcGFfYWxsb2NfcmVzb3VyY2VzKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldikK
PiAgIAkJZ290byBlcnJfa2V5Owo+ICAgCj4gICAJa2lja19hZGRyID0gbWRldi0+YmFyX2FkZHIg
KyBvZmZzZXQ7Cj4gKwlyZXMtPnBoeXNfa2lja19hZGRyID0ga2lja19hZGRyOwo+ICAgCj4gICAJ
cmVzLT5raWNrX2FkZHIgPSBpb3JlbWFwKGtpY2tfYWRkciwgUEFHRV9TSVpFKTsKPiAgIAlpZiAo
IXJlcy0+a2lja19hZGRyKSB7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IGluZGV4IDU1
MDBiY2ZlODRiNC4uMTkzNjAzOWUwNWJkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1
L25ldC9tbHg1X3ZuZXQuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
Ywo+IEBAIC0xODcxLDggKzE4NzEsMjUgQEAgc3RhdGljIHZvaWQgbWx4NV92ZHBhX2ZyZWUoc3Ry
dWN0IHZkcGFfZGV2aWNlICp2ZGV2KQo+ICAgCj4gICBzdGF0aWMgc3RydWN0IHZkcGFfbm90aWZp
Y2F0aW9uX2FyZWEgbWx4NV9nZXRfdnFfbm90aWZpY2F0aW9uKHN0cnVjdCB2ZHBhX2RldmljZSAq
dmRldiwgdTE2IGlkeCkKPiAgIHsKPiArCXN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiA9IHRv
X212ZGV2KHZkZXYpOwo+ICAgCXN0cnVjdCB2ZHBhX25vdGlmaWNhdGlvbl9hcmVhIHJldCA9IHt9
Owo+ICsJc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXY7Cj4gKwlwaHlzX2FkZHJfdCBhZGRyOwo+
ICsKPiArCS8qIElmIFNGIEJBUiBzaXplIGlzIHNtYWxsZXIgdGhhbiBQQUdFX1NJWkUsIGRvIG5v
dCB1c2UgZGlyZWN0Cj4gKwkgKiBub3RpZmljYXRpb24gdG8gYXZvaWQgdGhlIHJpc2sgb2YgbWFw
cGluZyBwYWdlcyB0aGF0IGNvbnRhaW4gQkFSIG9mIG1vcmUKPiArCSAqIHRoYW4gb25lIFNGCj4g
KwkgKi8KPiArCWlmIChNTFg1X0NBUF9HRU4obXZkZXYtPm1kZXYsIGxvZ19taW5fc2Zfc2l6ZSkg
KyAxMiA8IFBBR0VfU0hJRlQpCj4gKwkJcmV0dXJuIHJldDsKPiArCj4gKwluZGV2ID0gdG9fbWx4
NV92ZHBhX25kZXYobXZkZXYpOwo+ICsJYWRkciA9IChwaHlzX2FkZHJfdCluZGV2LT5tdmRldi5y
ZXMucGh5c19raWNrX2FkZHI7Cj4gKwlpZiAoYWRkciAmIH5QQUdFX01BU0spCj4gKwkJcmV0dXJu
IHJldDsKCgpUaGlzIGhhcyBiZWVuIGNoZWNrZWQgYnkgdmhvc3QtdkRQQSwgYW5kIGl0J3MgYmV0
dGVyIHRvIGxlYXZlIHRob3NlIApwb2xpY3kgY2hlY2tpbmcgdG8gdGhlbSBkcml2ZXIgaW5zdGVh
ZCBvZiBjaGVja2luZyBpdCBpbiB0aGUgcGFyZW50LgoKVGhhbmtzCgoKPiAgIAo+ICsJcmV0LmFk
ZHIgPSAocGh5c19hZGRyX3QpbmRldi0+bXZkZXYucmVzLnBoeXNfa2lja19hZGRyOwo+ICsJcmV0
LnNpemUgPSBQQUdFX1NJWkU7Cj4gICAJcmV0dXJuIHJldDsKPiAgIH0KPiAgIAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u

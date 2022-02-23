Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46736C433F5
	for <virtualization@archiver.kernel.org>; Wed, 23 Feb 2022 02:53:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5CE1401B9;
	Wed, 23 Feb 2022 02:53:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id THMpMl4jyA65; Wed, 23 Feb 2022 02:53:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 97660401D2;
	Wed, 23 Feb 2022 02:53:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56DCDC001A;
	Wed, 23 Feb 2022 02:53:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 759BBC0011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:53:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5480980B0D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:53:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bfbCuG75Erxu
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:53:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AAFC980ADC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645584813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=97UACQHtha/E1VpnTXRsyoGsVCoRUEP55ZUFTxP9SNc=;
 b=OzaV7OIBtffbQ95uKpT9tdLXJxRY5ljqhmFJr8/p+hMinmrGOWtBa1QpeIgBOW/OZfabDB
 nywzL8n/BOKax3mV92ysMdRC1CIQTidosFxS3pFXKB67BUGN1n3bVmodsXX/YGTHXQotAv
 WrhcSBduFtPzgg5AEgrLd2IuvUBHKSI=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-XyErMqTkN9qRnQOEegAolA-1; Tue, 22 Feb 2022 21:53:32 -0500
X-MC-Unique: XyErMqTkN9qRnQOEegAolA-1
Received: by mail-pf1-f198.google.com with SMTP id
 y127-20020a626485000000b004f1027d72a7so6068360pfb.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 18:53:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=97UACQHtha/E1VpnTXRsyoGsVCoRUEP55ZUFTxP9SNc=;
 b=vFahZHRXw8UQA+FGvk32lNvBA1KTRQ9wJd1J/NXHoEAUh8IWmJzLoMdZCNmrlVHQxO
 V5k1c7qmcZyLf3nfIupakZNGsl/R2mMLUt7P8/+FsMwqz02Ht0igvbSpK2VJUrNw7jfq
 fphbFkXestUu0DJFNfLp8jb6QDpYeiI4IWu6t4dy4kZbiKS5Gt8iRyXC3Qp3v9CztZV0
 b5XzXkzANc/ls9IKI2aK2fPDOQHVH0r94Lephc/P2+9S30yid41RfXv+xRpCAftujnWT
 X9kdlhk8Q/kvVhMz+Yr7Cl/b13cyTLQFTENnconmuEdBpbbodyrvz+7NGECXB+wDWXbF
 JkVQ==
X-Gm-Message-State: AOAM532GDPmde4p/mCLvZNQ5575G/qamh4DNsZH49f3CXZ4Iou2TEtBT
 osOjTnqVqawKZuAsrDO/gEa4ggBpU/j7sz/yyD4VYSWGP8ZLzgrGKge+L8BTmXu2Bu0FFftCX1P
 gGWQLWhww5dkFrcX4BgCmPFN8TmMN/0xvpbANbEOaVA==
X-Received: by 2002:a63:c47:0:b0:371:3a2e:32d8 with SMTP id
 7-20020a630c47000000b003713a2e32d8mr21629172pgm.281.1645584810911; 
 Tue, 22 Feb 2022 18:53:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJym0x5wi1ZAXFG0FTuC5VeMqfJ7/98rMRBokeesZDgxHutmwsCHSx0W5KIhO0Ksqal7IMBAcA==
X-Received: by 2002:a63:c47:0:b0:371:3a2e:32d8 with SMTP id
 7-20020a630c47000000b003713a2e32d8mr21629165pgm.281.1645584810612; 
 Tue, 22 Feb 2022 18:53:30 -0800 (PST)
Received: from [10.72.13.161] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id q32sm22815691pgm.26.2022.02.22.18.53.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Feb 2022 18:53:30 -0800 (PST)
Message-ID: <a0885532-11a6-615f-bb17-2290686c4f03@redhat.com>
Date: Wed, 23 Feb 2022 10:53:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v1 3/6] virtio: remove flags check for unmap packed
 indirect desc
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220210085124.15466-1-xuanzhuo@linux.alibaba.com>
 <20220210085124.15466-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220210085124.15466-4-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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

CuWcqCAyMDIyLzIvMTAg5LiL5Y2INDo1MSwgWHVhbiBaaHVvIOWGmemBkzoKPiBXaGVuIGNhbGxp
bmcgdnJpbmdfdW5tYXBfZGVzY19wYWNrZWQoKSwgaXQgd2lsbCBub3QgZW5jb3VudGVyIHRoZQo+
IHNpdHVhdGlvbiB0aGF0IHRoZSBmbGFncyBjb250YWlucyBWUklOR19ERVNDX0ZfSU5ESVJFQ1Qu
IFNvIHJlbW92ZSB0aGlzCj4gbG9naWMuCgoKVGhpcyBzZWVtcyBub3QgY29ycmVjdC4KClRoZXJl
J3MgYSBjYWxsIGZyb20gZGV0YWNoX2J1Zl9wYWNrZWQoKSB0aGF0IGNhbiB3b3JrIGZvciBpbmRp
cmVjdCAKZGVzY3JpcHRvcnM/CgpUaGFua3MKCgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVv
IDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3Zp
cnRpb19yaW5nLmMgfCAxOCArKysrKy0tLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5k
ZXggZmFkZDBhNzUwM2U5Li5jZmIwMjhjYTIzOGUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBA
QCAtMTAwOSwxOSArMTAwOSwxMSBAQCBzdGF0aWMgdm9pZCB2cmluZ191bm1hcF9kZXNjX3BhY2tl
ZChjb25zdCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPiAgIAo+ICAgCWZsYWdzID0gbGUx
Nl90b19jcHUoZGVzYy0+ZmxhZ3MpOwo+ICAgCj4gLQlpZiAoZmxhZ3MgJiBWUklOR19ERVNDX0Zf
SU5ESVJFQ1QpIHsKPiAtCQlkbWFfdW5tYXBfc2luZ2xlKHZyaW5nX2RtYV9kZXYodnEpLAo+IC0J
CQkJIGxlNjRfdG9fY3B1KGRlc2MtPmFkZHIpLAo+IC0JCQkJIGxlMzJfdG9fY3B1KGRlc2MtPmxl
biksCj4gLQkJCQkgKGZsYWdzICYgVlJJTkdfREVTQ19GX1dSSVRFKSA/Cj4gLQkJCQkgRE1BX0ZS
T01fREVWSUNFIDogRE1BX1RPX0RFVklDRSk7Cj4gLQl9IGVsc2Ugewo+IC0JCWRtYV91bm1hcF9w
YWdlKHZyaW5nX2RtYV9kZXYodnEpLAo+IC0JCQkgICAgICAgbGU2NF90b19jcHUoZGVzYy0+YWRk
ciksCj4gLQkJCSAgICAgICBsZTMyX3RvX2NwdShkZXNjLT5sZW4pLAo+IC0JCQkgICAgICAgKGZs
YWdzICYgVlJJTkdfREVTQ19GX1dSSVRFKSA/Cj4gLQkJCSAgICAgICBETUFfRlJPTV9ERVZJQ0Ug
OiBETUFfVE9fREVWSUNFKTsKPiAtCX0KPiArCWRtYV91bm1hcF9wYWdlKHZyaW5nX2RtYV9kZXYo
dnEpLAo+ICsJCSAgICAgICBsZTY0X3RvX2NwdShkZXNjLT5hZGRyKSwKPiArCQkgICAgICAgbGUz
Ml90b19jcHUoZGVzYy0+bGVuKSwKPiArCQkgICAgICAgKGZsYWdzICYgVlJJTkdfREVTQ19GX1dS
SVRFKSA/Cj4gKwkJICAgICAgIERNQV9GUk9NX0RFVklDRSA6IERNQV9UT19ERVZJQ0UpOwo+ICAg
fQo+ICAgCj4gICBzdGF0aWMgc3RydWN0IHZyaW5nX3BhY2tlZF9kZXNjICphbGxvY19pbmRpcmVj
dF9wYWNrZWQodW5zaWduZWQgaW50IHRvdGFsX3NnLAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

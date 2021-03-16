Return-Path: <SRS0=cXtE=IO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C57BC433E0
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 07:51:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC72364F8C
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 07:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC72364F8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 730B36F4F3;
	Tue, 16 Mar 2021 07:51:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jSgsHalTkmWc; Tue, 16 Mar 2021 07:51:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 025BD60654;
	Tue, 16 Mar 2021 07:51:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1E61C000B;
	Tue, 16 Mar 2021 07:51:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5073DC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 07:51:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3792C83A3C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 07:51:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q4p7roF9rDkp
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 07:51:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 68D5583942
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 07:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615881059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AY2pVgZQ8qnp0F65Bv2e/MO2m1QaprMdF+BkxncWLos=;
 b=Y0CZiURqcG7iF3Dpn+IRvtH8yOmGcXZFCP66e5vRHRSNK3OInRYrKjfP6WSbv/pumMsevP
 ItLRRrgwqKsWPJF8I8Ywas5unHz6a8Wt3VRHghg7anMk75A8wj35dOF6Kxz4MS0igPIuzg
 dhtZn/p7Vvco7YRotFfQsuHUTuuUJBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-JY7yx0cMO6-jOY2F-HZ-pA-1; Tue, 16 Mar 2021 03:50:55 -0400
X-MC-Unique: JY7yx0cMO6-jOY2F-HZ-pA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C307C100C667;
 Tue, 16 Mar 2021 07:50:53 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-216.pek2.redhat.com
 [10.72.12.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B2BF60C13;
 Tue, 16 Mar 2021 07:50:38 +0000 (UTC)
Subject: Re: [RFC v2 08/13] virtio: Add vhost_shadow_vq_get_vring_addr
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20210315194842.277740-1-eperezma@redhat.com>
 <20210315194842.277740-9-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0ab71cb2-6240-3c26-18db-71a1a9d25275@redhat.com>
Date: Tue, 16 Mar 2021 15:50:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210315194842.277740-9-eperezma@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Guru Prasad <guru.prasad@broadcom.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Eli Cohen <eli@mellanox.com>, Eric Blake <eblake@redhat.com>,
 Michael Lilja <ml@napatech.com>, Jim Harford <jim.harford@broadcom.com>,
 Rob Miller <rob.miller@broadcom.com>
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

CuWcqCAyMDIxLzMvMTYg5LiK5Y2IMzo0OCwgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IEl0IHJl
cG9ydHMgdGhlIHNoYWRvdyB2aXJ0cXVldWUgYWRkcmVzcyBmcm9tIHFlbXUgdmlydHVhbCBhZGRy
ZXNzIHNwYWNlCgoKTm90ZSB0aGF0IHRvIGJlIHVzZWQgYnkgdkRQQSwgd2UgY2FuJ3QgdXNlIHFl
bXUgVkEgZGlyZWN0bHkgaGVyZS4KCgo+Cj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXog
PGVwZXJlem1hQHJlZGhhdC5jb20+Cj4gLS0tCj4gICBody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZp
cnRxdWV1ZS5oIHwgIDIgKysKPiAgIGh3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMg
fCAyNCArKysrKysrKysrKysrKysrKysrKysrKy0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjUgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9z
dC1zaGFkb3ctdmlydHF1ZXVlLmggYi9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5o
Cj4gaW5kZXggMmNhNGI5MmIxMi4uZDgyYzM1YmNjZiAxMDA2NDQKPiAtLS0gYS9ody92aXJ0aW8v
dmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oCj4gKysrIGIvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12
aXJ0cXVldWUuaAo+IEBAIC0xOSw2ICsxOSw4IEBAIHR5cGVkZWYgc3RydWN0IFZob3N0U2hhZG93
VmlydHF1ZXVlIFZob3N0U2hhZG93VmlydHF1ZXVlOwo+ICAgCj4gICB2b2lkIHZob3N0X3NoYWRv
d192cV9tYXNrKFZob3N0U2hhZG93VmlydHF1ZXVlICpzdnEsIEV2ZW50Tm90aWZpZXIgKm1hc2tl
ZCk7Cj4gICB2b2lkIHZob3N0X3NoYWRvd192cV91bm1hc2soVmhvc3RTaGFkb3dWaXJ0cXVldWUg
KnN2cSk7Cj4gK3ZvaWQgdmhvc3Rfc2hhZG93X3ZxX2dldF92cmluZ19hZGRyKGNvbnN0IFZob3N0
U2hhZG93VmlydHF1ZXVlICpzdnEsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHN0cnVjdCB2aG9zdF92cmluZ19hZGRyICphZGRyKTsKPiAgIAo+ICAgYm9vbCB2aG9zdF9z
aGFkb3dfdnFfc3RhcnQoc3RydWN0IHZob3N0X2RldiAqZGV2LAo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdW5zaWduZWQgaWR4LAo+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3Qt
c2hhZG93LXZpcnRxdWV1ZS5jIGIvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYwo+
IGluZGV4IGI2YmFiNDM4ZDYuLjE0NjBkMWQ1ZDEgMTAwNjQ0Cj4gLS0tIGEvaHcvdmlydGlvL3Zo
b3N0LXNoYWRvdy12aXJ0cXVldWUuYwo+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmly
dHF1ZXVlLmMKPiBAQCAtMTcsNiArMTcsOSBAQAo+ICAgCj4gICAvKiBTaGFkb3cgdmlydHF1ZXVl
IHRvIHJlbGF5IG5vdGlmaWNhdGlvbnMgKi8KPiAgIHR5cGVkZWYgc3RydWN0IFZob3N0U2hhZG93
VmlydHF1ZXVlIHsKPiArICAgIC8qIFNoYWRvdyB2cmluZyAqLwo+ICsgICAgc3RydWN0IHZyaW5n
IHZyaW5nOwo+ICsKPiAgICAgICAvKiBTaGFkb3cga2ljayBub3RpZmllciwgc2VudCB0byB2aG9z
dCAqLwo+ICAgICAgIEV2ZW50Tm90aWZpZXIga2lja19ub3RpZmllcjsKPiAgICAgICAvKiBTaGFk
b3cgY2FsbCBub3RpZmllciwgc2VudCB0byB2aG9zdCAqLwo+IEBAIC01MSw2ICs1NCw5IEBAIHR5
cGVkZWYgc3RydWN0IFZob3N0U2hhZG93VmlydHF1ZXVlIHsKPiAgIAo+ICAgICAgIC8qIFZpcnRp
byBkZXZpY2UgKi8KPiAgICAgICBWaXJ0SU9EZXZpY2UgKnZkZXY7Cj4gKwo+ICsgICAgLyogRGVz
Y3JpcHRvcnMgY29waWVkIGZyb20gZ3Vlc3QgKi8KPiArICAgIHZyaW5nX2Rlc2NfdCBkZXNjc1td
Owo+ICAgfSBWaG9zdFNoYWRvd1ZpcnRxdWV1ZTsKPiAgIAo+ICAgLyogRm9yd2FyZCBndWVzdCBu
b3RpZmljYXRpb25zICovCj4gQEAgLTEzMiw2ICsxMzgsMTkgQEAgdm9pZCB2aG9zdF9zaGFkb3df
dnFfdW5tYXNrKFZob3N0U2hhZG93VmlydHF1ZXVlICpzdnEpCj4gICAgICAgcWVtdV9ldmVudF93
YWl0KCZzdnEtPm1hc2tlZF9ub3RpZmllci5pc19mcmVlKTsKPiAgIH0KPiAgIAo+ICsvKgo+ICsg
KiBHZXQgdGhlIHNoYWRvdyB2cSB2cmluZyBhZGRyZXNzLgo+ICsgKiBAc3ZxIFNoYWRvdyB2aXJ0
cXVldWUKPiArICogQGFkZHIgRGVzdGluYXRpb24gdG8gc3RvcmUgYWRkcmVzcwo+ICsgKi8KPiAr
dm9pZCB2aG9zdF9zaGFkb3dfdnFfZ2V0X3ZyaW5nX2FkZHIoY29uc3QgVmhvc3RTaGFkb3dWaXJ0
cXVldWUgKnN2cSwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IHZob3N0X3ZyaW5nX2FkZHIgKmFkZHIpCj4gK3sKPiArICAgIGFkZHItPmRlc2NfdXNlcl9hZGRy
ID0gKHVpbnQ2NF90KXN2cS0+dnJpbmcuZGVzYzsKPiArICAgIGFkZHItPmF2YWlsX3VzZXJfYWRk
ciA9ICh1aW50NjRfdClzdnEtPnZyaW5nLmF2YWlsOwo+ICsgICAgYWRkci0+dXNlZF91c2VyX2Fk
ZHIgPSAodWludDY0X3Qpc3ZxLT52cmluZy51c2VkOwo+ICt9Cj4gKwo+ICAgLyoKPiAgICAqIFJl
c3RvcmUgdGhlIHZob3N0IGd1ZXN0IHRvIGhvc3Qgbm90aWZpZXIsIGkuZS4sIGRpc2FibGVzIHN2
cSBlZmZlY3QuCj4gICAgKi8KPiBAQCAtMjYyLDcgKzI4MSw5IEBAIHZvaWQgdmhvc3Rfc2hhZG93
X3ZxX3N0b3Aoc3RydWN0IHZob3N0X2RldiAqZGV2LAo+ICAgVmhvc3RTaGFkb3dWaXJ0cXVldWUg
KnZob3N0X3NoYWRvd192cV9uZXcoc3RydWN0IHZob3N0X2RldiAqZGV2LCBpbnQgaWR4KQo+ICAg
ewo+ICAgICAgIGludCB2cV9pZHggPSBkZXYtPnZxX2luZGV4ICsgaWR4Owo+IC0gICAgZ19hdXRv
ZnJlZSBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3ZxID0gZ19uZXcwKFZob3N0U2hhZG93VmlydHF1
ZXVlLCAxKTsKPiArICAgIHVuc2lnbmVkIG51bSA9IHZpcnRpb19xdWV1ZV9nZXRfbnVtKGRldi0+
dmRldiwgdnFfaWR4KTsKPiArICAgIHNpemVfdCByaW5nX3NpemUgPSB2cmluZ19zaXplKG51bSwg
VlJJTkdfREVTQ19BTElHTl9TSVpFKTsKPiArICAgIGdfYXV0b2ZyZWUgVmhvc3RTaGFkb3dWaXJ0
cXVldWUgKnN2cSA9IGdfbWFsbG9jMChzaXplb2YoKnN2cSkgKyByaW5nX3NpemUpOwo+ICAgICAg
IGludCByOwo+ICAgCj4gICAgICAgciA9IGV2ZW50X25vdGlmaWVyX2luaXQoJnN2cS0+a2lja19u
b3RpZmllciwgMCk7Cj4gQEAgLTI3OSw2ICszMDAsNyBAQCBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAq
dmhvc3Rfc2hhZG93X3ZxX25ldyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIGludCBpZHgpCj4gICAg
ICAgICAgIGdvdG8gZXJyX2luaXRfY2FsbF9ub3RpZmllcjsKPiAgICAgICB9Cj4gICAKPiArICAg
IHZyaW5nX2luaXQoJnN2cS0+dnJpbmcsIG51bSwgc3ZxLT5kZXNjcywgVlJJTkdfREVTQ19BTElH
Tl9TSVpFKTsKCgpXZSBoYWQgc29tZSBkaWN1c3Npb24gaW4gdGhlIHBhc3QuIEV4cG9ydGluZyB2
cmluZ19pbml0KCkgaXMgd3JvbmcgYnV0IAp0b28gbGF0ZSB0byBmaXggKGFzc3VtZXMgYSBsZWdh
Y3kgc3BsaXQgbGF5b3V0KS4gTGV0J3Mgbm90IGRlcGVuZCBvbiAKdGhpcyBidWdneSB1QVBJLgoK
VGhhbmtzCgoKPiAgICAgICBzdnEtPnZxID0gdmlydGlvX2dldF9xdWV1ZShkZXYtPnZkZXYsIHZx
X2lkeCk7Cj4gICAgICAgc3ZxLT52ZGV2ID0gZGV2LT52ZGV2Owo+ICAgICAgIGV2ZW50X25vdGlm
aWVyX3NldF9oYW5kbGVyKCZzdnEtPmNhbGxfbm90aWZpZXIsCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

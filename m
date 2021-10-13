Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FEBC433F5
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 03:54:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4709960F11
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 03:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4709960F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D2D04079E;
	Wed, 13 Oct 2021 03:54:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id THGviQSGIOin; Wed, 13 Oct 2021 03:54:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5D76B40748;
	Wed, 13 Oct 2021 03:54:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 321D4C0011;
	Wed, 13 Oct 2021 03:54:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08127C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:54:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DE34D60655
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:54:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AnbgEbT_YI9B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:54:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1617C605A6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634097290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8pp6pJbc/kCViB86CHPdXK7ofeJwJIyHXYz6BBMaDCM=;
 b=AwSkffHTbALcx++x3kuybD/n+lWoymAzzbb24sFN8dShrVq8gJObxpHi1FuDdSAK8Nf6nF
 ESGgnsgUH55PAl6a1dgVi1ZLqlmfi+ade0U1RP1zo2S7A2aklod9IvSP+F+flwQ3FztMrO
 ssz+YPThV0xg4bRRnZLvYETHmMp7V08=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-4kmSQ6YYMOuhUX7N-Gs8Xg-1; Tue, 12 Oct 2021 23:54:48 -0400
X-MC-Unique: 4kmSQ6YYMOuhUX7N-Gs8Xg-1
Received: by mail-pj1-f71.google.com with SMTP id
 ge16-20020a17090b0e1000b001a06598a6e2so992769pjb.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 20:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=8pp6pJbc/kCViB86CHPdXK7ofeJwJIyHXYz6BBMaDCM=;
 b=QspMjOTNtxhIejTpUHx2RkuStJnCtMh5g1Wlf42ARYL9I4/1YuGUn0uTIuR+S0BMBV
 xyeVDklItb1IwvmwuqRL+4pcqBveaog0Cts0SmcNxm/8BahkoFDisRyZe0YNsiWZ1FvL
 teYd9M8hLeLs/1JL2RE48sGYfBX0z8GMh+stCRVOD9vQONcgFDLeF21+yF/Kr1df8sAT
 gwQqLK5IF5ztt/UEkvC09C8OKC7Hd88d7Z4kHpl8dTPOQ4bEA8/qHAEpwSzIcUs0vGcX
 byEFa949nuURSzm2sFzYOuOsZQqWDaGnhFc1pMtpB/k5lkBMiIgxAPIKhs0wuplaJKYM
 l94g==
X-Gm-Message-State: AOAM532MkGBNEP+sAhqVlXxRtSe2BnWx1DMEsA52OYapefbsXXaDiJuW
 SDw1IIy8gcExYSBnL3NEhj5x6JQ/jM5n+MiB/LaoA34yMU/Q4MB9HfzggP9ML4Xb3pUP7OcUgwO
 lKm9qXRI8qkrU+Qx/PxqKGDW+aZXTu5AeVhEc8KZnoQ==
X-Received: by 2002:a17:90b:3797:: with SMTP id
 mz23mr10695571pjb.216.1634097287822; 
 Tue, 12 Oct 2021 20:54:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8frD7nceWkG/wcTi9zXiIJS75uqhIzHEjaaQgFza7nQYVt58ZyYCGcp9+txgUU5eg5JTZ4Q==
X-Received: by 2002:a17:90b:3797:: with SMTP id
 mz23mr10695537pjb.216.1634097287452; 
 Tue, 12 Oct 2021 20:54:47 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p17sm4252142pjg.54.2021.10.12.20.54.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Oct 2021 20:54:47 -0700 (PDT)
Subject: Re: [RFC PATCH v4 12/20] virtio: Add vhost_shadow_vq_get_vring_addr
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20211001070603.307037-1-eperezma@redhat.com>
 <20211001070603.307037-13-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <981f5647-544e-f35e-4b72-06eca733368f@redhat.com>
Date: Wed, 13 Oct 2021 11:54:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211001070603.307037-13-eperezma@redhat.com>
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

CuWcqCAyMDIxLzEwLzEg5LiL5Y2IMzowNSwgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IEl0IHJl
cG9ydHMgdGhlIHNoYWRvdyB2aXJ0cXVldWUgYWRkcmVzcyBmcm9tIHFlbXUgdmlydHVhbCBhZGRy
ZXNzIHNwYWNlCgoKSSB0aGluayBib3RoIHRoZSB0aXRsZSBhbmQgY29tbWl0IGxvZyBuZWVkcyB0
byBtb3JlIHR3ZWFrcy4gTG9va2luZyBhdCAKdGhlIGNvZGVzLCB3aGF0IGlkIGRvZXMgaXMgYWN0
dWFsbHkgaW50cm9kdWNlIHZyaW5nIGludG8gc3ZxLgoKCj4KPiBTaWduZWQtb2ZmLWJ5OiBFdWdl
bmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiAtLS0KPiAgIGh3L3ZpcnRpby92aG9z
dC1zaGFkb3ctdmlydHF1ZXVlLmggfCAgNCArKysKPiAgIGh3L3ZpcnRpby92aG9zdC1zaGFkb3ct
dmlydHF1ZXVlLmMgfCA1MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgIDIgZmls
ZXMgY2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92
aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmggYi9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1
ZS5oCj4gaW5kZXggMjM3Y2ZjZWI5Yy4uMmRmM2QxMTdmNSAxMDA2NDQKPiAtLS0gYS9ody92aXJ0
aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oCj4gKysrIGIvaHcvdmlydGlvL3Zob3N0LXNoYWRv
dy12aXJ0cXVldWUuaAo+IEBAIC0xNiw2ICsxNiwxMCBAQCB0eXBlZGVmIHN0cnVjdCBWaG9zdFNo
YWRvd1ZpcnRxdWV1ZSBWaG9zdFNoYWRvd1ZpcnRxdWV1ZTsKPiAgIAo+ICAgRXZlbnROb3RpZmll
ciAqdmhvc3Rfc3ZxX2dldF9zdnFfY2FsbF9ub3RpZmllcihWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAq
c3ZxKTsKPiAgIHZvaWQgdmhvc3Rfc3ZxX3NldF9ndWVzdF9jYWxsX25vdGlmaWVyKFZob3N0U2hh
ZG93VmlydHF1ZXVlICpzdnEsIGludCBjYWxsX2ZkKTsKPiArdm9pZCB2aG9zdF9zdnFfZ2V0X3Zy
aW5nX2FkZHIoY29uc3QgVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2cSwKPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IHZob3N0X3ZyaW5nX2FkZHIgKmFkZHIpOwo+ICtzaXpl
X3Qgdmhvc3Rfc3ZxX2RyaXZlcl9hcmVhX3NpemUoY29uc3QgVmhvc3RTaGFkb3dWaXJ0cXVldWUg
KnN2cSk7Cj4gK3NpemVfdCB2aG9zdF9zdnFfZGV2aWNlX2FyZWFfc2l6ZShjb25zdCBWaG9zdFNo
YWRvd1ZpcnRxdWV1ZSAqc3ZxKTsKPiAgIAo+ICAgYm9vbCB2aG9zdF9zdnFfc3RhcnQoc3RydWN0
IHZob3N0X2RldiAqZGV2LCB1bnNpZ25lZCBpZHgsCj4gICAgICAgICAgICAgICAgICAgICAgICBW
aG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3ZxKTsKPiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0
LXNoYWRvdy12aXJ0cXVldWUuYyBiL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMK
PiBpbmRleCAzZmUxMjljZjYzLi41YzE4OTlmNmFmIDEwMDY0NAo+IC0tLSBhL2h3L3ZpcnRpby92
aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMKPiArKysgYi9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZp
cnRxdWV1ZS5jCj4gQEAgLTE4LDYgKzE4LDkgQEAKPiAgIAo+ICAgLyogU2hhZG93IHZpcnRxdWV1
ZSB0byByZWxheSBub3RpZmljYXRpb25zICovCj4gICB0eXBlZGVmIHN0cnVjdCBWaG9zdFNoYWRv
d1ZpcnRxdWV1ZSB7Cj4gKyAgICAvKiBTaGFkb3cgdnJpbmcgKi8KPiArICAgIHN0cnVjdCB2cmlu
ZyB2cmluZzsKPiArCj4gICAgICAgLyogU2hhZG93IGtpY2sgbm90aWZpZXIsIHNlbnQgdG8gdmhv
c3QgKi8KPiAgICAgICBFdmVudE5vdGlmaWVyIGtpY2tfbm90aWZpZXI7Cj4gICAgICAgLyogU2hh
ZG93IGNhbGwgbm90aWZpZXIsIHNlbnQgdG8gdmhvc3QgKi8KPiBAQCAtMzgsNiArNDEsOSBAQCB0
eXBlZGVmIHN0cnVjdCBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSB7Cj4gICAKPiAgICAgICAvKiBWaXJ0
aW8gcXVldWUgc2hhZG93aW5nICovCj4gICAgICAgVmlydFF1ZXVlICp2cTsKPiArCj4gKyAgICAv
KiBWaXJ0aW8gZGV2aWNlICovCj4gKyAgICBWaXJ0SU9EZXZpY2UgKnZkZXY7Cj4gICB9IFZob3N0
U2hhZG93VmlydHF1ZXVlOwo+ICAgCj4gICAvKiBGb3J3YXJkIGd1ZXN0IG5vdGlmaWNhdGlvbnMg
Ki8KPiBAQCAtOTMsNiArOTksMzUgQEAgdm9pZCB2aG9zdF9zdnFfc2V0X2d1ZXN0X2NhbGxfbm90
aWZpZXIoVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2cSwgaW50IGNhbGxfZmQpCj4gICAgICAgZXZl
bnRfbm90aWZpZXJfaW5pdF9mZCgmc3ZxLT5ndWVzdF9jYWxsX25vdGlmaWVyLCBjYWxsX2ZkKTsK
PiAgIH0KPiAgIAo+ICsvKgo+ICsgKiBHZXQgdGhlIHNoYWRvdyB2cSB2cmluZyBhZGRyZXNzLgo+
ICsgKiBAc3ZxIFNoYWRvdyB2aXJ0cXVldWUKPiArICogQGFkZHIgRGVzdGluYXRpb24gdG8gc3Rv
cmUgYWRkcmVzcwo+ICsgKi8KPiArdm9pZCB2aG9zdF9zdnFfZ2V0X3ZyaW5nX2FkZHIoY29uc3Qg
Vmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2cSwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc3RydWN0IHZob3N0X3ZyaW5nX2FkZHIgKmFkZHIpCj4gK3sKPiArICAgIGFkZHItPmRlc2Nf
dXNlcl9hZGRyID0gKHVpbnQ2NF90KXN2cS0+dnJpbmcuZGVzYzsKPiArICAgIGFkZHItPmF2YWls
X3VzZXJfYWRkciA9ICh1aW50NjRfdClzdnEtPnZyaW5nLmF2YWlsOwo+ICsgICAgYWRkci0+dXNl
ZF91c2VyX2FkZHIgPSAodWludDY0X3Qpc3ZxLT52cmluZy51c2VkOwo+ICt9Cj4gKwo+ICtzaXpl
X3Qgdmhvc3Rfc3ZxX2RyaXZlcl9hcmVhX3NpemUoY29uc3QgVmhvc3RTaGFkb3dWaXJ0cXVldWUg
KnN2cSkKPiArewo+ICsgICAgdWludDE2X3QgdnFfaWR4ID0gdmlydGlvX2dldF9xdWV1ZV9pbmRl
eChzdnEtPnZxKTsKPiArICAgIHNpemVfdCBkZXNjX3NpemUgPSB2aXJ0aW9fcXVldWVfZ2V0X2Rl
c2Nfc2l6ZShzdnEtPnZkZXYsIHZxX2lkeCk7Cj4gKyAgICBzaXplX3QgYXZhaWxfc2l6ZSA9IHZp
cnRpb19xdWV1ZV9nZXRfYXZhaWxfc2l6ZShzdnEtPnZkZXYsIHZxX2lkeCk7Cj4gKwo+ICsgICAg
cmV0dXJuIFJPVU5EX1VQKGRlc2Nfc2l6ZSArIGF2YWlsX3NpemUsIHFlbXVfcmVhbF9ob3N0X3Bh
Z2Vfc2l6ZSk7CgoKSXMgdGhpcyByb3VuZCB1cCByZXF1aXJlZCBieSB0aGUgc3BlYz8KCgo+ICt9
Cj4gKwo+ICtzaXplX3Qgdmhvc3Rfc3ZxX2RldmljZV9hcmVhX3NpemUoY29uc3QgVmhvc3RTaGFk
b3dWaXJ0cXVldWUgKnN2cSkKPiArewo+ICsgICAgdWludDE2X3QgdnFfaWR4ID0gdmlydGlvX2dl
dF9xdWV1ZV9pbmRleChzdnEtPnZxKTsKPiArICAgIHNpemVfdCB1c2VkX3NpemUgPSB2aXJ0aW9f
cXVldWVfZ2V0X3VzZWRfc2l6ZShzdnEtPnZkZXYsIHZxX2lkeCk7Cj4gKyAgICByZXR1cm4gUk9V
TkRfVVAodXNlZF9zaXplLCBxZW11X3JlYWxfaG9zdF9wYWdlX3NpemUpOwo+ICt9Cj4gKwo+ICAg
LyoKPiAgICAqIFJlc3RvcmUgdGhlIHZob3N0IGd1ZXN0IHRvIGhvc3Qgbm90aWZpZXIsIGkuZS4s
IGRpc2FibGVzIHN2cSBlZmZlY3QuCj4gICAgKi8KPiBAQCAtMTc4LDYgKzIxMywxMCBAQCB2b2lk
IHZob3N0X3N2cV9zdG9wKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgdW5zaWduZWQgaWR4LAo+ICAg
Vmhvc3RTaGFkb3dWaXJ0cXVldWUgKnZob3N0X3N2cV9uZXcoc3RydWN0IHZob3N0X2RldiAqZGV2
LCBpbnQgaWR4KQo+ICAgewo+ICAgICAgIGludCB2cV9pZHggPSBkZXYtPnZxX2luZGV4ICsgaWR4
Owo+ICsgICAgdW5zaWduZWQgbnVtID0gdmlydGlvX3F1ZXVlX2dldF9udW0oZGV2LT52ZGV2LCB2
cV9pZHgpOwo+ICsgICAgc2l6ZV90IGRlc2Nfc2l6ZSA9IHZpcnRpb19xdWV1ZV9nZXRfZGVzY19z
aXplKGRldi0+dmRldiwgdnFfaWR4KTsKPiArICAgIHNpemVfdCBkcml2ZXJfc2l6ZTsKPiArICAg
IHNpemVfdCBkZXZpY2Vfc2l6ZTsKPiAgICAgICBnX2F1dG9mcmVlIFZob3N0U2hhZG93VmlydHF1
ZXVlICpzdnEgPSBnX25ldzAoVmhvc3RTaGFkb3dWaXJ0cXVldWUsIDEpOwo+ICAgICAgIGludCBy
Owo+ICAgCj4gQEAgLTE5Niw2ICsyMzUsMTUgQEAgVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnZob3N0
X3N2cV9uZXcoc3RydWN0IHZob3N0X2RldiAqZGV2LCBpbnQgaWR4KQo+ICAgICAgIH0KPiAgIAo+
ICAgICAgIHN2cS0+dnEgPSB2aXJ0aW9fZ2V0X3F1ZXVlKGRldi0+dmRldiwgdnFfaWR4KTsKPiAr
ICAgIHN2cS0+dmRldiA9IGRldi0+dmRldjsKPiArICAgIGRyaXZlcl9zaXplID0gdmhvc3Rfc3Zx
X2RyaXZlcl9hcmVhX3NpemUoc3ZxKTsKPiArICAgIGRldmljZV9zaXplID0gdmhvc3Rfc3ZxX2Rl
dmljZV9hcmVhX3NpemUoc3ZxKTsKPiArICAgIHN2cS0+dnJpbmcubnVtID0gbnVtOwo+ICsgICAg
c3ZxLT52cmluZy5kZXNjID0gcWVtdV9tZW1hbGlnbihxZW11X3JlYWxfaG9zdF9wYWdlX3NpemUs
IGRyaXZlcl9zaXplKTsKPiArICAgIHN2cS0+dnJpbmcuYXZhaWwgPSAodm9pZCAqKSgoY2hhciAq
KXN2cS0+dnJpbmcuZGVzYyArIGRlc2Nfc2l6ZSk7Cj4gKyAgICBtZW1zZXQoc3ZxLT52cmluZy5k
ZXNjLCAwLCBkcml2ZXJfc2l6ZSk7CgoKQW55IHJlYXNvbiBmb3IgdXNpbmcgdGhlIGNvbnRpZ3Vv
dXMgYXJlYSBmb3IgYm90aCBkZXNjIGFuZCBhdmFpbD8KClRoYW5rcwoKCj4gKyAgICBzdnEtPnZy
aW5nLnVzZWQgPSBxZW11X21lbWFsaWduKHFlbXVfcmVhbF9ob3N0X3BhZ2Vfc2l6ZSwgZGV2aWNl
X3NpemUpOwo+ICsgICAgbWVtc2V0KHN2cS0+dnJpbmcudXNlZCwgMCwgZGV2aWNlX3NpemUpOwo+
ICAgICAgIGV2ZW50X25vdGlmaWVyX3NldF9oYW5kbGVyKCZzdnEtPmNhbGxfbm90aWZpZXIsCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmhvc3Rfc3ZxX2hhbmRsZV9jYWxsKTsK
PiAgICAgICByZXR1cm4gZ19zdGVhbF9wb2ludGVyKCZzdnEpOwo+IEBAIC0yMTUsNSArMjYzLDcg
QEAgdm9pZCB2aG9zdF9zdnFfZnJlZShWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqdnEpCj4gICAgICAg
ZXZlbnRfbm90aWZpZXJfY2xlYW51cCgmdnEtPmtpY2tfbm90aWZpZXIpOwo+ICAgICAgIGV2ZW50
X25vdGlmaWVyX3NldF9oYW5kbGVyKCZ2cS0+Y2FsbF9ub3RpZmllciwgTlVMTCk7Cj4gICAgICAg
ZXZlbnRfbm90aWZpZXJfY2xlYW51cCgmdnEtPmNhbGxfbm90aWZpZXIpOwo+ICsgICAgcWVtdV92
ZnJlZSh2cS0+dnJpbmcuZGVzYyk7Cj4gKyAgICBxZW11X3ZmcmVlKHZxLT52cmluZy51c2VkKTsK
PiAgICAgICBnX2ZyZWUodnEpOwo+ICAgfQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

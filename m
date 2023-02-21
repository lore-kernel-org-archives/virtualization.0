Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D382C61DA3
	for <virtualization@archiver.kernel.org>; Tue, 21 Feb 2023 05:36:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F03CD61095;
	Tue, 21 Feb 2023 05:36:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F03CD61095
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VZ2mC6Bw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DNI3PtgVy4VW; Tue, 21 Feb 2023 05:36:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 688C260B0F;
	Tue, 21 Feb 2023 05:36:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 688C260B0F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C368C0033;
	Tue, 21 Feb 2023 05:36:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8438C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 05:36:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B241B40201
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 05:36:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B241B40201
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VZ2mC6Bw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6X5lTPBIrE8s
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 05:36:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7BCEB400A6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7BCEB400A6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 05:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676957770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MRrLG9S9sWDDOj2GCZKdRPchWuMzUt1uMV7hdUGXxw8=;
 b=VZ2mC6Bw/tYN4ydGwzYswq6q9f28bfxHo4fLX8Lt0Ilfdmle8UY0YldJ+3yi3fz6z+9fvx
 yDkAtErcgzve1UIVeU9f11mec96/5GpVGjFJ84XPf7tIMmfi1E1GSvx+bqh5Vb9yK52O3S
 YBirJCOqmFyIK+oPjWuyhWIwh/Fde9A=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-378-R599wdb8NCmIMYsMN3cLQg-1; Tue, 21 Feb 2023 00:36:08 -0500
X-MC-Unique: R599wdb8NCmIMYsMN3cLQg-1
Received: by mail-pf1-f199.google.com with SMTP id
 t21-20020a056a00139500b005a8534314aeso1677399pfg.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 21:36:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MRrLG9S9sWDDOj2GCZKdRPchWuMzUt1uMV7hdUGXxw8=;
 b=kh5KinJ9vdKtFjGDPGuhK6Ij3wz4IyB1jrta+/KlxzsfOmDCSNNp8BD1cLEonvm9d6
 dOWhzfe9aoRPXQcZgG4OvXyrcs1EwJHin0nwHsIXSa21xdgaFfdMe1T+0jSIkg7vzchp
 7Nl9kLUd3NOSrlXfkY0vKPALwMsK/Hd7FiCS5L+ffWR9hlQ7q/otNTNeMljjHRAtBEzo
 bmWSf6A5mv68ZRMhhrJ2Lz3qUD51Sl2L4p8Xmn7F31hqfuvTO+kDh+nKALVJDVzj18jz
 HU1lj7UAZJzVrOZm+6oYbeKekGXUbjEjTIUTm4T4udq7OMfEtcOjkXUVGpSUUQ6izhT1
 4Izw==
X-Gm-Message-State: AO0yUKXP5g2Fi5sAPxIQ4SGnjf6siZUI8WZo4NunrKG0kQupWPUsyIk7
 dkMPWgGDLN1ZQiy/p0HFeUgM9vGYWLD3SfFY1wHlUfv+NzPxcLY8oqlAGMW4INkG44tZQ4VY/Kt
 UaSaTfqQpIiUaMBpXsGUv6WCxOILPn5udbnOoTzuiEA==
X-Received: by 2002:a17:903:1ca:b0:19b:9a19:76ae with SMTP id
 e10-20020a17090301ca00b0019b9a1976aemr3672712plh.1.1676957767920; 
 Mon, 20 Feb 2023 21:36:07 -0800 (PST)
X-Google-Smtp-Source: AK7set/ND8UocV2wBFriaDaIT5yySPoZU7PBsqhtDrME6CRJ2pDPchMqrvcLjzT59RGbVdCwnIh+Qw==
X-Received: by 2002:a17:903:1ca:b0:19b:9a19:76ae with SMTP id
 e10-20020a17090301ca00b0019b9a1976aemr3672679plh.1.1676957767624; 
 Mon, 20 Feb 2023 21:36:07 -0800 (PST)
Received: from [10.72.12.235] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a170902ea8500b0019c32968271sm2451577plb.11.2023.02.20.21.36.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Feb 2023 21:36:07 -0800 (PST)
Message-ID: <f8487b52-964f-641c-4365-e38b44ea2627@redhat.com>
Date: Tue, 21 Feb 2023 13:36:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 04/13] vdpa: move vhost reset after get vring base
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20230208094253.702672-1-eperezma@redhat.com>
 <20230208094253.702672-5-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230208094253.702672-5-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gautam Dawar <gdawar@xilinx.com>, virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Lei Yang <leiyang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 longpeng2@huawei.com, Shannon Nelson <snelson@pensando.io>,
 Liuxiangdong <liuxiangdong5@huawei.com>
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

CuWcqCAyMDIzLzIvOCAxNzo0MiwgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IFRoZSBmdW5jdGlv
biB2aG9zdC5jOnZob3N0X2Rldl9zdG9wIGNhbGxzIHZob3N0IG9wZXJhdGlvbgo+IHZob3N0X2Rl
dl9zdGFydChmYWxzZSkuIEluIHRoZSBjYXNlIG9mIHZkcGEgaXQgdG90YWxseSByZXNldCBhbmQg
d2lwZXMKPiB0aGUgZGV2aWNlLCBtYWtpbmcgdGhlIGZldGNoaW5nIG9mIHRoZSB2cmluZyBiYXNl
ICh2aXJ0cXVldWUgc3RhdGUpIHRvdGFsbHkKPiB1c2VsZXNzLgo+Cj4gVGhlIGtlcm5lbCBiYWNr
ZW5kIGRvZXMgbm90IHVzZSB2aG9zdF9kZXZfc3RhcnQgdmhvc3Qgb3AgY2FsbGJhY2ssIGJ1dAo+
IHZob3N0LXVzZXIgZG8uIEEgcGF0Y2ggdG8gbWFrZSB2aG9zdF91c2VyX2Rldl9zdGFydCBtb3Jl
IHNpbWlsYXIgdG8gdmRwYQo+IGlzIGRlc2lyYWJsZSwgYnV0IGl0IGNhbiBiZSBhZGRlZCBvbiB0
b3AuCj4KPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNv
bT4KPiAtLS0KPiAgIGluY2x1ZGUvaHcvdmlydGlvL3Zob3N0LWJhY2tlbmQuaCB8ICA0ICsrKysK
PiAgIGh3L3ZpcnRpby92aG9zdC12ZHBhLmMgICAgICAgICAgICB8IDIyICsrKysrKysrKysrKysr
KystLS0tLS0KPiAgIGh3L3ZpcnRpby92aG9zdC5jICAgICAgICAgICAgICAgICB8ICAzICsrKwo+
ICAgMyBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmlydGlvL3Zob3N0LWJhY2tlbmQuaCBiL2luY2x1ZGUv
aHcvdmlydGlvL3Zob3N0LWJhY2tlbmQuaAo+IGluZGV4IGM1YWI0OTA1MWUuLmVjM2ZiYWU1OGQg
MTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QtYmFja2VuZC5oCj4gKysrIGIv
aW5jbHVkZS9ody92aXJ0aW8vdmhvc3QtYmFja2VuZC5oCj4gQEAgLTEzMCw2ICsxMzAsOSBAQCB0
eXBlZGVmIGJvb2wgKCp2aG9zdF9mb3JjZV9pb21tdV9vcCkoc3RydWN0IHZob3N0X2RldiAqZGV2
KTsKPiAgIAo+ICAgdHlwZWRlZiBpbnQgKCp2aG9zdF9zZXRfY29uZmlnX2NhbGxfb3ApKHN0cnVj
dCB2aG9zdF9kZXYgKmRldiwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGludCBmZCk7Cj4gKwo+ICt0eXBlZGVmIHZvaWQgKCp2aG9zdF9yZXNldF9zdGF0dXNfb3Ap
KHN0cnVjdCB2aG9zdF9kZXYgKmRldik7Cj4gKwo+ICAgdHlwZWRlZiBzdHJ1Y3QgVmhvc3RPcHMg
ewo+ICAgICAgIFZob3N0QmFja2VuZFR5cGUgYmFja2VuZF90eXBlOwo+ICAgICAgIHZob3N0X2Jh
Y2tlbmRfaW5pdCB2aG9zdF9iYWNrZW5kX2luaXQ7Cj4gQEAgLTE3Nyw2ICsxODAsNyBAQCB0eXBl
ZGVmIHN0cnVjdCBWaG9zdE9wcyB7Cj4gICAgICAgdmhvc3RfZ2V0X2RldmljZV9pZF9vcCB2aG9z
dF9nZXRfZGV2aWNlX2lkOwo+ICAgICAgIHZob3N0X2ZvcmNlX2lvbW11X29wIHZob3N0X2ZvcmNl
X2lvbW11Owo+ICAgICAgIHZob3N0X3NldF9jb25maWdfY2FsbF9vcCB2aG9zdF9zZXRfY29uZmln
X2NhbGw7Cj4gKyAgICB2aG9zdF9yZXNldF9zdGF0dXNfb3Agdmhvc3RfcmVzZXRfc3RhdHVzOwo+
ICAgfSBWaG9zdE9wczsKPiAgIAo+ICAgaW50IHZob3N0X2JhY2tlbmRfdXBkYXRlX2RldmljZV9p
b3RsYihzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9z
dC12ZHBhLmMgYi9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4gaW5kZXggY2JiZTkyZmZlOC4uMjZl
MzhhNmFhYiAxMDA2NDQKPiAtLS0gYS9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4gKysrIGIvaHcv
dmlydGlvL3Zob3N0LXZkcGEuYwo+IEBAIC0xMTUyLDE0ICsxMTUyLDIzIEBAIHN0YXRpYyBpbnQg
dmhvc3RfdmRwYV9kZXZfc3RhcnQoc3RydWN0IHZob3N0X2RldiAqZGV2LCBib29sIHN0YXJ0ZWQp
Cj4gICAgICAgaWYgKHN0YXJ0ZWQpIHsKPiAgICAgICAgICAgbWVtb3J5X2xpc3RlbmVyX3JlZ2lz
dGVyKCZ2LT5saXN0ZW5lciwgJmFkZHJlc3Nfc3BhY2VfbWVtb3J5KTsKPiAgICAgICAgICAgcmV0
dXJuIHZob3N0X3ZkcGFfYWRkX3N0YXR1cyhkZXYsIFZJUlRJT19DT05GSUdfU19EUklWRVJfT0sp
Owo+IC0gICAgfSBlbHNlIHsKPiAtICAgICAgICB2aG9zdF92ZHBhX3Jlc2V0X2RldmljZShkZXYp
Owo+IC0gICAgICAgIHZob3N0X3ZkcGFfYWRkX3N0YXR1cyhkZXYsIFZJUlRJT19DT05GSUdfU19B
Q0tOT1dMRURHRSB8Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVklSVElP
X0NPTkZJR19TX0RSSVZFUik7Cj4gLSAgICAgICAgbWVtb3J5X2xpc3RlbmVyX3VucmVnaXN0ZXIo
JnYtPmxpc3RlbmVyKTsKPiArICAgIH0KPiAgIAo+IC0gICAgICAgIHJldHVybiAwOwo+ICsgICAg
cmV0dXJuIDA7Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lkIHZob3N0X3ZkcGFfcmVzZXRfc3RhdHVz
KHN0cnVjdCB2aG9zdF9kZXYgKmRldikKPiArewo+ICsgICAgc3RydWN0IHZob3N0X3ZkcGEgKnYg
PSBkZXYtPm9wYXF1ZTsKPiArCj4gKyAgICBpZiAoZGV2LT52cV9pbmRleCArIGRldi0+bnZxcyAh
PSBkZXYtPnZxX2luZGV4X2VuZCkgewo+ICsgICAgICAgIHJldHVybjsKPiAgICAgICB9Cj4gKwo+
ICsgICAgdmhvc3RfdmRwYV9yZXNldF9kZXZpY2UoZGV2KTsKPiArICAgIHZob3N0X3ZkcGFfYWRk
X3N0YXR1cyhkZXYsIFZJUlRJT19DT05GSUdfU19BQ0tOT1dMRURHRSB8Cj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgVklSVElPX0NPTkZJR19TX0RSSVZFUik7Cj4gKyAgICBtZW1v
cnlfbGlzdGVuZXJfdW5yZWdpc3Rlcigmdi0+bGlzdGVuZXIpOwo+ICAgfQo+ICAgCj4gICBzdGF0
aWMgaW50IHZob3N0X3ZkcGFfc2V0X2xvZ19iYXNlKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgdWlu
dDY0X3QgYmFzZSwKPiBAQCAtMTM0Niw0ICsxMzU1LDUgQEAgY29uc3QgVmhvc3RPcHMgdmRwYV9v
cHMgPSB7Cj4gICAgICAgICAgIC52aG9zdF92cV9nZXRfYWRkciA9IHZob3N0X3ZkcGFfdnFfZ2V0
X2FkZHIsCj4gICAgICAgICAgIC52aG9zdF9mb3JjZV9pb21tdSA9IHZob3N0X3ZkcGFfZm9yY2Vf
aW9tbXUsCj4gICAgICAgICAgIC52aG9zdF9zZXRfY29uZmlnX2NhbGwgPSB2aG9zdF92ZHBhX3Nl
dF9jb25maWdfY2FsbCwKPiArICAgICAgICAudmhvc3RfcmVzZXRfc3RhdHVzID0gdmhvc3RfdmRw
YV9yZXNldF9zdGF0dXMsCj4gICB9Owo+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3QuYyBi
L2h3L3ZpcnRpby92aG9zdC5jCj4gaW5kZXggZWI4YzRjMzc4Yy4uYTI2NjM5NjU3NiAxMDA2NDQK
PiAtLS0gYS9ody92aXJ0aW8vdmhvc3QuYwo+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC5jCj4gQEAg
LTIwNDksNiArMjA0OSw5IEBAIHZvaWQgdmhvc3RfZGV2X3N0b3Aoc3RydWN0IHZob3N0X2RldiAq
aGRldiwgVmlydElPRGV2aWNlICp2ZGV2LCBib29sIHZyaW5ncykKPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaGRldi0+dnFzICsgaSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaGRldi0+dnFfaW5kZXggKyBpKTsKPiAgICAgICB9Cj4gKyAgICBpZiAoaGRldi0+dmhv
c3Rfb3BzLT52aG9zdF9yZXNldF9zdGF0dXMpIHsKPiArICAgICAgICBoZGV2LT52aG9zdF9vcHMt
PnZob3N0X3Jlc2V0X3N0YXR1cyhoZGV2KTsKPiArICAgIH0KCgpUaGlzIGxvb2tzIHJhY3ksIGlm
IHdlIGRvbid0IHN1c3BlbmQvcmVzZXQgdGhlIGRldmljZSwgZGV2aWNlIGNhbiBtb3ZlIApsYXN0
X2F2YWlsX2lkeCBldmVuIGFmdGVyIGdldF92cmluZ19iYXNlKCk/CgpJbnN0ZWFkIG9mIGRvaW5n
IHRoaW5ncyBsaWtlIHRoaXMsIHNob3VsZCB3ZSBmYWxsYmFjayB0byAKdmlydGlvX3F1ZXVlX3Jl
c3RvcmVfbGFzdF9hdmFpbF9pZHgoKSBpbiB0aGlzIGNhc2U/CgpUaGFua3MKCgo+ICAgCj4gICAg
ICAgaWYgKHZob3N0X2Rldl9oYXNfaW9tbXUoaGRldikpIHsKPiAgICAgICAgICAgaWYgKGhkZXYt
PnZob3N0X29wcy0+dmhvc3Rfc2V0X2lvdGxiX2NhbGxiYWNrKSB7CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

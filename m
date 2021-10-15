Return-Path: <SRS0=T5WV=PD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE577C4332F
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 08:13:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44E196108B
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 08:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 44E196108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 074856081F;
	Fri, 15 Oct 2021 08:13:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6489SL2PIhk7; Fri, 15 Oct 2021 08:13:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8184960794;
	Fri, 15 Oct 2021 08:13:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D7B9C000F;
	Fri, 15 Oct 2021 08:13:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EE92C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:13:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6ED9F6081F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:13:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GdPj1dc4XzmX
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:13:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 96B6360793
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634285586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JpXqt6yy4VffvCByeQY3zk2PYH1CxDLDUiT+DZV4hbA=;
 b=ShUZ/g4VQzT8zx6c4tGwfFJmsVWoYK6fxaP7qCDjCqR17YbSU3CUCYA5ctK6Lb1CQJz28G
 o7HqCrjfee+Wm4zhnx2oxIhiUN9PP6jhCOaPeNdyESPyFi58WWvv6YgOCgi1xufSus1tgO
 NtPVhs9aoEGd1quxbIj9CgezqnbgmTQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-cNarXvmJN4SS0GKZ1O5VMg-1; Fri, 15 Oct 2021 04:13:05 -0400
X-MC-Unique: cNarXvmJN4SS0GKZ1O5VMg-1
Received: by mail-pj1-f69.google.com with SMTP id
 z23-20020a17090ab11700b001a070e36178so4620399pjq.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 01:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=JpXqt6yy4VffvCByeQY3zk2PYH1CxDLDUiT+DZV4hbA=;
 b=XRVcCjy5zCsj6O3Rcynjh3DrsuuuAI2B4Ec71yQ8b9G6loPpqsaLAuQacrZPW+v2Sk
 wAgK/E+VEkce7nxYcRKQxucOcfb5QDr3WKvrb/gs8V+YZI+FDrwz+jrMzzYxcRoqmsFm
 gHlJwuQ0m68dVOJPAbgpqxDHk6ihlqRafnKZ4nGMoYdMQYQYJEXurJ7DY8lIOy6buSmv
 +4m8eHGmtAw348kahOPAQIrR1HhVADnMlqf0CntHPVpatyMnBs4n585/E9+ePzdSuDZC
 mC1erQeTY25oEZihAFm8GGGoFOGwJeGnEHmngrF4qcp79+ofgJaWoLITyqxrxbfHe5Sp
 B09A==
X-Gm-Message-State: AOAM531Us+bIbKDKzJVrqkIg8arDQ85abQB0NY7rC0Ug0k1hkO4I+seL
 sEhl2HX5mWS55hYaGcmQs/P5oGBP+wvrak7jxhTJ4Xv7CLlTNj5hpnkU/G5Lc4V71O2WeFs9sZr
 ECfQOmRDzX7lVNbLRD38knM1DcN43twZG2a7EnpY+qg==
X-Received: by 2002:a62:7b87:0:b0:44d:3e28:a2ac with SMTP id
 w129-20020a627b87000000b0044d3e28a2acmr10432138pfc.67.1634285583840; 
 Fri, 15 Oct 2021 01:13:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOFMK1LxFzX8lcegJk+BmktufvTyX00IK89ssLDwRbtNNEUhNeoYGuPRnCQbVQfUOyGi3Sfw==
X-Received: by 2002:a62:7b87:0:b0:44d:3e28:a2ac with SMTP id
 w129-20020a627b87000000b0044d3e28a2acmr10432101pfc.67.1634285583448; 
 Fri, 15 Oct 2021 01:13:03 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id on17sm11425773pjb.47.2021.10.15.01.13.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Oct 2021 01:13:03 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] vdpa: Check for iova range at mappings changes
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20211014141236.923287-1-eperezma@redhat.com>
 <20211014141236.923287-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <83bb3fe3-10ff-2a8d-3140-e365a44bdac8@redhat.com>
Date: Fri, 15 Oct 2021 16:12:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211014141236.923287-4-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>
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

CuWcqCAyMDIxLzEwLzE0IOS4i+WNiDEwOjEyLCBFdWdlbmlvIFDDqXJleiDlhpnpgZM6Cj4gQ2hl
Y2sgdmRwYSBkZXZpY2UgcmFuZ2UgYmVmb3JlIHVwZGF0aW5nIG1lbW9yeSByZWdpb25zIHNvIHdl
IGRvbid0IGFkZAo+IGFueSBvdXRzaWRlIG9mIGl0LCBhbmQgcmVwb3J0IHRoZSBpbnZhbGlkIGNo
YW5nZSBpZiBhbnkuCj4KPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFA
cmVkaGF0LmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4K
Cgo+IC0tLQo+ICAgaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QtdmRwYS5oIHwgIDIgKysKPiAgIGh3
L3ZpcnRpby92aG9zdC12ZHBhLmMgICAgICAgICB8IDYyICsrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0KPiAgIGh3L3ZpcnRpby90cmFjZS1ldmVudHMgICAgICAgICB8ICAxICsKPiAg
IDMgZmlsZXMgY2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pCj4KPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QtdmRwYS5oIGIvaW5jbHVkZS9ody92
aXJ0aW8vdmhvc3QtdmRwYS5oCj4gaW5kZXggYTg5NjNkYTJkOS4uYzI4OGNmN2VjYiAxMDA2NDQK
PiAtLS0gYS9pbmNsdWRlL2h3L3ZpcnRpby92aG9zdC12ZHBhLmgKPiArKysgYi9pbmNsdWRlL2h3
L3ZpcnRpby92aG9zdC12ZHBhLmgKPiBAQCAtMTMsNiArMTMsNyBAQAo+ICAgI2RlZmluZSBIV19W
SVJUSU9fVkhPU1RfVkRQQV9ICj4gICAKPiAgICNpbmNsdWRlICJody92aXJ0aW8vdmlydGlvLmgi
Cj4gKyNpbmNsdWRlICJzdGFuZGFyZC1oZWFkZXJzL2xpbnV4L3Zob3N0X3R5cGVzLmgiCj4gICAK
PiAgIHR5cGVkZWYgc3RydWN0IFZob3N0VkRQQUhvc3ROb3RpZmllciB7Cj4gICAgICAgTWVtb3J5
UmVnaW9uIG1yOwo+IEBAIC0yNCw2ICsyNSw3IEBAIHR5cGVkZWYgc3RydWN0IHZob3N0X3ZkcGEg
ewo+ICAgICAgIHVpbnQzMl90IG1zZ190eXBlOwo+ICAgICAgIGJvb2wgaW90bGJfYmF0Y2hfYmVn
aW5fc2VudDsKPiAgICAgICBNZW1vcnlMaXN0ZW5lciBsaXN0ZW5lcjsKPiArICAgIHN0cnVjdCB2
aG9zdF92ZHBhX2lvdmFfcmFuZ2UgaW92YV9yYW5nZTsKPiAgICAgICBzdHJ1Y3Qgdmhvc3RfZGV2
ICpkZXY7Cj4gICAgICAgVmhvc3RWRFBBSG9zdE5vdGlmaWVyIG5vdGlmaWVyW1ZJUlRJT19RVUVV
RV9NQVhdOwo+ICAgfSBWaG9zdFZEUEE7Cj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9zdC12
ZHBhLmMgYi9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4gaW5kZXggYmU3YzYzYjRiYS4uNzY5MWU5
MDRhYyAxMDA2NDQKPiAtLS0gYS9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4gKysrIGIvaHcvdmly
dGlvL3Zob3N0LXZkcGEuYwo+IEBAIC0zNywyMCArMzcsMzQgQEAgc3RhdGljIEludDEyOCB2aG9z
dF92ZHBhX3NlY3Rpb25fZW5kKGNvbnN0IE1lbW9yeVJlZ2lvblNlY3Rpb24gKnNlY3Rpb24pCj4g
ICAgICAgcmV0dXJuIGxsZW5kOwo+ICAgfQo+ICAgCj4gLXN0YXRpYyBib29sIHZob3N0X3ZkcGFf
bGlzdGVuZXJfc2tpcHBlZF9zZWN0aW9uKE1lbW9yeVJlZ2lvblNlY3Rpb24gKnNlY3Rpb24pCj4g
LXsKPiAtICAgIHJldHVybiAoIW1lbW9yeV9yZWdpb25faXNfcmFtKHNlY3Rpb24tPm1yKSAmJgo+
IC0gICAgICAgICAgICAhbWVtb3J5X3JlZ2lvbl9pc19pb21tdShzZWN0aW9uLT5tcikpIHx8Cj4g
LSAgICAgICAgICAgIG1lbW9yeV9yZWdpb25faXNfcHJvdGVjdGVkKHNlY3Rpb24tPm1yKSB8fAo+
IC0gICAgICAgICAgIC8qIHZob3N0LXZEUEEgZG9lc24ndCBhbGxvdyBNTUlPIHRvIGJlIG1hcHBl
ZCAgKi8KPiAtICAgICAgICAgICAgbWVtb3J5X3JlZ2lvbl9pc19yYW1fZGV2aWNlKHNlY3Rpb24t
Pm1yKSB8fAo+IC0gICAgICAgICAgIC8qCj4gLSAgICAgICAgICAgICogU2l6aW5nIGFuIGVuYWJs
ZWQgNjQtYml0IEJBUiBjYW4gY2F1c2Ugc3B1cmlvdXMgbWFwcGluZ3MgdG8KPiAtICAgICAgICAg
ICAgKiBhZGRyZXNzZXMgaW4gdGhlIHVwcGVyIHBhcnQgb2YgdGhlIDY0LWJpdCBhZGRyZXNzIHNw
YWNlLiAgVGhlc2UKPiAtICAgICAgICAgICAgKiBhcmUgbmV2ZXIgYWNjZXNzZWQgYnkgdGhlIENQ
VSBhbmQgYmV5b25kIHRoZSBhZGRyZXNzIHdpZHRoIG9mCj4gLSAgICAgICAgICAgICogc29tZSBJ
T01NVSBoYXJkd2FyZS4gIFRPRE86IFZEUEEgc2hvdWxkIHRlbGwgdXMgdGhlIElPTU1VIHdpZHRo
Lgo+IC0gICAgICAgICAgICAqLwo+IC0gICAgICAgICAgIHNlY3Rpb24tPm9mZnNldF93aXRoaW5f
YWRkcmVzc19zcGFjZSAmICgxVUxMIDw8IDYzKTsKPiArc3RhdGljIGJvb2wgdmhvc3RfdmRwYV9s
aXN0ZW5lcl9za2lwcGVkX3NlY3Rpb24oTWVtb3J5UmVnaW9uU2VjdGlvbiAqc2VjdGlvbiwKPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3Qg
aW92YV9taW4sCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHVpbnQ2NF90IGlvdmFfbWF4KQo+ICt7Cj4gKyAgICBJbnQxMjggbGxlbmQ7Cj4gKwo+ICsg
ICAgaWYgKCghbWVtb3J5X3JlZ2lvbl9pc19yYW0oc2VjdGlvbi0+bXIpICYmCj4gKyAgICAgICAg
ICFtZW1vcnlfcmVnaW9uX2lzX2lvbW11KHNlY3Rpb24tPm1yKSkgfHwKPiArICAgICAgICBtZW1v
cnlfcmVnaW9uX2lzX3Byb3RlY3RlZChzZWN0aW9uLT5tcikgfHwKPiArICAgICAgICAvKiB2aG9z
dC12RFBBIGRvZXNuJ3QgYWxsb3cgTU1JTyB0byBiZSBtYXBwZWQgICovCj4gKyAgICAgICAgbWVt
b3J5X3JlZ2lvbl9pc19yYW1fZGV2aWNlKHNlY3Rpb24tPm1yKSkgewo+ICsgICAgICAgIHJldHVy
biB0cnVlOwo+ICsgICAgfQo+ICsKPiArICAgIGlmIChzZWN0aW9uLT5vZmZzZXRfd2l0aGluX2Fk
ZHJlc3Nfc3BhY2UgPCBpb3ZhX21pbikgewo+ICsgICAgICAgIGVycm9yX3JlcG9ydCgiUkFNIHNl
Y3Rpb24gb3V0IG9mIGRldmljZSByYW5nZSAobWluPSVsdSwgYWRkcj0lbHUpIiwKPiArICAgICAg
ICAgICAgICAgICAgICAgaW92YV9taW4sIHNlY3Rpb24tPm9mZnNldF93aXRoaW5fYWRkcmVzc19z
cGFjZSk7Cj4gKyAgICAgICAgcmV0dXJuIHRydWU7Cj4gKyAgICB9Cj4gKwo+ICsgICAgbGxlbmQg
PSB2aG9zdF92ZHBhX3NlY3Rpb25fZW5kKHNlY3Rpb24pOwo+ICsgICAgaWYgKGludDEyOF9ndChs
bGVuZCwgaW50MTI4X21ha2U2NChpb3ZhX21heCkpKSB7Cj4gKyAgICAgICAgZXJyb3JfcmVwb3J0
KCJSQU0gc2VjdGlvbiBvdXQgb2YgZGV2aWNlIHJhbmdlIChtYXg9JWx1LCBlbmQgYWRkcj0lbHUp
IiwKPiArICAgICAgICAgICAgICAgICAgICAgaW92YV9tYXgsIGludDEyOF9nZXQ2NChsbGVuZCkp
Owo+ICsgICAgICAgIHJldHVybiB0cnVlOwo+ICsgICAgfQo+ICsKPiArICAgIHJldHVybiBmYWxz
ZTsKPiAgIH0KPiAgIAo+ICAgc3RhdGljIGludCB2aG9zdF92ZHBhX2RtYV9tYXAoc3RydWN0IHZo
b3N0X3ZkcGEgKnYsIGh3YWRkciBpb3ZhLCBod2FkZHIgc2l6ZSwKPiBAQCAtMTYyLDcgKzE3Niw4
IEBAIHN0YXRpYyB2b2lkIHZob3N0X3ZkcGFfbGlzdGVuZXJfcmVnaW9uX2FkZChNZW1vcnlMaXN0
ZW5lciAqbGlzdGVuZXIsCj4gICAgICAgdm9pZCAqdmFkZHI7Cj4gICAgICAgaW50IHJldDsKPiAg
IAo+IC0gICAgaWYgKHZob3N0X3ZkcGFfbGlzdGVuZXJfc2tpcHBlZF9zZWN0aW9uKHNlY3Rpb24p
KSB7Cj4gKyAgICBpZiAodmhvc3RfdmRwYV9saXN0ZW5lcl9za2lwcGVkX3NlY3Rpb24oc2VjdGlv
biwgdi0+aW92YV9yYW5nZS5maXJzdCwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB2LT5pb3ZhX3JhbmdlLmxhc3QpKSB7Cj4gICAgICAgICAgIHJldHVybjsK
PiAgICAgICB9Cj4gICAKPiBAQCAtMjIwLDcgKzIzNSw4IEBAIHN0YXRpYyB2b2lkIHZob3N0X3Zk
cGFfbGlzdGVuZXJfcmVnaW9uX2RlbChNZW1vcnlMaXN0ZW5lciAqbGlzdGVuZXIsCj4gICAgICAg
SW50MTI4IGxsZW5kLCBsbHNpemU7Cj4gICAgICAgaW50IHJldDsKPiAgIAo+IC0gICAgaWYgKHZo
b3N0X3ZkcGFfbGlzdGVuZXJfc2tpcHBlZF9zZWN0aW9uKHNlY3Rpb24pKSB7Cj4gKyAgICBpZiAo
dmhvc3RfdmRwYV9saXN0ZW5lcl9za2lwcGVkX3NlY3Rpb24oc2VjdGlvbiwgdi0+aW92YV9yYW5n
ZS5maXJzdCwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2
LT5pb3ZhX3JhbmdlLmxhc3QpKSB7Cj4gICAgICAgICAgIHJldHVybjsKPiAgICAgICB9Cj4gICAK
PiBAQCAtMjg4LDYgKzMwNCwxOSBAQCBzdGF0aWMgdm9pZCB2aG9zdF92ZHBhX2FkZF9zdGF0dXMo
c3RydWN0IHZob3N0X2RldiAqZGV2LCB1aW50OF90IHN0YXR1cykKPiAgICAgICB2aG9zdF92ZHBh
X2NhbGwoZGV2LCBWSE9TVF9WRFBBX1NFVF9TVEFUVVMsICZzKTsKPiAgIH0KPiAgIAo+ICtzdGF0
aWMgdm9pZCB2aG9zdF92ZHBhX2dldF9pb3ZhX3JhbmdlKHN0cnVjdCB2aG9zdF92ZHBhICp2KQo+
ICt7Cj4gKyAgICBpbnQgcmV0ID0gdmhvc3RfdmRwYV9jYWxsKHYtPmRldiwgVkhPU1RfVkRQQV9H
RVRfSU9WQV9SQU5HRSwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnYtPmlvdmFf
cmFuZ2UpOwo+ICsgICAgaWYgKHJldCAhPSAwKSB7Cj4gKyAgICAgICAgdi0+aW92YV9yYW5nZS5m
aXJzdCA9IDA7Cj4gKyAgICAgICAgdi0+aW92YV9yYW5nZS5sYXN0ID0gVUlOVDY0X01BWDsKPiAr
ICAgIH0KPiArCj4gKyAgICB0cmFjZV92aG9zdF92ZHBhX2dldF9pb3ZhX3JhbmdlKHYtPmRldiwg
di0+aW92YV9yYW5nZS5maXJzdCwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdi0+aW92YV9yYW5nZS5sYXN0KTsKPiArfQo+ICsKPiAgIHN0YXRpYyBpbnQgdmhvc3RfdmRw
YV9pbml0KHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgdm9pZCAqb3BhcXVlLCBFcnJvciAqKmVycnAp
Cj4gICB7Cj4gICAgICAgc3RydWN0IHZob3N0X3ZkcGEgKnY7Cj4gQEAgLTMwMCw2ICszMjksNyBA
QCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfaW5pdChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIHZvaWQg
Km9wYXF1ZSwgRXJyb3IgKiplcnJwKQo+ICAgICAgIHYtPmxpc3RlbmVyID0gdmhvc3RfdmRwYV9t
ZW1vcnlfbGlzdGVuZXI7Cj4gICAgICAgdi0+bXNnX3R5cGUgPSBWSE9TVF9JT1RMQl9NU0dfVjI7
Cj4gICAKPiArICAgIHZob3N0X3ZkcGFfZ2V0X2lvdmFfcmFuZ2Uodik7Cj4gICAgICAgdmhvc3Rf
dmRwYV9hZGRfc3RhdHVzKGRldiwgVklSVElPX0NPTkZJR19TX0FDS05PV0xFREdFIHwKPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fQ09ORklHX1NfRFJJVkVSKTsKPiAg
IAo+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdHJhY2UtZXZlbnRzIGIvaHcvdmlydGlvL3RyYWNl
LWV2ZW50cwo+IGluZGV4IDhlZDE5ZTlkMGMuLjY1MGU1MjFlMzUgMTAwNjQ0Cj4gLS0tIGEvaHcv
dmlydGlvL3RyYWNlLWV2ZW50cwo+ICsrKyBiL2h3L3ZpcnRpby90cmFjZS1ldmVudHMKPiBAQCAt
NTIsNiArNTIsNyBAQCB2aG9zdF92ZHBhX3NldF92cmluZ19jYWxsKHZvaWQgKmRldiwgdW5zaWdu
ZWQgaW50IGluZGV4LCBpbnQgZmQpICJkZXY6ICVwIGluZGV4Ogo+ICAgdmhvc3RfdmRwYV9nZXRf
ZmVhdHVyZXModm9pZCAqZGV2LCB1aW50NjRfdCBmZWF0dXJlcykgImRldjogJXAgZmVhdHVyZXM6
IDB4JSJQUkl4NjQKPiAgIHZob3N0X3ZkcGFfc2V0X293bmVyKHZvaWQgKmRldikgImRldjogJXAi
Cj4gICB2aG9zdF92ZHBhX3ZxX2dldF9hZGRyKHZvaWQgKmRldiwgdm9pZCAqdnEsIHVpbnQ2NF90
IGRlc2NfdXNlcl9hZGRyLCB1aW50NjRfdCBhdmFpbF91c2VyX2FkZHIsIHVpbnQ2NF90IHVzZWRf
dXNlcl9hZGRyKSAiZGV2OiAlcCB2cTogJXAgZGVzY191c2VyX2FkZHI6IDB4JSJQUkl4NjQiIGF2
YWlsX3VzZXJfYWRkcjogMHglIlBSSXg2NCIgdXNlZF91c2VyX2FkZHI6IDB4JSJQUkl4NjQKPiAr
dmhvc3RfdmRwYV9nZXRfaW92YV9yYW5nZSh2b2lkICpkZXYsIHVpbnQ2NF90IGZpcnN0LCB1aW50
NjRfdCBsYXN0KSAiZGV2OiAlcCBmaXJzdDogMHglIlBSSXg2NCIgbGFzdDogMHglIlBSSXg2NAo+
ICAgCj4gICAjIHZpcnRpby5jCj4gICB2aXJ0cXVldWVfYWxsb2NfZWxlbWVudCh2b2lkICplbGVt
LCBzaXplX3Qgc3osIHVuc2lnbmVkIGluX251bSwgdW5zaWduZWQgb3V0X251bSkgImVsZW0gJXAg
c2l6ZSAlemQgaW5fbnVtICV1IG91dF9udW0gJXUiCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

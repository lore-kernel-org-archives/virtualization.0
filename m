Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA23C433F5
	for <virtualization@archiver.kernel.org>; Fri,  7 Jan 2022 05:09:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C624B42481;
	Fri,  7 Jan 2022 05:09:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lkEoTBhhTljN; Fri,  7 Jan 2022 05:09:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CF4704014E;
	Fri,  7 Jan 2022 05:09:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0DC6C0030;
	Fri,  7 Jan 2022 05:09:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 975C8C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:09:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6A6226FC5C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:09:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 014P78OEwV3K
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:09:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 170776FC45
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641532145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SW1Fv5Vv5Awxcw6drWyE//XF7gKaa85/kku+XOJfyxE=;
 b=YBRUzonbgFzhZOHCpVE4rSCBz+q1+zw1VyW7z5TZI0qmfniZfW2wHBfAul6KL5oyuoKwy+
 Kc3LlTYRQ68OilEx1bgVmZLpy5HDN7ll1NTlsQo+rkk33a97Qv0KmbLLfqfd91ePSBUkG0
 mfu3ee6kWAUvKEBMfHqcfxeaLPIUu34=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-ZZd3DwWLNgGTFxKSiNRWUQ-1; Fri, 07 Jan 2022 00:09:04 -0500
X-MC-Unique: ZZd3DwWLNgGTFxKSiNRWUQ-1
Received: by mail-pg1-f199.google.com with SMTP id
 k1-20020a63d841000000b003417384b156so3146434pgj.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jan 2022 21:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=SW1Fv5Vv5Awxcw6drWyE//XF7gKaa85/kku+XOJfyxE=;
 b=l1o7Lt/to8WmlcXngIf06BvP+Vt4tbHZFy2m+TpY1Wbv4UtHbQ8eLrECCVQHB09M3+
 c0Tkp/4dm18Eueqo9D3FfLgzowz+WDJoqPcLgWILJK03wEjxU+NrqfRUFIVRWjAZSdJ+
 NvJI8sZ8teM5gVSmYa0y6ojMizMHoRkPND54N8LSAPDYtAxz6poT3XjcdVupSKp90Xbh
 SjIkY8WutHEpmeXYQUDzdrerGfQpaploiy1K7BBNbzyT0AQYPqET45EHnxMVxN/lPIBB
 Xl2bGNHNXqNO/4iJtvd/crmaJpvqB1A7c7oFOr6VYfOowxP3SCd/UOO22Bk4dLWBCRzI
 dLsg==
X-Gm-Message-State: AOAM531K65U9paUkZQQ/6XSFg7APaHIcFYyXMEHt0xx4Pcms3Zd7YkyQ
 1wvW6Aok92j5dmKlNith65oMItPNnDaLbfL6cMlb6UjgF4AxLcOIOyDsPRbICFm8cQQU10vVuNM
 dkfZsN28d8ZmA8WYPfehxmZde2hXFwDQ9EV0HUKky+w==
X-Received: by 2002:a17:902:d489:b0:149:8018:e9dc with SMTP id
 c9-20020a170902d48900b001498018e9dcmr50099508plg.121.1641532143501; 
 Thu, 06 Jan 2022 21:09:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynZQP0cj+W5A72MjLnAkumf2ktdqpcSUBoqKp1Jv+ZB/sZnKa3iFn5DrJ1oBZMg4Zzuvls9w==
X-Received: by 2002:a17:902:d489:b0:149:8018:e9dc with SMTP id
 c9-20020a170902d48900b001498018e9dcmr50099488plg.121.1641532143204; 
 Thu, 06 Jan 2022 21:09:03 -0800 (PST)
Received: from [10.72.13.245] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p10sm4108110pfw.69.2022.01.06.21.08.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jan 2022 21:09:02 -0800 (PST)
Message-ID: <586d5d2a-e57c-117e-81d9-8b1366236002@redhat.com>
Date: Fri, 7 Jan 2022 13:08:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v7 03/14] vdpa: Sync calls set/get config/status with
 cf_mutex
To: Si-Wei Liu <si-wei.liu@oracle.com>, Eli Cohen <elic@nvidia.com>,
 mst@redhat.com, virtualization@lists.linux-foundation.org
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-4-elic@nvidia.com>
 <e6218f34-a7e6-9bc5-8de7-7690dec9aa01@oracle.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <e6218f34-a7e6-9bc5-8de7-7690dec9aa01@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: lvivier@redhat.com, eperezma@redhat.com
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

CuWcqCAyMDIyLzEvNyDkuIrljYg4OjMzLCBTaS1XZWkgTGl1IOWGmemBkzoKPgo+Cj4gT24gMS81
LzIwMjIgMzo0NiBBTSwgRWxpIENvaGVuIHdyb3RlOgo+PiBBZGQgd3JhcHBlcnMgdG8gZ2V0L3Nl
dCBzdGF0dXMgYW5kIHByb3RlY3QgdGhlc2Ugb3BlcmF0aW9ucyB3aXRoCj4+IGNmX211dGV4IHRv
IHNlcmlhbGl6ZSB0aGVzZSBvcGVyYXRpb25zIHdpdGggcmVzcGVjdCB0byBnZXQvc2V0IGNvbmZp
Zwo+PiBvcGVyYXRpb25zLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZp
ZGlhLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvdmRwYS92ZHBhLmPCoMKgwqDCoMKgwqDCoMKg
wqAgfCAxOSArKysrKysrKysrKysrKysrKysrCj4+IMKgIGRyaXZlcnMvdmhvc3QvdmRwYS5jwqDC
oMKgwqDCoMKgwqDCoCB8wqAgNyArKystLS0tCj4+IMKgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb192
ZHBhLmMgfMKgIDMgKy0tCj4+IMKgIGluY2x1ZGUvbGludXgvdmRwYS5owqDCoMKgwqDCoMKgwqDC
oCB8wqAgMyArKysKPj4gwqAgNCBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCA2IGRl
bGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGEuYyBiL2RyaXZl
cnMvdmRwYS92ZHBhLmMKPj4gaW5kZXggNDJkNzFkNjBkNWRjLi41MTM0YzgzYzRhMjIgMTAwNjQ0
Cj4+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhLmMKPj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGEu
Ywo+PiBAQCAtMjEsNiArMjEsMjUgQEAgc3RhdGljIExJU1RfSEVBRChtZGV2X2hlYWQpOwo+PiDC
oCBzdGF0aWMgREVGSU5FX01VVEVYKHZkcGFfZGV2X211dGV4KTsKPj4gwqAgc3RhdGljIERFRklO
RV9JREEodmRwYV9pbmRleF9pZGEpOwo+PiDCoCArdTggdmRwYV9nZXRfc3RhdHVzKHN0cnVjdCB2
ZHBhX2RldmljZSAqdmRldikKPj4gK3sKPj4gK8KgwqDCoCB1OCBzdGF0dXM7Cj4+ICsKPj4gK8Kg
wqDCoCBtdXRleF9sb2NrKCZ2ZGV2LT5jZl9tdXRleCk7Cj4+ICvCoMKgwqAgc3RhdHVzID0gdmRl
di0+Y29uZmlnLT5nZXRfc3RhdHVzKHZkZXYpOwo+PiArwqDCoMKgIG11dGV4X3VubG9jaygmdmRl
di0+Y2ZfbXV0ZXgpOwo+PiArwqDCoMKgIHJldHVybiBzdGF0dXM7Cj4+ICt9Cj4+ICtFWFBPUlRf
U1lNQk9MKHZkcGFfZ2V0X3N0YXR1cyk7Cj4+ICsKPj4gK3ZvaWQgdmRwYV9zZXRfc3RhdHVzKHN0
cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTggc3RhdHVzKQo+PiArewo+PiArwqDCoMKgIG11dGV4
X2xvY2soJnZkZXYtPmNmX211dGV4KTsKPj4gK8KgwqDCoCB2ZGV2LT5jb25maWctPnNldF9zdGF0
dXModmRldiwgc3RhdHVzKTsKPj4gK8KgwqDCoCBtdXRleF91bmxvY2soJnZkZXYtPmNmX211dGV4
KTsKPj4gK30KPj4gK0VYUE9SVF9TWU1CT0wodmRwYV9zZXRfc3RhdHVzKTsKPj4gKwo+PiDCoCBz
dGF0aWMgc3RydWN0IGdlbmxfZmFtaWx5IHZkcGFfbmxfZmFtaWx5Owo+PiDCoCDCoCBzdGF0aWMg
aW50IHZkcGFfZGV2X3Byb2JlKHN0cnVjdCBkZXZpY2UgKmQpCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+IGluZGV4IGViYWEzNzNl
OWI4Mi4uZDlkNDk5NDY1ZTJlIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+
PiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+PiBAQCAtMTQyLDEwICsxNDIsOSBAQCBzdGF0
aWMgbG9uZyB2aG9zdF92ZHBhX2dldF9kZXZpY2VfaWQoc3RydWN0IAo+PiB2aG9zdF92ZHBhICp2
LCB1OCBfX3VzZXIgKmFyZ3ApCj4+IMKgIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfZ2V0X3N0YXR1
cyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTggX191c2VyIAo+PiAqc3RhdHVzcCkKPj4gwqAgewo+
PiDCoMKgwqDCoMKgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4+IC3CoMKg
wqAgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRwYS0+Y29uZmlnOwo+PiDC
oMKgwqDCoMKgIHU4IHN0YXR1czsKPj4gwqAgLcKgwqDCoCBzdGF0dXMgPSBvcHMtPmdldF9zdGF0
dXModmRwYSk7Cj4+ICvCoMKgwqAgc3RhdHVzID0gdmRwYV9nZXRfc3RhdHVzKHZkcGEpOwo+IE5v
dCBzdXJlIHdoeSB3ZSBuZWVkIHRvIHRha2UgY2ZfbXV0ZXggaGVyZS4gQXBwZWFycyB0byBtZSBv
bmx5IHNldHRlcnMgCj4gKHNldF9zdGF0dXMgYW5kIHJlc2V0KSBuZWVkIHRvIHRha2UgdGhlIGxv
Y2sgaW4gdGhpcyBmdW5jdGlvbi4KCgpZb3UgbWF5IGJlIHJpZ2h0IGJ1dCBpdCBkb2Vzbid0IGhh
cm0gYW5kIGl0IGlzIGd1YXJhbnRlZWQgdG8gYmUgY29ycmVjdCAKaWYgd2UgcHJvdGVjdCBpdCB3
aXRoIG11dGV4IGhlcmUuCgpUaGFua3MKCgo+Cj4+IMKgIMKgwqDCoMKgwqAgaWYgKGNvcHlfdG9f
dXNlcihzdGF0dXNwLCAmc3RhdHVzLCBzaXplb2Yoc3RhdHVzKSkpCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gLUVGQVVMVDsKPj4gQEAgLTE2NCw3ICsxNjMsNyBAQCBzdGF0aWMgbG9uZyB2
aG9zdF92ZHBhX3NldF9zdGF0dXMoc3RydWN0IAo+PiB2aG9zdF92ZHBhICp2LCB1OCBfX3VzZXIg
KnN0YXR1c3ApCj4+IMKgwqDCoMKgwqAgaWYgKGNvcHlfZnJvbV91c2VyKCZzdGF0dXMsIHN0YXR1
c3AsIHNpemVvZihzdGF0dXMpKSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUZBVUxU
Owo+PiDCoCAtwqDCoMKgIHN0YXR1c19vbGQgPSBvcHMtPmdldF9zdGF0dXModmRwYSk7Cj4+ICvC
oMKgwqAgc3RhdHVzX29sZCA9IHZkcGFfZ2V0X3N0YXR1cyh2ZHBhKTsKPiBEaXR0by4KPgo+PiDC
oCDCoMKgwqDCoMKgIC8qCj4+IMKgwqDCoMKgwqDCoCAqIFVzZXJzcGFjZSBzaG91bGRuJ3QgcmVt
b3ZlIHN0YXR1cyBiaXRzIHVubGVzcyByZXNldCB0aGUKPj4gQEAgLTE4Miw3ICsxODEsNyBAQCBz
dGF0aWMgbG9uZyB2aG9zdF92ZHBhX3NldF9zdGF0dXMoc3RydWN0IAo+PiB2aG9zdF92ZHBhICp2
LCB1OCBfX3VzZXIgKnN0YXR1c3ApCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+PiDCoMKgwqDCoMKgIH0gZWxz
ZQo+PiAtwqDCoMKgwqDCoMKgwqAgb3BzLT5zZXRfc3RhdHVzKHZkcGEsIHN0YXR1cyk7Cj4+ICvC
oMKgwqDCoMKgwqDCoCB2ZHBhX3NldF9zdGF0dXModmRwYSwgc3RhdHVzKTsKPiBUaGUgcmVzZXQo
KSBjYWxsIGluIHRoZSBpZiBicmFuY2ggYWJvdmUgbmVlZHMgdG8gdGFrZSB0aGUgY2ZfbXV0ZXgs
IAo+IHRoZSBzYW1lIHdheSBhcyB0aGF0IGZvciBzZXRfc3RhdHVzKCkuIFRoZSByZXNldCgpIGlz
IGVmZmVjdGl2ZWx5IAo+IHNldF9zdGF0dXModmRwYSwgMCkuCj4KPiBUaGFua3MsCj4gLVNpd2Vp
Cj4KPj4gwqAgwqDCoMKgwqDCoCBpZiAoKHN0YXR1cyAmIFZJUlRJT19DT05GSUdfU19EUklWRVJf
T0spICYmICEoc3RhdHVzX29sZCAmIAo+PiBWSVJUSU9fQ09ORklHX1NfRFJJVkVSX09LKSkKPj4g
wqDCoMKgwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBudnFzOyBpKyspCj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlv
X3ZkcGEuYwo+PiBpbmRleCBhODRiMDRiYTMxOTUuLjc2NTA0NTU5YmMyNSAxMDA2NDQKPj4gLS0t
IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+PiArKysgYi9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fdmRwYS5jCj4+IEBAIC05MSw5ICs5MSw4IEBAIHN0YXRpYyB1OCB2aXJ0aW9fdmRwYV9n
ZXRfc3RhdHVzKHN0cnVjdCAKPj4gdmlydGlvX2RldmljZSAqdmRldikKPj4gwqAgc3RhdGljIHZv
aWQgdmlydGlvX3ZkcGFfc2V0X3N0YXR1cyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgdTgg
Cj4+IHN0YXR1cykKPj4gwqAgewo+PiDCoMKgwqDCoMKgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRw
YSA9IHZkX2dldF92ZHBhKHZkZXYpOwo+PiAtwqDCoMKgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZp
Z19vcHMgKm9wcyA9IHZkcGEtPmNvbmZpZzsKPj4gwqAgLcKgwqDCoCByZXR1cm4gb3BzLT5zZXRf
c3RhdHVzKHZkcGEsIHN0YXR1cyk7Cj4+ICvCoMKgwqAgcmV0dXJuIHZkcGFfc2V0X3N0YXR1cyh2
ZHBhLCBzdGF0dXMpOwo+PiDCoCB9Cj4+IMKgIMKgIHN0YXRpYyB2b2lkIHZpcnRpb192ZHBhX3Jl
c2V0KHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC92ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+PiBpbmRleCA5Y2M0MjkxYTc5YjMu
LmFlMDQ3ZmFlMjYwMyAxMDA2NDQKPj4gLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPj4gKysr
IGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPj4gQEAgLTQwOCw2ICs0MDgsOSBAQCB2b2lkIHZkcGFf
Z2V0X2NvbmZpZyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIAo+PiB1bnNpZ25lZCBpbnQgb2Zm
c2V0LAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZvaWQgKmJ1ZiwgdW5zaWduZWQg
aW50IGxlbik7Cj4+IMKgIHZvaWQgdmRwYV9zZXRfY29uZmlnKHN0cnVjdCB2ZHBhX2RldmljZSAq
ZGV2LCB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGNvbnN0IHZvaWQgKmJ1ZiwgdW5zaWduZWQgaW50IGxlbmd0aCk7Cj4+ICt1OCB2ZHBhX2dldF9z
dGF0dXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KTsKPj4gK3ZvaWQgdmRwYV9zZXRfc3RhdHVz
KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTggc3RhdHVzKTsKPj4gKwo+PiDCoCAvKioKPj4g
wqDCoCAqIHN0cnVjdCB2ZHBhX21nbXRkZXZfb3BzIC0gdmRwYSBkZXZpY2Ugb3BzCj4+IMKgwqAg
KiBAZGV2X2FkZDogQWRkIGEgdmRwYSBkZXZpY2UgdXNpbmcgYWxsb2MgYW5kIHJlZ2lzdGVyCj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==

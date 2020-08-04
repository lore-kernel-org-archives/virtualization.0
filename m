Return-Path: <SRS0=iZVf=BO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64254C433E1
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 09:21:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57DFD22B45
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 09:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUsp18db"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DFD22B45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id ED84F854C0;
	Tue,  4 Aug 2020 09:21:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fjE0Zn1uC6lE; Tue,  4 Aug 2020 09:21:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B983186970;
	Tue,  4 Aug 2020 09:21:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DBEBC0050;
	Tue,  4 Aug 2020 09:21:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E869C004C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 09:21:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2B0B185F68
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 09:21:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5s9cc9LFEMih
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 09:21:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2378985EAF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 09:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596532890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VdYeaAEHvxCuHRrC0ZWTZuqe8Mpsy7W7KzueiHGEXQQ=;
 b=QUsp18dbxWg4b8NtZSbhhWFZ5Ea8sQ+35dZwtKnS/YgGHJKhaUSUUmN9+VNgM/KGORaABF
 4oo/lD9n5scMMWx4U633kHib+q+4mjCAPZJAyfCgEPO3DUpq0opd2xHntLPRqAmOIcTey+
 l0TNsDTDRScI7v24xrPr5pwKfn4nXZQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-Hbmo_ekpM5abok4L-pnbew-1; Tue, 04 Aug 2020 05:21:29 -0400
X-MC-Unique: Hbmo_ekpM5abok4L-pnbew-1
Received: by mail-qv1-f69.google.com with SMTP id f1so17337217qvx.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Aug 2020 02:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=VdYeaAEHvxCuHRrC0ZWTZuqe8Mpsy7W7KzueiHGEXQQ=;
 b=i+QtO3YDxpNNILcrNcmwl+dSC3tFkhneAeVUMnNquDpFJSCgTTJrNMn740wyoUbn6X
 VDyasnhwEmm9ZuIjMi/QFacwWb/gxPbVHmjGlNXi8PkyR4M5ZVzWVMEzVjiK7oboT7NK
 8PyqvVBoa9YFu14ZSnMQaS2OFgqpaZaID92RbjhrQqxAvnULzwzWyIKhNd6757IHthGA
 W/YZXqKcuU60lHNK/spJ9+i/XFD6TsAIHCeoozDvwzIsSfoeU5FDt1CwkpisEmpv5IjW
 q+P7xTVVDVOp3j4O67SjEgYJkgIbb/tZyENqo3LTnujkXjsDqBxqvm/518zJHT6n1oO2
 55rA==
X-Gm-Message-State: AOAM533P+JVndxZ23U3CpoShnrxUS7PcPx+NH6ygDAxLUR6W+hrkLz5q
 eCtjMYUxqRdeJh1q3peQe05F/GJVO2L0yZ9SFmlGJ5iUPSJVcyLU8Px8az6fffgboNoAdHJtQM0
 k98UmWyKbWLxMVc9EIEjA+JKbPUffK3UxD5FBa3k3Aw==
X-Received: by 2002:ae9:c306:: with SMTP id n6mr5669506qkg.236.1596532889033; 
 Tue, 04 Aug 2020 02:21:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYMfSa4HWD7dsTEDCidkijX+9HP3ahgdhYBwSp9Fl7ADQr95CALTi2KN2456XprPWaNM3RUw==
X-Received: by 2002:ae9:c306:: with SMTP id n6mr5669479qkg.236.1596532888639; 
 Tue, 04 Aug 2020 02:21:28 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id g129sm23083159qkb.39.2020.08.04.02.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 02:21:27 -0700 (PDT)
Date: Tue, 4 Aug 2020 05:21:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V5 1/6] vhost: introduce vhost_vring_call
Message-ID: <20200804052050-mutt-send-email-mst@kernel.org>
References: <20200731065533.4144-1-lingshan.zhu@intel.com>
 <20200731065533.4144-2-lingshan.zhu@intel.com>
 <5e646141-ca8d-77a5-6f41-d30710d91e6d@redhat.com>
 <d51dd4e3-7513-c771-104c-b61f9ee70f30@intel.com>
 <156b8d71-6870-c163-fdfa-35bf4701987d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <156b8d71-6870-c163-fdfa-35bf4701987d@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: shahafs@mellanox.com, wanpengli@tencent.com, parav@mellanox.com,
 kvm@vger.kernel.org, netdev@vger.kernel.org, sean.j.christopherson@intel.com,
 virtualization@lists.linux-foundation.org, eli@mellanox.com,
 pbonzini@redhat.com, "Zhu, Lingshan" <lingshan.zhu@intel.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCBBdWcgMDQsIDIwMjAgYXQgMDQ6NTM6MzlQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzgvNCDkuIvljYg0OjQyLCBaaHUsIExpbmdzaGFuIHdyb3RlOgo+ID4g
Cj4gPiAKPiA+IE9uIDgvNC8yMDIwIDQ6MzggUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+IAo+
ID4gPiBPbiAyMDIwLzcvMzEg5LiL5Y2IMjo1NSwgWmh1IExpbmdzaGFuIHdyb3RlOgo+ID4gPiA+
IFRoaXMgY29tbWl0IGludHJvZHVjZXMgc3RydWN0IHZob3N0X3ZyaW5nX2NhbGwgd2hpY2ggcmVw
bGFjZWQKPiA+ID4gPiByYXcgc3RydWN0IGV2ZW50ZmRfY3R4ICpjYWxsX2N0eCBpbiBzdHJ1Y3Qg
dmhvc3RfdmlydHF1ZXVlLgo+ID4gPiA+IEJlc2lkZXMgZXZlbnRmZF9jdHgsIGl0IGNvbnRhaW5z
IGEgc3BpbiBsb2NrIGFuZCBhbgo+ID4gPiA+IGlycV9ieXBhc3NfcHJvZHVjZXIgaW4gaXRzIHN0
cnVjdHVyZS4KPiA+ID4gPiAKPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGluZ3NoYW4gPGxp
bmdzaGFuLnpodUBpbnRlbC5jb20+Cj4gPiA+ID4gU3VnZ2VzdGVkLWJ5OiBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiA+IC0tLQo+ID4gPiA+IMKgIGRyaXZlcnMvdmhvc3Qv
dmRwYS5jwqAgfMKgIDQgKystLQo+ID4gPiA+IMKgIGRyaXZlcnMvdmhvc3Qvdmhvc3QuYyB8IDIy
ICsrKysrKysrKysrKysrKystLS0tLS0KPiA+ID4gPiDCoCBkcml2ZXJzL3Zob3N0L3Zob3N0Lmgg
fMKgIDkgKysrKysrKystCj4gPiA+ID4gwqAgMyBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25z
KCspLCA5IGRlbGV0aW9ucygtKQo+ID4gPiA+IAo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gPiA+ID4gaW5kZXggYTU0YjYw
ZDY2MjNmLi5kZjNjZjM4NmIwY2QgMTAwNjQ0Cj4gPiA+ID4gLS0tIGEvZHJpdmVycy92aG9zdC92
ZHBhLmMKPiA+ID4gPiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ID4gPiA+IEBAIC05Niw3
ICs5Niw3IEBAIHN0YXRpYyB2b2lkIGhhbmRsZV92cV9raWNrKHN0cnVjdCB2aG9zdF93b3JrICp3
b3JrKQo+ID4gPiA+IMKgIHN0YXRpYyBpcnFyZXR1cm5fdCB2aG9zdF92ZHBhX3ZpcnRxdWV1ZV9j
Yih2b2lkICpwcml2YXRlKQo+ID4gPiA+IMKgIHsKPiA+ID4gPiDCoMKgwqDCoMKgIHN0cnVjdCB2
aG9zdF92aXJ0cXVldWUgKnZxID0gcHJpdmF0ZTsKPiA+ID4gPiAtwqDCoMKgIHN0cnVjdCBldmVu
dGZkX2N0eCAqY2FsbF9jdHggPSB2cS0+Y2FsbF9jdHg7Cj4gPiA+ID4gK8KgwqDCoCBzdHJ1Y3Qg
ZXZlbnRmZF9jdHggKmNhbGxfY3R4ID0gdnEtPmNhbGxfY3R4LmN0eDsKPiA+ID4gPiDCoCDCoMKg
wqDCoMKgIGlmIChjYWxsX2N0eCkKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgZXZlbnRmZF9z
aWduYWwoY2FsbF9jdHgsIDEpOwo+ID4gPiA+IEBAIC0zODIsNyArMzgyLDcgQEAgc3RhdGljIGxv
bmcgdmhvc3RfdmRwYV92cmluZ19pb2N0bChzdHJ1Y3QKPiA+ID4gPiB2aG9zdF92ZHBhICp2LCB1
bnNpZ25lZCBpbnQgY21kLAo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiA+ID4g
PiDCoCDCoMKgwqDCoMKgIGNhc2UgVkhPU1RfU0VUX1ZSSU5HX0NBTEw6Cj4gPiA+ID4gLcKgwqDC
oMKgwqDCoMKgIGlmICh2cS0+Y2FsbF9jdHgpIHsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAgaWYg
KHZxLT5jYWxsX2N0eC5jdHgpIHsKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBj
Yi5jYWxsYmFjayA9IHZob3N0X3ZkcGFfdmlydHF1ZXVlX2NiOwo+ID4gPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNiLnByaXZhdGUgPSB2cTsKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
wqAgfSBlbHNlIHsKPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92aG9zdC5jIGIv
ZHJpdmVycy92aG9zdC92aG9zdC5jCj4gPiA+ID4gaW5kZXggZDdiOGRmM2VkZmZjLi45ZjFhODQ1
YTkzMDIgMTAwNjQ0Cj4gPiA+ID4gLS0tIGEvZHJpdmVycy92aG9zdC92aG9zdC5jCj4gPiA+ID4g
KysrIGIvZHJpdmVycy92aG9zdC92aG9zdC5jCj4gPiA+ID4gQEAgLTI5OCw2ICsyOTgsMTMgQEAg
c3RhdGljIHZvaWQgdmhvc3RfdnFfbWV0YV9yZXNldChzdHJ1Y3QKPiA+ID4gPiB2aG9zdF9kZXYg
KmQpCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIF9fdmhvc3RfdnFfbWV0YV9yZXNldChkLT52
cXNbaV0pOwo+ID4gPiA+IMKgIH0KPiA+ID4gPiDCoCArc3RhdGljIHZvaWQgdmhvc3RfdnJpbmdf
Y2FsbF9yZXNldChzdHJ1Y3Qgdmhvc3RfdnJpbmdfY2FsbAo+ID4gPiA+ICpjYWxsX2N0eCkKPiA+
ID4gPiArewo+ID4gPiA+ICvCoMKgwqAgY2FsbF9jdHgtPmN0eCA9IE5VTEw7Cj4gPiA+ID4gK8Kg
wqDCoCBtZW1zZXQoJmNhbGxfY3R4LT5wcm9kdWNlciwgMHgwLCBzaXplb2Yoc3RydWN0Cj4gPiA+
ID4gaXJxX2J5cGFzc19wcm9kdWNlcikpOwo+ID4gPiA+ICvCoMKgwqAgc3Bpbl9sb2NrX2luaXQo
JmNhbGxfY3R4LT5jdHhfbG9jayk7Cj4gPiA+ID4gK30KPiA+ID4gPiArCj4gPiA+ID4gwqAgc3Rh
dGljIHZvaWQgdmhvc3RfdnFfcmVzZXQoc3RydWN0IHZob3N0X2RldiAqZGV2LAo+ID4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB2aG9zdF92aXJ0cXVldWUgKnZx
KQo+ID4gPiA+IMKgIHsKPiA+ID4gPiBAQCAtMzE5LDEzICszMjYsMTMgQEAgc3RhdGljIHZvaWQg
dmhvc3RfdnFfcmVzZXQoc3RydWN0IHZob3N0X2RldiAqZGV2LAo+ID4gPiA+IMKgwqDCoMKgwqAg
dnEtPmxvZ19iYXNlID0gTlVMTDsKPiA+ID4gPiDCoMKgwqDCoMKgIHZxLT5lcnJvcl9jdHggPSBO
VUxMOwo+ID4gPiA+IMKgwqDCoMKgwqAgdnEtPmtpY2sgPSBOVUxMOwo+ID4gPiA+IC3CoMKgwqAg
dnEtPmNhbGxfY3R4ID0gTlVMTDsKPiA+ID4gPiDCoMKgwqDCoMKgIHZxLT5sb2dfY3R4ID0gTlVM
TDsKPiA+ID4gPiDCoMKgwqDCoMKgIHZob3N0X3Jlc2V0X2lzX2xlKHZxKTsKPiA+ID4gPiDCoMKg
wqDCoMKgIHZob3N0X2Rpc2FibGVfY3Jvc3NfZW5kaWFuKHZxKTsKPiA+ID4gPiDCoMKgwqDCoMKg
IHZxLT5idXN5bG9vcF90aW1lb3V0ID0gMDsKPiA+ID4gPiDCoMKgwqDCoMKgIHZxLT51bWVtID0g
TlVMTDsKPiA+ID4gPiDCoMKgwqDCoMKgIHZxLT5pb3RsYiA9IE5VTEw7Cj4gPiA+ID4gK8KgwqDC
oCB2aG9zdF92cmluZ19jYWxsX3Jlc2V0KCZ2cS0+Y2FsbF9jdHgpOwo+ID4gPiA+IMKgwqDCoMKg
wqAgX192aG9zdF92cV9tZXRhX3Jlc2V0KHZxKTsKPiA+ID4gPiDCoCB9Cj4gPiA+ID4gwqAgQEAg
LTY4NSw4ICs2OTIsOCBAQCB2b2lkIHZob3N0X2Rldl9jbGVhbnVwKHN0cnVjdCB2aG9zdF9kZXYg
KmRldikKPiA+ID4gPiBldmVudGZkX2N0eF9wdXQoZGV2LT52cXNbaV0tPmVycm9yX2N0eCk7Cj4g
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChkZXYtPnZxc1tpXS0+a2ljaykKPiA+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmcHV0KGRldi0+dnFzW2ldLT5raWNrKTsKPiA+ID4g
PiAtwqDCoMKgwqDCoMKgwqAgaWYgKGRldi0+dnFzW2ldLT5jYWxsX2N0eCkKPiA+ID4gPiAtIGV2
ZW50ZmRfY3R4X3B1dChkZXYtPnZxc1tpXS0+Y2FsbF9jdHgpOwo+ID4gPiA+ICvCoMKgwqDCoMKg
wqDCoCBpZiAoZGV2LT52cXNbaV0tPmNhbGxfY3R4LmN0eCkKPiA+ID4gPiArIGV2ZW50ZmRfY3R4
X3B1dChkZXYtPnZxc1tpXS0+Y2FsbF9jdHguY3R4KTsKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
wqAgdmhvc3RfdnFfcmVzZXQoZGV2LCBkZXYtPnZxc1tpXSk7Cj4gPiA+ID4gwqDCoMKgwqDCoCB9
Cj4gPiA+ID4gwqDCoMKgwqDCoCB2aG9zdF9kZXZfZnJlZV9pb3ZlY3MoZGV2KTsKPiA+ID4gPiBA
QCAtMTYyOSw3ICsxNjM2LDEwIEBAIGxvbmcgdmhvc3RfdnJpbmdfaW9jdGwoc3RydWN0IHZob3N0
X2Rldgo+ID4gPiA+ICpkLCB1bnNpZ25lZCBpbnQgaW9jdGwsIHZvaWQgX191c2VyICphcmcKPiA+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByID0gUFRSX0VSUihjdHgpOwo+ID4gPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ID4gPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoCB9Cj4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgIHN3YXAoY3R4LCB2cS0+Y2FsbF9jdHgpOwo+
ID4gPiA+ICsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAgc3Bpbl9sb2NrKCZ2cS0+Y2FsbF9jdHgu
Y3R4X2xvY2spOwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCBzd2FwKGN0eCwgdnEtPmNhbGxfY3R4
LmN0eCk7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgIHNwaW5fdW5sb2NrKCZ2cS0+Y2FsbF9jdHgu
Y3R4X2xvY2spOwo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiA+ID4gPiDCoMKg
wqDCoMKgIGNhc2UgVkhPU1RfU0VUX1ZSSU5HX0VSUjoKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKGNvcHlfZnJvbV91c2VyKCZmLCBhcmdwLCBzaXplb2YgZikpIHsKPiA+ID4gPiBAQCAt
MjQ0MCw4ICsyNDUwLDggQEAgc3RhdGljIGJvb2wgdmhvc3Rfbm90aWZ5KHN0cnVjdCB2aG9zdF9k
ZXYKPiA+ID4gPiAqZGV2LCBzdHJ1Y3Qgdmhvc3RfdmlydHF1ZXVlICp2cSkKPiA+ID4gPiDCoCB2
b2lkIHZob3N0X3NpZ25hbChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIHN0cnVjdCB2aG9zdF92aXJ0
cXVldWUgKnZxKQo+ID4gPiA+IMKgIHsKPiA+ID4gPiDCoMKgwqDCoMKgIC8qIFNpZ25hbCB0aGUg
R3Vlc3QgdGVsbCB0aGVtIHdlIHVzZWQgc29tZXRoaW5nIHVwLiAqLwo+ID4gPiA+IC3CoMKgwqAg
aWYgKHZxLT5jYWxsX2N0eCAmJiB2aG9zdF9ub3RpZnkoZGV2LCB2cSkpCj4gPiA+ID4gLcKgwqDC
oMKgwqDCoMKgIGV2ZW50ZmRfc2lnbmFsKHZxLT5jYWxsX2N0eCwgMSk7Cj4gPiA+ID4gK8KgwqDC
oCBpZiAodnEtPmNhbGxfY3R4LmN0eCAmJiB2aG9zdF9ub3RpZnkoZGV2LCB2cSkpCj4gPiA+ID4g
K8KgwqDCoMKgwqDCoMKgIGV2ZW50ZmRfc2lnbmFsKHZxLT5jYWxsX2N0eC5jdHgsIDEpOwo+ID4g
PiA+IMKgIH0KPiA+ID4gPiDCoCBFWFBPUlRfU1lNQk9MX0dQTCh2aG9zdF9zaWduYWwpOwo+ID4g
PiA+IMKgIGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmggYi9kcml2ZXJzL3Zob3N0
L3Zob3N0LmgKPiA+ID4gPiBpbmRleCBjOGU5NmEwOTVkM2IuLjM4ZWIxYWEzYjY4ZCAxMDA2NDQK
PiA+ID4gPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmgKPiA+ID4gPiArKysgYi9kcml2ZXJz
L3Zob3N0L3Zob3N0LmgKPiA+ID4gPiBAQCAtMTMsNiArMTMsNyBAQAo+ID4gPiA+IMKgICNpbmNs
dWRlIDxsaW51eC92aXJ0aW9fcmluZy5oPgo+ID4gPiA+IMKgICNpbmNsdWRlIDxsaW51eC9hdG9t
aWMuaD4KPiA+ID4gPiDCoCAjaW5jbHVkZSA8bGludXgvdmhvc3RfaW90bGIuaD4KPiA+ID4gPiAr
I2luY2x1ZGUgPGxpbnV4L2lycWJ5cGFzcy5oPgo+ID4gPiA+IMKgIMKgIHN0cnVjdCB2aG9zdF93
b3JrOwo+ID4gPiA+IMKgIHR5cGVkZWYgdm9pZCAoKnZob3N0X3dvcmtfZm5fdCkoc3RydWN0IHZo
b3N0X3dvcmsgKndvcmspOwo+ID4gPiA+IEBAIC02MCw2ICs2MSwxMiBAQCBlbnVtIHZob3N0X3Vh
ZGRyX3R5cGUgewo+ID4gPiA+IMKgwqDCoMKgwqAgVkhPU1RfTlVNX0FERFJTID0gMywKPiA+ID4g
PiDCoCB9Owo+ID4gPiA+IMKgICtzdHJ1Y3Qgdmhvc3RfdnJpbmdfY2FsbCB7Cj4gPiA+ID4gK8Kg
wqDCoCBzdHJ1Y3QgZXZlbnRmZF9jdHggKmN0eDsKPiA+ID4gPiArwqDCoMKgIHN0cnVjdCBpcnFf
YnlwYXNzX3Byb2R1Y2VyIHByb2R1Y2VyOwo+ID4gPiA+ICvCoMKgwqAgc3BpbmxvY2tfdCBjdHhf
bG9jazsKPiA+ID4gCj4gPiA+IAo+ID4gPiBJdCdzIG5vdCBjbGVhciB0byBtZSB3aHkgd2UgbmVl
ZCBjdHhfbG9jayBoZXJlLgo+ID4gPiAKPiA+ID4gVGhhbmtzCj4gPiBIaSBKYXNvbiwKPiA+IAo+
ID4gd2UgdXNlIHRoaXMgbG9jayB0byBwcm90ZWN0IHRoZSBldmVudGZkX2N0eCBhbmQgaXJxIGZy
b20gcmFjZSBjb25kaXRpb25zLAo+IAo+IAo+IFdlIGRvbid0IHN1cHBvcnQgaXJxIG5vdGlmaWNh
dGlvbiBmcm9tIHZEUEEgZGV2aWNlIGRyaXZlciBpbiB0aGlzIHZlcnNpb24sCj4gZG8gd2Ugc3Rp
bGwgaGF2ZSByYWNlIGNvbmRpdGlvbj8KPiAKPiBUaGFua3MKCkphc29uIEknbSBub3Qgc3VyZSB3
aGF0IHlvdSBhcmUgdHJ5aW5nIHRvIHNheSBoZXJlLgoKCj4gCj4gPiAgIGFyZSB5b3Ugc3VnZ2Vz
dGluZyBhIGJldHRlciBuYW1lPwo+ID4gCj4gPiBUaGFua3MKPiA+ID4gCj4gPiA+IAo+ID4gPiA+
ICt9Owo+ID4gPiA+ICsKPiA+ID4gPiDCoCAvKiBUaGUgdmlydHF1ZXVlIHN0cnVjdHVyZSBkZXNj
cmliZXMgYSBxdWV1ZSBhdHRhY2hlZCB0byBhIGRldmljZS4gKi8KPiA+ID4gPiDCoCBzdHJ1Y3Qg
dmhvc3RfdmlydHF1ZXVlIHsKPiA+ID4gPiDCoMKgwqDCoMKgIHN0cnVjdCB2aG9zdF9kZXYgKmRl
djsKPiA+ID4gPiBAQCAtNzIsNyArNzksNyBAQCBzdHJ1Y3Qgdmhvc3RfdmlydHF1ZXVlIHsKPiA+
ID4gPiDCoMKgwqDCoMKgIHZyaW5nX3VzZWRfdCBfX3VzZXIgKnVzZWQ7Cj4gPiA+ID4gwqDCoMKg
wqDCoCBjb25zdCBzdHJ1Y3Qgdmhvc3RfaW90bGJfbWFwICptZXRhX2lvdGxiW1ZIT1NUX05VTV9B
RERSU107Cj4gPiA+ID4gwqDCoMKgwqDCoCBzdHJ1Y3QgZmlsZSAqa2ljazsKPiA+ID4gPiAtwqDC
oMKgIHN0cnVjdCBldmVudGZkX2N0eCAqY2FsbF9jdHg7Cj4gPiA+ID4gK8KgwqDCoCBzdHJ1Y3Qg
dmhvc3RfdnJpbmdfY2FsbCBjYWxsX2N0eDsKPiA+ID4gPiDCoMKgwqDCoMKgIHN0cnVjdCBldmVu
dGZkX2N0eCAqZXJyb3JfY3R4Owo+ID4gPiA+IMKgwqDCoMKgwqAgc3RydWN0IGV2ZW50ZmRfY3R4
ICpsb2dfY3R4Owo+ID4gPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

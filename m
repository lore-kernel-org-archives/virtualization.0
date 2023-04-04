Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED3EC6FD1D
	for <virtualization@archiver.kernel.org>; Tue,  4 Apr 2023 07:05:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C25C740439;
	Tue,  4 Apr 2023 07:05:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C25C740439
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S7RUqYKa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AaquhWGSze4Q; Tue,  4 Apr 2023 07:05:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 36E1840453;
	Tue,  4 Apr 2023 07:05:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 36E1840453
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E704C0036;
	Tue,  4 Apr 2023 07:05:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70470C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 07:05:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3B875409B1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 07:05:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B875409B1
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=S7RUqYKa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nOGLEhh-yb5D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 07:05:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 195AF409A8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 195AF409A8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 07:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680591902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wRGQbakcdzaASqmFqNMfN6cXWVKXiaqVuIK9X38kydM=;
 b=S7RUqYKa/mHtSn6CiCDJAldVy/Or7MEjqinttueJb+rJRCB1MQym1it72vIh0qyElkwcnC
 gGJKf8qMDcAXTftE2PmayksDQC98I6Os60BINfBBhaNDA7fwzNeyxywnwOtSQtFYn6IDAG
 JVdFvcRNeA8l5CJ1D5NDy/Y6ZytLCww=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-lDqPz6EANWy0jSWo4Bip9w-1; Tue, 04 Apr 2023 03:05:00 -0400
X-MC-Unique: lDqPz6EANWy0jSWo4Bip9w-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-17a678c2de9so16751587fac.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Apr 2023 00:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680591900; x=1683183900;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wRGQbakcdzaASqmFqNMfN6cXWVKXiaqVuIK9X38kydM=;
 b=Fl1OdiNvZh10eedAF+JBnt9LAij1mdSEG7sS0Vn/I05sZqkO+9mVlWyHDHMhbaBu3+
 uTAe7SZP2oWs2qCS1/nvDTKlGFfZ/SK9W+JgB6op3KBKl5cpSyTah5/F/FAZwNlwaDeE
 R0OAYRFoS80pF3J5b3X8uG7jHkwpVMxqv/p6E67vcIkIV5lceJ8xbb4oibOydwCJBeZV
 fEQ0Bg7ud20mdYBsqfKRgIiz2rUaTM+a8M2Ms3XJ10NuWGkIl/cQw3xhOrZL92qKUpDl
 H1sgtg6kNsRgAmec3BH5MKYgKl+pOu2j/z5bv70sHSLTUovJGrqS8hCv36akLhea0uq5
 nJxg==
X-Gm-Message-State: AAQBX9cAwEjlQwTf8hFFvi7WbaXyr9agIdl2FfkfRl311/aqPs94QCgd
 0aW783smFVS2bi9mWVXZVY3b678ekWLUpOKAECM8J8nrZhuisdE6Y2Hj7WdEKmkiWhksFWWr+MT
 wgKdrgZ70fCKdzlmDJ7RnR6a89Hvo+fEOPkg7nAIW/57Q0vu+hU6Uef8xQA==
X-Received: by 2002:a05:6870:344c:b0:17d:1287:1b5c with SMTP id
 i12-20020a056870344c00b0017d12871b5cmr820549oah.9.1680591899898; 
 Tue, 04 Apr 2023 00:04:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZuCwtmi+DPcu9KSTPh2WcNMa0iosV+A+Rxedwj6uDBO5Z2ZDPHznhxZTHC7u6V1ftqmHMawwN0934bnElqtNM=
X-Received: by 2002:a05:6870:344c:b0:17d:1287:1b5c with SMTP id
 i12-20020a056870344c00b0017d12871b5cmr820540oah.9.1680591899602; Tue, 04 Apr
 2023 00:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230328021717.42268-1-michael.christie@oracle.com>
 <20230328021717.42268-2-michael.christie@oracle.com>
In-Reply-To: <20230328021717.42268-2-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 4 Apr 2023 15:04:48 +0800
Message-ID: <CACGkMEvrAeSqSrBPkuVuRuh6a0MObw0H=19w82JijxHn6vQsVA@mail.gmail.com>
Subject: Re: [PATCH v6 01/11] vhost: add vhost_worker pointer to
 vhost_virtqueue
To: Mike Christie <michael.christie@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 mst@redhat.com
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

T24gVHVlLCBNYXIgMjgsIDIwMjMgYXQgMTA6MTfigK9BTSBNaWtlIENocmlzdGllCjxtaWNoYWVs
LmNocmlzdGllQG9yYWNsZS5jb20+IHdyb3RlOgo+Cj4gVGhpcyBwYXRjaHNldCBhbGxvd3MgdXNl
cnNwYWNlIHRvIG1hcCB2cXMgdG8gZGlmZmVyZW50IHdvcmtlcnMuIFRoaXMKPiBwYXRjaCBhZGRz
IGEgd29ya2VyIHBvaW50ZXIgdG8gdGhlIHZxIHNvIHdlIGNhbiBzdG9yZSB0aGF0IGluZm8uCj4K
PiBTaWduZWQtb2ZmLWJ5OiBNaWtlIENocmlzdGllIDxtaWNoYWVsLmNocmlzdGllQG9yYWNsZS5j
b20+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoK
PiAtLS0KPiAgZHJpdmVycy92aG9zdC92aG9zdC5jIHwgMjQgKysrKysrKysrKysrKy0tLS0tLS0t
LS0tCj4gIGRyaXZlcnMvdmhvc3Qvdmhvc3QuaCB8ICAxICsKPiAgMiBmaWxlcyBjaGFuZ2VkLCAx
NCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3Zob3N0L3Zob3N0LmMgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiBpbmRleCA0MzY4ZWU5Yjk5
OWMuLmUwNDFlMTE2YWZlZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiAr
KysgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiBAQCAtNDg2LDYgKzQ4Niw3IEBAIHZvaWQgdmhv
c3RfZGV2X2luaXQoc3RydWN0IHZob3N0X2RldiAqZGV2LAo+ICAgICAgICAgICAgICAgICB2cS0+
bG9nID0gTlVMTDsKPiAgICAgICAgICAgICAgICAgdnEtPmluZGlyZWN0ID0gTlVMTDsKPiAgICAg
ICAgICAgICAgICAgdnEtPmhlYWRzID0gTlVMTDsKPiArICAgICAgICAgICAgICAgdnEtPndvcmtl
ciA9IE5VTEw7Cj4gICAgICAgICAgICAgICAgIHZxLT5kZXYgPSBkZXY7Cj4gICAgICAgICAgICAg
ICAgIG11dGV4X2luaXQoJnZxLT5tdXRleCk7Cj4gICAgICAgICAgICAgICAgIHZob3N0X3ZxX3Jl
c2V0KGRldiwgdnEpOwo+IEBAIC01NTQsMTYgKzU1NSwxNSBAQCBzdGF0aWMgdm9pZCB2aG9zdF93
b3JrZXJfZnJlZShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpCj4gICAgICAgICBrZnJlZSh3b3JrZXIp
Owo+ICB9Cj4KPiAtc3RhdGljIGludCB2aG9zdF93b3JrZXJfY3JlYXRlKHN0cnVjdCB2aG9zdF9k
ZXYgKmRldikKPiArc3RhdGljIHN0cnVjdCB2aG9zdF93b3JrZXIgKnZob3N0X3dvcmtlcl9jcmVh
dGUoc3RydWN0IHZob3N0X2RldiAqZGV2KQo+ICB7Cj4gICAgICAgICBzdHJ1Y3Qgdmhvc3Rfd29y
a2VyICp3b3JrZXI7Cj4gICAgICAgICBzdHJ1Y3Qgdmhvc3RfdGFzayAqdnRzazsKPiAgICAgICAg
IGNoYXIgbmFtZVtUQVNLX0NPTU1fTEVOXTsKPiAtICAgICAgIGludCByZXQ7Cj4KPiAgICAgICAg
IHdvcmtlciA9IGt6YWxsb2Moc2l6ZW9mKCp3b3JrZXIpLCBHRlBfS0VSTkVMX0FDQ09VTlQpOwo+
ICAgICAgICAgaWYgKCF3b3JrZXIpCj4gLSAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOwo+
ICsgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsKPgo+ICAgICAgICAgZGV2LT53b3JrZXIgPSB3
b3JrZXI7Cj4gICAgICAgICB3b3JrZXItPmtjb3ZfaGFuZGxlID0ga2Nvdl9jb21tb25faGFuZGxl
KCk7Cj4gQEAgLTU3MSwyNSArNTcxLDI0IEBAIHN0YXRpYyBpbnQgdmhvc3Rfd29ya2VyX2NyZWF0
ZShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpCj4gICAgICAgICBzbnByaW50ZihuYW1lLCBzaXplb2Yo
bmFtZSksICJ2aG9zdC0lZCIsIGN1cnJlbnQtPnBpZCk7Cj4KPiAgICAgICAgIHZ0c2sgPSB2aG9z
dF90YXNrX2NyZWF0ZSh2aG9zdF93b3JrZXIsIHdvcmtlciwgbmFtZSk7Cj4gLSAgICAgICBpZiAo
IXZ0c2spIHsKPiAtICAgICAgICAgICAgICAgcmV0ID0gLUVOT01FTTsKPiArICAgICAgIGlmICgh
dnRzaykKPiAgICAgICAgICAgICAgICAgZ290byBmcmVlX3dvcmtlcjsKPiAtICAgICAgIH0KPgo+
ICAgICAgICAgd29ya2VyLT52dHNrID0gdnRzazsKPiAgICAgICAgIHZob3N0X3Rhc2tfc3RhcnQo
dnRzayk7Cj4gLSAgICAgICByZXR1cm4gMDsKPiArICAgICAgIHJldHVybiB3b3JrZXI7Cj4KPiAg
ZnJlZV93b3JrZXI6Cj4gICAgICAgICBrZnJlZSh3b3JrZXIpOwo+ICAgICAgICAgZGV2LT53b3Jr
ZXIgPSBOVUxMOwo+IC0gICAgICAgcmV0dXJuIHJldDsKPiArICAgICAgIHJldHVybiBOVUxMOwo+
ICB9Cj4KPiAgLyogQ2FsbGVyIHNob3VsZCBoYXZlIGRldmljZSBtdXRleCAqLwo+ICBsb25nIHZo
b3N0X2Rldl9zZXRfb3duZXIoc3RydWN0IHZob3N0X2RldiAqZGV2KQo+ICB7Cj4gLSAgICAgICBp
bnQgZXJyOwo+ICsgICAgICAgc3RydWN0IHZob3N0X3dvcmtlciAqd29ya2VyOwo+ICsgICAgICAg
aW50IGVyciwgaTsKPgo+ICAgICAgICAgLyogSXMgdGhlcmUgYW4gb3duZXIgYWxyZWFkeT8gKi8K
PiAgICAgICAgIGlmICh2aG9zdF9kZXZfaGFzX293bmVyKGRldikpIHsKPiBAQCAtNjAwLDkgKzU5
OSwxMiBAQCBsb25nIHZob3N0X2Rldl9zZXRfb3duZXIoc3RydWN0IHZob3N0X2RldiAqZGV2KQo+
ICAgICAgICAgdmhvc3RfYXR0YWNoX21tKGRldik7Cj4KPiAgICAgICAgIGlmIChkZXYtPnVzZV93
b3JrZXIpIHsKPiAtICAgICAgICAgICAgICAgZXJyID0gdmhvc3Rfd29ya2VyX2NyZWF0ZShkZXYp
Owo+IC0gICAgICAgICAgICAgICBpZiAoZXJyKQo+ICsgICAgICAgICAgICAgICB3b3JrZXIgPSB2
aG9zdF93b3JrZXJfY3JlYXRlKGRldik7Cj4gKyAgICAgICAgICAgICAgIGlmICghd29ya2VyKQo+
ICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyX3dvcmtlcjsKPiArCj4gKyAgICAgICAg
ICAgICAgIGZvciAoaSA9IDA7IGkgPCBkZXYtPm52cXM7IGkrKykKPiArICAgICAgICAgICAgICAg
ICAgICAgICBkZXYtPnZxc1tpXS0+d29ya2VyID0gd29ya2VyOwo+ICAgICAgICAgfQo+Cj4gICAg
ICAgICBlcnIgPSB2aG9zdF9kZXZfYWxsb2NfaW92ZWNzKGRldik7Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmhvc3Qvdmhvc3QuaCBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuaAo+IGluZGV4IDAzMDg2
MzhjZGVlZS4uZTcyYjY2NWJhM2E1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3Qvdmhvc3Qu
aAo+ICsrKyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuaAo+IEBAIC03NCw2ICs3NCw3IEBAIHN0cnVj
dCB2aG9zdF92cmluZ19jYWxsIHsKPiAgLyogVGhlIHZpcnRxdWV1ZSBzdHJ1Y3R1cmUgZGVzY3Jp
YmVzIGEgcXVldWUgYXR0YWNoZWQgdG8gYSBkZXZpY2UuICovCj4gIHN0cnVjdCB2aG9zdF92aXJ0
cXVldWUgewo+ICAgICAgICAgc3RydWN0IHZob3N0X2RldiAqZGV2Owo+ICsgICAgICAgc3RydWN0
IHZob3N0X3dvcmtlciAqd29ya2VyOwo+Cj4gICAgICAgICAvKiBUaGUgYWN0dWFsIHJpbmcgb2Yg
YnVmZmVycy4gKi8KPiAgICAgICAgIHN0cnVjdCBtdXRleCBtdXRleDsKPiAtLQo+IDIuMjUuMQo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=

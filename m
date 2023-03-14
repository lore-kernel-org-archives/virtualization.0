Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC85C6FD1C
	for <virtualization@archiver.kernel.org>; Tue, 14 Mar 2023 07:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15DBD61034;
	Tue, 14 Mar 2023 07:58:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 15DBD61034
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MwwRA+AT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hMAGIbteCvVl; Tue, 14 Mar 2023 07:58:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8322C60FF6;
	Tue, 14 Mar 2023 07:58:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8322C60FF6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 516D9C0035;
	Tue, 14 Mar 2023 07:58:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3C84C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 07:58:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 945AB4012D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 07:58:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 945AB4012D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MwwRA+AT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id esD4PaNN1GR0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 07:58:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D26CC4011F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D26CC4011F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 07:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678780715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bcu9yEm9wxqLqtY8UAaPzlgo5GuPCx4HMAK28fp2tEg=;
 b=MwwRA+ATkcZWUlq5PM/6/fyDRc8PhlYMH8TvweuK5CcDEpDOIWqFmFHXIHfK97JCE8ZY13
 DQKd4pW0PEA/+lU/0OwBxlQWLgI6+1mdEAHYYZEFEaOfAx9Bqk5qZPDXnZez5vnXKX7t/g
 uVRpx+eDIpYlIBFLtDPTvEb55IDzkIw=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-XVZELMdWMaaR6w1peRtZ4A-1; Tue, 14 Mar 2023 03:58:34 -0400
X-MC-Unique: XVZELMdWMaaR6w1peRtZ4A-1
Received: by mail-oo1-f70.google.com with SMTP id
 d201-20020a4a52d2000000b0051faef7ba52so4050558oob.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 00:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678780714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bcu9yEm9wxqLqtY8UAaPzlgo5GuPCx4HMAK28fp2tEg=;
 b=cYZf1VXTG7u+CoThxMKXE0cHOAt9S2A69WQajV08iYIMs7MZkxWEMYtwlbPQWXOueT
 jwue1jYL96Mio5e8Q01LcVYiTC/wudUiEc7MzaNODgG5+WPAvdiOBsHMZFdD9XKkeBnF
 bRBYfJ8I9sHrjDXQSMzk+Rjy+Fc0voT2+gyvrEsyezDVYU3S1Z/Cu5fzfk7jTrQy7HB4
 u/7GB+UxH/6r7Ld98JCqDaqPC1p1+/mHKiyc4zTnUEzVd0FyIGpU+mwz0lwoj6WF3lhy
 ow5k6+34Fbs/yftun2B9F9Lure2XUlAXZwqEub1Li1aBSRF5/AEDqz3TTW8VRSSQRiZE
 JhNg==
X-Gm-Message-State: AO0yUKWqQ+WRg4/VJUD03PjB6SDMo7YzYl9YnOmnL2dAXTAwyW2HJkna
 hbamRM2w/kphlUBH/Oz3dTNB7Hec5hpV1h6g6VMQLOvdLtHkzu5038EAiji+aQy8TEJVIzmTfjL
 Ve5QKncybIn0+JGH+ZudHnC8TguKea3AbRgpsR/s5EEVl/iO27uWqSDgNXA==
X-Received: by 2002:a05:6830:6505:b0:694:3b4e:d8d7 with SMTP id
 cm5-20020a056830650500b006943b4ed8d7mr4958336otb.0.1678780714057; 
 Tue, 14 Mar 2023 00:58:34 -0700 (PDT)
X-Google-Smtp-Source: AK7set/f2oXQRZCWePw/RpEfhcgB7slAbUng/qvzuQS/APV+AaprME85fe/C67PpoXbNkCDa0KyJN1L1AfOOFVubWmo=
X-Received: by 2002:a05:6830:6505:b0:694:3b4e:d8d7 with SMTP id
 cm5-20020a056830650500b006943b4ed8d7mr4958332otb.0.1678780713834; Tue, 14 Mar
 2023 00:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230308064443.50639-1-xuanzhuo@linux.alibaba.com>
 <20230308064443.50639-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230308064443.50639-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Mar 2023 15:58:22 +0800
Message-ID: <CACGkMEvh2Hxym5Xo_nwzHYa-0chNnM82FcuzRK_TXUy5K5s3rg@mail.gmail.com>
Subject: Re: [PATCH vhost v2 08/12] virtio_ring: update document for
 virtqueue_add_*
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

T24gV2VkLCBNYXIgOCwgMjAyMyBhdCAyOjQ04oCvUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4KPiBVcGRhdGUgdGhlIGRvY3VtZW50IG9mIHZpcnRxdWV1
ZV9hZGRfKiBzZXJpZXMgQVBJLCBhbGxvd2luZyB0aGUgY2FsbGVycyB0bwo+IHVzZSBzZy0+ZG1h
X2FkZHJlc3MgdG8gcGFzcyB0aGUgZG1hIGFkZHJlc3MgdG8gVmlydGlvIENvcmUuCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IC0tLQo+
ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMTYgKysrKysrKysrKysrKysrKwo+ICAx
IGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5k
ZXggYjIzZDMwMWVmZmI1Li4yMTZhYzg2NTQ5ODIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBA
QCAtMjE5MCw2ICsyMTkwLDEwIEBAIHN0YXRpYyBpbmxpbmUgaW50IHZpcnRxdWV1ZV9hZGQoc3Ry
dWN0IHZpcnRxdWV1ZSAqX3ZxLAo+ICAgKiBDYWxsZXIgbXVzdCBlbnN1cmUgd2UgZG9uJ3QgY2Fs
bCB0aGlzIHdpdGggb3RoZXIgdmlydHF1ZXVlIG9wZXJhdGlvbnMKPiAgICogYXQgdGhlIHNhbWUg
dGltZSAoZXhjZXB0IHdoZXJlIG5vdGVkKS4KPiAgICoKPiArICogSWYgdGhlIGNhbGxlciBoYXMg
ZG9uZSBkbWEgbWFwIHRoZW4gdXNlIHNnLT5kbWFfYWRkcmVzcyB0byBwYXNzIGRtYSBhZGRyZXNz
Lgo+ICsgKiBJZiBvbmUgc2ctPmRtYV9hZGRyZXNzIGlzIHVzZWQsIHRoZW4gYWxsIHNncyBtdXN0
IHVzZSBzZy0+ZG1hX2FkZHJlc3M7Cj4gKyAqIG90aGVyd2lzZSBhbGwgc2ctPmRtYV9hZGRyZXNz
IG11c3QgYmUgTlVMTC4KCklzIGl0IHdvcnRoIGFkZGluZyBjaGVja3MgZm9yIHRob3NlIHJlcXVp
cmVtZW50cz8KClRoYW5rcwoKPiArICoKPiAgICogUmV0dXJucyB6ZXJvIG9yIGEgbmVnYXRpdmUg
ZXJyb3IgKGllLiBFTk9TUEMsIEVOT01FTSwgRUlPKS4KPiAgICovCj4gIGludCB2aXJ0cXVldWVf
YWRkX3NncyhzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gQEAgLTIyMjQsNiArMjIyOCwxMCBAQCBF
WFBPUlRfU1lNQk9MX0dQTCh2aXJ0cXVldWVfYWRkX3Nncyk7Cj4gICAqIENhbGxlciBtdXN0IGVu
c3VyZSB3ZSBkb24ndCBjYWxsIHRoaXMgd2l0aCBvdGhlciB2aXJ0cXVldWUgb3BlcmF0aW9ucwo+
ICAgKiBhdCB0aGUgc2FtZSB0aW1lIChleGNlcHQgd2hlcmUgbm90ZWQpLgo+ICAgKgo+ICsgKiBJ
ZiB0aGUgY2FsbGVyIGhhcyBkb25lIGRtYSBtYXAgdGhlbiB1c2Ugc2ctPmRtYV9hZGRyZXNzIHRv
IHBhc3MgZG1hIGFkZHJlc3MuCj4gKyAqIElmIG9uZSBzZy0+ZG1hX2FkZHJlc3MgaXMgdXNlZCwg
dGhlbiBhbGwgc2dzIG11c3QgdXNlIHNnLT5kbWFfYWRkcmVzczsKPiArICogb3RoZXJ3aXNlIGFs
bCBzZy0+ZG1hX2FkZHJlc3MgbXVzdCBiZSBOVUxMLgo+ICsgKgo+ICAgKiBSZXR1cm5zIHplcm8g
b3IgYSBuZWdhdGl2ZSBlcnJvciAoaWUuIEVOT1NQQywgRU5PTUVNLCBFSU8pLgo+ICAgKi8KPiAg
aW50IHZpcnRxdWV1ZV9hZGRfb3V0YnVmKHN0cnVjdCB2aXJ0cXVldWUgKnZxLAo+IEBAIC0yMjQ2
LDYgKzIyNTQsMTAgQEAgRVhQT1JUX1NZTUJPTF9HUEwodmlydHF1ZXVlX2FkZF9vdXRidWYpOwo+
ICAgKiBDYWxsZXIgbXVzdCBlbnN1cmUgd2UgZG9uJ3QgY2FsbCB0aGlzIHdpdGggb3RoZXIgdmly
dHF1ZXVlIG9wZXJhdGlvbnMKPiAgICogYXQgdGhlIHNhbWUgdGltZSAoZXhjZXB0IHdoZXJlIG5v
dGVkKS4KPiAgICoKPiArICogSWYgdGhlIGNhbGxlciBoYXMgZG9uZSBkbWEgbWFwIHRoZW4gdXNl
IHNnLT5kbWFfYWRkcmVzcyB0byBwYXNzIGRtYSBhZGRyZXNzLgo+ICsgKiBJZiBvbmUgc2ctPmRt
YV9hZGRyZXNzIGlzIHVzZWQsIHRoZW4gYWxsIHNncyBtdXN0IHVzZSBzZy0+ZG1hX2FkZHJlc3M7
Cj4gKyAqIG90aGVyd2lzZSBhbGwgc2ctPmRtYV9hZGRyZXNzIG11c3QgYmUgTlVMTC4KPiArICoK
PiAgICogUmV0dXJucyB6ZXJvIG9yIGEgbmVnYXRpdmUgZXJyb3IgKGllLiBFTk9TUEMsIEVOT01F
TSwgRUlPKS4KPiAgICovCj4gIGludCB2aXJ0cXVldWVfYWRkX2luYnVmKHN0cnVjdCB2aXJ0cXVl
dWUgKnZxLAo+IEBAIC0yMjY5LDYgKzIyODEsMTAgQEAgRVhQT1JUX1NZTUJPTF9HUEwodmlydHF1
ZXVlX2FkZF9pbmJ1Zik7Cj4gICAqIENhbGxlciBtdXN0IGVuc3VyZSB3ZSBkb24ndCBjYWxsIHRo
aXMgd2l0aCBvdGhlciB2aXJ0cXVldWUgb3BlcmF0aW9ucwo+ICAgKiBhdCB0aGUgc2FtZSB0aW1l
IChleGNlcHQgd2hlcmUgbm90ZWQpLgo+ICAgKgo+ICsgKiBJZiB0aGUgY2FsbGVyIGhhcyBkb25l
IGRtYSBtYXAgdGhlbiB1c2Ugc2ctPmRtYV9hZGRyZXNzIHRvIHBhc3MgZG1hIGFkZHJlc3MuCj4g
KyAqIElmIG9uZSBzZy0+ZG1hX2FkZHJlc3MgaXMgdXNlZCwgdGhlbiBhbGwgc2dzIG11c3QgdXNl
IHNnLT5kbWFfYWRkcmVzczsKPiArICogb3RoZXJ3aXNlIGFsbCBzZy0+ZG1hX2FkZHJlc3MgbXVz
dCBiZSBOVUxMLgo+ICsgKgo+ICAgKiBSZXR1cm5zIHplcm8gb3IgYSBuZWdhdGl2ZSBlcnJvciAo
aWUuIEVOT1NQQywgRU5PTUVNLCBFSU8pLgo+ICAgKi8KPiAgaW50IHZpcnRxdWV1ZV9hZGRfaW5i
dWZfY3R4KHN0cnVjdCB2aXJ0cXVldWUgKnZxLAo+IC0tCj4gMi4zMi4wLjMuZzAxMTk1Y2Y5Zgo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=

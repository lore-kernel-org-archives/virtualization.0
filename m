Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0FBC61DA4
	for <virtualization@archiver.kernel.org>; Wed, 15 Feb 2023 02:00:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F44F81E61;
	Wed, 15 Feb 2023 02:00:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2F44F81E61
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d9KHA5Yd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C8QKgpj4b1AV; Wed, 15 Feb 2023 02:00:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ABF1D81E37;
	Wed, 15 Feb 2023 02:00:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ABF1D81E37
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63BCAC0032;
	Wed, 15 Feb 2023 02:00:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15D93C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 02:00:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DE92660BD3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 02:00:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DE92660BD3
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=d9KHA5Yd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lLIqRcds16NA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 02:00:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 07AFE60BBF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 07AFE60BBF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 02:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676426445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1jbzmLQHVv2tkOdLBbVZkdyTHtnIEvKSkdpfnMaOErA=;
 b=d9KHA5YdytIADEYu2bDRV4dLymIHBdYhg/2LsL3Quc1+2bodIqMqPNFL4VINC9M91Qwep6
 G681O3Zmh9el3l1Rm+gFw3gOaBW72c3RoCmKfesFizGiMdGvpCRorxY4s+hufXqwzTCpMq
 28NairRBREvT2psKj2vnJlkh32VaHVI=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-270-EGOWB30LMI6J0VRKHCHFWQ-1; Tue, 14 Feb 2023 21:00:44 -0500
X-MC-Unique: EGOWB30LMI6J0VRKHCHFWQ-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-16e46afe0b9so698913fac.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 18:00:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1jbzmLQHVv2tkOdLBbVZkdyTHtnIEvKSkdpfnMaOErA=;
 b=lWeyF7dZovnlNe4IvKdDBRrnuam70HNYsJZJR/x9hsMTdjhKnRR5A8UqmsALud/Sfp
 dYm/IEw5ODEa5lL3pMei55lxnLBIWnU8UMvr3LjERr7+YIa9GClomJGmyTZfqmEWSkr+
 AeLynu9BYNyGHNqgYO/rBUowe9QuURLkOHOHSAVV1ufOghf1hhXq/L1uU9Tqp/fq/Rqv
 wcrP6aQxEGjiRk9Z92CL3j3BY+q6v+oX5uKmj+oN/J8zxPIV54NDcWOFuC08rywcheuj
 txQZrRpik9UhjIAq08qJ7K1BzLu0qh93+vA0sbkM1N7Kjjew2pLwTqRKpmrFmAR+AZHh
 lVfA==
X-Gm-Message-State: AO0yUKWbwI0O2PCQVLrfr1Mz0FNiNOmhwQfTZdwLDXo2BQLV//XDYHml
 8C2i7g5AuTvW1Oo8iHrYjrNYLFnoPKQWGIArCbQxXiGwpVpvgtmGmw0cUV7nz5na0JvsHgLWWSA
 0DPJOb4IySlrkjptTxW2gyj6wX/ixW+K+A9d3ouVUZ6E/QcEJbG95ryDjzg==
X-Received: by 2002:aca:1119:0:b0:37d:5d77:e444 with SMTP id
 25-20020aca1119000000b0037d5d77e444mr93980oir.35.1676426443506; 
 Tue, 14 Feb 2023 18:00:43 -0800 (PST)
X-Google-Smtp-Source: AK7set/qjD0jsbngTzW6Ai6mzSW3H5nHco+/NJVQUkWR/xFc2QQvufuo+qETx3tdntuJ7uWec6Z8ZZrWeFqRJJKM0O0=
X-Received: by 2002:aca:1119:0:b0:37d:5d77:e444 with SMTP id
 25-20020aca1119000000b0037d5d77e444mr93974oir.35.1676426443204; Tue, 14 Feb
 2023 18:00:43 -0800 (PST)
MIME-Version: 1.0
References: <20230131145310.2069-1-longpeng2@huawei.com>
 <db99245c-606a-2f24-52fe-836a6972437f@redhat.com>
 <35b94992-0c6b-a190-1fce-5dda9c8dcf4b@huawei.com>
In-Reply-To: <35b94992-0c6b-a190-1fce-5dda9c8dcf4b@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Feb 2023 10:00:32 +0800
Message-ID: <CACGkMEt0Rgkcmt9k4dWsp-qqtPvrM40mtgmSERc0A7Ve1wzKHw@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: cleanup memory maps when closing vdpa fds
To: "Longpeng (Mike,
 Cloud Infrastructure Service Product Dept.)" <longpeng2@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org,
 yechuan@huawei.com, huangzhichao@huawei.com,
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

T24gVHVlLCBGZWIgMTQsIDIwMjMgYXQgMjoyOCBQTSBMb25ncGVuZyAoTWlrZSwgQ2xvdWQgSW5m
cmFzdHJ1Y3R1cmUKU2VydmljZSBQcm9kdWN0IERlcHQuKSA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+
IHdyb3RlOgo+Cj4KPgo+IOWcqCAyMDIzLzIvMTQgMTQ6MTYsIEphc29uIFdhbmcg5YaZ6YGTOgo+
ID4KPiA+IOWcqCAyMDIzLzEvMzEgMjI6NTMsIExvbmdwZW5nKE1pa2UpIOWGmemBkzoKPiA+PiBG
cm9tOiBMb25ncGVuZyA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+Cj4gPj4KPiA+PiBXZSBtdXN0IGNs
ZWFudXAgYWxsIG1lbW9yeSBtYXBzIHdoZW4gY2xvc2luZyB0aGUgdmRwYSBmZHMsIG90aGVyd2lz
ZQo+ID4+IHNvbWUgY3JpdGljYWwgcmVzb3VyY2VzIChlLmcuIG1lbW9yeSwgaW9tbXUgbWFwKSB3
aWxsIGxlYWtlZCBpZiB0aGUKPiA+PiB1c2Vyc3BhY2UgZXhpdHMgdW5leHBlY3RlZGx5IChlLmcu
IGtpbGwgLTkpLgo+ID4KPiA+Cj4gPiBTb3VuZHMgbGlrZSBhIGJ1ZyBvZiB0aGUga2VybmVsLCBz
aG91bGQgd2UgZml4IHRoZXJlPwo+ID4KPgo+IEZvciBleGFtcGxlLCB0aGUgaW9tbXUgbWFwIGlz
IHNldHVwIHdoZW4gUUVNVSBjYWxscyBWSE9TVF9JT1RMQl9VUERBVEUKPiBpb2N0bCBhbmQgaXQn
bGwgYmUgZnJlZWQgaWYgUUVNVSBjYWxscyBWSE9TVF9JT1RMQl9JTlZBTElEQVRFIGlvY3RsLgo+
Cj4gU28gbWF5YmUgd2UgcmVsZWFzZSB0aGVzZSByZXNvdXJjZXMgaW4gdmRwYSBmcmFtZXdvcmsg
aW4ga2VybmVsIGlzIGEKPiBzdWl0YWJsZSBjaG9pY2U/CgpJIHRoaW5rIEkgbmVlZCB1bmRlcnN0
YW5kIHdoYXQgZG9lcyAicmVzb3VyY2VzIiBtZWFuIGhlcmU6CgpGb3IgaW9tbXUgbWFwcGluZywg
aXQgc2hvdWxkIGJlIGZyZWVkIGJ5IHZob3N0X3ZkcGFfZnJlZV9kb21haW4oKSBpbgp2aG9zdF92
ZHBhX3JlbGVhc2UoKT8KCnN0YXRpYyBpbnQgdmhvc3RfdmRwYV9yZWxlYXNlKHN0cnVjdCBpbm9k
ZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlcCkKewogICAgICAgIHN0cnVjdCB2aG9zdF92ZHBh
ICp2ID0gZmlsZXAtPnByaXZhdGVfZGF0YTsKICAgICAgICBzdHJ1Y3Qgdmhvc3RfZGV2ICpkID0g
JnYtPnZkZXY7CgogICAgICAgIG11dGV4X2xvY2soJmQtPm11dGV4KTsKICAgICAgICBmaWxlcC0+
cHJpdmF0ZV9kYXRhID0gTlVMTDsKICAgICAgICB2aG9zdF92ZHBhX2NsZWFuX2lycSh2KTsKICAg
ICAgICB2aG9zdF92ZHBhX3Jlc2V0KHYpOwogICAgICAgIHZob3N0X2Rldl9zdG9wKCZ2LT52ZGV2
KTsKICAgICAgICB2aG9zdF92ZHBhX2ZyZWVfZG9tYWluKHYpOwogICAgICAgIHZob3N0X3ZkcGFf
Y29uZmlnX3B1dCh2KTsKICAgICAgICB2aG9zdF92ZHBhX2NsZWFudXAodik7CiAgICAgICAgbXV0
ZXhfdW5sb2NrKCZkLT5tdXRleCk7CgogICAgICAgIGF0b21pY19kZWMoJnYtPm9wZW5lZCk7CiAg
ICAgICAgY29tcGxldGUoJnYtPmNvbXBsZXRpb24pOwoKICAgICAgICByZXR1cm4gMDsKfQoKPgo+
IEJ5IHRoZSB3YXksIEphc29uLCBjYW4geW91IHJlcHJvZHVjZSB0aGUgcHJvYmxlbSBpbiB5b3Vy
IG1hY2hpbmU/Cj4KCkhhdmVuJ3QgZ290IHRpbWUgaW4gZG9pbmcgdGhpcyBidXQgaXQgc2hvdWxk
IGJlIHRoZSByZXNwb25zaWJpbGl0eSBvZgp0aGUgYXV0aG9yIHRvIHZhbGlkYXRlIHRoaXMgYW55
aG93LgoKVGhhbmtzCgo+ID4gVGhhbmtzCj4gPgo+ID4KPiA+Pgo+ID4+IFNpZ25lZC1vZmYtYnk6
IExvbmdwZW5nIDxsb25ncGVuZzJAaHVhd2VpLmNvbT4KPiA+PiAtLS0KPiA+PiAgIGRyaXZlcnMv
dmhvc3QvdmRwYS5jIHwgMTMgKysrKysrKysrKysrKwo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDEz
IGluc2VydGlvbnMoKykKPiA+Pgo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEu
YyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gPj4gaW5kZXggYTUyN2VlZWFjNjM3Li4zNzQ3N2Nm
ZmE1YWEgMTAwNjQ0Cj4gPj4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+PiArKysgYi9k
cml2ZXJzL3Zob3N0L3ZkcGEuYwo+ID4+IEBAIC04MjMsNiArODIzLDE4IEBAIHN0YXRpYyB2b2lk
IHZob3N0X3ZkcGFfdW5tYXAoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4gPj4gICAgICAgICAgIHZo
b3N0X3ZkcGFfcmVtb3ZlX2FzKHYsIGFzaWQpOwo+ID4+ICAgfQo+ID4+ICtzdGF0aWMgdm9pZCB2
aG9zdF92ZHBhX2NsZWFuX21hcChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdikKPiA+PiArewo+ID4+ICsg
ICAgc3RydWN0IHZob3N0X3ZkcGFfYXMgKmFzOwo+ID4+ICsgICAgdTMyIGFzaWQ7Cj4gPj4gKwo+
ID4+ICsgICAgZm9yIChhc2lkID0gMDsgYXNpZCA8IHYtPnZkcGEtPm5hczsgYXNpZCsrKSB7Cj4g
Pj4gKyAgICAgICAgYXMgPSBhc2lkX3RvX2FzKHYsIGFzaWQpOwo+ID4+ICsgICAgICAgIGlmIChh
cykKPiA+PiArICAgICAgICAgICAgdmhvc3RfdmRwYV91bm1hcCh2LCAmYXMtPmlvdGxiLCAwVUxM
LCAwVUxMIC0gMSk7Cj4gPj4gKyAgICB9Cj4gPj4gK30KPiA+PiArCj4gPj4gICBzdGF0aWMgaW50
IHZob3N0X3ZkcGFfdmFfbWFwKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+ID4+ICAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiLAo+ID4+ICAgICAgICAgICAgICAgICAg
ICB1NjQgaW92YSwgdTY0IHNpemUsIHU2NCB1YWRkciwgdTMyIHBlcm0pCj4gPj4gQEAgLTEyNDcs
NiArMTI1OSw3IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9yZWxlYXNlKHN0cnVjdCBpbm9kZQo+
ID4+ICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGVwKQo+ID4+ICAgICAgIHZob3N0X3ZkcGFfY2xl
YW5faXJxKHYpOwo+ID4+ICAgICAgIHZob3N0X3ZkcGFfcmVzZXQodik7Cj4gPj4gICAgICAgdmhv
c3RfZGV2X3N0b3AoJnYtPnZkZXYpOwo+ID4+ICsgICAgdmhvc3RfdmRwYV9jbGVhbl9tYXAodik7
Cj4gPj4gICAgICAgdmhvc3RfdmRwYV9mcmVlX2RvbWFpbih2KTsKPiA+PiAgICAgICB2aG9zdF92
ZHBhX2NvbmZpZ19wdXQodik7Cj4gPj4gICAgICAgdmhvc3RfdmRwYV9jbGVhbnVwKHYpOwo+ID4K
PiA+IC4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u

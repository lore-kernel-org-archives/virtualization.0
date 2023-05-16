Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152CBC77B7D
	for <virtualization@archiver.kernel.org>; Tue, 16 May 2023 03:30:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B427540489;
	Tue, 16 May 2023 03:30:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B427540489
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AFSggo7f
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SMQFUPx5r8S7; Tue, 16 May 2023 03:30:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2B15240BCB;
	Tue, 16 May 2023 03:30:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2B15240BCB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04684C0036;
	Tue, 16 May 2023 03:30:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 885CFC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 03:30:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 55B4F40BCB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 03:30:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 55B4F40BCB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0E1T3JIB6yYU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 03:30:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 830E940489
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 830E940489
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 03:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684207829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=loCDtii2bD6W+7H3uoSjkUTPrHhjUmw5luEGcHFUSck=;
 b=AFSggo7ff7q6s/mez2nCA0SQ1GzvLdbt3icaWa9MyVrq/LlrQlBLEKLsPAnnhfwqYJNraU
 CiDvnlwjmN/vxrrkZ15Pfw96Sw+UFKpwINKqAsTP53IOaKpd52EqNRsP5F3fOOQvam6H4e
 C4Jkk6If/fleWSHdaZNY99n54RwBxBU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-CdSQkJqsPgaEkHY-qz9sww-1; Mon, 15 May 2023 23:30:28 -0400
X-MC-Unique: CdSQkJqsPgaEkHY-qz9sww-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ac8165cad0so62116291fa.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 20:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684207826; x=1686799826;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=loCDtii2bD6W+7H3uoSjkUTPrHhjUmw5luEGcHFUSck=;
 b=Mfgmhef5jeb+oLNSa10VWinracUSUdG3uEMbOTt96Kg0R60zp8FcwvjLkfV+hR7fBQ
 KhkMl1E+gZIbQZ9qSyOm+3WWrr5c5/yQ7h6NYm5JbVb7Bxmn7zyw2kiRMEfcoP/9Q4Td
 O/3GO+8xJRnOP1EyYpDwj19Ats/RBC0dNo0tU6lgyXhmKwR/tlCesYmwysIudorm8Cf5
 qhGFDeN3+LnBW+dN9orrfeAcKJUFdrHHjbwS/deRKsTD1s3VZub2iTXsoY6249X3NDNC
 z44BWwSpJv4aVPAp2J/aXN/KxzBxOc1fpV7iS8JB0UABtl6J7NHWskyRTh+O4edt0VvP
 YV5g==
X-Gm-Message-State: AC+VfDyVkVBMgvEGHq41EdZJBtozWZjcIJjg6Vg3jdVzM7SELvJoRzgi
 jkBTjJDMV0rfs/sSqv+5CVQgdbEDFc225K1Uw9JGL5p6lrWMk1Kr3ylxaYQhBQu2aIemAyNWqYM
 7CfDLxIzT4mFtr//mjRBvr5UI36FmeM+F+aTCkBRZww9iXTR654yVmcl8VA==
X-Received: by 2002:a2e:9056:0:b0:2a8:bf35:3b7 with SMTP id
 n22-20020a2e9056000000b002a8bf3503b7mr6811380ljg.32.1684207826587; 
 Mon, 15 May 2023 20:30:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4dDZ4FoJXEw1j0re42ZJYNkrhcBjKfMPdneRRgN+p8lYpgxJmGRVuPHHIR+gxAFYi6xntauA4fDv5VQGuO52U=
X-Received: by 2002:a2e:9056:0:b0:2a8:bf35:3b7 with SMTP id
 n22-20020a2e9056000000b002a8bf3503b7mr6811371ljg.32.1684207826407; Mon, 15
 May 2023 20:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230516025521.43352-1-shannon.nelson@amd.com>
 <20230516025521.43352-11-shannon.nelson@amd.com>
In-Reply-To: <20230516025521.43352-11-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 May 2023 11:30:15 +0800
Message-ID: <CACGkMEv6CtrOQPTVaH6ngGLKyxBarwQMAhRiq0Z9QWnOz4Yx4g@mail.gmail.com>
Subject: Re: [PATCH v6 virtio 10/11] pds_vdpa: subscribe to the pds_core events
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: brett.creeley@amd.com, mst@redhat.com, simon.horman@corigine.com,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 drivers@pensando.io
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

T24gVHVlLCBNYXkgMTYsIDIwMjMgYXQgMTA6NTbigK9BTSBTaGFubm9uIE5lbHNvbiA8c2hhbm5v
bi5uZWxzb25AYW1kLmNvbT4gd3JvdGU6Cj4KPiBSZWdpc3RlciBmb3IgdGhlIHBkc19jb3JlJ3Mg
bm90aWZpY2F0aW9uIGV2ZW50cywgcHJpbWFyaWx5IHRvCj4gZmluZCBvdXQgd2hlbiB0aGUgRlcg
aGFzIGJlZW4gcmVzZXQgc28gd2UgY2FuIHBhc3MgdGhpcyBvbgo+IGJhY2sgdXAgdGhlIGNoYWlu
Lgo+Cj4gU2lnbmVkLW9mZi1ieTogU2hhbm5vbiBOZWxzb24gPHNoYW5ub24ubmVsc29uQGFtZC5j
b20+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoK
PiAtLS0KPiAgZHJpdmVycy92ZHBhL3Bkcy92ZHBhX2Rldi5jIHwgNTkgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLQo+ICBkcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmggfCAg
MSArCj4gIDIgZmlsZXMgY2hhbmdlZCwgNTkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9wZHMvdmRwYV9kZXYuYyBiL2RyaXZlcnMvdmRw
YS9wZHMvdmRwYV9kZXYuYwo+IGluZGV4IDA3Yjk4ZGZmNTcwMS4uOWFmYTgwM2M0ZjIxIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9wZHMvdmRwYV9kZXYuYwo+ICsrKyBiL2RyaXZlcnMvdmRw
YS9wZHMvdmRwYV9kZXYuYwo+IEBAIC0yMyw2ICsyMyw1MiBAQCBzdGF0aWMgc3RydWN0IHBkc192
ZHBhX2RldmljZSAqdmRwYV90b19wZHN2KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYpCj4g
ICAgICAgICByZXR1cm4gY29udGFpbmVyX29mKHZkcGFfZGV2LCBzdHJ1Y3QgcGRzX3ZkcGFfZGV2
aWNlLCB2ZHBhX2Rldik7Cj4gIH0KPgo+ICtzdGF0aWMgaW50IHBkc192ZHBhX25vdGlmeV9oYW5k
bGVyKHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIsCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB1bnNpZ25lZCBsb25nIGVjb2RlLAo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdm9pZCAqZGF0YSkKPiArewo+ICsgICAgICAgc3RydWN0IHBkc192ZHBhX2Rl
dmljZSAqcGRzdiA9IGNvbnRhaW5lcl9vZihuYiwgc3RydWN0IHBkc192ZHBhX2RldmljZSwgbmIp
Owo+ICsgICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gJnBkc3YtPnZkcGFfYXV4LT5wYWRldi0+
YXV4X2Rldi5kZXY7Cj4gKwo+ICsgICAgICAgZGV2X2RiZyhkZXYsICIlczogZXZlbnQgY29kZSAl
bHVcbiIsIF9fZnVuY19fLCBlY29kZSk7Cj4gKwo+ICsgICAgICAgaWYgKGVjb2RlID09IFBEU19F
VkVOVF9SRVNFVCB8fCBlY29kZSA9PSBQRFNfRVZFTlRfTElOS19DSEFOR0UpIHsKPiArICAgICAg
ICAgICAgICAgaWYgKHBkc3YtPmNvbmZpZ19jYi5jYWxsYmFjaykKPiArICAgICAgICAgICAgICAg
ICAgICAgICBwZHN2LT5jb25maWdfY2IuY2FsbGJhY2socGRzdi0+Y29uZmlnX2NiLnByaXZhdGUp
Owo+ICsgICAgICAgfQo+ICsKPiArICAgICAgIHJldHVybiAwOwo+ICt9Cj4gKwo+ICtzdGF0aWMg
aW50IHBkc192ZHBhX3JlZ2lzdGVyX2V2ZW50X2hhbmRsZXIoc3RydWN0IHBkc192ZHBhX2Rldmlj
ZSAqcGRzdikKPiArewo+ICsgICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gJnBkc3YtPnZkcGFf
YXV4LT5wYWRldi0+YXV4X2Rldi5kZXY7Cj4gKyAgICAgICBzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sg
Km5iID0gJnBkc3YtPm5iOwo+ICsgICAgICAgaW50IGVycjsKPiArCj4gKyAgICAgICBpZiAoIW5i
LT5ub3RpZmllcl9jYWxsKSB7Cj4gKyAgICAgICAgICAgICAgIG5iLT5ub3RpZmllcl9jYWxsID0g
cGRzX3ZkcGFfbm90aWZ5X2hhbmRsZXI7Cj4gKyAgICAgICAgICAgICAgIGVyciA9IHBkc2NfcmVn
aXN0ZXJfbm90aWZ5KG5iKTsKPiArICAgICAgICAgICAgICAgaWYgKGVycikgewo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIG5iLT5ub3RpZmllcl9jYWxsID0gTlVMTDsKPiArICAgICAgICAgICAg
ICAgICAgICAgICBkZXZfZXJyKGRldiwgImZhaWxlZCB0byByZWdpc3RlciBwZHMgZXZlbnQgaGFu
ZGxlcjogJXBzXG4iLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRVJSX1BUUihl
cnIpKTsKPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiArICAgICAg
ICAgICAgICAgfQo+ICsgICAgICAgICAgICAgICBkZXZfZGJnKGRldiwgInBkcyBldmVudCBoYW5k
bGVyIHJlZ2lzdGVyZWRcbiIpOwo+ICsgICAgICAgfQo+ICsKPiArICAgICAgIHJldHVybiAwOwo+
ICt9Cj4gKwo+ICtzdGF0aWMgdm9pZCBwZHNfdmRwYV91bnJlZ2lzdGVyX2V2ZW50X2hhbmRsZXIo
c3RydWN0IHBkc192ZHBhX2RldmljZSAqcGRzdikKPiArewo+ICsgICAgICAgaWYgKHBkc3YtPm5i
Lm5vdGlmaWVyX2NhbGwpIHsKPiArICAgICAgICAgICAgICAgcGRzY191bnJlZ2lzdGVyX25vdGlm
eSgmcGRzdi0+bmIpOwo+ICsgICAgICAgICAgICAgICBwZHN2LT5uYi5ub3RpZmllcl9jYWxsID0g
TlVMTDsKPiArICAgICAgIH0KPiArfQo+ICsKPiAgc3RhdGljIGludCBwZHNfdmRwYV9zZXRfdnFf
YWRkcmVzcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2LCB1MTYgcWlkLAo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdTY0IGRlc2NfYWRkciwgdTY0IGRyaXZlcl9hZGRy
LCB1NjQgZGV2aWNlX2FkZHIpCj4gIHsKPiBAQCAtNTk0LDYgKzY0MCwxMiBAQCBzdGF0aWMgaW50
IHBkc192ZHBhX2Rldl9hZGQoc3RydWN0IHZkcGFfbWdtdF9kZXYgKm1kZXYsIGNvbnN0IGNoYXIg
Km5hbWUsCj4KPiAgICAgICAgIHBkc3YtPnZkcGFfZGV2Lm1kZXYgPSAmdmRwYV9hdXgtPnZkcGFf
bWRldjsKPgo+ICsgICAgICAgZXJyID0gcGRzX3ZkcGFfcmVnaXN0ZXJfZXZlbnRfaGFuZGxlcihw
ZHN2KTsKPiArICAgICAgIGlmIChlcnIpIHsKPiArICAgICAgICAgICAgICAgZGV2X2VycihkZXYs
ICJGYWlsZWQgdG8gcmVnaXN0ZXIgZm9yIFBEUyBldmVudHM6ICVwZVxuIiwgRVJSX1BUUihlcnIp
KTsKPiArICAgICAgICAgICAgICAgZ290byBlcnJfdW5tYXA7Cj4gKyAgICAgICB9Cj4gKwo+ICAg
ICAgICAgLyogV2UgdXNlIHRoZSBfdmRwYV9yZWdpc3Rlcl9kZXZpY2UoKSBjYWxsIHJhdGhlciB0
aGFuIHRoZQo+ICAgICAgICAgICogdmRwYV9yZWdpc3Rlcl9kZXZpY2UoKSB0byBhdm9pZCBhIGRl
YWRsb2NrIGJlY2F1c2Ugb3VyCj4gICAgICAgICAgKiBkZXZfYWRkKCkgaXMgY2FsbGVkIHdpdGgg
dGhlIHZkcGFfZGV2X2xvY2sgYWxyZWFkeSBzZXQKPiBAQCAtNjAyLDEzICs2NTQsMTUgQEAgc3Rh
dGljIGludCBwZHNfdmRwYV9kZXZfYWRkKHN0cnVjdCB2ZHBhX21nbXRfZGV2ICptZGV2LCBjb25z
dCBjaGFyICpuYW1lLAo+ICAgICAgICAgZXJyID0gX3ZkcGFfcmVnaXN0ZXJfZGV2aWNlKCZwZHN2
LT52ZHBhX2RldiwgcGRzdi0+bnVtX3Zxcyk7Cj4gICAgICAgICBpZiAoZXJyKSB7Cj4gICAgICAg
ICAgICAgICAgIGRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIHJlZ2lzdGVyIHRvIHZEUEEgYnVzOiAl
cGVcbiIsIEVSUl9QVFIoZXJyKSk7Cj4gLSAgICAgICAgICAgICAgIGdvdG8gZXJyX3VubWFwOwo+
ICsgICAgICAgICAgICAgICBnb3RvIGVycl91bmV2ZW50Owo+ICAgICAgICAgfQo+Cj4gICAgICAg
ICBwZHNfdmRwYV9kZWJ1Z2ZzX2FkZF92ZHBhZGV2KHZkcGFfYXV4KTsKPgo+ICAgICAgICAgcmV0
dXJuIDA7Cj4KPiArZXJyX3VuZXZlbnQ6Cj4gKyAgICAgICBwZHNfdmRwYV91bnJlZ2lzdGVyX2V2
ZW50X2hhbmRsZXIocGRzdik7Cj4gIGVycl91bm1hcDoKPiAgICAgICAgIHB1dF9kZXZpY2UoJnBk
c3YtPnZkcGFfZGV2LmRldik7Cj4gICAgICAgICB2ZHBhX2F1eC0+cGRzdiA9IE5VTEw7Cj4gQEAg
LTYxOCw4ICs2NzIsMTEgQEAgc3RhdGljIGludCBwZHNfdmRwYV9kZXZfYWRkKHN0cnVjdCB2ZHBh
X21nbXRfZGV2ICptZGV2LCBjb25zdCBjaGFyICpuYW1lLAo+ICBzdGF0aWMgdm9pZCBwZHNfdmRw
YV9kZXZfZGVsKHN0cnVjdCB2ZHBhX21nbXRfZGV2ICptZGV2LAo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldikKPiAgewo+ICsgICAgICAg
c3RydWN0IHBkc192ZHBhX2RldmljZSAqcGRzdiA9IHZkcGFfdG9fcGRzdih2ZHBhX2Rldik7Cj4g
ICAgICAgICBzdHJ1Y3QgcGRzX3ZkcGFfYXV4ICp2ZHBhX2F1eDsKPgo+ICsgICAgICAgcGRzX3Zk
cGFfdW5yZWdpc3Rlcl9ldmVudF9oYW5kbGVyKHBkc3YpOwo+ICsKPiAgICAgICAgIHZkcGFfYXV4
ID0gY29udGFpbmVyX29mKG1kZXYsIHN0cnVjdCBwZHNfdmRwYV9hdXgsIHZkcGFfbWRldik7Cj4g
ICAgICAgICBfdmRwYV91bnJlZ2lzdGVyX2RldmljZSh2ZHBhX2Rldik7Cj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92ZHBhL3Bkcy92ZHBhX2Rldi5oIGIvZHJpdmVycy92ZHBhL3Bkcy92ZHBhX2Rl
di5oCj4gaW5kZXggMjVjMWQxOTJmMGVmLi5hMWJjMzdkZTk1MzcgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy92ZHBhL3Bkcy92ZHBhX2Rldi5oCj4gKysrIGIvZHJpdmVycy92ZHBhL3Bkcy92ZHBhX2Rl
di5oCj4gQEAgLTQwLDYgKzQwLDcgQEAgc3RydWN0IHBkc192ZHBhX2RldmljZSB7Cj4gICAgICAg
ICB1OCB2ZHBhX2luZGV4OyAgICAgICAgICAgICAgICAgIC8qIHJzdmQgZm9yIGZ1dHVyZSBzdWJk
ZXZpY2UgdXNlICovCj4gICAgICAgICB1OCBudW1fdnFzOyAgICAgICAgICAgICAgICAgICAgIC8q
IG51bSB2cXMgaW4gdXNlICovCj4gICAgICAgICBzdHJ1Y3QgdmRwYV9jYWxsYmFjayBjb25maWdf
Y2I7Cj4gKyAgICAgICBzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgbmI7Cj4gIH07Cj4KPiAgI2RlZmlu
ZSBQRFNfVkRQQV9QQUNLRURfSU5WRVJUX0lEWCAgICAgMHg4MDAwCj4gLS0KPiAyLjE3LjEKPgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u

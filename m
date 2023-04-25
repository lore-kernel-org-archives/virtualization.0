Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1869C77B73
	for <virtualization@archiver.kernel.org>; Tue, 25 Apr 2023 06:02:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 39A6A400CB;
	Tue, 25 Apr 2023 06:02:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 39A6A400CB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KwQMtlm1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zAHqjG2ZijUq; Tue, 25 Apr 2023 06:02:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B41F84016C;
	Tue, 25 Apr 2023 06:02:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B41F84016C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 947A1C0037;
	Tue, 25 Apr 2023 06:02:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19C9DC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 06:02:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D34D160A74
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 06:02:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D34D160A74
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KwQMtlm1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6PhHAJj4CHiU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 06:02:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D0084607A1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D0084607A1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 06:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682402528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YV2nK5HT6aYqlFKCy/XmGOSpQEi6x3KuuhaxH1jgwN8=;
 b=KwQMtlm1595TdupZGZLz0h4CdNmy0oTkWjtdXfvLmJqxWRyT49D2iI7OYJhv4mXaKxjKoi
 ytXpbn4tWgb9cLXLgm6eIzDQEzBhGTq/gCcVWfhMNknRahvBNHwVQCamhx0qmEYpFU2+7t
 1e/5rh8E+gFLFEqkPmvvvBgB0HPo69w=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-E2jzCP0PPu2mXu5KwwZOyA-1; Tue, 25 Apr 2023 02:02:05 -0400
X-MC-Unique: E2jzCP0PPu2mXu5KwwZOyA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4ec81706fc9so2254013e87.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 23:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682402523; x=1684994523;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YV2nK5HT6aYqlFKCy/XmGOSpQEi6x3KuuhaxH1jgwN8=;
 b=NX2vvCtgx/8gnMoQoBczzU9TBTNigV6jHnGXcUJNxy79b4Yv7Ryd77HBLivZBq3UbO
 AbUHumQizGQDTv9fsdJK0tAbuG1myfdSTkyV1LQQIGirEtGk21SJbYXpp3m5hYTkFI4S
 BXroi/7WhQd/voDjmlsYTYfjJF/sMvdtQXegFMpvp9kOwKNEeL8e1fq5BdfhS5Dgeuwl
 LAPIZWnaj0k56tANmWeKJ0qd3NGh5w4+7HIQKDRgXkcPNMhYvkyBc5+ut2DDIAzcN6ET
 UVkGIwNPryK3m4gnikNkLV0z8NVD9lum32uIU0i5H5RechdFyrBQ9fiP1h5cO81UUhAr
 gkZQ==
X-Gm-Message-State: AAQBX9e4Q8oGfK8gzieUZyxnqZCy50Le+oH7LTMuleC9XE/fQ1+ZM+12
 DFHQeD1OohjKcXDAGP1U+FW3YuAD0h/RcqmjBUzzhCr6uElbri053tSRs3oGeQJoN5jWVxUNkMu
 +LtXBT8t6NTwaOwFahx/LR+/ybwYIRCw/s5B3V0q+DEPl2qur5xn1ukIXRg==
X-Received: by 2002:ac2:515a:0:b0:4eb:30f9:eed7 with SMTP id
 q26-20020ac2515a000000b004eb30f9eed7mr4305371lfd.22.1682402523701; 
 Mon, 24 Apr 2023 23:02:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z+LLk2gg6iXl/VALthnRibDlX3Rp8hqZUGrfzhcNKepvTTdxHNQFjw5d44Vax/qOnJHww3lHCf7MxYBaxXuBU=
X-Received: by 2002:ac2:515a:0:b0:4eb:30f9:eed7 with SMTP id
 q26-20020ac2515a000000b004eb30f9eed7mr4305362lfd.22.1682402523347; Mon, 24
 Apr 2023 23:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230424225031.18947-1-shannon.nelson@amd.com>
 <20230424225031.18947-3-shannon.nelson@amd.com>
In-Reply-To: <20230424225031.18947-3-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Apr 2023 14:01:52 +0800
Message-ID: <CACGkMEt6SAn5V2DcuXAsyFqNQw5CyBoU8vAYRA36RtP+=aftqg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] vhost: support PACKED when setting-getting
 vring_base
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: drivers@pensando.io, virtualization@lists.linux-foundation.org,
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

T24gVHVlLCBBcHIgMjUsIDIwMjMgYXQgNjo1MOKAr0FNIFNoYW5ub24gTmVsc29uIDxzaGFubm9u
Lm5lbHNvbkBhbWQuY29tPiB3cm90ZToKPgo+IFVzZSB0aGUgcmlnaHQgc3RydWN0cyBmb3IgUEFD
S0VEIG9yIHNwbGl0IHZxcyB3aGVuIHNldHRpbmcgYW5kCj4gZ2V0dGluZyB0aGUgdnJpbmcgYmFz
ZS4KPgo+IFNpZ25lZC1vZmYtYnk6IFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQu
Y29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MK
Cj4gLS0tCj4gIGRyaXZlcnMvdmhvc3Qvdmhvc3QuYyB8IDE4ICsrKysrKysrKysrKystLS0tLQo+
ICBkcml2ZXJzL3Zob3N0L3Zob3N0LmggfCAgOCArKysrKystLQo+ICAyIGZpbGVzIGNoYW5nZWQs
IDE5IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92aG9zdC92aG9zdC5jIGIvZHJpdmVycy92aG9zdC92aG9zdC5jCj4gaW5kZXggZjExYmRiZTRj
MmM1Li5mNjRlZmRhNDhmMjEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC92aG9zdC5jCj4g
KysrIGIvZHJpdmVycy92aG9zdC92aG9zdC5jCj4gQEAgLTE2MzMsMTcgKzE2MzMsMjUgQEAgbG9u
ZyB2aG9zdF92cmluZ19pb2N0bChzdHJ1Y3Qgdmhvc3RfZGV2ICpkLCB1bnNpZ25lZCBpbnQgaW9j
dGwsIHZvaWQgX191c2VyICphcmcKPiAgICAgICAgICAgICAgICAgICAgICAgICByID0gLUVGQVVM
VDsKPiAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiAgICAgICAgICAgICAgICAgfQo+
IC0gICAgICAgICAgICAgICBpZiAocy5udW0gPiAweGZmZmYpIHsKPiAtICAgICAgICAgICAgICAg
ICAgICAgICByID0gLUVJTlZBTDsKPiAtICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiAr
ICAgICAgICAgICAgICAgaWYgKHZob3N0X2hhc19mZWF0dXJlKHZxLCBWSVJUSU9fRl9SSU5HX1BB
Q0tFRCkpIHsKPiArICAgICAgICAgICAgICAgICAgICAgICB2cS0+bGFzdF9hdmFpbF9pZHggPSBz
Lm51bSAmIDB4ZmZmZjsKPiArICAgICAgICAgICAgICAgICAgICAgICB2cS0+bGFzdF91c2VkX2lk
eCA9IChzLm51bSA+PiAxNikgJiAweGZmZmY7Cj4gKyAgICAgICAgICAgICAgIH0gZWxzZSB7Cj4g
KyAgICAgICAgICAgICAgICAgICAgICAgaWYgKHMubnVtID4gMHhmZmZmKSB7Cj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICByID0gLUVJTlZBTDsKPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGJyZWFrOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIH0KPiArICAgICAg
ICAgICAgICAgICAgICAgICB2cS0+bGFzdF9hdmFpbF9pZHggPSBzLm51bTsKPiAgICAgICAgICAg
ICAgICAgfQo+IC0gICAgICAgICAgICAgICB2cS0+bGFzdF9hdmFpbF9pZHggPSBzLm51bTsKPiAg
ICAgICAgICAgICAgICAgLyogRm9yZ2V0IHRoZSBjYWNoZWQgaW5kZXggdmFsdWUuICovCj4gICAg
ICAgICAgICAgICAgIHZxLT5hdmFpbF9pZHggPSB2cS0+bGFzdF9hdmFpbF9pZHg7Cj4gICAgICAg
ICAgICAgICAgIGJyZWFrOwo+ICAgICAgICAgY2FzZSBWSE9TVF9HRVRfVlJJTkdfQkFTRToKPiAg
ICAgICAgICAgICAgICAgcy5pbmRleCA9IGlkeDsKPiAtICAgICAgICAgICAgICAgcy5udW0gPSB2
cS0+bGFzdF9hdmFpbF9pZHg7Cj4gKyAgICAgICAgICAgICAgIGlmICh2aG9zdF9oYXNfZmVhdHVy
ZSh2cSwgVklSVElPX0ZfUklOR19QQUNLRUQpKQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHMu
bnVtID0gKHUzMil2cS0+bGFzdF9hdmFpbF9pZHggfCAoKHUzMil2cS0+bGFzdF91c2VkX2lkeCA8
PCAxNik7Cj4gKyAgICAgICAgICAgICAgIGVsc2UKPiArICAgICAgICAgICAgICAgICAgICAgICBz
Lm51bSA9IHZxLT5sYXN0X2F2YWlsX2lkeDsKPiAgICAgICAgICAgICAgICAgaWYgKGNvcHlfdG9f
dXNlcihhcmdwLCAmcywgc2l6ZW9mIHMpKQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHIgPSAt
RUZBVUxUOwo+ICAgICAgICAgICAgICAgICBicmVhazsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
aG9zdC92aG9zdC5oIGIvZHJpdmVycy92aG9zdC92aG9zdC5oCj4gaW5kZXggMTY0N2I3NTAxNjlj
Li42ZjczZjI5ZDU5NzkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC92aG9zdC5oCj4gKysr
IGIvZHJpdmVycy92aG9zdC92aG9zdC5oCj4gQEAgLTg1LDEzICs4NSwxNyBAQCBzdHJ1Y3Qgdmhv
c3RfdmlydHF1ZXVlIHsKPiAgICAgICAgIC8qIFRoZSByb3V0aW5lIHRvIGNhbGwgd2hlbiB0aGUg
R3Vlc3QgcGluZ3MgdXMsIG9yIHRpbWVvdXQuICovCj4gICAgICAgICB2aG9zdF93b3JrX2ZuX3Qg
aGFuZGxlX2tpY2s7Cj4KPiAtICAgICAgIC8qIExhc3QgYXZhaWxhYmxlIGluZGV4IHdlIHNhdy4g
Ki8KPiArICAgICAgIC8qIExhc3QgYXZhaWxhYmxlIGluZGV4IHdlIHNhdy4KPiArICAgICAgICAq
IFZhbHVlcyBhcmUgbGltaXRlZCB0byAweDdmZmYsIGFuZCB0aGUgaGlnaCBiaXQgaXMgdXNlZCBh
cwo+ICsgICAgICAgICogYSB3cmFwIGNvdW50ZXIgd2hlbiB1c2luZyBWSVJUSU9fRl9SSU5HX1BB
Q0tFRC4gKi8KPiAgICAgICAgIHUxNiBsYXN0X2F2YWlsX2lkeDsKPgo+ICAgICAgICAgLyogQ2Fj
aGVzIGF2YWlsYWJsZSBpbmRleCB2YWx1ZSBmcm9tIHVzZXIuICovCj4gICAgICAgICB1MTYgYXZh
aWxfaWR4Owo+Cj4gLSAgICAgICAvKiBMYXN0IGluZGV4IHdlIHVzZWQuICovCj4gKyAgICAgICAv
KiBMYXN0IGluZGV4IHdlIHVzZWQuCj4gKyAgICAgICAgKiBWYWx1ZXMgYXJlIGxpbWl0ZWQgdG8g
MHg3ZmZmLCBhbmQgdGhlIGhpZ2ggYml0IGlzIHVzZWQgYXMKPiArICAgICAgICAqIGEgd3JhcCBj
b3VudGVyIHdoZW4gdXNpbmcgVklSVElPX0ZfUklOR19QQUNLRUQuICovCj4gICAgICAgICB1MTYg
bGFzdF91c2VkX2lkeDsKPgo+ICAgICAgICAgLyogVXNlZCBmbGFncyAqLwo+IC0tCj4gMi4xNy4x
Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==

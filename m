Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F80C77B76
	for <virtualization@archiver.kernel.org>; Sun, 23 Apr 2023 06:37:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 618D460F68;
	Sun, 23 Apr 2023 06:37:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 618D460F68
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d5u2eJTs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AMDWdeTvnfKo; Sun, 23 Apr 2023 06:37:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 96FD960B32;
	Sun, 23 Apr 2023 06:37:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96FD960B32
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77585C0037;
	Sun, 23 Apr 2023 06:37:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D633CC002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 06:37:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7692560BEB
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 06:37:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7692560BEB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4PXMp7fgGEub
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 06:36:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A869860B32
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A869860B32
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 06:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682231818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0o81LiM4ZJYyVZpQOwmQjiCBhiZWXIoGbev5WMjpKTQ=;
 b=d5u2eJTszEoUSUriqHyyZ4nOn8a0sk44Pk54EqDG61AWAqzaHnYUYzmqlqwXnOM0qdYQbE
 e8O4GMreag0dUbEK/NWeAW2eQdyIxVFmONzbD4IIiaF8YN4IXBevAH7MqiZRAkcbvNI5e8
 ubTis9y22BHHGPPFGMgrG4zRsBrhksE=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-CbiYhfr3O4azwN0GCe8YfQ-1; Sun, 23 Apr 2023 02:36:52 -0400
X-MC-Unique: CbiYhfr3O4azwN0GCe8YfQ-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-38e551edfcaso2450191b6e.0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 22 Apr 2023 23:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682231812; x=1684823812;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0o81LiM4ZJYyVZpQOwmQjiCBhiZWXIoGbev5WMjpKTQ=;
 b=IyERdw4CanAQre9IDFk8CQst2ywtihuYqUfyBagnocytNwZTCDeV/j+ya64ExhXR0Z
 uUohOi4C7vES8oiPPp3wcM+0oBIJkxl8mqpT68SOZWeq6dSrZY5GFfLcuhrY+7W3EX0T
 X+ov3dYFDFX6CRFppMA569HO5QCyZIedHu1EB0x5zuhMc6VMaXDZGbjLgZFyqG2+RbB9
 FEmsvTXdhu5fpYwbytRM+NK6qRslamfhLPtIaMKDTLkn6tCJmyjo9VADNisuknR6iKYN
 R5UQAsArJ/CJb2nA7kY8UCWRTFQj93qSWuf7q4EzGUa6ee11rScKUVlT6tRPbF4ZS53r
 EQgw==
X-Gm-Message-State: AAQBX9ddydpGHmt+fRk3qWUq0guvkX7djjzr4yeHG6hH8pmjA4gG1iFL
 JqSFreGsTikpfSHPUi+O03xuCSsv1/VteXPjNMIDk+IjqSqZPGoRrxfJXfxbbyeEKDiZA5F4FS7
 mHZHa6DphsR1u1i1sK3VdFd9azdznvPVRqwNDBacpiAeE20UGhW15ibIjlg==
X-Received: by 2002:a05:6808:14c7:b0:38e:7fe:2cad with SMTP id
 f7-20020a05680814c700b0038e07fe2cadmr5898831oiw.30.1682231811964; 
 Sat, 22 Apr 2023 23:36:51 -0700 (PDT)
X-Google-Smtp-Source: AKy350YD2v6BHgwAP0Nbmha9oz1IFaIUIwRIHUM9G0kSG3PjlwnhwKeLJs4m5kiQSCiIO6kJLpwnNRWefrWR5YTrdig=
X-Received: by 2002:a05:6808:14c7:b0:38e:7fe:2cad with SMTP id
 f7-20020a05680814c700b0038e07fe2cadmr5898830oiw.30.1682231811727; Sat, 22 Apr
 2023 23:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230421195641.391-1-shannon.nelson@amd.com>
 <20230421195641.391-3-shannon.nelson@amd.com>
In-Reply-To: <20230421195641.391-3-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 23 Apr 2023 14:36:40 +0800
Message-ID: <CACGkMEsSyZFzB8k1Fpep35Yc7iLL9xmB52BG6F7gnC7ABGZ_5w@mail.gmail.com>
Subject: Re: [PATCH 2/3] vhost: support PACKED when setting-getting vring_base
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

T24gU2F0LCBBcHIgMjIsIDIwMjMgYXQgMzo1N+KAr0FNIFNoYW5ub24gTmVsc29uIDxzaGFubm9u
Lm5lbHNvbkBhbWQuY29tPiB3cm90ZToKPgo+IFVzZSB0aGUgcmlnaHQgc3RydWN0cyBmb3IgUEFD
S0VEIG9yIHNwbGl0IHZxcyB3aGVuIHNldHRpbmcgYW5kCj4gZ2V0dGluZyB0aGUgdnJpbmcgYmFz
ZS4KPgo+IFNpZ25lZC1vZmYtYnk6IFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQu
Y29tPgo+IC0tLQo+ICBkcml2ZXJzL3Zob3N0L3Zob3N0LmMgfCAxOCArKysrKysrKysrKysrLS0t
LS0KPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92aG9zdC5jIGIvZHJpdmVycy92aG9zdC92aG9z
dC5jCj4gaW5kZXggZjExYmRiZTRjMmM1Li5mNjRlZmRhNDhmMjEgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy92aG9zdC92aG9zdC5jCj4gKysrIGIvZHJpdmVycy92aG9zdC92aG9zdC5jCj4gQEAgLTE2
MzMsMTcgKzE2MzMsMjUgQEAgbG9uZyB2aG9zdF92cmluZ19pb2N0bChzdHJ1Y3Qgdmhvc3RfZGV2
ICpkLCB1bnNpZ25lZCBpbnQgaW9jdGwsIHZvaWQgX191c2VyICphcmcKPiAgICAgICAgICAgICAg
ICAgICAgICAgICByID0gLUVGQVVMVDsKPiAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsK
PiAgICAgICAgICAgICAgICAgfQo+IC0gICAgICAgICAgICAgICBpZiAocy5udW0gPiAweGZmZmYp
IHsKPiAtICAgICAgICAgICAgICAgICAgICAgICByID0gLUVJTlZBTDsKPiAtICAgICAgICAgICAg
ICAgICAgICAgICBicmVhazsKPiArICAgICAgICAgICAgICAgaWYgKHZob3N0X2hhc19mZWF0dXJl
KHZxLCBWSVJUSU9fRl9SSU5HX1BBQ0tFRCkpIHsKPiArICAgICAgICAgICAgICAgICAgICAgICB2
cS0+bGFzdF9hdmFpbF9pZHggPSBzLm51bSAmIDB4ZmZmZjsKPiArICAgICAgICAgICAgICAgICAg
ICAgICB2cS0+bGFzdF91c2VkX2lkeCA9IChzLm51bSA+PiAxNikgJiAweGZmZmY7CgpJIHRoaW5r
IHdlIG5lZWQgdG8gdHdlYWsgdGhlIGNvbW1lbnQgYXJvdW5kIGxhc3RfYXZhaWxfaWR4IGFuZCBs
YXN0X3VzZWRfaWR4OgoKICAgICAgICAvKiBMYXN0IGF2YWlsYWJsZSBpbmRleCB3ZSBzYXcuICov
CiAgICAgICAgdTE2IGxhc3RfYXZhaWxfaWR4OwoKICAgICAgICAvKiBMYXN0IGluZGV4IHdlIHVz
ZWQuICovCiAgICAgICAgdTE2IGxhc3RfdXNlZF9pZHg7CgpUbyBkZXNjcmliZSB0aGF0IGl0IGNv
bnRhaW5zIHdyYXAgY291bnRlcnMgYXMgd2VsbCBpbiB0aGUgY2FzZSBvZgpwYWNrZWQgdmlydHF1
ZXVlIG9yIG1heWJlIGl0J3MgdGltZSB0byByZW5hbWUgdGhlbSAoc2luY2UgdGhleSBhcmUKaW52
ZW50ZWQgZm9yIHNwbGl0IHZpcnRxdWV1ZSkuCgpUaGFua3MKCj4gKyAgICAgICAgICAgICAgIH0g
ZWxzZSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKHMubnVtID4gMHhmZmZmKSB7Cj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByID0gLUVJTlZBTDsKPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIH0K
PiArICAgICAgICAgICAgICAgICAgICAgICB2cS0+bGFzdF9hdmFpbF9pZHggPSBzLm51bTsKPiAg
ICAgICAgICAgICAgICAgfQo+IC0gICAgICAgICAgICAgICB2cS0+bGFzdF9hdmFpbF9pZHggPSBz
Lm51bTsKPiAgICAgICAgICAgICAgICAgLyogRm9yZ2V0IHRoZSBjYWNoZWQgaW5kZXggdmFsdWUu
ICovCj4gICAgICAgICAgICAgICAgIHZxLT5hdmFpbF9pZHggPSB2cS0+bGFzdF9hdmFpbF9pZHg7
Cj4gICAgICAgICAgICAgICAgIGJyZWFrOwo+ICAgICAgICAgY2FzZSBWSE9TVF9HRVRfVlJJTkdf
QkFTRToKPiAgICAgICAgICAgICAgICAgcy5pbmRleCA9IGlkeDsKPiAtICAgICAgICAgICAgICAg
cy5udW0gPSB2cS0+bGFzdF9hdmFpbF9pZHg7Cj4gKyAgICAgICAgICAgICAgIGlmICh2aG9zdF9o
YXNfZmVhdHVyZSh2cSwgVklSVElPX0ZfUklOR19QQUNLRUQpKQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHMubnVtID0gKHUzMil2cS0+bGFzdF9hdmFpbF9pZHggfCAoKHUzMil2cS0+bGFzdF91
c2VkX2lkeCA8PCAxNik7Cj4gKyAgICAgICAgICAgICAgIGVsc2UKPiArICAgICAgICAgICAgICAg
ICAgICAgICBzLm51bSA9IHZxLT5sYXN0X2F2YWlsX2lkeDsKPiAgICAgICAgICAgICAgICAgaWYg
KGNvcHlfdG9fdXNlcihhcmdwLCAmcywgc2l6ZW9mIHMpKQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIHIgPSAtRUZBVUxUOwo+ICAgICAgICAgICAgICAgICBicmVhazsKPiAtLQo+IDIuMTcuMQo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=

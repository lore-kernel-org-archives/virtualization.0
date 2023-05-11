Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05A3C77B7C
	for <virtualization@archiver.kernel.org>; Thu, 11 May 2023 07:31:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B8AD700AC;
	Thu, 11 May 2023 07:31:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3B8AD700AC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QM2aIJ4c
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z9lGeFXkZPBd; Thu, 11 May 2023 07:31:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BD89A60AED;
	Thu, 11 May 2023 07:31:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BD89A60AED
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A222DC0036;
	Thu, 11 May 2023 07:31:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08FB9C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 07:31:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B103F60D71
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 07:31:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B103F60D71
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KtT0wnQhoSvf
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 07:31:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5691460AED
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5691460AED
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 07:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683790296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5V0/1s5ImrAvwwVL+7JYFZ+EKAgRU5k+UcpUCxvavT4=;
 b=QM2aIJ4cDLqPDMnaFveD925vZIJWfK3igvYhpuUb3rJgXsYoU7+L3d+TC/Yoj8oFTUTIoz
 WNP+owQFKzwvg6YvYZaL3Fu2QZnr8uV/pmrsuWgHvwmDFUWz25GTjWPjbn5j/48p68WlJu
 QOtxBC5cStUZhKq4VzhJ3HGA4qVToWE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-RnjZOkKoNYOwpCgJBU_2ZQ-1; Thu, 11 May 2023 03:31:34 -0400
X-MC-Unique: RnjZOkKoNYOwpCgJBU_2ZQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4f0176dcc4fso4462840e87.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 00:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683790293; x=1686382293;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5V0/1s5ImrAvwwVL+7JYFZ+EKAgRU5k+UcpUCxvavT4=;
 b=aE8ZA6ljUV1klGkL11p+8yeig5XMj47ltZjF/lGJ2tTQvaYbVGTrH5L2gmt+313vg5
 eIzuRKObc9s3QSuQZoWRUNA0zKYT0nTSdcEZH2RvEXxE4LQPIZkMVaeFlQTFBek8sW7P
 NU3NG6XStAt630I1Y+Z6ZfwiOPxk04+RbnGC09OxP0m9igGLxuYf/I29cp4OQRjzddCC
 K5n3QnkJNCnzSWFbo2gK5bvTmJo3HNThG8RlMBqfbdOU3aE6JRBetBL4JhjWHCzaRogc
 926KhllMnXm8+VZrzJT2n7WOK+aErxi9VczigsrPn3ZeDDlH6ja3WrrhyHMQyvqi3FXA
 hKwA==
X-Gm-Message-State: AC+VfDwWWt/54oXUrWvX5dzcSV6hs5Vml83IJHZCtO44t4bkB4S+nKQl
 P/SLEhBGORzW06PNWt2Hm+dUQBrGZ02VXF911h/h5sstGS4+kRy6ODmJuDuWrFLWu50Cbx+zYfp
 Ml03BmI65iPXOURQxhjkfB8zUg7GLeCfyzyq534Awuhjx1HdZZ2fxEYPn1w==
X-Received: by 2002:ac2:5398:0:b0:4f1:3ca4:926f with SMTP id
 g24-20020ac25398000000b004f13ca4926fmr2305166lfh.21.1683790293479; 
 Thu, 11 May 2023 00:31:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Wbc1XZdl4sGlowrfd/KP1k6He8tT2ctNUXs3FHeEquzBLM1HwcZ4pHvc+WQU60ovxrcq99qQ+d/QbDRRb6OU=
X-Received: by 2002:ac2:5398:0:b0:4f1:3ca4:926f with SMTP id
 g24-20020ac25398000000b004f13ca4926fmr2305152lfh.21.1683790293117; Thu, 11
 May 2023 00:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230424204411.24888-1-asmetanin@yandex-team.ru>
In-Reply-To: <20230424204411.24888-1-asmetanin@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 May 2023 15:31:22 +0800
Message-ID: <CACGkMEsqXoXPLAxuzs-2wAvouwnqe_Q7Z9A=EROoqfjHgD849A@mail.gmail.com>
Subject: Re: [PATCH v2] vhost_net: revert upend_idx only on retriable error
To: Andrey Smetanin <asmetanin@yandex-team.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 yc-core@yandex-team.ru
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

T24gVHVlLCBBcHIgMjUsIDIwMjMgYXQgNDo0NOKAr0FNIEFuZHJleSBTbWV0YW5pbgo8YXNtZXRh
bmluQHlhbmRleC10ZWFtLnJ1PiB3cm90ZToKPgo+IEZpeCBwb3NzaWJsZSB2aXJ0cXVldWUgdXNl
ZCBidWZmZXJzIGxlYWsgYW5kIGNvcnJlc3BvbmRpbmcgc3R1Y2sKPiBpbiBjYXNlIG9mIHRlbXBv
cmFyeSAtRUlPIGZyb20gc2VuZG1zZygpIHdoaWNoIGlzIHByb2R1Y2VkIGJ5Cj4gdHVuIGRyaXZl
ciB3aGlsZSBiYWNrZW5kIGRldmljZSBpcyBub3QgdXAuCj4KPiBJbiBjYXNlIG9mIG5vLXJldHJp
YWJsZSBlcnJvciBhbmQgemNvcHkgZG8gbm90IHJldmVydCB1cGVuZF9pZHgKPiB0byBwYXNzIHBh
Y2tldCBkYXRhICh0aGF0IGlzIHVwZGF0ZSB1c2VkX2lkeCBpbiBjb3JyZXNwb25kaW5nCj4gdmhv
c3RfemVyb2NvcHlfc2lnbmFsX3VzZWQoKSkgYXMgaWYgcGFja2V0IGRhdGEgaGFzIGJlZW4KPiB0
cmFuc2ZlcnJlZCBzdWNjZXNzZnVsbHkuCj4KPiB2Mjogc2V0IHZxLT5oZWFkc1t1YnVmLT5kZXNj
XS5sZW4gZXF1YWwgdG8gVkhPU1RfRE1BX0RPTkVfTEVOCj4gaW4gY2FzZSBvZiBmYWtlIHN1Y2Nl
c3NmdWwgdHJhbnNtaXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgU21ldGFuaW4gPGFzbWV0
YW5pbkB5YW5kZXgtdGVhbS5ydT4KCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPgoKVGhhbmtzCgo+IC0tLQo+ICBkcml2ZXJzL3Zob3N0L25ldC5jIHwgMTEgKysrKysr
KystLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L25ldC5jIGIvZHJpdmVycy92aG9zdC9uZXQu
Ywo+IGluZGV4IDIwMjY1MzkzYWVlNy4uMDc5MWZiZGIzOTc1IDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvdmhvc3QvbmV0LmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L25ldC5jCj4gQEAgLTkzNCwxMyAr
OTM0LDE4IEBAIHN0YXRpYyB2b2lkIGhhbmRsZV90eF96ZXJvY29weShzdHJ1Y3Qgdmhvc3RfbmV0
ICpuZXQsIHN0cnVjdCBzb2NrZXQgKnNvY2spCj4KPiAgICAgICAgICAgICAgICAgZXJyID0gc29j
ay0+b3BzLT5zZW5kbXNnKHNvY2ssICZtc2csIGxlbik7Cj4gICAgICAgICAgICAgICAgIGlmICh1
bmxpa2VseShlcnIgPCAwKSkgewo+ICsgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgcmV0cnkg
PSBlcnIgPT0gLUVBR0FJTiB8fCBlcnIgPT0gLUVOT01FTSB8fCBlcnIgPT0gLUVOT0JVRlM7Cj4g
Kwo+ICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh6Y29weV91c2VkKSB7Cj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpZiAodnEtPmhlYWRzW3VidWYtPmRlc2NdLmxlbiA9PSBW
SE9TVF9ETUFfSU5fUFJPR1JFU1MpCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHZob3N0X25ldF91YnVmX3B1dCh1YnVmcyk7Cj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBudnEtPnVwZW5kX2lkeCA9ICgodW5zaWduZWQpbnZxLT51cGVuZF9pZHggLSAx
KQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAlIFVJT19NQVhJT1Y7
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAocmV0cnkpCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG52cS0+dXBlbmRfaWR4ID0gKCh1bnNpZ25l
ZCludnEtPnVwZW5kX2lkeCAtIDEpCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgJSBVSU9fTUFYSU9WOwo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZWxzZQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2cS0+
aGVhZHNbdWJ1Zi0+ZGVzY10ubGVuID0gVkhPU1RfRE1BX0RPTkVfTEVOOwo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIH0KPiAtICAgICAgICAgICAgICAgICAgICAgICBpZiAoZXJyID09IC1FQUdB
SU4gfHwgZXJyID09IC1FTk9NRU0gfHwgZXJyID09IC1FTk9CVUZTKSB7Cj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgaWYgKHJldHJ5KSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB2aG9zdF9kaXNjYXJkX3ZxX2Rlc2ModnEsIDEpOwo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdmhvc3RfbmV0X2VuYWJsZV92cShuZXQsIHZxKTsKPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGJyZWFrOwo+IC0tCj4gMi4yNS4xCj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

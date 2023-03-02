Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F46FC6FA8E
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 11:34:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6E5C409A8;
	Thu,  2 Mar 2023 11:34:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A6E5C409A8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h1BRlEVf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WMn7YKxpkzZl; Thu,  2 Mar 2023 11:34:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BB93C419A8;
	Thu,  2 Mar 2023 11:34:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB93C419A8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9437FC0035;
	Thu,  2 Mar 2023 11:34:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FD84C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:34:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 456AC419A3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:34:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 456AC419A3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bkmGPNIFcEGY
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:34:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 07DEF409B2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 07DEF409B2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677756870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VN5H8jXkUyi7b3gGlXy5t9+JY6Ep4JlnJplI0XClENQ=;
 b=h1BRlEVf6svjAwrRjcXLQIQxQPvovWIgKgCC+OSaUxm/bE4F9J+bM/eqvzq2svnckgj/x3
 p5wJ52m+mZk9brNWQ48ai2c5i7BJmlau1cdpNp+srEWAEn+zsbZ0rlhMW43Xj79AGvHvLz
 i3AcQdaQgCZ6DClu7iTOr9hmGrCJ8/8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-219-dkIpu-IPNGWUCRV6ZRC0jQ-1; Thu, 02 Mar 2023 06:34:29 -0500
X-MC-Unique: dkIpu-IPNGWUCRV6ZRC0jQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 ge13-20020a05621427cd00b005739f5f9d7cso8513953qvb.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Mar 2023 03:34:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677756868;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VN5H8jXkUyi7b3gGlXy5t9+JY6Ep4JlnJplI0XClENQ=;
 b=Ll6OpZSgV+yFmTjL7ojkJq0kFUfOBEM7eDNUt+W8SP84Oyu4oseSdtQHSx5kpl576V
 ZSpjd0UvNOCkSZqZGefUwddS2I70ZOv0qqsuKc2FvPCsfFT0MNkoI4lD/fCXkTb9BgRG
 ctlKlDPkTlUJFldRFoksK02bGfGIx5cA1ccrSYVu1oo+lqAJ+ALjGRySghK6uhED0NHc
 R4bLfnL1+0cUe55Uzxnv+mYzKe0bWM8IP7k5flRwHDy3EQfLMqNPaXud9dKPn7j2W5HV
 IvtX/Mgafd27CciK8sIURRYgzkHQKYzjAJfurAfmSy8i1HeYm1GMDhvDiFiXvUS6Bh8O
 FjXg==
X-Gm-Message-State: AO0yUKWDFzRn9it23quji2SAbURDoq+Dr8+zVxirbuoqPTZHR2xkINIy
 D7ycqydPSETL7DM0FTXK99zbcb37mZsvtE6b4d2fa0vOkZBaeCmM6XMjZOwR/FBv32nNdpdDROx
 BwMnYfsBACPjwEdkQitnmEbuVvXpViyXX/3epTG3RG60ZsJKd5fjacedyRIR7oToG7j4MbK6PJc
 tJiGH3Uj4L6jkSOUEV0MF8NAA=
X-Received: by 2002:ac8:5784:0:b0:3b9:bd05:bde1 with SMTP id
 v4-20020ac85784000000b003b9bd05bde1mr17927077qta.8.1677756868256; 
 Thu, 02 Mar 2023 03:34:28 -0800 (PST)
X-Google-Smtp-Source: AK7set/2/Vd4OA7axFE8KFaebdPNos2qTeW2fYUlVEyXvnFpPWZ0y0QARAa9MZDYbM3lH3FNvX4jMA==
X-Received: by 2002:ac8:5784:0:b0:3b9:bd05:bde1 with SMTP id
 v4-20020ac85784000000b003b9bd05bde1mr17927037qta.8.1677756867876; 
 Thu, 02 Mar 2023 03:34:27 -0800 (PST)
Received: from step1.redhat.com (c-115-213.cust-q.wadsl.it. [212.43.115.213])
 by smtp.gmail.com with ESMTPSA id
 o12-20020ac8698c000000b003ba19e53e43sm10084156qtq.25.2023.03.02.03.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Mar 2023 03:34:27 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2 0/8] vdpa_sim: add support for user VA
Date: Thu,  2 Mar 2023 12:34:13 +0100
Message-Id: <20230302113421.174582-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, eperezma@redhat.com, stefanha@redhat.com
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

djI6Ci0gcmViYXNlZCBvbiBMaW51cycgdHJlZSwgY29tbWl0IGFlMzQxOWZiYWM4NCAoInZjX3Nj
cmVlbjogZG9uJ3QgY2xvYmJlcgogIHJldHVybiB2YWx1ZSBpbiB2Y3NfcmVhZCIpCi0gcmVtb3Zl
ZCBgc3RydWN0IHRhc2tfc3RydWN0ICpvd25lcmAgcGFyYW0gKHVudXNlZCBmb3Igbm93LCBtYXli
ZQogwqB1c2VmdWwgdG8gc3VwcG9ydCBjZ3JvdXBzKSBbSmFzb25dCi0gYWRkIHVuYmluZF9tbSBj
YWxsYmFjayBbSmFzb25dCi0gY2FsbCB0aGUgbmV3IHVuYmluZF9tbSBjYWxsYmFjayBkdXJpbmcg
dGhlIHJlbGVhc2UgW0phc29uXQotIGF2b2lkIHRvIGNhbGwgYmluZF9tbSBjYWxsYmFjayBhZnRl
ciB0aGUgcmVzZXQsIHNpbmNlIHRoZSBkZXZpY2UKIMKgaXMgbm90IGRldGFjaGluZyBpdCBub3cg
ZHVyaW5nIHRoZSByZXNldAotIGFkZGVkIG5ldyBwYXRjaCByZXBsYWNlIGttYXBfYXRvbWljKCkg
d2l0aCBrbWFwX2xvY2FsX3BhZ2UoKSBzaW5jZQogwqBjaGVja3BhdGNoLnBsIGNvbXBsYWluZWQg
YWJvdXQgZGVwcmVjYXRpb24gb2Yga21hcF9hdG9taWMoKSB0b3VjaGVkCiDCoGJ5IGEgcGF0Y2gg
aW4gdGhpcyBzZXJpZXMKLSBmaXggY2FzdCB3YXJuaW5ncyB3aGVuIGJ1aWxkIHdpdGggVz0xIEM9
MQotIGFkZGVkIG5ldyBwYXRjaCB0byByZXBsYWNlIHRoZSBzcGlubG9jayB3aXRoIGEgbXV0ZXgg
W0phc29uXQotIGB1c2VfdmFgIHNldCB0byB0cnVlIGJ5IGRlZmF1bHQgW0V1Z2VuaW9dCi0gc3Vw
cG9ydGVkIHRoZSBuZXcgdW5iaW5kX21tIGNhbGxiYWNrIFtKYXNvbl0KLSByZW1vdmVkIHRoZSB1
bmJpbmRfbW0gY2FsbCBpbiB2ZHBhc2ltX2RvX3Jlc2V0KCkgW0phc29uXQotIGF2b2lkZWQgdG8g
cmVsZWFzZSB0aGUgbG9jayB3aGlsZSBjYWxsIGt0aHJlYWRfZmx1c2hfd29yaygpIHNpbmNlCiDC
oHdlIGFyZSBub3cgdXNpbmcgYSBtdXRleCB0byBwcm90ZWN0IHRoZSBkZXZpY2Ugc3RhdGUKClJG
QyB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMTIxNDE2MzAyNS4xMDMwNzUt
MS1zZ2FyemFyZUByZWRoYXQuY29tLwoKVGhpcyBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciB0aGUg
dXNlIG9mIHVzZXIgdmlydHVhbCBhZGRyZXNzZXMgaW4gdGhlCnZEUEEgc2ltdWxhdG9yIGRldmlj
ZXMuCgpUaGUgbWFpbiByZWFzb24gZm9yIHRoaXMgY2hhbmdlIGlzIHRvIGxpZnQgdGhlIHBpbm5p
bmcgb2YgYWxsIGd1ZXN0IG1lbW9yeS4KRXNwZWNpYWxseSB3aXRoIHZpcnRpbyBkZXZpY2VzIGlt
cGxlbWVudGVkIGluIHNvZnR3YXJlLgoKVGhlIG5leHQgc3RlcCB3b3VsZCBiZSB0byBnZW5lcmFs
aXplIHRoZSBjb2RlIGluIHZkcGEtc2ltIHRvIGFsbG93IHRoZQppbXBsZW1lbnRhdGlvbiBvZiBp
bi1rZXJuZWwgc29mdHdhcmUgZGV2aWNlcy4gU2ltaWxhciB0byB2aG9zdCwgYnV0IHVzaW5nIHZE
UEEKc28gd2UgY2FuIHJldXNlIHRoZSBzYW1lIHNvZnR3YXJlIHN0YWNrIChlLmcuIGluIFFFTVUp
IGZvciBib3RoIEhXIGFuZCBTVwpkZXZpY2VzLgoKRm9yIGV4YW1wbGUsIHdlIGhhdmUgbmV2ZXIg
bWVyZ2VkIHZob3N0LWJsaywgYW5kIGxhdGVseSB0aGVyZSBoYXMgYmVlbiBpbnRlcmVzdC4KU28g
aXQgd291bGQgYmUgbmljZSB0byBkbyBpdCBkaXJlY3RseSB3aXRoIHZEUEEgdG8gcmV1c2UgdGhl
IHNhbWUgY29kZSBpbiB0aGUKVk1NIGZvciBib3RoIEhXIGFuZCBTVyB2RFBBIGJsb2NrIGRldmlj
ZXMuCgpUaGUgbWFpbiBwcm9ibGVtIChhZGRyZXNzZWQgYnkgdGhpcyBzZXJpZXMpIHdhcyBkdWUg
dG8gdGhlIHBpbm5pbmcgb2YgYWxsCmd1ZXN0IG1lbW9yeSwgd2hpY2ggdGh1cyBwcmV2ZW50ZWQg
dGhlIG92ZXJjb21taXQgb2YgZ3Vlc3QgbWVtb3J5LgoKVGhhbmtzLApTdGVmYW5vCgpTdGVmYW5v
IEdhcnphcmVsbGEgKDgpOgogIHZkcGE6IGFkZCBiaW5kX21tL3VuYmluZF9tbSBjYWxsYmFja3MK
ICB2aG9zdC12ZHBhOiB1c2UgYmluZF9tbS91bmJpbmRfbW0gZGV2aWNlIGNhbGxiYWNrcwogIHZy
aW5naDogcmVwbGFjZSBrbWFwX2F0b21pYygpIHdpdGgga21hcF9sb2NhbF9wYWdlKCkKICB2cmlu
Z2g6IHN1cHBvcnQgVkEgd2l0aCBpb3RsYgogIHZkcGFfc2ltOiBtYWtlIGRldmljZXMgYWdub3N0
aWMgZm9yIHdvcmsgbWFuYWdlbWVudAogIHZkcGFfc2ltOiB1c2Uga3RocmVhZCB3b3JrZXIKICB2
ZHBhX3NpbTogcmVwbGFjZSB0aGUgc3BpbmxvY2sgd2l0aCBhIG11dGV4IHRvIHByb3RlY3QgdGhl
IHN0YXRlCiAgdmRwYV9zaW06IGFkZCBzdXBwb3J0IGZvciB1c2VyIFZBCgogZHJpdmVycy92ZHBh
L3ZkcGFfc2ltL3ZkcGFfc2ltLmggICAgIHwgIDExICstCiBpbmNsdWRlL2xpbnV4L3ZkcGEuaCAg
ICAgICAgICAgICAgICAgfCAgMTAgKysKIGluY2x1ZGUvbGludXgvdnJpbmdoLmggICAgICAgICAg
ICAgICB8ICAgNSArLQogZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jICAgIHwgICAy
ICstCiBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyAgICAgfCAxNjAgKysrKysrKysr
KysrKystLS0KIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYyB8ICAxMCArLQog
ZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5jIHwgIDEwICstCiBkcml2ZXJzL3Zo
b3N0L3ZkcGEuYyAgICAgICAgICAgICAgICAgfCAgMzAgKysrKwogZHJpdmVycy92aG9zdC92cmlu
Z2guYyAgICAgICAgICAgICAgIHwgMjQ3ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLQogOSBm
aWxlcyBjaGFuZ2VkLCAzOTUgaW5zZXJ0aW9ucygrKSwgOTAgZGVsZXRpb25zKC0pCgotLSAKMi4z
OS4yCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=

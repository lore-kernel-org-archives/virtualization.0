Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CB7C77B7F
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 02:54:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CB7E81BF4;
	Mon, 15 May 2023 02:54:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CB7E81BF4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K7rxZP0w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id skrJf9Xa-O0x; Mon, 15 May 2023 02:54:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CB53681D47;
	Mon, 15 May 2023 02:54:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CB53681D47
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4B33C0036;
	Mon, 15 May 2023 02:54:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F103CC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 02:54:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D6F23408F1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 02:54:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D6F23408F1
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=K7rxZP0w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W2U6BDCW4-bh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 02:54:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E3851408D1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E3851408D1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 02:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684119259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EkzlwX51KE129ml/9poCdEkruLOF2qo9tI3tXAC4N1o=;
 b=K7rxZP0w8+CFg8ljlxrCNunNagwm5Q+fu14MxyCakIOOpsucDQmnypJWlRidDtZXJOGHKH
 QWYz+AX+8Okj0Z94l8CehWzlQOcU76/vb9hVlPhHKvzQhZKKSLrBWHrpa+ejCJbw63GsGg
 50ImFtKEx2yd1tsrabC7WtPSD4zm8r4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-e8e3Mpz1N3WRfBX4CXpX1w-1; Sun, 14 May 2023 22:54:18 -0400
X-MC-Unique: e8e3Mpz1N3WRfBX4CXpX1w-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-643bb9cdd3cso9956931b3a.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 May 2023 19:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684119257; x=1686711257;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EkzlwX51KE129ml/9poCdEkruLOF2qo9tI3tXAC4N1o=;
 b=iu24AlxDInsWxub3TIX8zDgMgw1gYTBzr8zl3rseIu8DQ4PsbSc8DFh/BKsxqFWFUQ
 I7Qn6l0d1gLMlva5n+cPWUMwPqkvtdtLghlpZ+Bgik9V+SUC7G0MoByJPTWzGlKi75Sg
 XsCyJo8fnsqFS4I4NneZSDwu3wgx5QhN1+n/p2fOs2dHtm6hmlgtCugdLJxFLw1iz4EY
 6+XHYZzKu9IkTW6bRjPDXvWWVSAbjd8o/wk4UF0uStYVHXpLBr9dI2aNDS4UAcDaqpb7
 YTDRfYqsWshM32CZUu3al2JQBpcYl8K3en+OpMyvgygYQax5nt7Ne5ZB07t3gZomNb61
 AwzQ==
X-Gm-Message-State: AC+VfDyk6Uys1hkyK5/ZfKticMTOQexvVA3FSN3KHlnWlK0aPB9TeV13
 QN3zgHqHLTz4WAIvXtVILGq4c6ZfjLY0RxCauE/UZo0XqFgow5fcRo48qoMuK30PLnRSgHaDM/t
 3CAUx9Yu0ouJEq+I+A1By0k3jLxm2OwGxaoVTWSiL3w==
X-Received: by 2002:a05:6a00:1a06:b0:645:e008:d7ba with SMTP id
 g6-20020a056a001a0600b00645e008d7bamr33616783pfv.27.1684119257503; 
 Sun, 14 May 2023 19:54:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ54myTqbH/N66ayTKu7p7Naxk1W4iTkxHVxbTrenFvZw42D9bZCcna/F3moNHQnqTqxvQG6IA==
X-Received: by 2002:a05:6a00:1a06:b0:645:e008:d7ba with SMTP id
 g6-20020a056a001a0600b00645e008d7bamr33616766pfv.27.1684119257204; 
 Sun, 14 May 2023 19:54:17 -0700 (PDT)
Received: from [10.72.13.223] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 f26-20020aa78b1a000000b0063b6bd2216dsm652307pfd.187.2023.05.14.19.54.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 May 2023 19:54:16 -0700 (PDT)
Message-ID: <747f6c1f-2bd1-a331-796d-dbef43692183@redhat.com>
Date: Mon, 15 May 2023 10:54:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v5 virtio 02/11] virtio: allow caller to override device
 DMA mask in vp_modern
To: Shannon Nelson <shannon.nelson@amd.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, brett.creeley@amd.com,
 netdev@vger.kernel.org
References: <20230503181240.14009-1-shannon.nelson@amd.com>
 <20230503181240.14009-3-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230503181240.14009-3-shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: simon.horman@corigine.com, drivers@pensando.io
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

CuWcqCAyMDIzLzUvNCAwMjoxMiwgU2hhbm5vbiBOZWxzb24g5YaZ6YGTOgo+IFRvIGFkZCBhIGJp
dCBvZiB2ZW5kb3IgZmxleGliaWxpdHkgd2l0aCB2YXJpb3VzIHZpcnRpbyBiYXNlZCBkZXZpY2Vz
LAo+IGFsbG93IHRoZSBjYWxsZXIgdG8gc3BlY2lmeSBhIGRpZmZlcmVudCBETUEgbWFzay4gIFRo
aXMgYWRkcyBhIGRtYV9tYXNrCj4gZmllbGQgdG8gc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2Rl
dmljZS4gIElmIGRlZmluZWQgYnkgdGhlIGRyaXZlciwKPiB0aGlzIG1hc2sgd2lsbCBiZSB1c2Vk
IGluIGEgY2FsbCB0byBkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KCkgaW5zdGVhZAo+IG9mIHRo
ZSB0cmFkaXRpb25hbCBETUFfQklUX01BU0soNjQpLiAgVGhpcyBhbGxvd3MgbGltaXRpbmcgdGhl
IERNQSBzcGFjZQo+IG9uIHZlbmRvciBkZXZpY2VzIHdpdGggYWRkcmVzcyBsaW1pdGF0aW9ucy4K
Pgo+IFNpZ25lZC1vZmYtYnk6IFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQuY29t
PgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgoK
PiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuX2Rldi5jIHwgMyArKy0K
PiAgIGluY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaCAgICAgIHwgMyArKysKPiAgIDIg
ZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMgYi9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcGNpX21vZGVybl9kZXYuYwo+IGluZGV4IDliMmQ2NjE0ZGU2Ny4uYWFkN2Q5
Mjk2ZTc3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuX2Rl
di5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMKPiBAQCAt
MjY4LDcgKzI2OCw4IEBAIGludCB2cF9tb2Rlcm5fcHJvYmUoc3RydWN0IHZpcnRpb19wY2lfbW9k
ZXJuX2RldmljZSAqbWRldikKPiAgIAkJcmV0dXJuIC1FSU5WQUw7Cj4gICAJfQo+ICAgCj4gLQll
cnIgPSBkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KCZwY2lfZGV2LT5kZXYsIERNQV9CSVRfTUFT
Syg2NCkpOwo+ICsJZXJyID0gZG1hX3NldF9tYXNrX2FuZF9jb2hlcmVudCgmcGNpX2Rldi0+ZGV2
LAo+ICsJCQkJCW1kZXYtPmRtYV9tYXNrID8gOiBETUFfQklUX01BU0soNjQpKTsKPiAgIAlpZiAo
ZXJyKQo+ICAgCQllcnIgPSBkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KCZwY2lfZGV2LT5kZXYs
Cj4gICAJCQkJCQlETUFfQklUX01BU0soMzIpKTsKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC92aXJ0aW9fcGNpX21vZGVybi5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fcGNpX21vZGVybi5o
Cj4gaW5kZXggZTdiMWRiMWRkMGJiLi4wNjdhYzFkNzg5YmMgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVk
ZS9saW51eC92aXJ0aW9fcGNpX21vZGVybi5oCj4gKysrIGIvaW5jbHVkZS9saW51eC92aXJ0aW9f
cGNpX21vZGVybi5oCj4gQEAgLTQxLDYgKzQxLDkgQEAgc3RydWN0IHZpcnRpb19wY2lfbW9kZXJu
X2RldmljZSB7Cj4gICAKPiAgIAkvKiBvcHRpb25hbCBjaGVjayBmb3IgdmVuZG9yIHZpcnRpbyBk
ZXZpY2UsIHJldHVybnMgZGV2X2lkIG9yIC1FUlJOTyAqLwo+ICAgCWludCAoKmRldmljZV9pZF9j
aGVjaykoc3RydWN0IHBjaV9kZXYgKnBkZXYpOwo+ICsKPiArCS8qIG9wdGlvbmFsIG1hc2sgZm9y
IGRldmljZXMgd2l0aCBsaW1pdGVkIERNQSBzcGFjZSAqLwo+ICsJdTY0IGRtYV9tYXNrOwo+ICAg
fTsKPiAgIAo+ICAgLyoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

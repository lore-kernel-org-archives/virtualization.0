Return-Path: <SRS0=GbdO=L3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A308C07E97
	for <virtualization@archiver.kernel.org>; Sat,  3 Jul 2021 08:12:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D30A61421
	for <virtualization@archiver.kernel.org>; Sat,  3 Jul 2021 08:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D30A61421
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BEBF584367;
	Sat,  3 Jul 2021 08:12:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bsdBCKfkzUlU; Sat,  3 Jul 2021 08:12:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 747798435F;
	Sat,  3 Jul 2021 08:12:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 434F2C0022;
	Sat,  3 Jul 2021 08:12:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E368C000E
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Jul 2021 08:12:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 74F7B40696
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Jul 2021 08:11:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aPMjqw--OGse
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Jul 2021 08:11:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B58EB40689
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Jul 2021 08:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625299913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KNgXYIOgFk3/50sq9zIL4S0YcLBbQBv9LP1nNZa2JAA=;
 b=Is/0ClB5ELfAofWQMDsaxB3Kb/nK36FlRH+ZEQksYtN1iYzZEhCa91txECZEvXPM/BYrgC
 77wawFIYhKYRuu9/tFxSCaIW69s+HvY1Q4KSQco49rFgyXD1HljYwNbw9jhnMGkauVjN08
 s5RuufRHWPytaeGyAD4/TG58VzTWu2w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-MoPHtAzAMza7AgIMzMc9Pw-1; Sat, 03 Jul 2021 04:11:51 -0400
X-MC-Unique: MoPHtAzAMza7AgIMzMc9Pw-1
Received: by mail-wm1-f71.google.com with SMTP id
 13-20020a1c010d0000b02901eca51685daso7492731wmb.3
 for <virtualization@lists.linux-foundation.org>;
 Sat, 03 Jul 2021 01:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=KNgXYIOgFk3/50sq9zIL4S0YcLBbQBv9LP1nNZa2JAA=;
 b=HR+QjejiHYtS5o+v0J/8PusS0Eq0LoUOfIrfs/JNjf8XXf8iBkSzLWq21+mEbjss5w
 XAZr1Sz+k8m1QSqgTDhncglIANkuxQDy+Nh5MYy2QTca71j9HHi5wreI2ri0F8YWcDlN
 7Gdy+76MfCF/6RYuQnFTX+CM6CuqXQikUign2/TF7azkkSqqfIYd+vf6PBzbcTabPWl3
 qZyk/l85zb5XEsQaELmSoS4NTSWweoYGN21NoRq2VApwp9cNo2B94DU78XE6GVn9tya1
 9Nwa4ZpPmM8VEnrAz+octlBbSV2mLT50Mr1xd0yx7sn7x2pLaPwyVJ70MFNK2kXVL59W
 qZfg==
X-Gm-Message-State: AOAM533IeZpQpNoiiX05ZPl1VdWsZeoE6bpzfK12EYLr+eVUp7r2uxgZ
 9uMOXOISn6XYQqIeZY8maHlAzb3YaAgBdK4BSi1nHtwndfkdWZRkzQfSnH6ry9VnwIS6TGlfjJh
 DSpSxTEhK7c29RriTiabsMdHP3YSG2xoFPPXKQY7EbA==
X-Received: by 2002:a05:600c:296:: with SMTP id
 22mr3824975wmk.17.1625299910358; 
 Sat, 03 Jul 2021 01:11:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwK/iU/CBYEp+7S7mKEGeGippXEk01Zz5EGl2SiAx3okylS3s7KpViTuEX44OaCNPVpb3WcZg==
X-Received: by 2002:a05:600c:296:: with SMTP id
 22mr3824967wmk.17.1625299910246; 
 Sat, 03 Jul 2021 01:11:50 -0700 (PDT)
Received: from redhat.com ([2.55.4.39])
 by smtp.gmail.com with ESMTPSA id j37sm2822258wms.37.2021.07.03.01.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jul 2021 01:11:48 -0700 (PDT)
Date: Sat, 3 Jul 2021 04:11:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: log warning message if vhost_vdpa_remove
 gets blocked
Message-ID: <20210703041124-mutt-send-email-mst@kernel.org>
References: <20210606132909.177640-1-gdawar.xilinx@gmail.com>
 <aa866c72-c3d9-9022-aa5b-b5a9fc9e946a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <aa866c72-c3d9-9022-aa5b-b5a9fc9e946a@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Gautam Dawar <gdawar.xilinx@gmail.com>, linux-kernel@vger.kernel.org,
 gdawar@xilinx.com, virtualization@lists.linux-foundation.org,
 martinh@xilinx.com, hanand@xilinx.com
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

T24gVHVlLCBKdW4gMTUsIDIwMjEgYXQgMTA6MzM6MjJQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS82LzYg5LiL5Y2IOToyOSwgR2F1dGFtIERhd2FyIOWGmemBkzoKPiA+
IEZyb206IEdhdXRhbSBEYXdhciA8Z2Rhd2FyQHhpbGlueC5jb20+Cj4gPiAKPiA+IElmIHNvbWUg
bW9kdWxlIGludm9rZXMgdmRwYV9kZXZpY2VfdW5yZWdpc3RlciAodXN1YWxseSBpbiB0aGUgbW9k
dWxlCj4gPiB1bmxvYWQgZnVuY3Rpb24pIHdoZW4gdGhlIHVzZXJzcGFjZSBhcHAgKGVnLiBRRU1V
KSB3aGljaCBoYWQgb3BlbmVkCj4gPiB0aGUgdmhvc3QtdmRwYSBjaGFyYWN0ZXIgZGV2aWNlIGlz
IHN0aWxsIHJ1bm5pbmcsIHZob3N0X3ZkcGFfcmVtb3ZlKCkKPiA+IGZ1bmN0aW9uIHdpbGwgYmxv
Y2sgaW5kZWZpbml0ZWx5IGluIGNhbGwgdG8gd2FpdF9mb3JfY29tcGxldGlvbigpLgo+ID4gCj4g
PiBUaGlzIGNhdXNlcyB0aGUgdmRwYV9kZXZpY2VfdW5yZWdpc3RlciBjYWxsZXIgdG8gaGFuZyBh
bmQgd2l0aCBhCj4gPiB1c3VhbCBzaWRlLWVmZmVjdCBvZiBybW1vZCBjb21tYW5kIG5vdCByZXR1
cm5pbmcgd2hlbiB0aGlzIGNhbGwKPiA+IGlzIGluIHRoZSBtb2R1bGVfZXhpdCBmdW5jdGlvbi4K
PiA+IAo+ID4gVGhpcyBwYXRjaCBjb252ZXJ0cyB0aGUgd2FpdF9mb3JfY29tcGxldGlvbiBjYWxs
IHRvIGl0cyB0aW1lb3V0IGJhc2VkCj4gPiBjb3VudGVycGFydCAod2FpdF9mb3JfY29tcGxldGlv
bl90aW1lb3V0KSBhbmQgYWxzbyBhZGRzIGEgd2FybmluZwo+ID4gbWVzc2FnZSB0byBhbGVydCB0
aGUgdXNlci9hZG1pbmlzdHJhdG9yIGFib3V0IHRoaXMgaGFuZyBzaXR1YXRpb24uCj4gPiAKPiA+
IFRvIGV2ZW50dWFsbHkgZml4IHRoaXMgcHJvYmxlbSwgYSBtZWNoYW5pc20gd2lsbCBiZSByZXF1
aXJlZCB0byBsZXQKPiA+IHZob3N0LXZkcGEgbW9kdWxlIGluZm9ybSB0aGUgdXNlcnNwYWNlIG9m
IHRoaXMgc2l0dWF0aW9uIGFuZAo+ID4gdXNlcnNwYWNlIHdpbGwgY2xvc2UgdGhlIGRlc2NyaXB0
b3Igb2Ygdmhvc3QtdmRwYSBjaGFyIGRldmljZS4KPiA+IFRoaXMgd2lsbCBlbmFibGUgdmhvc3Qt
dmRwYSB0byBjb250aW51ZSB3aXRoIGdyYWNlZnVsIGNsZWFuLXVwLgo+ID4gCj4gPiBTaWduZWQt
b2ZmLWJ5OiBHYXV0YW0gRGF3YXIgPGdkYXdhckB4aWxpbnguY29tPgo+ID4gLS0tCj4gPiAgIGRy
aXZlcnMvdmhvc3QvdmRwYS5jIHwgNiArKysrKy0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ID4gaW5kZXggYmZhNGM2ZWY1NTRl
Li41NzJiNjRkMDliMDYgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ID4g
KysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+IEBAIC0xMDkxLDcgKzEwOTEsMTEgQEAgc3Rh
dGljIHZvaWQgdmhvc3RfdmRwYV9yZW1vdmUoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhKQo+ID4g
ICAJCW9wZW5lZCA9IGF0b21pY19jbXB4Y2hnKCZ2LT5vcGVuZWQsIDAsIDEpOwo+ID4gICAJCWlm
ICghb3BlbmVkKQo+ID4gICAJCQlicmVhazsKPiA+IC0JCXdhaXRfZm9yX2NvbXBsZXRpb24oJnYt
PmNvbXBsZXRpb24pOwo+ID4gKwkJd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCZ2LT5jb21w
bGV0aW9uLAo+ID4gKwkJCQkJICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOwo+ID4gKwkJZGV2
X3dhcm5fcmF0ZWxpbWl0ZWQoJnYtPmRldiwKPiA+ICsJCQkJICAgICAiJXMgd2FpdGluZyBmb3Ig
L2Rldi8lcyB0byBiZSBjbG9zZWRcbiIsCj4gPiArCQkJCSAgICAgX19mdW5jX18sIGRldl9uYW1l
KCZ2LT5kZXYpKTsKCkNhbiBmaWxsIHVwIHRoZSBrZXJuZWwgbG9nIGluIHRoaXMgY2FzZSAuLi4g
ZGV2X3dhcm5fb25jZSBzZWVtcyBtb3JlCmFwcHJvcHJpYXRlLgoKPiA+ICAgCX0gd2hpbGUgKDEp
Owo+ID4gICAJcHV0X2RldmljZSgmdi0+ZGV2KTsKPiAKPiAKPiBBY2tlZC1ieTogSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

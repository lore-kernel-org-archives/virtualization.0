Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DDAE7D0C3
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 03:03:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0B6DD40AD9;
	Fri, 22 Sep 2023 03:03:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0B6DD40AD9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KJmjPuyx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kZ4cePwfr3V7; Fri, 22 Sep 2023 03:03:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 864CB40154;
	Fri, 22 Sep 2023 03:03:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 864CB40154
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C716C0071;
	Fri, 22 Sep 2023 03:03:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E572C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 91B1D40333
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:03:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 91B1D40333
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KJmjPuyx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t7D6_N4wg1k7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:03:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D63CB42189
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:03:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D63CB42189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695351786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dW4RnVlw5/tVnpAaLSeim6/pCr4y6tZ4UO2FXXjy4VI=;
 b=KJmjPuyxZaH8RKPlnROBph3KnmnNu1DirmS8sEoLT0l51R7Tmvj+SklTgikpURa8KucbVk
 W86utna4+67DrZw8egclS430U7Fy1bKhD6jArW6K5FSYKLByQe4TlfmfRV9SP5bPVqSOAw
 pWrUEpqtqqEeUBZRx+ZokM+q3aFSP2w=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-EdSezyDmPfS_1iPTxAj5GQ-1; Thu, 21 Sep 2023 23:03:03 -0400
X-MC-Unique: EdSezyDmPfS_1iPTxAj5GQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-503177646d2so2087552e87.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 20:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695351782; x=1695956582;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dW4RnVlw5/tVnpAaLSeim6/pCr4y6tZ4UO2FXXjy4VI=;
 b=jnUiKLWyTYIfH1haCLfrIiOgDW3b9K1piC9J+ItVCb9krpj85a789yMGaAWDwabi6h
 oYOwcBNAz4D2iR2gVg7EltZGaWNG0vx7D/HtMvhT73XZWHa70nKzLWbq1ENsnf1xsj7M
 o0lQ8N63c3+0hrtTjWyJgQavWOQmPoIB6COefwt2f82bHP4PoH/rw396tJBlFWXzrsw4
 Q8SFLrC8Fr89n4PzXXYRpunZWoD6ndh5jJMy39fIJteALyAgLcsvhfGZOesEHXtzC3v1
 AXCJoWkvz3irPx/b+IMDKcDNSLQkUsvlHgwgbxExXI3g+mJE1aB7ktQxlAmYh8/Qqdsc
 yrlQ==
X-Gm-Message-State: AOJu0YzdxipvlZWHFXrqhufTfED67Oyp4E7bga7SrTAfTgc8IlE97vUH
 AtFS4nSewZkiJ/45NUyn2GdqgReqWxk2XXvjBQGNqIjyRmaRIl62kzy/uyNtwpi+Cchjsew5SOf
 5jrUlyDtzIe4ejbwgwFvv4qCNVBZiG+b/BCY4venUH3zA88wkONBdPk0Wvg==
X-Received: by 2002:a05:6512:45c:b0:500:a408:dbd with SMTP id
 y28-20020a056512045c00b00500a4080dbdmr5634789lfk.55.1695351781962; 
 Thu, 21 Sep 2023 20:03:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCe0kdx/yNUkFl1DpNMRt90Uw3lvxFNhgSGLq2OYqjLwjpt60Uo7KV1kgg6YBPqqu6tDxOYe7G+arq74CtToQ=
X-Received: by 2002:a05:6512:45c:b0:500:a408:dbd with SMTP id
 y28-20020a056512045c00b00500a4080dbdmr5634777lfk.55.1695351781806; Thu, 21
 Sep 2023 20:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230921124040.145386-12-yishaih@nvidia.com>
 <20230921104350.6bb003ff.alex.williamson@redhat.com>
 <20230921165224.GR13733@nvidia.com>
 <20230921125348-mutt-send-email-mst@kernel.org>
 <20230921170709.GS13733@nvidia.com>
 <20230921131035-mutt-send-email-mst@kernel.org>
 <20230921174450.GT13733@nvidia.com>
 <20230921135426-mutt-send-email-mst@kernel.org>
 <20230921181637.GU13733@nvidia.com>
 <20230921152802-mutt-send-email-mst@kernel.org>
 <20230921195345.GZ13733@nvidia.com>
In-Reply-To: <20230921195345.GZ13733@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Sep 2023 11:02:50 +0800
Message-ID: <CACGkMEt=dxhJP4mUUWh+x-TSxA5JQcvmhJbkLJMWdN8oXV6ojg@mail.gmail.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
To: Jason Gunthorpe <jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 maorg@nvidia.com, virtualization@lists.linux-foundation.org, jiri@nvidia.com,
 leonro@nvidia.com
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

T24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgMzo1M+KAr0FNIEphc29uIEd1bnRob3JwZSA8amdnQG52
aWRpYS5jb20+IHdyb3RlOgo+Cj4gT24gVGh1LCBTZXAgMjEsIDIwMjMgYXQgMDM6MzQ6MDNQTSAt
MDQwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Cj4gPiB0aGF0J3MgZWFzeS9wcmFjdGlj
YWwuICBJZiBpbnN0ZWFkIFZEUEEgZ2l2ZXMgdGhlIHNhbWUgc3BlZWQgd2l0aCBqdXN0Cj4gPiBz
aGFkb3cgdnEgdGhlbiBrZWVwaW5nIHRoaXMgaGFjayBpbiB2ZmlvIHNlZW1zIGxpa2UgbGVzcyBv
ZiBhIHByb2JsZW0uCj4gPiBGaW5hbGx5IGlmIFZEUEEgaXMgZmFzdGVyIHRoZW4gbWF5YmUgeW91
IHdpbGwgcmVjb25zaWRlciB1c2luZyBpdCA7KQo+Cj4gSXQgaXMgbm90IGFsbCBhYm91dCB0aGUg
c3BlZWQuCj4KPiBWRFBBIHByZXNlbnRzIGFub3RoZXIgbGFyZ2UgYW5kIGNvbXBsZXggc29mdHdh
cmUgc3RhY2sgaW4gdGhlCj4gaHlwZXJ2aXNvciB0aGF0IGNhbiBiZSBlbGltaW5hdGVkIGJ5IHNp
bXBseSB1c2luZyBWRklPLgoKdkRQQSBzdXBwb3J0cyBzdGFuZGFyZCB2aXJ0aW8gZGV2aWNlcyBz
byBob3cgZGlkIHlvdSBkZWZpbmUgY29tcGxleGl0eT8KCkZyb20gdGhlIHZpZXcgb2YgdGhlIGFw
cGxpY2F0aW9uLCB3aGF0IGl0IHdhbnRzIGlzIGEgc2ltcGxlIHZpcnRpbwpkZXZpY2UgYnV0IG5v
dCB2aXJ0aW8tcGNpIGRldmljZXMuIFRoYXQgaXMgd2hhdCB2RFBBIHRyaWVzIHRvIHByZXNlbnQu
CgpCeSBzaW1wbHkgY291bnRpbmcgTE9DczogdmRwYSArIHZob3N0ICsgdnBfdmRwYSBpcyBtdWNo
IGxlc3MgY29kZSB0aGFuCndoYXQgVkZJTyBoYWQuIEl0J3Mgbm90IGhhcmQgdG8gZXhwZWN0LCBp
dCB3aWxsIHN0aWxsIGJlIG11Y2ggbGVzcwpldmVuIGlmIGlvbW11ZmQgaXMgZG9uZS4KClRoYW5r
cwoKCgo+IFZGSU8gaXMKPiBhbHJlYWR5IHJlcXVpcmVkIGZvciBvdGhlciBzY2VuYXJpb3MuCj4K
PiBUaGlzIGlzIGFib3V0IHJlZHVjaW5nIGNvbXBsZXhpdHksIHJlZHVjaW5nIGF0dGFjayBzdXJm
YWNlIGFuZAo+IGluY3JlYXNpbmcgbWFpbnRhaW5hYmlsaXR5IG9mIHRoZSBoeXBlcnZpc29yIGVu
dmlyb25tZW50Lgo+Cj4gSmFzb24KPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

Return-Path: <SRS0=x/cL=HV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78249C433E0
	for <virtualization@archiver.kernel.org>; Fri, 19 Feb 2021 14:56:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B7564EB2
	for <virtualization@archiver.kernel.org>; Fri, 19 Feb 2021 14:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B7564EB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B1DA606EC
	for <virtualization@archiver.kernel.org>; Fri, 19 Feb 2021 14:56:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jlGW3v147cM4 for <virtualization@archiver.kernel.org>;
	Fri, 19 Feb 2021 14:56:14 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id B023E606F4; Fri, 19 Feb 2021 14:56:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 946E060690;
	Fri, 19 Feb 2021 14:56:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63359C000E;
	Fri, 19 Feb 2021 14:56:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF488C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 14:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A420E86C02
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 14:56:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yRvActVvQHJq
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 14:56:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C0AC886BF8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 14:56:09 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id q10so10454652edt.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 06:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9KW+1lIwPV9FPrnZg5vNSqypATsMZae7KiNb0eudmHM=;
 b=fWlizlEuP6fQFXcSfr57FExVLI3CPIV2N2m+q43FPhwTzlg8qFqVtR2ot7crvh/QW2
 Qs8fcmRxZoRaSthNGmlfJA5Rv1YBC4S9VvZN9TBF+pu585Yd1tSv+dganVhM4259iily
 Wk8X2dC0CiMSntdm2q50kxGpwkPvEF2mKeZbx3Rd9w0aV1hEjvzOeSYK91djuqD/9uRz
 IybFBgnlTsOuU0j8UxqZHZhzAmejyXt6wOt88B/zjfNk8g3b8pKf0IPPwq3gTBJNFb6m
 sZQFyr10ifWODIk6m67nbAeupaz3rX9483lUva4ErH/Z1+sVoqOuBKu+W0aPvF0RE7bF
 LqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9KW+1lIwPV9FPrnZg5vNSqypATsMZae7KiNb0eudmHM=;
 b=rrHIF6QaN+3WonIFPpIPCrtNopoTbxSGqK6CQImkIdu8UQh2SOKvW8rFMJhPR5nXYH
 mMQCQV8O+l+fJMVjcDkmHZidL3oBBzv4WhtazMXT9WAirOi0PXlW10kVbKnjWaUXWo0Q
 1NpYVAqfUA88ikEXqtMbqVS0wrIFIY8nd6l09R1PY1bGPqIfhJTnIWkoCHjxIoPVoxs+
 rgkZT24lfPLJKx7+B4nBOs02NDrjK8VTjb8X5WadcfecevABFYyzF66ORsel0YnQatmc
 zK68ZG188ZiXt3wdasRhZUQ8+XGvunIqa8Z623C3fxmnaUUSSljJo/Kfrgliuuf0fyar
 tIHQ==
X-Gm-Message-State: AOAM531vWo2dVZU7rBhnahR7uWv6XzKe5kL8vp4tmFYL0ji1yt0r7Zvx
 xh9tm4iZX+3n8oKHtLZ9HK/j5r5zMAE=
X-Google-Smtp-Source: ABdhPJypcjKf00afbpVdx9yxMzQX7yRxC5yxJ9xjtr7nND10OvNzNc9Hwv79InT3EJVhnh/SANr6SA==
X-Received: by 2002:aa7:c78e:: with SMTP id n14mr9480568eds.31.1613746567673; 
 Fri, 19 Feb 2021 06:56:07 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com.
 [209.85.221.41])
 by smtp.gmail.com with ESMTPSA id u17sm5370763edr.0.2021.02.19.06.56.06
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Feb 2021 06:56:06 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id v1so8929518wrd.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 06:56:06 -0800 (PST)
X-Received: by 2002:a5d:4488:: with SMTP id j8mr8312106wrq.12.1613746565793;
 Fri, 19 Feb 2021 06:56:05 -0800 (PST)
MIME-Version: 1.0
References: <5e910d11a14da17c41317417fc41d3a9d472c6e7.1613659844.git.bnemeth@redhat.com>
 <CA+FuTSe7srSBnAmFNFBFkDrLmPL5XtxhbXEs1mBytUBuuym2fg@mail.gmail.com>
 <2cc06597-8005-7be8-4094-b20f525afde8@redhat.com>
In-Reply-To: <2cc06597-8005-7be8-4094-b20f525afde8@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 19 Feb 2021 09:55:28 -0500
X-Gmail-Original-Message-ID: <CA+FuTSf2GCi+RzpkFeBgtSOyhjsBFfApjekzupHLfyeYDn-JYQ@mail.gmail.com>
Message-ID: <CA+FuTSf2GCi+RzpkFeBgtSOyhjsBFfApjekzupHLfyeYDn-JYQ@mail.gmail.com>
Subject: Re: [PATCH] net: check if protocol extracted by
 virtio_net_hdr_set_proto is correct
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Balazs Nemeth <bnemeth@redhat.com>,
 David Miller <davem@davemloft.net>
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

T24gRnJpLCBGZWIgMTksIDIwMjEgYXQgMzo1MyBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+Cj4gT24gMjAyMS8yLzE4IDExOjUwIOS4i+WNiCwgV2lsbGVtIGRl
IEJydWlqbiB3cm90ZToKPiA+IE9uIFRodSwgRmViIDE4LCAyMDIxIGF0IDEwOjAxIEFNIEJhbGF6
cyBOZW1ldGggPGJuZW1ldGhAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPj4gRm9yIGdzbyBwYWNrZXRz
LCB2aXJ0aW9fbmV0X2hkcl9zZXRfcHJvdG8gc2V0cyB0aGUgcHJvdG9jb2wgKGlmIGl0IGlzbid0
Cj4gPj4gc2V0KSBiYXNlZCBvbiB0aGUgdHlwZSBpbiB0aGUgdmlydGlvIG5ldCBoZHIsIGJ1dCB0
aGUgc2tiIGNvdWxkIGNvbnRhaW4KPiA+PiBhbnl0aGluZyBzaW5jZSBpdCBjb3VsZCBjb21lIGZy
b20gcGFja2V0X3NuZCB0aHJvdWdoIGEgcmF3IHNvY2tldC4gSWYKPiA+PiB0aGVyZSBpcyBhIG1p
c21hdGNoIGJldHdlZW4gd2hhdCB2aXJ0aW9fbmV0X2hkcl9zZXRfcHJvdG8gc2V0cyBhbmQKPiA+
PiB0aGUgYWN0dWFsIHByb3RvY29sLCB0aGVuIHRoZSBza2IgY291bGQgYmUgaGFuZGxlZCBpbmNv
cnJlY3RseSBsYXRlcgo+ID4+IG9uIGJ5IGdzby4KPiA+Pgo+ID4+IFRoZSBuZXR3b3JrIGhlYWRl
ciBvZiBnc28gcGFja2V0cyBzdGFydHMgYXQgMTQgYnl0ZXMsIGJ1dCBhIHNwZWNpYWxseQo+ID4+
IGNyYWZ0ZWQgcGFja2V0IGNvdWxkIGZvb2wgdGhlIGNhbGwgdG8gc2tiX2Zsb3dfZGlzc2VjdF9m
bG93X2tleXNfYmFzaWMKPiA+PiBhcyB0aGUgbmV0d29yayBoZWFkZXIgb2Zmc2V0IGluIHRoZSBz
a2IgY291bGQgYmUgaW5jb3JyZWN0Lgo+ID4+IENvbnNlcXVlbnRseSwgRUlOVkFMIGlzIG5vdCBy
ZXR1cm5lZC4KPiA+Pgo+ID4+IFRoZXJlIGFyZSBldmVuIHBhY2tldHMgdGhhdCBjYW4gY2F1c2Ug
YW4gaW5maW5pdGUgbG9vcC4gRm9yIGV4YW1wbGUsIGEKPiA+PiBwYWNrZXQgd2l0aCBldGhlcm5l
dCB0eXBlIEVUSF9QX01QTFNfVUMgKHdoaWNoIGlzIHVubm90aWNlZCBieQo+ID4+IHZpcnRpb19u
ZXRfaGRyX3RvX3NrYikgdGhhdCBpcyBzZW50IHRvIGEgZ2VuZXZlIGludGVyZmFjZSB3aWxsIGJl
Cj4gPj4gaGFuZGxlZCBieSBnZW5ldmVfYnVpbGRfc2tiLiBJbiB0dXJuLCBpdCBjYWxscwo+ID4+
IHVkcF90dW5uZWxfaGFuZGxlX29mZmxvYWRzIHdoaWNoIHRoZW4gY2FsbHMgc2tiX3Jlc2V0X2lu
bmVyX2hlYWRlcnMuCj4gPj4gQWZ0ZXIgdGhhdCwgdGhlIHBhY2tldCBnZXRzIHBhc3NlZCB0byBt
cGxzX2dzb19zZWdtZW50LiBUaGF0IGZ1bmN0aW9uCj4gPj4gY2FsY3VsYXRlcyB0aGUgbXBscyBo
ZWFkZXIgbGVuZ3RoIGJ5IHRha2luZyB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuCj4gPj4gbmV0d29y
a19oZWFkZXIgYW5kIGlubmVyX25ldHdvcmtfaGVhZGVyLiBTaW5jZSB0aGUgdHdvIGFyZSBlcXVh
bAo+ID4+IChkdWUgdG8gdGhlIGVhcmxpZXIgY2FsbCB0byBza2JfcmVzZXRfaW5uZXJfaGVhZGVy
cyksIGl0IHdpbGwgY2FsY3VsYXRlCj4gPj4gYSBoZWFkZXIgb2YgbGVuZ3RoIDAsIGFuZCBpdCB3
aWxsIG5vdCBwdWxsIGFueSBoZWFkZXJzLiBUaGVuLCBpdCB3aWxsCj4gPj4gY2FsbCBza2JfbWFj
X2dzb19zZWdtZW50IHdoaWNoIHdpbGwgYWdhaW4gY2FsbCBtcGxzX2dzb19zZWdtZW50LCBldGMu
Li4KPiA+PiBUaGlzIGxlYWRzIHRvIHRoZSBpbmZpbml0ZSBsb29wLgo+Cj4KPiBJIHJlbWVtYmVy
IGtlcm5lbCB3aWxsIHZhbGlkYXRlIGRvZGd5IGdzbyBwYWNrZXRzIGluIGdzbyBvcHMuIEkgd29u
ZGVyCj4gd2h5IG5vdCBkbyB0aGUgY2hlY2sgdGhlcmU/IFRoZSByZWFzb24gaXMgdGhhdCB2aXJ0
aW8vVFVOIGlzIG5vdCB0aGUKPiBvbmx5IHNvdXJjZSBmb3IgdGhvc2UgcGFja2V0cy4KCkl0IGlz
PyBBbGwgb3RoZXIgR1NPIHBhY2tldHMgYXJlIGdlbmVyYXRlZCBieSB0aGUgc3RhY2sgaXRzZWxm
LCBlaXRoZXIKbG9jYWxseSBvciB0aHJvdWdoIEdSTy4KCkJ1dCBpbmRlZWQgc29tZSBjaGVja3Mg
YXJlIGJldHRlciBwZXJmb3JtZWQgaW4gdGhlIEdTTyBsYXllci4gU3VjaCBhcwpsaWtlbHkgdGhl
IDAtYnl0ZSBtcGxzIGhlYWRlciBsZW5ndGguCgpJZiB3ZSBjYW5ub3QgdHJ1c3QgdmlydGlvX25l
dF9oZHIuZ3NvX3R5cGUgcGFzc2VkIGZyb20gdXNlcnNwYWNlLCB0aGVuCndlIGNhbiBhbHNvIG5v
dCB0cnVzdCB0aGUgZXRoLmhfcHJvdG8gY29taW5nIGZyb20gdGhlIHNhbWUgc291cmNlLiBCdXQK
aXQgbWFrZXMgc2Vuc2UgdG8gcmVxdWlyZSB0aGVtIHRvIGJlIGNvbnNpc3RlbnQuIFRoZXJlIGlz
IGEKZGV2X3BhcnNlX2hlYWRlcl9wcm90b2NvbCB0aGF0IG1heSByZXR1cm4gdGhlIGxpbmsgbGF5
ZXIgdHlwZSBpbiBhCm1vcmUgZ2VuZXJpYyBmYXNoaW9uIHRoYW4gY2FzdGluZyB0byBza2JfZXRo
X2hkci4KClF1ZXN0aW9uIHJlbWFpbnMgd2hhdCB0byBkbyBmb3IgdGhlIGxpbmsgbGF5ZXIgdHlw
ZXMgdGhhdCBkbyBub3QgaW1wbGVtZW50CmhlYWRlcl9vcHMtPnBhcnNlX3Byb3RvY29sLCBhbmQg
c28gd2UgY2Fubm90IHZhbGlkYXRlIHRoZSBwYWNrZXQncwpuZXR3b3JrIHByb3RvY29sLiBEcm9w
IHdpbGwgY2F1c2UgZmFsc2UgcG9zaXRpdmVzLCBhY2NlcHRzIHdpbGwgbGVhdmUgYQpwb3RlbnRp
YWwgcGF0aCwganVzdCBjbG9zZXMgaXQgZm9yIEV0aGVybmV0LgoKVGhpcyBtaWdodCBjYWxsIGZv
ciBtdWx0aXBsZSBmaXhlcywgYm90aCBvbiBmaXJzdCBpbmdlc3QgYW5kIGluc2lkZSB0aGUgc3Rh
Y2s/Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==

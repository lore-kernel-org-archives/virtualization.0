Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A4DC433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Dec 2021 06:40:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E6762403BE;
	Thu,  9 Dec 2021 06:40:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hpzpsxUhHrpD; Thu,  9 Dec 2021 06:40:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F117A40255;
	Thu,  9 Dec 2021 06:40:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBBC9C002F;
	Thu,  9 Dec 2021 06:40:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5DA3C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 06:40:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A51B460769
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 06:40:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cPS_0R_5lvUX
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 06:40:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB7366069D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 06:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639032042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HItKaEVThTkJ2QIHyp/bO4uhWwDFTwJR6Bm5V+C1o5Y=;
 b=duel/qXo2ZW60lq+xZQVSI7s4mXqt7q/k5fvgM5OXF0fSsbbyZ/LDrvnbRDoFcRwPaDHBD
 xOvqLbdwmU+xvx+PunokzoZIF2s8Q5PjZ8XlwTEwfCu46bfQ+RHlcz7L6HoWkKyh/b1ROX
 C6r1rThEvnZWNMCUl4NhY74ggI98sPk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-238-P84ydKsfMZ-xaHdOCZ3qLQ-1; Thu, 09 Dec 2021 01:40:41 -0500
X-MC-Unique: P84ydKsfMZ-xaHdOCZ3qLQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 k8-20020a5d5248000000b001763e7c9ce5so1057092wrc.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Dec 2021 22:40:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=HItKaEVThTkJ2QIHyp/bO4uhWwDFTwJR6Bm5V+C1o5Y=;
 b=q8sn8U5vgvbSusZvDUlLbqRWhJqt4vf2njQO4KH+TyzOwGAbfIpc7qJg/BNHkA69yQ
 krm2lkvDCi3EjPYRcQ//ykSpig6UAlN9oL/IMmssUciUM01MM/wdrDnXlgEqlEbC0G30
 L2jVCV2wkSIle1BVCLSufWgNwBLk8/Ak6J6bO5VH66aGQVfFR5DENWmRnr2hRfzzHiET
 4TTNlzPpGHgepE7fR0SDfDn5qSMrMmhjs3O10VvT79JHm8UYNgraFUTu8qTaXn5Jo+ov
 UcFlQPcFLKYRXE3CJjxZugT0SEqlLprpEK2+Sd6T58STGtp0yHI5sYZJdu2aB8fG0cop
 GlUA==
X-Gm-Message-State: AOAM532dpTcLfyzVI4Hwz99l/Bv/8BFiwg+moQjopgfiXG8iDtO6r3VV
 7Np9xrmifv5LfdWf97CkqdfJdqvxWJXep+Y/TeTzL/nWhY9bIbR8L4g8QYnOOuMsHb09oIkP3iA
 AMSutf1Uoq8KWrpJ3NgTYpeDoALPxWnpynhSinTf0ww==
X-Received: by 2002:a5d:4312:: with SMTP id h18mr4269922wrq.626.1639032040269; 
 Wed, 08 Dec 2021 22:40:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxigXNVg7SRW6zp5Vj3MsFSvI73LOepnWH/bWDIovVMHtbh4xBRqE80WZsdE/KLDQ1CeD2Hcw==
X-Received: by 2002:a5d:4312:: with SMTP id h18mr4269902wrq.626.1639032040068; 
 Wed, 08 Dec 2021 22:40:40 -0800 (PST)
Received: from redhat.com ([2.55.18.120])
 by smtp.gmail.com with ESMTPSA id e3sm4830673wrp.8.2021.12.08.22.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Dec 2021 22:40:39 -0800 (PST)
Date: Thu, 9 Dec 2021 01:40:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Subject: Re: [RFC PATCH] virtio: make sure legacy pci device gain 32bit-pfn vq
Message-ID: <20211209013833-mutt-send-email-mst@kernel.org>
References: <b50fff4d-9f05-76b3-eba7-91241c351751@linux.alibaba.com>
 <20211207031217-mutt-send-email-mst@kernel.org>
 <8bbfd029-d969-4632-cb8e-482481d65a2f@linux.alibaba.com>
 <20211208021947-mutt-send-email-mst@kernel.org>
 <dfb712d7-1186-1496-9fcc-a72e23c3409b@linux.alibaba.com>
 <20211208060115-mutt-send-email-mst@kernel.org>
 <a5b62e3c-5c24-dc8f-f7a3-027a67ef3bb2@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <a5b62e3c-5c24-dc8f-f7a3-027a67ef3bb2@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>
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

T24gVGh1LCBEZWMgMDksIDIwMjEgYXQgMTE6MjE6MzZBTSArMDgwMCwg546L6LSHIHdyb3RlOgo+
IAo+IAo+IOWcqCAyMDIxLzEyLzgg5LiL5Y2INzowOCwgTWljaGFlbCBTLiBUc2lya2luIOWGmemB
kzoKPiBbc25pcF0KPiA+ID4gPiA+IAo+ID4gPiA+ID4gSGksIE1pY2hhZWwKPiA+ID4gPiA+IAo+
ID4gPiA+ID4gVGhhbmtzIGZvciB0aGUgY29tbWVudCwgdW5mb3J0dW5hdGVseSBtb2RpZnkgZGV2
aWNlIGlzIG5vdCBhbiBvcHRpb24gZm9yIHVzCj4gPiA+ID4gPiA6LSgKPiA+ID4gPiA+IAo+ID4g
PiA+ID4gSXMgdGhlcmUgYW55IGlkZWEgb24gaG93IHRvIHNvbHZlIHRoaXMgaXNzdWUgcHJvcGVy
bHk/Cj4gPiA+ID4gPiAKPiA+ID4gPiA+IFJlZ2FyZHMsCj4gPiA+ID4gPiBNaWNoYWVsIFdhbmcK
PiA+ID4gPiAKPiA+ID4gPiBCeSB0aGUgd2F5LCB0aGVyZSBpcyBhIGJ1ZyBpbiB0aGUgZXJyb3Ig
bWVzc2FnZS4gV2FudCB0byBmaXggdGhhdD8KPiA+ID4gCj4gPiA+IENvdWxkIHlvdSBwbGVhc2Ug
cHJvdmlkZSBtb3JlIGRldGFpbCBhYm91dCB0aGUgYnVnPyBXZSdkIGxpa2UgdG8gaGVscCBmaXhp
bmcKPiA+ID4gaXQgOi0pCj4gPiAKPiA+IHZpcnRpby1wY2kgMDAwMDoxNDowMC4wOiBwbGF0Zm9y
bSBidWc6IGxlZ2FjeSB2aXJ0aW8tbW1pbyBtdXN0IC4uLgo+ID4gCj4gPiBzaG91bGQgYmUgdmly
dGlvLXBjaSBub3QgdmlydGlvLW1taW8KPiAKPiBQYXRjaCBvbiB0aGUgd2F5fgo+IAo+ID4gCj4g
PiAKPiA+IAo+ID4gPiBCZXNpZGVzLCBJJ3ZlIGNoZWNrZWQgdGhhdCBwYXRjaCBidXQgaXQgY2Fu
J3QgYWRkcmVzcyBvdXIgaXNzdWUsIHdlIGFjdHVhbGx5Cj4gPiA+IGhhdmUgdGhpcyBsZWdhY3kg
cGNpIGRldmljZSBvbiBhcm0gcGxhdGZvcm0sIGFuZCB0aGUgbWVtb3J5IGxheW91dCBpcwo+ID4g
PiB1bmZyaWVuZGx5IHNpbmNlIGFsbG9jYXRpb24gcmFyZWx5IHByb3ZpZGluZyBwYWdlLWFkZHJl
c3MgYmVsb3cgNDRiaXQsIHdlCj4gPiA+IHVuZGVyc3RhbmQgdGhlIHZpcnRpby1pb21tdSBjYXNl
IHNob3VsZCBub3QgZG8gZm9yY2UgZG1hLCB3aGlsZSB3ZSBkb24ndAo+ID4gPiBoYXZlIHRoYXQg
c28gaXQncyBqdXN0IHdvcmtpbmcgZmluZS4KPiA+ID4gCj4gPiA+IFJlZ2FyZHMsCj4gPiA+IE1p
Y2hhZWwgV2FuZwo+ID4gCj4gPiBIbW0gd2FpdCBhIHNlYyBpcyBpdCBhIHBoeXNpY2FsIGRldmlj
ZSBvciBhIGh5cGVydmlzb3I/Cj4gPiBJZiBhIHBoeXNpY2FsIG9uZSB0aGVuIGRvZXNuJ3QgaXQg
bmVlZCBWSVJUSU9fRl9PUkRFUl9QTEFURk9STQo+ID4gb24gQVJNPwo+IAo+IFRoZSBQQ0kgZGV2
aWNlIGlzIHZpcnR1YWwsIEkgY2FuJ3Qgc2VlIGhvdyBWSVJUSU9fRl9PUkRFUl9QTEFURk9STSBo
ZWxwCj4gYWRkcmVzcyB0aGlzIGlzc3VlLCBsZWdhY3kgcGNpIGNvbmZpZyBpcyAzMmJpdCBidXQg
aXQncyAzNiwgc2VlbXMgbGlrZSB3aWxsCj4gbmV2ZXIgYmUgaW5jbHVkZWQ/Cj4gCj4gUmVnYXJk
cywKPiBNaWNoYWVsIFdhbmcKCk9oLCBpZiB0aGUgZGV2aWNlIGlzIHZpcnR1YWwgdGhlbiBJIHRo
aW5rIHlvdSBzaG91bGQganVzdCB1cGRhdGUgaXQgcGxlYXNlLgp2aXJ0aW8gMC5YIGlzIGFyY2hp
dGVjdHVyYWxseSBsaW1pdGVkIHRvIHNtYWxsIFZNcywKaWYgeW91ciBoeXBlcnZpc29yIHN1cHBv
cnRzIG1vcmUgaXQgc2hvdWxkIGVtdWxhdGUgdmlydGlvIDEuMC4KCgoKPiA+IAo+ID4gCj4gPiAK
PiA+ID4gPiAKPiA+ID4gPiAKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gLS0tCj4gPiA+ID4g
PiA+ID4gICAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMgfCAxMCArKysrKysr
KysrCj4gPiA+ID4gPiA+ID4gICAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgICAgICAg
fCAgMyArKysKPiA+ID4gPiA+ID4gPiAgICAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICAg
ICAgICB8ICAxICsKPiA+ID4gPiA+ID4gPiAgICAgMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRp
b25zKCspCj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMKPiA+ID4gPiA+ID4gPiBiL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19wY2lfbGVnYWN5LmMKPiA+ID4gPiA+ID4gPiBpbmRleCBkNjJlOTgzLi4xMWYyZWJm
IDEwMDY0NAo+ID4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVn
YWN5LmMKPiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2Fj
eS5jCj4gPiA+ID4gPiA+ID4gQEAgLTI2Myw2ICsyNjMsMTYgQEAgaW50IHZpcnRpb19wY2lfbGVn
YWN5X3Byb2JlKHN0cnVjdCB2aXJ0aW9fcGNpX2RldmljZQo+ID4gPiA+ID4gPiA+ICp2cF9kZXYp
Cj4gPiA+ID4gPiA+ID4gICAgIAl2cF9kZXYtPnNldHVwX3ZxID0gc2V0dXBfdnE7Cj4gPiA+ID4g
PiA+ID4gICAgIAl2cF9kZXYtPmRlbF92cSA9IGRlbF92cTsKPiA+ID4gPiA+ID4gPiAKPiA+ID4g
PiA+ID4gPiArCS8qCj4gPiA+ID4gPiA+ID4gKwkgKiBUaGUgbGVnYWN5IHBjaSBkZXZpY2UgcmVx
dXJlIDMyYml0LXBmbiB2cSwKPiA+ID4gPiA+ID4gPiArCSAqIG9yIHNldHVwX3ZxKCkgd2lsbCBm
YWlsZWQuCj4gPiA+ID4gPiA+ID4gKwkgKgo+ID4gPiA+ID4gPiA+ICsJICogVGh1cyB3ZSBtYWtl
IHN1cmUgdnJpbmdfdXNlX2RtYV9hcGkoKSB3aWxsCj4gPiA+ID4gPiA+ID4gKwkgKiByZXR1cm4g
dHJ1ZSBkdXJpbmcgdGhlIGFsbG9jYXRpb24gYnkgbWFya2luZwo+ID4gPiA+ID4gPiA+ICsJICog
Zm9yY2VfZG1hIGhlcmUuCj4gPiA+ID4gPiA+ID4gKwkgKi8KPiA+ID4gPiA+ID4gPiArCXZwX2Rl
di0+dmRldi5mb3JjZV9kbWEgPSB0cnVlOwo+ID4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gPiAg
ICAgCXJldHVybiAwOwo+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ICAgICBlcnJfaW9tYXA6
Cj4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMg
Yi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ID4gPiA+ID4gaW5kZXggMzAzNWJi
Ni4uNjU2MmUwMSAxMDA2NDQKPiA+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcmluZy5jCj4gPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
Ywo+ID4gPiA+ID4gPiA+IEBAIC0yNDUsNiArMjQ1LDkgQEAgc3RhdGljIGlubGluZSBib29sIHZp
cnRxdWV1ZV91c2VfaW5kaXJlY3Qoc3RydWN0Cj4gPiA+ID4gPiA+ID4gdmlydHF1ZXVlICpfdnEs
Cj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gICAgIHN0YXRpYyBib29sIHZyaW5nX3VzZV9k
bWFfYXBpKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiA+ID4gPiA+ICAgICB7Cj4g
PiA+ID4gPiA+ID4gKwlpZiAodmRldi0+Zm9yY2VfZG1hKQo+ID4gPiA+ID4gPiA+ICsJCXJldHVy
biB0cnVlOwo+ID4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gPiAgICAgCWlmICghdmlydGlvX2hh
c19kbWFfcXVpcmsodmRldikpCj4gPiA+ID4gPiA+ID4gICAgIAkJcmV0dXJuIHRydWU7Cj4gPiA+
ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlv
LmggYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gPiA+ID4gPiA+ID4gaW5kZXggNDFlZGJjMC4u
YTRlYjI5ZCAxMDA2NDQKPiA+ID4gPiA+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5o
Cj4gPiA+ID4gPiA+ID4gKysrIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+ID4gPiA+ID4gPiA+
IEBAIC0xMDksNiArMTA5LDcgQEAgc3RydWN0IHZpcnRpb19kZXZpY2Ugewo+ID4gPiA+ID4gPiA+
ICAgICAJYm9vbCBmYWlsZWQ7Cj4gPiA+ID4gPiA+ID4gICAgIAlib29sIGNvbmZpZ19lbmFibGVk
Owo+ID4gPiA+ID4gPiA+ICAgICAJYm9vbCBjb25maWdfY2hhbmdlX3BlbmRpbmc7Cj4gPiA+ID4g
PiA+ID4gKwlib29sIGZvcmNlX2RtYTsKPiA+ID4gPiA+ID4gPiAgICAgCXNwaW5sb2NrX3QgY29u
ZmlnX2xvY2s7Cj4gPiA+ID4gPiA+ID4gICAgIAlzcGlubG9ja190IHZxc19saXN0X2xvY2s7IC8q
IFByb3RlY3RzIFZRcyBsaXN0IGFjY2VzcyAqLwo+ID4gPiA+ID4gPiA+ICAgICAJc3RydWN0IGRl
dmljZSBkZXY7Cj4gPiA+ID4gPiA+ID4gLS0gCj4gPiA+ID4gPiA+ID4gMS44LjMuMQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u

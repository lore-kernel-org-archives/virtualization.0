Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AB8C433EF
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 20:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46B30831FB;
	Fri, 14 Jan 2022 20:12:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8SAGI0mT_JWg; Fri, 14 Jan 2022 20:12:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DC8CE81B58;
	Fri, 14 Jan 2022 20:12:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E2F7C0030;
	Fri, 14 Jan 2022 20:12:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EE4EC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 20:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 36E92410D8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 20:12:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vWEE0fu0GPte
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 20:12:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6D470410AB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 20:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642191169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7iTzTn2n67utbixR5b6YXHlQ+XdyXgKqOT9cBufKBdM=;
 b=N3W2HaqlnIcpnA8wvXXDuIJy5nZtLaefHh/bcQ+DjI+zmlcWawXTFPdElFTaoKsX3EwI3G
 JUqoIdIqj3XPqn9kcrVfYIQMD95aDEKi/A82JvI3j3vKfAM+XSOyxlK/ek4ldoM3JoD1vP
 cwhBD4DNMhOyEDu8LoF+9096dViVLtE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-Q3FXE_xLNyiZ1bwHr6RP8A-1; Fri, 14 Jan 2022 15:12:48 -0500
X-MC-Unique: Q3FXE_xLNyiZ1bwHr6RP8A-1
Received: by mail-ed1-f71.google.com with SMTP id
 r8-20020a05640251c800b003f9a52daa3fso9046157edd.22
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 12:12:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=7iTzTn2n67utbixR5b6YXHlQ+XdyXgKqOT9cBufKBdM=;
 b=tt2VuBCrHgAFU6+rzy011KJ2/Xptle2ydN6iVGe0cNOfOVvKplnBAYfOS/feY4L9zu
 JP16B7u0vjrptUzkIAgvGbEKohnakqsLzgIRgJ4gycPdOTKzy8ZUi0X04d7zUTlg4dMk
 gH96pSsjxAcJCyh3Gsgmu+CVtXYjZoGCtv08SRSWCAtH7XGAQTDQqmzi87OrwuUOBxqJ
 GcfKQlKEBSYOPJTWQiEWLEu4Q7pDPYBESq0ETQqzXCZEDEqwCSpIavvDSMXQ3RbN6Esk
 RJGe0Ac7NMZhZk0ubUsvtgGYVQmfoJ5+xxk+Jh7pBy4VVH0bHgolK6EQKgezarRK5+0H
 jskA==
X-Gm-Message-State: AOAM530jiwaX1wpBfhWnrQLQnm8EiJ2bYmxLR7PMrodSlBpobyxTHNfo
 Vvyag5r2Wq5K/7OQiLCDEY49W4ZzGMKAtzNbFf8mLabC035r0u53RBs8PMZqZG5GFixj5YClswF
 KlZmKvJn8H5T6/yGaVUzQy67W4CK6jcTZIQGTsI9TNw==
X-Received: by 2002:a17:906:4998:: with SMTP id
 p24mr8386858eju.131.1642191167097; 
 Fri, 14 Jan 2022 12:12:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxlRk5849FD9Gb0CZqUKAe6WWwoBJIyORKH5tTXEVe14wdHDHsknTapvCgDiW0DJ1AVlgt6pg==
X-Received: by 2002:a17:906:4998:: with SMTP id
 p24mr8386847eju.131.1642191166939; 
 Fri, 14 Jan 2022 12:12:46 -0800 (PST)
Received: from redhat.com ([2.55.154.210])
 by smtp.gmail.com with ESMTPSA id u12sm1884500eda.56.2022.01.14.12.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jan 2022 12:12:45 -0800 (PST)
Date: Fri, 14 Jan 2022 15:12:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: virtio_bt: fix device removal
Message-ID: <20220114151142-mutt-send-email-mst@kernel.org>
References: <20211125174200.133230-1-mst@redhat.com>
 <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
 <20211209162149-mutt-send-email-mst@kernel.org>
 <20211213054357-mutt-send-email-mst@kernel.org>
 <20211213185620-mutt-send-email-mst@kernel.org>
 <FF8BA713-6DD2-485B-9ADC-02006126BC60@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <FF8BA713-6DD2-485B-9ADC-02006126BC60@holtmann.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-bluetooth@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Johan Hedberg <johan.hedberg@gmail.com>
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

T24gVGh1LCBEZWMgMTYsIDIwMjEgYXQgMDg6NTg6MzFQTSArMDEwMCwgTWFyY2VsIEhvbHRtYW5u
IHdyb3RlOgo+IEhpIE1pY2hhZWwsCj4gCj4gPj4+Pj4gRGV2aWNlIHJlbW92YWwgaXMgY2xlYXJs
eSBvdXQgb2YgdmlydGlvIHNwZWM6IGl0IGF0dGVtcHRzIHRvIHJlbW92ZQo+ID4+Pj4+IHVudXNl
ZCBidWZmZXJzIGZyb20gYSBWUSBiZWZvcmUgaW52b2tpbmcgZGV2aWNlIHJlc2V0LiBUbyBmaXgs
IG1ha2UKPiA+Pj4+PiBvcGVuL2Nsb3NlIE5PUHMgYW5kIGRvIGFsbCBjbGVhbnVwL3NldHVwIGlu
IHByb2JlL3JlbW92ZS4KPiA+Pj4+IAo+ID4+Pj4gc28gdGhlIHZpcnRidF97b3BlbixjbG9zZX0g
YXMgTk9QIGlzIG5vdCByZWFsbHkgd2hhdCBhIGRyaXZlciBpcyBzdXBwb3NlCj4gPj4+PiB0byBi
ZSBkb2luZy4gVGhlc2UgYXJlIHRyYW5zcG9ydCBlbmFibGUvZGlzYWJsZSBjYWxsYmFja3MgZnJv
bSB0aGUgQlQKPiA+Pj4+IENvcmUgdG93YXJkcyB0aGUgZHJpdmVyLiBJdCBtYXBzIHRvIGEgZGV2
aWNlIGJlaW5nIGVuYWJsZWQvZGlzYWJsZWQgYnkKPiA+Pj4+IHNvbWV0aGluZyBsaWtlIGJsdWV0
b290aGQgZm9yIGV4YW1wbGUuIFNvIGlmIGRpc2FibGVkLCBJIGV4cGVjdCB0aGF0IG5vCj4gPj4+
PiByZXNvdXJjZXMvcXVldWVzIGFyZSBpbiB1c2UuCj4gPj4+PiAKPiA+Pj4+IE1heWJlIEkgbWlz
dW5kZXJzdGFuZCB0aGUgdmlydGlvIHNwZWMgaW4gdGhhdCByZWdhcmQsIGJ1dCBJIHdvdWxkIGxp
a2UKPiA+Pj4+IHRvIGtlZXAgdGhpcyBmdW5kYW1lbnRhbCBjb25jZXB0IG9mIGEgQmx1ZXRvb3Ro
IGRyaXZlci4gSXQgZG9lcyB3b3JrCj4gPj4+PiB3aXRoIGFsbCBvdGhlciB0cmFuc3BvcnRzIGxp
a2UgVVNCLCBTRElPLCBVQVJUIGV0Yy4KPiA+Pj4+IAo+ID4+Pj4+IFRoZSBjb3N0IGhlcmUgaXMg
YSBzaW5nbGUgc2tiIHdhc3RlZCBvbiBhbiB1bnVzZWQgYnQgZGV2aWNlIC0gd2hpY2gKPiA+Pj4+
PiBzZWVtcyBtb2Rlc3QuCj4gPj4+PiAKPiA+Pj4+IFRoZXJlIHNob3VsZCBiZSBubyBidWZmZXIg
dXNlZCBpZiB0aGUgZGV2aWNlIGlzIHBvd2VyZWQgb2ZmLiBXZSBhbHNvIGRvbuKAmXQKPiA+Pj4+
IGhhdmUgYW55IFVTQiBVUkJzIGluLWZsaWdodCBpZiB0aGUgdHJhbnNwb3J0IGlzIG5vdCBhY3Rp
dmUuCj4gPj4+PiAKPiA+Pj4+PiBOQjogd2l0aCB0aGlzIGZpeCBpbiBwbGFjZSBkcml2ZXIgc3Rp
bGwgc3VmZmVycyBmcm9tIGEgcmFjZSBjb25kaXRpb24gaWYKPiA+Pj4+PiBhbiBpbnRlcnJ1cHQg
dHJpZ2dlcnMgd2hpbGUgZGV2aWNlIGlzIGJlaW5nIHJlc2V0LiBXb3JrIG9uIGEgZml4IGZvcgo+
ID4+Pj4+IHRoYXQgaXNzdWUgaXMgaW4gcHJvZ3Jlc3MuCj4gPj4+PiAKPiA+Pj4+IEluIHRoZSB2
aXJ0YnRfY2xvc2UoKSBjYWxsYmFjayB3ZSBzaG91bGQgZGVhY3RpdmF0ZSBhbGwgaW50ZXJydXB0
cy4KPiA+Pj4+IAo+ID4+Pj4gUmVnYXJkcwo+ID4+Pj4gCj4gPj4+PiBNYXJjZWwKPiA+Pj4gCj4g
Pj4+IFNvIE1hcmNlbCwgZG8gSSByZWFkIGl0IHJpZ2h0IHRoYXQgeW91IGFyZSB3b3JraW5nIG9u
IGEgZml4Cj4gPj4+IGFuZCBJIGNhbiBkcm9wIHRoaXMgcGF0Y2ggZm9yIG5vdz8KPiA+PiAKPiA+
PiBwaW5nCj4gPiAKPiA+IAo+ID4gSWYgSSBkb24ndCBoZWFyIG90aGVyd2lzZSBJJ2xsIHF1ZXVl
IG15IHZlcnNpb24gLSBpdCBtaWdodCBub3QKPiA+IGJlIGlkZWFsIGJ1dCBpdCBhdCBsZWFzdCBk
b2VzIG5vdCB2aW9sYXRlIHRoZSBzcGVjLgo+ID4gV2UgY2FuIHdvcmsgb24gbm90IGFsbG9jYXRp
bmcvZnJlZWluZyBidWZmZXJzIGxhdGVyCj4gPiBhcyBhcHByb3ByaWF0ZS4KPiAKPiBJIGhhdmUg
YSBwYXRjaCwgYnV0IGl0IGlzIG5vdCBmdWxseSB0ZXN0ZWQgeWV0Lgo+IAo+IFJlZ2FyZHMKPiAK
PiBNYXJjZWwKCnBpbmcKCml0J3MgYmVlbiBhIG1vbnRoIC4uLgoKSSdtIHdvcmtpbmcgb24gY2xl
YW5pbmcgdXAgbW9kdWxlL2RldmljZSByZW1vdmFsIGluIHZpcnRpbyBhbmQgYnQKaXMga2luZCBv
ZiBzdGlja2luZyBvdXQuCgotLSAKTVNUCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30E6EB64DD
	for <virtualization@archiver.kernel.org>; Tue, 25 Jul 2023 03:08:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50FBE40A00;
	Tue, 25 Jul 2023 03:08:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 50FBE40A00
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BnKozPRi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R3qnu8zfPxx0; Tue, 25 Jul 2023 03:07:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AC18F410B5;
	Tue, 25 Jul 2023 03:07:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC18F410B5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EA8AC0072;
	Tue, 25 Jul 2023 03:07:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD0ADC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 03:07:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8438F8146C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 03:07:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8438F8146C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BnKozPRi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MFJr25LUfp71
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 03:07:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6D1588146B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 03:07:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D1588146B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690254475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VsrFcx7CKuChRWMATh1+NSjWHNvI5lnlCZ+wKzBTyhE=;
 b=BnKozPRiTrK8Bllwqg+dlerJSSnRz5wyizWdq7HCGuZl3SeFyu/JCB2JyPSZ1k0lzptyNy
 eKT5mrnA09nPz8m9C2ylh92q9D8hEPcOmU8U58iM5ExtJQ4AwsywZrWFt600KB+h/xIRVt
 Ub9zrgdmpr5r8Do7IuRy3sB4hWVCYkg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-Vv7tbFeSNmy1U2SIQypReg-1; Mon, 24 Jul 2023 23:07:53 -0400
X-MC-Unique: Vv7tbFeSNmy1U2SIQypReg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b9525b64d2so41084111fa.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 20:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690254472; x=1690859272;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VsrFcx7CKuChRWMATh1+NSjWHNvI5lnlCZ+wKzBTyhE=;
 b=hUpORuiq8RNvF9+JrVNTL2mAOIKZAGIEF44blS4Sq7IxAYe+1s0bxJeF0IryN9J8mH
 d3AbZ32Gi112SAQTheTuUmT5RcINY6iivcaWZUZViTQSe0oruBqZ65N4UBO8c+JljPdJ
 7N5uP1/DDpxxcBRNswbPBfo6ZVV998HgyjlnjNUtj9l7vOxNG9q4TUkMTnYSaYCM1EuG
 hB+sNmgA/MpUUgYjez0jw2E9EU9pPuYhmVfrKITqqK+W7YRJ3PF2r25uUbRwoxkS6sT2
 c1rJc60n9IWv5K3bOHDboWWcHInmPJElDdDl5lBdWh4Rl6t1uNJeQcLCozlkYgJPwujx
 sGuw==
X-Gm-Message-State: ABy/qLZ172d4qIOWmX/HMcRHcXAFjsc8XEK6WF4C5iafOyj6xtTuMC2D
 2LYz9iFGGv3qW9oJx2fmmPEDkjVHGpqx0j8t+UbbEUcqObZFNQ9ODz/KQEv1JtU6FrIodo25FDZ
 bWGhQGZLhWeo2Q3A3kghB+J1+C3pb4/RHTw8qnsaewguVwHkvbyItqhqV8A==
X-Received: by 2002:a2e:92d0:0:b0:2b4:65bf:d7b with SMTP id
 k16-20020a2e92d0000000b002b465bf0d7bmr6750641ljh.2.1690254471984; 
 Mon, 24 Jul 2023 20:07:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFldEasInu8/EU/4WmFQMOs6DD/Y7YsaR0vjQ1PPmGDpzLFjM8Ou0Nzwjk+3kPaljEexhz/8vzlaUYQeVLu7N4=
X-Received: by 2002:a2e:92d0:0:b0:2b4:65bf:d7b with SMTP id
 k16-20020a2e92d0000000b002b465bf0d7bmr6750625ljh.2.1690254471671; Mon, 24 Jul
 2023 20:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230720083839.481487-1-jasowang@redhat.com>
 <20230720083839.481487-3-jasowang@redhat.com>
 <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
 <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
 <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
 <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
 <20230724025720-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230724025720-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Jul 2023 11:07:40 +0800
Message-ID: <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, edumazet@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

T24gTW9uLCBKdWwgMjQsIDIwMjMgYXQgMzoxN+KAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gTW9uLCBKdWwgMjQsIDIwMjMgYXQgMDI6NTI6MDVQ
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IE9uIFNhdCwgSnVsIDIyLCAyMDIzIGF0IDQ6
MTjigK9BTSBNYXhpbWUgQ29xdWVsaW4KPiA+IDxtYXhpbWUuY29xdWVsaW5AcmVkaGF0LmNvbT4g
d3JvdGU6Cj4gPiA+Cj4gPiA+Cj4gPiA+Cj4gPiA+IE9uIDcvMjEvMjMgMTc6MTAsIE1pY2hhZWwg
Uy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiBPbiBGcmksIEp1bCAyMSwgMjAyMyBhdCAwNDo1ODow
NFBNICswMjAwLCBNYXhpbWUgQ29xdWVsaW4gd3JvdGU6Cj4gPiA+ID4+Cj4gPiA+ID4+Cj4gPiA+
ID4+IE9uIDcvMjEvMjMgMTY6NDUsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPj4+
IE9uIEZyaSwgSnVsIDIxLCAyMDIzIGF0IDA0OjM3OjAwUE0gKzAyMDAsIE1heGltZSBDb3F1ZWxp
biB3cm90ZToKPiA+ID4gPj4+Pgo+ID4gPiA+Pj4+Cj4gPiA+ID4+Pj4gT24gNy8yMC8yMyAyMzow
MiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+Pj4+PiBPbiBUaHUsIEp1bCAyMCwg
MjAyMyBhdCAwMToyNjoyMFBNIC0wNzAwLCBTaGFubm9uIE5lbHNvbiB3cm90ZToKPiA+ID4gPj4+
Pj4+IE9uIDcvMjAvMjMgMTozOCBBTSwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPj4+Pj4+Pgo+
ID4gPiA+Pj4+Pj4+IEFkZGluZyBjb25kX3Jlc2NoZWQoKSB0byB0aGUgY29tbWFuZCB3YWl0aW5n
IGxvb3AgZm9yIGEgYmV0dGVyCj4gPiA+ID4+Pj4+Pj4gY28tb3BlcmF0aW9uIHdpdGggdGhlIHNj
aGVkdWxlci4gVGhpcyBhbGxvd3MgdG8gZ2l2ZSBDUFUgYSBicmVhdGggdG8KPiA+ID4gPj4+Pj4+
PiBydW4gb3RoZXIgdGFzayh3b3JrcXVldWUpIGluc3RlYWQgb2YgYnVzeSBsb29waW5nIHdoZW4g
cHJlZW1wdGlvbiBpcwo+ID4gPiA+Pj4+Pj4+IG5vdCBhbGxvd2VkIG9uIGEgZGV2aWNlIHdob3Nl
IENWUSBtaWdodCBiZSBzbG93Lgo+ID4gPiA+Pj4+Pj4+Cj4gPiA+ID4+Pj4+Pj4gU2lnbmVkLW9m
Zi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiA+ID4gPj4+Pj4+Cj4gPiA+
ID4+Pj4+PiBUaGlzIHN0aWxsIGxlYXZlcyBodW5nIHByb2Nlc3NlcywgYnV0IGF0IGxlYXN0IGl0
IGRvZXNuJ3QgcGluIHRoZSBDUFUgYW55Cj4gPiA+ID4+Pj4+PiBtb3JlLiAgVGhhbmtzLgo+ID4g
PiA+Pj4+Pj4gUmV2aWV3ZWQtYnk6IFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQu
Y29tPgo+ID4gPiA+Pj4+Pj4KPiA+ID4gPj4+Pj4KPiA+ID4gPj4+Pj4gSSdkIGxpa2UgdG8gc2Vl
IGEgZnVsbCBzb2x1dGlvbgo+ID4gPiA+Pj4+PiAxLSBibG9jayB1bnRpbCBpbnRlcnJ1cHQKPiA+
Cj4gPiBJIHJlbWVtYmVyIGluIHByZXZpb3VzIHZlcnNpb25zLCB5b3Ugd29ycmllZCBhYm91dCB0
aGUgZXh0cmEgTVNJCj4gPiB2ZWN0b3IuIChNYXliZSBJIHdhcyB3cm9uZykuCj4gPgo+ID4gPiA+
Pj4+Cj4gPiA+ID4+Pj4gV291bGQgaXQgbWFrZSBzZW5zZSB0byBhbHNvIGhhdmUgYSB0aW1lb3V0
Pwo+ID4gPiA+Pj4+IEFuZCB3aGVuIHRpbWVvdXQgZXhwaXJlcywgc2V0IEZBSUxFRCBiaXQgaW4g
ZGV2aWNlIHN0YXR1cz8KPiA+ID4gPj4+Cj4gPiA+ID4+PiB2aXJ0aW8gc3BlYyBkb2VzIG5vdCBz
ZXQgYW55IGxpbWl0cyBvbiB0aGUgdGltaW5nIG9mIHZxCj4gPiA+ID4+PiBwcm9jZXNzaW5nLgo+
ID4gPiA+Pgo+ID4gPiA+PiBJbmRlZWQsIGJ1dCBJIHRob3VnaHQgdGhlIGRyaXZlciBjb3VsZCBk
ZWNpZGUgaXQgaXMgdG9vIGxvbmcgZm9yIGl0Lgo+ID4gPiA+Pgo+ID4gPiA+PiBUaGUgaXNzdWUg
aXMgd2Uga2VlcCB3YWl0aW5nIHdpdGggcnRubCBsb2NrZWQsIGl0IGNhbiBxdWlja2x5IG1ha2Ug
dGhlCj4gPiA+ID4+IHN5c3RlbSB1bnVzYWJsZS4KPiA+ID4gPgo+ID4gPiA+IGlmIHRoaXMgaXMg
YSBwcm9ibGVtIHdlIHNob3VsZCBmaW5kIGEgd2F5IG5vdCB0byBrZWVwIHJ0bmwKPiA+ID4gPiBs
b2NrZWQgaW5kZWZpbml0ZWx5Lgo+ID4KPiA+IEFueSBpZGVhcyBvbiB0aGlzIGRpcmVjdGlvbj8g
U2ltcGx5IGRyb3BwaW5nIHJ0bmwgZHVyaW5nIHRoZSBidXN5IGxvb3AKPiA+IHdpbGwgcmVzdWx0
IGluIGEgbG90IG9mIHJhY2VzLiBUaGlzIHNlZW1zIHRvIHJlcXVpcmUgbm9uLXRyaXZpYWwKPiA+
IGNoYW5nZXMgaW4gdGhlIG5ldHdvcmtpbmcgY29yZS4KPiA+Cj4gPiA+Cj4gPiA+ICBGcm9tIHRo
ZSB0ZXN0cyBJIGhhdmUgZG9uZSwgSSB0aGluayBpdCBpcy4gV2l0aCBPVlMsIGEgcmVjb25maWd1
cmF0aW9uCj4gPiA+IGlzIHBlcmZvcm1lZCB3aGVuIHRoZSBWRFVTRSBkZXZpY2UgaXMgYWRkZWQs
IGFuZCB3aGVuIGEgTUxYNSBkZXZpY2UgaXMKPiA+ID4gaW4gdGhlIHNhbWUgYnJpZGdlLCBpdCBl
bmRzIHVwIGRvaW5nIGFuIGlvY3RsKCkgdGhhdCB0cmllcyB0byB0YWtlIHRoZQo+ID4gPiBydG5s
IGxvY2suIEluIHRoaXMgY29uZmlndXJhdGlvbiwgaXQgaXMgbm90IHBvc3NpYmxlIHRvIGtpbGwg
T1ZTIGJlY2F1c2UKPiA+ID4gaXQgaXMgc3R1Y2sgdHJ5aW5nIHRvIGFjcXVpcmUgcnRubCBsb2Nr
IGZvciBtbHg1IHRoYXQgaXMgaGVsZCBieSB2aXJ0aW8tCj4gPiA+IG5ldC4KPiA+Cj4gPiBZZWFo
LCBiYXNpY2FsbHksIGFueSBSVE5MIHVzZXJzIHdvdWxkIGJlIGJsb2NrZWQgZm9yZXZlci4KPiA+
Cj4gPiBBbmQgdGhlIGluZmluaXRlIGxvb3AgaGFzIG90aGVyIHNpZGUgZWZmZWN0cyBsaWtlIGl0
IGJsb2NrcyB0aGUgZnJlZXplciB0byB3b3JrLgo+ID4KPiA+IFRvIHN1bW1hcml6ZSwgdGhlcmUg
YXJlIHRocmVlIGlzc3Vlcwo+ID4KPiA+IDEpIGJ1c3kgcG9sbGluZwo+ID4gMikgYnJlYWtzIGZy
ZWV6ZXIKPiA+IDMpIGhvbGQgUlROTCBkdXJpbmcgdGhlIGxvb3AKPiA+Cj4gPiBTb2x2aW5nIDMg
bWF5IGhlbHAgc29tZWhvdyBmb3IgMiBlLmcgc29tZSBwbSByb3V0aW5lIGUuZyB3aXJlZ3VhcmQg
b3IKPiA+IGV2ZW4gdmlydG5ldF9yZXN0b3JlKCkgaXRzZWxmIG1heSB0cnkgdG8gaG9sZCB0aGUg
bG9jay4KPgo+IFllcC4gU28gbXkgZmVlbGluZyBjdXJyZW50bHkgaXMsIHRoZSBvbmx5IHJlYWwg
Zml4IGlzIHRvIGFjdHVhbGx5Cj4gcXVldWUgdXAgdGhlIHdvcmsgaW4gc29mdHdhcmUuCgpEbyB5
b3UgbWVhbiBzb21ldGhpbmcgbGlrZToKCnJ0bmxfbG9jaygpOwpxdWV1ZSB1cCB0aGUgd29yawpy
dG5sX3VubG9jaygpOwpyZXR1cm4gc3VjY2VzczsKCj8KCj4gSXQncyBtb3N0bHkgdHJpdmlhbCB0
byBsaW1pdAo+IG1lbW9yeSBjb25zdW1wdGlvbiwgdmlkJ3MgaXMgdGhlCj4gb25seSBvbmUgd2hl
cmUgaXQgd291bGQgbWFrZSBzZW5zZSB0byBoYXZlIG1vcmUgdGhhbgo+IDEgY29tbWFuZCBvZiBh
IGdpdmVuIHR5cGUgb3V0c3RhbmRpbmcuCgpBbmQgcnggbW9kZSBzbyB0aGlzIGltcGxpZXMgd2Ug
d2lsbCBmYWlsIGFueSBjb21tYW5kIGlmIHRoZSBwcmV2aW91cwp3b3JrIGlzIG5vdCBmaW5pc2hl
ZC4KCj4gaGF2ZSBhIHRyZWUKPiBvciBhIGJpdG1hcCB3aXRoIHZpZHMgdG8gYWRkL3JlbW92ZT8K
ClByb2JhYmx5LgoKVGhhbmtzCgo+Cj4KPgo+ID4gPgo+ID4gPiA+Cj4gPiA+ID4+Pj4+IDItIHN0
aWxsIGhhbmRsZSBzdXJwcmlzZSByZW1vdmFsIGNvcnJlY3RseSBieSB3YWtpbmcgaW4gdGhhdCBj
YXNlCj4gPgo+ID4gVGhpcyBpcyBiYXNpY2FsbHkgd2hhdCB2ZXJzaW9uIDEgZGlkPwo+ID4KPiA+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvNjAyNmU4MDEtNmZkYS1mZWU5LWE2OWItZDA2
YTgwMzY4NjIxQHJlZGhhdC5jb20vdC8KPiA+Cj4gPiBUaGFua3MKPgo+IFllcyAtIGV4Y2VwdCB0
aGUgdGltZW91dCBwYXJ0Lgo+Cj4KPiA+ID4gPj4+Pj4KPiA+ID4gPj4+Pj4KPiA+ID4gPj4+Pj4K
PiA+ID4gPj4+Pj4+PiAtLS0KPiA+ID4gPj4+Pj4+PiAgICAgIGRyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYyB8IDQgKysrLQo+ID4gPiA+Pj4+Pj4+ICAgICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4gPiA+Pj4+Pj4+Cj4gPiA+ID4+Pj4+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
Ywo+ID4gPiA+Pj4+Pj4+IGluZGV4IDlmM2IxZDZhYzMzZC4uZTc1MzNmMjliMjE5IDEwMDY0NAo+
ID4gPiA+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+Pj4+Pj4+
ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+Pj4+Pj4+IEBAIC0yMzE0LDgg
KzIzMTQsMTAgQEAgc3RhdGljIGJvb2wgdmlydG5ldF9zZW5kX2NvbW1hbmQoc3RydWN0IHZpcnRu
ZXRfaW5mbyAqdmksIHU4IGNsYXNzLCB1OCBjbWQsCj4gPiA+ID4+Pj4+Pj4gICAgICAgICAgICAg
ICogaW50byB0aGUgaHlwZXJ2aXNvciwgc28gdGhlIHJlcXVlc3Qgc2hvdWxkIGJlIGhhbmRsZWQg
aW1tZWRpYXRlbHkuCj4gPiA+ID4+Pj4+Pj4gICAgICAgICAgICAgICovCj4gPiA+ID4+Pj4+Pj4g
ICAgICAgICAgICAgd2hpbGUgKCF2aXJ0cXVldWVfZ2V0X2J1Zih2aS0+Y3ZxLCAmdG1wKSAmJgo+
ID4gPiA+Pj4+Pj4+IC0gICAgICAgICAgICAgICF2aXJ0cXVldWVfaXNfYnJva2VuKHZpLT5jdnEp
KQo+ID4gPiA+Pj4+Pj4+ICsgICAgICAgICAgICAgICF2aXJ0cXVldWVfaXNfYnJva2VuKHZpLT5j
dnEpKSB7Cj4gPiA+ID4+Pj4+Pj4gKyAgICAgICAgICAgICAgIGNvbmRfcmVzY2hlZCgpOwo+ID4g
PiA+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgY3B1X3JlbGF4KCk7Cj4gPiA+ID4+Pj4+Pj4g
KyAgICAgICB9Cj4gPiA+ID4+Pj4+Pj4KPiA+ID4gPj4+Pj4+PiAgICAgICAgICAgICByZXR1cm4g
dmktPmN0cmwtPnN0YXR1cyA9PSBWSVJUSU9fTkVUX09LOwo+ID4gPiA+Pj4+Pj4+ICAgICAgfQo+
ID4gPiA+Pj4+Pj4+IC0tCj4gPiA+ID4+Pj4+Pj4gMi4zOS4zCj4gPiA+ID4+Pj4+Pj4KPiA+ID4g
Pj4+Pj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
ID4gPiA+Pj4+Pj4+IFZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdAo+ID4gPiA+Pj4+Pj4+IFZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj4gPiA+ID4+Pj4+Pj4gaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24KPiA+ID4gPj4+Pj4KPiA+ID4gPj4+Cj4gPiA+ID4KPiA+ID4KPgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

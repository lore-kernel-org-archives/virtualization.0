Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DE4C7EE37
	for <virtualization@archiver.kernel.org>; Tue,  6 Jun 2023 12:58:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4CE2140BCB;
	Tue,  6 Jun 2023 12:58:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4CE2140BCB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VMQ+Roar
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZyUBy2OmKUCl; Tue,  6 Jun 2023 12:58:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A6F2840121;
	Tue,  6 Jun 2023 12:58:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A6F2840121
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B74DC007A;
	Tue,  6 Jun 2023 12:58:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E26FFC0029
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 12:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BCDFC60FC7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 12:58:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BCDFC60FC7
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VMQ+Roar
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A9XO9yWRqvZM
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 12:58:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5981360FA3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5981360FA3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 12:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686056295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dtuylhemCFrocIQz72z/IvBRItNMZNPZwOBB6roSRDM=;
 b=VMQ+Roar/LRQZyjUSGQq/wpJkzdCHsZ2NNzjluy+ipew6O43Gnuiwoud+Mxmsaeyi3pzyx
 agTH1wyUPHIU3HmWNv70mQJHLBekU0brpjSN+UjoRSRR43IaAntHiZLXVwjRhtqs4lNYjD
 lgpgjm6NgZcVfdcfOLGHjkBvEzIOwGs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-j2XDJxgOPjOmvz9GdEMvEA-1; Tue, 06 Jun 2023 08:58:12 -0400
X-MC-Unique: j2XDJxgOPjOmvz9GdEMvEA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f70f9995aeso29974545e9.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Jun 2023 05:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686056291; x=1688648291;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dtuylhemCFrocIQz72z/IvBRItNMZNPZwOBB6roSRDM=;
 b=fUu2ERKcxyyNlSw8LjdGfo+4ITWReDqMOWhvyKifpsNixlA2jk9ZHiYixaHbUp6KnA
 5hmQDEx0k/nKs028/fdz26EPWot8hsbiwHcWjyzI3u2U9T1lAscrfMfd63Xc0D24toML
 6nPHgnbXlI5P5L2nI2oLpuhKXTQDnxbEKeCEEvnD5g+XDF3zlBk0NCe9aVTsKBnlmdgL
 o0X7b3ES/SeIyyqNPaJNDU9i6aCz8x6C48wCWfzts/PT4woiKqTalvIQ+vRHig6A11Tu
 jWweTfvsjGKr7cAluXjAK0Wyyb55prumZMxJ5DP608jE5PLleB8bo3tFIzrg7B+98X8a
 GVcg==
X-Gm-Message-State: AC+VfDxmSpHdzcqIe62DD2gN5DelIFNPGeLljbuMlXy0lRFlubhpigFY
 xTbU9cZRQBq+pOuwF7NWdx5cVyWTeqee3d6autQ0878aDBVeruvSxg+HoAkR5xx99GNBUySI7LQ
 pxRNFJ91yKogxIb8KMK1U6LyIFFj1P0fjXNzZYZhezQ==
X-Received: by 2002:a05:600c:3797:b0:3f4:2492:a91f with SMTP id
 o23-20020a05600c379700b003f42492a91fmr1985697wmr.27.1686056291607; 
 Tue, 06 Jun 2023 05:58:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7iSPeYaUH/YZk+7SBXsnFurRNoLRH/Yr/5f9n7h0h6HrxGNUlFSlQiPwqzijjD8yGHRwJDSg==
X-Received: by 2002:a05:600c:3797:b0:3f4:2492:a91f with SMTP id
 o23-20020a05600c379700b003f42492a91fmr1985683wmr.27.1686056291295; 
 Tue, 06 Jun 2023 05:58:11 -0700 (PDT)
Received: from redhat.com ([2.55.41.2]) by smtp.gmail.com with ESMTPSA id
 q25-20020a7bce99000000b003eddc6aa5fasm17487714wmj.39.2023.06.06.05.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 05:58:10 -0700 (PDT)
Date: Tue, 6 Jun 2023 08:58:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <20230606085643-mutt-send-email-mst@kernel.org>
References: <20230605110644.151211-1-sgarzare@redhat.com>
 <20230605084104-mutt-send-email-mst@kernel.org>
 <24fjdwp44hovz3d3qkzftmvjie45er3g3boac7aezpvzbwvuol@lmo47ydvnqau>
 <20230605085840-mutt-send-email-mst@kernel.org>
 <gi2hngx3ndsgz5d2rpqjywdmou5vxhd7xgi5z2lbachr7yoos4@kpifz37oz2et>
 <20230605095404-mutt-send-email-mst@kernel.org>
 <32ejjuvhvcicv7wjuetkv34qtlpa657n4zlow4eq3fsi2twozk@iqnd2t5tw2an>
 <CACGkMEu3PqQ99UoKF5NHgVADD3q=BF6jhLiyumeT4S1QCqN1tw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEu3PqQ99UoKF5NHgVADD3q=BF6jhLiyumeT4S1QCqN1tw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, Tiwei Bie <tiwei.bie@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
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

T24gVHVlLCBKdW4gMDYsIDIwMjMgYXQgMDk6Mjk6MjJBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBNb24sIEp1biA1LCAyMDIzIGF0IDEwOjU44oCvUE0gU3RlZmFubyBHYXJ6YXJlbGxh
IDxzZ2FyemFyZUByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBNb24sIEp1biAwNSwgMjAy
MyBhdCAwOTo1NDo1N0FNIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+T24g
TW9uLCBKdW4gMDUsIDIwMjMgYXQgMDM6MzA6MzVQTSArMDIwMCwgU3RlZmFubyBHYXJ6YXJlbGxh
IHdyb3RlOgo+ID4gPj4gT24gTW9uLCBKdW4gMDUsIDIwMjMgYXQgMDk6MDA6MjVBTSAtMDQwMCwg
TWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPj4gPiBPbiBNb24sIEp1biAwNSwgMjAyMyBh
dCAwMjo1NDoyMFBNICswMjAwLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gPiA+PiA+ID4g
T24gTW9uLCBKdW4gMDUsIDIwMjMgYXQgMDg6NDE6NTRBTSAtMDQwMCwgTWljaGFlbCBTLiBUc2ly
a2luIHdyb3RlOgo+ID4gPj4gPiA+ID4gT24gTW9uLCBKdW4gMDUsIDIwMjMgYXQgMDE6MDY6NDRQ
TSArMDIwMCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+ID4gPj4gPiA+ID4gPiB2aG9zdC12
ZHBhIElPQ1RMcyAoZWcuIFZIT1NUX0dFVF9WUklOR19CQVNFLCBWSE9TVF9TRVRfVlJJTkdfQkFT
RSkKPiA+ID4+ID4gPiA+ID4gZG9uJ3Qgc3VwcG9ydCBwYWNrZWQgdmlydHF1ZXVlIHdlbGwgeWV0
LCBzbyBsZXQncyBmaWx0ZXIgdGhlCj4gPiA+PiA+ID4gPiA+IFZJUlRJT19GX1JJTkdfUEFDS0VE
IGZlYXR1cmUgZm9yIG5vdyBpbiB2aG9zdF92ZHBhX2dldF9mZWF0dXJlcygpLgo+ID4gPj4gPiA+
ID4gPgo+ID4gPj4gPiA+ID4gPiBUaGlzIHdheSwgZXZlbiBpZiB0aGUgZGV2aWNlIHN1cHBvcnRz
IGl0LCB3ZSBkb24ndCByaXNrIGl0IGJlaW5nCj4gPiA+PiA+ID4gPiA+IG5lZ290aWF0ZWQsIHRo
ZW4gdGhlIFZNTSBpcyB1bmFibGUgdG8gc2V0IHRoZSB2cmluZyBzdGF0ZSBwcm9wZXJseS4KPiA+
ID4+ID4gPiA+ID4KPiA+ID4+ID4gPiA+ID4gRml4ZXM6IDRjOGNmMzE4ODVmNiAoInZob3N0OiBp
bnRyb2R1Y2UgdkRQQS1iYXNlZCBiYWNrZW5kIikKPiA+ID4+ID4gPiA+ID4gQ2M6IHN0YWJsZUB2
Z2VyLmtlcm5lbC5vcmcKPiA+ID4+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6
YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+ID4gPj4gPiA+ID4gPiAtLS0KPiA+ID4+ID4g
PiA+ID4KPiA+ID4+ID4gPiA+ID4gTm90ZXM6Cj4gPiA+PiA+ID4gPiA+ICAgICBUaGlzIHBhdGNo
IHNob3VsZCBiZSBhcHBsaWVkIGJlZm9yZSB0aGUgIltQQVRDSCB2MiAwLzNdIHZob3N0X3ZkcGE6
Cj4gPiA+PiA+ID4gPiA+ICAgICBiZXR0ZXIgUEFDS0VEIHN1cHBvcnQiIHNlcmllcyBbMV0gYW5k
IGJhY2twb3J0ZWQgaW4gc3RhYmxlIGJyYW5jaGVzLgo+ID4gPj4gPiA+ID4gPgo+ID4gPj4gPiA+
ID4gPiAgICAgV2UgY2FuIHJldmVydCBpdCB3aGVuIHdlIGFyZSBzdXJlIHRoYXQgZXZlcnl0aGlu
ZyBpcyB3b3JraW5nIHdpdGgKPiA+ID4+ID4gPiA+ID4gICAgIHBhY2tlZCB2aXJ0cXVldWVzLgo+
ID4gPj4gPiA+ID4gPgo+ID4gPj4gPiA+ID4gPiAgICAgVGhhbmtzLAo+ID4gPj4gPiA+ID4gPiAg
ICAgU3RlZmFubwo+ID4gPj4gPiA+ID4gPgo+ID4gPj4gPiA+ID4gPiAgICAgWzFdIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL3ZpcnR1YWxpemF0aW9uLzIwMjMwNDI0MjI1MDMxLjE4OTQ3LTEtc2hh
bm5vbi5uZWxzb25AYW1kLmNvbS8KPiA+ID4+ID4gPiA+Cj4gPiA+PiA+ID4gPiBJJ20gYSBiaXQg
bG9zdCBoZXJlLiBTbyB3aHkgYW0gSSBtZXJnaW5nICJiZXR0ZXIgUEFDS0VEIHN1cHBvcnQiIHRo
ZW4/Cj4gPiA+PiA+ID4KPiA+ID4+ID4gPiBUbyByZWFsbHkgc3VwcG9ydCBwYWNrZWQgdmlydHF1
ZXVlIHdpdGggdmhvc3QtdmRwYSwgYXQgdGhhdCBwb2ludCB3ZSB3b3VsZAo+ID4gPj4gPiA+IGFs
c28gaGF2ZSB0byByZXZlcnQgdGhpcyBwYXRjaC4KPiA+ID4+ID4gPgo+ID4gPj4gPiA+IEkgd2Fz
bid0IHN1cmUgaWYgeW91IHdhbnRlZCB0byBxdWV1ZSB0aGUgc2VyaWVzIGZvciB0aGlzIG1lcmdl
IHdpbmRvdy4KPiA+ID4+ID4gPiBJbiB0aGF0IGNhc2UgZG8geW91IHRoaW5rIGl0IGlzIGJldHRl
ciB0byBzZW5kIHRoaXMgcGF0Y2ggb25seSBmb3Igc3RhYmxlCj4gPiA+PiA+ID4gYnJhbmNoZXM/
Cj4gPiA+PiA+ID4gPiBEb2VzIHRoaXMgcGF0Y2ggbWFrZSB0aGVtIGEgTk9QPwo+ID4gPj4gPiA+
Cj4gPiA+PiA+ID4gWWVwLCBhZnRlciBhcHBseWluZyB0aGUgImJldHRlciBQQUNLRUQgc3VwcG9y
dCIgc2VyaWVzIGFuZCBiZWluZwo+ID4gPj4gPiA+IHN1cmUgdGhhdAo+ID4gPj4gPiA+IHRoZSBJ
T0NUTHMgb2Ygdmhvc3QtdmRwYSBzdXBwb3J0IHBhY2tlZCB2aXJ0cXVldWUsIHdlIHNob3VsZCBy
ZXZlcnQgdGhpcwo+ID4gPj4gPiA+IHBhdGNoLgo+ID4gPj4gPiA+Cj4gPiA+PiA+ID4gTGV0IG1l
IGtub3cgaWYgeW91IHByZWZlciBhIGRpZmZlcmVudCBhcHByb2FjaC4KPiA+ID4+ID4gPgo+ID4g
Pj4gPiA+IEknbSBjb25jZXJuZWQgdGhhdCBRRU1VIHVzZXMgdmhvc3QtdmRwYSBJT0NUTHMgdGhp
bmtpbmcgdGhhdCB0aGUga2VybmVsCj4gPiA+PiA+ID4gaW50ZXJwcmV0cyB0aGVtIHRoZSByaWdo
dCB3YXksIHdoZW4gaXQgZG9lcyBub3QuCj4gPiA+PiA+ID4KPiA+ID4+ID4gPiBUaGFua3MsCj4g
PiA+PiA+ID4gU3RlZmFubwo+ID4gPj4gPiA+Cj4gPiA+PiA+Cj4gPiA+PiA+IElmIHRoaXMgZml4
ZXMgYSBidWcgY2FuIHlvdSBhZGQgRml4ZXMgdGFncyB0byBlYWNoIG9mIHRoZW0/IFRoZW4gaXQn
cyBvawo+ID4gPj4gPiB0byBtZXJnZSBpbiB0aGlzIHdpbmRvdy4gUHJvYmFibHkgZWFzaWVyIHRo
YW4gdGhlIGVsYWJvcmF0ZQo+ID4gPj4gPiBtYXNrL3VubWFzayBkYW5jZS4KPiA+ID4+Cj4gPiA+
PiBDQ2luZyBTaGFubm9uICh0aGUgb3JpZ2luYWwgYXV0aG9yIG9mIHRoZSAiYmV0dGVyIFBBQ0tF
RCBzdXBwb3J0Igo+ID4gPj4gc2VyaWVzKS4KPiA+ID4+Cj4gPiA+PiBJSVVDIFNoYW5ub24gaXMg
Z29pbmcgdG8gc2VuZCBhIHYzIG9mIHRoYXQgc2VyaWVzIHRvIGZpeCB0aGUKPiA+ID4+IGRvY3Vt
ZW50YXRpb24sIHNvIFNoYW5ub24gY2FuIHlvdSBhbHNvIGFkZCB0aGUgRml4ZXMgdGFncz8KPiA+
ID4+Cj4gPiA+PiBUaGFua3MsCj4gPiA+PiBTdGVmYW5vCj4gPiA+Cj4gPiA+V2VsbCB0aGlzIGlz
IGluIG15IHRyZWUgYWxyZWFkeS4gSnVzdCByZXBseSB3aXRoCj4gPiA+Rml4ZXM6IDw+Cj4gPiA+
dG8gZWFjaCBhbmQgSSB3aWxsIGFkZCB0aGVzZSB0YWdzLgo+ID4KPiA+IEkgdHJpZWQsIGJ1dCBp
dCBpcyBub3QgZWFzeSBzaW5jZSB3ZSBhZGRlZCB0aGUgc3VwcG9ydCBmb3IgcGFja2VkCj4gPiB2
aXJ0cXVldWUgaW4gdmRwYSBhbmQgdmhvc3QgaW5jcmVtZW50YWxseS4KPiA+Cj4gPiBJbml0aWFs
bHkgSSB3YXMgdGhpbmtpbmcgb2YgYWRkaW5nIHRoZSBzYW1lIHRhZyB1c2VkIGhlcmU6Cj4gPgo+
ID4gRml4ZXM6IDRjOGNmMzE4ODVmNiAoInZob3N0OiBpbnRyb2R1Y2UgdkRQQS1iYXNlZCBiYWNr
ZW5kIikKPiA+Cj4gPiBUaGVuIEkgZGlzY292ZXJlZCB0aGF0IHZxX3N0YXRlIHdhc24ndCB0aGVy
ZSwgc28gSSB3YXMgdGhpbmtpbmcgb2YKPiA+Cj4gPiBGaXhlczogNTMwYTU2NzhiYzAwICgidmRw
YTogc3VwcG9ydCBwYWNrZWQgdmlydHF1ZXVlIGZvciBzZXQvZ2V0X3ZxX3N0YXRlKCkiKQo+ID4K
PiA+IFNvIHdlIHdvdWxkIGhhdmUgdG8gYmFja3BvcnQgcXVpdGUgYSBmZXcgcGF0Y2hlcyBpbnRv
IHRoZSBzdGFibGUgYnJhbmNoZXMuCj4gPiBJIGRvbid0IGtub3cgaWYgaXQncyB3b3J0aCBpdC4u
Lgo+ID4KPiA+IEkgc3RpbGwgdGhpbmsgaXQgaXMgYmV0dGVyIHRvIGRpc2FibGUgcGFja2VkIGlu
IHRoZSBzdGFibGUgYnJhbmNoZXMsCj4gPiBvdGhlcndpc2UgSSBoYXZlIHRvIG1ha2UgYSBsaXN0
IG9mIGFsbCB0aGUgcGF0Y2hlcyB3ZSBuZWVkLgo+ID4KPiA+IEFueSBvdGhlciBpZGVhcz8KPiAK
PiBBRkFJSywgZXhjZXB0IGZvciB2cF92ZHBhLCBwZHMgc2VlbXMgdG8gYmUgdGhlIGZpcnN0IHBh
cmVudCB0aGF0Cj4gc3VwcG9ydHMgcGFja2VkIHZpcnRxdWV1ZS4gVXNlcnMgc2hvdWxkIG5vdCBu
b3RpY2UgYW55dGhpbmcgd3JvbmcgaWYKPiB0aGV5IGRvbid0IHVzZSBwYWNrZWQgdmlydHF1ZXVl
LiBBbmQgdGhlIHByb2JsZW0gb2YgdnBfdmRwYSArIHBhY2tlZAo+IHZpcnRxdWV1ZSBjYW1lIHNp
bmNlIHRoZSBkYXkwIG9mIHZwX3ZkcGEuIEl0IHNlZW1zIGZpbmUgdG8gZG8gbm90aGluZwo+IEkg
Z3Vlc3MuCj4gCj4gVGhhbmtzCgoKSSBoYXZlIGEgcXVlc3Rpb24gdGhvdWdoLCB3aGF0IGlmIGRv
d24gdGhlIHJvYWQgdGhlcmUKaXMgYSBuZXcgZmVhdHVyZSB0aGF0IG5lZWRzIG1vcmUgY2hhbmdl
cz8gSXQgd2lsbCBiZQpicm9rZW4gdG9vIGp1c3QgbGlrZSBQQUNLRUQgbm8/ClNob3VsZG4ndCB2
ZHBhIGhhdmUgYW4gYWxsb3dsaXN0IG9mIGZlYXR1cmVzIGl0IGtub3dzIGhvdwp0byBzdXBwb3J0
PwoKPiA+Cj4gPiBUaGFua3MsCj4gPiBTdGVmYW5vCj4gPgo+ID4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

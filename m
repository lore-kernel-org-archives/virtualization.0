Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8E8C77B7A
	for <virtualization@archiver.kernel.org>; Tue,  6 Jun 2023 10:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A2B540934;
	Tue,  6 Jun 2023 10:19:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A2B540934
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UxYpqJzn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fNUdBFuy8UGW; Tue,  6 Jun 2023 10:18:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3026B40926;
	Tue,  6 Jun 2023 10:18:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3026B40926
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3678C007A;
	Tue,  6 Jun 2023 10:18:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C918C0029
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 10:18:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 60F6A405A2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 10:18:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 60F6A405A2
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UxYpqJzn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5lBBnxI9LX28
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 10:18:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 36DDD40191
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 36DDD40191
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 10:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686046733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WdTmcarTjpToePhx1ty5NLOSGd6QvPabttahqlaLQ7A=;
 b=UxYpqJznZ4HMxVc8GWNZtU6D6+rM6DIrDnDkWTFFJgcBwGAnWr4pAuFOohrAPdYCSFI1qp
 aNsGEYIYtQCvTEWFTGxEwtq7I64F40WPAxNX2WNAqgPHjbC6PfArhzDTNyWBFa6gEg4NFz
 vlyqSp8nXT61cy7vWFUM6MlBPGfCdX0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-Yxz1TZ8WPvSNcIw3-2sZ0A-1; Tue, 06 Jun 2023 06:18:52 -0400
X-MC-Unique: Yxz1TZ8WPvSNcIw3-2sZ0A-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30ae7bd987dso2575675f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Jun 2023 03:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686046731; x=1688638731;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WdTmcarTjpToePhx1ty5NLOSGd6QvPabttahqlaLQ7A=;
 b=SGqdkZiDUUPf0OmdM0yGLc/c4fX9njvf5iUwukjf8iWV2EKzbTCCGmFcYOyUnc4LRP
 WqPsZCQp7hzUAPFpNGhJmFpqk/ubZBFQh3RaLPcQuqO/8zssuJtTg7oRzOUkZ5VKD6eS
 M6nYs/wJ8pCI3uRNozzgE920JOdOY/qVC79bOVc2CcpEfmfIlJ4GixSp6g0cY5SgDJPB
 IoqhidrF+xHP8JplLbdvwiLXCXjQw7ZAFDLxtcy1e3HN6mGZeygbuikuH7Dd95SZ7/1K
 GcBEjIy6hnRTpsv+0y8sK6QTSTcmh1vbeeiWt3JgfpHovZq3ZOISPcGb9CFD3jwhEoV+
 cNLw==
X-Gm-Message-State: AC+VfDxYxuDYG8GSM3ILvn6g6IPKCmwqo2FQ7wyMF/uHu+KnAuAErvAx
 alO1CfQIZxP0A142hjfjpeWywYFoAkBXkICtxUaXOiDOpBTWRfqy4daPkHt1UOwFTEEOFAYyDGO
 XnaWIbEec4nMSIrrb0BfMDBWiCyUTzlav0/U6XyJj1g==
X-Received: by 2002:adf:ff89:0:b0:30a:8995:1dc3 with SMTP id
 j9-20020adfff89000000b0030a89951dc3mr1371966wrr.55.1686046731708; 
 Tue, 06 Jun 2023 03:18:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Fk6MqA/8GgHa5USB5P2+VXOKgfrHs1qQGdgd9HhZcWc64fMDe2Prhx8xF8VumCgAaHZmb7w==
X-Received: by 2002:adf:ff89:0:b0:30a:8995:1dc3 with SMTP id
 j9-20020adfff89000000b0030a89951dc3mr1371952wrr.55.1686046731415; 
 Tue, 06 Jun 2023 03:18:51 -0700 (PDT)
Received: from sgarzare-redhat (93-44-29-47.ip95.fastwebnet.it. [93.44.29.47])
 by smtp.gmail.com with ESMTPSA id
 hn20-20020a05600ca39400b003f71ad792f2sm2097422wmb.1.2023.06.06.03.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 03:18:50 -0700 (PDT)
Date: Tue, 6 Jun 2023 12:18:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <ufyif62swl2voj3k5wvbiyn4nbfgfzdf46xhr4dtj5jranwwrr@cvtskm6sff3x>
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
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
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

T24gVHVlLCBKdW4gMDYsIDIwMjMgYXQgMDk6Mjk6MjJBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPk9uIE1vbiwgSnVuIDUsIDIwMjMgYXQgMTA6NTjigK9QTSBTdGVmYW5vIEdhcnphcmVsbGEg
PHNnYXJ6YXJlQHJlZGhhdC5jb20+IHdyb3RlOgo+Pgo+PiBPbiBNb24sIEp1biAwNSwgMjAyMyBh
dCAwOTo1NDo1N0FNIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+ID5PbiBNb24s
IEp1biAwNSwgMjAyMyBhdCAwMzozMDozNVBNICswMjAwLCBTdGVmYW5vIEdhcnphcmVsbGEgd3Jv
dGU6Cj4+ID4+IE9uIE1vbiwgSnVuIDA1LCAyMDIzIGF0IDA5OjAwOjI1QU0gLTA0MDAsIE1pY2hh
ZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4gPj4gPiBPbiBNb24sIEp1biAwNSwgMjAyMyBhdCAwMjo1
NDoyMFBNICswMjAwLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4+ID4+ID4gPiBPbiBNb24s
IEp1biAwNSwgMjAyMyBhdCAwODo0MTo1NEFNIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3Jv
dGU6Cj4+ID4+ID4gPiA+IE9uIE1vbiwgSnVuIDA1LCAyMDIzIGF0IDAxOjA2OjQ0UE0gKzAyMDAs
IFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPj4gPj4gPiA+ID4gPiB2aG9zdC12ZHBhIElPQ1RM
cyAoZWcuIFZIT1NUX0dFVF9WUklOR19CQVNFLCBWSE9TVF9TRVRfVlJJTkdfQkFTRSkKPj4gPj4g
PiA+ID4gPiBkb24ndCBzdXBwb3J0IHBhY2tlZCB2aXJ0cXVldWUgd2VsbCB5ZXQsIHNvIGxldCdz
IGZpbHRlciB0aGUKPj4gPj4gPiA+ID4gPiBWSVJUSU9fRl9SSU5HX1BBQ0tFRCBmZWF0dXJlIGZv
ciBub3cgaW4gdmhvc3RfdmRwYV9nZXRfZmVhdHVyZXMoKS4KPj4gPj4gPiA+ID4gPgo+PiA+PiA+
ID4gPiA+IFRoaXMgd2F5LCBldmVuIGlmIHRoZSBkZXZpY2Ugc3VwcG9ydHMgaXQsIHdlIGRvbid0
IHJpc2sgaXQgYmVpbmcKPj4gPj4gPiA+ID4gPiBuZWdvdGlhdGVkLCB0aGVuIHRoZSBWTU0gaXMg
dW5hYmxlIHRvIHNldCB0aGUgdnJpbmcgc3RhdGUgcHJvcGVybHkuCj4+ID4+ID4gPiA+ID4KPj4g
Pj4gPiA+ID4gPiBGaXhlczogNGM4Y2YzMTg4NWY2ICgidmhvc3Q6IGludHJvZHVjZSB2RFBBLWJh
c2VkIGJhY2tlbmQiKQo+PiA+PiA+ID4gPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCj4+
ID4+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUBy
ZWRoYXQuY29tPgo+PiA+PiA+ID4gPiA+IC0tLQo+PiA+PiA+ID4gPiA+Cj4+ID4+ID4gPiA+ID4g
Tm90ZXM6Cj4+ID4+ID4gPiA+ID4gICAgIFRoaXMgcGF0Y2ggc2hvdWxkIGJlIGFwcGxpZWQgYmVm
b3JlIHRoZSAiW1BBVENIIHYyIDAvM10gdmhvc3RfdmRwYToKPj4gPj4gPiA+ID4gPiAgICAgYmV0
dGVyIFBBQ0tFRCBzdXBwb3J0IiBzZXJpZXMgWzFdIGFuZCBiYWNrcG9ydGVkIGluIHN0YWJsZSBi
cmFuY2hlcy4KPj4gPj4gPiA+ID4gPgo+PiA+PiA+ID4gPiA+ICAgICBXZSBjYW4gcmV2ZXJ0IGl0
IHdoZW4gd2UgYXJlIHN1cmUgdGhhdCBldmVyeXRoaW5nIGlzIHdvcmtpbmcgd2l0aAo+PiA+PiA+
ID4gPiA+ICAgICBwYWNrZWQgdmlydHF1ZXVlcy4KPj4gPj4gPiA+ID4gPgo+PiA+PiA+ID4gPiA+
ICAgICBUaGFua3MsCj4+ID4+ID4gPiA+ID4gICAgIFN0ZWZhbm8KPj4gPj4gPiA+ID4gPgo+PiA+
PiA+ID4gPiA+ICAgICBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvdmlydHVhbGl6YXRpb24v
MjAyMzA0MjQyMjUwMzEuMTg5NDctMS1zaGFubm9uLm5lbHNvbkBhbWQuY29tLwo+PiA+PiA+ID4g
Pgo+PiA+PiA+ID4gPiBJJ20gYSBiaXQgbG9zdCBoZXJlLiBTbyB3aHkgYW0gSSBtZXJnaW5nICJi
ZXR0ZXIgUEFDS0VEIHN1cHBvcnQiIHRoZW4/Cj4+ID4+ID4gPgo+PiA+PiA+ID4gVG8gcmVhbGx5
IHN1cHBvcnQgcGFja2VkIHZpcnRxdWV1ZSB3aXRoIHZob3N0LXZkcGEsIGF0IHRoYXQgcG9pbnQg
d2Ugd291bGQKPj4gPj4gPiA+IGFsc28gaGF2ZSB0byByZXZlcnQgdGhpcyBwYXRjaC4KPj4gPj4g
PiA+Cj4+ID4+ID4gPiBJIHdhc24ndCBzdXJlIGlmIHlvdSB3YW50ZWQgdG8gcXVldWUgdGhlIHNl
cmllcyBmb3IgdGhpcyBtZXJnZSB3aW5kb3cuCj4+ID4+ID4gPiBJbiB0aGF0IGNhc2UgZG8geW91
IHRoaW5rIGl0IGlzIGJldHRlciB0byBzZW5kIHRoaXMgcGF0Y2ggb25seSBmb3Igc3RhYmxlCj4+
ID4+ID4gPiBicmFuY2hlcz8KPj4gPj4gPiA+ID4gRG9lcyB0aGlzIHBhdGNoIG1ha2UgdGhlbSBh
IE5PUD8KPj4gPj4gPiA+Cj4+ID4+ID4gPiBZZXAsIGFmdGVyIGFwcGx5aW5nIHRoZSAiYmV0dGVy
IFBBQ0tFRCBzdXBwb3J0IiBzZXJpZXMgYW5kIGJlaW5nCj4+ID4+ID4gPiBzdXJlIHRoYXQKPj4g
Pj4gPiA+IHRoZSBJT0NUTHMgb2Ygdmhvc3QtdmRwYSBzdXBwb3J0IHBhY2tlZCB2aXJ0cXVldWUs
IHdlIHNob3VsZCByZXZlcnQgdGhpcwo+PiA+PiA+ID4gcGF0Y2guCj4+ID4+ID4gPgo+PiA+PiA+
ID4gTGV0IG1lIGtub3cgaWYgeW91IHByZWZlciBhIGRpZmZlcmVudCBhcHByb2FjaC4KPj4gPj4g
PiA+Cj4+ID4+ID4gPiBJJ20gY29uY2VybmVkIHRoYXQgUUVNVSB1c2VzIHZob3N0LXZkcGEgSU9D
VExzIHRoaW5raW5nIHRoYXQgdGhlIGtlcm5lbAo+PiA+PiA+ID4gaW50ZXJwcmV0cyB0aGVtIHRo
ZSByaWdodCB3YXksIHdoZW4gaXQgZG9lcyBub3QuCj4+ID4+ID4gPgo+PiA+PiA+ID4gVGhhbmtz
LAo+PiA+PiA+ID4gU3RlZmFubwo+PiA+PiA+ID4KPj4gPj4gPgo+PiA+PiA+IElmIHRoaXMgZml4
ZXMgYSBidWcgY2FuIHlvdSBhZGQgRml4ZXMgdGFncyB0byBlYWNoIG9mIHRoZW0/IFRoZW4gaXQn
cyBvawo+PiA+PiA+IHRvIG1lcmdlIGluIHRoaXMgd2luZG93LiBQcm9iYWJseSBlYXNpZXIgdGhh
biB0aGUgZWxhYm9yYXRlCj4+ID4+ID4gbWFzay91bm1hc2sgZGFuY2UuCj4+ID4+Cj4+ID4+IEND
aW5nIFNoYW5ub24gKHRoZSBvcmlnaW5hbCBhdXRob3Igb2YgdGhlICJiZXR0ZXIgUEFDS0VEIHN1
cHBvcnQiCj4+ID4+IHNlcmllcykuCj4+ID4+Cj4+ID4+IElJVUMgU2hhbm5vbiBpcyBnb2luZyB0
byBzZW5kIGEgdjMgb2YgdGhhdCBzZXJpZXMgdG8gZml4IHRoZQo+PiA+PiBkb2N1bWVudGF0aW9u
LCBzbyBTaGFubm9uIGNhbiB5b3UgYWxzbyBhZGQgdGhlIEZpeGVzIHRhZ3M/Cj4+ID4+Cj4+ID4+
IFRoYW5rcywKPj4gPj4gU3RlZmFubwo+PiA+Cj4+ID5XZWxsIHRoaXMgaXMgaW4gbXkgdHJlZSBh
bHJlYWR5LiBKdXN0IHJlcGx5IHdpdGgKPj4gPkZpeGVzOiA8Pgo+PiA+dG8gZWFjaCBhbmQgSSB3
aWxsIGFkZCB0aGVzZSB0YWdzLgo+Pgo+PiBJIHRyaWVkLCBidXQgaXQgaXMgbm90IGVhc3kgc2lu
Y2Ugd2UgYWRkZWQgdGhlIHN1cHBvcnQgZm9yIHBhY2tlZAo+PiB2aXJ0cXVldWUgaW4gdmRwYSBh
bmQgdmhvc3QgaW5jcmVtZW50YWxseS4KPj4KPj4gSW5pdGlhbGx5IEkgd2FzIHRoaW5raW5nIG9m
IGFkZGluZyB0aGUgc2FtZSB0YWcgdXNlZCBoZXJlOgo+Pgo+PiBGaXhlczogNGM4Y2YzMTg4NWY2
ICgidmhvc3Q6IGludHJvZHVjZSB2RFBBLWJhc2VkIGJhY2tlbmQiKQo+Pgo+PiBUaGVuIEkgZGlz
Y292ZXJlZCB0aGF0IHZxX3N0YXRlIHdhc24ndCB0aGVyZSwgc28gSSB3YXMgdGhpbmtpbmcgb2YK
Pj4KPj4gRml4ZXM6IDUzMGE1Njc4YmMwMCAoInZkcGE6IHN1cHBvcnQgcGFja2VkIHZpcnRxdWV1
ZSBmb3Igc2V0L2dldF92cV9zdGF0ZSgpIikKPj4KPj4gU28gd2Ugd291bGQgaGF2ZSB0byBiYWNr
cG9ydCBxdWl0ZSBhIGZldyBwYXRjaGVzIGludG8gdGhlIHN0YWJsZSBicmFuY2hlcy4KPj4gSSBk
b24ndCBrbm93IGlmIGl0J3Mgd29ydGggaXQuLi4KPj4KPj4gSSBzdGlsbCB0aGluayBpdCBpcyBi
ZXR0ZXIgdG8gZGlzYWJsZSBwYWNrZWQgaW4gdGhlIHN0YWJsZSBicmFuY2hlcywKPj4gb3RoZXJ3
aXNlIEkgaGF2ZSB0byBtYWtlIGEgbGlzdCBvZiBhbGwgdGhlIHBhdGNoZXMgd2UgbmVlZC4KPj4K
Pj4gQW55IG90aGVyIGlkZWFzPwo+Cj5BRkFJSywgZXhjZXB0IGZvciB2cF92ZHBhLCBwZHMgc2Vl
bXMgdG8gYmUgdGhlIGZpcnN0IHBhcmVudCB0aGF0CgpJSVVDIGFsc28gdmR1c2UgYW5kIHNuZXQg
c3VwcG9ydHMgcGFja2VkIHZpcnRxdWV1ZS4KCj5zdXBwb3J0cyBwYWNrZWQgdmlydHF1ZXVlLiBV
c2VycyBzaG91bGQgbm90IG5vdGljZSBhbnl0aGluZyB3cm9uZyBpZgo+dGhleSBkb24ndCB1c2Ug
cGFja2VkIHZpcnRxdWV1ZS4gQW5kIHRoZSBwcm9ibGVtIG9mIHZwX3ZkcGEgKyBwYWNrZWQKPnZp
cnRxdWV1ZSBjYW1lIHNpbmNlIHRoZSBkYXkwIG9mIHZwX3ZkcGEuIEl0IHNlZW1zIGZpbmUgdG8g
ZG8gbm90aGluZwo+SSBndWVzcy4KCk9rYXksIG1heWJlIEknbSBvdmVydGhpbmtpbmcgaXQsIG5v
dCBoYXZpbmcgYSBzcGVjaWZpYyBwcm9ibGVtIEkgZG9uJ3QKb2JqZWN0LCBpdCB3YXMganVzdCBh
IGNvbmNlcm4gYWJvdXQgdUFQSS4KClRoYW5rcywKU3RlZmFubwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

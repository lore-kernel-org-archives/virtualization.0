Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75021C7EE25
	for <virtualization@archiver.kernel.org>; Thu,  8 Jun 2023 13:43:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F320B40B74;
	Thu,  8 Jun 2023 13:43:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F320B40B74
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RssQ61w9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ixJIgGYbYcLu; Thu,  8 Jun 2023 13:43:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2DB2B402E8;
	Thu,  8 Jun 2023 13:43:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2DB2B402E8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09D9EC007A;
	Thu,  8 Jun 2023 13:43:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A123CC0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 13:43:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 797E340624
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 13:43:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 797E340624
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RssQ61w9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RVUcrr7xiEJV
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 13:43:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C359C405C8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C359C405C8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 13:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686231817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FwwjX0DTQ9pDyVotNAjxvKXjO/18HyPagdYutCSy84o=;
 b=RssQ61w9imqC4tkXHDR1pmoXh9DQo3+ojd4dHmA/HlNSUqTENpmCduGX80ovLHHpU41ljR
 fefpZb5pGdgvkoPXoHfOjoqbDKgdjS9H4xx74z2OuKENYGooBDVMEZXP+DdasUHsLrYypp
 ufgO70+hytcfRziqUiF/FWpcLIkiL/w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-bsuFgfzsN9G01n9cCy33Ow-1; Thu, 08 Jun 2023 09:43:34 -0400
X-MC-Unique: bsuFgfzsN9G01n9cCy33Ow-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3079c6648e3so408033f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Jun 2023 06:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686231813; x=1688823813;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FwwjX0DTQ9pDyVotNAjxvKXjO/18HyPagdYutCSy84o=;
 b=ROf8h7KLQSlMhkCX2ZQjLfSZR4g9ktu6NC4k/bhPnplFyLRoH+J1biXtwruG/86dlL
 lx4AzdJyka7AD7tclu+WmU7xL2kgPehKL2Ios8DbdpvF2Vp0Oh6/2Uc8c5OKSxNI7Awc
 I3jDvliw73cQD8N60JzmAUn402c3i6SHvQu4kltVNxQtGrMRBUZ2uqIc1Cv4M7SeoMIe
 VFZXvWE/H7QSWZmF3XuPc2z+EBd+sscayyhEO7cEYr8QwJxJKwjbWb/7uZour1BU9aJj
 xm8y9I6AlJ3ANq4Pm9pplbWyzbalgr7iaYe5oX946P47+wEpTLRJadI4d3AetBIe8XMy
 diTg==
X-Gm-Message-State: AC+VfDwTUJaOpNSQadASG9uE6+ynNSawyNsjpJITk2flRaCO6Extqg+E
 1Vi5ljjAFIgQf+MxNvEJlAaSpSzd6BcGwq6Up5z6Gj1hGoN4kbD2TGIcl4YI2PUfvA1jcatiz6I
 6YfPc73Dm3BSIokTseQZEn/TSozO3lpWVaRXKnka1sQ==
X-Received: by 2002:adf:f810:0:b0:309:54b6:33b0 with SMTP id
 s16-20020adff810000000b0030954b633b0mr6902331wrp.44.1686231813106; 
 Thu, 08 Jun 2023 06:43:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6l2wxPHxygUqAgwJKdM3ILKyed0BQuYFWwdxlh0hmTm1xDo/3dzFUkr6JPg6f2+5qx75i6Ug==
X-Received: by 2002:adf:f810:0:b0:309:54b6:33b0 with SMTP id
 s16-20020adff810000000b0030954b633b0mr6902313wrp.44.1686231812720; 
 Thu, 08 Jun 2023 06:43:32 -0700 (PDT)
Received: from redhat.com ([2.55.41.2]) by smtp.gmail.com with ESMTPSA id
 l15-20020a1c790f000000b003f7ec54d900sm2054972wme.9.2023.06.08.06.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 06:43:32 -0700 (PDT)
Date: Thu, 8 Jun 2023 09:43:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <20230608094202-mutt-send-email-mst@kernel.org>
References: <gi2hngx3ndsgz5d2rpqjywdmou5vxhd7xgi5z2lbachr7yoos4@kpifz37oz2et>
 <20230605095404-mutt-send-email-mst@kernel.org>
 <32ejjuvhvcicv7wjuetkv34qtlpa657n4zlow4eq3fsi2twozk@iqnd2t5tw2an>
 <CACGkMEu3PqQ99UoKF5NHgVADD3q=BF6jhLiyumeT4S1QCqN1tw@mail.gmail.com>
 <20230606085643-mutt-send-email-mst@kernel.org>
 <CAGxU2F7fkgL-HpZdj=5ZEGNWcESCHQpgRAYQA3W2sPZaoEpNyQ@mail.gmail.com>
 <20230607054246-mutt-send-email-mst@kernel.org>
 <CACGkMEuUapKvUYiJiLwtsN+x941jafDKS9tuSkiNrvkrrSmQkg@mail.gmail.com>
 <20230608020111-mutt-send-email-mst@kernel.org>
 <CACGkMEt4=3BRVNX38AD+mJU8v3bmqO-CdNj5NkFP-SSvsuy2Hg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEt4=3BRVNX38AD+mJU8v3bmqO-CdNj5NkFP-SSvsuy2Hg@mail.gmail.com>
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

T24gVGh1LCBKdW4gMDgsIDIwMjMgYXQgMDM6NDY6MDBQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUaHUsIEp1biA4LCAyMDIzIGF0IDI6MDPigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBUaHUsIEp1biAwOCwgMjAyMyBhdCAw
ODo0MjoxNUFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiBPbiBXZWQsIEp1biA3LCAy
MDIzIGF0IDU6NDPigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90
ZToKPiA+ID4gPgo+ID4gPiA+IE9uIFdlZCwgSnVuIDA3LCAyMDIzIGF0IDEwOjM5OjE1QU0gKzAy
MDAsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiA+ID4gPiA+IE9uIFR1ZSwgSnVuIDYsIDIw
MjMgYXQgMjo1OOKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3Rl
Ogo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBPbiBUdWUsIEp1biAwNiwgMjAyMyBhdCAwOToyOToy
MkFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+IE9uIE1vbiwgSnVuIDUs
IDIwMjMgYXQgMTA6NTjigK9QTSBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5j
b20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IE9uIE1vbiwgSnVuIDA1
LCAyMDIzIGF0IDA5OjU0OjU3QU0gLTA0MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+
ID4gPiA+ID4gPiA+ID5PbiBNb24sIEp1biAwNSwgMjAyMyBhdCAwMzozMDozNVBNICswMjAwLCBT
dGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+PiBPbiBNb24sIEp1biAw
NSwgMjAyMyBhdCAwOTowMDoyNUFNIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4g
PiA+ID4gPiA+ID4gPiA+PiA+IE9uIE1vbiwgSnVuIDA1LCAyMDIzIGF0IDAyOjU0OjIwUE0gKzAy
MDAsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4+ID4gPiBPbiBN
b24sIEp1biAwNSwgMjAyMyBhdCAwODo0MTo1NEFNIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4g
d3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+PiA+ID4gPiBPbiBNb24sIEp1biAwNSwgMjAyMyBhdCAw
MTowNjo0NFBNICswMjAwLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gPiA+ID4gPiA+ID4g
PiA+PiA+ID4gPiA+IHZob3N0LXZkcGEgSU9DVExzIChlZy4gVkhPU1RfR0VUX1ZSSU5HX0JBU0Us
IFZIT1NUX1NFVF9WUklOR19CQVNFKQo+ID4gPiA+ID4gPiA+ID4gPj4gPiA+ID4gPiBkb24ndCBz
dXBwb3J0IHBhY2tlZCB2aXJ0cXVldWUgd2VsbCB5ZXQsIHNvIGxldCdzIGZpbHRlciB0aGUKPiA+
ID4gPiA+ID4gPiA+ID4+ID4gPiA+ID4gVklSVElPX0ZfUklOR19QQUNLRUQgZmVhdHVyZSBmb3Ig
bm93IGluIHZob3N0X3ZkcGFfZ2V0X2ZlYXR1cmVzKCkuCj4gPiA+ID4gPiA+ID4gPiA+PiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiA+PiA+ID4gPiA+IFRoaXMgd2F5LCBldmVuIGlmIHRoZSBkZXZp
Y2Ugc3VwcG9ydHMgaXQsIHdlIGRvbid0IHJpc2sgaXQgYmVpbmcKPiA+ID4gPiA+ID4gPiA+ID4+
ID4gPiA+ID4gbmVnb3RpYXRlZCwgdGhlbiB0aGUgVk1NIGlzIHVuYWJsZSB0byBzZXQgdGhlIHZy
aW5nIHN0YXRlIHByb3Blcmx5Lgo+ID4gPiA+ID4gPiA+ID4gPj4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gPj4gPiA+ID4gPiBGaXhlczogNGM4Y2YzMTg4NWY2ICgidmhvc3Q6IGludHJvZHVjZSB2
RFBBLWJhc2VkIGJhY2tlbmQiKQo+ID4gPiA+ID4gPiA+ID4gPj4gPiA+ID4gPiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZwo+ID4gPiA+ID4gPiA+ID4gPj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4gPiA+ID4gPiA+ID4g
PiA+PiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gPiA+ID4gPj4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
ID4gPj4gPiA+ID4gPiBOb3RlczoKPiA+ID4gPiA+ID4gPiA+ID4+ID4gPiA+ID4gICAgIFRoaXMg
cGF0Y2ggc2hvdWxkIGJlIGFwcGxpZWQgYmVmb3JlIHRoZSAiW1BBVENIIHYyIDAvM10gdmhvc3Rf
dmRwYToKPiA+ID4gPiA+ID4gPiA+ID4+ID4gPiA+ID4gICAgIGJldHRlciBQQUNLRUQgc3VwcG9y
dCIgc2VyaWVzIFsxXSBhbmQgYmFja3BvcnRlZCBpbiBzdGFibGUgYnJhbmNoZXMuCj4gPiA+ID4g
PiA+ID4gPiA+PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+PiA+ID4gPiA+ICAgICBXZSBjYW4g
cmV2ZXJ0IGl0IHdoZW4gd2UgYXJlIHN1cmUgdGhhdCBldmVyeXRoaW5nIGlzIHdvcmtpbmcgd2l0
aAo+ID4gPiA+ID4gPiA+ID4gPj4gPiA+ID4gPiAgICAgcGFja2VkIHZpcnRxdWV1ZXMuCj4gPiA+
ID4gPiA+ID4gPiA+PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+PiA+ID4gPiA+ICAgICBUaGFu
a3MsCj4gPiA+ID4gPiA+ID4gPiA+PiA+ID4gPiA+ICAgICBTdGVmYW5vCj4gPiA+ID4gPiA+ID4g
PiA+PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+PiA+ID4gPiA+ICAgICBbMV0gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvdmlydHVhbGl6YXRpb24vMjAyMzA0MjQyMjUwMzEuMTg5NDctMS1zaGFu
bm9uLm5lbHNvbkBhbWQuY29tLwo+ID4gPiA+ID4gPiA+ID4gPj4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+ID4+ID4gPiA+IEknbSBhIGJpdCBsb3N0IGhlcmUuIFNvIHdoeSBhbSBJIG1lcmdpbmcgImJl
dHRlciBQQUNLRUQgc3VwcG9ydCIgdGhlbj8KPiA+ID4gPiA+ID4gPiA+ID4+ID4gPgo+ID4gPiA+
ID4gPiA+ID4gPj4gPiA+IFRvIHJlYWxseSBzdXBwb3J0IHBhY2tlZCB2aXJ0cXVldWUgd2l0aCB2
aG9zdC12ZHBhLCBhdCB0aGF0IHBvaW50IHdlIHdvdWxkCj4gPiA+ID4gPiA+ID4gPiA+PiA+ID4g
YWxzbyBoYXZlIHRvIHJldmVydCB0aGlzIHBhdGNoLgo+ID4gPiA+ID4gPiA+ID4gPj4gPiA+Cj4g
PiA+ID4gPiA+ID4gPiA+PiA+ID4gSSB3YXNuJ3Qgc3VyZSBpZiB5b3Ugd2FudGVkIHRvIHF1ZXVl
IHRoZSBzZXJpZXMgZm9yIHRoaXMgbWVyZ2Ugd2luZG93Lgo+ID4gPiA+ID4gPiA+ID4gPj4gPiA+
IEluIHRoYXQgY2FzZSBkbyB5b3UgdGhpbmsgaXQgaXMgYmV0dGVyIHRvIHNlbmQgdGhpcyBwYXRj
aCBvbmx5IGZvciBzdGFibGUKPiA+ID4gPiA+ID4gPiA+ID4+ID4gPiBicmFuY2hlcz8KPiA+ID4g
PiA+ID4gPiA+ID4+ID4gPiA+IERvZXMgdGhpcyBwYXRjaCBtYWtlIHRoZW0gYSBOT1A/Cj4gPiA+
ID4gPiA+ID4gPiA+PiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4+ID4gPiBZZXAsIGFmdGVyIGFwcGx5
aW5nIHRoZSAiYmV0dGVyIFBBQ0tFRCBzdXBwb3J0IiBzZXJpZXMgYW5kIGJlaW5nCj4gPiA+ID4g
PiA+ID4gPiA+PiA+ID4gc3VyZSB0aGF0Cj4gPiA+ID4gPiA+ID4gPiA+PiA+ID4gdGhlIElPQ1RM
cyBvZiB2aG9zdC12ZHBhIHN1cHBvcnQgcGFja2VkIHZpcnRxdWV1ZSwgd2Ugc2hvdWxkIHJldmVy
dCB0aGlzCj4gPiA+ID4gPiA+ID4gPiA+PiA+ID4gcGF0Y2guCj4gPiA+ID4gPiA+ID4gPiA+PiA+
ID4KPiA+ID4gPiA+ID4gPiA+ID4+ID4gPiBMZXQgbWUga25vdyBpZiB5b3UgcHJlZmVyIGEgZGlm
ZmVyZW50IGFwcHJvYWNoLgo+ID4gPiA+ID4gPiA+ID4gPj4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+
PiA+ID4gSSdtIGNvbmNlcm5lZCB0aGF0IFFFTVUgdXNlcyB2aG9zdC12ZHBhIElPQ1RMcyB0aGlu
a2luZyB0aGF0IHRoZSBrZXJuZWwKPiA+ID4gPiA+ID4gPiA+ID4+ID4gPiBpbnRlcnByZXRzIHRo
ZW0gdGhlIHJpZ2h0IHdheSwgd2hlbiBpdCBkb2VzIG5vdC4KPiA+ID4gPiA+ID4gPiA+ID4+ID4g
Pgo+ID4gPiA+ID4gPiA+ID4gPj4gPiA+IFRoYW5rcywKPiA+ID4gPiA+ID4gPiA+ID4+ID4gPiBT
dGVmYW5vCj4gPiA+ID4gPiA+ID4gPiA+PiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4+ID4KPiA+ID4g
PiA+ID4gPiA+ID4+ID4gSWYgdGhpcyBmaXhlcyBhIGJ1ZyBjYW4geW91IGFkZCBGaXhlcyB0YWdz
IHRvIGVhY2ggb2YgdGhlbT8gVGhlbiBpdCdzIG9rCj4gPiA+ID4gPiA+ID4gPiA+PiA+IHRvIG1l
cmdlIGluIHRoaXMgd2luZG93LiBQcm9iYWJseSBlYXNpZXIgdGhhbiB0aGUgZWxhYm9yYXRlCj4g
PiA+ID4gPiA+ID4gPiA+PiA+IG1hc2svdW5tYXNrIGRhbmNlLgo+ID4gPiA+ID4gPiA+ID4gPj4K
PiA+ID4gPiA+ID4gPiA+ID4+IENDaW5nIFNoYW5ub24gKHRoZSBvcmlnaW5hbCBhdXRob3Igb2Yg
dGhlICJiZXR0ZXIgUEFDS0VEIHN1cHBvcnQiCj4gPiA+ID4gPiA+ID4gPiA+PiBzZXJpZXMpLgo+
ID4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+ID4+IElJVUMgU2hhbm5vbiBpcyBnb2lu
ZyB0byBzZW5kIGEgdjMgb2YgdGhhdCBzZXJpZXMgdG8gZml4IHRoZQo+ID4gPiA+ID4gPiA+ID4g
Pj4gZG9jdW1lbnRhdGlvbiwgc28gU2hhbm5vbiBjYW4geW91IGFsc28gYWRkIHRoZSBGaXhlcyB0
YWdzPwo+ID4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+ID4+IFRoYW5rcywKPiA+ID4g
PiA+ID4gPiA+ID4+IFN0ZWZhbm8KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID5X
ZWxsIHRoaXMgaXMgaW4gbXkgdHJlZSBhbHJlYWR5LiBKdXN0IHJlcGx5IHdpdGgKPiA+ID4gPiA+
ID4gPiA+ID5GaXhlczogPD4KPiA+ID4gPiA+ID4gPiA+ID50byBlYWNoIGFuZCBJIHdpbGwgYWRk
IHRoZXNlIHRhZ3MuCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gSSB0cmllZCwgYnV0
IGl0IGlzIG5vdCBlYXN5IHNpbmNlIHdlIGFkZGVkIHRoZSBzdXBwb3J0IGZvciBwYWNrZWQKPiA+
ID4gPiA+ID4gPiA+IHZpcnRxdWV1ZSBpbiB2ZHBhIGFuZCB2aG9zdCBpbmNyZW1lbnRhbGx5Lgo+
ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IEluaXRpYWxseSBJIHdhcyB0aGlua2luZyBv
ZiBhZGRpbmcgdGhlIHNhbWUgdGFnIHVzZWQgaGVyZToKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gPiBGaXhlczogNGM4Y2YzMTg4NWY2ICgidmhvc3Q6IGludHJvZHVjZSB2RFBBLWJhc2Vk
IGJhY2tlbmQiKQo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IFRoZW4gSSBkaXNjb3Zl
cmVkIHRoYXQgdnFfc3RhdGUgd2Fzbid0IHRoZXJlLCBzbyBJIHdhcyB0aGlua2luZyBvZgo+ID4g
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IEZpeGVzOiA1MzBhNTY3OGJjMDAgKCJ2ZHBhOiBz
dXBwb3J0IHBhY2tlZCB2aXJ0cXVldWUgZm9yIHNldC9nZXRfdnFfc3RhdGUoKSIpCj4gPiA+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gU28gd2Ugd291bGQgaGF2ZSB0byBiYWNrcG9ydCBxdWl0
ZSBhIGZldyBwYXRjaGVzIGludG8gdGhlIHN0YWJsZSBicmFuY2hlcy4KPiA+ID4gPiA+ID4gPiA+
IEkgZG9uJ3Qga25vdyBpZiBpdCdzIHdvcnRoIGl0Li4uCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+ID4gSSBzdGlsbCB0aGluayBpdCBpcyBiZXR0ZXIgdG8gZGlzYWJsZSBwYWNrZWQgaW4g
dGhlIHN0YWJsZSBicmFuY2hlcywKPiA+ID4gPiA+ID4gPiA+IG90aGVyd2lzZSBJIGhhdmUgdG8g
bWFrZSBhIGxpc3Qgb2YgYWxsIHRoZSBwYXRjaGVzIHdlIG5lZWQuCj4gPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+ID4gQW55IG90aGVyIGlkZWFzPwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gQUZBSUssIGV4Y2VwdCBmb3IgdnBfdmRwYSwgcGRzIHNlZW1zIHRvIGJlIHRoZSBmaXJzdCBw
YXJlbnQgdGhhdAo+ID4gPiA+ID4gPiA+IHN1cHBvcnRzIHBhY2tlZCB2aXJ0cXVldWUuIFVzZXJz
IHNob3VsZCBub3Qgbm90aWNlIGFueXRoaW5nIHdyb25nIGlmCj4gPiA+ID4gPiA+ID4gdGhleSBk
b24ndCB1c2UgcGFja2VkIHZpcnRxdWV1ZS4gQW5kIHRoZSBwcm9ibGVtIG9mIHZwX3ZkcGEgKyBw
YWNrZWQKPiA+ID4gPiA+ID4gPiB2aXJ0cXVldWUgY2FtZSBzaW5jZSB0aGUgZGF5MCBvZiB2cF92
ZHBhLiBJdCBzZWVtcyBmaW5lIHRvIGRvIG5vdGhpbmcKPiA+ID4gPiA+ID4gPiBJIGd1ZXNzLgo+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+IEkgaGF2ZSBhIHF1ZXN0aW9uIHRob3VnaCwgd2hhdCBpZiBkb3duIHRoZSBy
b2FkIHRoZXJlCj4gPiA+ID4gPiA+IGlzIGEgbmV3IGZlYXR1cmUgdGhhdCBuZWVkcyBtb3JlIGNo
YW5nZXM/IEl0IHdpbGwgYmUKPiA+ID4gPiA+ID4gYnJva2VuIHRvbyBqdXN0IGxpa2UgUEFDS0VE
IG5vPwo+ID4gPiA+ID4gPiBTaG91bGRuJ3QgdmRwYSBoYXZlIGFuIGFsbG93bGlzdCBvZiBmZWF0
dXJlcyBpdCBrbm93cyBob3cKPiA+ID4gPiA+ID4gdG8gc3VwcG9ydD8KPiA+ID4gPiA+Cj4gPiA+
ID4gPiBJdCBsb29rcyBsaWtlIHdlIGhhZCBpdCwgYnV0IHdlIHRvb2sgaXQgb3V0IChieSB0aGUg
d2F5LCB3ZSB3ZXJlCj4gPiA+ID4gPiBlbmFibGluZyBwYWNrZWQgZXZlbiB0aG91Z2ggd2UgZGlk
bid0IHN1cHBvcnQgaXQpOgo+ID4gPiA+ID4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9NjIzNGY4MDU3
NGQ3NTY5NDQ0ZDg3MTgzNTVmYTI4MzhlOTJiMTU4Ygo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoZSBv
bmx5IHByb2JsZW0gSSBzZWUgaXMgdGhhdCBmb3IgZWFjaCBuZXcgZmVhdHVyZSB3ZSBoYXZlIHRv
IG1vZGlmeQo+ID4gPiA+ID4gdGhlIGtlcm5lbC4KPiA+ID4gPiA+IENvdWxkIHdlIGhhdmUgbmV3
IGZlYXR1cmVzIHRoYXQgZG9uJ3QgcmVxdWlyZSBoYW5kbGluZyBieSB2aG9zdC12ZHBhPwo+ID4g
PiA+ID4KPiA+ID4gPiA+IFRoYW5rcywKPiA+ID4gPiA+IFN0ZWZhbm8KPiA+ID4gPgo+ID4gPiA+
IEphc29uIHdoYXQgZG8geW91IHNheSB0byByZXZlcnRpbmcgdGhpcz8KPiA+ID4KPiA+ID4gSSBt
YXkgbWlzcyBzb21ldGhpbmcgYnV0IEkgZG9uJ3Qgc2VlIGFueSBwcm9ibGVtIHdpdGggdkRQQSBj
b3JlLgo+ID4gPgo+ID4gPiBJdCdzIHRoZSBkdXR5IG9mIHRoZSBwYXJlbnRzIHRvIGFkdmVydGlz
ZSB0aGUgZmVhdHVyZXMgaXQgaGFzLiBGb3IgZXhhbXBsZSwKPiA+ID4KPiA+ID4gMSkgSWYgc29t
ZSBrZXJuZWwgdmVyc2lvbiB0aGF0IGlzIHBhY2tlZCBpcyBub3Qgc3VwcG9ydGVkIHZpYQo+ID4g
PiBzZXRfdnFfc3RhdGUsIHBhcmVudHMgc2hvdWxkIG5vdCBhZHZlcnRpc2UgUEFDS0VEIGZlYXR1
cmVzIGluIHRoaXMKPiA+ID4gY2FzZS4KPiA+ID4gMikgSWYgdGhlIGtlcm5lbCBoYXMgc3VwcG9y
dCBwYWNrZWQgc2V0X3ZxX3N0YXRlKCksIGJ1dCBpdCdzIGVtdWxhdGVkCj4gPiA+IGN2cSBkb2Vz
bid0IHN1cHBvcnQsIHBhcmVudHMgc2hvdWxkIG5vdCBhZHZlcnRpc2UgUEFDS0VEIGFzIHdlbGwK
PiA+ID4KPiA+ID4gSWYgYSBwYXJlbnQgdmlvbGF0ZXMgdGhlIGFib3ZlIDIsIGl0IGxvb2tzIGxp
a2UgYSBidWcgb2YgdGhlIHBhcmVudHMuCj4gPiA+Cj4gPiA+IFRoYW5rcwo+ID4KPiA+IFllcyBi
dXQgd2hhdCBhYm91dCB2aG9zdF92ZHBhPyBUYWxraW5nIGFib3V0IHRoYXQgbm90IHRoZSBjb3Jl
Lgo+IAo+IE5vdCBzdXJlIGl0J3MgYSBnb29kIGlkZWEgdG8gd29ya2Fyb3VuZCBwYXJlbnQgYnVn
cyB2aWEgdmhvc3QtdkRQQS4KCnRoZXNlIGFyZSBub3QgcGFyZW50IGJ1Z3MuIHZob3N0LXZkcGEg
ZGlkIG5vdCBwYXNzIGlvY3RsIGRhdGEKY29ycmVjdGx5IHRvIHBhcmVudCwgcmlnaHQ/Cgo+ID4g
U2hvdWxkIHRoYXQgbm90IGhhdmUgYSB3aGl0ZWxpc3Qgb2YgZmVhdHVyZXMKPiA+IHNpbmNlIGl0
IGludGVycHJldHMgaW9jdGxzIGRpZmZlcmVudGx5IGRlcGVuZGluZyBvbiB0aGlzPwo+IAo+IElm
IHRoZXJlJ3MgYSBidWcsIGl0IG1pZ2h0IG9ubHkgbWF0dGVyIHRoZSBmb2xsb3dpbmcgc2V0dXA6
Cj4gCj4gU0VUX1ZSSU5HX0JBU0UvR0VUX1ZSSU5HX0JBU0UgKyBWRFVTRS4KCldoeSBkb2VzIGl0
IG5vdCBhcHBseSB0byBhbnkgcGFyZW50PwoKPiBUaGlzIHNlZW1zIHRvIGJlIGJyb2tlbiBzaW5j
ZSBWRFVTRSB3YXMgaW50cm9kdWNlZC4gSWYgd2UgcmVhbGx5IHdhbnQKPiB0byBiYWNrcG9ydCBz
b21ldGhpbmcsIGl0IGNvdWxkIGJlIGEgZml4IHRvIGZpbHRlciBvdXQgUEFDS0VEIGluCj4gVkRV
U0U/Cj4gCj4gVGhhbmtzCgp3aGF0IHByZXZlbnRzIFZEVVNFIGZyb20gc3VwcG9ydGluZyBwYWNr
ZWQ/Cgo+ID4KPiA+ID4gPgo+ID4gPiA+IC0tCj4gPiA+ID4gTVNUCj4gPiA+ID4KPiA+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=

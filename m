Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E784C433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Dec 2021 08:07:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A882940162;
	Mon, 13 Dec 2021 08:07:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b7FHuAQSdIAg; Mon, 13 Dec 2021 08:07:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DF2C9401C9;
	Mon, 13 Dec 2021 08:07:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B779DC002F;
	Mon, 13 Dec 2021 08:07:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B27B1C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 08:07:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 985E040162
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 08:07:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 17oS3p3qc3ea
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 08:06:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2BAAC4021A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 08:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639382818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ppFYv3R1teHWfY7IoGI+J3KcvC+92KTAnR33CqYPNrM=;
 b=L5f8eScqEkyGwNEJUlyw7vp/DrOfB1zOjzEa7R3xhMTkTsVAqmSsASxzVOGNVYaRS6+Qt7
 a6qUR6DTrLWU6Un5UY9tZRvrTO2w0+RW0ho+9KXs9vdpXkJ1OuUFG5BA6D6nUdBSWV53M/
 luI+tXiUDkEthgXdW6VHEd1c+lUdGdk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-9KbtgGQWP1m2UpX7KCIt9w-1; Mon, 13 Dec 2021 03:06:54 -0500
X-MC-Unique: 9KbtgGQWP1m2UpX7KCIt9w-1
Received: by mail-ed1-f70.google.com with SMTP id
 w4-20020aa7cb44000000b003e7c0f7cfffso13239423edt.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 00:06:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ppFYv3R1teHWfY7IoGI+J3KcvC+92KTAnR33CqYPNrM=;
 b=uVgBj8WsRXVSq9gRsfzVYILz7llBpq9mIecpX1b8zaDBGth6UsTkTXO9LaToiwqavH
 kxRsmmFQLH3aiG9gSt8B/QMtWnoycXal7KphaFe/kKvEdIi6EvD0dZuCcYYP5nJ9xBUU
 5C2W/U+F47vWedVEn/ND3XXzjsr5NhzEgfws1SxEi5r1m3tNXRqP6ertjgIe0Q1m6baE
 uWg3AzUjpE2yxDxgcQ+cqS84JWIMS8c0Ib+6Mq8qWFn/mRAjPX+fawaY8zYYGweTRhkw
 QUClmTOh3cCCqnKLNgWsjVKWFZd4jZQzZQj440kYLYm1Wbg7+cXF5maLfH2y0wlWft8i
 4kdA==
X-Gm-Message-State: AOAM533OqsVANGbDltFndI4MUYhK89iQTIUXEmHtL1sU2t6w9UI4G1gZ
 d7fdbLKY3h9zN5uWtVWdGZO0AI5ETH40yVQp3Na9pKUhVMs1r1T+wnieR/hYK17noo0DFMKOWyZ
 G9ZQ/N8LmOP8tqB8rxufD1sKyuC9vF3T7pWU7Vgtlaw==
X-Received: by 2002:a05:6402:124e:: with SMTP id
 l14mr60671503edw.74.1639382813057; 
 Mon, 13 Dec 2021 00:06:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzLix4rVHAPEUnAuCm8F6B/tu/kAFRPY4UjJuE0IRdt+98l2KDOnJD1Bi6Ev1zJJARNW1hlQ==
X-Received: by 2002:a05:6402:124e:: with SMTP id
 l14mr60671484edw.74.1639382812833; 
 Mon, 13 Dec 2021 00:06:52 -0800 (PST)
Received: from redhat.com ([2.55.148.125])
 by smtp.gmail.com with ESMTPSA id w5sm5992484edc.58.2021.12.13.00.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Dec 2021 00:06:52 -0800 (PST)
Date: Mon, 13 Dec 2021 03:06:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: vdpa legacy guest support (was Re: [PATCH] vdpa/mlx5:
 set_features should allow reset to zero)
Message-ID: <20211213030535-mutt-send-email-mst@kernel.org>
References: <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
 <20210228163031-mutt-send-email-mst@kernel.org>
 <2cb51a6d-afa0-7cd1-d6f2-6b153186eaca@redhat.com>
 <20210302043419-mutt-send-email-mst@kernel.org>
 <178f8ea7-cebd-0e81-3dc7-10a058d22c07@redhat.com>
 <c9a0932f-a6d7-a9df-38ba-97e50f70c2b2@oracle.com>
 <20211212042311-mutt-send-email-mst@kernel.org>
 <CACGkMEtwWcBNj62Yn_ZSq33N42ZG5yhCcZf=eQZ_AdVgJhEjEA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtwWcBNj62Yn_ZSq33N42ZG5yhCcZf=eQZ_AdVgJhEjEA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, netdev <netdev@vger.kernel.org>,
 Eli Cohen <elic@nvidia.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gTW9uLCBEZWMgMTMsIDIwMjEgYXQgMTE6MDI6MzlBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBTdW4sIERlYyAxMiwgMjAyMSBhdCA1OjI2IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIEZyaSwgRGVjIDEwLCAyMDIxIGF0IDA1
OjQ0OjE1UE0gLTA4MDAsIFNpLVdlaSBMaXUgd3JvdGU6Cj4gPiA+IFNvcnJ5IGZvciByZXZpdmlu
ZyB0aGlzIGFuY2llbnQgdGhyZWFkLiBJIHdhcyBraW5kYSBsb3N0IGZvciB0aGUgY29uY2x1c2lv
bgo+ID4gPiBpdCBlbmRlZCB1cCB3aXRoLiBJIGhhdmUgdGhlIGZvbGxvd2luZyBxdWVzdGlvbnMs
Cj4gPiA+Cj4gPiA+IDEuIGxlZ2FjeSBndWVzdCBzdXBwb3J0OiBmcm9tIHRoZSBwYXN0IGNvbnZl
cnNhdGlvbnMgaXQgZG9lc24ndCBzZWVtIHRoZQo+ID4gPiBzdXBwb3J0IHdpbGwgYmUgY29tcGxl
dGVseSBkcm9wcGVkIGZyb20gdGhlIHRhYmxlLCBpcyBteSB1bmRlcnN0YW5kaW5nCj4gPiA+IGNv
cnJlY3Q/IEFjdHVhbGx5IHdlJ3JlIGludGVyZXN0ZWQgaW4gc3VwcG9ydGluZyB2aXJ0aW8gdjAu
OTUgZ3Vlc3QgZm9yIHg4NiwKPiA+ID4gd2hpY2ggaXMgYmFja2VkIGJ5IHRoZSBzcGVjIGF0Cj4g
PiA+IGh0dHBzOi8vb3psYWJzLm9yZy9+cnVzdHkvdmlydGlvLXNwZWMvdmlydGlvLTAuOS41LnBk
Zi4gVGhvdWdoIEknbSBub3Qgc3VyZQo+ID4gPiBpZiB0aGVyZSdzIHJlcXVlc3QvbmVlZCB0byBz
dXBwb3J0IHdpbGRlciBsZWdhY3kgdmlydGlvIHZlcnNpb25zIGVhcmxpZXIKPiA+ID4gYmV5b25k
Lgo+ID4KPiA+IEkgcGVyc29uYWxseSBmZWVsIGl0J3MgbGVzcyB3b3JrIHRvIGFkZCBpbiBrZXJu
ZWwgdGhhbiB0cnkgdG8KPiA+IHdvcmsgYXJvdW5kIGl0IGluIHVzZXJzcGFjZS4gSmFzb24gZmVl
bHMgZGlmZmVyZW50bHkuCj4gPiBNYXliZSBwb3N0IHRoZSBwYXRjaGVzIGFuZCB0aGlzIHdpbGwg
cHJvdmUgdG8gSmFzb24gaXQncyBub3QKPiA+IHRvbyB0ZXJyaWJsZT8KPiAKPiBUaGF0J3Mgb25l
IHdheSwgb3RoZXIgdGhhbiB0aGUgY29uZmlnIGFjY2VzcyBiZWZvcmUgc2V0dGluZyBmZWF0dXJl
cywKPiB3ZSBuZWVkIHRvIGRlYWwgd2l0aCBvdGhlciBzdHVmZnM6Cj4gCj4gMSkgVklSVElPX0Zf
T1JERVJfUExBVEZPUk0KPiAyKSB0aGVyZSBjb3VsZCBiZSBhIHBhcmVudCBkZXZpY2UgdGhhdCBv
bmx5IHN1cHBvcnQgMS4wIGRldmljZQo+IAo+IEFuZCBhIGxvdCBvZiBvdGhlciBzdHVmZiBzdW1t
YXJpemVkIGluIHNwZWMgNy40IHdoaWNoIHNlZW1zIG5vdCBhbgo+IGVhc3kgdGFzay4gVmFyaW91
cyB2RFBBIHBhcmVudCBkcml2ZXJzIHdlcmUgd3JpdHRlbiB1bmRlciB0aGUKPiBhc3N1bXB0aW9u
IHRoYXQgb25seSBtb2Rlcm4gZGV2aWNlcyBhcmUgc3VwcG9ydGVkLgo+IAo+IFRoYW5rcwoKTGlt
aXRpbmcgdGhpbmdzIHRvIHg4NiB3aWxsIGxpa2VseSBhZGRyZXNzIG1vc3QgaXNzdWVzIHRob3Vn
aCwgd29uJ3QgaXQ/Cgo+ID4KPiA+ID4gMi4gc3VwcG9zZSBzb21lIGZvcm0gb2YgbGVnYWN5IGd1
ZXN0IHN1cHBvcnQgbmVlZHMgdG8gYmUgdGhlcmUsIGhvdyBkbyB3ZQo+ID4gPiBkZWFsIHdpdGgg
dGhlIGJvZ3VzIGFzc3VtcHRpb24gYmVsb3cgaW4gdmRwYV9nZXRfY29uZmlnKCkgaW4gdGhlIHNo
b3J0IHRlcm0/Cj4gPiA+IEl0IGxvb2tzIG9uZSBvZiB0aGUgaW50dWl0aXZlIGZpeCBpcyB0byBt
b3ZlIHRoZSB2ZHBhX3NldF9mZWF0dXJlcyBjYWxsIG91dAo+ID4gPiBvZiB2ZHBhX2dldF9jb25m
aWcoKSB0byB2ZHBhX3NldF9jb25maWcoKS4KPiA+ID4KPiA+ID4gICAgICAgICAvKgo+ID4gPiAg
ICAgICAgICAqIENvbmZpZyBhY2Nlc3NlcyBhcmVuJ3Qgc3VwcG9zZWQgdG8gdHJpZ2dlciBiZWZv
cmUgZmVhdHVyZXMgYXJlCj4gPiA+IHNldC4KPiA+ID4gICAgICAgICAgKiBJZiBpdCBkb2VzIGhh
cHBlbiB3ZSBhc3N1bWUgYSBsZWdhY3kgZ3Vlc3QuCj4gPiA+ICAgICAgICAgICovCj4gPiA+ICAg
ICAgICAgaWYgKCF2ZGV2LT5mZWF0dXJlc192YWxpZCkKPiA+ID4gICAgICAgICAgICAgICAgIHZk
cGFfc2V0X2ZlYXR1cmVzKHZkZXYsIDApOwo+ID4gPiAgICAgICAgIG9wcy0+Z2V0X2NvbmZpZyh2
ZGV2LCBvZmZzZXQsIGJ1ZiwgbGVuKTsKPiA+ID4KPiA+ID4gSSBjYW4gcG9zdCBhIHBhdGNoIHRv
IGZpeCAyKSBpZiB0aGVyZSdzIGNvbnNlbnN1cyBhbHJlYWR5IHJlYWNoZWQuCj4gPiA+Cj4gPiA+
IFRoYW5rcywKPiA+ID4gLVNpd2VpCj4gPgo+ID4gSSdtIG5vdCBzdXJlIGhvdyBpbXBvcnRhbnQg
aXQgaXMgdG8gY2hhbmdlIHRoYXQuCj4gPiBJbiBhbnkgY2FzZSBpdCBvbmx5IGFmZmVjdHMgdHJh
bnNpdGlvbmFsIGRldmljZXMsIHJpZ2h0Pwo+ID4gTGVnYWN5IG9ubHkgc2hvdWxkIG5vdCBjYXJl
IC4uLgo+ID4KPiA+Cj4gPiA+IE9uIDMvMi8yMDIxIDI6NTMgQU0sIEphc29uIFdhbmcgd3JvdGU6
Cj4gPiA+ID4KPiA+ID4gPiBPbiAyMDIxLzMvMiA1OjQ3IOS4i+WNiCwgTWljaGFlbCBTLiBUc2ly
a2luIHdyb3RlOgo+ID4gPiA+ID4gT24gTW9uLCBNYXIgMDEsIDIwMjEgYXQgMTE6NTY6NTBBTSAr
MDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gT24gMjAyMS8zLzEgNTozNCDkuIrl
jYgsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+ID4gPiBPbiBXZWQsIEZlYiAy
NCwgMjAyMSBhdCAxMDoyNDo0MUFNIC0wODAwLCBTaS1XZWkgTGl1IHdyb3RlOgo+ID4gPiA+ID4g
PiA+ID4gPiBEZXRlY3RpbmcgaXQgaXNuJ3QgZW5vdWdoIHRob3VnaCwgd2Ugd2lsbCBuZWVkIGEg
bmV3IGlvY3RsIHRvIG5vdGlmeQo+ID4gPiA+ID4gPiA+ID4gPiB0aGUga2VybmVsIHRoYXQgaXQn
cyBhIGxlZ2FjeSBndWVzdC4gVWdoIDooCj4gPiA+ID4gPiA+ID4gPiBXZWxsLCBhbHRob3VnaCBJ
IHRoaW5rIGFkZGluZyBhbiBpb2N0bCBpcyBkb2FibGUsIG1heSBJCj4gPiA+ID4gPiA+ID4gPiBr
bm93IHdoYXQgdGhlIHVzZQo+ID4gPiA+ID4gPiA+ID4gY2FzZSB0aGVyZSB3aWxsIGJlIGZvciBr
ZXJuZWwgdG8gbGV2ZXJhZ2Ugc3VjaCBpbmZvCj4gPiA+ID4gPiA+ID4gPiBkaXJlY3RseT8gSXMg
dGhlcmUgYQo+ID4gPiA+ID4gPiA+ID4gY2FzZSBRRU1VIGNhbid0IGRvIHdpdGggZGVkaWNhdGUg
aW9jdGxzIGxhdGVyIGlmIHRoZXJlJ3MgaW5kZWVkCj4gPiA+ID4gPiA+ID4gPiBkaWZmZXJlbnRp
YXRpb24gKGxlZ2FjeSB2LnMuIG1vZGVybikgbmVlZGVkPwo+ID4gPiA+ID4gPiA+IEJUVyBhIGdv
b2QgQVBJIGNvdWxkIGJlCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiAjZGVmaW5lIFZIT1NU
X1NFVF9FTkRJQU4gX0lPVyhWSE9TVF9WSVJUSU8sID8sIGludCkKPiA+ID4gPiA+ID4gPiAjZGVm
aW5lIFZIT1NUX0dFVF9FTkRJQU4gX0lPVyhWSE9TVF9WSVJUSU8sID8sIGludCkKPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+IHdlIGRpZCBpdCBwZXIgdnJpbmcgYnV0IG1heWJlIHRoYXQgd2Fz
IGEgbWlzdGFrZSAuLi4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gQWN0dWFsbHksIEkgd29uZGVy
IHdoZXRoZXIgaXQncyBnb29kIHRpbWUgdG8ganVzdCBub3Qgc3VwcG9ydAo+ID4gPiA+ID4gPiBs
ZWdhY3kgZHJpdmVyCj4gPiA+ID4gPiA+IGZvciB2RFBBLiBDb25zaWRlcjoKPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gMSkgSXQncyBkZWZpbml0aW9uIGlzIG5vLW5vcm1hdGl2ZQo+ID4gPiA+ID4g
PiAyKSBBIGxvdCBvZiBidWRyZW4gb2YgY29kZXMKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gU28g
cWVtdSBjYW4gc3RpbGwgcHJlc2VudCB0aGUgbGVnYWN5IGRldmljZSBzaW5jZSB0aGUgY29uZmln
Cj4gPiA+ID4gPiA+IHNwYWNlIG9yIG90aGVyCj4gPiA+ID4gPiA+IHN0dWZmcyB0aGF0IGlzIHBy
ZXNlbnRlZCBieSB2aG9zdC12RFBBIGlzIG5vdCBleHBlY3RlZCB0byBiZQo+ID4gPiA+ID4gPiBh
Y2Nlc3NlZCBieQo+ID4gPiA+ID4gPiBndWVzdCBkaXJlY3RseS4gUWVtdSBjYW4gZG8gdGhlIGVu
ZGlhbiBjb252ZXJzaW9uIHdoZW4gbmVjZXNzYXJ5Cj4gPiA+ID4gPiA+IGluIHRoaXMKPiA+ID4g
PiA+ID4gY2FzZT8KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiBPdmVyYWxsIEkgd291bGQgYmUgZmluZSB3aXRoIHRoaXMgYXBwcm9hY2ggYnV0IHdl
IG5lZWQgdG8gYXZvaWQgYnJlYWtpbmcKPiA+ID4gPiA+IHdvcmtpbmcgdXNlcnNwYWNlLCBxZW11
IHJlbGVhc2VzIHdpdGggdmRwYSBzdXBwb3J0IGFyZSBvdXQgdGhlcmUgYW5kCj4gPiA+ID4gPiBz
ZWVtIHRvIHdvcmsgZm9yIHBlb3BsZS4gQW55IGNoYW5nZXMgbmVlZCB0byB0YWtlIHRoYXQgaW50
byBhY2NvdW50Cj4gPiA+ID4gPiBhbmQgZG9jdW1lbnQgY29tcGF0aWJpbGl0eSBjb25jZXJucy4K
PiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gQWdyZWUsIGxldCBtZSBjaGVjay4KPiA+ID4gPgo+ID4g
PiA+Cj4gPiA+ID4gPiAgIEkgbm90ZSB0aGF0IGFueSBoYXJkd2FyZQo+ID4gPiA+ID4gaW1wbGVt
ZW50YXRpb24gaXMgYWxyZWFkeSBicm9rZW4gZm9yIGxlZ2FjeSBleGNlcHQgb24gcGxhdGZvcm1z
IHdpdGgKPiA+ID4gPiA+IHN0cm9uZyBvcmRlcmluZyB3aGljaCBtaWdodCBiZSBoZWxwZnVsIGlu
IHJlZHVjaW5nIHRoZSBzY29wZS4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gWWVzLgo+ID4gPiA+
Cj4gPiA+ID4gVGhhbmtzCj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+
ID4KPiA+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=

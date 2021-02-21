Return-Path: <SRS0=m9lB=HX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D1DC433DB
	for <virtualization@archiver.kernel.org>; Sun, 21 Feb 2021 11:33:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F358164EE6
	for <virtualization@archiver.kernel.org>; Sun, 21 Feb 2021 11:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F358164EE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A425F833FB
	for <virtualization@archiver.kernel.org>; Sun, 21 Feb 2021 11:33:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VJ-0e8gEHfOb for <virtualization@archiver.kernel.org>;
	Sun, 21 Feb 2021 11:33:19 +0000 (UTC)
Received: by smtp1.osuosl.org (Postfix, from userid 1001)
	id 92FAC8318C; Sun, 21 Feb 2021 11:33:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C3D1832EA;
	Sun, 21 Feb 2021 11:33:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A80E7C000E;
	Sun, 21 Feb 2021 11:33:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25500C000B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Feb 2021 11:33:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 13AC3870AA
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Feb 2021 11:33:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r5OhDVpE3fBy
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Feb 2021 11:33:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0425F83668
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Feb 2021 11:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613907189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZdeToMlanriOSyztn4NGDqzCE8kvs/AecJfz5xeD8Z0=;
 b=Mc9iLoQdP3g6rinB1V6O8v+R/Ymsr8l4NEMrnOO48+vUIQvUr3zJEx+4KK0feS2IO9Z4d3
 IuBqr3yT2RiqDiLo9zf9VrG3drbCmV4fSEqGHF/guopeT9y4pnqn2YoUnfVodGPPtmgGX1
 ouvchzVYjxDrajpgc4c1L1edloK3SJ0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-X5sbW8YtOSuJ0h-Whl5JkA-1; Sun, 21 Feb 2021 06:33:05 -0500
X-MC-Unique: X5sbW8YtOSuJ0h-Whl5JkA-1
Received: by mail-ed1-f69.google.com with SMTP id d3so5436968edk.22
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Feb 2021 03:33:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ZdeToMlanriOSyztn4NGDqzCE8kvs/AecJfz5xeD8Z0=;
 b=QYx9F2NQPsj+mjDIqDCPxRkCfzANuuQjO0f2TGXbrQ42OWToJyhIx+aShAmblhiDfA
 2zaeDnNZ+LKEdY55wOdV6LYti4XmWZ5d+MzYh02onmouhYNCJpYUxAlwJieHlDsxPFZl
 8aAoJlHOcGKAIbfWgH2Ol7N7amUHztMUQlGTqYO2r3z/QWAJnEW15SGCJFxod5nnEAQ7
 hS/f8uDTQLsctspM+fMA0kz0FR3EKz1/UglBEElMBLov15BpV4HKnuC1R8mmgXT0BBRl
 a+3Xjx0SZvJ0T8bJrxcFfufU6JDBv0Y5lPG1+S7jk1nXp7TDnE75zy8cn5PXm438DCOk
 5DzQ==
X-Gm-Message-State: AOAM533f43+TgOPKBDE7GUWv0hw5sohNPBYNDaP7NwoN5RQJb0H0dfny
 ETTNAOWgn31UtOhHtH7zLb8rGajhhPRcCWwXII1NEK+6H22zVME6gFm4wm4v8DreCjAZoCNqD4S
 NntcRRZJLWwxw8t+8lk1rR0yVpIrxBfnlQJKml1ReFA==
X-Received: by 2002:a05:6402:46:: with SMTP id
 f6mr17682509edu.163.1613907184707; 
 Sun, 21 Feb 2021 03:33:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwysqToGXs1mj8BQr9Sl+WDxGXmrKJUDqrnRhGVkCh4wUJ3SCYBAutr931huSXsnrIPk7pjoA==
X-Received: by 2002:a05:6402:46:: with SMTP id
 f6mr17682494edu.163.1613907184423; 
 Sun, 21 Feb 2021 03:33:04 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id da12sm6921507edb.52.2021.02.21.03.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Feb 2021 03:33:03 -0800 (PST)
Date: Sun, 21 Feb 2021 06:33:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] virtio-net: suppress bad irq warning for tx napi
Message-ID: <20210221062810-mutt-send-email-mst@kernel.org>
References: <CAF=yD-+NVKiwS6P2=cS=gk2nLcsWP1anMyy4ghdPiNrhOmLRDw@mail.gmail.com>
 <9b0b8f2a-8476-697e-9002-e9947e3eab63@redhat.com>
 <CA+FuTScVOuoHKtrdrRFswjA3Zq1-7sgMVhnP2iMB5sYFFS8NFg@mail.gmail.com>
 <50ae0b71-df87-f26c-8b4d-8035f9f6a58d@redhat.com>
 <CAF=yD-J5-60D=JDwvpecjaO6J03SZHoHJyCsR3B1HbP1-jbqng@mail.gmail.com>
 <00de1b0f-f2aa-de54-9c7e-472643400417@redhat.com>
 <CAF=yD-K9xTBStGR5BEiS6WZd=znqM_ENcj9_nb=rrpcMORqE8g@mail.gmail.com>
 <CAEA6p_Bi1OMTas0W4VuxAMz8Frf+vBNc8c7xCDUxb_uwUy8Zgw@mail.gmail.com>
 <20210210040802-mutt-send-email-mst@kernel.org>
 <9b077d6c-aeca-8266-4579-fae02c8b31de@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9b077d6c-aeca-8266-4579-fae02c8b31de@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Network Development <netdev@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 Wei Wang <weiwan@google.com>, David Miller <davem@davemloft.net>
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

T24gVGh1LCBGZWIgMTgsIDIwMjEgYXQgMDE6Mzk6MTlQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIxLzIvMTAg5LiL5Y2INToxNCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gT24gVHVlLCBGZWIgMDksIDIwMjEgYXQgMTA6MDA6MjJBTSAtMDgwMCwgV2VpIFdhbmcg
d3JvdGU6Cj4gPiA+IE9uIFR1ZSwgRmViIDksIDIwMjEgYXQgNjo1OCBBTSBXaWxsZW0gZGUgQnJ1
aWpuCj4gPiA+IDx3aWxsZW1kZWJydWlqbi5rZXJuZWxAZ21haWwuY29tPiB3cm90ZToKPiA+ID4g
PiA+ID4gPiA+IEkgaGF2ZSBubyBwcmVmZXJlbmNlLiBKdXN0IGN1cmlvdXMsIGVzcGVjaWFsbHkg
aWYgaXQgY29tcGxpY2F0ZXMgdGhlIHBhdGNoLgo+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+
ID4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0LiBJdCdzIHByb2JhYmx5IG9rIGZvciBuZXQuIEJ1
dCB3ZSBwcm9iYWJseSBuZWVkCj4gPiA+ID4gPiA+ID4gdG8gZG9jdW1lbnQgdGhlIGFzc3VtcHRp
b25zIHRvIG1ha2Ugc3VyZSBpdCB3YXMgbm90IGFidXNlZCBpbiBvdGhlciBkcml2ZXJzLgo+ID4g
PiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+IEludHJvZHVjZSBuZXcgcGFyYW1ldGVycyBmb3IgZmlu
ZF92cXMoKSBjYW4gaGVscCB0byBlbGltaW5hdGUgdGhlIHN1YnRsZQo+ID4gPiA+ID4gPiA+IHN0
dWZmcyBidXQgSSBhZ3JlZSBpdCBsb29rcyBsaWtlIGEgb3ZlcmtpbGwuCj4gPiA+ID4gPiA+ID4g
Cj4gPiA+ID4gPiA+ID4gKEJ0dywgSSBmb3JnZXQgdGhlIG51bWJlcnMgYnV0IHdvbmRlciBob3cg
bXVjaCBkaWZmZXJlbmNlIGlmIHdlIHNpbXBsZQo+ID4gPiA+ID4gPiA+IHJlbW92ZSB0aGUgZnJl
ZV9vbGRfeG1pdHMoKSBmcm9tIHRoZSByeCBOQVBJIHBhdGg/KQo+ID4gPiA+ID4gPiBUaGUgY29t
bWl0dGVkIHBhdGNoc2V0IGRpZCBub3QgcmVjb3JkIHRob3NlIG51bWJlcnMsIGJ1dCBJIGZvdW5k
IHRoZW0KPiA+ID4gPiA+ID4gaW4gYW4gZWFybGllciBpdGVyYXRpb246Cj4gPiA+ID4gPiA+IAo+
ID4gPiA+ID4gPiAgICAgW1BBVENIIG5ldC1uZXh0IDAvM10gdmlydGlvLW5ldCB0eCBuYXBpCj4g
PiA+ID4gPiA+ICAgICBodHRwczovL2xpc3RzLm9wZW53YWxsLm5ldC9uZXRkZXYvMjAxNy8wNC8w
Mi81NQo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gSXQgZGlkIHNlZW0gdG8gc2lnbmlmaWNhbnRs
eSByZWR1Y2UgY29tcHV0ZSBjeWNsZXMgKCJHY3ljIikgYXQgdGhlCj4gPiA+ID4gPiA+IHRpbWUu
IEZvciBpbnN0YW5jZToKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ICAgICAgIFRDUF9SUiBMYXRl
bmN5ICh1cyk6Cj4gPiA+ID4gPiA+ICAgICAgIDF4Ogo+ID4gPiA+ID4gPiAgICAgICAgIHA1MCAg
ICAgICAgICAgICAgMjQgICAgICAgMjQgICAgICAgMjEKPiA+ID4gPiA+ID4gICAgICAgICBwOTkg
ICAgICAgICAgICAgIDI3ICAgICAgIDI3ICAgICAgIDI3Cj4gPiA+ID4gPiA+ICAgICAgICAgR2N5
Y2xlcyAgICAgICAgIDI5OSAgICAgIDQzMiAgICAgIDMwOAo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+
ID4gSSdtIGNvbmNlcm5lZCB0aGF0IHJlbW92aW5nIGl0IG5vdyBtYXkgY2F1c2UgYSByZWdyZXNz
aW9uIHJlcG9ydCBpbiBhCj4gPiA+ID4gPiA+IGZldyBtb250aHMuIFRoYXQgaXMgaGlnaGVyIHJp
c2sgdGhhbiB0aGUgc3B1cmlvdXMgaW50ZXJydXB0IHdhcm5pbmcKPiA+ID4gPiA+ID4gdGhhdCB3
YXMgb25seSByZXBvcnRlZCBhZnRlciB5ZWFycyBvZiB1c2UuCj4gPiA+ID4gPiAKPiA+ID4gPiA+
IFJpZ2h0Lgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBTbyBpZiBNaWNoYWVsIGlzIGZpbmUgd2l0aCB0
aGlzIGFwcHJvYWNoLCBJJ20gb2sgd2l0aCBpdC4gQnV0IHdlCj4gPiA+ID4gPiBwcm9iYWJseSBu
ZWVkIHRvIGEgVE9ETyB0byBpbnZlbnQgdGhlIGludGVycnVwdCBoYW5kbGVycyB0aGF0IGNhbiBi
ZQo+ID4gPiA+ID4gdXNlZCBmb3IgbW9yZSB0aGFuIG9uZSB2aXJ0cXVldWVzLiBXaGVuIE1TSS1Y
IGlzIGVuYWJsZWQsIHRoZSBpbnRlcnJ1cHQKPiA+ID4gPiA+IGhhbmRsZXIgKHZyaW5nX2ludGVy
cnVwKCkpIGFzc3VtZXMgdGhlIGludGVycnVwdCBpcyB1c2VkIGJ5IGEgc2luZ2xlCj4gPiA+ID4g
PiB2aXJ0cXVldWUuCj4gPiA+ID4gVGhhbmtzLgo+ID4gPiA+IAo+ID4gPiA+IFRoZSBhcHByb2Fj
aCB0byBzY2hlZHVsZSB0eC1uYXBpIGZyb20gdmlydG5ldF9wb2xsX2NsZWFudHggaW5zdGVhZCBv
Zgo+ID4gPiA+IGNsZWFuaW5nIGRpcmVjdGx5IGluIHRoaXMgcngtbmFwaSBmdW5jdGlvbiB3YXMg
bm90IGVmZmVjdGl2ZSBhdAo+ID4gPiA+IHN1cHByZXNzaW5nIHRoZSB3YXJuaW5nLCBJIHVuZGVy
c3RhbmQuCj4gPiA+IENvcnJlY3QuIEkgdHJpZWQgdGhlIGFwcHJvYWNoIHRvIHNjaGVkdWxlIHR4
IG5hcGkgaW5zdGVhZCBvZiBkaXJlY3RseQo+ID4gPiBkbyBmcmVlX29sZF94bWl0X3NrYnMoKSBp
biB2aXJ0bmV0X3BvbGxfY2xlYW50eCgpLiBCdXQgdGhlIHdhcm5pbmcKPiA+ID4gc3RpbGwgaGFw
cGVucy4KPiA+IFR3byBxdWVzdGlvbnMgaGVyZTogaXMgdGhlIGRldmljZSB1c2luZyBwYWNrZWQg
b3Igc3BsaXQgdnFzPwo+ID4gQW5kIGlzIGV2ZW50IGluZGV4IGVuYWJsZWQ/Cj4gPiAKPiA+IEkg
dGhpbmsgb25lIGlzc3VlIGlzIHRoYXQgYXQgdGhlIG1vbWVudCB3aXRoIHNwbGl0IGFuZCBldmVu
dCBpbmRleCB3ZQo+ID4gZG9uJ3QgYWN0dWFsbHkgZGlzYWJsZSBldmVudHMgYXQgYWxsLgo+IAo+
IAo+IERvIHdlIHJlYWxseSBoYXZlIGEgd2F5IHRvIGRpc2FibGUgdGhhdD8gKFdlIGRvbid0IGhh
dmUgYSBmbGFnIGxpa2UgcGFja2VkCj4gdmlydHF1ZXVlKQo+IAo+IE9yIHlvdSBtZWFuIHRoZSB0
cmljayBbMV0gd2hlbiBJIHBvc3QgdHggaW50ZXJydXB0IFJGQz8KPiAKPiBUaGFua3MKPiAKPiBb
MV0gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTUvMi85LzExMwoKU29tZXRoaW5nIGxpa2UgdGhp
cy4gT3IgYmFzaWNhbGx5IGFueSBvdGhlciB2YWx1ZSB3aWxsIGRvLAplLmcuIG1vdmUgdGhlIGlu
ZGV4IGJhY2sgdG8gYSB2YWx1ZSBqdXN0IHNpZ25hbGxlZCAuLi4KCj4gCj4gPiAKPiA+IHN0YXRp
YyB2b2lkIHZpcnRxdWV1ZV9kaXNhYmxlX2NiX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSkK
PiA+IHsKPiA+ICAgICAgICAgIHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92
cSk7Cj4gPiAKPiA+ICAgICAgICAgIGlmICghKHZxLT5zcGxpdC5hdmFpbF9mbGFnc19zaGFkb3cg
JiBWUklOR19BVkFJTF9GX05PX0lOVEVSUlVQVCkpIHsKPiA+ICAgICAgICAgICAgICAgICAgdnEt
PnNwbGl0LmF2YWlsX2ZsYWdzX3NoYWRvdyB8PSBWUklOR19BVkFJTF9GX05PX0lOVEVSUlVQVDsK
PiA+ICAgICAgICAgICAgICAgICAgaWYgKCF2cS0+ZXZlbnQpCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgdnEtPnNwbGl0LnZyaW5nLmF2YWlsLT5mbGFncyA9Cj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjcHVfdG9fdmlydGlvMTYoX3ZxLT52ZGV2LAo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZxLT5zcGxpdC5hdmFp
bF9mbGFnc19zaGFkb3cpOwo+ID4gICAgICAgICAgfQo+ID4gfQo+ID4gCj4gPiBDYW4geW91IHRy
eSB5b3VyIG5hcGkgcGF0Y2ggKyBkaXNhYmxlIGV2ZW50IGluZGV4Pwo+ID4gCj4gPiAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==

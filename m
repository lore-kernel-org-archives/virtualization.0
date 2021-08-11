Return-Path: <SRS0=15I4=NC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DAAC4338F
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 07:40:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95EA360FC3
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 07:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 95EA360FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 397BA402DD;
	Wed, 11 Aug 2021 07:40:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v5UBWRJMVlc0; Wed, 11 Aug 2021 07:40:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A5AB9402AE;
	Wed, 11 Aug 2021 07:40:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56D8AC001A;
	Wed, 11 Aug 2021 07:40:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D942EC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 07:40:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B99BA402AE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 07:40:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w5IW78ds4eS8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 07:40:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DE677402A6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 07:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628667604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5+NI0dedA5cM6J5be1uDhwKdbPg91uFizX6wypdFa4=;
 b=EXQrcJHBOSsYi9ARw97Ku4zXiT0PNer+Il/1auXUuatADxn4Q6lrtfjDL26vR3i5T8Iq+N
 cGOSqYKquX8VUhnQx5CBpPxjAzbBRwjA8Yuj0uprvZjUqfoAxp3bYzdL2WHP0/M0ojm2Fb
 nC/XYI1qy4xW+EKwlsHZYbjsK/yDgUk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-d8hPc4WKO0aKD7KOFPua_A-1; Wed, 11 Aug 2021 03:40:01 -0400
X-MC-Unique: d8hPc4WKO0aKD7KOFPua_A-1
Received: by mail-ej1-f70.google.com with SMTP id
 nb40-20020a1709071ca8b02905992266c319so322103ejc.21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 00:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=M5+NI0dedA5cM6J5be1uDhwKdbPg91uFizX6wypdFa4=;
 b=n/KiL6YIIA7zNMSU7bO5Bp7ZEwazu8zePObIWzaq8+U1j6i/LkTQqSbzu0/T00Dxo4
 v5bcmxwNsr0EOWNxVLpltyP+ui0TAlLiQLaXrk/U1djdgUI+4jpPKZ8r/+zjgiPJrFxX
 f1NxEIltfr0sEkwpvQMxKhdBXJRbXS1+TML8vEf78iIRhEP6AnYkmprMsjppsTY6md5q
 Ww9QEuO2hHxmrNt2BG2ZOmh0KBtwzzENCZtcp57Ylw/cD0aIdG7teVo7wtfeACF0VKJU
 /31KqFFSFvILpVf6w79h/OqP7fUNhcX7K6BCtDzbpQ0KqQ44iNYWY8zVDmTWXETnjHn/
 WAGw==
X-Gm-Message-State: AOAM533cWMDxRljwRn+zNiP8ej8fivxibpiX9KCo9TUKzcYxjFZ+sAIi
 sZfkoOo2T/QycKCAHGR8UEdJk79NoomIO/3qng2COB/opDqiSOTn/aTax/2pN5+KyGt8CIrkj5g
 hrMA3LrKOpzYtHyXo6LQPLLY5rX7B9vART9ZGw1Ba1A==
X-Received: by 2002:a17:906:12c6:: with SMTP id
 l6mr2416862ejb.373.1628667600350; 
 Wed, 11 Aug 2021 00:40:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7EpTmBQDgwXdy/v5YxI6x7HsV4laB3vVQANPqiHpRYpc6hA9diFk4aDsrKhSIBE6D1BzT/Q==
X-Received: by 2002:a17:906:12c6:: with SMTP id
 l6mr2416836ejb.373.1628667600062; 
 Wed, 11 Aug 2021 00:40:00 -0700 (PDT)
Received: from redhat.com ([2.55.156.103])
 by smtp.gmail.com with ESMTPSA id p23sm7788654ejc.19.2021.08.11.00.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Aug 2021 00:39:59 -0700 (PDT)
Date: Wed, 11 Aug 2021 03:39:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: PROBLEM: virtio_net LRO kernel panics
Message-ID: <20210811030612-mutt-send-email-mst@kernel.org>
References: <CACFia2en0JJDFyz3Umk-JTnMT=kjvRogt4PudED4kiLeMjcHFg@mail.gmail.com>
 <CACFia2fx7Lt-4o_uqDznvk-VgdsMtD64qv6RYkrCjKLu2yt8bg@mail.gmail.com>
 <CACFia2eUi4KNRC7MYktzUS9Nq2WcBiesX04Tbn2pTuvuGkY4qA@mail.gmail.com>
 <CACFia2dns1rTe5OQj4H-kpurVm2CTtGfAXz0aOUS0_cs0QUrsA@mail.gmail.com>
 <20210727050944-mutt-send-email-mst@kernel.org>
 <CACFia2dLp19pzJsScSvVYREpQm0n6XCWLieWXzA94=OVYVHTbw@mail.gmail.com>
 <20210802154901-mutt-send-email-mst@kernel.org>
 <CACFia2f8xmOwB69Cj+OUNobNSurVnrLrJFdrxnmurww9aSzJMw@mail.gmail.com>
 <20210810112147-mutt-send-email-mst@kernel.org>
 <CACGkMEt94bNsM6e+U6a+H4ZGp5Ss+y=1_fBDUKto5BJXcG_47w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEt94bNsM6e+U6a+H4ZGp5Ss+y=1_fBDUKto5BJXcG_47w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Willem de Bruijn <willemb@google.com>,
 Ivan <ivan@prestigetransportation.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

T24gV2VkLCBBdWcgMTEsIDIwMjEgYXQgMTE6Mzg6NTlBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUdWUsIEF1ZyAxMCwgMjAyMSBhdCAxMTozMSBQTSBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBNb24sIEF1ZyAwMiwgMjAyMSBhdCAw
NDoyMzoxMlBNIC0wNTAwLCBJdmFuIHdyb3RlOgo+ID4gPiBPbiBNb24sIEF1ZyAyLCAyMDIxIGF0
IDI6NTIgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+
ID4KPiA+ID4gPiBPbiBNb24sIEF1ZyAwMiwgMjAyMSBhdCAwMTozMjowNVBNIC0wNTAwLCBJdmFu
IHdyb3RlOgo+ID4gPiA+ID4gT24gVHVlLCBKdWwgMjcsIDIwMjEgYXQgNDoxMSBBTSBNaWNoYWVs
IFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gT24gTW9uLCBKdWwgMjYsIDIwMjEgYXQgMDc6NDQ6NDNQTSAtMDUwMCwgSXZhbiB3cm90ZToK
PiA+ID4gPiA+ID4gPiBPbiBTYXQsIEp1bCAyNCwgMjAyMSBhdCAxMToxOCBQTSBJdmFuIDxpdmFu
QHByZXN0aWdldHJhbnNwb3J0YXRpb24uY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gPiBPbiBTYXQsIEp1bCAyNCwgMjAyMSBhdCA3OjE3IFBNIEl2YW4gPGl2YW5AcHJl
c3RpZ2V0cmFuc3BvcnRhdGlvbi5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+ID4gPiBPbiBGcmksIEp1bCAyMywgMjAyMSBhdCA3OjMzIEFNIEl2YW4gPGl2YW5AcHJl
c3RpZ2V0cmFuc3BvcnRhdGlvbi5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPj4KPiA+ID4g
PiA+ID4gPiA+ID4+IE9uIEZyaSwgSnVsIDIzLCAyMDIxIGF0IDc6MTAgQU0gTWljaGFlbCBTLiBU
c2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+Pj4KPiA+ID4g
PiA+ID4gPiA+ID4+PiBPbiBGcmksIEp1bCAyMywgMjAyMSBhdCAwMzowNjowNEFNIC0wNTAwLCBJ
dmFuIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPj4+ID4gT24gRnJpLCBKdWwgMjMsIDIwMjEgYXQg
Mjo1OSBBTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4g
PiA+ID4gPiA+ID4+PiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4+PiA+ID4gT24gVGh1LCBKdWwgMjIs
IDIwMjEgYXQgMTE6NTA6MTFQTSAtMDUwMCwgSXZhbiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4+
PiA+ID4gPiBPbiBUaHUsIEp1bCAyMiwgMjAyMSBhdCAxMToyNSBQTSBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4+PiA+ID4gPiA+IOWcqCAy
MDIxLzcvMjMg5LiK5Y2IMTA6NTQsIEl2YW4g5YaZ6YGTOgo+ID4gPiA+ID4gPiA+ID4gPj4+ID4g
PiA+ID4gPiBPbiBUaHUsIEp1bCAyMiwgMjAyMSBhdCA5OjM3IFBNIEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPj4+ID4gPiA+ID4gPj4gRG9l
cyBpdCB3b3JrIGlmIHlvdSB0dXJuIG9mZiBscm8gYmVmb3JlIGVuYWJsaW5nIHRoZSBmb3J3YXJk
aW5nPwo+ID4gPiA+ID4gPiA+ID4gPj4+ID4gPiA+ID4gPiAwIHJvb3RATnVSYWlkOn4jIGV0aHRv
b2wgLUsgZXRoMCBscm8gb2ZmCj4gPiA+ID4gPiA+ID4gPiA+Pj4gPiA+ID4gPiA+IEFjdHVhbCBj
aGFuZ2VzOgo+ID4gPiA+ID4gPiA+ID4gPj4+ID4gPiA+ID4gPiByeC1scm86IG9uIFtyZXF1ZXN0
ZWQgb2ZmXQo+ID4gPiA+ID4gPiA+ID4gPj4+ID4gPiA+ID4gPiBDb3VsZCBub3QgY2hhbmdlIGFu
eSBkZXZpY2UgZmVhdHVyZXMKPiA+ID4gPiA+ID4gPiA+ID4+PiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gPiA+Pj4gPiA+ID4gPiBPaywgaXQgbG9va3MgbGlrZSB0aGUgZGV2aWNlIG1pc3NlcyB0aGUg
VklSVElPX05FVF9GX0NUUkxfR1VFU1RfT0ZGTE9BRFMKPiA+ID4gPiA+ID4gPiA+ID4+PiA+ID4g
PiA+IHdoaWNoIG1ha2VzIGl0IGltcG9zc2libGUgdG8gY2hhbmdlIHRoZSBMUk8gc2V0dGluZy4K
PiA+ID4gPiA+ID4gPiA+ID4+PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+Pj4gPiA+ID4gPiBE
aWQgeW91IHVzZSBxZW11PyBJZiB5ZXMsIHdoYXQncyB0aGUgcWVtdSB2ZXJzaW9uIHlvdSd2ZSB1
c2VkPwo+ID4gPiA+ID4gPiA+ID4gPj4+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+Pj4gPiA+ID4g
VGhlc2UgYXJlIFZpcnR1YWxCb3ggbWFjaGluZXMsIHdoaWNoIEkndmUgYmVlbiB1c2luZyBmb3Ig
eWVhcnMgd2l0aAo+ID4gPiA+ID4gPiA+ID4gPj4+ID4gPiA+IGxvbmd0ZXJtIGtlcm5lbHMgNC4x
OSwgYW5kIEkgbmV2ZXIgaGFkIHN1Y2ggYSBwcm9ibGVtLiAgQnV0IG5vdyB0aGF0IEkKPiA+ID4g
PiA+ID4gPiA+ID4+PiA+ID4gPiB0cmllZCB1cGdyYWRpbmcgdG8ga2VybmVscyA1LjEwIG9yIDUu
MTMgLS0gdGhlIHBhbmljcyBzdGFydGVkLiAgVGhlc2UKPiA+ID4gPiA+ID4gPiA+ID4+PiA+ID4g
PiBhcmUganVzdCBnZW5lcmljIGtlcm5lbCBidWlsZHMsIGFuZCBhIG1pbmltYWxpc3RpYyB1c2Vy
c3BhY2UuCj4gPiA+ID4gPiA+ID4gPiA+Pj4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+Pj4gPiA+IEkg
d291bGQgYmUgdXNlZnVsIHRvIHNlZSB0aGUgZmVhdHVyZXMgeW91ciB2aXJ0dWFsYm94IGluc3Rh
bmNlIHByb3ZpZGVzCj4gPiA+ID4gPiA+ID4gPiA+Pj4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+Pj4g
PiA+IGNhdCAvc3lzL2NsYXNzL25ldC9ldGgwL2RldmljZS9mZWF0dXJlcwo+ID4gPiA+ID4gPiA+
ID4gPj4+ID4KPiA+ID4gPiA+ID4gPiA+ID4+PiA+ICMgY2F0IC9zeXMvY2xhc3MvbmV0L2V0aDAv
ZGV2aWNlL2ZlYXR1cmVzCj4gPiA+ID4gPiA+ID4gPiA+Pj4gPiAxMTAwMDEwMTEwMTExMDExMTEx
MTAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwCj4gPiA+ID4gPiA+
ID4gPiA+Pj4KPiA+ID4gPiA+ID4gPiA+ID4+PiBJIHdhcyBhYmxlIHRvIHJlcHJvZHVjZSB0aGUg
d2FybmluZyBidXQgbm90IHRoZSBwYW5pYy4KPiA+ID4gPiA+ID4gPiA+ID4+PiBPVE9IIGlmIExS
TyBzdGF5cyBvbiB3aGVuIGVuYWJsaW5nIGZvcndhcmRpbmcgdGhhdAo+ID4gPiA+ID4gPiA+ID4g
Pj4+IGlzIGFscmVhZHkgYSBwcm9ibGVtLiBBbnkgY2hhbmNlIHlvdSBjYW4gYmlzZWN0IHRvCj4g
PiA+ID4gPiA+ID4gPiA+Pj4gZmluZCBvdXQgd2hpY2ggY2hhbmdlIGludHJvZHVjZWQgdGhlIHBh
bmljPwo+ID4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4g
PiA+PiBBbnkga2VybmVscyB1cCB0byA0LjE5LjE5OCBkb24ndCBwYW5pYy4KPiA+ID4gPiA+ID4g
PiA+ID4+IEFueSBrZXJuZWxzIDUuMTArIHBhbmljIGltbWVkaWF0ZWx5IHVwb24gc3RhcnRpbmcg
Zm9yd2FyZGluZy4KPiA+ID4gPiA+ID4gPiA+ID4+IEkgaGF2ZSBub3QgdGVzdGVkIGFueSBrZXJu
ZWxzIGJldHdlZW4gNC4xOSBhbmQgNS4xMC4KPiA+ID4gPiA+ID4gPiA+ID4+IEkgZ3Vlc3MgSSBj
YW4gYnVpbGQgYSBmZXcga2VybmVscyBpbmJldHdlZW4sIGFuZCB0cnkgcGlucG9pbnQgd2hlcmUg
aXQgc3RhcnRzLgo+ID4gPiA+ID4gPiA+ID4gPj4gVGhhdCBtYXkgdGFrZSBhIGRheSBvciBzby4g
IEknbGwgZ2V0IG9uIHdpdGggaXQgbm93LCBhbmQgcmVwb3J0IG15IGZpbmRpbmdzLgo+ID4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBTbywgSSBuYXJyb3dlZCAgaXQgZG93bjogdGhl
IHBhbmljcyBzdGFydCB3aXRoIGtlcm5lbCA1LjAtcmMuCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+ID4gTW9yZSBuYXJvd2x5LCB0aGUgcHJvYmxlbSBzZWVtcyBiZSBjb21pbmcgZnJvbSBj
b21taXQKPiA+ID4gPiA+ID4gPiA+IGEwMmU4OTY0ZWFmOTI3MWE4YTVmY2MwYzU1YmQxM2Y5MzNi
YWZjNTYuCj4gPiA+ID4gPiA+ID4gPiBKdXN0IHRvIHRlc3QgbXkgc3VzcGljaW9uLCBJIGRlbGV0
ZWQgYSBmZXcgbGluZXMgZnJvbSB0aGF0IGNvZGUsCj4gPiA+ID4gPiA+ID4gPiBhbmQgdGhlIHBh
bmljIHdlbnQgYXdheS4gIEhvcGUgdGhhdCBoZWxwcyB5b3UgZ3V5cyBmaWd1cmUgb3V0Cj4gPiA+
ID4gPiA+ID4gPiB3aGF0IHRoZSBwcm9ibGVtIG1pZ2h0IGJlLgo+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiBXZWxsIGl0IGRpc2FibGVzIExSTyBidXQgd2Uga25ldyB0aGlzIDooIEknZCBoZWxwIGlm
IHdlIGtuZXcKPiA+ID4gPiA+ID4gd2hlcmUgZG9lcyBpdCBwYW5pYywgYWxsIHdlIHNlZSBpdCB0
aGUgd2FybmluZyB3aGljaCBpcwo+ID4gPiA+ID4gPiByZWxhdGVkIGZvciBzdXJlIGJ1dCBub3Qg
dGhlIGltbWVkaWF0ZSByb290Y2F1c2UgLi4uCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gPiA+
ID4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiA+ID4gPiA+IEBAIC0y
OTc4LDExICsyOTc4LDYgQEAKPiA+ID4gPiA+ID4gPiA+ICAgfQo+ID4gPiA+ID4gPiA+ID4gICBp
ZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9HVUVTVF9DU1VNKSkKPiA+
ID4gPiA+ID4gPiA+ICAgICAgZGV2LT5mZWF0dXJlcyB8PSBORVRJRl9GX1JYQ1NVTTsKPiA+ID4g
PiA+ID4gPiA+IC0gaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfR1VF
U1RfVFNPNCkgfHwKPiA+ID4gPiA+ID4gPiA+IC0gICAgdmlydGlvX2hhc19mZWF0dXJlKHZkZXYs
IFZJUlRJT19ORVRfRl9HVUVTVF9UU082KSkKPiA+ID4gPiA+ID4gPiA+IC0gICAgZGV2LT5mZWF0
dXJlcyB8PSBORVRJRl9GX0xSTzsKPiA+ID4gPiA+ID4gPiA+IC0gaWYgKHZpcnRpb19oYXNfZmVh
dHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfQ1RSTF9HVUVTVF9PRkZMT0FEUykpCj4gPiA+ID4gPiA+
ID4gPiAtICAgIGRldi0+aHdfZmVhdHVyZXMgfD0gTkVUSUZfRl9MUk87Cj4gPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+ID4gICBkZXYtPnZsYW5fZmVhdHVyZXMgPSBkZXYtPmZlYXR1cmVzOwo+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gSnVzdCBGWUksIEdvb2dsZSB0dXJuZWQgdXAgdHdv
IHNpbWlsYXIgYnVnIHJlcG9zdHMuLi4KPiA+ID4gPiA+ID4gPiBBcHIgMTQsIDIwMjAgLS0gaHR0
cHM6Ly9naXRodWIuY29tL2NvbnRhaW5lcnMvcG9kbWFuL2lzc3Vlcy81ODE1Cj4gPiA+ID4gPiA+
ID4gT2N0IDA5LiAyMDIwIC0tIGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5j
Z2k/aWQ9MjA5NTkzCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBJcyB0aGVyZSBhbnkgc2Vu
c2libGUgdGhpbmcgSSBjb3VsZCBkbywgdGVtcG9yYXJpbHksIHVudGlsIHRoaXMKPiA+ID4gPiA+
ID4gPiBwcm9ibGVtIGlzIHNvcnRlZCBvdXQ/Cj4gPiA+ID4gPiA+ID4gT3IgYW0gSSBzaW1wbHkg
c3R1Y2sgdG8ga2VybmVscyA0LjE5IG9uIHRoZXNlIG1hY2hpbmVzIGZvciBub3c/Cj4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFNvbWV0aGluZyBsaWtlIHRoaXMgSSBndWVzczoK
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+ID4gPiBp
bmRleCA4YTU4YTJmMDEzYWYuLmNjNTk4MjE5M2E0MCAxMDA2NDQKPiA+ID4gPiA+ID4gLS0tIGEv
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYwo+ID4gPiA+ID4gPiBAQCAtMzA2Myw2ICszMDYzLDggQEAgc3RhdGljIGludCB2
aXJ0bmV0X3ZhbGlkYXRlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiA+ID4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICBfX3ZpcnRpb19jbGVhcl9iaXQodmRldiwgVklSVElPX05F
VF9GX01UVSk7Cj4gPiA+ID4gPiA+ICAgICAgICAgfQo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiAr
ICAgICAgIF9fdmlydGlvX2NsZWFyX2JpdCh2ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNCk7
Cj4gPiA+ID4gPiA+ICsgICAgICAgX192aXJ0aW9fY2xlYXJfYml0KHZkZXYsIFZJUlRJT19ORVRf
Rl9HVUVTVF9UU082KTsKPiA+ID4gPiA+ID4gICAgICAgICByZXR1cm4gMDsKPiA+ID4gPiA+ID4g
IH0KPiA+ID4gPiA+Cj4gPiA+ID4gPiBXaGVuIEkgYXBwbHkgeW91ciBwYXRjaCwgdGhlbiBJIHNl
ZSBkcmFzdGljIChtb3JlIHRoYW4gaGFsZikKPiA+ID4gPiA+IHJlZHVjdGlvbnMgaW4gc3BlZWQu
IChjb25maXJtZWQgd2l0aCBpcGVyZikuCj4gPiA+ID4gPgo+ID4gPiA+ID4gQnV0IGlmIGluc3Rl
YWQgSSBqdXN0IHJlbW92ZSBhIGZldyBsaW5lcyBmcm9tIGNvbW1pdAo+ID4gPiA+ID4gYTAyZTg5
NjRlYWY5MjcxYThhNWZjYzBjNTViZDEzZjkzM2JhZmM1Ngo+ID4gPiA+ID4gYXMgaW4gbXkgZWFy
bGllciBwb3N0LCB0aGVuIEknbSBiYWNrIHRvIGZ1bGwgc3BlZWQKPiA+ID4gPiA+Cj4gPiA+ID4g
PiBJIHVuZGVyc3RhbmQgdGhhdCB0aGlzIGlzIGp1c3QgdGVtcG9yYXJ5IHdvcmthcm91bmQsIHVu
dGlsIHdlIGZpZ3VyZSB0aGlzIG91dC4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gT2ggd2VpcmQu
IFNvIGl0J3Mgbm90IGFib3V0IGdldHRpbmcgc29tZSB3ZWlyZCBMUk8gcGFja2V0LiBXZSB3aWxs
IGdldCBpdCB3aXRoCj4gPiA+ID4gVklSVElPX05FVF9GX0dVRVNUX1RTTzQgYW55d2F5LiBJdCdz
IGFib3V0IHRoZSBMUk8gZmxhZyBiZWluZyBzZXQgaW4KPiA+ID4gPiBmZWF0dXJlcy4KPiA+ID4g
Pgo+ID4gPiA+IEhvdyBhYm91dCB0aGlzIHRoZW4/IEp1c3QgcHJldGVuZCB0byBMaW51eCB0aGF0
IHdlIGRpc2FibGVkIExSTy4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+
IGluZGV4IDhhNThhMmYwMTNhZi4uOGU3ZTRjZWExNzZiIDEwMDY0NAo+ID4gPiA+IC0tLSBhL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYwo+ID4gPiA+IEBAIC0yNjUxLDggKzI2NTEsOSBAQCBzdGF0aWMgaW50IHZpcnRuZXRfc2V0
X2ZlYXR1cmVzKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB+R1VFU1RfT0ZGTE9BRF9MUk9fTUFTSzsKPiA+ID4gPgo+ID4g
PiA+ICAgICAgICAgICAgICAgICBlcnIgPSB2aXJ0bmV0X3NldF9ndWVzdF9vZmZsb2Fkcyh2aSwg
b2ZmbG9hZHMpOwo+ID4gPiA+IC0gICAgICAgICAgICAgICBpZiAoZXJyKQo+ID4gPiA+IC0gICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiBlcnI7Cj4gPiA+ID4gKyAgICAgICAgICAgICAgIFdB
Uk5fT04oZXJyKTsKPiA+ID4gPiArICAgICAgICAgICAgICAgLy9pZiAoZXJyKQo+ID4gPiA+ICsg
ICAgICAgICAgICAgICAvLyAgICAgIHJldHVybiBlcnI7Cj4gPiA+ID4gICAgICAgICAgICAgICAg
IHZpLT5ndWVzdF9vZmZsb2FkcyA9IG9mZmxvYWRzOwo+ID4gPiA+ICAgICAgICAgfQo+ID4gPgo+
ID4gPiBOby4gV2l0aCB0aGlzIGFwcGxpZWQsIHRoZSBwcm9ibGVtIHBlcnNpc3RzOgo+ID4gPgo+
ID4gPiAjIGVjaG8gIjEiID4gL3Byb2Mvc3lzL25ldC9pcHY0L2lwX2ZvcndhcmQKPiA+ID4KPiA+
ID4ga2VybmVsOiAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0KPiA+ID4ga2Vy
bmVsOiBuZXRkZXZpY2U6IGV0aDA6IGZhaWxlZCB0byBkaXNhYmxlIExSTyEKPiA+ID4ga2VybmVs
OiBXQVJOSU5HOiBDUFU6IDAgUElEOiA0NTIgYXQgbmV0L2NvcmUvZGV2LmM6MTc2OAo+ID4gPiBk
ZXZfZGlzYWJsZV9scm8rMHgxMDgvMHgxNTAKPiA+ID4ga2VybmVsOiBNb2R1bGVzIGxpbmtlZCBp
bjogc2cgbmxzX2lzbzg4NTlfMSBubHNfY3A0MzcgdmZhdCBmYXQKPiA+ID4gaGlkX2dlbmVyaWMg
dXNiaGlkIGhpZCB2aXJ0aW9fbmV0IG5ldF9mYWlsb3ZlciBmYWlsb3ZlciBhZXNuaV9pbnRlbAo+
ID4gPiBsaWJhZXMgY3J5cHRvX3NpbWQgb2hjaV9wY2kgYWhjaSBsaWJhaGNpIGNyeXB0ZCByYXBs
IGVoY2lfcGNpIG9oY2lfaGNkCj4gPiA+IGVoY2lfaGNkIHVzYmNvcmUgdXNiX2NvbW1vbiBsaWJh
dGEgZXZkZXYgbHBjX2ljaCBtZmRfY29yZSBybmdfY29yZQo+ID4gPiBpMmNfcGlpeDQgaTJjX2Nv
cmUgdmlydGlvX3BjaSB2aXJ0aW9fcGNpX21vZGVybl9kZXYgdmlydGlvX3JpbmcgdmlydGlvCj4g
PiA+IHJ0Y19jbW9zIGF0a2JkIGxpYnBzMiBpODA0MiBzZXJpbyBiYXR0ZXJ5IGFjIGJ1dHRvbiBs
b29wIHVuaXgKPiA+ID4ga2VybmVsOiBDUFU6IDAgUElEOiA0NTIgQ29tbTogYmFzaCBOb3QgdGFp
bnRlZCA1LjEzLjctZ251LjEtTnVNaW5pICMxCj4gPiA+IGtlcm5lbDogSGFyZHdhcmUgbmFtZTog
aW5ub3RlayBHbWJIIFZpcnR1YWxCb3gvVmlydHVhbEJveCwgQklPUwo+ID4gPiBWaXJ0dWFsQm94
IDEyLzAxLzIwMDYKPiA+ID4ga2VybmVsOiBSSVA6IDAwMTA6ZGV2X2Rpc2FibGVfbHJvKzB4MTA4
LzB4MTUwCj4gPgo+ID4gQWdhaW4gdGhlIHdhcm5pbmcgaXNuJ3QgYSBiaWcgZGVhbC4gSSBhZ3Jl
ZSB3ZSBzaG91bGQgYWRkcmVzcyAtIEphc29uCj4gPiBhbnkgdXBkYXRlPwo+IAo+IEkgc3RpbGwg
dGhpbmsgdXNpbmcgTkVUSUZfRl9MUk8gbWlnaHQgbm90IGJlIGNvcnJlY3QuIFNpbmNlIHdlJ3Jl
Cj4gYmFzaWNhbGx5IHJlY2VpdmluZyBHU08gcGFja2V0cy4KPiAKPiBBbmQgaXQgbWlnaHQgY2F1
c2UgYSBsb3Qgb2YgaXNzdWVzIGlmIHRoZSBkZXZpY2UgZG9lc24ndCBoYXZlCj4gVklSVElPX05F
VF9GX0NUUkxfR1VFU1RfT0ZGTE9BRFMuCj4gCj4gSSBzZWUgdHdvIHBvc3NpYmxlIGZpeGVzOgo+
IAo+IDEpIHVzaW5nIE5FVElGX0ZfR1JPX0hXIGluc3RlYWQgKHRoZSBwYXRjaCBpcyBhdHRhY2hl
ZCkKCkl0J3MgdW5mb3J0dW5hdGUgeW91IGRpZG4ndCBpbmxpbmUuIEFueXdheS4KSXZhbiBjb3Vs
ZCB5b3UgdGVzdCB0aGUgcGF0Y2ggYW5kIHJlcG9ydD8KCj4gCj4gb3IKCkhtbS4gSSBhbSBub3Qg
c3VyZSB3ZSBhbHdheXMgcHJlc2VydmUgdGhlIEdST19IVyByZXF1aXJlbWVudCB0aGF0CnBhY2tl
dHMgY2FuIGJlIHJlLXNlZ21lbnRlZCB0byByZWNvbnN0cnVjdCB0aGUgb3JpZ2luYWwgcGFja2V0
IHN0cmVhbS4gCkRvIGFsbCBiYWNrZW5kcyBndWFyYW50ZWUgdGhpcz8gQ291bGQgeW91IGV4cGxh
aW4gd2h5PwoKCgo+IDIpIHNldCBORVRJRl9GX0xSTyBvbmx5IGlmIHRoZSBkZXZpY2UgaGFzIENU
UkxfR1VFU1RfT0ZGTE9BRFMKPiAKPiBUaGFua3MKCgpUaGlzIG9uZSB3b3VsZCBzbG93IGd1ZXN0
cyBvbiBvbGQgaG9zdHMgZG93biBzaWduaWZpY2FudGx5LgoKSSBhbSBub3Qgc3VyZSB3aHkgdGhp
cyBkaWRuJ3QgdHJpZ2dlciBwcmV2aW91c2x5IGJ0dyAtCndlIHVzZWQgbm90IHRvIGhhdmUgQ1RS
TF9HVUVTVF9PRkZMT0FEUyBhZnRlciBhbGwuCgoKCj4gPiBCdXQgdGhlIG1haW4gaXNzdWUgaXMg
eW91IGxvc2UgY29ubmVjdGl2aXR5LiBUaGF0IHN0aWxsCj4gPiBwZXJzaXN0cyB3aXRoIHRoaXM/
IENhbid0IHlvdSBnZXQgYSBzZXJpYWwgY29ubmVjdGlvbgo+ID4gb3V0PyBJIGtub3cgcWVtdSBE
aWQgdGhlIGtlcm5lbCBvb3BzIGFmdGVyd2FyZHM/Cj4gPgo+ID4gLS0KPiA+IE1TVAo+ID4KCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u

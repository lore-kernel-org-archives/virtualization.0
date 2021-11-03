Return-Path: <SRS0=Oeu7=PW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6246EC433EF
	for <virtualization@archiver.kernel.org>; Wed,  3 Nov 2021 03:18:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E816160F24
	for <virtualization@archiver.kernel.org>; Wed,  3 Nov 2021 03:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E816160F24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A943740448;
	Wed,  3 Nov 2021 03:18:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JfooFDCCfYUi; Wed,  3 Nov 2021 03:18:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 25B76403EE;
	Wed,  3 Nov 2021 03:18:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB8B3C0019;
	Wed,  3 Nov 2021 03:18:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0D89C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 03:18:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C9BDF80B02
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 03:18:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id inDMY4AZ2xzs
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 03:18:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1553980AF4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 03:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635909526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nbi9rn2xsE5yf8jFyQAhibGX8oN+6/Yf35r4qZ0RW1k=;
 b=ERmHe+BagyaXUOHHmDoSClFnEN5pflKxE32b89F8JCz5X6GDioosc+DCKb+h+9CiHgRh4n
 p7d7BS5LzPgnSWrhRnEkmvTgYNiOT96ZRhNtBjSC6xUERWQ9R0hx/Qk9qPckHXm+a+h7Ls
 hLcUwGMgxJctdHPFZ7BaHnnac1PoY/o=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-ar0qSHzWM0GF7jJac9vs0A-1; Tue, 02 Nov 2021 23:18:43 -0400
X-MC-Unique: ar0qSHzWM0GF7jJac9vs0A-1
Received: by mail-lj1-f198.google.com with SMTP id
 v2-20020a2e5042000000b00216bb21d8b8so504568ljd.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 Nov 2021 20:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nbi9rn2xsE5yf8jFyQAhibGX8oN+6/Yf35r4qZ0RW1k=;
 b=VTElf+LNEMJBYXQhr1hL/itACwXa75pd09NlH7DxmIE5RRZGrFvS0lI70wpKjkrVwu
 7r9qE/dRx1/V5DLMbj6UW4Qts/mEkrktdVdzTO0n+9ad/zxxknHXpGSRjtZl9cUjWWcO
 YgY8t1m1NOJojFLEUexr5+vvqswJThomi1SI19AUvnoPfobAqHoxFvHWNSEMBfyQaQV3
 vIW/WOFT6zo6Zi5w1GVoXr0akjfqPI/vjUhzOUs+587+tsEjh3lfiBFcftR+VP4QtRpG
 26dSq04bgQ1T9qrkVZrMsCV9hfpMvTy8Ee77oDalT8LnYymHqZtXEdmzVaUFHqUvyYMm
 aO7g==
X-Gm-Message-State: AOAM5316cdkxO1LQFnvF3F1sPcXB47FTAhcs0PL1yZ7jdi12DomDj7BA
 zQYmKLuKFNYJ9suYvg8Ix1eGK41E8H1D5u8djYuxe5GF9NSNPI3eql3eGa9zGQ5zY1riF25uLF7
 YBklWPv1T0MTqg0+P1RGhgsBZCLeW2GDbrIU8/XENUANEK/qVfbtm4Ofozw==
X-Received: by 2002:a05:651c:1254:: with SMTP id
 h20mr43543801ljh.420.1635909522341; 
 Tue, 02 Nov 2021 20:18:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxi1q1R1sCNlX0y74CNOGX7yiG87rnq/CIa6IVvhtvbbPlNJwhZY0tF688cVh8XLXLBPy6krwe4saZaLPCIB0w=
X-Received: by 2002:a05:651c:1254:: with SMTP id
 h20mr43543779ljh.420.1635909522140; 
 Tue, 02 Nov 2021 20:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211029183525.1776416-1-eperezma@redhat.com>
 <20211029183525.1776416-22-eperezma@redhat.com>
 <CACGkMEt8fusPLj3=E1GETzotMOhkuTAzD_bON0hQEjNecg2GcQ@mail.gmail.com>
 <CAJaqyWfdZwW82cTXwfdyfcLZUyKyw7R2wcwF2SM0wwTcVmZ_yQ@mail.gmail.com>
In-Reply-To: <CAJaqyWfdZwW82cTXwfdyfcLZUyKyw7R2wcwF2SM0wwTcVmZ_yQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Nov 2021 11:18:30 +0800
Message-ID: <CACGkMEvw8-D7VL3P0QJcn3zNFW3St3cEncqFfBW1J+m1b99CAQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 21/26] vhost: Add vhost_svq_valid_guest_features to
 shadow vq
To: Eugenio Perez Martin <eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Parav Pandit <parav@mellanox.com>
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

T24gVHVlLCBOb3YgMiwgMjAyMSBhdCA0OjEwIFBNIEV1Z2VuaW8gUGVyZXogTWFydGluIDxlcGVy
ZXptYUByZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgTm92IDIsIDIwMjEgYXQgNjoyNiBB
TSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBTYXQs
IE9jdCAzMCwgMjAyMSBhdCAyOjQ0IEFNIEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQu
Y29tPiB3cm90ZToKPiA+ID4KPiA+ID4gVGhpcyBhbGxvd3MgaXQgdG8gdGVzdCBpZiB0aGUgZ3Vl
c3QgaGFzIGFrbm93bGVkZ2UgYW4gaW52YWxpZCB0cmFuc3BvcnQKPiA+ID4gZmVhdHVyZSBmb3Ig
U1ZRLiBUaGlzIHdpbGwgaW5jbHVkZSBwYWNrZWQgdnEgbGF5b3V0IG9yIGV2ZW50X2lkeCwKPiA+
ID4gd2hlcmUgVmlydElPIGRldmljZSBuZWVkcyBoZWxwIGZyb20gU1ZRLgo+ID4gPgo+ID4gPiBU
aGVyZSBpcyBub3QgbmVlZGVkIGF0IHRoaXMgbW9tZW50LCBidXQgc2luY2UgU1ZRIHdpbGwgbm90
IHJlLW5lZ290aWF0ZQo+ID4gPiBmZWF0dXJlcyBhZ2FpbiB3aXRoIHRoZSBndWVzdCwgYSBmYWls
dXJlIGluIGFja25vd2xlZGdlIHRoZW0gaXMgZmF0YWwKPiA+ID4gZm9yIFNWUS4KPiA+ID4KPiA+
Cj4gPiBJdCdzIG5vdCBjbGVhciB0byBtZSB3aHkgd2UgbmVlZCB0aGlzLiBNYXliZSB5b3UgY2Fu
IGdpdmUgbWUgYW4KPiA+IGV4YW1wbGUuIEUuZyBpc24ndCBpdCBzdWZmaWNpZW50IHRvIGZpbHRl
ciBvdXQgdGhlIGRldmljZSB3aXRoCj4gPiBldmVudF9pZHg/Cj4gPgo+Cj4gSWYgdGhlIGd1ZXN0
IGRpZCBuZWdvdGlhdGUgX0ZfRVZFTlRfSURYLCBpdCBleHBlY3RzIHRvIGJlIG5vdGlmaWVkCj4g
b25seSB3aGVuIGRldmljZSBtYXJrcyBhcyB1c2VkIGEgc3BlY2lmaWMgbnVtYmVyIG9mIGRlc2Ny
aXB0b3JzLgo+Cj4gSWYgd2UgdXNlIFZpcnRRdWV1ZSBub3RpZmljYXRpb24sIHRoZSBWaXJ0UXVl
dWUgY29kZSBoYW5kbGVzIGl0Cj4gdHJhbnNwYXJlbnRseS4gQnV0IGlmIHdlIHdhbnQgdG8gYmUg
YWJsZSB0byBjaGFuZ2UgdGhlIGd1ZXN0IFZRJ3MKPiBjYWxsX2ZkLCB3ZSBjYW5ub3QgdXNlIFZp
cnRRdWV1ZSdzLCBzbyB0aGlzIG5lZWRzIHRvIGJlIGhhbmRsZWQgYnkgU1ZRCj4gY29kZS4gQW5k
IHRoYXQgaXMgc3RpbGwgbm90IGltcGxlbWVudGVkLgo+Cj4gT2YgY291cnNlIGluIHRoZSBldmVu
dF9pZHggY2FzZSB3ZSBjb3VsZCBqdXN0IGlnbm9yZSBpdCBhbmQgbm90aWZ5IGluCj4gYWxsIHVz
ZWQgZGVzY3JpcHRvcnMsIGJ1dCBpdCBzZWVtcyBub3QgcG9saXRlIHRvIG1lIDopLiBJIHdpbGwg
ZGV2ZWxvcAo+IGV2ZW50X2lkeCBvbiB0b3Agb2YgdGhpcywgZWl0aGVyIGV4cG9zaW5nIHRoZSBu
ZWVkZWQgcGllY2VzIGluCj4gVmlydFF1ZXVlIChJIHByZWZlciB0aGlzKSBvciByb2xsaW5nIG91
ciBvd24gaW4gU1ZRLgoKWWVzLCBidXQgd2hhdCBJIG1lYW50IGlzLCB3ZSBjYW4gZmFpbCB0aGUg
U1ZRIGVuYWJsaW5nIGlmIHRoZSBkZXZpY2UKc3VwcG9ydHMgZXZlbnRfaWR4LiBUaGVuIHdlJ3Jl
IHN1cmUgZ3Vlc3RzIHdvbid0IG5lZ290aWF0ZSBldmVudF9pZHguCgpUaGFua3MKCj4KPiBTYW1l
IHJlYXNvbmluZyBjYW4gYmUgYXBwbGllZCB0byB1bmtub3duIHRyYW5zcG9ydCBmZWF0dXJlcy4K
Pgo+IFRoYW5rcyEKPgo+ID4gVGhhbmtzCj4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlv
IFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiA+ID4gLS0tCj4gPiA+ICBody92aXJ0aW8v
dmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oIHwgMSArCj4gPiA+ICBody92aXJ0aW8vdmhvc3Qtc2hh
ZG93LXZpcnRxdWV1ZS5jIHwgNiArKysrKysKPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNl
cnRpb25zKCspCj4gPiA+Cj4gPiA+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3Qtc2hhZG93
LXZpcnRxdWV1ZS5oIGIvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuaAo+ID4gPiBp
bmRleCA5NDZiMmM2Mjk1Li5hYzU1NTg4MDA5IDEwMDY0NAo+ID4gPiAtLS0gYS9ody92aXJ0aW8v
dmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oCj4gPiA+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC1zaGFk
b3ctdmlydHF1ZXVlLmgKPiA+ID4gQEAgLTE2LDYgKzE2LDcgQEAKPiA+ID4gIHR5cGVkZWYgc3Ry
dWN0IFZob3N0U2hhZG93VmlydHF1ZXVlIFZob3N0U2hhZG93VmlydHF1ZXVlOwo+ID4gPgo+ID4g
PiAgYm9vbCB2aG9zdF9zdnFfdmFsaWRfZGV2aWNlX2ZlYXR1cmVzKHVpbnQ2NF90ICpmZWF0dXJl
cyk7Cj4gPiA+ICtib29sIHZob3N0X3N2cV92YWxpZF9ndWVzdF9mZWF0dXJlcyh1aW50NjRfdCAq
ZmVhdHVyZXMpOwo+ID4gPgo+ID4gPiAgdm9pZCB2aG9zdF9zdnFfc2V0X3N2cV9raWNrX2ZkKFZo
b3N0U2hhZG93VmlydHF1ZXVlICpzdnEsIGludCBzdnFfa2lja19mZCk7Cj4gPiA+ICB2b2lkIHZo
b3N0X3N2cV9zZXRfZ3Vlc3RfY2FsbF9ub3RpZmllcihWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3Zx
LCBpbnQgY2FsbF9mZCk7Cj4gPiA+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3Qtc2hhZG93
LXZpcnRxdWV1ZS5jIGIvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYwo+ID4gPiBp
bmRleCA2ZTA1MDhhMjMxLi5jYjlmZmNiMDE1IDEwMDY0NAo+ID4gPiAtLS0gYS9ody92aXJ0aW8v
dmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5jCj4gPiA+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC1zaGFk
b3ctdmlydHF1ZXVlLmMKPiA+ID4gQEAgLTYyLDYgKzYyLDEyIEBAIGJvb2wgdmhvc3Rfc3ZxX3Zh
bGlkX2RldmljZV9mZWF0dXJlcyh1aW50NjRfdCAqZGV2X2ZlYXR1cmVzKQo+ID4gPiAgICAgIHJl
dHVybiB0cnVlOwo+ID4gPiAgfQo+ID4gPgo+ID4gPiArLyogSWYgdGhlIGd1ZXN0IGlzIHVzaW5n
IHNvbWUgb2YgdGhlc2UsIFNWUSBjYW5ub3QgY29tbXVuaWNhdGUgKi8KPiA+ID4gK2Jvb2wgdmhv
c3Rfc3ZxX3ZhbGlkX2d1ZXN0X2ZlYXR1cmVzKHVpbnQ2NF90ICpndWVzdF9mZWF0dXJlcykKPiA+
ID4gK3sKPiA+ID4gKyAgICByZXR1cm4gdHJ1ZTsKPiA+ID4gK30KPiA+ID4gKwo+ID4gPiAgLyog
Rm9yd2FyZCBndWVzdCBub3RpZmljYXRpb25zICovCj4gPiA+ICBzdGF0aWMgdm9pZCB2aG9zdF9o
YW5kbGVfZ3Vlc3Rfa2ljayhFdmVudE5vdGlmaWVyICpuKQo+ID4gPiAgewo+ID4gPiAtLQo+ID4g
PiAyLjI3LjAKPiA+ID4KPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

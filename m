Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B60C433F5
	for <virtualization@archiver.kernel.org>; Mon, 21 Feb 2022 07:44:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 500B960B44;
	Mon, 21 Feb 2022 07:44:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GdvfpAd3uiTW; Mon, 21 Feb 2022 07:44:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B966360674;
	Mon, 21 Feb 2022 07:44:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF874C0072;
	Mon, 21 Feb 2022 07:44:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0581CC001A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:44:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E822C60B99
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:44:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e9rRi4Sd7BZ3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:44:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2269460A89
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645429451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kuKgTI/RwPWsvniqSsC4/B9sBnaFVNlbje0ummfh5IQ=;
 b=ORCH7qZpCwtqf4wlG50/JltEiGtNZIFVtjcvQ5/vI1rNQEL4k9qR5lsiPqF6GbgHoW5T4X
 r4M8ZsKOAKFERHoitW2404I4TkoqGaAyHGytXvhefSpleABAKtS8a7B24u6G9dHGdq2Sjl
 1IezjhwwVFDupKoGefXjGQu2yhtYya4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-86vL0AibNuu6qHwmzO2r2g-1; Mon, 21 Feb 2022 02:44:08 -0500
X-MC-Unique: 86vL0AibNuu6qHwmzO2r2g-1
Received: by mail-pj1-f72.google.com with SMTP id
 fa22-20020a17090af0d600b001bb93310b41so6920410pjb.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Feb 2022 23:44:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=kuKgTI/RwPWsvniqSsC4/B9sBnaFVNlbje0ummfh5IQ=;
 b=jw7nAjOA1mCRjv5KE1oQnf5hh2Ry2uLX5rPRC6vpRP0yDcpakBTibiulwKygQJB13e
 mm7KdIW6EbzzwAViOQ5vjGSybLT3j/C7JatBqPYY/hirBpNyvfkcQEidldQGSZEnmn+5
 J9mC3voaSKq0PZ59rgP3fSvfAFHAJLfZofsAd1A/kb+FjdpSTpKw7T0O6XzDUIBzOBNz
 jReF1z0uLVGXhI/Bd5WHwi3iR4uSvje5DGkq2oCkkETXmc9MirUQGydxTExvxHR9R7wr
 akXX3iVdrkrt5gZSRuIK07GjlqGsUxQMeWcyLcx/7oQw3Gotcnn8t2pveV6J7eE+gK3F
 HRLQ==
X-Gm-Message-State: AOAM532HRRW9Pd8HCPmuT8HeCsz78GAJA1tOthU9WxN+Ao7LsCW6FoX9
 h7s6E8zs04zkAXL5kuwrwCLStGQY+uyV/HIM1C8h7PWHKsozPQOZYPO+XQlRWXM9gyNsOjCGd8u
 Qp5Ntc8ZhIaCCYELFsmufLszMsBDso4UfeN73GqF3rg==
X-Received: by 2002:a63:6242:0:b0:348:601c:25fc with SMTP id
 w63-20020a636242000000b00348601c25fcmr15173769pgb.467.1645429447062; 
 Sun, 20 Feb 2022 23:44:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvgt0TkFXVzZ6g3rO66/RNNA49lcJFSfwSFXoaEu42XpK0EhDU8ZV453i7HX3w75IKc+TeHg==
X-Received: by 2002:a63:6242:0:b0:348:601c:25fc with SMTP id
 w63-20020a636242000000b00348601c25fcmr15173738pgb.467.1645429446796; 
 Sun, 20 Feb 2022 23:44:06 -0800 (PST)
Received: from [10.72.12.96] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id e20sm10151695pfv.42.2022.02.20.23.43.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Feb 2022 23:44:06 -0800 (PST)
Message-ID: <7e72def5-a1e9-ad92-2c83-fda72ffd7b60@redhat.com>
Date: Mon, 21 Feb 2022 15:43:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH 18/31] vhost: Shadow virtqueue buffers forwarding
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-19-eperezma@redhat.com>
 <62e877ca-51d7-da85-13c9-d469a85f33c9@redhat.com>
 <CAJaqyWfF01k3LntM7RLEmFcej=EY2d4+2MARKXPptQ2J7VnB9A@mail.gmail.com>
 <7c52e50a-4c8e-7865-1c3d-8b156986c13a@redhat.com>
 <CAJaqyWedqtzRW=ur7upchneSc-oOkvkr3FUph_BfphV3zTmnkw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWedqtzRW=ur7upchneSc-oOkvkr3FUph_BfphV3zTmnkw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Gautam Dawar <gdawar@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Blake <eblake@redhat.com>
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

CuWcqCAyMDIyLzIvMTcg5LiL5Y2IODo0OCwgRXVnZW5pbyBQZXJleiBNYXJ0aW4g5YaZ6YGTOgo+
IE9uIFR1ZSwgRmViIDgsIDIwMjIgYXQgOToxNiBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPj4KPj4g5ZyoIDIwMjIvMi8xIOS4i+WNiDc6MjUsIEV1Z2VuaW8gUGVy
ZXogTWFydGluIOWGmemBkzoKPj4+IE9uIFN1biwgSmFuIDMwLCAyMDIyIGF0IDc6NDcgQU0gSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4g5ZyoIDIwMjIvMS8yMiDk
uIrljYg0OjI3LCBFdWdlbmlvIFDDqXJleiDlhpnpgZM6Cj4+Pj4+IEBAIC0yNzIsNiArNTkwLDI4
IEBAIHZvaWQgdmhvc3Rfc3ZxX3NldF9zdnFfa2lja19mZChWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAq
c3ZxLCBpbnQgc3ZxX2tpY2tfZmQpCj4+Pj4+ICAgICB2b2lkIHZob3N0X3N2cV9zdG9wKFZob3N0
U2hhZG93VmlydHF1ZXVlICpzdnEpCj4+Pj4+ICAgICB7Cj4+Pj4+ICAgICAgICAgZXZlbnRfbm90
aWZpZXJfc2V0X2hhbmRsZXIoJnN2cS0+c3ZxX2tpY2ssIE5VTEwpOwo+Pj4+PiArICAgIGdfYXV0
b2ZyZWUgVmlydFF1ZXVlRWxlbWVudCAqbmV4dF9hdmFpbF9lbGVtID0gTlVMTDsKPj4+Pj4gKwo+
Pj4+PiArICAgIGlmICghc3ZxLT52cSkgewo+Pj4+PiArICAgICAgICByZXR1cm47Cj4+Pj4+ICsg
ICAgfQo+Pj4+PiArCj4+Pj4+ICsgICAgLyogU2VuZCBhbGwgcGVuZGluZyB1c2VkIGRlc2NyaXB0
b3JzIHRvIGd1ZXN0ICovCj4+Pj4+ICsgICAgdmhvc3Rfc3ZxX2ZsdXNoKHN2cSwgZmFsc2UpOwo+
Pj4+IERvIHdlIG5lZWQgdG8gd2FpdCBmb3IgYWxsIHRoZSBwZW5kaW5nIGRlc2NyaXB0b3JzIHRv
IGJlIGNvbXBsZXRlZCBoZXJlPwo+Pj4+Cj4+PiBObywgdGhpcyBmdW5jdGlvbiBkb2VzIG5vdCB3
YWl0LCBpdCBvbmx5IGNvbXBsZXRlcyB0aGUgZm9yd2FyZGluZyBvZgo+Pj4gdGhlICp1c2VkKiBk
ZXNjcmlwdG9ycy4KPj4+Cj4+PiBUaGUgYmVzdCBleGFtcGxlIGlzIHRoZSBuZXQgcnggcXVldWUg
aW4gbXkgb3Bpbmlvbi4gVGhpcyBjYWxsIHdpbGwKPj4+IGNoZWNrIFNWUSdzIHZyaW5nIHVzZWRf
aWR4IGFuZCB3aWxsIGZvcndhcmQgdGhlIGxhc3QgdXNlZCBkZXNjcmlwdG9ycwo+Pj4gaWYgYW55
LCBidXQgYWxsIGF2YWlsYWJsZSBkZXNjcmlwdG9ycyB3aWxsIHJlbWFpbiBhcyBhdmFpbGFibGUg
Zm9yCj4+PiBxZW11J3MgVlEgY29kZS4KPj4+Cj4+PiBUbyBza2lwIGl0IHdvdWxkIG1pc3MgdGhv
c2UgbGFzdCByeCBkZXNjcmlwdG9ycyBpbiBtaWdyYXRpb24uCj4+Pgo+Pj4gVGhhbmtzIQo+Pgo+
PiBTbyBpdCdzIHByb2JhYmx5IHRvIG5vdCB0aGUgYmVzdCBwbGFjZSB0byBhc2suIEl0J3MgbW9y
ZSBhYm91dCB0aGUKPj4gaW5mbGlnaHQgZGVzY3JpcHRvcnMgc28gaXQgc2hvdWxkIGJlIFRYIGlu
c3RlYWQgb2YgUlguCj4+Cj4+IEkgY2FuIGltYWdpbmUgdGhlIG1pZ3JhdGlvbiBsYXN0IHBoYXNl
LCB3ZSBzaG91bGQgc3RvcCB0aGUgdmhvc3QtdkRQQQo+PiBiZWZvcmUgY2FsbGluZyB2aG9zdF9z
dnFfc3RvcCgpLiBUaGVuIHdlIHNob3VsZCBiZSBmaW5lIHJlZ2FyZGxlc3Mgb2YKPj4gaW5mbGln
aHQgZGVzY3JpcHRvcnMuCj4+Cj4gSSB0aGluayBJJ20gc3RpbGwgbWlzc2luZyBzb21ldGhpbmcg
aGVyZS4KPgo+IFRvIGJlIG9uIHRoZSBzYW1lIHBhZ2UuIFJlZ2FyZGluZyB0eCB0aGlzIGNvdWxk
IGNhdXNlIHJlcGVhdGVkIHR4Cj4gZnJhbWVzIChvbmUgYXQgc291cmNlIGFuZCBvdGhlciBhdCBk
ZXN0aW5hdGlvbiksIGJ1dCBuZXZlciBhIG1pc3NlZAo+IGJ1ZmZlciBub3QgdHJhbnNtaXR0ZWQu
IFRoZSAic3RvcCBiZWZvcmUiIGNvdWxkIGJlIGludGVycHJldGVkIGFzICJTVlEKPiBpcyBub3Qg
Zm9yd2FyZGluZyBhdmFpbGFibGUgYnVmZmVycyBhbnltb3JlIi4gV291bGQgdGhhdCB3b3JrPwoK
ClJpZ2h0LCBidXQgdGhpcyBvbmx5IHdvcmsgaWYKCjEpIGEgZmx1c2ggdG8gbWFrZSBzdXJlIFRY
IERNQSBmb3IgaW5mbGlnaHQgZGVzY3JpcHRvcnMgYXJlIGFsbCBjb21wbGV0ZWQKCjIpIGp1c3Qg
bWFyayBhbGwgaW5mbGlnaHQgZGVzY3JpcHRvciB1c2VkCgpPdGhlcndpc2UgdGhlcmUgY291bGQg
YmUgYnVmZmVycyB0aGF0IGlzIGluZmxpZ2h0IGZvcmV2ZXIuCgpUaGFua3MKCgo+Cj4gVGhhbmtz
IQo+Cj4+IFRoYW5rcwo+Pgo+Pgo+Pj4+IFRoYW5rcwo+Pj4+Cj4+Pj4KPj4+Pj4gKwo+Pj4+PiAr
ICAgIGZvciAodW5zaWduZWQgaSA9IDA7IGkgPCBzdnEtPnZyaW5nLm51bTsgKytpKSB7Cj4+Pj4+
ICsgICAgICAgIGdfYXV0b2ZyZWUgVmlydFF1ZXVlRWxlbWVudCAqZWxlbSA9IE5VTEw7Cj4+Pj4+
ICsgICAgICAgIGVsZW0gPSBnX3N0ZWFsX3BvaW50ZXIoJnN2cS0+cmluZ19pZF9tYXBzW2ldKTsK
Pj4+Pj4gKyAgICAgICAgaWYgKGVsZW0pIHsKPj4+Pj4gKyAgICAgICAgICAgIHZpcnRxdWV1ZV9k
ZXRhY2hfZWxlbWVudChzdnEtPnZxLCBlbGVtLCBlbGVtLT5sZW4pOwo+Pj4+PiArICAgICAgICB9
Cj4+Pj4+ICsgICAgfQo+Pj4+PiArCj4+Pj4+ICsgICAgbmV4dF9hdmFpbF9lbGVtID0gZ19zdGVh
bF9wb2ludGVyKCZzdnEtPm5leHRfZ3Vlc3RfYXZhaWxfZWxlbSk7Cj4+Pj4+ICsgICAgaWYgKG5l
eHRfYXZhaWxfZWxlbSkgewo+Pj4+PiArICAgICAgICB2aXJ0cXVldWVfZGV0YWNoX2VsZW1lbnQo
c3ZxLT52cSwgbmV4dF9hdmFpbF9lbGVtLAo+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgbmV4dF9hdmFpbF9lbGVtLT5sZW4pOwo+Pj4+PiArICAgIH0KPj4+Pj4gICAgIH0K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==

Return-Path: <SRS0=15I4=NC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEF0C4338F
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 07:47:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C4360EB5
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 07:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 51C4360EB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0846460879;
	Wed, 11 Aug 2021 07:47:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DnrCCzsXPVNS; Wed, 11 Aug 2021 07:47:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9D68B6086A;
	Wed, 11 Aug 2021 07:47:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56619C001A;
	Wed, 11 Aug 2021 07:47:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F3BCC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 07:47:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 39BAF402D8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 07:47:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JO0zw9AreFdJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 07:47:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8B251402A8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 07:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628668024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rSLommB+NvYpAodfBbuK+2QImOl1gzfEQlxBtMzInww=;
 b=KUkG84oSIH4KvYfe+5BGgHQm0mrs10NNnPVvu/Lvz9dC6psr9ydzEcuV06+vKMT1oil58e
 ZMhT3LgpoxPd+D+LjE/K3CE4PmIMaP118RX84pLlOx+1fuBtX1zt/EyY/odF9SQzds6iSs
 uTcKIrfhHY7UhFq33zgZ8OCEvShPXKg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-b1UrMeEGOxeleHHvWL2lng-1; Wed, 11 Aug 2021 03:45:55 -0400
X-MC-Unique: b1UrMeEGOxeleHHvWL2lng-1
Received: by mail-pl1-f197.google.com with SMTP id
 h19-20020a170902eed3b029012d3624d993so927202plb.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 00:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=rSLommB+NvYpAodfBbuK+2QImOl1gzfEQlxBtMzInww=;
 b=C8KVgGy0zIAcwOOM4bRe6h4+X2pE/N3Uq6+ZF+J0+Rdn9wpSNKNS7vXzt/KHKkUy02
 FNBI3Ii6Ammwrut/e3U4107oHVkYCwO9kbk+EqVVe0JCGhOvDmdG2eE1PAeQwpQ3gGzd
 ilWxYGnUkEOqAnJS108ho/Wvc/Avkbmwn07jdv+DyT8eTV5kKoB+5MIqJHDA+GQWzvE+
 WZs3FVrevEkWQ3rjx5tVFA2rZFVfIehx3zh2LLCe6I5D2Fz42d3zEBAhEKzavwj+oDmx
 NaVDBann8zI+ZfDf8ODye6DVXa3zPjFd6twLIw9L+V4zs1UCFKpkbVC94/JnfBKvtMiq
 oygA==
X-Gm-Message-State: AOAM5302Uy9isx6/IjJApXARQ56SWJg1DJAbq00WCcJAvZpqAiHUw9qY
 qE5CsQG9UAS3JEzcEp+BUC+AJLeVJoz5AyVLEXBdi2iasX+DUwg+Azl6yzd6X+MNJFpomIXwOWj
 vUI7tlWAcc6ZhCyrr0EbailmWAkgKid5Yvemlj3zklQ==
X-Received: by 2002:a63:5706:: with SMTP id l6mr70720pgb.217.1628667953895;
 Wed, 11 Aug 2021 00:45:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygKzdhtlhbdfTizH+pF7oqeyTVpEAClgT43Sl5b86BLr1rmh9SRCZKflogQjv+tyofrNy2iQ==
X-Received: by 2002:a63:5706:: with SMTP id l6mr70696pgb.217.1628667953613;
 Wed, 11 Aug 2021 00:45:53 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id g22sm17468306pfo.164.2021.08.11.00.45.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Aug 2021 00:45:53 -0700 (PDT)
Subject: Re: PROBLEM: virtio_net LRO kernel panics
To: "Michael S. Tsirkin" <mst@redhat.com>
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
 <20210811030612-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <847f9477-634f-bf14-967e-38852c82a841@redhat.com>
Date: Wed, 11 Aug 2021 15:45:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811030612-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzgvMTEg5LiL5Y2IMzozOSwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiBP
biBXZWQsIEF1ZyAxMSwgMjAyMSBhdCAxMTozODo1OUFNICswODAwLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+PiBPbiBUdWUsIEF1ZyAxMCwgMjAyMSBhdCAxMTozMSBQTSBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPiB3cm90ZToKPj4+IE9uIE1vbiwgQXVnIDAyLCAyMDIxIGF0IDA0OjIz
OjEyUE0gLTA1MDAsIEl2YW4gd3JvdGU6Cj4+Pj4gT24gTW9uLCBBdWcgMiwgMjAyMSBhdCAyOjUy
IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+PiBPbiBN
b24sIEF1ZyAwMiwgMjAyMSBhdCAwMTozMjowNVBNIC0wNTAwLCBJdmFuIHdyb3RlOgo+Pj4+Pj4g
T24gVHVlLCBKdWwgMjcsIDIwMjEgYXQgNDoxMSBBTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+PiBPbiBNb24sIEp1bCAyNiwgMjAyMSBhdCAwNzo0NDo0
M1BNIC0wNTAwLCBJdmFuIHdyb3RlOgo+Pj4+Pj4+PiBPbiBTYXQsIEp1bCAyNCwgMjAyMSBhdCAx
MToxOCBQTSBJdmFuIDxpdmFuQHByZXN0aWdldHJhbnNwb3J0YXRpb24uY29tPiB3cm90ZToKPj4+
Pj4+Pj4+IE9uIFNhdCwgSnVsIDI0LCAyMDIxIGF0IDc6MTcgUE0gSXZhbiA8aXZhbkBwcmVzdGln
ZXRyYW5zcG9ydGF0aW9uLmNvbT4gd3JvdGU6Cj4+Pj4+Pj4+Pj4gT24gRnJpLCBKdWwgMjMsIDIw
MjEgYXQgNzozMyBBTSBJdmFuIDxpdmFuQHByZXN0aWdldHJhbnNwb3J0YXRpb24uY29tPiB3cm90
ZToKPj4+Pj4+Pj4+Pj4gT24gRnJpLCBKdWwgMjMsIDIwMjEgYXQgNzoxMCBBTSBNaWNoYWVsIFMu
IFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+Pj4+Pj4+IE9uIEZyaSwgSnVs
IDIzLCAyMDIxIGF0IDAzOjA2OjA0QU0gLTA1MDAsIEl2YW4gd3JvdGU6Cj4+Pj4+Pj4+Pj4+Pj4g
T24gRnJpLCBKdWwgMjMsIDIwMjEgYXQgMjo1OSBBTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+Pj4+Pj4+Pj4gT24gVGh1LCBKdWwgMjIsIDIwMjEgYXQg
MTE6NTA6MTFQTSAtMDUwMCwgSXZhbiB3cm90ZToKPj4+Pj4+Pj4+Pj4+Pj4+IE9uIFRodSwgSnVs
IDIyLCAyMDIxIGF0IDExOjI1IFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdy
b3RlOgo+Pj4+Pj4+Pj4+Pj4+Pj4+IOWcqCAyMDIxLzcvMjMg5LiK5Y2IMTA6NTQsIEl2YW4g5YaZ
6YGTOgo+Pj4+Pj4+Pj4+Pj4+Pj4+PiBPbiBUaHUsIEp1bCAyMiwgMjAyMSBhdCA5OjM3IFBNIEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4g
RG9lcyBpdCB3b3JrIGlmIHlvdSB0dXJuIG9mZiBscm8gYmVmb3JlIGVuYWJsaW5nIHRoZSBmb3J3
YXJkaW5nPwo+Pj4+Pj4+Pj4+Pj4+Pj4+PiAwIHJvb3RATnVSYWlkOn4jIGV0aHRvb2wgLUsgZXRo
MCBscm8gb2ZmCj4+Pj4+Pj4+Pj4+Pj4+Pj4+IEFjdHVhbCBjaGFuZ2VzOgo+Pj4+Pj4+Pj4+Pj4+
Pj4+PiByeC1scm86IG9uIFtyZXF1ZXN0ZWQgb2ZmXQo+Pj4+Pj4+Pj4+Pj4+Pj4+PiBDb3VsZCBu
b3QgY2hhbmdlIGFueSBkZXZpY2UgZmVhdHVyZXMKPj4+Pj4+Pj4+Pj4+Pj4+PiBPaywgaXQgbG9v
a3MgbGlrZSB0aGUgZGV2aWNlIG1pc3NlcyB0aGUgVklSVElPX05FVF9GX0NUUkxfR1VFU1RfT0ZG
TE9BRFMKPj4+Pj4+Pj4+Pj4+Pj4+PiB3aGljaCBtYWtlcyBpdCBpbXBvc3NpYmxlIHRvIGNoYW5n
ZSB0aGUgTFJPIHNldHRpbmcuCj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+PiBEaWQg
eW91IHVzZSBxZW11PyBJZiB5ZXMsIHdoYXQncyB0aGUgcWVtdSB2ZXJzaW9uIHlvdSd2ZSB1c2Vk
Pwo+Pj4+Pj4+Pj4+Pj4+Pj4gVGhlc2UgYXJlIFZpcnR1YWxCb3ggbWFjaGluZXMsIHdoaWNoIEkn
dmUgYmVlbiB1c2luZyBmb3IgeWVhcnMgd2l0aAo+Pj4+Pj4+Pj4+Pj4+Pj4gbG9uZ3Rlcm0ga2Vy
bmVscyA0LjE5LCBhbmQgSSBuZXZlciBoYWQgc3VjaCBhIHByb2JsZW0uICBCdXQgbm93IHRoYXQg
SQo+Pj4+Pj4+Pj4+Pj4+Pj4gdHJpZWQgdXBncmFkaW5nIHRvIGtlcm5lbHMgNS4xMCBvciA1LjEz
IC0tIHRoZSBwYW5pY3Mgc3RhcnRlZC4gIFRoZXNlCj4+Pj4+Pj4+Pj4+Pj4+PiBhcmUganVzdCBn
ZW5lcmljIGtlcm5lbCBidWlsZHMsIGFuZCBhIG1pbmltYWxpc3RpYyB1c2Vyc3BhY2UuCj4+Pj4+
Pj4+Pj4+Pj4+IEkgd291bGQgYmUgdXNlZnVsIHRvIHNlZSB0aGUgZmVhdHVyZXMgeW91ciB2aXJ0
dWFsYm94IGluc3RhbmNlIHByb3ZpZGVzCj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+IGNh
dCAvc3lzL2NsYXNzL25ldC9ldGgwL2RldmljZS9mZWF0dXJlcwo+Pj4+Pj4+Pj4+Pj4+ICMgY2F0
IC9zeXMvY2xhc3MvbmV0L2V0aDAvZGV2aWNlL2ZlYXR1cmVzCj4+Pj4+Pj4+Pj4+Pj4gMTEwMDAx
MDExMDExMTAxMTExMTEwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MAo+Pj4+Pj4+Pj4+Pj4gSSB3YXMgYWJsZSB0byByZXByb2R1Y2UgdGhlIHdhcm5pbmcgYnV0IG5v
dCB0aGUgcGFuaWMuCj4+Pj4+Pj4+Pj4+PiBPVE9IIGlmIExSTyBzdGF5cyBvbiB3aGVuIGVuYWJs
aW5nIGZvcndhcmRpbmcgdGhhdAo+Pj4+Pj4+Pj4+Pj4gaXMgYWxyZWFkeSBhIHByb2JsZW0uIEFu
eSBjaGFuY2UgeW91IGNhbiBiaXNlY3QgdG8KPj4+Pj4+Pj4+Pj4+IGZpbmQgb3V0IHdoaWNoIGNo
YW5nZSBpbnRyb2R1Y2VkIHRoZSBwYW5pYz8KPj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4gQW55IGtl
cm5lbHMgdXAgdG8gNC4xOS4xOTggZG9uJ3QgcGFuaWMuCj4+Pj4+Pj4+Pj4+IEFueSBrZXJuZWxz
IDUuMTArIHBhbmljIGltbWVkaWF0ZWx5IHVwb24gc3RhcnRpbmcgZm9yd2FyZGluZy4KPj4+Pj4+
Pj4+Pj4gSSBoYXZlIG5vdCB0ZXN0ZWQgYW55IGtlcm5lbHMgYmV0d2VlbiA0LjE5IGFuZCA1LjEw
Lgo+Pj4+Pj4+Pj4+PiBJIGd1ZXNzIEkgY2FuIGJ1aWxkIGEgZmV3IGtlcm5lbHMgaW5iZXR3ZWVu
LCBhbmQgdHJ5IHBpbnBvaW50IHdoZXJlIGl0IHN0YXJ0cy4KPj4+Pj4+Pj4+Pj4gVGhhdCBtYXkg
dGFrZSBhIGRheSBvciBzby4gIEknbGwgZ2V0IG9uIHdpdGggaXQgbm93LCBhbmQgcmVwb3J0IG15
IGZpbmRpbmdzLgo+Pj4+Pj4+Pj4+IFNvLCBJIG5hcnJvd2VkICBpdCBkb3duOiB0aGUgcGFuaWNz
IHN0YXJ0IHdpdGgga2VybmVsIDUuMC1yYy4KPj4+Pj4+Pj4+IE1vcmUgbmFyb3dseSwgdGhlIHBy
b2JsZW0gc2VlbXMgYmUgY29taW5nIGZyb20gY29tbWl0Cj4+Pj4+Pj4+PiBhMDJlODk2NGVhZjky
NzFhOGE1ZmNjMGM1NWJkMTNmOTMzYmFmYzU2Lgo+Pj4+Pj4+Pj4gSnVzdCB0byB0ZXN0IG15IHN1
c3BpY2lvbiwgSSBkZWxldGVkIGEgZmV3IGxpbmVzIGZyb20gdGhhdCBjb2RlLAo+Pj4+Pj4+Pj4g
YW5kIHRoZSBwYW5pYyB3ZW50IGF3YXkuICBIb3BlIHRoYXQgaGVscHMgeW91IGd1eXMgZmlndXJl
IG91dAo+Pj4+Pj4+Pj4gd2hhdCB0aGUgcHJvYmxlbSBtaWdodCBiZS4KPj4+Pj4+PiBXZWxsIGl0
IGRpc2FibGVzIExSTyBidXQgd2Uga25ldyB0aGlzIDooIEknZCBoZWxwIGlmIHdlIGtuZXcKPj4+
Pj4+PiB3aGVyZSBkb2VzIGl0IHBhbmljLCBhbGwgd2Ugc2VlIGl0IHRoZSB3YXJuaW5nIHdoaWNo
IGlzCj4+Pj4+Pj4gcmVsYXRlZCBmb3Igc3VyZSBidXQgbm90IHRoZSBpbW1lZGlhdGUgcm9vdGNh
dXNlIC4uLgo+Pj4+Pj4+Cj4+Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMK
Pj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4+Pj4+Pj4gQEAgLTI5
NzgsMTEgKzI5NzgsNiBAQAo+Pj4+Pj4+Pj4gICAgfQo+Pj4+Pj4+Pj4gICAgaWYgKHZpcnRpb19o
YXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfQ1NVTSkpCj4+Pj4+Pj4+PiAgICAg
ICBkZXYtPmZlYXR1cmVzIHw9IE5FVElGX0ZfUlhDU1VNOwo+Pj4+Pj4+Pj4gLSBpZiAodmlydGlv
X2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9HVUVTVF9UU080KSB8fAo+Pj4+Pj4+Pj4g
LSAgICB2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX0dVRVNUX1RTTzYpKQo+
Pj4+Pj4+Pj4gLSAgICBkZXYtPmZlYXR1cmVzIHw9IE5FVElGX0ZfTFJPOwo+Pj4+Pj4+Pj4gLSBp
ZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9DVFJMX0dVRVNUX09GRkxP
QURTKSkKPj4+Pj4+Pj4+IC0gICAgZGV2LT5od19mZWF0dXJlcyB8PSBORVRJRl9GX0xSTzsKPj4+
Pj4+Pj4+Cj4+Pj4+Pj4+PiAgICBkZXYtPnZsYW5fZmVhdHVyZXMgPSBkZXYtPmZlYXR1cmVzOwo+
Pj4+Pj4+PiBKdXN0IEZZSSwgR29vZ2xlIHR1cm5lZCB1cCB0d28gc2ltaWxhciBidWcgcmVwb3N0
cy4uLgo+Pj4+Pj4+PiBBcHIgMTQsIDIwMjAgLS0gaHR0cHM6Ly9naXRodWIuY29tL2NvbnRhaW5l
cnMvcG9kbWFuL2lzc3Vlcy81ODE1Cj4+Pj4+Pj4+IE9jdCAwOS4gMjAyMCAtLSBodHRwczovL2J1
Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIwOTU5Mwo+Pj4+Pj4+Pgo+Pj4+Pj4+
PiBJcyB0aGVyZSBhbnkgc2Vuc2libGUgdGhpbmcgSSBjb3VsZCBkbywgdGVtcG9yYXJpbHksIHVu
dGlsIHRoaXMKPj4+Pj4+Pj4gcHJvYmxlbSBpcyBzb3J0ZWQgb3V0Pwo+Pj4+Pj4+PiBPciBhbSBJ
IHNpbXBseSBzdHVjayB0byBrZXJuZWxzIDQuMTkgb24gdGhlc2UgbWFjaGluZXMgZm9yIG5vdz8K
Pj4+Pj4+Pgo+Pj4+Pj4+IFNvbWV0aGluZyBsaWtlIHRoaXMgSSBndWVzczoKPj4+Pj4+Pgo+Pj4+
Pj4+Cj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4+Pj4+IGluZGV4IDhhNThhMmYwMTNhZi4uY2M1OTgyMTkz
YTQwIDEwMDY0NAo+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4+Pj4+
ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4+Pj4+IEBAIC0zMDYzLDYgKzMwNjMs
OCBAQCBzdGF0aWMgaW50IHZpcnRuZXRfdmFsaWRhdGUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZk
ZXYpCj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgIF9fdmlydGlvX2NsZWFyX2JpdCh2
ZGV2LCBWSVJUSU9fTkVUX0ZfTVRVKTsKPj4+Pj4+PiAgICAgICAgICB9Cj4+Pj4+Pj4KPj4+Pj4+
PiArICAgICAgIF9fdmlydGlvX2NsZWFyX2JpdCh2ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNP
NCk7Cj4+Pj4+Pj4gKyAgICAgICBfX3ZpcnRpb19jbGVhcl9iaXQodmRldiwgVklSVElPX05FVF9G
X0dVRVNUX1RTTzYpOwo+Pj4+Pj4+ICAgICAgICAgIHJldHVybiAwOwo+Pj4+Pj4+ICAgfQo+Pj4+
Pj4gV2hlbiBJIGFwcGx5IHlvdXIgcGF0Y2gsIHRoZW4gSSBzZWUgZHJhc3RpYyAobW9yZSB0aGFu
IGhhbGYpCj4+Pj4+PiByZWR1Y3Rpb25zIGluIHNwZWVkLiAoY29uZmlybWVkIHdpdGggaXBlcmYp
Lgo+Pj4+Pj4KPj4+Pj4+IEJ1dCBpZiBpbnN0ZWFkIEkganVzdCByZW1vdmUgYSBmZXcgbGluZXMg
ZnJvbSBjb21taXQKPj4+Pj4+IGEwMmU4OTY0ZWFmOTI3MWE4YTVmY2MwYzU1YmQxM2Y5MzNiYWZj
NTYKPj4+Pj4+IGFzIGluIG15IGVhcmxpZXIgcG9zdCwgdGhlbiBJJ20gYmFjayB0byBmdWxsIHNw
ZWVkCj4+Pj4+Pgo+Pj4+Pj4gSSB1bmRlcnN0YW5kIHRoYXQgdGhpcyBpcyBqdXN0IHRlbXBvcmFy
eSB3b3JrYXJvdW5kLCB1bnRpbCB3ZSBmaWd1cmUgdGhpcyBvdXQuCj4+Pj4+Cj4+Pj4+IE9oIHdl
aXJkLiBTbyBpdCdzIG5vdCBhYm91dCBnZXR0aW5nIHNvbWUgd2VpcmQgTFJPIHBhY2tldC4gV2Ug
d2lsbCBnZXQgaXQgd2l0aAo+Pj4+PiBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNCBhbnl3YXkuIEl0
J3MgYWJvdXQgdGhlIExSTyBmbGFnIGJlaW5nIHNldCBpbgo+Pj4+PiBmZWF0dXJlcy4KPj4+Pj4K
Pj4+Pj4gSG93IGFib3V0IHRoaXMgdGhlbj8gSnVzdCBwcmV0ZW5kIHRvIExpbnV4IHRoYXQgd2Ug
ZGlzYWJsZWQgTFJPLgo+Pj4+Pgo+Pj4+Pgo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+Pj4+IGluZGV4IDhhNThh
MmYwMTNhZi4uOGU3ZTRjZWExNzZiIDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMKPj4+Pj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+Pj4+IEBAIC0y
NjUxLDggKzI2NTEsOSBAQCBzdGF0aWMgaW50IHZpcnRuZXRfc2V0X2ZlYXR1cmVzKHN0cnVjdCBu
ZXRfZGV2aWNlICpkZXYsCj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IH5HVUVTVF9PRkZMT0FEX0xST19NQVNLOwo+Pj4+Pgo+Pj4+PiAgICAgICAgICAgICAgICAgIGVy
ciA9IHZpcnRuZXRfc2V0X2d1ZXN0X29mZmxvYWRzKHZpLCBvZmZsb2Fkcyk7Cj4+Pj4+IC0gICAg
ICAgICAgICAgICBpZiAoZXJyKQo+Pj4+PiAtICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4g
ZXJyOwo+Pj4+PiArICAgICAgICAgICAgICAgV0FSTl9PTihlcnIpOwo+Pj4+PiArICAgICAgICAg
ICAgICAgLy9pZiAoZXJyKQo+Pj4+PiArICAgICAgICAgICAgICAgLy8gICAgICByZXR1cm4gZXJy
Owo+Pj4+PiAgICAgICAgICAgICAgICAgIHZpLT5ndWVzdF9vZmZsb2FkcyA9IG9mZmxvYWRzOwo+
Pj4+PiAgICAgICAgICB9Cj4+Pj4gTm8uIFdpdGggdGhpcyBhcHBsaWVkLCB0aGUgcHJvYmxlbSBw
ZXJzaXN0czoKPj4+Pgo+Pj4+ICMgZWNobyAiMSIgPiAvcHJvYy9zeXMvbmV0L2lwdjQvaXBfZm9y
d2FyZAo+Pj4+Cj4+Pj4ga2VybmVsOiAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0t
LS0KPj4+PiBrZXJuZWw6IG5ldGRldmljZTogZXRoMDogZmFpbGVkIHRvIGRpc2FibGUgTFJPIQo+
Pj4+IGtlcm5lbDogV0FSTklORzogQ1BVOiAwIFBJRDogNDUyIGF0IG5ldC9jb3JlL2Rldi5jOjE3
NjgKPj4+PiBkZXZfZGlzYWJsZV9scm8rMHgxMDgvMHgxNTAKPj4+PiBrZXJuZWw6IE1vZHVsZXMg
bGlua2VkIGluOiBzZyBubHNfaXNvODg1OV8xIG5sc19jcDQzNyB2ZmF0IGZhdAo+Pj4+IGhpZF9n
ZW5lcmljIHVzYmhpZCBoaWQgdmlydGlvX25ldCBuZXRfZmFpbG92ZXIgZmFpbG92ZXIgYWVzbmlf
aW50ZWwKPj4+PiBsaWJhZXMgY3J5cHRvX3NpbWQgb2hjaV9wY2kgYWhjaSBsaWJhaGNpIGNyeXB0
ZCByYXBsIGVoY2lfcGNpIG9oY2lfaGNkCj4+Pj4gZWhjaV9oY2QgdXNiY29yZSB1c2JfY29tbW9u
IGxpYmF0YSBldmRldiBscGNfaWNoIG1mZF9jb3JlIHJuZ19jb3JlCj4+Pj4gaTJjX3BpaXg0IGky
Y19jb3JlIHZpcnRpb19wY2kgdmlydGlvX3BjaV9tb2Rlcm5fZGV2IHZpcnRpb19yaW5nIHZpcnRp
bwo+Pj4+IHJ0Y19jbW9zIGF0a2JkIGxpYnBzMiBpODA0MiBzZXJpbyBiYXR0ZXJ5IGFjIGJ1dHRv
biBsb29wIHVuaXgKPj4+PiBrZXJuZWw6IENQVTogMCBQSUQ6IDQ1MiBDb21tOiBiYXNoIE5vdCB0
YWludGVkIDUuMTMuNy1nbnUuMS1OdU1pbmkgIzEKPj4+PiBrZXJuZWw6IEhhcmR3YXJlIG5hbWU6
IGlubm90ZWsgR21iSCBWaXJ0dWFsQm94L1ZpcnR1YWxCb3gsIEJJT1MKPj4+PiBWaXJ0dWFsQm94
IDEyLzAxLzIwMDYKPj4+PiBrZXJuZWw6IFJJUDogMDAxMDpkZXZfZGlzYWJsZV9scm8rMHgxMDgv
MHgxNTAKPj4+IEFnYWluIHRoZSB3YXJuaW5nIGlzbid0IGEgYmlnIGRlYWwuIEkgYWdyZWUgd2Ug
c2hvdWxkIGFkZHJlc3MgLSBKYXNvbgo+Pj4gYW55IHVwZGF0ZT8KPj4gSSBzdGlsbCB0aGluayB1
c2luZyBORVRJRl9GX0xSTyBtaWdodCBub3QgYmUgY29ycmVjdC4gU2luY2Ugd2UncmUKPj4gYmFz
aWNhbGx5IHJlY2VpdmluZyBHU08gcGFja2V0cy4KPj4KPj4gQW5kIGl0IG1pZ2h0IGNhdXNlIGEg
bG90IG9mIGlzc3VlcyBpZiB0aGUgZGV2aWNlIGRvZXNuJ3QgaGF2ZQo+PiBWSVJUSU9fTkVUX0Zf
Q1RSTF9HVUVTVF9PRkZMT0FEUy4KPj4KPj4gSSBzZWUgdHdvIHBvc3NpYmxlIGZpeGVzOgo+Pgo+
PiAxKSB1c2luZyBORVRJRl9GX0dST19IVyBpbnN0ZWFkICh0aGUgcGF0Y2ggaXMgYXR0YWNoZWQp
Cj4gSXQncyB1bmZvcnR1bmF0ZSB5b3UgZGlkbid0IGlubGluZS4gQW55d2F5Lgo+IEl2YW4gY291
bGQgeW91IHRlc3QgdGhlIHBhdGNoIGFuZCByZXBvcnQ/Cj4KPj4gb3IKPiBIbW0uIEkgYW0gbm90
IHN1cmUgd2UgYWx3YXlzIHByZXNlcnZlIHRoZSBHUk9fSFcgcmVxdWlyZW1lbnQgdGhhdAo+IHBh
Y2tldHMgY2FuIGJlIHJlLXNlZ21lbnRlZCB0byByZWNvbnN0cnVjdCB0aGUgb3JpZ2luYWwgcGFj
a2V0IHN0cmVhbS4KPiBEbyBhbGwgYmFja2VuZHMgZ3VhcmFudGVlIHRoaXM/CgoKSSB0aGluayB3
ZSBjYW4ndC4KCgo+IENvdWxkIHlvdSBleHBsYWluIHdoeT8KCgpPciB3ZSBwcm9iYWJseSBuZWVk
IGFub3RoZXIgbmV3IG5ldGRldiBmZWF0dXJlIGxpa2UgcngtZ3NvPwoKCj4KPgo+Cj4+IDIpIHNl
dCBORVRJRl9GX0xSTyBvbmx5IGlmIHRoZSBkZXZpY2UgaGFzIENUUkxfR1VFU1RfT0ZGTE9BRFMK
Pj4KPj4gVGhhbmtzCj4KPiBUaGlzIG9uZSB3b3VsZCBzbG93IGd1ZXN0cyBvbiBvbGQgaG9zdHMg
ZG93biBzaWduaWZpY2FudGx5LgoKCkFjdHVhbGx5LCBpdCdzIG5vdCB0aGlzIHByb3Bvc2FsIGJ1
dCBzZWUgYmVsb3cuCgoKPgo+IEkgYW0gbm90IHN1cmUgd2h5IHRoaXMgZGlkbid0IHRyaWdnZXIg
cHJldmlvdXNseQoKCkl0IGxvb2tzIHRvIG1lIGl0IHdhcyBjYXVzZWQgYnkgYTAyZTg5NjRlYWY5
MjcxYThhNWZjYzBjNTViZDEzZjkzM2JhZmM1NiAKKCJ2aXJ0aW8tbmV0OiBldGh0b29sIGNvbmZp
Z3VyYWJsZSBMUk8iKS4KCkJlZm9yZSB0aGlzIGNvbW1pdCB3ZSB3b24ndCBldmVuIGFkdmVydGlz
ZSBORVRJRl9GX0xSTywgc28gCmRldl9kaXNhYmxlX2xybygpIHdvbid0IHdhcm4uCgpBZnRlciB0
aGlzIGNvbW1pdCwgd2UgYWR2ZXJ0aXNlIExSTyBhbmQgZGV2X2Rpc2FibGVfbHJvKCkgd2lsbCB0
cnkgdG8gCmRpc2FibGUgYWxsIGd1ZXN0IG9mZmxvYWRzIHdoaWNoIHdpbGw6CgoxKSBzbG93IHRo
ZSB0cmFmZmljCgphbmQKCjIpIHdhcm4gaWYgImxybyIgY2FuJ3QgYmUgZGlzYWJsZWQgb24gdGhl
IGRldmljZSB3aXRob3V0IGN0cmwgZ3Vlc3QgCm9mZmxvYWRzIChlLmcgdGhlIHZpcnR1YWxib3gg
aG9zdCkKClRoYW5rcwoKCj4gYnR3IC0KPiB3ZSB1c2VkIG5vdCB0byBoYXZlIENUUkxfR1VFU1Rf
T0ZGTE9BRFMgYWZ0ZXIgYWxsLgo+Cj4KPgo+Pj4gQnV0IHRoZSBtYWluIGlzc3VlIGlzIHlvdSBs
b3NlIGNvbm5lY3Rpdml0eS4gVGhhdCBzdGlsbAo+Pj4gcGVyc2lzdHMgd2l0aCB0aGlzPyBDYW4n
dCB5b3UgZ2V0IGEgc2VyaWFsIGNvbm5lY3Rpb24KPj4+IG91dD8gSSBrbm93IHFlbXUgRGlkIHRo
ZSBrZXJuZWwgb29wcyBhZnRlcndhcmRzPwo+Pj4KPj4+IC0tCj4+PiBNU1QKPj4+Cj4KPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u

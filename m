Return-Path: <SRS0=FRCo=EK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0103DC55179
	for <virtualization@archiver.kernel.org>; Wed,  4 Nov 2020 09:33:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FFF6221F8
	for <virtualization@archiver.kernel.org>; Wed,  4 Nov 2020 09:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gybab4cN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFF6221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CB55686BBE;
	Wed,  4 Nov 2020 09:33:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5VND9JsX6diG; Wed,  4 Nov 2020 09:33:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 02A2786B94;
	Wed,  4 Nov 2020 09:33:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA548C0889;
	Wed,  4 Nov 2020 09:33:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 957C6C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 09:33:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5FC4F874D8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 09:33:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lly19UPxUCN3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 09:33:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1226F874D5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 09:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604482423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S67mblvp8BDDbDS1GLfHleJupRJCu9AfMSH9PH8i7Jg=;
 b=Gybab4cNh+GmsIr7HARA67O3RgU5pgb4coY7m5TxZbFL154G8Vz1ZPx8WI1nGQz4pbTMim
 jXNgR0wNR8S7GoVZ9o+fley2r1I0Lf57CkIabc3gLr3ZUDr0kZyz0t6n5E79FBLu87hTHK
 yPiB1FzbtASO4TT83FzFlT1uXbHNjq8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-YhEYob97PFCpXk4WdqYWQw-1; Wed, 04 Nov 2020 04:33:41 -0500
X-MC-Unique: YhEYob97PFCpXk4WdqYWQw-1
Received: by mail-wr1-f69.google.com with SMTP id u1so6769166wri.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 Nov 2020 01:33:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=S67mblvp8BDDbDS1GLfHleJupRJCu9AfMSH9PH8i7Jg=;
 b=sMnTJwVlEkkUO+FEWDe8V3aBTwwrbAVaIHwdqbyjTrrkHRAmgp8dA/1TQlDkeABQDJ
 d5aqiotHhC2OtZvZedCpq93hOuyR6L1Jz8SrNVIfysKw478yewQV06OCt4xCmmyH68E5
 yN9fLtFvGNjj60eRcgnPXknhowKkk/ykL7VLlrgSiKk3iCvKo2B0QFieciNFY09SBYcb
 2LVgrJTS/Mg3kXL7xy28MsMf6VELbPxXab94HTpM98zLlSkuBeZV598J51xGhRlcbN9a
 Q9Ge2LV23cp/H0SXFRg1xwI4BTFj7p0Ov6w71KXZHsaMa2x18kD38CzgTnqWxCsRAr3A
 l1zg==
X-Gm-Message-State: AOAM530bgIz/8GQaZfBFHUhJxOGOuORZvP95W5KzszMlyRkTJgpyuQzB
 zQuQU00M47wBWUjf4kvsFYb5jC/mElxa9GpXXIs5AKe2hGPTD0bJLkNV+boMH3AmeJOA2WjyBuF
 y4BGb7IgyFBRLU+GjU3NwGRBAIZpnHN8FY+I0/+hHYQ==
X-Received: by 2002:adf:9b95:: with SMTP id d21mr5997462wrc.335.1604482420758; 
 Wed, 04 Nov 2020 01:33:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLnqhRSqhTc7S9kSWg6N6gWOKIWH0uIfnUrQUkHUqik23WMt5c8lft5ls5BYqlcfZ+saqWZQ==
X-Received: by 2002:adf:9b95:: with SMTP id d21mr5997433wrc.335.1604482420530; 
 Wed, 04 Nov 2020 01:33:40 -0800 (PST)
Received: from steredhat (host-79-22-200-33.retail.telecomitalia.it.
 [79.22.200.33])
 by smtp.gmail.com with ESMTPSA id q2sm1690836wrw.40.2020.11.04.01.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 01:33:39 -0800 (PST)
Date: Wed, 4 Nov 2020 10:33:37 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] vhost/vsock: add IOTLB API support
Message-ID: <20201104093337.ge3qtlfhkjjkx4ax@steredhat>
References: <20201029174351.134173-1-sgarzare@redhat.com>
 <751cc074-ae68-72c8-71de-a42458058761@redhat.com>
 <20201030105422.ju2aj2bmwsckdufh@steredhat>
 <278f4732-e561-2b4f-03ee-b26455760b01@redhat.com>
 <20201102171104.eiovmkj23fle5ioj@steredhat>
 <8648a2e3-1052-3b5b-11ce-87628ac8dd33@redhat.com>
 <20201103194613.GK20600@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20201103194613.GK20600@xz-x1>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>
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

T24gVHVlLCBOb3YgMDMsIDIwMjAgYXQgMDI6NDY6MTNQTSAtMDUwMCwgUGV0ZXIgWHUgd3JvdGU6
Cj5PbiBUdWUsIE5vdiAwMywgMjAyMCBhdCAwNTowNDoyM1BNICswODAwLCBKYXNvbiBXYW5nIHdy
b3RlOgo+Pgo+PiBPbiAyMDIwLzExLzMg5LiK5Y2IMToxMSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdy
b3RlOgo+PiA+IE9uIEZyaSwgT2N0IDMwLCAyMDIwIGF0IDA3OjQ0OjQzUE0gKzA4MDAsIEphc29u
IFdhbmcgd3JvdGU6Cj4+ID4gPgo+PiA+ID4gT24gMjAyMC8xMC8zMCDkuIvljYg2OjU0LCBTdGVm
YW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4+ID4gPiA+IE9uIEZyaSwgT2N0IDMwLCAyMDIwIGF0IDA2
OjAyOjE4UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+ID4gPiA+ID4KPj4gPiA+ID4gPiBP
biAyMDIwLzEwLzMwIOS4iuWNiDE6NDMsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPj4gPiA+
ID4gPiA+IFRoaXMgcGF0Y2ggZW5hYmxlcyB0aGUgSU9UTEIgQVBJIHN1cHBvcnQgZm9yIHZob3N0
LXZzb2NrIGRldmljZXMsCj4+ID4gPiA+ID4gPiBhbGxvd2luZyB0aGUgdXNlcnNwYWNlIHRvIGVt
dWxhdGUgYW4gSU9NTVUgZm9yIHRoZSBndWVzdC4KPj4gPiA+ID4gPiA+Cj4+ID4gPiA+ID4gPiBU
aGVzZSBjaGFuZ2VzIHdlcmUgbWFkZSBmb2xsb3dpbmcgdmhvc3QtbmV0LCBpbiBkZXRhaWxzIHRo
aXMgcGF0Y2g6Cj4+ID4gPiA+ID4gPiAtIGV4cG9zZXMgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JN
IGZlYXR1cmUgYW5kIGluaXRzIHRoZSBpb3RsYgo+PiA+ID4gPiA+ID4gwqAgZGV2aWNlIGlmIHRo
ZSBmZWF0dXJlIGlzIGFja2VkCj4+ID4gPiA+ID4gPiAtIGltcGxlbWVudHMgVkhPU1RfR0VUX0JB
Q0tFTkRfRkVBVFVSRVMgYW5kCj4+ID4gPiA+ID4gPiDCoCBWSE9TVF9TRVRfQkFDS0VORF9GRUFU
VVJFUyBpb2N0bHMKPj4gPiA+ID4gPiA+IC0gY2FsbHMgdnFfbWV0YV9wcmVmZXRjaCgpIGJlZm9y
ZSB2cSBwcm9jZXNzaW5nIHRvIHByZWZldGNoIHZxCj4+ID4gPiA+ID4gPiDCoCBtZXRhZGF0YSBh
ZGRyZXNzIGluIElPVExCCj4+ID4gPiA+ID4gPiAtIHByb3ZpZGVzIC5yZWFkX2l0ZXIsIC53cml0
ZV9pdGVyLCBhbmQgLnBvbGwgY2FsbGJhY2tzIGZvciB0aGUKPj4gPiA+ID4gPiA+IMKgIGNoYXJk
ZXY7IHRoZXkgYXJlIHVzZWQgYnkgdGhlIHVzZXJzcGFjZSB0byBleGNoYW5nZSBJT1RMQiBtZXNz
YWdlcwo+PiA+ID4gPiA+ID4KPj4gPiA+ID4gPiA+IFRoaXMgcGF0Y2ggd2FzIHRlc3RlZCB3aXRo
IFFFTVUgYW5kIGEgcGF0Y2ggYXBwbGllZCBbMV0gdG8gZml4IGEKPj4gPiA+ID4gPiA+IHNpbXBs
ZSBpc3N1ZToKPj4gPiA+ID4gPiA+IMKgwqDCoCAkIHFlbXUgLU0gcTM1LGFjY2VsPWt2bSxrZXJu
ZWwtaXJxY2hpcD1zcGxpdCBcCj4+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtZHJp
dmUgZmlsZT1mZWRvcmEucWNvdzIsZm9ybWF0PXFjb3cyLGlmPXZpcnRpbyBcCj4+ID4gPiA+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtZGV2aWNlIGludGVsLWlvbW11LGludHJlbWFwPW9uIFwK
Pj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIC1kZXZpY2Ugdmhvc3QtdnNvY2stcGNp
LGd1ZXN0LWNpZD0zLGlvbW11X3BsYXRmb3JtPW9uCj4+ID4gPiA+ID4KPj4gPiA+ID4gPgo+PiA+
ID4gPiA+IFBhdGNoIGxvb2tzIGdvb2QsIGJ1dCBhIHF1ZXN0aW9uOgo+PiA+ID4gPiA+Cj4+ID4g
PiA+ID4gSXQgbG9va3MgdG8gbWUgeW91IGRvbid0IGVuYWJsZSBBVFMgd2hpY2ggbWVhbnMgdmhv
c3Qgd29uJ3QKPj4gPiA+ID4gPiBnZXQgYW55IGludmFsaWRhdGlvbiByZXF1ZXN0IG9yIGRpZCBJ
IG1pc3MgYW55dGhpbmc/Cj4+ID4gPiA+ID4KPj4gPiA+ID4KPj4gPiA+ID4gWW91J3JlIHJpZ2h0
LCBJIGRpZG4ndCBzZWUgaW52YWxpZGF0aW9uIHJlcXVlc3RzLCBvbmx5IG1pc3MgYW5kCj4+ID4g
PiA+IHVwZGF0ZXMuCj4+ID4gPiA+IE5vdyBJIGhhdmUgdHJpZWQgdG8gZW5hYmxlICdhdHMnIGFu
ZCAnZGV2aWNlLWlvdGxiJyBidXQgSSBzdGlsbAo+PiA+ID4gPiBkb24ndCBzZWUgYW55IGludmFs
aWRhdGlvbi4KPj4gPiA+ID4KPj4gPiA+ID4gSG93IGNhbiBJIHRlc3QgaXQ/IChTb3JyeSBidXQg
SSBkb24ndCBoYXZlIG11Y2ggZXhwZXJpZW5jZSB5ZXQKPj4gPiA+ID4gd2l0aCB2SU9NTVUpCj4+
ID4gPgo+PiA+ID4KPj4gPiA+IEkgZ3Vlc3MgaXQncyBiZWNhdXNlIHRoZSBiYXRjaGVkIHVubWFw
LiBNYXliZSB5b3UgY2FuIHRyeSB0byB1c2UKPj4gPiA+ICJpbnRlbF9pb21tdT1zdHJpY3QiIGlu
IGd1ZXN0IGtlcm5lbCBjb21tYW5kIGxpbmUgdG8gc2VlIGlmIGl0Cj4+ID4gPiB3b3Jrcy4KPj4g
PiA+Cj4+ID4gPiBCdHcsIG1ha2Ugc3VyZSB0aGUgcWVtdSBjb250YWlucyB0aGUgcGF0Y2ggWzFd
LiBPdGhlcndpc2UgQVRTIHdvbid0Cj4+ID4gPiBiZSBlbmFibGVkIGZvciByZWNlbnQgTGludXgg
S2VybmVsIGluIHRoZSBndWVzdC4KPj4gPgo+PiA+IFRoZSBwcm9ibGVtIHdhcyBteSBrZXJuZWws
IGl0IHdhcyBidWlsdCB3aXRoIGEgdGlueSBjb25maWd1cmF0aW9uLgo+PiA+IFVzaW5nIGZlZG9y
YSBzdG9jayBrZXJuZWwgSSBjYW4gc2VlIHRoZSAnaW52YWxpZGF0ZScgcmVxdWVzdHMsIGJ1dCBJ
Cj4+ID4gYWxzbyBoYWQgdGhlIGZvbGxvd2luZyBpc3N1ZXMuCj4+ID4KPj4gPiBEbyB0aGV5IG1h
a2UgeW91IHJpbmcgYW55IGJlbGxzPwo+PiA+Cj4+ID4gJCAuL3FlbXUgLW0gNEcgLXNtcCA0IC1N
IHEzNSxhY2NlbD1rdm0sa2VybmVsLWlycWNoaXA9c3BsaXQgXAo+PiA+IMKgwqDCoCAtZHJpdmUg
ZmlsZT1mZWRvcmEucWNvdzIsZm9ybWF0PXFjb3cyLGlmPXZpcnRpbyBcCj4+ID4gwqDCoMKgIC1k
ZXZpY2UgaW50ZWwtaW9tbXUsaW50cmVtYXA9b24sZGV2aWNlLWlvdGxiPW9uIFwKPj4gPiDCoMKg
wqAgLWRldmljZSB2aG9zdC12c29jay1wY2ksZ3Vlc3QtY2lkPTYsaW9tbXVfcGxhdGZvcm09b24s
YXRzPW9uLGlkPXYxCj4+ID4KPj4gPiDCoMKgwqAgcWVtdS1zeXN0ZW0teDg2XzY0OiB2dGRfaW92
YV90b19zbHB0ZTogZGV0ZWN0ZWQgSU9WQSBvdmVyZmxvdyDCoMKgwqAKPj4gPiAoaW92YT0weDFk
NDAwMDAwMzBjMCkKPj4KPj4KPj4gSXQncyBhIGhpbnQgdGhhdCBJT1ZBIGV4Y2VlZHMgdGhlIEFX
LiBJdCBtaWdodCBiZSB3b3J0aCB0byBjaGVjayB3aGV0aGVyIHRoZQo+PiBtaXNzZWQgSU9WQSBy
ZXBvcnRlZCBmcm9tIElPVExCIGlzIGxlZ2FsLgo+Cj5ZZWFoLiAgQnkgZGVmYXVsdCB0aGUgUUVN
VSB2SU9NTVUgc2hvdWxkIG9ubHkgc3VwcG9ydCAzOWJpdHMgd2lkdGggZm9yIGd1ZXN0Cj5pb3Zh
IGFkZHJlc3Mgc3BhY2UuICBUbyBleHRlbmQgaXQsIHdlIGNhbiB1c2U6Cj4KPiAgLWRldmljZSBp
bnRlbC1pb21tdSxhdy1iaXRzPTQ4Cj4KPlNvIHdlJ2xsIGVuYWJsZSA0LWxldmVsIGlvbW11IHBn
dGFibGUuCj4KPkhlcmUgdGhlIGlvdmEgaXMgb2J2aW91cyBsb25nZXIgdGhhbiB0aGlzLCBzbyBp
dCdsbCBiZSBpbnRlcmVzdGluZyB0byBrbm93IHdoeQo+dGhhdCBpb3ZhIGlzIGFsbG9jYXRlZCBp
biB0aGUgZ3Vlc3QgZHJpdmVyIHNpbmNlIHRoZSBkcml2ZXIgc2hvdWxkIGtub3cgc29tZWhvdwo+
dGhhdCB0aGlzIGlvdmEgaXMgYmV5b25kIHdoYXQncyBzdXBwb3J0ZWQgKGd1ZXN0IGlvbW11IGRy
aXZlciBzaG91bGQgYmUgYWJsZSB0bwo+cHJvYmUgdmlvbW11IGNhcGFiaWxpdHkgb24gdGhpcyB3
aWR0aCBpbmZvcm1hdGlvbiB0b28pLgo+CgpQZXRlciwgSmFzb24sIHRoYW5rcyBmb3IgdGhlIGhp
bnRzIQoKSSdsbCB0cnkgdG8gdW5kZXJzdGFuZCB3aGF0IGlzIGdvaW5nIG9uIGluIHRoZSBndWVz
dCBkcml2ZXIuCgpTdGVmYW5vCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

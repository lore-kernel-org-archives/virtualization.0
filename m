Return-Path: <SRS0=E6mM=JG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F98C433B4
	for <virtualization@archiver.kernel.org>; Fri,  9 Apr 2021 16:05:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D7FE610FB
	for <virtualization@archiver.kernel.org>; Fri,  9 Apr 2021 16:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7FE610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE5F3606E6;
	Fri,  9 Apr 2021 16:05:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id teGnyB6bCziF; Fri,  9 Apr 2021 16:05:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77E5560756;
	Fri,  9 Apr 2021 16:05:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D60DC000C;
	Fri,  9 Apr 2021 16:05:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFE2BC000A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 16:05:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 918E483B71
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 16:05:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PgDj70v08isN
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 16:05:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7D91183640
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 16:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617984306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4pXIEp6QTLcUhBgPHNk8mFiyRY9cbts1+UUx37kdPtE=;
 b=OPncfzMtK7X7c8mydYyrCcXE9wLxGZ0+nBY1SgyL2vPGZc/zvs+CNIoj6ZMZYS0tnWMFKh
 ljiv4KcCl+03oWOS5gR84Cc5syvUzid5OiLow8GDcUKdSxuUqpgCsfj6OK2p6dtyUpnpRo
 YgFMRNGYe7A90FUTF3xnxTkapm64Fgc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-YHSuHse8Ni63EB8OuYCe2Q-1; Fri, 09 Apr 2021 12:05:04 -0400
X-MC-Unique: YHSuHse8Ni63EB8OuYCe2Q-1
Received: by mail-wr1-f70.google.com with SMTP id z7so2496631wrs.17
 for <virtualization@lists.linux-foundation.org>;
 Fri, 09 Apr 2021 09:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=4pXIEp6QTLcUhBgPHNk8mFiyRY9cbts1+UUx37kdPtE=;
 b=ZHHGKgtqzttytKlgN+sGUm8oYuA7Ol66ZVZXJv4BnC92S345jLj9kbHAajDmm5HMWz
 6TiBlpiPD6G2GsRUUj5c0rdkPSQkmPgla/dQV85wapCjSA9/ZI/x0mXT89oEqAPzkk+Y
 i98X4Cy2GdK7AGW+HQWywt2edH4GLbAbEPRF3p/1RdLVu7tejNp/z61d/n5lgVMKUEbL
 u1ZBsPvzN7dXAXde0FoLw0Z7Z/41C9QXX9bDHq0QyHuTJlTpdR56vQjqBSqkQtt5XnQE
 P9UljXCk9tPHHLf6YhLIdehJ27T9+QdUnG+mfdFMVkb4s4gvst+jD60ypu/1F/wvuG3k
 1EkQ==
X-Gm-Message-State: AOAM532VJWTQlqbjconLbmLMMXloEOWgiwRSntsNG2/rDp3jn7tQr7Bv
 0OrFXto7vtzudmoBIUTCHvV8nfTHG8Y+bFWw4dEQBBpPbMIKLRdwYuw/3T5au8BKE43AjcZb/F6
 lBUYv5ECYl8qK1QCpxOpVf8eMT8vVTTbI4qMqsu9Mcg==
X-Received: by 2002:adf:f687:: with SMTP id v7mr18058254wrp.272.1617984302810; 
 Fri, 09 Apr 2021 09:05:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFnEQujInujNsmq1ttaJLy8i5/5gCEX4rK7k88zoLDZoku4V60sy9jkn30tLwp4cy2O6152g==
X-Received: by 2002:adf:f687:: with SMTP id v7mr18058237wrp.272.1617984302656; 
 Fri, 09 Apr 2021 09:05:02 -0700 (PDT)
Received: from redhat.com ([2a10:800e:f0d3:0:b69b:9fb8:3947:5636])
 by smtp.gmail.com with ESMTPSA id q18sm2916754wrs.25.2021.04.09.09.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Apr 2021 09:05:01 -0700 (PDT)
Date: Fri, 9 Apr 2021 12:04:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH] vdpa: mandate 1.0 device
Message-ID: <20210409115343-mutt-send-email-mst@kernel.org>
References: <20210408082648.20145-1-jasowang@redhat.com>
 <20210408115834-mutt-send-email-mst@kernel.org>
 <a6a4ab68-c958-7266-c67c-142960222b67@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a6a4ab68-c958-7266-c67c-142960222b67@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: elic@nvidia.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

T24gRnJpLCBBcHIgMDksIDIwMjEgYXQgMTI6NDc6NTVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS80Lzgg5LiL5Y2IMTE6NTksIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnp
gZM6Cj4gPiBPbiBUaHUsIEFwciAwOCwgMjAyMSBhdCAwNDoyNjo0OFBNICswODAwLCBKYXNvbiBX
YW5nIHdyb3RlOgo+ID4gPiBUaGlzIHBhdGNoIG1hbmRhdGVzIDEuMCBmb3IgdkRQQSBkZXZpY2Vz
LiBUaGUgZ29hbCBpcyB0byBoYXZlIHRoZQo+ID4gPiBzZW1hbnRpYyBvZiBub3JtYXRpdmUgc3Rh
dGVtZW50IGluIHRoZSB2aXJ0aW8gc3BlYyBhbmQgZWxpbWluYXRlIHRoZQo+ID4gPiBidXJkZW4g
b2YgdHJhbnNpdGlvbmFsIGRldmljZSBmb3IgYm90aCB2RFBBIGJ1cyBhbmQgdkRQQSBwYXJlbnQu
Cj4gPiA+IAo+ID4gPiB1QVBJIHNlZW1zIGZpbmUgc2luY2UgYWxsIHRoZSB2RFBBIHBhcmVudCBt
YW5kYXRlcwo+ID4gPiBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0gd2hpY2ggaW1wbGllcyAxLjAg
ZGV2aWNlcy4KPiA+ID4gCj4gPiA+IEZvciBsZWdhY3kgZ3Vlc3RzLCBpdCBjYW4gc3RpbGwgd29y
ayBzaW5jZSBRZW11IHdpbGwgbWVkaWF0ZSB3aGVuCj4gPiA+IG5lY2Vzc2FyeSAoZS5nIGRvaW5n
IHRoZSBlbmRpYW4gY29udmVyc2lvbikuCj4gPiA+IAo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gSG1tLiBJZiB3ZSBkbyB0aGlzLCBkb24n
dCB3ZSBzdGlsbCBoYXZlIGEgcHJvYmxlbSB3aXRoCj4gPiBsZWdhY3kgZHJpdmVycyB3aGljaCBk
b24ndCBhY2sgMS4wPwo+IAo+IAo+IFllcywgYnV0IGl0J3Mgbm90IHNvbWV0aGluZyB0aGF0IGlz
IGludHJvZHVjZWQgaW4gdGhpcyBjb21taXQuIFRoZSBsZWdhY3kKPiBkcml2ZXIgbmV2ZXIgd29y
ayAuLi4KCk15IHBvaW50IGlzIHRoaXMgbmVpdGhlciBmaXhlcyBvciBwcmV2ZW50cyB0aGlzLgoK
U28gbXkgc3VnZ2VzdGlvbiBpcyB0byBmaW5hbGx5IGFkZCBpb2N0bHMgYWxvbmcgdGhlIGxpbmVz
Cm9mIFBST1RPQ09MX0ZFQVRVUkVTIG9mIHZob3N0LXVzZXIuCgpUaGVuIHRoYXQgb25lIGNhbiBo
YXZlIGJpdHMgZm9yIGxlZ2FjeSBsZSwgbGVnYWN5IGJlIGFuZCBtb2Rlcm4uCgpCVFcgSSBsb29r
ZWQgYXQgdmhvc3QtdXNlciBhbmQgaXQgZG9lcyBub3QgbG9vayBsaWtlIHRoYXQKaGFzIGEgc29s
dXRpb24gZm9yIHRoaXMgcHJvYmxlbSBlaXRoZXIsIHJpZ2h0PwoKCj4gCj4gPiBOb3RlIDEuMCBh
ZmZlY3RzIHJpbmcgZW5kaWFubmVzcyB3aGljaCBpcyBub3QgbWVkaWF0ZWQgaW4gUUVNVQo+ID4g
c28gUUVNVSBjYW4ndCBwcmV0ZW5kIHRvIGRldmljZSBndWVzdCBpcyAxLjAuCj4gCj4gCj4gUmln
aHQsIEkgcGxhbiB0byBzZW5kIHBhdGNoZXMgdG8gZG8gbWVkaWF0aW9uIGluIHRoZSBRZW11IHRv
IHVuYnJlYWsgbGVnYWN5Cj4gZHJpdmVycy4KPiAKPiBUaGFua3MKCkkgZnJhbmtseSB0aGluayB3
ZSdsbCBuZWVkIFBST1RPQ09MX0ZFQVRVUkVTIGFueXdheSwgaXQncyB0b28gdXNlZnVsIC4uLgpz
byB3aHkgbm90IHRlYWNoIGRyaXZlcnMgYWJvdXQgaXQgYW5kIGJlIGRvbmUgd2l0aCBpdD8gWW91
IGNhbid0IGVtdWxhdGUKbGVnYWN5IG9uIG1vZGVybiBpbiBhIGNyb3NzIGVuZGlhbiBzaXR1YXRp
b24gYmVjYXVzZSBvZiB2cmluZwplbmRpYW4tbmVzcyAuLi4KCgo+IAo+ID4gCj4gPiAKPiA+IAo+
ID4gCj4gPiAKPiA+ID4gLS0tCj4gPiA+ICAgaW5jbHVkZS9saW51eC92ZHBhLmggfCA2ICsrKysr
Kwo+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPiA+ID4gCj4gPiA+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaCBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4g
PiA+IGluZGV4IDBmZWZlYjk3Njg3Ny4uY2ZkZTRlYzk5OWI0IDEwMDY0NAo+ID4gPiAtLS0gYS9p
bmNsdWRlL2xpbnV4L3ZkcGEuaAo+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+ID4g
PiBAQCAtNiw2ICs2LDcgQEAKPiA+ID4gICAjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+Cj4gPiA+
ICAgI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgo+ID4gPiAgICNpbmNsdWRlIDxsaW51eC92
aG9zdF9pb3RsYi5oPgo+ID4gPiArI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX2NvbmZpZy5o
Pgo+ID4gPiAgIC8qKgo+ID4gPiAgICAqIHZEUEEgY2FsbGJhY2sgZGVmaW5pdGlvbi4KPiA+ID4g
QEAgLTMxNyw2ICszMTgsMTEgQEAgc3RhdGljIGlubGluZSBpbnQgdmRwYV9zZXRfZmVhdHVyZXMo
c3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1NjQgZmVhdHVyZXMpCj4gPiA+ICAgewo+ID4gPiAg
ICAgICAgICAgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRldi0+Y29uZmln
Owo+ID4gPiArICAgICAgICAvKiBNYW5kYXRpbmcgMS4wIHRvIGhhdmUgc2VtYW50aWNzIG9mIG5v
cm1hdGl2ZSBzdGF0ZW1lbnRzIGluCj4gPiA+ICsgICAgICAgICAqIHRoZSBzcGVjLiAqLwo+ID4g
PiArICAgICAgICBpZiAoIShmZWF0dXJlcyAmIEJJVF9VTEwoVklSVElPX0ZfVkVSU0lPTl8xKSkp
Cj4gPiA+ICsJCXJldHVybiAtRUlOVkFMOwo+ID4gPiArCj4gPiA+ICAgCXZkZXYtPmZlYXR1cmVz
X3ZhbGlkID0gdHJ1ZTsKPiA+ID4gICAgICAgICAgIHJldHVybiBvcHMtPnNldF9mZWF0dXJlcyh2
ZGV2LCBmZWF0dXJlcyk7Cj4gPiA+ICAgfQo+ID4gPiAtLSAKPiA+ID4gMi4yNS4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=

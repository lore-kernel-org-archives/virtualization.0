Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0C2C433F5
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 15:46:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 37A8E4012F;
	Tue, 11 Jan 2022 15:46:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00MmcpetDxz2; Tue, 11 Jan 2022 15:46:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6108B404F8;
	Tue, 11 Jan 2022 15:46:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15522C0030;
	Tue, 11 Jan 2022 15:46:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A512C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 15:46:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 79C8C8134C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 15:46:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bjD75KcQDmzF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 15:46:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 88F28812D3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 15:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641916008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jc0m/8iF/lGJn7BIJROxPDH0wXyIJVBOix7xKQ6Id/Y=;
 b=OJ8Np7gV3WLaG6YQo+tQfb8VVdHQ1AP2BH4U3fBSB6in6BwrRC/nwrRmXFpdkGjPr+Gyef
 z+x9vgrkJ3tvlve1hIWo2QYqU7jRWnNNHnZjCtBZW4dPDGkMa8RcJEJV/cjlL+b/28eck1
 j3fLyrMnFIZ93+7AhMhkL3LRyR3kEcU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-54TL_kfdNUaV5wHY9Ki8Vg-1; Tue, 11 Jan 2022 10:46:46 -0500
X-MC-Unique: 54TL_kfdNUaV5wHY9Ki8Vg-1
Received: by mail-ed1-f69.google.com with SMTP id
 b8-20020a056402350800b003f8f42a883dso13662823edd.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 07:46:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Jc0m/8iF/lGJn7BIJROxPDH0wXyIJVBOix7xKQ6Id/Y=;
 b=ebg3RMi2yxKgQ88v3F/0ndVlvJEzhpJlzHl8KMhGOpvTqA9z6i/r44S6XXbTU++89i
 KXbIk5//+VeMKTW6yu4w5I6T02z+wTN83AsOa2zMY9L13q2szOTO+ml6aVjgw0rvvBU8
 Zk6yPVPIfGlBYiwVI9YwHrxEmAkEgyhFclein6mHbhmdJ+0OgSomL5bNPNzBMSqu1t65
 UqRpGeyc5g/ZEQtlnB8cRrIDTx5IeKtB1/bWA1VFf23Yc1jQLeJzMAUNHf3M3X0MprkG
 ZkrODZM8uDLzkAoPSegJpZKuX9j68OdGf2SYOhz05ijbAvgLi9OQYxuimVhx48+aB3xm
 sHAQ==
X-Gm-Message-State: AOAM533KRgmRRO9z8nCa+FZApuhtIHQV7GX9j7ifWTe/veLiq+ImlSAs
 uNPOQRbpONzonJA0V7AprHYMFqx64hMX/pB2gvpDOqE4pWUVMlxHqQqYCcaNUwSF31plMMkF+bx
 2zDlxT8M22T2jM728Ixg5yL4cE6BFt9n6paSIJXcFhw==
X-Received: by 2002:a17:906:f1ce:: with SMTP id
 gx14mr4217253ejb.766.1641916005713; 
 Tue, 11 Jan 2022 07:46:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgqiGdiOCtACMvdVv2rhysktH2kvUxCPr96DO7Yq1m4qNNJ9uGKf7TkAD2vl4eOd8VmlDFug==
X-Received: by 2002:a17:906:f1ce:: with SMTP id
 gx14mr4217239ejb.766.1641916005517; 
 Tue, 11 Jan 2022 07:46:45 -0800 (PST)
Received: from redhat.com ([2.55.5.100])
 by smtp.gmail.com with ESMTPSA id z11sm5183455edr.72.2022.01.11.07.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jan 2022 07:46:44 -0800 (PST)
Date: Tue, 11 Jan 2022 10:46:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Karlsson, Magnus" <magnus.karlsson@intel.com>
Subject: Re: RE: [PATCH 0/6] virtio: support advance DMA
Message-ID: <20220111104212-mutt-send-email-mst@kernel.org>
References: <MW3PR11MB46029D413C9A6C32C0E5B347F7519@MW3PR11MB4602.namprd11.prod.outlook.com>
 <1641888372.6630723-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEv1p=tM-YNM0nKTDxQCOkaL-9xVji8K76fJxMwwwYHkJg@mail.gmail.com>
 <MW3PR11MB46021E726D394F747E19D4C7F7519@MW3PR11MB4602.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <MW3PR11MB46021E726D394F747E19D4C7F7519@MW3PR11MB4602.namprd11.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization <virtualization@lists.linux-foundation.org>
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

T24gVHVlLCBKYW4gMTEsIDIwMjIgYXQgMDg6NDA6NTZBTSArMDAwMCwgS2FybHNzb24sIE1hZ251
cyB3cm90ZToKPiAKPiAKPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPiBGcm9tOiBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gU2VudDogVHVlc2RheSwgSmFudWFy
eSAxMSwgMjAyMiA5OjI2IEFNCj4gPiBUbzogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGli
YWJhLmNvbT4KPiA+IENjOiBLYXJsc3NvbiwgTWFnbnVzIDxtYWdudXMua2FybHNzb25AaW50ZWwu
Y29tPjsgdmlydHVhbGl6YXRpb24KPiA+IDx2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZz47IE1pY2hhZWwgUy5Uc2lya2luCj4gPiA8bXN0QHJlZGhhdC5jb20+Cj4gPiBT
dWJqZWN0OiBSZTogUkU6IFtQQVRDSCAwLzZdIHZpcnRpbzogc3VwcG9ydCBhZHZhbmNlIERNQQo+
ID4gCj4gPiBPbiBUdWUsIEphbiAxMSwgMjAyMiBhdCA0OjE3IFBNIFh1YW4gWmh1byA8eHVhbnpo
dW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gVHVlLCAxMSBK
YW4gMjAyMiAwODowNDowNSArMDAwMCwgS2FybHNzb24sIE1hZ251cwo+ID4gPG1hZ251cy5rYXJs
c3NvbkBpbnRlbC5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tCj4gPiA+ID4gPiBGcm9tOiBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPgo+ID4gPiA+ID4gU2VudDogVHVlc2RheSwgSmFudWFyeSAxMSwgMjAy
MiA3OjE3IEFNCj4gPiA+ID4gPiBUbzogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4K
PiA+ID4gPiA+IENjOiB2aXJ0dWFsaXphdGlvbiA8dmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmc+Owo+ID4gPiA+ID4gTWljaGFlbCBTLlRzaXJraW4gPG1zdEByZWRoYXQu
Y29tPjsgS2FybHNzb24sIE1hZ251cwo+ID4gPiA+ID4gPG1hZ251cy5rYXJsc3NvbkBpbnRlbC5j
b20+Cj4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDAvNl0gdmlydGlvOiBzdXBwb3J0IGFk
dmFuY2UgRE1BCj4gPiA+ID4gPgo+ID4gPiA+ID4gT24gVHVlLCAxMSBKYW4gMjAyMiAxMDo1NDo0
NSArMDgwMCwgSmFzb24gV2FuZwo+ID4gPiA+ID4gPGphc293YW5nQHJlZGhhdC5jb20+Cj4gPiA+
ID4gPiB3cm90ZToKPiA+ID4gPiA+ID4gT24gTW9uLCBKYW4gMTAsIDIwMjIgYXQgNTo1OSBQTSBN
aWNoYWVsIFMuIFRzaXJraW4KPiA+ID4gPiA+ID4gPG1zdEByZWRoYXQuY29tPgo+ID4gPiA+ID4g
d3JvdGU6Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBPbiBGcmksIEphbiAwNywgMjAyMiBh
dCAwMjozMzowMFBNICswODAwLCBYdWFuIFpodW8gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiB2aXJ0
cXVldWVfYWRkKCkgb25seSBzdXBwb3J0cyB2aXJ0dWFsIGFkZHJlc3NlcywgZG1hIGlzCj4gPiA+
ID4gPiA+ID4gPiBjb21wbGV0ZWQgaW4gdmlydHF1ZXVlX2FkZCgpLgo+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+IEluIHNvbWUgc2NlbmFyaW9zIChzdWNoIGFzIHRoZSBBRl9YRFAgc2Nl
bmFyaW8pLCBETUEgaXMKPiA+ID4gPiA+ID4gPiA+IGNvbXBsZXRlZCBpbiBhZHZhbmNlLCBzbyBp
dCBpcyBuZWNlc3NhcnkgZm9yIHVzIHRvIHN1cHBvcnQKPiA+ID4gPiA+ID4gPiA+IHBhc3Npbmcg
dGhlIERNQSBhZGRyZXNzCj4gPiA+ID4gPiB0byB2aXJ0cXVldWVfYWRkKCkuCj4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gVGhpcyBwYXRjaCBzZXQgc3RpcHVsYXRlcyB0aGF0IGlmIHNn
LT5kbWFfYWRkcmVzcyBpcyBub3QKPiA+ID4gPiA+ID4gPiA+IE5VTEwsIHVzZSB0aGlzIGFkZHJl
c3MgYXMgdGhlIERNQSBhZGRyZXNzLiBBbmQgcmVjb3JkIHRoaXMKPiA+ID4gPiA+ID4gPiA+IGlu
Zm9ybWF0aW9uIGluCj4gPiA+ID4gPiA+ID4gPiBleHRyYS0+ZmxhZ3MsIHdoaWNoIGNhbiBiZSBz
a2lwcGVkIHdoZW4gZXhlY3V0aW5nIGRtYSB1bm1hcC4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gPiAgICAgZXh0cmEtPmZsYWdzIHw9IFZSSU5HX0RFU0NfRl9QUkVETUE7Cj4gPiA+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gQnV0IHRoZSBpbmRpcmVjdCBkZXNjIGRvZXMgbm90IGhh
dmUgYSBjb3JyZXNwb25kaW5nIGV4dHJhLAo+ID4gPiA+ID4gPiA+ID4gc28gdGhlIHNlY29uZCBh
bmQgdGhpcmQgcGF0Y2hlcyBvZiB0aGlzIHBhdGNoIHNldCBhcmUgdG8KPiA+ID4gPiA+ID4gPiA+
IGFsbG9jYXRlIHRoZSBjb3JyZXNwb25kaW5nIGV4dHJhIHdoaWxlIGFsbG9jYXRpbmcgdGhlCj4g
PiA+ID4gPiA+ID4gPiBpbmRpcmVjdCBkZXNjLiBFYWNoIGRlc2MgbXVzdCBoYXZlIGEgY29ycmVz
cG9uZGluZyBleHRyYQo+ID4gPiA+ID4gPiA+ID4gYmVjYXVzZSBpdCBpcyBwb3NzaWJsZSBpbiBh
biBzZ3Mgc29tZSBhcmUgYWR2YW5jZSBETUEsIHdoaWxlCj4gPiA+ID4gPiA+ID4gPiBvdGhlcnMg
YXJlIHZpcnR1YWwgYWRkcmVzc2VzLiBTbyB3ZSBtdXN0Cj4gPiA+ID4gPiBhbGxvY2F0ZSBhbiBl
eHRyYSBmb3IgZWFjaCBpbmRpcmVjdCBkZXNjLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiBJIGRpZG4ndCByZWFsaXplIEFGX1hEUCBkaWRuJ3QgaGF2ZSBzcGFjZSB0
byBzdHVmZiB0aGUgaGVhZGVyIGludG8uCj4gPiA+ID4gPiA+ID4gSmFzb24sIGlzIHRoYXQgZXhw
ZWN0ZWQ/Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEkgbWlnaHQgYmUgd3JvbmcgYnV0IGl0IGxv
b2tzIHRvIG1lIEFGX1hEUCBhbGxvd3MgdG8gcmVzZXJ2ZQo+ID4gPiA+ID4gPiBzdWZmaWNpZW50
IGhlYWRyb29tIHZpYSB4ZHBfdW1lbV9yZWdfdjEuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4g
PiA+ID4gSSB1bmRlcnN0YW5kIHRoYXQgdGhlcmUgaXMgYSBoZWFkcm9vbSBmb3IgcmVjZWl2aW5n
IHBhY2thZ2VzLAo+ID4gPiA+ID4gd2hpY2ggY2FuIGJlIHVzZWQgdG8gcHV0IHZpcnRpbyBoZWFk
ZXJzLiBCdXQgdGhlcmUgaXMgbm8gaGVhZHJvb20KPiA+ID4gPiA+IGRlZmluZWQgaW4gdGhlIGRp
cmVjdGlvbiBvZiBzZW5kaW5nIHBhY2thZ2VzLiBJIGhvcGUgTWFnbnVzCj4gPiA+ID4gPiBLYXJs
c3NvbiBjYW4gaGVscCBjb25maXJtIHdoZXRoZXIgdGhlcmUgaXMgYW55IG1pc3VuZGVyc3RhbmRp
bmcuCj4gPiA+ID4KPiA+ID4gPiBZb3UgY2FuIHNwZWNpZnkgdGhlIGFtb3VudCBvZiBoZWFkcm9v
bSB5b3Ugd2FudCBvbiBUeCBieSBhZGp1c3RpbmcgdGhlCj4gPiAiYWRkciIgZmllbGQgaW4gdGhl
IGRlc2NyaXB0b3Igb2YgdGhlIFR4IHJpbmcuIElmIHlvdXIgY2h1bmsgc3RhcnRzIGF0IGFkZHJl
c3MgWAo+ID4gaW4gdGhlIHVtZW0gYW5kIHlvdSB3YW50IDEyOCBieXRlcyBvZiBoZWFkcm9vbSwg
anVzdCB3cml0ZSB5b3VyIHBhY2tldAo+ID4gaW50byBYKzEyOCBhbmQgcHV0IHRoYXQgYWRkcmVz
cyBpbnRvIHRoZSBUeCBkZXNjcmlwdG9yLiBXaWxsIHRoaXMgc29sdmUgeW91cgo+ID4gcHJvYmxl
bT8gSWYgbm90LCB3aGF0IHdvdWxkIHlvdSBuZWVkIGZyb20gQUZfWERQIHRvIG1ha2UgaXQgd29y
az8KPiA+ID4gPgo+ID4gPiA+IE9uIFJ4LCB0aGVyZSBpcyBhbHdheXMgMjU2IGJ5dGVzIHdvcnRo
IG9mIGhlYWRyb29tIGFzIHNwZWNpZmllZCBieSBYRFAuCj4gPiBJZiB5b3UgbmVlZCBleHRyYSwg
eW91IGNhbiBzZXQgdGhlIGhlYWRyb29tIHZhcmlhYmxlIHdoZW4geW91IHJlZ2lzdGVyIHRoZQo+
ID4gdW1lbS4KPiA+ID4KPiA+ID4gVGhlIGRyaXZlciBvZiB2aXJ0aW8gbmV0LCB3aGVuIHBhc3Np
bmcgdGhlIHBhY2tldCB0byB0aGUgaGFyZHdhcmUsCj4gPiA+IHNob3VsZCBhZGQgYSB2aXJ0bmV0
IGhkciAoMTIgYnl0ZXMpIGluIGZyb250IG9mIHRoZSBwYWNrZXQuIEJvdGggcngKPiA+ID4gYW5k
IHR4IHNob3VsZCBhZGQgc3VjaCBhIGhlYWRlci4gQUZfWERQIGhhcyBhIHNwYWNlIG9mIDI1NiBi
eXRlcyBpbgo+ID4gPiB0aGUgcnggcHJvY2Vzcy4gV2UgY2FuIHJldXNlIHRoaXMgc3BhY2UuIFRo
ZSBkaXJlY3Rpb24gb2YgQUZfWERQIHR4IGhhcyBubwo+ID4gc3VjaCByZWd1bGF0aW9uLgo+ID4g
Pgo+ID4gPiBUaGUgbWV0aG9kIHlvdSBtZW50aW9uZWQgcmVxdWlyZXMgdXNlciBjb29wZXJhdGlv
biwgd2hpY2ggaXMgbm90IGEKPiA+ID4gZ29vZCBtZXRob2QgZm9yIGRyaXZlciBpbXBsZW1lbnRh
dGlvbi4KPiA+IAo+ID4gVGhpcyB3aWxsIHJlc3VsdCBpbiBhIG5vbi1wb3J0YWJsZSB1c2Vyc3Bh
Y2UgcHJvZ3JhbS4gSSB3b25kZXIgd2h5IFRYIGhhcwo+ID4gYmVjb21lIGEgcHJvYmxlbSBoZXJl
IGFjdHVhbGx5LCBhbnlob3cgd2UgY2FuIHVzZSBhIGRlZGljYXRlZCBzZyBmb3Igdm5ldAo+ID4g
aGRyPyBBbmQgaWYgd2UgcGFja2VkIGFsbCB2bmV0IGhlYWRlcnMgaW4gYW4gYXJyYXkgaXQgd2ls
bCBnaXZlIGxlc3MKPiA+IHBlcmZvcm1hbmNlIGltcGFjdC4KPiAKPiBZZXMsIGl0IHdvdWxkIGJl
IGdyZWF0IGlmIHlvdSBjb3VsZCBwdXQgdGhpcyBzb21ld2hlcmUgZWxzZSDwn5iKLiBFc3BlY2lh
bGx5IHNpbmNlIEkgZG8gbm90IHNlZSBhIHdheSBvdXQgb2YgdGhlIHByb2JsZW0gb2YgdGhlIGRy
aXZlciByZXF1aXJpbmcgaGVhZHJvb20gb24gVHgsIHNpbmNlIHRoaXMgaXMgY29tcGxldGVseSBs
ZWZ0IHVwIHRvIHVzZXItc3BhY2UgYW5kIHVzZXItc3BhY2UgcGFja2V0IG9mZnNldCA9PSBrZXJu
ZWwtc3BhY2UgcGFja2V0IG9mZnNldCB3aXRoaW4gdGhlIGNodW5rLCBhbHdheXMuIFRoZSBvbmx5
IHdheSB0byBjaGFuZ2UgdGhhdCBpcyB0aHJvdWdoIGNvcHlpbmcsIGJ1dCB0aGVuIGl0IGlzIG5v
dCB6ZXJvLWNvcHkgYW55bW9yZS4gT25lIGNvdWxkIHdpc2ggdGhlcmUgd2FzIGEgbWVjaGFuaXNt
IG9mIGNvbW11bmljYXRpbmcgdGhpcyByZXF1aXJlbWVudCB0byB1c2VyLXNwYWNlLCBidXQgaW50
cm9kdWNpbmcgdGhhdCBub3cgd291bGQgbWFrZSBhbnkgZXhpc3RpbmcgYXBwIG5vdCB3b3JrIGZv
ciB2aXJ0aW8tbmV0LiBTbyBwcm9iYWJseSBlYXNpZXIgaWYgeW91IGNvdWxkIGNvbWUgdXAgd2l0
aCBhIHNvbHV0aW9uIG5vdCByZXF1aXJpbmcgaGVhZHJvb20gZm9yIHRoZSBkcml2ZXIuIElmIG5v
dCwgcGxlYXNlIGxldCBtZSBrbm93LgoKV2UgY2FuIHB1dCB0aGUgaGVhZHJvb20gaW4gYSBzZXBh
cmF0ZSBidWZmZXIgd2l0aCBhIGdhdGhlciBsaXN0LiBHYXRoZXIKbGlzdCB3aWxsIGFsd2F5cyBi
ZSBzbG93ZXIgdGhhbiBtYWtpbmcgaXQgbGluZWFyIHRob3VnaC4gdmlydGlvIGlzCmxpa2VseSBu
b3QgdW5pcXVlIGluIHRoYXQgaXQgd29ya3MgYmV0dGVyIHdpdGggYSBoZWFkcm9vbS4KClNvIGl0
IGNvdWxkIGJlIGFuIG9wdGlvbmFsIHRoaW5nIHdoZXJlIHdlIGhhbmRsZSBhIGdhdGhlciBsaXN0
IHRvbywKbGV0J3Mgc2F5IGl0J3Mgbm90IGEgcmVxdWlyZW1lbnQgYnV0IGEgcGVyZm9ybWFuY2Ug
aGludC4KWERQIGdlbmVyYWxseSBpcyBub3QgdG9vIHN0aW5neSB3aXRoIG1lbW9yeSwgc28gbWF5
YmUganVzdAphc2sgYXBwcyB0byBwcmVmZXJhYmx5IGFkZCBhIGNvdXBsZSBvZiBodW5kcmVkIGJ5
dGVzIGhlYWRzcGFjZQppZiB0aGV5IGNhbiwgYW5kIHRoZW4gaXQncyBwb3J0YWJsZSBhY3Jvc3Mg
ZHJpdmVycy4KQW5kIHZpcnRpbyB3aWxsIGxlZ2FjeSB3aGVyZSB0aGF0IHNwYWNlIGlzIG5vdCB0
aGVyZS4KSG93IGRvZXMgdGhpcyBzb3VuZD8KCgoKPiA+IFRoYW5rcwo+ID4gCj4gPiA+Cj4gPiA+
IFRoYW5rcy4KPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gSXQgd291bGQgYmUgYmVzdCBpZiB3ZSBj
b3VsZCBub3QgdXNlIGluZGlyZWN0Lgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoYW5rcy4KPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gSXQgd291bGQgYmUgYmVzdCB0byBmaXggdGhhdCwgcGVyZm9ybWFu
Y2UgaXMgYmVzdCBpZiBoZWFkZXIgaXMKPiA+ID4gPiA+ID4gPiBsaW5lYXIgd2l0aCB0aGUgZGF0
YSAuLi4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gVGhpcyBsb29rcyBsaWtlIGEgbXVzdCBvdGhl
cndpc2Ugd2UgbWF5IG1lZXQgdHJvdWJsZSBpbiB6ZXJvY29weQo+ID4gcmVjZWl2ZS4KPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gT3IgbWF5
YmUgd2UgY2FuIHJlZHVjZSB0aGUgdXNlIG9mIGluZGlyZWN0IHNvbWV3aGF0LCBhdCBsZWFzdAo+
ID4gPiA+ID4gPiA+IHdoaWxlIHRoZSByaW5nIGlzIG1vc3RseSBlbXB0eT8KPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+ID4gWHVhbiBaaHVvICg2KToKPiA+ID4gPiA+ID4gPiA+ICAgdmlydGlv
OiByZW5hbWUgdnJpbmdfdW5tYXBfc3RhdGVfcGFja2VkKCkgdG8KPiA+ID4gPiA+ID4gPiA+ICAg
ICB2cmluZ191bm1hcF9leHRyYV9wYWNrZWQoKQo+ID4gPiA+ID4gPiA+ID4gICB2aXJ0aW86IHNw
bGl0OiBhbGxvYyBpbmRpcmVjdCBkZXNjIHdpdGggZXh0cmEKPiA+ID4gPiA+ID4gPiA+ICAgdmly
dGlvOiBwYWNrZWQ6IGFsbG9jIGluZGlyZWN0IGRlc2Mgd2l0aCBleHRyYQo+ID4gPiA+ID4gPiA+
ID4gICB2aXJ0aW86IHNwbGl0OiB2aXJ0cXVldWVfYWRkX3NwbGl0KCkgc3VwcG9ydCBkbWEgYWRk
cmVzcwo+ID4gPiA+ID4gPiA+ID4gICB2aXJ0aW86IHBhY2tlZDogdmlydHF1ZXVlX2FkZF9wYWNr
ZWQoKSBzdXBwb3J0IGRtYSBhZGRyZXNzCj4gPiA+ID4gPiA+ID4gPiAgIHZpcnRpbzogYWRkIGFw
aSB2aXJ0aW9fZG1hX21hcCgpIGZvciBhZHZhbmNlIGRtYQo+ID4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMzg3ICsrKysrKysrKysr
KysrKysrKysrLS0tLS0tLS0tCj4gPiAtLS0tLS0KPiA+ID4gPiA+ID4gPiA+ICBpbmNsdWRlL2xp
bnV4L3ZpcnRpby5oICAgICAgIHwgICA5ICsKPiA+ID4gPiA+ID4gPiA+ICAyIGZpbGVzIGNoYW5n
ZWQsIDIzMiBpbnNlcnRpb25zKCspLCAxNjQgZGVsZXRpb25zKC0pCj4gPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+ID4gLS0KPiA+ID4gPiA+ID4gPiA+IDIuMzEuMAo+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+Cj4gPiA+Cj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

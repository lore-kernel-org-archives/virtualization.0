Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E90BC433F5
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 06:29:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F411283E37;
	Tue, 17 May 2022 06:29:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vwU6h_mDbz03; Tue, 17 May 2022 06:29:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 758A883381;
	Tue, 17 May 2022 06:29:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5733AC0039;
	Tue, 17 May 2022 06:29:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4E0FC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 06:29:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B387C60D6B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 06:29:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tLXl24RUzvTm
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 06:29:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C77A760B6F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 06:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652768994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ex5aMBQG5jRnpWVI9kCNtvh4qp2lb01lVSM5eoxtznk=;
 b=Kv8zjZ2NDHLMBgq49tHmbIT3sl+eDs3Y+kakgdnqweDQDRpxOQDLID1zPFSx1CYSoaX/BB
 bwn7qvpxmKCa/jNsi9DsKwpoqx1jazmAVRhjdC9dzfREObEYHEjgIF4gaUgnXgeq9gljky
 36BB5UwyxtseFcFIamsa8irE2LhnN6E=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-Y_-H1jN7NWaus5mZzb-91w-1; Tue, 17 May 2022 02:29:51 -0400
X-MC-Unique: Y_-H1jN7NWaus5mZzb-91w-1
Received: by mail-lj1-f197.google.com with SMTP id
 m11-20020a2ea88b000000b0024db6246908so4043317ljq.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 23:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ex5aMBQG5jRnpWVI9kCNtvh4qp2lb01lVSM5eoxtznk=;
 b=wukD//glbGH1Q4jtUl3ZuJhskbw8I4/326c0U+RD6J+Ba1PSyIu6EUHaYbPYA0bAW5
 8QSvXMaxu+W5mtRQdVVAPHWB+w1QsvoGZ3z9yc5lrGX/igBqkpli4/nKH1YXlITcpSYc
 iRQecqlNeOTxcsNOZ7qhktJT6g5QYaX8RdxoC+26j9t4DUMHKO2ZDJDbQJODM63NHSyH
 wL2efVkNmmX+zjDi1t7l0njh1R0nL4tu9vwEm22MmqxO2iWjRfOrPNt14TaKHHSwbLf6
 DOBpVbLJjsFvE92FE/bvre1wPPvTVNcMT+/tcCq/0//+wK7O4J0PZSIvUdV13IZCIDRP
 K7gg==
X-Gm-Message-State: AOAM531lFExWJcG+JH7u2IQ6ZczMGe6IAIBwncgrcXrgagjv1GDYvuur
 3XAMOlsemESICf3GMCX/x/KOWfjbQpWUZt0UgzxmlTYzO4zeCrEZSoUN5AHuctzKhqfsZrP6fYk
 rfS/0142kZqT41NJoD/Oli8G4fZDIyDpsZE1cIsnTlMPaZG49FNm3Dkf6Vg==
X-Received: by 2002:a05:6512:a91:b0:473:bb9e:fc80 with SMTP id
 m17-20020a0565120a9100b00473bb9efc80mr15892070lfu.471.1652768989597; 
 Mon, 16 May 2022 23:29:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/zqPSFQhLidH18XKpcWMLgkEo00ljuW+yUjIv8a/tmgT+VgkGdsKIWbGDCluXudS87Xc0d07o+nB1rjEsPRQ=
X-Received: by 2002:a05:6512:a91:b0:473:bb9e:fc80 with SMTP id
 m17-20020a0565120a9100b00473bb9efc80mr15892054lfu.471.1652768989384; Mon, 16
 May 2022 23:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220516060342.106-1-xieyongji@bytedance.com>
 <20220516060342.106-2-xieyongji@bytedance.com>
 <51811045-548c-1241-0a25-d23e8f7c9d1d@redhat.com>
 <CACycT3uoWjYjogi0H4yrA7GuKnY=djt6BmafoRB-rbmz+8Y4BA@mail.gmail.com>
 <20220516055356-mutt-send-email-mst@kernel.org>
 <CACycT3sqEJ7JSYV646m6CLVH5tKpfbTUV4Oz+XcfXTe4ApEE1w@mail.gmail.com>
 <20220516063357-mutt-send-email-mst@kernel.org> <YoI7eBEkVNPj3qFz@kroah.com>
In-Reply-To: <YoI7eBEkVNPj3qFz@kroah.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 May 2022 14:29:38 +0800
Message-ID: <CACGkMEuF8wJu7mvMbKpB+Ui-XvB_O8+w0qH2yU6=yQ5mYVQW1Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] vdpa: Add a device object for vdpa management
 device
To: Greg KH <gregkh@linuxfoundation.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yongji Xie <xieyongji@bytedance.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>,
 Eli Cohen <elic@nvidia.com>
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

T24gTW9uLCBNYXkgMTYsIDIwMjIgYXQgNzo1NCBQTSBHcmVnIEtIIDxncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZz4gd3JvdGU6Cj4KPiBPbiBNb24sIE1heSAxNiwgMjAyMiBhdCAwNjozNDozNkFN
IC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiBPbiBNb24sIE1heSAxNiwgMjAy
MiBhdCAwNjozMToxOFBNICswODAwLCBZb25namkgWGllIHdyb3RlOgo+ID4gPiBPbiBNb24sIE1h
eSAxNiwgMjAyMiBhdCA1OjU0IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+
IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4gT24gTW9uLCBNYXkgMTYsIDIwMjIgYXQgMDU6MzE6MjdQ
TSArMDgwMCwgWW9uZ2ppIFhpZSB3cm90ZToKPiA+ID4gPiA+IE9uIE1vbiwgTWF5IDE2LCAyMDIy
IGF0IDU6MTQgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IOWcqCAyMDIyLzUvMTYgMTQ6MDMsIFhpZSBZ
b25namkg5YaZ6YGTOgo+ID4gPiA+ID4gPiA+IEludHJvZHVjZSBhIGRldmljZSBvYmplY3QgZm9y
IHZkcGEgbWFuYWdlbWVudCBkZXZpY2UgdG8gY29udHJvbAo+ID4gPiA+ID4gPiA+IGl0cyBsaWZl
Y3ljbGUuIEFuZCB0aGUgZGV2aWNlIG5hbWUgd2lsbCBiZSB1c2VkIHRvIG1hdGNoCj4gPiA+ID4g
PiA+ID4gVkRQQV9BVFRSX01HTVRERVZfREVWX05BTUUgZmllbGQgb2YgbmV0bGluayBtZXNzYWdl
IHJhdGhlciB0aGFuCj4gPiA+ID4gPiA+ID4gdXNpbmcgcGFyZW50IGRldmljZSBuYW1lLgo+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gV2l0aCB0aGlzIHBhdGNoIGFwcGxpZWQsIGRyaXZlcnMg
c2hvdWxkIHVzZSB2ZHBhX21nbXRkZXZfYWxsb2MoKQo+ID4gPiA+ID4gPiA+IG9yIF92ZHBhX21n
bXRkZXZfYWxsb2MoKSB0byBhbGxvY2F0ZSBhIHZEUEEgbWFuYWdlbWVudCBkZXZpY2UKPiA+ID4g
PiA+ID4gPiBiZWZvcmUgY2FsbGluZyB2ZHBhX21nbXRkZXZfcmVnaXN0ZXIoKS4gQW5kIHNvbWUg
YnVnZ3kgZW1wdHkKPiA+ID4gPiA+ID4gPiByZWxlYXNlIGZ1bmN0aW9uIGNhbiBhbHNvIGJlIHJl
bW92ZWQgZnJvbSB0aGUgZHJpdmVyIGNvZGVzLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogWGllIFlvbmdqaSA8eGlleW9uZ2ppQGJ5dGVkYW5jZS5jb20+Cj4gPiA+
ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiA+ID4gICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFp
bi5jICAgICAgfCAxMSArKy0tCj4gPiA+ID4gPiA+ID4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMgICAgfCAxMSArKy0tCj4gPiA+ID4gPiA+ID4gICBkcml2ZXJzL3ZkcGEvdmRw
YS5jICAgICAgICAgICAgICAgICAgfCA5MiArKysrKysrKysrKysrKysrKysrKysrKystLS0tCj4g
PiA+ID4gPiA+ID4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMgfCAzOSAr
KysrLS0tLS0tLS0KPiA+ID4gPiA+ID4gPiAgIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3Np
bV9uZXQuYyB8IDQ2ICsrKysrLS0tLS0tLS0tCj4gPiA+ID4gPiA+ID4gICBkcml2ZXJzL3ZkcGEv
dmRwYV91c2VyL3ZkdXNlX2Rldi5jICAgfCAzOCArKysrLS0tLS0tLS0KPiA+ID4gPiA+ID4gPiAg
IGluY2x1ZGUvbGludXgvdmRwYS5oICAgICAgICAgICAgICAgICB8IDM4ICsrKysrKysrKysrLQo+
ID4gPiA+ID4gPiA+ICAgNyBmaWxlcyBjaGFuZ2VkLCAxNjggaW5zZXJ0aW9ucygrKSwgMTA3IGRl
bGV0aW9ucygtKQo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFp
bi5jCj4gPiA+ID4gPiA+ID4gaW5kZXggNDM2NjMyMGZiNjhkLi5kNDA4N2MzN2NmZGYgMTAwNjQ0
Cj4gPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+ID4g
PiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPiA+ID4gPiA+
ID4gPiBAQCAtODIxLDEwICs4MjEsMTEgQEAgc3RhdGljIGludCBpZmN2Zl9wcm9iZShzdHJ1Y3Qg
cGNpX2RldiAqcGRldiwgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmlkKQo+ID4gPiA+ID4g
PiA+ICAgICAgIHUzMiBkZXZfdHlwZTsKPiA+ID4gPiA+ID4gPiAgICAgICBpbnQgcmV0Owo+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gLSAgICAgaWZjdmZfbWdtdF9kZXYgPSBremFsbG9jKHNp
emVvZihzdHJ1Y3QgaWZjdmZfdmRwYV9tZ210X2RldiksIEdGUF9LRVJORUwpOwo+ID4gPiA+ID4g
PiA+IC0gICAgIGlmICghaWZjdmZfbWdtdF9kZXYpIHsKPiA+ID4gPiA+ID4gPiArICAgICBpZmN2
Zl9tZ210X2RldiA9IHZkcGFfbWdtdGRldl9hbGxvYyhzdHJ1Y3QgaWZjdmZfdmRwYV9tZ210X2Rl
diwKPiA+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBtZGV2LCBkZXZfbmFtZShkZXYpLCBkZXYpOwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiBKdXN0IHdvbmRlciBpZiBpdCdzIGJldHRlciB0byBtYWtlIHZEUEEgZGV2aWNlIGEg
Y2hpbGQgb2YgdGhlIG1nbXQKPiA+ID4gPiA+ID4gZGV2aWNlIGluc3RlYWQgb2YgdGhlIFBDSSBk
ZXZpY2U/Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IChDdXJyZW50bHkgd2UgdXNlIFBDSSBkZXZp
Y2UgYXMgdGhlIHBhcmVudCBvZiB0aGUgdkRQQSBkZXZpY2UsIG9yIGF0Cj4gPiA+ID4gPiA+IGxl
YXN0IHdlIGNhbiBkbyB0aGlzIGZvciB0aGUgc2ltdWxhdG9yIHdoaWNoIGRvZXNuJ3QgaGF2ZSBh
IHBhcmVudD8pCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gTWFrZSBzZW5zZS4gSSB0
aGluayB3ZSBjYW4gZG8gaXQgZm9yIGFsbCB2RFBBIGRyaXZlcnMuIE1ha2Ugc3VyZSB0aGUKPiA+
ID4gPiA+IHBhcmVudCBvZiB0aGUgdkRQQSBkZXZpY2UgaXMgdGhlIHZEUEEgbWFuYWdlbWVudCBk
ZXZpY2UuCj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhhbmtzLAo+ID4gPiA+ID4gWW9uZ2ppCj4gPiA+
ID4KPiA+ID4gPgo+ID4gPiA+IHRoYXQncyBhbiBBQkkgY2hhbmdlIHRob3VnaCBpc24ndCBpdD8g
cGFyZW50IGlzIGV4cG9zZWQgaW4gc3lzZnMsCj4gPiA+ID4gcmlnaHQ/Cj4gPiA+ID4KPiA+ID4K
PiA+ID4gSG1tLi4ueWVzLiBTbyBpdCBsb29rcyBsaWtlIHdlIGNhbid0IGNoYW5nZSBpdCwgcmln
aHQ/Cj4gPiA+Cj4gPiA+IFRoYW5rcywKPiA+ID4gWW9uZ2ppCj4gPgo+ID4gQWZyYWlkIHNvLiBh
IHdheSB0byBmaW5kIHRoZSBwY2kgZGV2aWNlIGFscmVhZHkgZXhpc3RzIEkgdGhpbmssIHJpZ2h0
Pwo+Cj4gWW91IGNhbiBjaGFuZ2UgaXQsIGFueSB0b29scyBzaG91bGQgYmUgZ29pbmcgdGhyb3Vn
aCB0aGUgYnVzL2RldmljZQo+IGxpbmtzLCBub3Qgd2Fsa2luZyB0aGUgc3lzZnMgdHJlZSBkaXJl
Y3RseSwgcmlnaHQ/ICBUaGF0J3Mgd2hhdCB0aG9zZQo+IHN5bWxpbmtzIGFyZSBmb3IsIGluIG9y
ZGVyIHRvIHByb3Blcmx5IGJlIGFibGUgdG8gZW51bWVyYXRlIGRpZmZlcmVudAo+IGRldmljZSB0
eXBlcy4KPgo+IEEgc3BlY2lmaWMgdG9wb2xvZ3kgaW4gc3lzZnMgc2hvdWxkIG5vdCBldmVyIGJl
IGFzc3VtZWQgdG8gYmUgc3RhdGljCj4gb3ZlciB0aW1lLCB0aGF0J3Mgbm90IGFuIGFjY3VyYXRl
IHJlcHJlc2VudGF0aW9uIG9mIGhvdyB0aGUga2VybmVsCj4gd29ya3MuCj4KPiBTbyB0cnkgaXQg
YW5kIHNlZT8gIE9kZHMgYXJlIHRoZXJlIGFyZSBubyB0b29scyB0aGF0IGV2ZW4gY2FyZSBhYm91
dAo+IHRoZXNlIGRldmljZXMsIHJpZ2h0PyAgT3IgaXMgdGhlcmU/CgpJIHRoaW5rIHRoZXJlJ3Mg
bm8gdG9vbCB0aGF0IGRlcGVuZHMgb24gdGhlIHN5c2ZzIHRyZWUgbm93LiBUaGUKbWFuYWdlbWVu
dCBsYXllciBpcyBvbmx5IGV4cGVjdGVkIHRvIHRhbGsgdG8gdGhlIG1hbmFnZW1lbnQgZGV2aWNl
IHZpYQp2ZHBhKDgpIHdoaWNoIGlzIGludGVncmF0ZWQgaW4gaXByb3V0ZTIuCgpUaGFua3MKCj4K
PiB0aGFua3MsCj4KPiBncmVnIGstaAo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81AFDC433F5
	for <virtualization@archiver.kernel.org>; Fri, 13 May 2022 06:18:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 263D1607FE;
	Fri, 13 May 2022 06:18:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8oU4S_zu0xDM; Fri, 13 May 2022 06:18:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6CF2D60BC2;
	Fri, 13 May 2022 06:18:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BDDFC0032;
	Fri, 13 May 2022 06:18:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0F40C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 06:18:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C987760BC2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 06:18:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jJRpfLhSpMVO
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 06:18:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CCEF0607FE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 06:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652422724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bYxYcHDmBNRonV1aCz/hZfsybBwlaPWBWVvjPNlftZc=;
 b=AF/J1vZKQf/vMLkhOUpGiEBe/h3CMMqgTM94RQD+oCGnV59cBKKNJDq4kg4085Ry6vuoac
 jIZ5p+iRBwxr4Gt7XQh/4EUDXVg3gabvTYUd4XOwnz05dVw5/ztGd/JiCQXmQrEVFNFJJm
 LKQvO10gBp7YsZICdecRc/X3vYhLFk0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-hIvjAJZKPASd3fVwnIUNNQ-1; Fri, 13 May 2022 02:18:43 -0400
X-MC-Unique: hIvjAJZKPASd3fVwnIUNNQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 h34-20020a0565123ca200b00473e2754d00so3174333lfv.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 23:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bYxYcHDmBNRonV1aCz/hZfsybBwlaPWBWVvjPNlftZc=;
 b=ppm9o959GjpZ5h/2p+zj8HVihnrWgIVNUcdEh217J/zj2HM4Y/7lSXrBKj0PIBWe5u
 uOXizfVVwul7IPGhIGC9kxanSwiD2BKh5xkHeJP6et0hoV4FeJMSI7pwCQehTOI/cG66
 NBMQaWLr0B759v08fti0IhGvcZlxQPgm85ZLaRspiFwzwFAOIgEDrM0bJxp7N9XXoRRh
 eEwPzLImBoUeVsWYB9rs9kGriYqI9Y8QzPKgaGsCpTHY2cMgwZ96w1MYlUjR4DpQBbdv
 YldwW5yrbqgl8E6scvy2m6N4s66th+L2V/do4Xysayt/rQIKTneoHZu3fd8dEKnPCT2l
 qUWA==
X-Gm-Message-State: AOAM533Ne/G7atDiupmYi9xp1wfOu+xusiJPWG20OUDdvcucKFfJchCe
 3GGiV3dFb+ApZ2k7GBWq8Fb31jofmHSSuCmxQaqbTbFV0ijMTNxKnV3hGkAybhVtw95afnXYV1T
 TeyquwcYl1VbV8tJonMmq3JV4L3Qr1g9++Ylt36t6wkNvt0f/mLaOcJ8xpQ==
X-Received: by 2002:a05:6512:a91:b0:473:bb9e:fc80 with SMTP id
 m17-20020a0565120a9100b00473bb9efc80mr2336534lfu.471.1652422721746; 
 Thu, 12 May 2022 23:18:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBnL9Jnuvk7oaX8CeIyjxUEtDXPUUSGDhV4pAhxXOArX8hCJmh8lHAzJkEuHvs78e0R5q3TidWdpzN/ISGdwY=
X-Received: by 2002:a05:6512:a91:b0:473:bb9e:fc80 with SMTP id
 m17-20020a0565120a9100b00473bb9efc80mr2336515lfu.471.1652422721488; Thu, 12
 May 2022 23:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220511135523.147-1-xieyongji@bytedance.com>
 <YnvB2ZxyzGRkPwbm@kroah.com>
 <CACycT3s_-E=whAX02C0KKnr-1qx2yWdvTrRnQN=Km1L98VFThg@mail.gmail.com>
 <YnyZ6LiaQDxRSD/b@kroah.com>
 <CACycT3tibej7Hw3LtNRyDiNLLm7W5PzssENbuSGXsvK8-Cg43Q@mail.gmail.com>
 <Ynym+9BgJOyJdEkn@kroah.com>
 <CACycT3uHn0BnQO8kHY6P+EnLu1-YAVqC3koWP8AKzvcXH4hHYw@mail.gmail.com>
 <YnzMGO919dZG908/@kroah.com>
 <CACycT3uf61r0Wduw=SSMGvbMRA7XWf208Ow0Thc4N6M6nCd0nA@mail.gmail.com>
 <YnzWKfsIfYOif5eA@kroah.com> <85f74db9-06ce-9cef-c7b8-2aedd773ef53@redhat.com>
 <CACycT3tF=zc1P+PBUFoZZqob6P9Hmydexfqj0pWW0_a+dk5Dag@mail.gmail.com>
In-Reply-To: <CACycT3tF=zc1P+PBUFoZZqob6P9Hmydexfqj0pWW0_a+dk5Dag@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 May 2022 14:18:30 +0800
Message-ID: <CACGkMEus19G3QvOiCaANXS7fHsLxKTm6ig7qbSsSqGCawzNKvQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vduse: Remove empty vduse_mgmtdev_release()
To: Yongji Xie <xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Greg KH <gregkh@linuxfoundation.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gRnJpLCBNYXkgMTMsIDIwMjIgYXQgMTI6NDYgUE0gWW9uZ2ppIFhpZSA8eGlleW9uZ2ppQGJ5
dGVkYW5jZS5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCBNYXkgMTMsIDIwMjIgYXQgMTE6NTMgQU0g
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4KPiA+IOWcqCAy
MDIyLzUvMTIgMTc6NDAsIEdyZWcgS0gg5YaZ6YGTOgo+ID4gPiBPbiBUaHUsIE1heSAxMiwgMjAy
MiBhdCAwNTozMTo1MVBNICswODAwLCBZb25namkgWGllIHdyb3RlOgo+ID4gPj4gT24gVGh1LCBN
YXkgMTIsIDIwMjIgYXQgNDo1OCBQTSBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9y
Zz4gd3JvdGU6Cj4gPiA+Pj4gT24gVGh1LCBNYXkgMTIsIDIwMjIgYXQgMDM6NTE6MzhQTSArMDgw
MCwgWW9uZ2ppIFhpZSB3cm90ZToKPiA+ID4+Pj4gT24gVGh1LCBNYXkgMTIsIDIwMjIgYXQgMjox
OSBQTSBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6Cj4gPiA+Pj4+
PiBPbiBUaHUsIE1heSAxMiwgMjAyMiBhdCAwMTo1OTowMFBNICswODAwLCBZb25namkgWGllIHdy
b3RlOgo+ID4gPj4+Pj4+IE9uIFRodSwgTWF5IDEyLCAyMDIyIGF0IDE6MjMgUE0gR3JlZyBLSCA8
Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOgo+ID4gPj4+Pj4+PiBPbiBUaHUsIE1h
eSAxMiwgMjAyMiBhdCAwMToxOTo1OFBNICswODAwLCBZb25namkgWGllIHdyb3RlOgo+ID4gPj4+
Pj4+Pj4gT24gV2VkLCBNYXkgMTEsIDIwMjIgYXQgMTA6MDIgUE0gR3JlZyBLSCA8Z3JlZ2toQGxp
bnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOgo+ID4gPj4+Pj4+Pj4+IE9uIFdlZCwgTWF5IDExLCAy
MDIyIGF0IDA5OjU1OjIyUE0gKzA4MDAsIFhpZSBZb25namkgd3JvdGU6Cj4gPiA+Pj4+Pj4+Pj4+
IEl0J3Mgbm90IHJlY29tbWVuZGVkIHRvIHByb3ZpZGUgYW4gImVtcHR5IiByZWxlYXNlIGZ1bmN0
aW9uCj4gPiA+Pj4+Pj4+Pj4+IGZvciB0aGUgZGV2aWNlIG9iamVjdCBhcyBEb2N1bWVudGF0aW9u
L2NvcmUtYXBpL2tvYmplY3QucnN0Cj4gPiA+Pj4+Pj4+Pj4+IG1lbnRpb25lZC4KPiA+ID4+Pj4+
Pj4+PiAiaXQgaXMgYSBidWcgdG8gaGF2ZSBhbiBlbXB0eSByZWxlYXNlIGZ1bmN0aW9uIiBpcyBt
b3JlIGxpa2UgaXQgOikKPiA+ID4+Pj4+Pj4+Pgo+ID4gPj4+Pj4+Pj4gT0suCj4gPiA+Pj4+Pj4+
Pgo+ID4gPj4+Pj4+Pj4+PiBTbyBsZXQncyBhbGxvY2F0ZSB0aGUgZGV2aWNlIG9iamVjdCBkeW5h
bWljYWxseQo+ID4gPj4+Pj4+Pj4+PiB0byBnZXQgcmlkIG9mIGl0Lgo+ID4gPj4+Pj4+Pj4+IE11
Y2ggYmV0dGVyLCBidXQgbm90IHF1aXRlIHRoZXJlLCBzZWUgYmVsb3cgZm9yIGRldGFpbHMuCj4g
PiA+Pj4+Pj4+Pj4KPiA+ID4+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogWGllIFlvbmdqaSA8eGll
eW9uZ2ppQGJ5dGVkYW5jZS5jb20+Cj4gPiA+Pj4+Pj4+Pj4+IC0tLQo+ID4gPj4+Pj4+Pj4+PiAg
IGRyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMgfCA0MyArKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0KPiA+ID4+Pj4+Pj4+Pj4gICAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0
aW9ucygrKSwgMTggZGVsZXRpb25zKC0pCj4gPiA+Pj4+Pj4+Pj4+Cj4gPiA+Pj4+Pj4+Pj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jIGIvZHJpdmVycy92
ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+ID4gPj4+Pj4+Pj4+PiBpbmRleCAxNjBlNDBkMDMw
ODQuLmE4YTVlYmFlZmExMCAxMDA2NDQKPiA+ID4+Pj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy92ZHBh
L3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+ID4gPj4+Pj4+Pj4+PiArKysgYi9kcml2ZXJzL3ZkcGEv
dmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4gPiA+Pj4+Pj4+Pj4+IEBAIC0xNDc1LDE1ICsxNDc1LDYg
QEAgc3RhdGljIGNoYXIgKnZkdXNlX2Rldm5vZGUoc3RydWN0IGRldmljZSAqZGV2LCB1bW9kZV90
ICptb2RlKQo+ID4gPj4+Pj4+Pj4+PiAgICAgICAgcmV0dXJuIGthc3ByaW50ZihHRlBfS0VSTkVM
LCAidmR1c2UvJXMiLCBkZXZfbmFtZShkZXYpKTsKPiA+ID4+Pj4+Pj4+Pj4gICB9Cj4gPiA+Pj4+
Pj4+Pj4+Cj4gPiA+Pj4+Pj4+Pj4+IC1zdGF0aWMgdm9pZCB2ZHVzZV9tZ210ZGV2X3JlbGVhc2Uo
c3RydWN0IGRldmljZSAqZGV2KQo+ID4gPj4+Pj4+Pj4+PiAtewo+ID4gPj4+Pj4+Pj4+PiAtfQo+
ID4gPj4+Pj4+Pj4+PiAtCj4gPiA+Pj4+Pj4+Pj4+IC1zdGF0aWMgc3RydWN0IGRldmljZSB2ZHVz
ZV9tZ210ZGV2ID0gewo+ID4gPj4+Pj4+Pj4+PiAtICAgICAuaW5pdF9uYW1lID0gInZkdXNlIiwK
PiA+ID4+Pj4+Pj4+Pj4gLSAgICAgLnJlbGVhc2UgPSB2ZHVzZV9tZ210ZGV2X3JlbGVhc2UsCj4g
PiA+Pj4+Pj4+Pj4+IC19Owo+ID4gPj4+Pj4+Pj4+PiAtCj4gPiA+Pj4+Pj4+Pj4+ICAgc3RhdGlj
IHN0cnVjdCB2ZHBhX21nbXRfZGV2IG1nbXRfZGV2Owo+ID4gPj4+Pj4+Pj4+IENsb3NlLiAgVGhp
cyBzaG91bGQgYmUgYSBwb2ludGVyIGFuZCB0aGUgZGV2aWNlIHN0cnVjdHVyZSB3aXRoaW4gaXQK
PiA+ID4+Pj4+Pj4+PiBzaG91bGQgY29udHJvbCB0aGUgbGlmZWN5Y2xlIG9mIHRoYXQgc3RydWN0
dXJlLiAgSXQgc2hvdWxkIG5vdCBiZSBhCj4gPiA+Pj4+Pj4+Pj4gc2luZ2xlIHN0YXRpYyBzdHJ1
Y3R1cmUgbGlrZSB0aGlzLCB0aGF0J3MgdmVyeSBvZGQuCj4gPiA+Pj4+Pj4+Pj4KPiA+ID4+Pj4+
Pj4+IE9LLCBJIGNhbiBkZWZpbmUgbWdtdF9kZXYgYXMgYSBwb2ludGVyLiBCdXQgdGhlIGRldmlj
ZSBpcyBkZWZpbmVkIGFzIGEKPiA+ID4+Pj4+Pj4+IHBhcmVudCBkZXZpY2UgZm9yIHN0cnVjdHVy
ZSB2ZHBhX21nbXRfZGV2LiBTbyBJIHRoaW5rIHdlIGNhbid0IHVzZSBpdAo+ID4gPj4+Pj4+Pj4g
dG8gY29udHJvbCB0aGUgbGlmZWN5Y2xlIG9mIHRoZSBzdHJ1Y3R1cmUgdmRwYV9tZ210X2Rldi4K
PiA+ID4+Pj4+Pj4gWW91IHNob3VsZCBiZSBhYmxlIHRvIGNvbnRyb2wgdGhlIGxpZmVjeWNsZSBv
ZiBpdCwgZXNwZWNpYWxseSBpZiBpdCBpcwo+ID4gPj4+Pj4+PiB0aGUgcGFyZW50IGRldmljZSBv
ZiBzb21ldGhpbmcuICBUbyBub3QgZG8gdGhhdCBjb3JyZWN0bHkgaXMgdG8gaGF2ZQo+ID4gPj4+
Pj4+PiBldmVyeXRoaW5nIG1lc3NlZCB1cCBhcyB5b3Ugc2hvdWxkIGJlIHVzaW5nIHRoZSBkcml2
ZXIgbW9kZWwgcHJvcGVybHkuCj4gPiA+Pj4+Pj4+IEFzIGl0IGlzLCB5b3UgYXJlIG5vdCA6KAo+
ID4gPj4+Pj4+Pgo+ID4gPj4+Pj4+IEkgY2FuIGNvbnRyb2wgdGhlIGxpZmVjeWNsZSBvZiBpdC4g
V2hhdCBJIG1lYW4gaXMgdGhhdCBJIGNhbiBub3QgZnJlZQo+ID4gPj4+Pj4+IGl0IGluIHRoZSBy
ZWxlYXNlIGZ1bmN0aW9uIG9mIHRoZSBkZXZpY2Ugb2JqZWN0IHNpbmNlIGl0IGlzIHRoZSBwYXJl
bnQKPiA+ID4+Pj4+PiBkZXZpY2Ugb2YgbWdtdF9kZXYuIEUuZy4sIGluIG90aGVyIGNhc2VzIChz
dWNoIGFzIGlmY3ZmX3Byb2JlKCkpLCB0aGUKPiA+ID4+Pj4+PiBkZXZpY2Ugb2JqZWN0IGNvbWVz
IGZyb20gYSBwY2kgZGV2aWNlIGJ1dCB0aGUgc3RydWN0dXJlIHZkcGFfbWdtdF9kZXYKPiA+ID4+
Pj4+PiBpcyBjcmVhdGVkIGR1cmluZyBkcml2ZXIgcHJvYmluZy4gVGhlIHN0cnVjdHVyZSB2ZHBh
X21nbXRfZGV2IGp1c3QKPiA+ID4+Pj4+PiBtYWludGFpbnMgYSBwb2ludGVyIHRvIHRoZSBkZXZp
Y2Ugb2JqZWN0LiBTbyB0aGUgc3RydWN0dXJlCj4gPiA+Pj4+Pj4gdmRwYV9tZ210X2RldiBhbmQg
dGhlIGRldmljZSBvYmplY3QgaGF2ZSBkaWZmZXJlbnQgbGlmZWN5Y2xlcy4KPiA+ID4+Pj4+IFRo
ZW4gc29tZXRoaW5nIGlzIHZlcnkgdmVyeSB3cm9uZyBoZXJlLiAgVGhlIHN0cnVjdHVyZSdzIGxp
ZmVzcGFjZQo+ID4gPj4+Pj4gc2hvdWxkIG9ubHkgYmUgY29udHJvbGxlZCBieSBvbmUgcmVmZXJl
bmNlIGNvdW50LCBub3QgbXVsdGlwbGUgb25lcy4KPiA+ID4+Pj4gQnV0IHRoZXkgYXJlIGRpZmZl
cmVudCBkZXZpY2VzIChvbmUgaXMgdmRwYV9tZ210X2RldiBhbmQgYW5vdGhlciBpcwo+ID4gPj4+
PiB0aGUgZGV2aWNlIEkgY3JlYXRlIHdoaWNoIHdpbGwgYmUgdGhlIHBhcmVudCBvZiB2ZHBhX21n
bXRfZGV2KSwgSQo+ID4gPj4+PiBkaWRuJ3QgZ2V0IHdoeSB3ZSBuZWVkIHRvIGNvbnRyb2wgdGhl
aXIgbGlmZWN5Y2xlIGluIG9uZSByZWZlcmVuY2UKPiA+ID4+Pj4gY291bnQuCj4gPiA+Pj4+Cj4g
PiA+Pj4+PiBIYXZlIGl0IGJlIGNvbnRyb2xsZWQgYnkgdGhlIGRldmljZSB5b3UgY3JlYXRlIGFu
ZCBwcm9wZXJseSByZWdpc3RlciBhcwo+ID4gPj4+Pj4gYSBjaGlsZCBvZiB0aGUgcGNpIGRldmlj
ZSBhbmQgYWxsIHNob3VsZCBiZSBmaW5lLgo+ID4gPj4+Pj4KPiA+ID4+Pj4gVGhlIHN0cnVjdHVy
ZSB2ZHBhX21nbXRfZGV2IGlzIGRlZmluZWQgYXM6Cj4gPiA+Pj4+Cj4gPiA+Pj4+IC8qKgo+ID4g
Pj4+PiAgICogc3RydWN0IHZkcGFfbWdtdF9kZXYgLSB2ZHBhIG1hbmFnZW1lbnQgZGV2aWNlCj4g
PiA+Pj4+ICAgKiBAZGV2aWNlOiBNYW5hZ2VtZW50IHBhcmVudCBkZXZpY2UKPiA+ID4+Pj4gICAq
IEBvcHM6IG9wZXJhdGlvbnMgc3VwcG9ydGVkIGJ5IG1hbmFnZW1lbnQgZGV2aWNlCj4gPiA+Pj4+
ICAgKiBAaWRfdGFibGU6IFBvaW50ZXIgdG8gZGV2aWNlIGlkIHRhYmxlIG9mIHN1cHBvcnRlZCBp
ZHMKPiA+ID4+Pj4gICAqIEBjb25maWdfYXR0cl9tYXNrOiBiaXQgbWFzayBvZiBhdHRyaWJ1dGVz
IG9mIHR5cGUgZW51bSB2ZHBhX2F0dHIgdGhhdAo+ID4gPj4+PiAgICogICAgICAgbWFuYWdlbWVu
dCBkZXZpY2Ugc3VwcG9ydCBkdXJpbmcgZGV2X2FkZCBjYWxsYmFjawo+ID4gPj4+PiAgICogQGxp
c3Q6IGxpc3QgZW50cnkKPiA+ID4+Pj4gICAqLwo+ID4gPj4+PiBzdHJ1Y3QgdmRwYV9tZ210X2Rl
diB7Cj4gPiA+Pj4+ICAgICAgc3RydWN0IGRldmljZSAqZGV2aWNlOwo+ID4gPj4+PiAgICAgIGNv
bnN0IHN0cnVjdCB2ZHBhX21nbXRkZXZfb3BzICpvcHM7Cj4gPiA+Pj4+ICAgICAgY29uc3Qgc3Ry
dWN0IHZpcnRpb19kZXZpY2VfaWQgKmlkX3RhYmxlOwo+ID4gPj4+PiAgICAgIHU2NCBjb25maWdf
YXR0cl9tYXNrOwo+ID4gPj4+PiAgICAgIHN0cnVjdCBsaXN0X2hlYWQgbGlzdDsKPiA+ID4+Pj4g
fTsKPiA+ID4+Pj4KPiA+ID4+Pj4gTm93IHRoZSBkZXZpY2UgSSBjcmVhdGUgaXMgcGFzc2VkIHRv
IHRoZSBzdHJ1Y3QgdmRwYV9tZ210X2RldiBhcyBhCj4gPiA+Pj4+IHBhcmVudCBkZXZpY2UgcG9p
bnRlci4gSWYgd2Ugd2FudCB0byBjb250cm9sIHRoZSBsaWZlY3ljbGUgb2YgdGhlCj4gPiA+Pj4+
IHN0cnVjdHVyZSB2ZHBhX21nbXRfZGV2IGJ5IHRoZSBkZXZpY2UgSSBjcmVhdGUsIHNvbWUgbG9n
aWMgb2YgdGhlIHZkcGEKPiA+ID4+Pj4gbWFuYWdlbWVudCBkZXZpY2UgbmVlZHMgdG8gYmUgcmV3
b3JrZWQuIEZvciBleGFtcGxlLCBkZWZpbmUgYSBkZXZpY2UKPiA+ID4+Pj4gb2JqZWN0IGZvciBz
dHJ1Y3R1cmUgdmRwYV9tZ210X2RldiByYXRoZXIgdGhhbiBqdXN0IG1haW50YWluaW5nIGEKPiA+
ID4+Pj4gcG9pbnRlciB0byB0aGUgcGFyZW50IGRldmljZS4KPiA+ID4+PiBCdXQgdGhpcyBpcyBh
IGRldmljZSAoaXQgc2F5cyBpbiB0aGUgbmFtZSksIHNvIGl0IHNob3VsZCBoYXZlIHRoZSBkZXZp
Y2UKPiA+ID4+PiBzdHJ1Y3R1cmUgZW1iZWRkZWQgaW4gaXQgdG8gY29udHJvbCB0aGUgbGlmZXNw
YW4gb2YgaXQuCj4gPiA+Pj4KPiA+ID4+IEN1cnJlbnRseSBpdCdzIG5vdCBhIGRldmljZSBhcyBK
YXNvbiBtZW50aW9uZWQuIFNvIEkgdGhpbmsgdGhlCj4gPiA+PiBxdWVzdGlvbiBpcyB3aGV0aGVy
IHdlIG5lZWQgdG8gcmUtZGVmaW5lIGl0IG9yIGp1c3QgcmUtbmFtZSBpdC4KPiA+ID4gSXQgaXMg
YSBkZXZpY2UsIHlvdSBoYXZlIGEgcG9pbnRlciB0byBhIGRldmljZSBzdHJ1Y3R1cmUgdGhhdCBp
cyB1c2VkIGJ5Cj4gPiA+IHRoZSBjb2RlIQo+ID4gPgo+ID4gPiBFbWJlZCBpdCBpbiB0aGUgc3Ry
dWN0dXJlIGFuZCB5b3Ugc2hvdWxkIGJlIGZpbmUuICBXZWxsLCBtYXliZSwgbGV0J3MKPiA+ID4g
c2VlIHdoYXQgZmFsbHMgb3V0IGZyb20gdGhlcmUgYXMgaXQgc2VlbXMgbGlrZSB0aGUgdXNlIG9m
IHRoZSBkcml2ZXIKPiA+ID4gbW9kZWwgaXMgYSBiaXQgbWVzc2VkIHVwIGluIHRoaXMgY29kZWJh
c2UuICBCdXQgaXQncyBhIGdvb2QgZmlyc3Qgc3RlcAo+ID4gPiBmb3J3YXJkIGluIGZpeGluZyB0
aGluZ3MuCj4gPgo+ID4KPiA+IFJpZ2h0LCB0aGluZ3MgYmVjYW1lIG1lc3NlZCB1cCBzaW5jZSB0
aGUgaW50cm9kdWN0aW9uIG9mIHRoZSBtZ210IGRldmljZS4KPiA+Cj4gPiBZb25nIEppLCB3YW5k
IHRvIGRvIHRoZSB3b3JrIChvciBpZiB5b3Ugd2lzaCBJIGNhbiBkbyByZXdvcmspPwo+ID4KPgo+
IFN1cmUuIEkgY2FuIGRvIGl0LgoKR3JlYXQuCgpUaGFua3MKCj4KPiBUaGFua3MsCj4gWW9uZ2pp
Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==

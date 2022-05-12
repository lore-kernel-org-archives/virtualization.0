Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C862C433FE
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 08:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AF8BC40185;
	Thu, 12 May 2022 08:53:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y6UIIa6jrAB2; Thu, 12 May 2022 08:53:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 347D3400FD;
	Thu, 12 May 2022 08:53:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFFC8C0032;
	Thu, 12 May 2022 08:53:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4D62C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 08:53:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8503283E23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 08:53:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VuHMEDMC1AUk
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 08:53:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A504E826C2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 08:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652345582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iWM3AU/fKzLFf1d+D6DVf6MGYZ2dMRyA0PEKJpKR3sU=;
 b=D1lgnzChxcdho5Ua85CEJYgEppYhw6Twm7T4bN6qrVX29YYhGYB5VpgYUx1gyk8w918iOs
 q7pkFlv6N984/YRUUfaHxmuOF7jumugeqhXSwXsb/UoO5W/2caWXsG4gCVHV/pVzTmzxZK
 IctqKHeCuuI98HUoIwzTAGyiLxfhk5c=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-j6jACL2PM2eBDH4Fv1-rWA-1; Thu, 12 May 2022 04:52:58 -0400
X-MC-Unique: j6jACL2PM2eBDH4Fv1-rWA-1
Received: by mail-pj1-f69.google.com with SMTP id
 u1-20020a17090a2b8100b001d9325a862fso2520633pjd.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 01:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=iWM3AU/fKzLFf1d+D6DVf6MGYZ2dMRyA0PEKJpKR3sU=;
 b=bZjahzCpnNDcg+zbPSNEncGpxWQ0bganTmNZDL02l9rA79TzfOvzlqha8KFe0IX/FF
 FM0B+R04VDcmQmA+XBJe0t7gvKY5oKe1UtClrOVLvuxg3MaNT2qU+S0XLN6gtqn+5H3n
 Sjqx4jrPjP1DwUbgcDo3XkTInHPbwI+9NC2d2+SYzfVh+LdVX6S4PG6zU70Kt801JGE+
 FXGqybR7PilkdL+5m5IlkxNR9fL3nCDn+scV8MgfPgq4HhsT5zY5S4ScysUzc1NaUoSf
 +x0CvNWAf2UqD7UwbGSt7xZSqUEe1Sh8JU3xjMhgQU/oGSjbQvMh4FSx2btfNHwbu2zo
 X3lA==
X-Gm-Message-State: AOAM530rrukOQ2c9KofIPJTmqpj4/w9A7IU5dRPlB0p8id+BfGLS9ECk
 dHOyi2akfB6nZB5AscMPF+wBmaK061Mv4EUAWAUuKjaXnjXbvcD6TZwe+BLgu3xwP2Az7dngA0u
 oPHOhv5HE9qzmvCHmAc8XoSpZew88FOIcjwfnBnpF8g==
X-Received: by 2002:a62:5c3:0:b0:50d:4274:4e9d with SMTP id
 186-20020a6205c3000000b0050d42744e9dmr28659001pff.54.1652345577750; 
 Thu, 12 May 2022 01:52:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrxysiSclxILqIo3zFBNAZZPe9RiTbjG6q/MEm8FGpBpAHqV27kUI6/CjFvvh7FXh+xeCTIw==
X-Received: by 2002:a62:5c3:0:b0:50d:4274:4e9d with SMTP id
 186-20020a6205c3000000b0050d42744e9dmr28658981pff.54.1652345577447; 
 Thu, 12 May 2022 01:52:57 -0700 (PDT)
Received: from [10.72.13.200] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 j35-20020a634a63000000b003c18ab7389asm1347324pgl.36.2022.05.12.01.52.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 May 2022 01:52:56 -0700 (PDT)
Message-ID: <8ccfb246-7cc0-fe4b-c5b3-51876f11bcd7@redhat.com>
Date: Thu, 12 May 2022 16:52:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] vduse: Remove empty vduse_mgmtdev_release()
To: Yongji Xie <xieyongji@bytedance.com>, Greg KH <gregkh@linuxfoundation.org>
References: <20220511135523.147-1-xieyongji@bytedance.com>
 <YnvB2ZxyzGRkPwbm@kroah.com>
 <CACycT3s_-E=whAX02C0KKnr-1qx2yWdvTrRnQN=Km1L98VFThg@mail.gmail.com>
 <YnyZ6LiaQDxRSD/b@kroah.com>
 <CACycT3tibej7Hw3LtNRyDiNLLm7W5PzssENbuSGXsvK8-Cg43Q@mail.gmail.com>
 <Ynym+9BgJOyJdEkn@kroah.com>
 <CACycT3uHn0BnQO8kHY6P+EnLu1-YAVqC3koWP8AKzvcXH4hHYw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CACycT3uHn0BnQO8kHY6P+EnLu1-YAVqC3koWP8AKzvcXH4hHYw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization <virtualization@lists.linux-foundation.org>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzUvMTIgMTU6NTEsIFlvbmdqaSBYaWUg5YaZ6YGTOgo+IE9uIFRodSwgTWF5IDEy
LCAyMDIyIGF0IDI6MTkgUE0gR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdy
b3RlOgo+PiBPbiBUaHUsIE1heSAxMiwgMjAyMiBhdCAwMTo1OTowMFBNICswODAwLCBZb25namkg
WGllIHdyb3RlOgo+Pj4gT24gVGh1LCBNYXkgMTIsIDIwMjIgYXQgMToyMyBQTSBHcmVnIEtIIDxn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6Cj4+Pj4gT24gVGh1LCBNYXkgMTIsIDIw
MjIgYXQgMDE6MTk6NThQTSArMDgwMCwgWW9uZ2ppIFhpZSB3cm90ZToKPj4+Pj4gT24gV2VkLCBN
YXkgMTEsIDIwMjIgYXQgMTA6MDIgUE0gR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc+IHdyb3RlOgo+Pj4+Pj4gT24gV2VkLCBNYXkgMTEsIDIwMjIgYXQgMDk6NTU6MjJQTSArMDgw
MCwgWGllIFlvbmdqaSB3cm90ZToKPj4+Pj4+PiBJdCdzIG5vdCByZWNvbW1lbmRlZCB0byBwcm92
aWRlIGFuICJlbXB0eSIgcmVsZWFzZSBmdW5jdGlvbgo+Pj4+Pj4+IGZvciB0aGUgZGV2aWNlIG9i
amVjdCBhcyBEb2N1bWVudGF0aW9uL2NvcmUtYXBpL2tvYmplY3QucnN0Cj4+Pj4+Pj4gbWVudGlv
bmVkLgo+Pj4+Pj4gIml0IGlzIGEgYnVnIHRvIGhhdmUgYW4gZW1wdHkgcmVsZWFzZSBmdW5jdGlv
biIgaXMgbW9yZSBsaWtlIGl0IDopCj4+Pj4+Pgo+Pj4+PiBPSy4KPj4+Pj4KPj4+Pj4+PiBTbyBs
ZXQncyBhbGxvY2F0ZSB0aGUgZGV2aWNlIG9iamVjdCBkeW5hbWljYWxseQo+Pj4+Pj4+IHRvIGdl
dCByaWQgb2YgaXQuCj4+Pj4+PiBNdWNoIGJldHRlciwgYnV0IG5vdCBxdWl0ZSB0aGVyZSwgc2Vl
IGJlbG93IGZvciBkZXRhaWxzLgo+Pj4+Pj4KPj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9u
Z2ppIDx4aWV5b25namlAYnl0ZWRhbmNlLmNvbT4KPj4+Pj4+PiAtLS0KPj4+Pj4+PiAgIGRyaXZl
cnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMgfCA0MyArKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0KPj4+Pj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxOCBk
ZWxldGlvbnMoLSkKPj4+Pj4+Pgo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRw
YV91c2VyL3ZkdXNlX2Rldi5jIGIvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+
Pj4+Pj4+IGluZGV4IDE2MGU0MGQwMzA4NC4uYThhNWViYWVmYTEwIDEwMDY0NAo+Pj4+Pj4+IC0t
LSBhL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPj4+Pj4+PiArKysgYi9kcml2
ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4+Pj4+Pj4gQEAgLTE0NzUsMTUgKzE0NzUs
NiBAQCBzdGF0aWMgY2hhciAqdmR1c2VfZGV2bm9kZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHVtb2Rl
X3QgKm1vZGUpCj4+Pj4+Pj4gICAgICAgIHJldHVybiBrYXNwcmludGYoR0ZQX0tFUk5FTCwgInZk
dXNlLyVzIiwgZGV2X25hbWUoZGV2KSk7Cj4+Pj4+Pj4gICB9Cj4+Pj4+Pj4KPj4+Pj4+PiAtc3Rh
dGljIHZvaWQgdmR1c2VfbWdtdGRldl9yZWxlYXNlKHN0cnVjdCBkZXZpY2UgKmRldikKPj4+Pj4+
PiAtewo+Pj4+Pj4+IC19Cj4+Pj4+Pj4gLQo+Pj4+Pj4+IC1zdGF0aWMgc3RydWN0IGRldmljZSB2
ZHVzZV9tZ210ZGV2ID0gewo+Pj4+Pj4+IC0gICAgIC5pbml0X25hbWUgPSAidmR1c2UiLAo+Pj4+
Pj4+IC0gICAgIC5yZWxlYXNlID0gdmR1c2VfbWdtdGRldl9yZWxlYXNlLAo+Pj4+Pj4+IC19Owo+
Pj4+Pj4+IC0KPj4+Pj4+PiAgIHN0YXRpYyBzdHJ1Y3QgdmRwYV9tZ210X2RldiBtZ210X2RldjsK
Pj4+Pj4+IENsb3NlLiAgVGhpcyBzaG91bGQgYmUgYSBwb2ludGVyIGFuZCB0aGUgZGV2aWNlIHN0
cnVjdHVyZSB3aXRoaW4gaXQKPj4+Pj4+IHNob3VsZCBjb250cm9sIHRoZSBsaWZlY3ljbGUgb2Yg
dGhhdCBzdHJ1Y3R1cmUuICBJdCBzaG91bGQgbm90IGJlIGEKPj4+Pj4+IHNpbmdsZSBzdGF0aWMg
c3RydWN0dXJlIGxpa2UgdGhpcywgdGhhdCdzIHZlcnkgb2RkLgo+Pj4+Pj4KPj4+Pj4gT0ssIEkg
Y2FuIGRlZmluZSBtZ210X2RldiBhcyBhIHBvaW50ZXIuIEJ1dCB0aGUgZGV2aWNlIGlzIGRlZmlu
ZWQgYXMgYQo+Pj4+PiBwYXJlbnQgZGV2aWNlIGZvciBzdHJ1Y3R1cmUgdmRwYV9tZ210X2Rldi4g
U28gSSB0aGluayB3ZSBjYW4ndCB1c2UgaXQKPj4+Pj4gdG8gY29udHJvbCB0aGUgbGlmZWN5Y2xl
IG9mIHRoZSBzdHJ1Y3R1cmUgdmRwYV9tZ210X2Rldi4KPj4+PiBZb3Ugc2hvdWxkIGJlIGFibGUg
dG8gY29udHJvbCB0aGUgbGlmZWN5Y2xlIG9mIGl0LCBlc3BlY2lhbGx5IGlmIGl0IGlzCj4+Pj4g
dGhlIHBhcmVudCBkZXZpY2Ugb2Ygc29tZXRoaW5nLiAgVG8gbm90IGRvIHRoYXQgY29ycmVjdGx5
IGlzIHRvIGhhdmUKPj4+PiBldmVyeXRoaW5nIG1lc3NlZCB1cCBhcyB5b3Ugc2hvdWxkIGJlIHVz
aW5nIHRoZSBkcml2ZXIgbW9kZWwgcHJvcGVybHkuCj4+Pj4gQXMgaXQgaXMsIHlvdSBhcmUgbm90
IDooCj4+Pj4KPj4+IEkgY2FuIGNvbnRyb2wgdGhlIGxpZmVjeWNsZSBvZiBpdC4gV2hhdCBJIG1l
YW4gaXMgdGhhdCBJIGNhbiBub3QgZnJlZQo+Pj4gaXQgaW4gdGhlIHJlbGVhc2UgZnVuY3Rpb24g
b2YgdGhlIGRldmljZSBvYmplY3Qgc2luY2UgaXQgaXMgdGhlIHBhcmVudAo+Pj4gZGV2aWNlIG9m
IG1nbXRfZGV2LiBFLmcuLCBpbiBvdGhlciBjYXNlcyAoc3VjaCBhcyBpZmN2Zl9wcm9iZSgpKSwg
dGhlCj4+PiBkZXZpY2Ugb2JqZWN0IGNvbWVzIGZyb20gYSBwY2kgZGV2aWNlIGJ1dCB0aGUgc3Ry
dWN0dXJlIHZkcGFfbWdtdF9kZXYKPj4+IGlzIGNyZWF0ZWQgZHVyaW5nIGRyaXZlciBwcm9iaW5n
LiBUaGUgc3RydWN0dXJlIHZkcGFfbWdtdF9kZXYganVzdAo+Pj4gbWFpbnRhaW5zIGEgcG9pbnRl
ciB0byB0aGUgZGV2aWNlIG9iamVjdC4gU28gdGhlIHN0cnVjdHVyZQo+Pj4gdmRwYV9tZ210X2Rl
diBhbmQgdGhlIGRldmljZSBvYmplY3QgaGF2ZSBkaWZmZXJlbnQgbGlmZWN5Y2xlcy4KPj4gVGhl
biBzb21ldGhpbmcgaXMgdmVyeSB2ZXJ5IHdyb25nIGhlcmUuICBUaGUgc3RydWN0dXJlJ3MgbGlm
ZXNwYWNlCj4+IHNob3VsZCBvbmx5IGJlIGNvbnRyb2xsZWQgYnkgb25lIHJlZmVyZW5jZSBjb3Vu
dCwgbm90IG11bHRpcGxlIG9uZXMuCj4gQnV0IHRoZXkgYXJlIGRpZmZlcmVudCBkZXZpY2VzIChv
bmUgaXMgdmRwYV9tZ210X2RldiBhbmQgYW5vdGhlciBpcwo+IHRoZSBkZXZpY2UgSSBjcmVhdGUg
d2hpY2ggd2lsbCBiZSB0aGUgcGFyZW50IG9mIHZkcGFfbWdtdF9kZXYpLCBJCj4gZGlkbid0IGdl
dCB3aHkgd2UgbmVlZCB0byBjb250cm9sIHRoZWlyIGxpZmVjeWNsZSBpbiBvbmUgcmVmZXJlbmNl
Cj4gY291bnQuCgoKSSB0aGluayB0aGUgbmFtZSAidmRwYV9tZ210X2RldiIgaXMgcHJvYmFibHkg
Y29uZnVzaW5nIHNpbmNlIGl0J3Mgbm90IGEgCmRldmljZSAobm8gZW1iZWRkZWQgZGV2aWNlIHN0
cnVjdCkuCgpXZSBwcm9iYWJseSBuZWVkIGEgYmV0dGVyIG5hbWUuCgpUaGFua3MKCgo+Cj4+IEhh
dmUgaXQgYmUgY29udHJvbGxlZCBieSB0aGUgZGV2aWNlIHlvdSBjcmVhdGUgYW5kIHByb3Blcmx5
IHJlZ2lzdGVyIGFzCj4+IGEgY2hpbGQgb2YgdGhlIHBjaSBkZXZpY2UgYW5kIGFsbCBzaG91bGQg
YmUgZmluZS4KPj4KPiBUaGUgc3RydWN0dXJlIHZkcGFfbWdtdF9kZXYgaXMgZGVmaW5lZCBhczoK
Pgo+IC8qKgo+ICAgKiBzdHJ1Y3QgdmRwYV9tZ210X2RldiAtIHZkcGEgbWFuYWdlbWVudCBkZXZp
Y2UKPiAgICogQGRldmljZTogTWFuYWdlbWVudCBwYXJlbnQgZGV2aWNlCj4gICAqIEBvcHM6IG9w
ZXJhdGlvbnMgc3VwcG9ydGVkIGJ5IG1hbmFnZW1lbnQgZGV2aWNlCj4gICAqIEBpZF90YWJsZTog
UG9pbnRlciB0byBkZXZpY2UgaWQgdGFibGUgb2Ygc3VwcG9ydGVkIGlkcwo+ICAgKiBAY29uZmln
X2F0dHJfbWFzazogYml0IG1hc2sgb2YgYXR0cmlidXRlcyBvZiB0eXBlIGVudW0gdmRwYV9hdHRy
IHRoYXQKPiAgICogICAgICAgbWFuYWdlbWVudCBkZXZpY2Ugc3VwcG9ydCBkdXJpbmcgZGV2X2Fk
ZCBjYWxsYmFjawo+ICAgKiBAbGlzdDogbGlzdCBlbnRyeQo+ICAgKi8KPiBzdHJ1Y3QgdmRwYV9t
Z210X2RldiB7Cj4gICAgICBzdHJ1Y3QgZGV2aWNlICpkZXZpY2U7Cj4gICAgICBjb25zdCBzdHJ1
Y3QgdmRwYV9tZ210ZGV2X29wcyAqb3BzOwo+ICAgICAgY29uc3Qgc3RydWN0IHZpcnRpb19kZXZp
Y2VfaWQgKmlkX3RhYmxlOwo+ICAgICAgdTY0IGNvbmZpZ19hdHRyX21hc2s7Cj4gICAgICBzdHJ1
Y3QgbGlzdF9oZWFkIGxpc3Q7Cj4gfTsKPgo+IE5vdyB0aGUgZGV2aWNlIEkgY3JlYXRlIGlzIHBh
c3NlZCB0byB0aGUgc3RydWN0IHZkcGFfbWdtdF9kZXYgYXMgYQo+IHBhcmVudCBkZXZpY2UgcG9p
bnRlci4gSWYgd2Ugd2FudCB0byBjb250cm9sIHRoZSBsaWZlY3ljbGUgb2YgdGhlCj4gc3RydWN0
dXJlIHZkcGFfbWdtdF9kZXYgYnkgdGhlIGRldmljZSBJIGNyZWF0ZSwgc29tZSBsb2dpYyBvZiB0
aGUgdmRwYQo+IG1hbmFnZW1lbnQgZGV2aWNlIG5lZWRzIHRvIGJlIHJld29ya2VkLiBGb3IgZXhh
bXBsZSwgZGVmaW5lIGEgZGV2aWNlCj4gb2JqZWN0IGZvciBzdHJ1Y3R1cmUgdmRwYV9tZ210X2Rl
diByYXRoZXIgdGhhbiBqdXN0IG1haW50YWluaW5nIGEKPiBwb2ludGVyIHRvIHRoZSBwYXJlbnQg
ZGV2aWNlLgo+Cj4gVGhhbmtzLAo+IFlvbmdqaQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3472C433F5
	for <virtualization@archiver.kernel.org>; Fri, 13 May 2022 03:53:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5949B82F0F;
	Fri, 13 May 2022 03:53:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id omo5oENjbIpX; Fri, 13 May 2022 03:53:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BBE9482EF0;
	Fri, 13 May 2022 03:53:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B3F9C0039;
	Fri, 13 May 2022 03:53:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C6EAC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 03:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 173EC82F0F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 03:53:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Il-5GWWGLEpv
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 03:53:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 077DE82EF0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 03:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652414014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8OcMZIRJqKzSNkLTeGB/7AWn8vnEibe5AY+HJEI1Awc=;
 b=SVhxoUrlJSP8um9GHwdpQk++vZGR6FL9WjM0pfWHhXDeK3ttOoZZxHj4QtDz5qsg9OeblM
 bhQRX0JeAYLhqGCihVLwJJJK8+Vbl8zB5aVr2IgW8v2GEl4/2glpCV4EhHAbLMPpwuM6TK
 Swibi2KGTxJGygkZGdQMNs0dYP8r6yo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-4Hezhpd1MO-eW9KwC2_c_g-1; Thu, 12 May 2022 23:53:33 -0400
X-MC-Unique: 4Hezhpd1MO-eW9KwC2_c_g-1
Received: by mail-pj1-f72.google.com with SMTP id
 gb16-20020a17090b061000b001d78792caebso3372442pjb.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 20:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=8OcMZIRJqKzSNkLTeGB/7AWn8vnEibe5AY+HJEI1Awc=;
 b=vdSpeRzPZt26gC6uz4D7AoogNzcQ43CM+8gz7IBiTC0sBAYKa75uyCpZtj//bYBrby
 3feBIbNM3/ARxgLuqYr00lz645Z/vvTY67Qirhq1pnM5E6tLqPRT0Hnau111joBeYFYM
 ftDHhvDeMdJJuHBXo2rgXCP1/ruIf5Na/I6UYx3ZiLng981HcKolhE3xoiSaqaezSRnG
 QXsRcR/bteND09ZIrSLH7F+tEtxO7B3h5KY9DaycIe9wHGwGsRlJj+DrF3Yr3dMDlmD0
 yWgUgSTBItLyoi1NYZBNRYEuq5kptkgQPR6mWpm6E6OKG12phZQnho4Xr9CiRu5EvQxL
 VNwA==
X-Gm-Message-State: AOAM530s8FhYHLM/KBx83YFrj0BLopAeXarar7XC8LJBZ9JCB11z7v5v
 m/9rFITr0gqdA2c3/IGbKZVc3+40A1samvTwO2fNLqPkY/fXEF80lRXhx+k9a2QWha9IS9bqTbu
 IccfmFoVvznRUcTcV1j5kY4snytS+7225EGuswVsN+g==
X-Received: by 2002:a17:902:7788:b0:15e:ec55:2cfd with SMTP id
 o8-20020a170902778800b0015eec552cfdmr2953715pll.113.1652414012385; 
 Thu, 12 May 2022 20:53:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyRZ17ZQYXiN64f33MqhWA5UCInNp0KAfmD41zAOxJIftC97x5UmFiAGdflWPxpz5GwqKD3g==
X-Received: by 2002:a17:902:7788:b0:15e:ec55:2cfd with SMTP id
 o8-20020a170902778800b0015eec552cfdmr2953702pll.113.1652414012062; 
 Thu, 12 May 2022 20:53:32 -0700 (PDT)
Received: from [10.72.14.43] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a170902968800b0015e8d4eb26bsm654890plp.181.2022.05.12.20.53.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 May 2022 20:53:31 -0700 (PDT)
Message-ID: <85f74db9-06ce-9cef-c7b8-2aedd773ef53@redhat.com>
Date: Fri, 13 May 2022 11:53:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] vduse: Remove empty vduse_mgmtdev_release()
To: Greg KH <gregkh@linuxfoundation.org>, Yongji Xie <xieyongji@bytedance.com>
References: <20220511135523.147-1-xieyongji@bytedance.com>
 <YnvB2ZxyzGRkPwbm@kroah.com>
 <CACycT3s_-E=whAX02C0KKnr-1qx2yWdvTrRnQN=Km1L98VFThg@mail.gmail.com>
 <YnyZ6LiaQDxRSD/b@kroah.com>
 <CACycT3tibej7Hw3LtNRyDiNLLm7W5PzssENbuSGXsvK8-Cg43Q@mail.gmail.com>
 <Ynym+9BgJOyJdEkn@kroah.com>
 <CACycT3uHn0BnQO8kHY6P+EnLu1-YAVqC3koWP8AKzvcXH4hHYw@mail.gmail.com>
 <YnzMGO919dZG908/@kroah.com>
 <CACycT3uf61r0Wduw=SSMGvbMRA7XWf208Ow0Thc4N6M6nCd0nA@mail.gmail.com>
 <YnzWKfsIfYOif5eA@kroah.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <YnzWKfsIfYOif5eA@kroah.com>
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

CuWcqCAyMDIyLzUvMTIgMTc6NDAsIEdyZWcgS0gg5YaZ6YGTOgo+IE9uIFRodSwgTWF5IDEyLCAy
MDIyIGF0IDA1OjMxOjUxUE0gKzA4MDAsIFlvbmdqaSBYaWUgd3JvdGU6Cj4+IE9uIFRodSwgTWF5
IDEyLCAyMDIyIGF0IDQ6NTggUE0gR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+
IHdyb3RlOgo+Pj4gT24gVGh1LCBNYXkgMTIsIDIwMjIgYXQgMDM6NTE6MzhQTSArMDgwMCwgWW9u
Z2ppIFhpZSB3cm90ZToKPj4+PiBPbiBUaHUsIE1heSAxMiwgMjAyMiBhdCAyOjE5IFBNIEdyZWcg
S0ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToKPj4+Pj4gT24gVGh1LCBNYXkg
MTIsIDIwMjIgYXQgMDE6NTk6MDBQTSArMDgwMCwgWW9uZ2ppIFhpZSB3cm90ZToKPj4+Pj4+IE9u
IFRodSwgTWF5IDEyLCAyMDIyIGF0IDE6MjMgUE0gR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRh
dGlvbi5vcmc+IHdyb3RlOgo+Pj4+Pj4+IE9uIFRodSwgTWF5IDEyLCAyMDIyIGF0IDAxOjE5OjU4
UE0gKzA4MDAsIFlvbmdqaSBYaWUgd3JvdGU6Cj4+Pj4+Pj4+IE9uIFdlZCwgTWF5IDExLCAyMDIy
IGF0IDEwOjAyIFBNIEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToK
Pj4+Pj4+Pj4+IE9uIFdlZCwgTWF5IDExLCAyMDIyIGF0IDA5OjU1OjIyUE0gKzA4MDAsIFhpZSBZ
b25namkgd3JvdGU6Cj4+Pj4+Pj4+Pj4gSXQncyBub3QgcmVjb21tZW5kZWQgdG8gcHJvdmlkZSBh
biAiZW1wdHkiIHJlbGVhc2UgZnVuY3Rpb24KPj4+Pj4+Pj4+PiBmb3IgdGhlIGRldmljZSBvYmpl
Y3QgYXMgRG9jdW1lbnRhdGlvbi9jb3JlLWFwaS9rb2JqZWN0LnJzdAo+Pj4+Pj4+Pj4+IG1lbnRp
b25lZC4KPj4+Pj4+Pj4+ICJpdCBpcyBhIGJ1ZyB0byBoYXZlIGFuIGVtcHR5IHJlbGVhc2UgZnVu
Y3Rpb24iIGlzIG1vcmUgbGlrZSBpdCA6KQo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4gT0suCj4+Pj4+Pj4+
Cj4+Pj4+Pj4+Pj4gU28gbGV0J3MgYWxsb2NhdGUgdGhlIGRldmljZSBvYmplY3QgZHluYW1pY2Fs
bHkKPj4+Pj4+Pj4+PiB0byBnZXQgcmlkIG9mIGl0Lgo+Pj4+Pj4+Pj4gTXVjaCBiZXR0ZXIsIGJ1
dCBub3QgcXVpdGUgdGhlcmUsIHNlZSBiZWxvdyBmb3IgZGV0YWlscy4KPj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4gU2lnbmVkLW9mZi1ieTogWGllIFlvbmdqaSA8eGlleW9uZ2ppQGJ5dGVkYW5jZS5jb20+
Cj4+Pj4+Pj4+Pj4gLS0tCj4+Pj4+Pj4+Pj4gICBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNl
X2Rldi5jIHwgNDMgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tCj4+Pj4+Pj4+Pj4gICAx
IGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pCj4+Pj4+Pj4+
Pj4KPj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9k
ZXYuYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPj4+Pj4+Pj4+PiBpbmRl
eCAxNjBlNDBkMDMwODQuLmE4YTVlYmFlZmExMCAxMDA2NDQKPj4+Pj4+Pj4+PiAtLS0gYS9kcml2
ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4+Pj4+Pj4+Pj4gKysrIGIvZHJpdmVycy92
ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+Pj4+Pj4+Pj4+IEBAIC0xNDc1LDE1ICsxNDc1LDYg
QEAgc3RhdGljIGNoYXIgKnZkdXNlX2Rldm5vZGUoc3RydWN0IGRldmljZSAqZGV2LCB1bW9kZV90
ICptb2RlKQo+Pj4+Pj4+Pj4+ICAgICAgICByZXR1cm4ga2FzcHJpbnRmKEdGUF9LRVJORUwsICJ2
ZHVzZS8lcyIsIGRldl9uYW1lKGRldikpOwo+Pj4+Pj4+Pj4+ICAgfQo+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4gLXN0YXRpYyB2b2lkIHZkdXNlX21nbXRkZXZfcmVsZWFzZShzdHJ1Y3QgZGV2aWNlICpk
ZXYpCj4+Pj4+Pj4+Pj4gLXsKPj4+Pj4+Pj4+PiAtfQo+Pj4+Pj4+Pj4+IC0KPj4+Pj4+Pj4+PiAt
c3RhdGljIHN0cnVjdCBkZXZpY2UgdmR1c2VfbWdtdGRldiA9IHsKPj4+Pj4+Pj4+PiAtICAgICAu
aW5pdF9uYW1lID0gInZkdXNlIiwKPj4+Pj4+Pj4+PiAtICAgICAucmVsZWFzZSA9IHZkdXNlX21n
bXRkZXZfcmVsZWFzZSwKPj4+Pj4+Pj4+PiAtfTsKPj4+Pj4+Pj4+PiAtCj4+Pj4+Pj4+Pj4gICBz
dGF0aWMgc3RydWN0IHZkcGFfbWdtdF9kZXYgbWdtdF9kZXY7Cj4+Pj4+Pj4+PiBDbG9zZS4gIFRo
aXMgc2hvdWxkIGJlIGEgcG9pbnRlciBhbmQgdGhlIGRldmljZSBzdHJ1Y3R1cmUgd2l0aGluIGl0
Cj4+Pj4+Pj4+PiBzaG91bGQgY29udHJvbCB0aGUgbGlmZWN5Y2xlIG9mIHRoYXQgc3RydWN0dXJl
LiAgSXQgc2hvdWxkIG5vdCBiZSBhCj4+Pj4+Pj4+PiBzaW5nbGUgc3RhdGljIHN0cnVjdHVyZSBs
aWtlIHRoaXMsIHRoYXQncyB2ZXJ5IG9kZC4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+IE9LLCBJIGNhbiBk
ZWZpbmUgbWdtdF9kZXYgYXMgYSBwb2ludGVyLiBCdXQgdGhlIGRldmljZSBpcyBkZWZpbmVkIGFz
IGEKPj4+Pj4+Pj4gcGFyZW50IGRldmljZSBmb3Igc3RydWN0dXJlIHZkcGFfbWdtdF9kZXYuIFNv
IEkgdGhpbmsgd2UgY2FuJ3QgdXNlIGl0Cj4+Pj4+Pj4+IHRvIGNvbnRyb2wgdGhlIGxpZmVjeWNs
ZSBvZiB0aGUgc3RydWN0dXJlIHZkcGFfbWdtdF9kZXYuCj4+Pj4+Pj4gWW91IHNob3VsZCBiZSBh
YmxlIHRvIGNvbnRyb2wgdGhlIGxpZmVjeWNsZSBvZiBpdCwgZXNwZWNpYWxseSBpZiBpdCBpcwo+
Pj4+Pj4+IHRoZSBwYXJlbnQgZGV2aWNlIG9mIHNvbWV0aGluZy4gIFRvIG5vdCBkbyB0aGF0IGNv
cnJlY3RseSBpcyB0byBoYXZlCj4+Pj4+Pj4gZXZlcnl0aGluZyBtZXNzZWQgdXAgYXMgeW91IHNo
b3VsZCBiZSB1c2luZyB0aGUgZHJpdmVyIG1vZGVsIHByb3Blcmx5Lgo+Pj4+Pj4+IEFzIGl0IGlz
LCB5b3UgYXJlIG5vdCA6KAo+Pj4+Pj4+Cj4+Pj4+PiBJIGNhbiBjb250cm9sIHRoZSBsaWZlY3lj
bGUgb2YgaXQuIFdoYXQgSSBtZWFuIGlzIHRoYXQgSSBjYW4gbm90IGZyZWUKPj4+Pj4+IGl0IGlu
IHRoZSByZWxlYXNlIGZ1bmN0aW9uIG9mIHRoZSBkZXZpY2Ugb2JqZWN0IHNpbmNlIGl0IGlzIHRo
ZSBwYXJlbnQKPj4+Pj4+IGRldmljZSBvZiBtZ210X2Rldi4gRS5nLiwgaW4gb3RoZXIgY2FzZXMg
KHN1Y2ggYXMgaWZjdmZfcHJvYmUoKSksIHRoZQo+Pj4+Pj4gZGV2aWNlIG9iamVjdCBjb21lcyBm
cm9tIGEgcGNpIGRldmljZSBidXQgdGhlIHN0cnVjdHVyZSB2ZHBhX21nbXRfZGV2Cj4+Pj4+PiBp
cyBjcmVhdGVkIGR1cmluZyBkcml2ZXIgcHJvYmluZy4gVGhlIHN0cnVjdHVyZSB2ZHBhX21nbXRf
ZGV2IGp1c3QKPj4+Pj4+IG1haW50YWlucyBhIHBvaW50ZXIgdG8gdGhlIGRldmljZSBvYmplY3Qu
IFNvIHRoZSBzdHJ1Y3R1cmUKPj4+Pj4+IHZkcGFfbWdtdF9kZXYgYW5kIHRoZSBkZXZpY2Ugb2Jq
ZWN0IGhhdmUgZGlmZmVyZW50IGxpZmVjeWNsZXMuCj4+Pj4+IFRoZW4gc29tZXRoaW5nIGlzIHZl
cnkgdmVyeSB3cm9uZyBoZXJlLiAgVGhlIHN0cnVjdHVyZSdzIGxpZmVzcGFjZQo+Pj4+PiBzaG91
bGQgb25seSBiZSBjb250cm9sbGVkIGJ5IG9uZSByZWZlcmVuY2UgY291bnQsIG5vdCBtdWx0aXBs
ZSBvbmVzLgo+Pj4+IEJ1dCB0aGV5IGFyZSBkaWZmZXJlbnQgZGV2aWNlcyAob25lIGlzIHZkcGFf
bWdtdF9kZXYgYW5kIGFub3RoZXIgaXMKPj4+PiB0aGUgZGV2aWNlIEkgY3JlYXRlIHdoaWNoIHdp
bGwgYmUgdGhlIHBhcmVudCBvZiB2ZHBhX21nbXRfZGV2KSwgSQo+Pj4+IGRpZG4ndCBnZXQgd2h5
IHdlIG5lZWQgdG8gY29udHJvbCB0aGVpciBsaWZlY3ljbGUgaW4gb25lIHJlZmVyZW5jZQo+Pj4+
IGNvdW50Lgo+Pj4+Cj4+Pj4+IEhhdmUgaXQgYmUgY29udHJvbGxlZCBieSB0aGUgZGV2aWNlIHlv
dSBjcmVhdGUgYW5kIHByb3Blcmx5IHJlZ2lzdGVyIGFzCj4+Pj4+IGEgY2hpbGQgb2YgdGhlIHBj
aSBkZXZpY2UgYW5kIGFsbCBzaG91bGQgYmUgZmluZS4KPj4+Pj4KPj4+PiBUaGUgc3RydWN0dXJl
IHZkcGFfbWdtdF9kZXYgaXMgZGVmaW5lZCBhczoKPj4+Pgo+Pj4+IC8qKgo+Pj4+ICAgKiBzdHJ1
Y3QgdmRwYV9tZ210X2RldiAtIHZkcGEgbWFuYWdlbWVudCBkZXZpY2UKPj4+PiAgICogQGRldmlj
ZTogTWFuYWdlbWVudCBwYXJlbnQgZGV2aWNlCj4+Pj4gICAqIEBvcHM6IG9wZXJhdGlvbnMgc3Vw
cG9ydGVkIGJ5IG1hbmFnZW1lbnQgZGV2aWNlCj4+Pj4gICAqIEBpZF90YWJsZTogUG9pbnRlciB0
byBkZXZpY2UgaWQgdGFibGUgb2Ygc3VwcG9ydGVkIGlkcwo+Pj4+ICAgKiBAY29uZmlnX2F0dHJf
bWFzazogYml0IG1hc2sgb2YgYXR0cmlidXRlcyBvZiB0eXBlIGVudW0gdmRwYV9hdHRyIHRoYXQK
Pj4+PiAgICogICAgICAgbWFuYWdlbWVudCBkZXZpY2Ugc3VwcG9ydCBkdXJpbmcgZGV2X2FkZCBj
YWxsYmFjawo+Pj4+ICAgKiBAbGlzdDogbGlzdCBlbnRyeQo+Pj4+ICAgKi8KPj4+PiBzdHJ1Y3Qg
dmRwYV9tZ210X2RldiB7Cj4+Pj4gICAgICBzdHJ1Y3QgZGV2aWNlICpkZXZpY2U7Cj4+Pj4gICAg
ICBjb25zdCBzdHJ1Y3QgdmRwYV9tZ210ZGV2X29wcyAqb3BzOwo+Pj4+ICAgICAgY29uc3Qgc3Ry
dWN0IHZpcnRpb19kZXZpY2VfaWQgKmlkX3RhYmxlOwo+Pj4+ICAgICAgdTY0IGNvbmZpZ19hdHRy
X21hc2s7Cj4+Pj4gICAgICBzdHJ1Y3QgbGlzdF9oZWFkIGxpc3Q7Cj4+Pj4gfTsKPj4+Pgo+Pj4+
IE5vdyB0aGUgZGV2aWNlIEkgY3JlYXRlIGlzIHBhc3NlZCB0byB0aGUgc3RydWN0IHZkcGFfbWdt
dF9kZXYgYXMgYQo+Pj4+IHBhcmVudCBkZXZpY2UgcG9pbnRlci4gSWYgd2Ugd2FudCB0byBjb250
cm9sIHRoZSBsaWZlY3ljbGUgb2YgdGhlCj4+Pj4gc3RydWN0dXJlIHZkcGFfbWdtdF9kZXYgYnkg
dGhlIGRldmljZSBJIGNyZWF0ZSwgc29tZSBsb2dpYyBvZiB0aGUgdmRwYQo+Pj4+IG1hbmFnZW1l
bnQgZGV2aWNlIG5lZWRzIHRvIGJlIHJld29ya2VkLiBGb3IgZXhhbXBsZSwgZGVmaW5lIGEgZGV2
aWNlCj4+Pj4gb2JqZWN0IGZvciBzdHJ1Y3R1cmUgdmRwYV9tZ210X2RldiByYXRoZXIgdGhhbiBq
dXN0IG1haW50YWluaW5nIGEKPj4+PiBwb2ludGVyIHRvIHRoZSBwYXJlbnQgZGV2aWNlLgo+Pj4g
QnV0IHRoaXMgaXMgYSBkZXZpY2UgKGl0IHNheXMgaW4gdGhlIG5hbWUpLCBzbyBpdCBzaG91bGQg
aGF2ZSB0aGUgZGV2aWNlCj4+PiBzdHJ1Y3R1cmUgZW1iZWRkZWQgaW4gaXQgdG8gY29udHJvbCB0
aGUgbGlmZXNwYW4gb2YgaXQuCj4+Pgo+PiBDdXJyZW50bHkgaXQncyBub3QgYSBkZXZpY2UgYXMg
SmFzb24gbWVudGlvbmVkLiBTbyBJIHRoaW5rIHRoZQo+PiBxdWVzdGlvbiBpcyB3aGV0aGVyIHdl
IG5lZWQgdG8gcmUtZGVmaW5lIGl0IG9yIGp1c3QgcmUtbmFtZSBpdC4KPiBJdCBpcyBhIGRldmlj
ZSwgeW91IGhhdmUgYSBwb2ludGVyIHRvIGEgZGV2aWNlIHN0cnVjdHVyZSB0aGF0IGlzIHVzZWQg
YnkKPiB0aGUgY29kZSEKPgo+IEVtYmVkIGl0IGluIHRoZSBzdHJ1Y3R1cmUgYW5kIHlvdSBzaG91
bGQgYmUgZmluZS4gIFdlbGwsIG1heWJlLCBsZXQncwo+IHNlZSB3aGF0IGZhbGxzIG91dCBmcm9t
IHRoZXJlIGFzIGl0IHNlZW1zIGxpa2UgdGhlIHVzZSBvZiB0aGUgZHJpdmVyCj4gbW9kZWwgaXMg
YSBiaXQgbWVzc2VkIHVwIGluIHRoaXMgY29kZWJhc2UuICBCdXQgaXQncyBhIGdvb2QgZmlyc3Qg
c3RlcAo+IGZvcndhcmQgaW4gZml4aW5nIHRoaW5ncy4KCgpSaWdodCwgdGhpbmdzIGJlY2FtZSBt
ZXNzZWQgdXAgc2luY2UgdGhlIGludHJvZHVjdGlvbiBvZiB0aGUgbWdtdCBkZXZpY2UuCgpZb25n
IEppLCB3YW5kIHRvIGRvIHRoZSB3b3JrIChvciBpZiB5b3Ugd2lzaCBJIGNhbiBkbyByZXdvcmsp
PwoKVGhhbmtzCgoKPgo+IHRoYW5rcywKPgo+IGdyZWcgay1oCj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

Return-Path: <SRS0=J7vq=KX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6647C47089
	for <virtualization@archiver.kernel.org>; Fri, 28 May 2021 01:34:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B5E7613B4
	for <virtualization@archiver.kernel.org>; Fri, 28 May 2021 01:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5E7613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9524040E7F;
	Fri, 28 May 2021 01:34:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WMaRcnGPtuer; Fri, 28 May 2021 01:34:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id B293F405AA;
	Fri, 28 May 2021 01:33:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EFF3C0022;
	Fri, 28 May 2021 01:33:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B58FC000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 May 2021 01:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2A48660D88
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 May 2021 01:33:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eOwsXbehLz6R
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 May 2021 01:33:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1214C60683
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 May 2021 01:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622165634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8EflzxBdWy0wiqxEhDGP+Q2T2EKetKqpgEpZkAeYf/A=;
 b=S4yJIAdo04HShBOeEztagfuSKahh7K8Fs6P3wYnWR3yYdOQycT+MVrrAoZUfJ93bznh5cW
 JnMj6D9FZ/Zfkkw+6343e4kc/73qiP1AixXluONg6+MbYoGrOMQN2dxECYmzxslQ0tnPKU
 CoSeACifCz8qPc/Y4ykVSaIX221zrpc=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-XqQheSX7Pri-9Fu5kFCqVg-1; Thu, 27 May 2021 21:33:53 -0400
X-MC-Unique: XqQheSX7Pri-9Fu5kFCqVg-1
Received: by mail-pg1-f198.google.com with SMTP id
 b71-20020a63344a0000b029021593d6428aso1008252pga.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 18:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=8EflzxBdWy0wiqxEhDGP+Q2T2EKetKqpgEpZkAeYf/A=;
 b=FuP0rCbxbAKOBkLoZV8MTvGhmLC8Pb6/EoO0B+W687sNOSngs+qO4b+UE9XBgiJUdH
 I5oz3InOODlBTGIw8qBBoBzlkO99ZdHeRtZ0lTakdlUT4ce8Pyf6dYxpQ6Giw1A1IIB3
 9KYmS8l+HEOOhk2oh8jkZidbvWJjY0JJ3JApQX6T4XuziNkPd5Ck4Awzs0LHX06A02Yz
 datXluOhFFDhM8NJuIhTNYQWjubi3w/7MJ2Mew1h5AbCZkPhVpzwFbUp1MS5jAITNfpz
 UKM/dtEuZA7DfCWDbCbGu7J66CANqwKlmIN89h7XFvvAGLGP9k7NWkGz1FenXq9ncJCa
 im1A==
X-Gm-Message-State: AOAM5321c8RAdvETH6fvRhdugAFnbMor8J4tGf/ei45JkPIggoy8oleJ
 RSpLTyv6RWGzLjaBd5//dpltyqHPM+DSEkdJFjGz0HVIiraC8NM9Y4w1sIo0tvfb7OzBINDWmRb
 rPjnEUFwHvSL5+Y+CwgMrTN52UhgsWs6Yk8j1bhNo6A==
X-Received: by 2002:a17:90a:4d01:: with SMTP id
 c1mr1544241pjg.113.1622165632002; 
 Thu, 27 May 2021 18:33:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydC/stmtwVBAw7vn0dDxdtXv7rokRxoXkgRqgTNFUSMcTPVSj5vrj1iqRSI/twfonCL/POEw==
X-Received: by 2002:a17:90a:4d01:: with SMTP id
 c1mr1544208pjg.113.1622165631682; 
 Thu, 27 May 2021 18:33:51 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id g4sm2964265pgu.46.2021.05.27.18.33.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 May 2021 18:33:51 -0700 (PDT)
Subject: Re: [PATCH v7 11/12] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-12-xieyongji@bytedance.com>
 <3740c7eb-e457-07f3-5048-917c8606275d@redhat.com>
 <CACycT3uAqa6azso_8MGreh+quj-JXO1piuGnrV8k2kTfc34N2g@mail.gmail.com>
 <5a68bb7c-fd05-ce02-cd61-8a601055c604@redhat.com>
 <CACycT3ve7YvKF+F+AnTQoJZMPua+jDvGMs_ox8GQe_=SGdeCMA@mail.gmail.com>
 <ee00efca-b26d-c1be-68d2-f9e34a735515@redhat.com>
 <CACycT3ufok97cKpk47NjUBTc0QAyfauFUyuFvhWKmuqCGJ7zZw@mail.gmail.com>
 <00ded99f-91b6-ba92-5d92-2366b163f129@redhat.com>
 <3cc7407d-9637-227e-9afa-402b6894d8ac@redhat.com>
 <CACycT3s6SkER09KL_Ns9d03quYSKOuZwd3=HJ_s1SL7eH7y5gA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <baf0016a-7930-2ae2-399f-c28259f415c1@redhat.com>
Date: Fri, 28 May 2021 09:33:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CACycT3s6SkER09KL_Ns9d03quYSKOuZwd3=HJ_s1SL7eH7y5gA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, joro@8bytes.org,
 Randy Dunlap <rdunlap@infradead.org>, iommu@lists.linux-foundation.org,
 Matthew Wilcox <willy@infradead.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <christian.brauner@canonical.com>, bcrl@kvack.org,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
 =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
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

CuWcqCAyMDIxLzUvMjcg5LiL5Y2INjoxNCwgWW9uZ2ppIFhpZSDlhpnpgZM6Cj4gT24gVGh1LCBN
YXkgMjcsIDIwMjEgYXQgNDo0MyBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3
cm90ZToKPj4KPj4g5ZyoIDIwMjEvNS8yNyDkuIvljYg0OjQxLCBKYXNvbiBXYW5nIOWGmemBkzoK
Pj4+IOWcqCAyMDIxLzUvMjcg5LiL5Y2IMzozNCwgWW9uZ2ppIFhpZSDlhpnpgZM6Cj4+Pj4gT24g
VGh1LCBNYXkgMjcsIDIwMjEgYXQgMTo0MCBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPj4+Pj4g5ZyoIDIwMjEvNS8yNyDkuIvljYgxOjA4LCBZb25namkgWGllIOWG
memBkzoKPj4+Pj4+IE9uIFRodSwgTWF5IDI3LCAyMDIxIGF0IDE6MDAgUE0gSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4KPj4+Pj4+IHdyb3RlOgo+Pj4+Pj4+IOWcqCAyMDIxLzUvMjcg
5LiL5Y2IMTI6NTcsIFlvbmdqaSBYaWUg5YaZ6YGTOgo+Pj4+Pj4+PiBPbiBUaHUsIE1heSAyNywg
MjAyMSBhdCAxMjoxMyBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+Pj4+Pj4+
PiB3cm90ZToKPj4+Pj4+Pj4+IOWcqCAyMDIxLzUvMTcg5LiL5Y2INTo1NSwgWGllIFlvbmdqaSDl
hpnpgZM6Cj4+Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4+ICtzdGF0aWMgaW50IHZkdXNlX2Rldl9tc2df
c3luYyhzdHJ1Y3QgdmR1c2VfZGV2ICpkZXYsCj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHN0cnVjdCB2ZHVzZV9kZXZfbXNnICptc2cpCj4+Pj4+Pj4+Pj4gK3sKPj4+Pj4+
Pj4+PiArICAgICBpbml0X3dhaXRxdWV1ZV9oZWFkKCZtc2ctPndhaXRxKTsKPj4+Pj4+Pj4+PiAr
ICAgICBzcGluX2xvY2soJmRldi0+bXNnX2xvY2spOwo+Pj4+Pj4+Pj4+ICsgICAgIHZkdXNlX2Vu
cXVldWVfbXNnKCZkZXYtPnNlbmRfbGlzdCwgbXNnKTsKPj4+Pj4+Pj4+PiArICAgICB3YWtlX3Vw
KCZkZXYtPndhaXRxKTsKPj4+Pj4+Pj4+PiArICAgICBzcGluX3VubG9jaygmZGV2LT5tc2dfbG9j
ayk7Cj4+Pj4+Pj4+Pj4gKyAgICAgd2FpdF9ldmVudF9raWxsYWJsZShtc2ctPndhaXRxLCBtc2ct
PmNvbXBsZXRlZCk7Cj4+Pj4+Pj4+PiBXaGF0IGhhcHBlbnMgaWYgdGhlIHVzZXJzcGFjZShtYWxp
Y291cykgZG9lc24ndCBnaXZlIGEgcmVzcG9uc2UKPj4+Pj4+Pj4+IGZvcmV2ZXI/Cj4+Pj4+Pj4+
Pgo+Pj4+Pj4+Pj4gSXQgbG9va3MgbGlrZSBhIERPUy4gSWYgeWVzLCB3ZSBuZWVkIHRvIGNvbnNp
ZGVyIGEgd2F5IHRvIGZpeCB0aGF0Lgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4gSG93IGFib3V0IHVzaW5n
IHdhaXRfZXZlbnRfa2lsbGFibGVfdGltZW91dCgpIGluc3RlYWQ/Cj4+Pj4+Pj4gUHJvYmFibHks
IGFuZCB0aGVuIHdlIG5lZWQgY2hvb3NlIGEgc3VpdGFibGUgdGltZW91dCBhbmQgbW9yZQo+Pj4+
Pj4+IGltcG9ydGFudCwKPj4+Pj4+PiBuZWVkIHRvIHJlcG9ydCB0aGUgZmFpbHVyZSB0byB2aXJ0
aW8uCj4+Pj4+Pj4KPj4+Pj4+IE1ha2VzIHNlbnNlIHRvIG1lLiBCdXQgaXQgbG9va3MgbGlrZSBz
b21lCj4+Pj4+PiB2ZHBhX2NvbmZpZ19vcHMvdmlydGlvX2NvbmZpZ19vcHMgc3VjaCBhcyBzZXRf
c3RhdHVzKCkgZGlkbid0IGhhdmUgYQo+Pj4+Pj4gcmV0dXJuIHZhbHVlLiAgTm93IEkgYWRkIGEg
V0FSTl9PTigpIGZvciB0aGUgZmFpbHVyZS4gRG8geW91IG1lYW4gd2UKPj4+Pj4+IG5lZWQgdG8g
YWRkIHNvbWUgY2hhbmdlIGZvciB2aXJ0aW8gY29yZSB0byBoYW5kbGUgdGhlIGZhaWx1cmU/Cj4+
Pj4+IE1heWJlLCBidXQgSSdtIG5vdCBzdXJlIGhvdyBoYXJkIHdlIGNhbiBkbyB0aGF0Lgo+Pj4+
Pgo+Pj4+IFdlIG5lZWQgdG8gY2hhbmdlIGFsbCB2aXJ0aW8gZGV2aWNlIGRyaXZlcnMgaW4gdGhp
cyB3YXkuCj4+Pgo+Pj4gUHJvYmFibHkuCj4+Pgo+Pj4KPj4+Pj4gV2UgaGFkIE5FRURTX1JFU0VU
IGJ1dCBpdCBsb29rcyB3ZSBkb24ndCBpbXBsZW1lbnQgaXQuCj4+Pj4+Cj4+Pj4gQ291bGQgaXQg
aGFuZGxlIHRoZSBmYWlsdXJlIG9mIGdldF9mZWF0dXJlKCkgYW5kIGdldC9zZXRfY29uZmlnKCk/
Cj4+Pgo+Pj4gTG9va3Mgbm90Ogo+Pj4KPj4+ICIKPj4+Cj4+PiBUaGUgZGV2aWNlIFNIT1VMRCBz
ZXQgREVWSUNFX05FRURTX1JFU0VUIHdoZW4gaXQgZW50ZXJzIGFuIGVycm9yIHN0YXRlCj4+PiB0
aGF0IGEgcmVzZXQgaXMgbmVlZGVkLiBJZiBEUklWRVJfT0sgaXMgc2V0LCBhZnRlciBpdCBzZXRz
Cj4+PiBERVZJQ0VfTkVFRFNfUkVTRVQsIHRoZSBkZXZpY2UgTVVTVCBzZW5kIGEgZGV2aWNlIGNv
bmZpZ3VyYXRpb24gY2hhbmdlCj4+PiBub3RpZmljYXRpb24gdG8gdGhlIGRyaXZlci4KPj4+Cj4+
PiAiCj4+Pgo+Pj4gVGhpcyBsb29rcyBpbXBsaWVzIHRoYXQgTkVFRFNfUkVTRVQgbWF5IG9ubHkg
d29yayBhZnRlciBkZXZpY2UgaXMKPj4+IHByb2JlZC4gQnV0IGluIHRoZSBjdXJyZW50IGRlc2ln
biwgZXZlbiB0aGUgcmVzZXQoKSBpcyBub3QgcmVsaWFibGUuCj4+Pgo+Pj4KPj4+Pj4gT3IgYSBy
b3VnaCBpZGVhIGlzIHRoYXQgbWF5YmUgbmVlZCBzb21lIHJlbGF4aW5nIHRvIGJlIGNvdXBsZWQg
bG9vc2VseQo+Pj4+PiB3aXRoIHVzZXJzcGFjZS4gRS5nIHRoZSBkZXZpY2UgKGNvbnRyb2wgcGF0
aCkgaXMgaW1wbGVtZW50ZWQgaW4gdGhlCj4+Pj4+IGtlcm5lbCBidXQgdGhlIGRhdGFwYXRoIGlz
IGltcGxlbWVudGVkIGluIHRoZSB1c2Vyc3BhY2UgbGlrZSBUVU4vVEFQLgo+Pj4+Pgo+Pj4+IEkg
dGhpbmsgaXQgY2FuIHdvcmsgZm9yIG1vc3QgY2FzZXMuIE9uZSBwcm9ibGVtIGlzIHRoYXQgdGhl
IHNldF9jb25maWcKPj4+PiBtaWdodCBjaGFuZ2UgdGhlIGJlaGF2aW9yIG9mIHRoZSBkYXRhIHBh
dGggYXQgcnVudGltZSwgZS5nLgo+Pj4+IHZpcnRuZXRfc2V0X21hY19hZGRyZXNzKCkgaW4gdGhl
IHZpcnRpby1uZXQgZHJpdmVyIGFuZAo+Pj4+IGNhY2hlX3R5cGVfc3RvcmUoKSBpbiB0aGUgdmly
dGlvLWJsayBkcml2ZXIuIE5vdCBzdXJlIGlmIHRoaXMgcGF0aCBpcwo+Pj4+IGFibGUgdG8gcmV0
dXJuIGJlZm9yZSB0aGUgZGF0YXBhdGggaXMgYXdhcmUgb2YgdGhpcyBjaGFuZ2UuCj4+Pgo+Pj4g
R29vZCBwb2ludC4KPj4+Cj4+PiBCdXQgc2V0X2NvbmZpZygpIHNob3VsZCBiZSByYXJlOgo+Pj4K
Pj4+IEUuZyBpbiB0aGUgY2FzZSBvZiB2aXJ0aW8tbmV0IHdpdGggVkVSU0lPTl8xLCBjb25maWcg
c3BhY2UgaXMgcmVhZAo+Pj4gb25seSwgYW5kIGl0IHdhcyBzZXQgdmlhIGNvbnRyb2wgdnEuCj4+
Pgo+Pj4gRm9yIGJsb2NrLCB3ZSBjYW4KPj4+Cj4+PiAxKSBzdGFydCBmcm9tIHdpdGhvdXQgV0NF
IG9yCj4+PiAyKSB3ZSBhZGQgYSBjb25maWcgY2hhbmdlIG5vdGlmaWNhdGlvbiB0byB1c2Vyc3Bh
Y2Ugb3IKPj4+IDMpIGV4dGVuZCB0aGUgc3BlYyB0byB1c2UgdnEgaW5zdGVhZCBvZiBjb25maWcg
c3BhY2UKPj4+Cj4+PiBUaGFua3MKPj4KPj4gQW5vdGhlciB0aGluZyBpZiB3ZSB3YW50IHRvIGdv
IHRoaXMgd2F5Ogo+Pgo+PiBXZSBuZWVkIGZpbmQgYSB3YXkgdG8gdGVybWluYXRlIHRoZSBkYXRh
IHBhdGggZnJvbSB0aGUga2VybmVsIHNpZGUsIHRvCj4+IGltcGxlbWVudCB0byByZXNldCBzZW1h
bnRpYy4KPj4KPiBEbyB5b3UgbWVhbiB0ZXJtaW5hdGUgdGhlIGRhdGEgcGF0aCBpbiB2ZHBhX3Jl
c2V0KCkuCgoKWWVzLgoKCj4gICBJcyBpdCBvayB0byBqdXN0Cj4gbm90aWZ5IHVzZXJzcGFjZSB0
byBzdG9wIGRhdGEgcGF0aCBhc3luY2hyb25vdXNseT8KCgpGb3Igd2VsbC1iZWhhdmVkIHVzZXJz
cGFjZSwgeWVzIGJ1dCBubyBmb3IgYnVnZ3kgb3IgbWFsaWNpb3VzIG9uZXMuCgpJIGhhZCBhbiBp
ZGVhLCBob3cgYWJvdXQgdGVybWluYXRlIElPVExCIGluIHRoaXMgY2FzZT8gVGhlbiB3ZSdyZSBp
biAKZmFjdCB0dXJuIGRhdGFwYXRoIG9mZi4KClRoYW5rcwoKCj4gICBVc2Vyc3BhY2Ugc2hvdWxk
Cj4gbm90IGJlIGFibGUgdG8gZG8gYW55IEkvTyBhdCB0aGF0IHRpbWUgYmVjYXVzZSB0aGUgaW90
bGIgbWFwcGluZyBpcwo+IGFscmVhZHkgcmVtb3ZlZC4KPgo+IFRoYW5rcywKPiBZb25namkKPgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u

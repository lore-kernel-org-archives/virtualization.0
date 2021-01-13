Return-Path: <SRS0=6FxZ=GQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB38C433E0
	for <virtualization@archiver.kernel.org>; Wed, 13 Jan 2021 14:40:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A86722343B
	for <virtualization@archiver.kernel.org>; Wed, 13 Jan 2021 14:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86722343B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 35DCA2E0E3;
	Wed, 13 Jan 2021 14:40:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Syx4aw4HiypI; Wed, 13 Jan 2021 14:40:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2A5ED2D059;
	Wed, 13 Jan 2021 14:40:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A59CC088B;
	Wed, 13 Jan 2021 14:40:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FDEDC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 14:40:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 898AF84070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 14:40:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tX7geV3nzv6S
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 14:40:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5EECA841AC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 14:40:11 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id y8so1174779plp.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 06:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2ujGnSKYEthvi0rZ2iClFRGUsHpgEMsu727w+G030VY=;
 b=KUPL716HUHhkSt/RjEEjpWlYVDKM/abejwsbcqehL7DCSQm+pJqoncUorlVw/OV54k
 YViU+8HHMxFP67B4XdlZeuFHhKN8LFgxxyAuzbMhI/TONKoL8kkMF1z2PUJzY2Z+Gzd3
 6FVdE8sdiBLfF+nzsTAeDoSVodGoWs6pbHJdyHrDWIya8fLkDBpMubiZhda8l6YVYSQL
 TQ6gMvrlDp0E9Pb02g8KV/58eBqEYu+BKtSUdEXFQfnPiTe80AhbbzV2fj9dw+KuF5nx
 E8XWoEDWqy7jLDC+GnO6H3xkacv1NVRiFqCnTzYxIU/DjZQs+qOL0hVLJ+Us+11Zm6ot
 B0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2ujGnSKYEthvi0rZ2iClFRGUsHpgEMsu727w+G030VY=;
 b=PLnhTVPEqMHoiB3oKyKLCrERhJUC9D2jLO0xsAe/4xpmoSPsGa6NszpswN5N094yf/
 L4v+lDhRKekr8dGkeFxIIG2a/Pt24Wk3AwPUzAHo7kaUg4ZQcn/hUeobzAcLD5tfDNZf
 ih26FzyyTdRuImXgUBVU5j1csBrGJY2a/GXCgPn6VaeD5BfVay3W7SVUzDpcVjjpxibC
 gMoKwIGm4zpmW7uEtHOWssWMk02+r1orRbALt8EDPiRSSARLT5R0wLRW+9409iqBfICZ
 sjQlRXnhNenJZ7bCEX1l5AlY+HghI3Gw65XlPrqlSyJDbY9hGmWluw7FTbLHERzTs6zl
 J0LA==
X-Gm-Message-State: AOAM533FAQ7mL/4qwWKqk79F8TrsE5QiWVDJT7kPmST50C1GZDY+MCfg
 EVbX3PT7zSnKaZcspkoHDJ923YddgeU=
X-Google-Smtp-Source: ABdhPJwN4FfSjFH93GkGBWxS+czVke7jQTBXXJJWKTWPrtC7QhbAjm2b5y86ieX+9gPJfbNEIc8r3Q==
X-Received: by 2002:a17:90a:74cd:: with SMTP id
 p13mr2701552pjl.25.1610548810338; 
 Wed, 13 Jan 2021 06:40:10 -0800 (PST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com.
 [209.85.214.174])
 by smtp.gmail.com with ESMTPSA id k18sm3119389pjz.26.2021.01.13.06.40.09
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 06:40:10 -0800 (PST)
Received: by mail-pl1-f174.google.com with SMTP id t6so1189183plq.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 06:40:09 -0800 (PST)
X-Received: by 2002:a67:bd0a:: with SMTP id y10mr2141127vsq.28.1610548441862; 
 Wed, 13 Jan 2021 06:34:01 -0800 (PST)
MIME-Version: 1.0
References: <20210112194143.1494-1-yuri.benditovich@daynix.com>
 <CAOEp5OejaX4ZETThrj4-n8_yZoeTZs56CBPHbQqNsR2oni8dWw@mail.gmail.com>
 <CAOEp5Oc5qif_krU8oC6qhq6X0xRW-9GpWrBzWgPw0WevyhT8Mg@mail.gmail.com>
 <CA+FuTSfhBZfEf8+LKNUJQpSxt8c5h1wMpARupekqFKuei6YBsA@mail.gmail.com>
 <78bbc518-4b73-4629-68fb-2713250f8967@redhat.com>
In-Reply-To: <78bbc518-4b73-4629-68fb-2713250f8967@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 13 Jan 2021 09:33:25 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfJJhEYr6gXmjpjjXzg6Xm5wWa-dL1SEV-Zt7RcPXGztg@mail.gmail.com>
Message-ID: <CA+FuTSfJJhEYr6gXmjpjjXzg6Xm5wWa-dL1SEV-Zt7RcPXGztg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Support for virtio-net hash reporting
To: Jason Wang <jasowang@redhat.com>
Cc: Song Liu <songliubraving@fb.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Yan Vugenfirer <yan@daynix.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Daniel Borkmann <daniel@iogearbox.net>, decui@microsoft.com,
 Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
 Paolo Abeni <pabeni@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Marco Elver <elver@google.com>, KP Singh <kpsingh@kernel.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, cai@lca.pw,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 Jakub Sitnicki <jakub@cloudflare.com>,
 Network Development <netdev@vger.kernel.org>, rdunlap@infradead.org,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, bpf <bpf@vger.kernel.org>,
 Martin KaFai Lau <kafai@fb.com>
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

T24gVHVlLCBKYW4gMTIsIDIwMjEgYXQgMTE6MTEgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPgo+IE9uIDIwMjEvMS8xMyDkuIrljYg3OjQ3LCBXaWxsZW0gZGUg
QnJ1aWpuIHdyb3RlOgo+ID4gT24gVHVlLCBKYW4gMTIsIDIwMjEgYXQgMzoyOSBQTSBZdXJpIEJl
bmRpdG92aWNoCj4gPiA8eXVyaS5iZW5kaXRvdmljaEBkYXluaXguY29tPiB3cm90ZToKPiA+PiBP
biBUdWUsIEphbiAxMiwgMjAyMSBhdCA5OjQ5IFBNIFl1cmkgQmVuZGl0b3ZpY2gKPiA+PiA8eXVy
aS5iZW5kaXRvdmljaEBkYXluaXguY29tPiB3cm90ZToKPiA+Pj4gT24gVHVlLCBKYW4gMTIsIDIw
MjEgYXQgOTo0MSBQTSBZdXJpIEJlbmRpdG92aWNoCj4gPj4+IDx5dXJpLmJlbmRpdG92aWNoQGRh
eW5peC5jb20+IHdyb3RlOgo+ID4+Pj4gRXhpc3RpbmcgVFVOIG1vZHVsZSBpcyBhYmxlIHRvIHVz
ZSBwcm92aWRlZCAic3RlZXJpbmcgZUJQRiIgdG8KPiA+Pj4+IGNhbGN1bGF0ZSBwZXItcGFja2V0
IGhhc2ggYW5kIGRlcml2ZSB0aGUgZGVzdGluYXRpb24gcXVldWUgdG8KPiA+Pj4+IHBsYWNlIHRo
ZSBwYWNrZXQgdG8uIFRoZSBlQlBGIHVzZXMgbWFwcGVkIGNvbmZpZ3VyYXRpb24gZGF0YQo+ID4+
Pj4gY29udGFpbmluZyBhIGtleSBmb3IgaGFzaCBjYWxjdWxhdGlvbiBhbmQgaW5kaXJlY3Rpb24g
dGFibGUKPiA+Pj4+IHdpdGggYXJyYXkgb2YgcXVldWVzJyBpbmRpY2VzLgo+ID4+Pj4KPiA+Pj4+
IFRoaXMgc2VyaWVzIG9mIHBhdGNoZXMgYWRkcyBzdXBwb3J0IGZvciB2aXJ0aW8tbmV0IGhhc2gg
cmVwb3J0aW5nCj4gPj4+PiBmZWF0dXJlIGFzIGRlZmluZWQgaW4gdmlydGlvIHNwZWNpZmljYXRp
b24uIEl0IGV4dGVuZHMgdGhlIFRVTiBtb2R1bGUKPiA+Pj4+IGFuZCB0aGUgInN0ZWVyaW5nIGVC
UEYiIGFzIGZvbGxvd3M6Cj4gPj4+Pgo+ID4+Pj4gRXh0ZW5kZWQgc3RlZXJpbmcgZUJQRiBjYWxj
dWxhdGVzIHRoZSBoYXNoIHZhbHVlIGFuZCBoYXNoIHR5cGUsIGtlZXBzCj4gPj4+PiBoYXNoIHZh
bHVlIGluIHRoZSBza2ItPmhhc2ggYW5kIHJldHVybnMgaW5kZXggb2YgZGVzdGluYXRpb24gdmly
dHF1ZXVlCj4gPj4+PiBhbmQgdGhlIHR5cGUgb2YgdGhlIGhhc2guIFRVTiBtb2R1bGUga2VlcHMg
cmV0dXJuZWQgaGFzaCB0eXBlIGluCj4gPj4+PiAoY3VycmVudGx5IHVudXNlZCkgZmllbGQgb2Yg
dGhlIHNrYi4KPiA+Pj4+IHNrYi0+X191bnVzZWQgcmVuYW1lZCB0byAnaGFzaF9yZXBvcnRfdHlw
ZScuCj4gPj4+Pgo+ID4+Pj4gV2hlbiBUVU4gbW9kdWxlIGlzIGNhbGxlZCBsYXRlciB0byBhbGxv
Y2F0ZSBhbmQgZmlsbCB0aGUgdmlydGlvLW5ldAo+ID4+Pj4gaGVhZGVyIGFuZCBwdXNoIGl0IHRv
IGRlc3RpbmF0aW9uIHZpcnRxdWV1ZSBpdCBwb3B1bGF0ZXMgdGhlIGhhc2gKPiA+Pj4+IGFuZCB0
aGUgaGFzaCB0eXBlIGludG8gdmlydGlvLW5ldCBoZWFkZXIuCj4gPj4+Pgo+ID4+Pj4gVkhPU1Qg
ZHJpdmVyIGlzIG1hZGUgYXdhcmUgb2YgcmVzcGVjdGl2ZSB2aXJ0aW8tbmV0IGZlYXR1cmUgdGhh
dAo+ID4+Pj4gZXh0ZW5kcyB0aGUgdmlydGlvLW5ldCBoZWFkZXIgdG8gcmVwb3J0IHRoZSBoYXNo
IHZhbHVlIGFuZCBoYXNoIHJlcG9ydAo+ID4+Pj4gdHlwZS4KPiA+Pj4gQ29tbWVudCBmcm9tIFdp
bGxlbSBkZSBCcnVpam46Cj4gPj4+Cj4gPj4+IFNrYnVmZiBmaWVsZHMgYXJlIGluIHNob3J0IHN1
cHBseS4gSSBkb24ndCB0aGluayB3ZSBuZWVkIHRvIGFkZCBvbmUKPiA+Pj4ganVzdCBmb3IgdGhp
cyBuYXJyb3cgcGF0aCBlbnRpcmVseSBpbnRlcm5hbCB0byB0aGUgdHVuIGRldmljZS4KPiA+Pj4K
PiA+PiBXZSB1bmRlcnN0YW5kIHRoYXQgYW5kIHRyeSB0byBtaW5pbWl6ZSB0aGUgaW1wYWN0IGJ5
IHVzaW5nIGFuIGFscmVhZHkKPiA+PiBleGlzdGluZyB1bnVzZWQgZmllbGQgb2Ygc2tiLgo+ID4g
Tm90IGFueW1vcmUuIEl0IHdhcyByZXB1cnBvc2VkIGFzIGEgZmxhZ3MgZmllbGQgdmVyeSByZWNl
bnRseS4KPiA+Cj4gPiBUaGlzIHVzZSBjYXNlIGlzIGFsc28gdmVyeSBuYXJyb3cgaW4gc2NvcGUu
IEFuZCBhIHZlcnkgc2hvcnQgcGF0aCBmcm9tCj4gPiBkYXRhIHByb2R1Y2VyIHRvIGNvbnN1bWVy
LiBTbyBJIGRvbid0IHRoaW5rIGl0IG5lZWRzIHRvIGNsYWltIHNjYXJjZQo+ID4gYml0cyBpbiB0
aGUgc2tiLgo+ID4KPiA+IHR1bl9lYnBmX3NlbGVjdF9xdWV1ZSBzdG9yZXMgdGhlIGZpZWxkLCB0
dW5fcHV0X3VzZXIgcmVhZHMgaXQgYW5kCj4gPiBjb252ZXJ0cyBpdCB0byB0aGUgdmlydGlvX25l
dF9oZHIgaW4gdGhlIGRlc2NyaXB0b3IuCj4gPgo+ID4gdHVuX2VicGZfc2VsZWN0X3F1ZXVlIGlz
IGNhbGxlZCBmcm9tIC5uZG9fc2VsZWN0X3F1ZXVlLiAgU3RvcmluZyB0aGUKPiA+IGZpZWxkIGlu
IHNrYi0+Y2IgaXMgZnJhZ2lsZSwgYXMgaW4gdGhlb3J5IHNvbWUgY29kZSBjb3VsZCBvdmVyd3Jp
dGUKPiA+IHRoYXQgYmV0d2VlbiBmaWVsZCBiZXR3ZWVuIG5kb19zZWxlY3RfcXVldWUgYW5kCj4g
PiBuZG9fc3RhcnRfeG1pdC90dW5fbmV0X3htaXQsIGZyb20gd2hpY2ggcG9pbnQgaXQgaXMgZnVs
bHkgdW5kZXIgdHVuCj4gPiBjb250cm9sIGFnYWluLiBCdXQgaW4gcHJhY3RpY2UsIEkgZG9uJ3Qg
YmVsaWV2ZSBhbnl0aGluZyBkb2VzLgo+ID4KPiA+IEFsdGVybmF0aXZlbHkgYW4gZXhpc3Rpbmcg
c2tiIGZpZWxkIHRoYXQgaXMgdXNlZCBvbmx5IG9uIGRpc2pvaW50Cj4gPiBkYXRhcGF0aHMsIHN1
Y2ggYXMgaW5ncmVzcy1vbmx5LCBjb3VsZCBiZSB2aWFibGUuCj4KPgo+IEEgcXVlc3Rpb24gaGVy
ZS4gV2UgaGFkIG1ldGFkYXRhIHN1cHBvcnQgaW4gWERQIGZvciBjb29wZXJhdGlvbiBiZXR3ZWVu
Cj4gZUJQRiBwcm9ncmFtcy4gRG8gd2UgaGF2ZSBzb21ldGhpbmcgc2ltaWxhciBpbiB0aGUgc2ti
Pwo+Cj4gRS5nIGluIHRoZSBSU1MsIGlmIHdlIHdhbnQgdG8gcGFzcyBzb21lIG1ldGFkYXRhIGlu
Zm9ybWF0aW9uIGJldHdlZW4KPiBlQlBGIHByb2dyYW0gYW5kIHRoZSBsb2dpYyB0aGF0IGdlbmVy
YXRlcyB0aGUgdm5ldCBoZWFkZXIgKGVpdGhlciBoYXJkCj4gbG9naWMgaW4gdGhlIGtlcm5lbCBv
ciBhbm90aGVyIGVCUEYgcHJvZ3JhbSkuIElzIHRoZXJlIGFueSB3YXkgdGhhdCBjYW4KPiBhdm9p
ZCB0aGUgcG9zc2libGUgY29uZmxpY3RzIG9mIHFkaXNjcz8KCk5vdCB0aGF0IEkgYW0gYXdhcmUg
b2YuIFRoZSBjbG9zZXN0IHRoaW5nIGlzIGNiW10uCgpJdCdsbCBoYXZlIHRvIGFsaWFzZSBhIGZp
ZWxkIGxpa2UgdGhhdCwgdGhhdCBpcyBrbm93biB1bnVzZWQgZm9yIHRoZSBnaXZlbiBwYXRoLgoK
T25lIG90aGVyIGFwcHJvYWNoIHRoYXQgaGFzIGJlZW4gdXNlZCB3aXRoaW4gbGluZWFyIGNhbGwg
c3RhY2tzIGlzIG91dApvZiBiYW5kLiBMaWtlIHBlcmNwdSB2YXJpYWJsZXMgc29mdG5ldF9kYXRh
LnhtaXQubW9yZSBhbmQKbWlycmVkX3JlY19sZXZlbC4gQnV0IHRoYXQgaXMgcGVyaGFwcyBhIGJp
dCBvdmVyd3JvdWdodCBmb3IgdGhpcyB1c2UKY2FzZS4KCj4gPgo+ID4+PiBJbnN0ZWFkLCB5b3Ug
Y291bGQganVzdCBydW4gdGhlIGZsb3dfZGlzc2VjdG9yIGluIHR1bl9wdXRfdXNlciBpZiB0aGUK
PiA+Pj4gZmVhdHVyZSBpcyBuZWdvdGlhdGVkLiBJbmRlZWQsIHRoZSBmbG93IGRpc3NlY3RvciBz
ZWVtcyBtb3JlIGFwdCB0byBtZQo+ID4+PiB0aGFuIEJQRiBoZXJlLiBOb3RlIHRoYXQgdGhlIGZs
b3cgZGlzc2VjdG9yIGludGVybmFsbHkgY2FuIGJlCj4gPj4+IG92ZXJyaWRkZW4gYnkgYSBCUEYg
cHJvZ3JhbSBpZiB0aGUgYWRtaW4gc28gY2hvb3Nlcy4KPiA+Pj4KPiA+PiBXaGVuIHRoaXMgc2V0
IG9mIHBhdGNoZXMgaXMgcmVsYXRlZCB0byBoYXNoIGRlbGl2ZXJ5IGluIHRoZSB2aXJ0aW8tbmV0
Cj4gPj4gcGFja2V0IGluIGdlbmVyYWwsCj4gPj4gaXQgd2FzIHByZXBhcmVkIGluIGNvbnRleHQg
b2YgUlNTIGZlYXR1cmUgaW1wbGVtZW50YXRpb24gYXMgZGVmaW5lZCBpbgo+ID4+IHZpcnRpbyBz
cGVjIFsxXQo+ID4+IEluIGNhc2Ugb2YgUlNTIGl0IGlzIG5vdCBlbm91Z2ggdG8gcnVuIHRoZSBm
bG93X2Rpc3NlY3RvciBpbiB0dW5fcHV0X3VzZXI6Cj4gPj4gaW4gdHVuX2VicGZfc2VsZWN0X3F1
ZXVlIHRoZSBUVU4gY2FsbHMgZUJQRiB0byBjYWxjdWxhdGUgdGhlIGhhc2gsCj4gPj4gaGFzaCB0
eXBlIGFuZCBxdWV1ZSBpbmRleAo+ID4+IGFjY29yZGluZyB0byB0aGUgKG1hcHBlZCkgcGFyYW1l
dGVycyAoa2V5LCBoYXNoIHR5cGVzLCBpbmRpcmVjdGlvbgo+ID4+IHRhYmxlKSByZWNlaXZlZCBm
cm9tIHRoZSBndWVzdC4KPiA+IFRVTlNFVFNURUVSSU5HRUJQRiB3YXMgYWRkZWQgdG8gc3VwcG9y
dCBtb3JlIGRpdmVyc2UgcXVldWUgc2VsZWN0aW9uCj4gPiB0aGFuIHRoZSBkZWZhdWx0IGluIGNh
c2Ugb2YgbXVsdGlxdWV1ZSB0dW4uIE5vdCBzdXJlIHdoYXQgdGhlIGV4YWN0Cj4gPiB1c2UgY2Fz
ZXMgYXJlLgo+ID4KPiA+IEJ1dCBSU1MgaXMgZXhhY3RseSB0aGUgcHVycG9zZSBvZiB0aGUgZmxv
dyBkaXNzZWN0b3IuIEl0IGlzIHVzZWQgZm9yCj4gPiB0aGF0IHB1cnBvc2UgaW4gdGhlIHNvZnR3
YXJlIHZhcmlhbnQgUlBTLiBUaGUgZmxvdyBkaXNzZWN0b3IKPiA+IGltcGxlbWVudHMgYSBzdXBl
cnNldCBvZiB0aGUgUlNTIHNwZWMsIGFuZCBjZXJ0YWlubHkgY29tcHV0ZXMgYQo+ID4gZm91ci10
dXBsZSBmb3IgVENQL0lQdjYuIEluIHRoZSBjYXNlIG9mIFJQUywgaXQgaXMgc2tpcHBlZCBpZiB0
aGUgTklDCj4gPiBoYXMgYWxyZWFkeSBjb21wdXRlZCBhIDQtdHVwbGUgaGFzaC4KPiA+Cj4gPiBX
aGF0IGl0IGRvZXMgbm90IGdpdmUgaXMgYSB0eXBlIGluZGljYXRpb24sIHN1Y2ggYXMKPiA+IFZJ
UlRJT19ORVRfSEFTSF9UWVBFX1RDUHY2LiBJIGRvbid0IHVuZGVyc3RhbmQgaG93IHRoaXMgd291
bGQgYmUgdXNlZC4KPiA+IEluIGRhdGFwYXRocyB3aGVyZSB0aGUgTklDIGhhcyBhbHJlYWR5IGNv
bXB1dGVkIHRoZSBmb3VyLXR1cGxlIGhhc2gKPiA+IGFuZCBzdG9yZWQgaXQgaW4gc2tiLT5oYXNo
IC0tdGhlIGNvbW1vbiBjYXNlIGZvciBzZXJ2ZXJzLS0sIFRoYXQgdHlwZQo+ID4gZmllbGQgaXMg
dGhlIG9ubHkgcmVhc29uIHRvIGhhdmUgdG8gY29tcHV0ZSBhZ2Fpbi4KPgo+Cj4gVGhlIHByb2Js
ZW0gaXMgdGhlcmUncyBubyBndWFyYW50ZWUgdGhhdCB0aGUgcGFja2V0IGNvbWVzIGZyb20gdGhl
IE5JQywKPiBpdCBjb3VsZCBiZSBhIHNpbXBsZSBWTTJWTSBvciBob3N0MlZNIHBhY2tldC4KPgo+
IEFuZCBldmVuIGlmIHRoZSBwYWNrZXQgaXMgY29taW5nIGZyb20gdGhlIE5JQyB0aGF0IGNhbGN1
bGF0ZXMgdGhlIGhhc2gKPiB0aGVyZSdzIG5vIGd1YXJhbnRlZSB0aGF0IGl0J3MgdGhlIGhhcyB0
aGF0IGd1ZXN0IHdhbnQgKGd1ZXN0IG1heSB1c2UKPiBkaWZmZXJlbnQgUlNTIGtleXMpLgoKQWgg
eWVzLCBvZiBjb3Vyc2UuCgpJIHdvdWxkIHN0aWxsIHJldmlzaXQgdGhlIG5lZWQgdG8gc3RvcmUg
YSBkZXRhaWxlZCBoYXNoX3R5cGUgYWxvbmcgd2l0aAp0aGUgaGFzaCwgYXMgYXMgZmFyIEkgY2Fu
IHRlbGwgdGhhdCBjb252ZXlzIG5vIGFjdGlvbmFibGUgaW5mb3JtYXRpb24KdG8gdGhlIGd1ZXN0
LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=

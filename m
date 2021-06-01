Return-Path: <SRS0=ZGfu=K3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C1AC47082
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 03:27:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2F7A611CA
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 03:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F7A611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B62D60810;
	Tue,  1 Jun 2021 03:27:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P4MS5_PqLsnr; Tue,  1 Jun 2021 03:27:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id DEDC8606B8;
	Tue,  1 Jun 2021 03:27:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF52AC000D;
	Tue,  1 Jun 2021 03:27:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CF00C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 03:27:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2445183C7E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 03:27:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LHr-T4bR-GC5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 03:27:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 53DD683C7C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 03:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622518045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KSGfV7SHW5dFZw9CK2SCDtuEH742HZRbhMdLwIKQRSk=;
 b=EYynlMh782LzGGI0Xtr5spjhwvM/irAsB0BLdRW3aq2yAElPJTVbEV3VBAm/tOQRI+i4Tj
 GWTPhTp3cECDMc8SfewNb8I0WAFAfFuCIbWKniR+dH5cJ5tWtibP9nv5pQ2V0xe2j3Ywgq
 NVBA3k4GLQwTvuIIffEiPpppvOwaYJY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-LHvQqViFO8-UbSQ0fKt8Fg-1; Mon, 31 May 2021 23:27:23 -0400
X-MC-Unique: LHvQqViFO8-UbSQ0fKt8Fg-1
Received: by mail-pg1-f200.google.com with SMTP id
 x29-20020a634a1d0000b029021b9c79b0a1so8136353pga.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 20:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=KSGfV7SHW5dFZw9CK2SCDtuEH742HZRbhMdLwIKQRSk=;
 b=g9hQ4OqCifJotZLH1xQFKE4txxmYl7Znob7GxC8tYuVoQnL7MztxfKR7Eh57sZxuIE
 po52L0cKY2FYqoT2r2mA3ciiTEdKt0iZCb1wzu4s1mKhZKzfHNAY+FIF1w+ySyWvShhP
 a5DSem0x/nlAq9B+RIKmWLj9Ugib6QXEVdEXPDEe/c2AO00PHcwHTY7b2bEjdpRjG/zO
 2/JKYWV06gmF2BmsLvElR0dhmYTojAquXZN1C+0RTOGiDVRn5hpdhUZcyBy6WNfTzjyy
 BxYPtP1DTjDVtbkcIjTPxJ3knAeAbQ0+DW4aGYdEa1WBR2SToLCMKHEJmKfAbV/2qndT
 9mTA==
X-Gm-Message-State: AOAM530uJrYGN9yeZOvn6u4ud2rBD1KUh4sxZ3aNeBwcKeD7g7qpZe9T
 +Ce806+7+KKAYzr6v2Lfj5KYEGylrabtFftK2WrCaGYR1/OJQo3LgSU3qyHvlqYJtlai7zhys0W
 SjamsxiCHWrP6gAbkSR5WXHllR/rcAVDLKPvG4OsHpg==
X-Received: by 2002:a17:90b:3593:: with SMTP id
 mm19mr2360902pjb.28.1622518042375; 
 Mon, 31 May 2021 20:27:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysrflVyzdes+pZMBaRr43Z/Iz21+sNG4jTK7VeN3rudVuxOkzevkr4aXEVtgN284SLiLD/sA==
X-Received: by 2002:a17:90b:3593:: with SMTP id
 mm19mr2360881pjb.28.1622518042052; 
 Mon, 31 May 2021 20:27:22 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j4sm667960pjv.7.2021.05.31.20.27.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 May 2021 20:27:21 -0700 (PDT)
Subject: Re: [PATCH net 2/2] virtio-net: get build_skb() buf by data ptr
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1622516885.7439268-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <93f79b8b-62c3-60f0-b401-0908e3e6325f@redhat.com>
Date: Tue, 1 Jun 2021 11:27:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1622516885.7439268-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
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

CuWcqCAyMDIxLzYvMSDkuIrljYgxMTowOCwgWHVhbiBaaHVvIOWGmemBkzoKPiBPbiBUdWUsIDEg
SnVuIDIwMjEgMTE6MDM6MzcgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
IHdyb3RlOgo+PiDlnKggMjAyMS81LzMxIOS4i+WNiDY6NTgsIFh1YW4gWmh1byDlhpnpgZM6Cj4+
PiBPbiBNb24sIDMxIE1heSAyMDIxIDE0OjEwOjU1ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tPiB3cm90ZToKPj4+PiDlnKggMjAyMS81LzE0IOS4i+WNiDExOjE2LCBYdWFu
IFpodW8g5YaZ6YGTOgo+Pj4+PiBJbiB0aGUgY2FzZSBvZiBtZXJnZSwgdGhlIHBhZ2UgcGFzc2Vk
IGludG8gcGFnZV90b19za2IoKSBtYXkgYmUgYSBoZWFkCj4+Pj4+IHBhZ2UsIG5vdCB0aGUgcGFn
ZSB3aGVyZSB0aGUgY3VycmVudCBkYXRhIGlzIGxvY2F0ZWQuCj4+Pj4gSSBkb24ndCBnZXQgaG93
IHRoaXMgY2FuIGhhcHBlbj8KPj4+Pgo+Pj4+IE1heWJlIHlvdSBjYW4gZXhwbGFpbiBhIGxpdHRs
ZSBiaXQgbW9yZT8KPj4+Pgo+Pj4+IHJlY2VpdmVfbWVyZ2VhYmxlKCkgY2FsbCBwYWdlX3RvX3Nr
YigpIGluIHR3byBwbGFjZXM6Cj4+Pj4KPj4+PiAxKSBYRFBfUEFTUyBmb3IgbGluZWFyaXplZCBw
YWdlICwgaW4gdGhpcyBjYXNlIHdlIHVzZSB4ZHBfcGFnZQo+Pj4+IDIpIHBhZ2VfdG9fc2tiKCkg
Zm9yICJub3JtYWwiIHBhZ2UsIGluIHRoaXMgY2FzZSB0aGUgcGFnZSBjb250YWlucyB0aGUgZGF0
YQo+Pj4gVGhlIG9mZnNldCBtYXkgYmUgZ3JlYXRlciB0aGFuIFBBR0VfU0laRSwgYmVjYXVzZSBw
YWdlIGlzIG9idGFpbmVkIGJ5Cj4+PiB2aXJ0X3RvX2hlYWRfcGFnZSgpLCBub3QgdGhlIHBhZ2Ug
d2hlcmUgYnVmIGlzIGxvY2F0ZWQuIEFuZCAib2Zmc2V0IiBpcyB0aGUgb2Zmc2V0Cj4+PiBvZiBi
dWYgcmVsYXRpdmUgdG8gcGFnZS4KPj4+Cj4+PiAJdGFpbHJvb20gPSB0cnVlc2l6ZSAtIGxlbiAt
IG9mZnNldDsKPj4+Cj4+PiBJbiB0aGlzIGNhc2UsIHRoZSB0YWlscm9vbSBtdXN0IGJlIGxlc3Mg
dGhhbiAwLiBBbHRob3VnaCB0aGVyZSBtYXkgYmUgZW5vdWdoCj4+PiBjb250ZW50IG9uIHRoaXMg
cGFnZSB0byBzYXZlIHNrYl9zaGFyZWRfaW5mby4KPj4KPj4gSW50ZXJlc3RpbmcsIEkgdGhpbmsg
d2UgZG9uJ3QgdXNlIGNvbXBvdW5kIHBhZ2VzIGZvciB2aXJ0aW8tbmV0LiAoV2UKPj4gZG9uJ3Qg
ZGVmaW5lIFNLQl9GUkFHX1BBR0VfT1JERVIpLgo+Pgo+PiBBbSBJIHdyb25nPwo+Cj4gSXQgc2Vl
bXMgdG8gbWUgdGhhdCBpdCBzZWVtcyB0byBiZSBhIGZpeGVkIHNldHRpbmcsIG5vdCBmb3IgdXMg
dG8gY29uZmlndXJlCj4gaW5kZXBlbmRlbnRseQoKCkxvb2tzIGxpa2UgeW91IGFyZSByaWdodC4K
ClNlZSBjb21tZW50cyBiZWxvdy4KCgo+Cj4gVGhhbmtzLgo+Cj4gPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09Cj4KPiBuZXQvc29jay5jCj4KPiAjZGVmaW5lIFNLQl9G
UkFHX1BBR0VfT1JERVIJZ2V0X29yZGVyKDMyNzY4KQo+IERFRklORV9TVEFUSUNfS0VZX0ZBTFNF
KG5ldF9oaWdoX29yZGVyX2FsbG9jX2Rpc2FibGVfa2V5KTsKPgo+IC8qKgo+ICAgKiBza2JfcGFn
ZV9mcmFnX3JlZmlsbCAtIGNoZWNrIHRoYXQgYSBwYWdlX2ZyYWcgY29udGFpbnMgZW5vdWdoIHJv
b20KPiAgICogQHN6OiBtaW5pbXVtIHNpemUgb2YgdGhlIGZyYWdtZW50IHdlIHdhbnQgdG8gZ2V0
Cj4gICAqIEBwZnJhZzogcG9pbnRlciB0byBwYWdlX2ZyYWcKPiAgICogQGdmcDogcHJpb3JpdHkg
Zm9yIG1lbW9yeSBhbGxvY2F0aW9uCj4gICAqCj4gICAqIE5vdGU6IFdoaWxlIHRoaXMgYWxsb2Nh
dG9yIHRyaWVzIHRvIHVzZSBoaWdoIG9yZGVyIHBhZ2VzLCB0aGVyZSBpcwo+ICAgKiBubyBndWFy
YW50ZWUgdGhhdCBhbGxvY2F0aW9ucyBzdWNjZWVkLiBUaGVyZWZvcmUsIEBzeiBNVVNUIGJlCj4g
ICAqIGxlc3Mgb3IgZXF1YWwgdGhhbiBQQUdFX1NJWkUuCj4gICAqLwo+IGJvb2wgc2tiX3BhZ2Vf
ZnJhZ19yZWZpbGwodW5zaWduZWQgaW50IHN6LCBzdHJ1Y3QgcGFnZV9mcmFnICpwZnJhZywgZ2Zw
X3QgZ2ZwKQo+IHsKPiAJaWYgKHBmcmFnLT5wYWdlKSB7Cj4gCQlpZiAocGFnZV9yZWZfY291bnQo
cGZyYWctPnBhZ2UpID09IDEpIHsKPiAJCQlwZnJhZy0+b2Zmc2V0ID0gMDsKPiAJCQlyZXR1cm4g
dHJ1ZTsKPiAJCX0KPiAJCWlmIChwZnJhZy0+b2Zmc2V0ICsgc3ogPD0gcGZyYWctPnNpemUpCj4g
CQkJcmV0dXJuIHRydWU7Cj4gCQlwdXRfcGFnZShwZnJhZy0+cGFnZSk7Cj4gCX0KPgo+IAlwZnJh
Zy0+b2Zmc2V0ID0gMDsKPiAJaWYgKFNLQl9GUkFHX1BBR0VfT1JERVIgJiYKPiAJICAgICFzdGF0
aWNfYnJhbmNoX3VubGlrZWx5KCZuZXRfaGlnaF9vcmRlcl9hbGxvY19kaXNhYmxlX2tleSkpIHsK
PiAJCS8qIEF2b2lkIGRpcmVjdCByZWNsYWltIGJ1dCBhbGxvdyBrc3dhcGQgdG8gd2FrZSAqLwo+
IAkJcGZyYWctPnBhZ2UgPSBhbGxvY19wYWdlcygoZ2ZwICYgfl9fR0ZQX0RJUkVDVF9SRUNMQUlN
KSB8Cj4gCQkJCQkgIF9fR0ZQX0NPTVAgfCBfX0dGUF9OT1dBUk4gfAo+IAkJCQkJICBfX0dGUF9O
T1JFVFJZLAo+IAkJCQkJICBTS0JfRlJBR19QQUdFX09SREVSKTsKPiAJCWlmIChsaWtlbHkocGZy
YWctPnBhZ2UpKSB7Cj4gCQkJcGZyYWctPnNpemUgPSBQQUdFX1NJWkUgPDwgU0tCX0ZSQUdfUEFH
RV9PUkRFUjsKPiAJCQlyZXR1cm4gdHJ1ZTsKPiAJCX0KPiAJfQo+IAlwZnJhZy0+cGFnZSA9IGFs
bG9jX3BhZ2UoZ2ZwKTsKPiAJaWYgKGxpa2VseShwZnJhZy0+cGFnZSkpIHsKPiAJCXBmcmFnLT5z
aXplID0gUEFHRV9TSVpFOwo+IAkJcmV0dXJuIHRydWU7Cj4gCX0KPiAJcmV0dXJuIGZhbHNlOwo+
IH0KPiBFWFBPUlRfU1lNQk9MKHNrYl9wYWdlX2ZyYWdfcmVmaWxsKTsKPgo+Cj4+IFRoYW5rcwo+
Pgo+Pgo+Pj4gVGhhbmtzLgo+Pj4KPj4+PiBUaGFua3MKPj4+Pgo+Pj4+Cj4+Pj4+IFNvIHdoZW4g
dHJ5aW5nIHRvCj4+Pj4+IGdldCB0aGUgYnVmIHdoZXJlIHRoZSBkYXRhIGlzIGxvY2F0ZWQsIHlv
dSBzaG91bGQgZGlyZWN0bHkgdXNlIHRoZQo+Pj4+PiBwb2ludGVyKHApIHRvIGdldCB0aGUgYWRk
cmVzcyBjb3JyZXNwb25kaW5nIHRvIHRoZSBwYWdlLgo+Pj4+Pgo+Pj4+PiBBdCB0aGUgc2FtZSB0
aW1lLCB0aGUgb2Zmc2V0IG9mIHRoZSBkYXRhIGluIHRoZSBwYWdlIHNob3VsZCBhbHNvIGJlCj4+
Pj4+IG9idGFpbmVkIHVzaW5nIG9mZnNldF9pbl9wYWdlKCkuCj4+Pj4+Cj4+Pj4+IFRoaXMgcGF0
Y2ggc29sdmVzIHRoaXMgcHJvYmxlbS4gQnV0IGlmIHlvdSBkb27igJl0IHVzZSB0aGlzIHBhdGNo
LCB0aGUKPj4+Pj4gb3JpZ2luYWwgY29kZSBjYW4gYWxzbyBydW4sIGJlY2F1c2UgaWYgdGhlIHBh
Z2UgaXMgbm90IHRoZSBwYWdlIG9mIHRoZQo+Pj4+PiBjdXJyZW50IGRhdGEsIHRoZSBjYWxjdWxh
dGVkIHRhaWxyb29tIHdpbGwgYmUgbGVzcyB0aGFuIDAsIGFuZCB3aWxsIG5vdAo+Pj4+PiBlbnRl
ciB0aGUgbG9naWMgb2YgYnVpbGRfc2tiKCkgLiBUaGUgc2lnbmlmaWNhbmNlIG9mIHRoaXMgcGF0
Y2ggaXMgdG8KPj4+Pj4gbW9kaWZ5IHRoaXMgbG9naWNhbCBwcm9ibGVtLCBhbGxvd2luZyBtb3Jl
IHNpdHVhdGlvbnMgdG8gdXNlCj4+Pj4+IGJ1aWxkX3NrYigpLgo+Pj4+Pgo+Pj4+PiBTaWduZWQt
b2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+Pj4+PiBBY2tl
ZC1ieTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPj4+Pj4gLS0tCj4+Pj4+
ICAgICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCA4ICsrKysrKy0tCj4+Pj4+ICAgICAxIGZp
bGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pj4+Pgo+Pj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4+Pj4+IGluZGV4IDNlNDZjMTJkZGUwOC4uMDczZmVjNGMwZGYxIDEwMDY0NAo+Pj4+
PiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+Pj4gKysrIGIvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jCj4+Pj4+IEBAIC00MDcsOCArNDA3LDEyIEBAIHN0YXRpYyBzdHJ1Y3Qgc2tf
YnVmZiAqcGFnZV90b19za2Ioc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4+Pj4+ICAgICAJCSAq
IHNlZSBhZGRfcmVjdmJ1Zl9tZXJnZWFibGUoKSArIGdldF9tZXJnZWFibGVfYnVmX2xlbigpCj4+
Pj4+ICAgICAJCSAqLwo+Pj4+PiAgICAgCQl0cnVlc2l6ZSA9IFBBR0VfU0laRTsKPj4+Pj4gLQkJ
dGFpbHJvb20gPSB0cnVlc2l6ZSAtIGxlbiAtIG9mZnNldDsKPj4+Pj4gLQkJYnVmID0gcGFnZV9h
ZGRyZXNzKHBhZ2UpOwo+Pj4+PiArCj4+Pj4+ICsJCS8qIHBhZ2UgbWF5YmUgaGVhZCBwYWdlLCBz
byB3ZSBzaG91bGQgZ2V0IHRoZSBidWYgYnkgcCwgbm90IHRoZQo+Pj4+PiArCQkgKiBwYWdlCj4+
Pj4+ICsJCSAqLwo+Pj4+PiArCQl0YWlscm9vbSA9IHRydWVzaXplIC0gbGVuIC0gb2Zmc2V0X2lu
X3BhZ2UocCk7CgoKSSB3b25kZXIgd2h5IG9mZnNldF9pbl9wYWdlKHApIGlzIGNvcnJlY3Q/IEkg
Z3Vlc3MgaXQgc2hvdWxkIGJlOgoKdGFpbHJvb20gPSB0cnVlc2l6ZSAtIGxlbiAtIGhlYWRyb29t
OwoKVGhlIHJlYXNvbiBpcyB0aGF0IHRoZSBidWZmZXIgaXMgbm90IG5lY2Vzc2FyaWx5IGFsbG9j
YXRlZCBhdCB0aGUgcGFnZSAKYm91bmRhcnkuCgpUaGFua3MKCgo+Pj4+PiArCQlidWYgPSAoY2hh
ciAqKSgodW5zaWduZWQgbG9uZylwICYgUEFHRV9NQVNLKTsKPj4+Pj4gICAgIAl9IGVsc2Ugewo+
Pj4+PiAgICAgCQl0YWlscm9vbSA9IHRydWVzaXplIC0gbGVuOwo+Pj4+PiAgICAgCQlidWYgPSBw
OwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u

Return-Path: <SRS0=j1Zo=K2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A54C47082
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 06:44:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A981C61220
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 06:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A981C61220
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A74E827C5;
	Mon, 31 May 2021 06:44:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EODVJvESWaPG; Mon, 31 May 2021 06:44:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD7FE82505;
	Mon, 31 May 2021 06:44:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E9C3C000E;
	Mon, 31 May 2021 06:44:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B2E4C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 06:44:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2C39C8254A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 06:44:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MGZ9TXcEturZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 06:44:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1B67A82505
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 06:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622443483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SUaSuygZibRbIXo2WqN5Ex4ftPJcRx59Uhx8TtNHYWQ=;
 b=I5QCBLEXMi5Dmqu9gglFhuM8fnEEJ/guYt5uJ5auCj5j61HMAE8v7U3gaWVHz0Qnejsh2T
 Zmkll4MGZgiMKVHrFkiqwU0U3JcBj8bbTXsI5ojIONwG0lbK9mHLzb+OQP/zDCgGgqc8C0
 f8/86TCUFf2OzrAvL4V93QjZ90B1oVg=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-WO-oDsBJNfSSNiXvEtjsuQ-1; Mon, 31 May 2021 02:44:40 -0400
X-MC-Unique: WO-oDsBJNfSSNiXvEtjsuQ-1
Received: by mail-pg1-f198.google.com with SMTP id
 a10-20020a65418a0000b029021b78388f57so6666847pgq.15
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 23:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=SUaSuygZibRbIXo2WqN5Ex4ftPJcRx59Uhx8TtNHYWQ=;
 b=B0whtRz//Kpt3tdue1YBX7Txqk0jdM5oBQVkMBTZ79lnxbHG0DVqu6QlllATmsnblN
 eZqHxKoVa5aYHl9jikbOrFE74oD0L/f9RNFSkrCKSO+iMzFBU0xel6WG6H1OeL93AmLH
 i2jpsPemqCawk9p1E516nYCI2wibn4tmdQ3Aa5x+KlkeIwDPThf/hSibiLqrWMM0G10m
 NzmfL02Hzy+q8LFlHQdB3WH9vsEszAS9t3vgFcYlNHU7HbDk+J1QnZ0AW4CqSmfTBEZq
 Y5M0jI/lG8/ISMlTStkL624C4fv29NzwkGoNmmKvhqbFaXW373dmuzX9PdnhL7vlaB5U
 f8NQ==
X-Gm-Message-State: AOAM533YLpnogIDt9e/k8p5ZXKb/0+uaP2peiVVrnSmBuvyJewo2wmQY
 fIko3dPDcwHh0u/KaxMWH9WykopknL8zdRXR1aMoyGsiRWMvV3y5kq3zYb9et3a93MyA/nHN24Y
 JSD1V9Q/ypOfVIdkk0hTxI2bHhC1b5PzmZPwqrFxFqA==
X-Received: by 2002:a65:5684:: with SMTP id v4mr20716482pgs.218.1622443479537; 
 Sun, 30 May 2021 23:44:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpfywURmpQK3qDRNW85wBFBQSUdZKWt/D1g3uaED+Wsy/u7Ad8Q8SY34NgN/HEhXWXj30lAA==
X-Received: by 2002:a65:5684:: with SMTP id v4mr20716472pgs.218.1622443479280; 
 Sun, 30 May 2021 23:44:39 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id v6sm11475580pgk.33.2021.05.30.23.44.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 May 2021 23:44:38 -0700 (PDT)
Subject: Re: [PATCH 2/2] vdpa/mlx5: Add support for running with virtio_vdpa
To: Eli Cohen <elic@nvidia.com>
References: <20210530075415.4644-1-elic@nvidia.com>
 <20210530075415.4644-3-elic@nvidia.com>
 <9b130015-d116-7fb0-1b86-2604353a2283@redhat.com>
 <20210531051308.GC158940@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a2f13f08-7e50-1fb3-3367-1b03f80af6ac@redhat.com>
Date: Mon, 31 May 2021 14:44:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210531051308.GC158940@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

CuWcqCAyMDIxLzUvMzEg5LiL5Y2IMToxMywgRWxpIENvaGVuIOWGmemBkzoKPiBPbiBNb24sIE1h
eSAzMSwgMjAyMSBhdCAxMToxNjoxMUFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiDlnKgg
MjAyMS81LzMwIOS4i+WNiDM6NTQsIEVsaSBDb2hlbiDlhpnpgZM6Cj4+PiBJbiBvcmRlciB0byBz
dXBwb3J0IHJ1bm5pbmcgdmRwYSB1c2luZyB2cml0aW9fdmRwYSBkcml2ZXIsIHdlIG5lZWQgIHRv
Cj4+PiBjcmVhdGUgYSBkaWZmZXJlbnQga2luZCBvZiBNUiwgb25lIHRoYXQgaGFzIDE6MSBtYXBw
aW5nLCBzaW5jZSB0aGUKPj4+IGFkZHJlc3NlcyByZWZlcnJpbmcgdG8gdmlydHF1ZXVlcyBhcmUg
ZG1hIGFkZHJlc3Nlcy4KPj4+Cj4+PiBXZSBjcmVhdGUgdGhlIDE6MSBNUiBpbiBtbHg1X3ZkcGFf
ZGV2X2FkZCgpIG9ubHkgaW4gY2FzZSBmaXJtd2FyZQo+Pj4gc3VwcG9ydHMgdGhlIGdlbmVyYWwg
Y2FwYWJpbGl0eSB1bWVtX3VpZF8wLiBUaGUgcmVhc29uIGZvciB0aGF0IGlzIHRoYXQKPj4+IDE6
MSBNUnMgbXVzdCBiZSBjcmVhdGVkIHdpdGggdWlkID09IDAgd2hpbGUgdmlydHF1ZXVlIG9iamVj
dHMgY2FuIGJlCj4+PiBjcmVhdGVkIHdpdGggdWlkID09IDAgb25seSB3aGVuIHRoZSBmaXJtd2Fy
ZSBjYXBhYmlsaXR5IGlzIG9uLgo+Pj4KPj4+IElmIHRoZSBzZXRfbWFwKCkgY2FsbGJhY2sgaXMg
Y2FsbGVkIHdpdGggbmV3IHRyYW5zbGF0aW9ucyBwcm92aWRlZAo+Pj4gdGhyb3VnaCBpb3RsYiwg
dGhlIGRyaXZlciB3aWxsIGRlc3Ryb3kgdGhlIDE6MSBNUiBhbmQgY3JlYXRlIGEgcmVndWxhcgo+
Pj4gb25lLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29t
Pgo+Pj4gLS0tCj4+PiAgICBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oIHwgIDEg
Kwo+Pj4gICAgZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jICAgICAgICB8IDgxICsrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLQo+Pj4gICAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVf
dm5ldC5jICB8IDEzICsrKystCj4+PiAgICAzIGZpbGVzIGNoYW5nZWQsIDgwIGluc2VydGlvbnMo
KyksIDE1IGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4
NS9jb3JlL21seDVfdmRwYS5oIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaAo+
Pj4gaW5kZXggYjZjYzUzYmE5ODBjLi4wOWExNmEzZDFiMmEgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2
ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oCj4+PiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4
NS9jb3JlL21seDVfdmRwYS5oCj4+PiBAQCAtMzUsNiArMzUsNyBAQCBzdHJ1Y3QgbWx4NV92ZHBh
X21yIHsKPj4+ICAgIAkvKiBzZXJpYWxpemUgbWtleSBjcmVhdGlvbiBhbmQgZGVzdHJ1Y3Rpb24g
Ki8KPj4+ICAgIAlzdHJ1Y3QgbXV0ZXggbWtleV9tdHg7Cj4+PiArCWJvb2wgdXNlcl9tcjsKPj4+
ICAgIH07Cj4+PiAgICBzdHJ1Y3QgbWx4NV92ZHBhX3Jlc291cmNlcyB7Cj4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9t
ci5jCj4+PiBpbmRleCA4MDBjZmQxOTY3YWQuLjAyMGMwY2U0ZDIwMyAxMDA2NDQKPj4+IC0tLSBh
L2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYwo+Pj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUv
Y29yZS9tci5jCj4+PiBAQCAtMzYwLDcgKzM2MCw3IEBAIHN0YXRpYyBpbnQgYWRkX2RpcmVjdF9j
aGFpbihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHU2NCBzdGFydCwgdTY0IHNpemUsIHU4
Cj4+PiAgICAgKiBpbmRpcmVjdCBtZW1vcnkga2V5IHRoYXQgcHJvdmlkZXMgYWNjZXNzIHRvIHRo
ZSBlbml0cmUgYWRkcmVzcyBzcGFjZSBnaXZlbgo+Pj4gICAgICogYnkgaW90bGIuCj4+PiAgICAg
Ki8KPj4+IC1zdGF0aWMgaW50IF9tbHg1X3ZkcGFfY3JlYXRlX21yKHN0cnVjdCBtbHg1X3ZkcGFf
ZGV2ICptdmRldiwgc3RydWN0IHZob3N0X2lvdGxiICppb3RsYikKPj4+ICtzdGF0aWMgaW50IGNy
ZWF0ZV91c2VyX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgc3RydWN0IHZob3N0X2lv
dGxiICppb3RsYikKPj4+ICAgIHsKPj4+ICAgIAlzdHJ1Y3QgbWx4NV92ZHBhX21yICptciA9ICZt
dmRldi0+bXI7Cj4+PiAgICAJc3RydWN0IG1seDVfdmRwYV9kaXJlY3RfbXIgKmRtcjsKPj4+IEBA
IC0zNzQsOSArMzc0LDYgQEAgc3RhdGljIGludCBfbWx4NV92ZHBhX2NyZWF0ZV9tcihzdHJ1Y3Qg
bWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0cnVjdCB2aG9zdF9pb3RsYgo+Pj4gICAgCWludCBlcnIg
PSAwOwo+Pj4gICAgCWludCBubnVsczsKPj4+IC0JaWYgKG1yLT5pbml0aWFsaXplZCkKPj4+IC0J
CXJldHVybiAwOwo+Pj4gLQo+Pj4gICAgCUlOSVRfTElTVF9IRUFEKCZtci0+aGVhZCk7Cj4+PiAg
ICAJZm9yIChtYXAgPSB2aG9zdF9pb3RsYl9pdHJlZV9maXJzdChpb3RsYiwgc3RhcnQsIGxhc3Qp
OyBtYXA7Cj4+PiAgICAJICAgICBtYXAgPSB2aG9zdF9pb3RsYl9pdHJlZV9uZXh0KG1hcCwgc3Rh
cnQsIGxhc3QpKSB7Cj4+PiBAQCAtNDE0LDcgKzQxMSw3IEBAIHN0YXRpYyBpbnQgX21seDVfdmRw
YV9jcmVhdGVfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCBzdHJ1Y3Qgdmhvc3RfaW90
bGIKPj4+ICAgIAlpZiAoZXJyKQo+Pj4gICAgCQlnb3RvIGVycl9jaGFpbjsKPj4+IC0JbXItPmlu
aXRpYWxpemVkID0gdHJ1ZTsKPj4+ICsJbXItPnVzZXJfbXIgPSB0cnVlOwo+Pj4gICAgCXJldHVy
biAwOwo+Pj4gICAgZXJyX2NoYWluOgo+Pj4gQEAgLTQyNiwzMyArNDIzLDg5IEBAIHN0YXRpYyBp
bnQgX21seDVfdmRwYV9jcmVhdGVfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCBzdHJ1
Y3Qgdmhvc3RfaW90bGIKPj4+ICAgIAlyZXR1cm4gZXJyOwo+Pj4gICAgfQo+Pj4gLWludCBtbHg1
X3ZkcGFfY3JlYXRlX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgc3RydWN0IHZob3N0
X2lvdGxiICppb3RsYikKPj4+ICtzdGF0aWMgaW50IGNyZWF0ZV9kbWFfbXIoc3RydWN0IG1seDVf
dmRwYV9kZXYgKm12ZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX21yICptcikKPj4+ICt7Cj4+PiArCWlu
dCBpbmxlbiA9IE1MWDVfU1RfU1pfQllURVMoY3JlYXRlX21rZXlfaW4pOwo+Pj4gKwl2b2lkICpt
a2M7Cj4+PiArCXUzMiAqaW47Cj4+PiArCWludCBlcnI7Cj4+PiArCj4+PiArCWluID0ga3phbGxv
YyhpbmxlbiwgR0ZQX0tFUk5FTCk7Cj4+PiArCWlmICghaW4pCj4+PiArCQlyZXR1cm4gLUVOT01F
TTsKPj4+ICsKPj4+ICsJbWtjID0gTUxYNV9BRERSX09GKGNyZWF0ZV9ta2V5X2luLCBpbiwgbWVt
b3J5X2tleV9ta2V5X2VudHJ5KTsKPj4+ICsKPj4+ICsJTUxYNV9TRVQobWtjLCBta2MsIGFjY2Vz
c19tb2RlXzFfMCwgTUxYNV9NS0NfQUNDRVNTX01PREVfUEEpOwo+Pj4gKwlNTFg1X1NFVChta2Ms
IG1rYywgbGVuZ3RoNjQsIDEpOwo+Pj4gKwlNTFg1X1NFVChta2MsIG1rYywgbHcsIDEpOwo+Pj4g
KwlNTFg1X1NFVChta2MsIG1rYywgbHIsIDEpOwo+Pj4gKwlNTFg1X1NFVChta2MsIG1rYywgcGQs
IG12ZGV2LT5yZXMucGRuKTsKPj4+ICsJTUxYNV9TRVQobWtjLCBta2MsIHFwbiwgMHhmZmZmZmYp
Owo+Pj4gKwo+Pj4gKwllcnIgPSBtbHg1X3ZkcGFfY3JlYXRlX21rZXkobXZkZXYsICZtci0+bWtl
eSwgaW4sIGlubGVuKTsKPj4+ICsJa2ZyZWUoaW4pOwo+Pj4gKwlyZXR1cm4gZXJyOwo+Pj4gK30K
Pj4+ICsKPj4+ICtzdGF0aWMgdm9pZCBkZXN0cm95X2RtYV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2Rl
diAqbXZkZXYsIHN0cnVjdCBtbHg1X3ZkcGFfbXIgKm1yKQo+Pj4gK3sKPj4+ICsJbWx4NV92ZHBh
X2Rlc3Ryb3lfbWtleShtdmRldiwgJm1yLT5ta2V5KTsKPj4+ICt9Cj4+PiArCj4+PiArc3RhdGlj
IGludCBfbWx4NV92ZHBhX2NyZWF0ZV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0
cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIpCj4+PiAgICB7Cj4+PiAgICAJc3RydWN0IG1seDVfdmRw
YV9tciAqbXIgPSAmbXZkZXYtPm1yOwo+Pj4gICAgCWludCBlcnI7Cj4+PiAtCW11dGV4X2xvY2so
Jm1yLT5ta2V5X210eCk7Cj4+PiArCWlmIChtci0+aW5pdGlhbGl6ZWQpCj4+PiArCQlyZXR1cm4g
MDsKPj4+ICsKPj4+ICsJaWYgKGlvdGxiKQo+Pj4gKwkJZXJyID0gY3JlYXRlX3VzZXJfbXIobXZk
ZXYsIGlvdGxiKTsKPj4+ICsJZWxzZQo+Pj4gKwkJZXJyID0gY3JlYXRlX2RtYV9tcihtdmRldiwg
bXIpOwo+Pgo+PiBEbyB3ZSBuZWVkIHRvIHNldCB1c2VyX21yIHRvIGZhbHNlIGhlcmU/Cj4gSSB0
aGluayB0aGUgcmlnaHQgcGxhY2UgdG8gZG8gdGhpcyBzaG91bGQgYmUgaW5zaWRlIGNyZWF0ZV9k
bWFfbXIoKSwgdGhlCj4gc2FtZSBhcyB3ZSBzZXQgaXQgdHJ1ZSBpbiAoKS4KCgpGaW5lLgoKCj4+
Cj4+PiArCj4+PiArCW1yLT5pbml0aWFsaXplZCA9IHRydWU7Cj4+PiArCXJldHVybiBlcnI7Cj4+
PiArfQo+Pj4gKwo+Pj4gK2ludCBtbHg1X3ZkcGFfY3JlYXRlX21yKHN0cnVjdCBtbHg1X3ZkcGFf
ZGV2ICptdmRldiwgc3RydWN0IHZob3N0X2lvdGxiICppb3RsYikKPj4+ICt7Cj4+PiArCWludCBl
cnI7Cj4+PiArCj4+PiArCW11dGV4X2xvY2soJm12ZGV2LT5tci5ta2V5X210eCk7Cj4+PiAgICAJ
ZXJyID0gX21seDVfdmRwYV9jcmVhdGVfbXIobXZkZXYsIGlvdGxiKTsKPj4+IC0JbXV0ZXhfdW5s
b2NrKCZtci0+bWtleV9tdHgpOwo+Pj4gKwltdXRleF91bmxvY2soJm12ZGV2LT5tci5ta2V5X210
eCk7Cj4+PiAgICAJcmV0dXJuIGVycjsKPj4+ICAgIH0KPj4+IC12b2lkIG1seDVfdmRwYV9kZXN0
cm95X21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldikKPj4+ICtzdGF0aWMgdm9pZCBkZXN0
cm95X3VzZXJfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCBzdHJ1Y3QgbWx4NV92ZHBh
X21yICptcikKPj4+ICAgIHsKPj4+IC0Jc3RydWN0IG1seDVfdmRwYV9tciAqbXIgPSAmbXZkZXYt
Pm1yOwo+Pj4gICAgCXN0cnVjdCBtbHg1X3ZkcGFfZGlyZWN0X21yICpkbXI7Cj4+PiAgICAJc3Ry
dWN0IG1seDVfdmRwYV9kaXJlY3RfbXIgKm47Cj4+PiAtCW11dGV4X2xvY2soJm1yLT5ta2V5X210
eCk7Cj4+PiAtCWlmICghbXItPmluaXRpYWxpemVkKQo+Pj4gLQkJZ290byBvdXQ7Cj4+PiAtCj4+
PiAgICAJZGVzdHJveV9pbmRpcmVjdF9rZXkobXZkZXYsIG1yKTsKPj4+ICAgIAlsaXN0X2Zvcl9l
YWNoX2VudHJ5X3NhZmVfcmV2ZXJzZShkbXIsIG4sICZtci0+aGVhZCwgbGlzdCkgewo+Pj4gICAg
CQlsaXN0X2RlbF9pbml0KCZkbXItPmxpc3QpOwo+Pj4gICAgCQl1bm1hcF9kaXJlY3RfbXIobXZk
ZXYsIGRtcik7Cj4+PiAgICAJCWtmcmVlKGRtcik7Cj4+PiAgICAJfQo+Pj4gK30KPj4+ICsKPj4+
ICt2b2lkIG1seDVfdmRwYV9kZXN0cm95X21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldikK
Pj4+ICt7Cj4+PiArCXN0cnVjdCBtbHg1X3ZkcGFfbXIgKm1yID0gJm12ZGV2LT5tcjsKPj4+ICsK
Pj4+ICsJbXV0ZXhfbG9jaygmbXItPm1rZXlfbXR4KTsKPj4+ICsJaWYgKCFtci0+aW5pdGlhbGl6
ZWQpCj4+PiArCQlnb3RvIG91dDsKPj4+ICsKPj4+ICsJaWYgKG1yLT51c2VyX21yKQo+Pj4gKwkJ
ZGVzdHJveV91c2VyX21yKG12ZGV2LCBtcik7Cj4+PiArCWVsc2UKPj4+ICsJCWRlc3Ryb3lfZG1h
X21yKG12ZGV2LCBtcik7Cj4+PiArCj4+PiAgICAJbWVtc2V0KG1yLCAwLCBzaXplb2YoKm1yKSk7
Cj4+PiAgICAJbXItPmluaXRpYWxpemVkID0gZmFsc2U7Cj4+PiAgICBvdXQ6Cj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21s
eDUvbmV0L21seDVfdm5ldC5jCj4+PiBpbmRleCBmZGYzZTc0YmZmYmQuLmYxNjc1NjY2MWMxOSAx
MDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4gKysr
IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+PiBAQCAtMTc4MCw2ICsxNzgw
LDggQEAgc3RhdGljIHZvaWQgbWx4NV92ZHBhX3NldF9zdGF0dXMoc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZGV2LCB1OCBzdGF0dXMpCj4+PiAgICAJCW5kZXYtPm12ZGV2LnN0YXR1cyA9IDA7Cj4+PiAg
ICAJCW5kZXYtPm12ZGV2Lm1seF9mZWF0dXJlcyA9IDA7Cj4+PiAgICAJCSsrbXZkZXYtPmdlbmVy
YXRpb247Cj4+PiArCQlpZiAoTUxYNV9DQVBfR0VOKG12ZGV2LT5tZGV2LCB1bWVtX3VpZF8wKSkK
Pj4+ICsJCQltbHg1X3ZkcGFfY3JlYXRlX21yKG12ZGV2LCBOVUxMKTsKPj4KPj4gSSB3b25kZXIg
aWYgaXQncyBwb3NzaWJsZS93b3J0aCB0byBhdm9pZCB0aGUgZGVzdHJveSBhbmQgcmUtY3JlYXRl
IG9mIGRtYSBNUgo+PiBoZXJlLiAoSW4gdGhlIGNhc2Ugb2YgaXQgaGFzIGJlZW4gdXNlZCBieSB1
cykuCj4gSWYgaXQgaXMgYSB1c2VyIE1SLCB5b3UgbXVzdCBkZXN0cm95IGl0IHNpbmNlIGl0IGlz
IHVzZWxlc3MuIElmIGl0J3MKPiBETUEgTVIsIHlvdSBtaWdodCBiZSBhYmxlIHRvIGRvIGl0IGJ1
dCBzaW5jZSB0aGUgRE1BIE1SJ3MgYXJlCj4gbGlnaHR3ZWlnaHQsIEkgZG9uJ3QgdGhpbmsgaXQn
cyB3b3J0aCBpdC4KCgpZZXMsIEkgYWdyZWUuCgpUaGFua3MKCgo+Cj4+IFRoYW5rcwo+Pgo+Pgo+
Pj4gICAgCQlyZXR1cm47Cj4+PiAgICAJfQo+Pj4gQEAgLTE4NTksNiArMTg2MSw3IEBAIHN0YXRp
YyB2b2lkIG1seDVfdmRwYV9mcmVlKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldikKPj4+ICAgIAlu
ZGV2ID0gdG9fbWx4NV92ZHBhX25kZXYobXZkZXYpOwo+Pj4gICAgCWZyZWVfcmVzb3VyY2VzKG5k
ZXYpOwo+Pj4gKwltbHg1X3ZkcGFfZGVzdHJveV9tcihtdmRldik7Cj4+PiAgICAJbWx4NV92ZHBh
X2ZyZWVfcmVzb3VyY2VzKCZuZGV2LT5tdmRldik7Cj4+PiAgICAJbXV0ZXhfZGVzdHJveSgmbmRl
di0+cmVzbG9jayk7Cj4+PiAgICB9Cj4+PiBAQCAtMjAyMyw5ICsyMDI2LDE1IEBAIHN0YXRpYyBp
bnQgbWx4NV92ZHBhX2Rldl9hZGQoc3RydWN0IHZkcGFfbWdtdF9kZXYgKnZfbWRldiwgY29uc3Qg
Y2hhciAqbmFtZSkKPj4+ICAgIAlpZiAoZXJyKQo+Pj4gICAgCQlnb3RvIGVycl9tdHU7Cj4+PiAr
CWlmIChNTFg1X0NBUF9HRU4obXZkZXYtPm1kZXYsIHVtZW1fdWlkXzApKSB7Cj4+PiArCQllcnIg
PSBtbHg1X3ZkcGFfY3JlYXRlX21yKG12ZGV2LCBOVUxMKTsKPj4+ICsJCWlmIChlcnIpCj4+PiAr
CQkJZ290byBlcnJfcmVzOwo+Pj4gKwl9Cj4+PiArCj4+PiAgICAJZXJyID0gYWxsb2NfcmVzb3Vy
Y2VzKG5kZXYpOwo+Pj4gICAgCWlmIChlcnIpCj4+PiAtCQlnb3RvIGVycl9yZXM7Cj4+PiArCQln
b3RvIGVycl9tcjsKPj4+ICAgIAltdmRldi0+dmRldi5tZGV2ID0gJm1ndGRldi0+bWd0ZGV2Owo+
Pj4gICAgCWVyciA9IF92ZHBhX3JlZ2lzdGVyX2RldmljZSgmbXZkZXYtPnZkZXYsIDIgKiBtbHg1
X3ZkcGFfbWF4X3FwcyhtYXhfdnFzKSk7Cj4+PiBAQCAtMjAzNyw2ICsyMDQ2LDggQEAgc3RhdGlj
IGludCBtbHg1X3ZkcGFfZGV2X2FkZChzdHJ1Y3QgdmRwYV9tZ210X2RldiAqdl9tZGV2LCBjb25z
dCBjaGFyICpuYW1lKQo+Pj4gICAgZXJyX3JlZzoKPj4+ICAgIAlmcmVlX3Jlc291cmNlcyhuZGV2
KTsKPj4+ICtlcnJfbXI6Cj4+PiArCW1seDVfdmRwYV9kZXN0cm95X21yKG12ZGV2KTsKPj4+ICAg
IGVycl9yZXM6Cj4+PiAgICAJbWx4NV92ZHBhX2ZyZWVfcmVzb3VyY2VzKCZuZGV2LT5tdmRldik7
Cj4+PiAgICBlcnJfbXR1OgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

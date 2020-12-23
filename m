Return-Path: <SRS0=+X4x=F3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E3FC433E0
	for <virtualization@archiver.kernel.org>; Wed, 23 Dec 2020 13:49:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD0420771
	for <virtualization@archiver.kernel.org>; Wed, 23 Dec 2020 13:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD0420771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1295A22B25;
	Wed, 23 Dec 2020 13:49:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 08ttl36lAR4B; Wed, 23 Dec 2020 13:49:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1294720408;
	Wed, 23 Dec 2020 13:49:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC1B8C1825;
	Wed, 23 Dec 2020 13:49:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42B54C0893
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 13:49:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0C99020408
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 13:49:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cf39EqV9YuXq
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 13:49:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by silver.osuosl.org (Postfix) with ESMTPS id A3C8E203E2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 13:49:12 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id n26so22886321eju.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 05:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kDoBl5kU7Uu0Oj9/VHW59eqfYVVogbWtg6TAfuelOT4=;
 b=d/91sDdmpZPQFWzTl8F0ahMMmMRudzBe8ccDSqM9uQnMHNRW8ZAQ7/tbq6b0jOYUUd
 AUtnzZEz9up0A5OJdTS8ldALNVgz1ITWGsXgEWyEqIs34kSZulHfIaXTa/9YewhtoDMT
 tjn0JNgopMuVE87XZ1tSJorwZd97oFRBlNgmcEoovO5Z53USYJtxLnQ/p+F64zPlqabX
 CpBG+qxPjiaaSnP8MYYxGA4D01k5//CY3llLclOfm2Xd4IrOvB+/S7kVXV9bnxvEDM3M
 zcxjMbr/K/HbXOkk8fDj7+JU1EhrMRsO2HeKjJgo8PVtptYoo5W8vI8h2y8oXfpxwAT6
 a1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kDoBl5kU7Uu0Oj9/VHW59eqfYVVogbWtg6TAfuelOT4=;
 b=AMSkCAv7RkxnX8XXhrUAMxMvc82VXy8sXMYB6T9iZ5UZddcmo6jyLBK60S3ZgiXOOi
 keWZkvo1fuOt+DCBHYMSVWr306ocMSUrj8FGO7ZN+KzlW8pP2ITKB8OmjMDwWQhltZOV
 4A54zIPvIeRRsNo4dhV4wJbnbGXh+TSa0WniFQll3qy5UT5ycTrk1l8txOSiemNp7Y3H
 lh5zpcXZ3UshICKhVqHE9m6r2hZ+rzFZ/8Sl3ztm7/6uXdxvaISR1vc+518QsGgEnJBh
 mJFBsBANAQ1YasZo+sqrnLBDHN2FyI7+EUXDQ7c9PlyLN9Tpa9cXl5AnNrBmGZ3DuCMb
 zyUg==
X-Gm-Message-State: AOAM531v3JDzyla+4ksmPXgqcqE7295rPLdgZnOx5t5pSsJ399dM4ufD
 JnHXNxvD1mpDN2MPEDqDYXak3m2fQynx+PqbpR8=
X-Google-Smtp-Source: ABdhPJy8nTS5vZDsnThh6gD/GDIH0m+tO/6dB07om3hIzXT4luOhuL7Pta9B/WxeohScHf4CL8NX/9sd2r5J9cIQx1s=
X-Received: by 2002:a17:906:aeda:: with SMTP id
 me26mr23844396ejb.11.1608731351205; 
 Wed, 23 Dec 2020 05:49:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1608065644.git.wangyunjian@huawei.com>
 <6b4c5fff8705dc4b5b6a25a45c50f36349350c73.1608065644.git.wangyunjian@huawei.com>
 <CAF=yD-K6EM3zfZtEh=305P4Z6ehO6TzfQC4cxp5+gHYrxEtXSg@mail.gmail.com>
 <acebdc23-7627-e170-cdfb-b7656c05e5c5@redhat.com>
 <CAF=yD-KCs5x1oX-02aDM=5JyLP=BaA7_Jg7Wxt3=JmK8JBnyiA@mail.gmail.com>
 <2a309efb-0ea5-c40e-5564-b8900601da97@redhat.com>
 <34EFBCA9F01B0748BEB6B629CE643AE60DB8E046@DGGEMM533-MBX.china.huawei.com>
In-Reply-To: <34EFBCA9F01B0748BEB6B629CE643AE60DB8E046@DGGEMM533-MBX.china.huawei.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 23 Dec 2020 08:48:34 -0500
Message-ID: <CAF=yD-Kt0uk=xyCmdfRzddV5LdTebXnAfoEYVX3bzM=L2B2VDQ@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] vhost_net: fix high cpu load when sendmsg fails
To: wangyunjian <wangyunjian@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 "Lilijun \(Jerry\)" <jerry.lilijun@huawei.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, xudingke <xudingke@huawei.com>,
 "huangbin \(J\)" <brian.huangbin@huawei.com>,
 chenchanghu <chenchanghu@huawei.com>
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

T24gV2VkLCBEZWMgMjMsIDIwMjAgYXQgODoyMSBBTSB3YW5neXVuamlhbiA8d2FuZ3l1bmppYW5A
aHVhd2VpLmNvbT4gd3JvdGU6Cj4KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPiBG
cm9tOiBKYXNvbiBXYW5nIFttYWlsdG86amFzb3dhbmdAcmVkaGF0LmNvbV0KPiA+IFNlbnQ6IFdl
ZG5lc2RheSwgRGVjZW1iZXIgMjMsIDIwMjAgMTA6NTQgQU0KPiA+IFRvOiBXaWxsZW0gZGUgQnJ1
aWpuIDx3aWxsZW1kZWJydWlqbi5rZXJuZWxAZ21haWwuY29tPgo+ID4gQ2M6IHdhbmd5dW5qaWFu
IDx3YW5neXVuamlhbkBodWF3ZWkuY29tPjsgTmV0d29yayBEZXZlbG9wbWVudAo+ID4gPG5ldGRl
dkB2Z2VyLmtlcm5lbC5vcmc+OyBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPjsK
PiA+IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBMaWxpanVuIChK
ZXJyeSkKPiA+IDxqZXJyeS5saWxpanVuQGh1YXdlaS5jb20+OyBjaGVuY2hhbmdodSA8Y2hlbmNo
YW5naHVAaHVhd2VpLmNvbT47Cj4gPiB4dWRpbmdrZSA8eHVkaW5na2VAaHVhd2VpLmNvbT47IGh1
YW5nYmluIChKKQo+ID4gPGJyaWFuLmh1YW5nYmluQGh1YXdlaS5jb20+Cj4gPiBTdWJqZWN0OiBS
ZTogW1BBVENIIG5ldCB2MiAyLzJdIHZob3N0X25ldDogZml4IGhpZ2ggY3B1IGxvYWQgd2hlbiBz
ZW5kbXNnIGZhaWxzCj4gPgo+ID4KPiA+IE9uIDIwMjAvMTIvMjIg5LiL5Y2IMTA6MjQsIFdpbGxl
bSBkZSBCcnVpam4gd3JvdGU6Cj4gPiA+IE9uIE1vbiwgRGVjIDIxLCAyMDIwIGF0IDExOjQxIFBN
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gPiB3cm90ZToKPiA+ID4+Cj4gPiA+
PiBPbiAyMDIwLzEyLzIyIOS4iuWNiDc6MDcsIFdpbGxlbSBkZSBCcnVpam4gd3JvdGU6Cj4gPiA+
Pj4gT24gV2VkLCBEZWMgMTYsIDIwMjAgYXQgMzoyMCBBTSB3YW5neXVuamlhbjx3YW5neXVuamlh
bkBodWF3ZWkuY29tPgo+ID4gd3JvdGU6Cj4gPiA+Pj4+IEZyb206IFl1bmppYW4gV2FuZzx3YW5n
eXVuamlhbkBodWF3ZWkuY29tPgo+ID4gPj4+Pgo+ID4gPj4+PiBDdXJyZW50bHkgd2UgYnJlYWsg
dGhlIGxvb3AgYW5kIHdha2UgdXAgdGhlIHZob3N0X3dvcmtlciB3aGVuCj4gPiA+Pj4+IHNlbmRt
c2cgZmFpbHMuIFdoZW4gdGhlIHdvcmtlciB3YWtlcyB1cCBhZ2Fpbiwgd2UnbGwgbWVldCB0aGUg
c2FtZQo+ID4gPj4+PiBlcnJvci4KPiA+ID4+PiBUaGUgcGF0Y2ggaXMgYmFzZWQgb24gdGhlIGFz
c3VtcHRpb24gdGhhdCBzdWNoIGVycm9yIGNhc2VzIGFsd2F5cwo+ID4gPj4+IHJldHVybiBFQUdB
SU4uIENhbiBpdCBub3QgYWxzbyBiZSBFTk9NRU0sIHN1Y2ggYXMgZnJvbSB0dW5fYnVpbGRfc2ti
Pwo+ID4gPj4+Cj4gPiA+Pj4+IFRoaXMgd2lsbCBjYXVzZSBoaWdoIENQVSBsb2FkLiBUbyBmaXgg
dGhpcyBpc3N1ZSwgd2UgY2FuIHNraXAgdGhpcwo+ID4gPj4+PiBkZXNjcmlwdGlvbiBieSBpZ25v
cmluZyB0aGUgZXJyb3IuIFdoZW4gd2UgZXhjZWVkcyBzbmRidWYsIHRoZQo+ID4gPj4+PiByZXR1
cm4gdmFsdWUgb2Ygc2VuZG1zZyBpcyAtRUFHQUlOLiBJbiB0aGUgY2FzZSB3ZSBkb24ndCBza2lw
IHRoZQo+ID4gPj4+PiBkZXNjcmlwdGlvbiBhbmQgZG9uJ3QgZHJvcCBwYWNrZXQuCj4gPiA+Pj4g
dGhlIC0+IHRoYXQKPiA+ID4+Pgo+ID4gPj4+IGhlcmUgYW5kIGFib3ZlOiBkZXNjcmlwdGlvbiAt
PiBkZXNjcmlwdG9yCj4gPiA+Pj4KPiA+ID4+PiBQZXJoYXBzIHNsaWdodGx5IHJldmlzZSB0byBt
b3JlIGV4cGxpY2l0bHkgc3RhdGUgdGhhdAo+ID4gPj4+Cj4gPiA+Pj4gMS4gaW4gdGhlIGNhc2Ug
b2YgcGVyc2lzdGVudCBmYWlsdXJlIChpLmUuLCBiYWQgcGFja2V0KSwgdGhlIGRyaXZlcgo+ID4g
Pj4+IGRyb3BzIHRoZSBwYWNrZXQgMi4gaW4gdGhlIGNhc2Ugb2YgdHJhbnNpZW50IGZhaWx1cmUg
KGUuZywuIG1lbW9yeQo+ID4gPj4+IHByZXNzdXJlKSB0aGUgZHJpdmVyIHNjaGVkdWxlcyB0aGUg
d29ya2VyIHRvIHRyeSBhZ2FpbiBsYXRlcgo+ID4gPj4KPiA+ID4+IElmIHdlIHdhbnQgdG8gZ28g
d2l0aCB0aGlzIHdheSwgd2UgbmVlZCBhIGJldHRlciB0aW1lIHRvIHdha2V1cCB0aGUKPiA+ID4+
IHdvcmtlci4gT3RoZXJ3aXNlIGl0IGp1c3QgcHJvZHVjZXMgbW9yZSBzdHJlc3Mgb24gdGhlIGNw
dSB0aGF0IGlzCj4gPiA+PiB3aGF0IHRoaXMgcGF0Y2ggdHJpZXMgdG8gYXZvaWQuCj4gPiA+IFBl
cmhhcHMgSSBtaXN1bmRlcnN0b29kIHRoZSBwdXJwb3NlIG9mIHRoZSBwYXRjaDogaXMgaXQgdG8g
ZHJvcAo+ID4gPiBldmVyeXRoaW5nLCByZWdhcmRsZXNzIG9mIHRyYW5zaWVudCBvciBwZXJzaXN0
ZW50IGZhaWx1cmUsIHVudGlsIHRoZQo+ID4gPiByaW5nIHJ1bnMgb3V0IG9mIGRlc2NyaXB0b3Jz
Pwo+ID4KPiA+Cj4gPiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgdGhlIG1haW4gbW90aXZhdGlv
biBpcyB0byBhdm9pZCBoaWdoIGNwdSB1dGlsaXphdGlvbgo+ID4gd2hlbiBzZW5kbXNnKCkgZmFp
bCBkdWUgdG8gZ3Vlc3QgcmVhc29uIChlLmcgYmFkIHBhY2tldCkuCj4gPgo+Cj4gTXkgbWFpbiBt
b3RpdmF0aW9uIGlzIHRvIGF2b2lkIHRoZSB0eCBxdWV1ZSBzdHVjay4KPgo+IFNob3VsZCBJIGRl
c2NyaWJlIGl0IGxpa2UgdGhpczoKPiBDdXJyZW50bHkgdGhlIGRyaXZlciBkb24ndCBkcm9wIGEg
cGFja2V0IHdoaWNoIGNhbid0IGJlIHNlbmQgYnkgdHVuCj4gKGUuZyBiYWQgcGFja2V0KS4gSW4g
dGhpcyBjYXNlLCB0aGUgZHJpdmVyIHdpbGwgYWx3YXlzIHByb2Nlc3MgdGhlCj4gc2FtZSBwYWNr
ZXQgbGVhZCB0byB0aGUgdHggcXVldWUgc3R1Y2suCj4KPiBUbyBmaXggdGhpcyBpc3N1ZToKPiAx
LiBpbiB0aGUgY2FzZSBvZiBwZXJzaXN0ZW50IGZhaWx1cmUgKGUuZyBiYWQgcGFja2V0KSwgdGhl
IGRyaXZlciBjYW4gc2tpcAo+IHRoaXMgZGVzY3JpcHRpb3IgYnkgaWdub3JpbmcgdGhlIGVycm9y
Lgo+IDIuIGluIHRoZSBjYXNlIG9mIHRyYW5zaWVudCBmYWlsdXJlIChlLmcgLUVBR0FJTiBhbmQg
LUVOT01FTSksIHRoZSBkcml2ZXIKPiBzY2hlZHVsZXMgdGhlIHdvcmtlciB0byB0cnkgYWdhaW4u
CgpUaGF0IHNvdW5kcyBnb29kIHRvIG1lLCB0aGFua3MuCgo+IFRoYW5rcwo+Cj4gPgo+ID4gPgo+
ID4gPiBJIGNhbiB1bmRlcnN0YW5kIGJvdGggYSBibG9ja2luZyBhbmQgZHJvcCBzdHJhdGVneSBk
dXJpbmcgbWVtb3J5Cj4gPiA+IHByZXNzdXJlLiBCdXQgcGFydGlhbCBkcm9wIHN0cmF0ZWd5IHVu
dGlsIGV4Y2VlZGluZyByaW5nIGNhcGFjaXR5Cj4gPiA+IHNlZW1zIGxpa2UgYSBwZWN1bGlhciBo
eWJyaWQ/Cj4gPgo+ID4KPiA+IFllcy4gU28gSSB3b25kZXIgaWYgd2Ugd2FudCB0byBiZSBkbyBi
ZXR0ZXIgd2hlbiB3ZSBhcmUgaW4gdGhlIG1lbW9yeQo+ID4gcHJlc3N1cmUuIEUuZyBjYW4gd2Ug
bGV0IHNvY2tldCB3YWtlIHVwIHVzIGluc3RlYWQgb2YgcmVzY2hlZHVsaW5nIHRoZQo+ID4gd29y
a2VycyBoZXJlPyBBdCBsZWFzdCBpbiB0aGlzIGNhc2Ugd2Uga25vdyBzb21lIG1lbW9yeSBtaWdo
dCBiZSBmcmVlZD8KCkkgZG9uJ3Qga25vdyB3aGV0aGVyIGEgYmxvY2tpbmcgb3IgZHJvcCBzdHJh
dGVneSBpcyB0aGUgYmV0dGVyIGNob2ljZS4KRWl0aGVyIHdheSwgaXQgcHJvYmFibHkgZGVzZXJ2
ZXMgdG8gYmUgaGFuZGxlZCBzZXBhcmF0ZWx5LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

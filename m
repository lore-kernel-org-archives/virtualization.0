Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD7BC77B7E
	for <virtualization@archiver.kernel.org>; Mon, 29 May 2023 07:30:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 70E2A417D0;
	Mon, 29 May 2023 07:30:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 70E2A417D0
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=KUGYnnqk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2ZKMBP8V3OZZ; Mon, 29 May 2023 07:30:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CEE824032C;
	Mon, 29 May 2023 07:30:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CEE824032C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A57C5C0035;
	Mon, 29 May 2023 07:30:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B98AC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 07:30:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2936F83339
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 07:30:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2936F83339
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20221208 header.b=KUGYnnqk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OHYR0glgfY6n
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 07:30:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC7B983330
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC7B983330
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 07:30:47 +0000 (UTC)
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2af28303127so31090781fa.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 00:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685345446; x=1687937446;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KkQR+d/C0t4pr2zOXjJaFErA6sOw3jBbv3bylMF2rR0=;
 b=KUGYnnqkhgvFGl58FkNAhMlDzkvhonDqsoQhRLI1s8oxEQ67h1hT33TL++G/ZKv3B7
 S22RhBI+D35LeaNUElckO20icpcDV6sm2Fof9t8SQhofVuAKRy+sXPB0oS1iLWGYT4KE
 kn+4TJRAYEoUGt348r9aurInGIvn3Opi4jhW2Qf0cxX6BnRwnLSg3ci8uN4nQZ3kgElG
 RA2cu1y1pg///n5yli3ik5h40JaI0V3wnOafHUWAn9YaTB3nr8oGbgemt6snM22LyolS
 HY5Xq9cD1nrtoEpAy3eFUP8M7eciNY9J6hjwDRZd8BfQBf0Aif1809MKr+xdqsUPexqh
 3RoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685345446; x=1687937446;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KkQR+d/C0t4pr2zOXjJaFErA6sOw3jBbv3bylMF2rR0=;
 b=T+kPLiMeHScpyAuKWguIyN+4UUVolpCnMnDS+Ea8cqkNzTukhtUe7AjpwUI5lb1kZn
 k7K5C8mGg1zsxSmrZP0sCKQnlD8cU7Ot1qwlr0at+zv6wqk+D8TKD+jTrOHBkYZwowfd
 8fDGew6s/M+tUHxa40ueimRKAVYAMno+UCJueIeelXJtMORI4n7PYvtvRcgysggT4uc4
 mW2X9sgiTpczOnQ47ykz4AWGqoKZkDkYsFZm9IZCUVthSQ1TwIed/ksXppyxpmcfCStg
 yiOu5U1NYWXImUPbNlpuMzzoS63r3TjoKXKN4uOc1Hf5Hhn8fIiFNpNtyJctD994pVzJ
 TW/Q==
X-Gm-Message-State: AC+VfDwFY/XHrlHHdbkRVNIVnlo/mDlm285PcbfXhisZpSH4JsyBPngY
 /hD6WQJpDKmWB9R1w+TbJfl6Cr9dRA56plE2LHc=
X-Google-Smtp-Source: ACHHUZ5fyk5q2VGIGCKNtRJ3q3BjJwatfRZbDcOb102v983t1V37Fydyqhu07yyVO78XQYV6dPBic+n6saDa8yt+x2Q=
X-Received: by 2002:a2e:9d96:0:b0:2af:32a7:4eef with SMTP id
 c22-20020a2e9d96000000b002af32a74eefmr3221080ljj.35.1685345445653; Mon, 29
 May 2023 00:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
 <20230526054621.18371-3-liangchen.linux@gmail.com>
 <992eb402-43f9-0289-f95c-b41cb17f2e59@huawei.com>
In-Reply-To: <992eb402-43f9-0289-f95c-b41cb17f2e59@huawei.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Mon, 29 May 2023 15:30:33 +0800
Message-ID: <CAKhg4tL9PrUebqQHL+s7A6-xqNnju3erNQejMr7UFjwTaOduZw@mail.gmail.com>
Subject: Re: [PATCH net-next 3/5] virtio_net: Add page pool fragmentation
 support
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

T24gTW9uLCBNYXkgMjksIDIwMjMgYXQgOTozM+KAr0FNIFl1bnNoZW5nIExpbiA8bGlueXVuc2hl
bmdAaHVhd2VpLmNvbT4gd3JvdGU6Cj4KPiBPbiAyMDIzLzUvMjYgMTM6NDYsIExpYW5nIENoZW4g
d3JvdGU6Cj4KPiAuLi4KPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
YyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gaW5kZXggOTljMGNhMGMxNzgxLi5hYzQw
YjhjNjZjNTkgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ICsr
KyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gQEAgLTMyLDcgKzMyLDkgQEAgbW9kdWxl
X3BhcmFtKGdzbywgYm9vbCwgMDQ0NCk7Cj4gPiAgbW9kdWxlX3BhcmFtKG5hcGlfdHgsIGJvb2ws
IDA2NDQpOwo+ID4KPiA+ICBzdGF0aWMgYm9vbCBwYWdlX3Bvb2xfZW5hYmxlZDsKPiA+ICtzdGF0
aWMgYm9vbCBwYWdlX3Bvb2xfZnJhZzsKPiA+ICBtb2R1bGVfcGFyYW0ocGFnZV9wb29sX2VuYWJs
ZWQsIGJvb2wsIDA0MDApOwo+ID4gK21vZHVsZV9wYXJhbShwYWdlX3Bvb2xfZnJhZywgYm9vbCwg
MDQwMCk7Cj4KPiBUaGUgYmVsb3cgcGF0Y2hzZXQgdW5pZmllcyB0aGUgZnJhZyBhbmQgbm9uLWZy
YWcgcGFnZSBmb3IKPiBwYWdlX3Bvb2xfYWxsb2NfZnJhZygpIEFQSSwgcGVyaGFwcyBpdCB3b3Vs
ZCBzaW1wbGlmeSB0aGUKPiBkcml2ZXIncyBzdXBwb3J0IG9mIHBhZ2UgcG9vbC4KPgo+IGh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9uZXRkZXZicGYvY292ZXIvMjAyMzA1MjYw
OTI2MTYuNDAzNTUtMS1saW55dW5zaGVuZ0BodWF3ZWkuY29tLwo+CgpUaGFua3MgZm9yIHRoZSBp
bmZvcm1hdGlvbiBhbmQgdGhlIHdvcmsgdG8gbWFrZSBkcml2ZXIgc3VwcG9ydCBlYXN5LiBJCndp
bGwgcmViYXNlIGFjY29yZGluZ2x5IGFmdGVyIGl0IGxhbmRzLgoKPiA+Cj4KPiAuLi4KPgo+ID4g
QEAgLTE3NjksMTMgKzE3ODgsMjkgQEAgc3RhdGljIGludCBhZGRfcmVjdmJ1Zl9tZXJnZWFibGUo
c3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gPiAgICAgICAgKi8KPiA+ICAgICAgIGxlbiA9IGdl
dF9tZXJnZWFibGVfYnVmX2xlbihycSwgJnJxLT5tcmdfYXZnX3BrdF9sZW4sIHJvb20pOwo+ID4g
ICAgICAgaWYgKHJxLT5wYWdlX3Bvb2wpIHsKPiA+IC0gICAgICAgICAgICAgc3RydWN0IHBhZ2Ug
KnBhZ2U7Cj4gPiArICAgICAgICAgICAgIGlmIChycS0+cGFnZV9wb29sLT5wLmZsYWdzICYgUFBf
RkxBR19QQUdFX0ZSQUcpIHsKPiA+ICsgICAgICAgICAgICAgICAgICAgICBpZiAodW5saWtlbHko
IXBhZ2VfcG9vbF9kZXZfYWxsb2NfZnJhZyhycS0+cGFnZV9wb29sLAo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZwcF9mcmFn
X29mZnNldCwgbGVuICsgcm9vbSkpKQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIC1FTk9NRU07Cj4gPiArICAgICAgICAgICAgICAgICAgICAgYnVmID0gKGNoYXIgKilw
YWdlX2FkZHJlc3MocnEtPnBhZ2VfcG9vbC0+ZnJhZ19wYWdlKSArCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBwcF9mcmFnX29mZnNldDsKPiA+ICsgICAgICAgICAgICAgICAgICAg
ICBidWYgKz0gaGVhZHJvb207IC8qIGFkdmFuY2UgYWRkcmVzcyBsZWF2aW5nIGhvbGUgYXQgZnJv
bnQgb2YgcGt0ICovCj4gPiArICAgICAgICAgICAgICAgICAgICAgaG9sZSA9IChQQUdFX1NJWkUg
PDwgcnEtPnBhZ2VfcG9vbC0+cC5vcmRlcikKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIC0gcnEtPnBhZ2VfcG9vbC0+ZnJhZ19vZmZzZXQ7Cj4gPiArICAgICAgICAgICAgICAgICAg
ICAgaWYgKGhvbGUgPCBsZW4gKyByb29tKSB7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpZiAoIWhlYWRyb29tKQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBsZW4gKz0gaG9sZTsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJxLT5w
YWdlX3Bvb2wtPmZyYWdfb2Zmc2V0ICs9IGhvbGU7Cj4KPiBJcyB0aGVyZSBhbnkgcmVhc29uIHdo
eSB0aGUgZHJpdmVyIG5lZWQgdG8gYmUgYXdhcmUgb2YgcGFnZV9wb29sLT5mcmFnX29mZnNldD8K
PiBJc24ndCB0aGUgcGFnZV9wb29sX2Rldl9hbGxvY19mcmFnKCkgd2lsbCBkcmFpbiB0aGUgbGFz
dCBwYWdlIGZvciB5b3Ugd2hlbgo+IHBhZ2VfcG9vbF9kZXZfYWxsb2NfZnJhZygpIGlzIGNhbGxl
ZCB3aXRoIHNpemUgYmVpbmcgJ2xlbiArIHJvb20nIGxhdGVyPwo+IE9uZSBjYXNlIEkgY2FuIHRo
aW5rIG9mIG5lZWRpbmcgdGhpcyBpcyB0byBoYXZlIGFuIGFjY3VyYXRlIHRydWVzaXplIHJlcG9y
dAo+IGZvciBza2IsIGJ1dCBJIGFtIG5vdCBzdXJlIGl0IG1hdHRlcnMgdGhhdCBtdWNoIGFzICdz
dHJ1Y3QgcGFnZV9mcmFnX2NhY2hlJwo+IGFuZCAncGFnZV9mcmFnJyBpbXBsZW1lbnRhdGlvbiBi
b3RoIGhhdmUgYSBzaW1pbGFyIHByb2JsZW0uCj4KClllYWgsIGFzIHlvdSBwb2ludGVkIG91dCBw
YWdlX3Bvb2xfZGV2X2FsbG9jX2ZyYWcgd2lsbCBkcmFpbiB0aGUgcGFnZQppdHNlbGYsIHNvIGRv
ZXMgc2tiX3BhZ2VfZnJhZ19yZWZpbGwuIFRoaXMgaXMgdHJ5aW5nIHRvIGtlZXAgdGhlIGxvZ2lj
CmNvbnNpc3RlbnQgd2l0aCBub24gcGFnZSBwb29sIGNhc2Ugd2hlcmUgdGhlIGhvbGUgd2FzIHNr
aXBwZWQgYW5kCmluY2x1ZGVkIGluIGJ1ZmZlciBsZW4uCgo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgIH0KPiA+ICsgICAgICAgICAgICAgfSBlbHNlIHsKPiA+ICsgICAgICAgICAgICAgICAgICAg
ICBzdHJ1Y3QgcGFnZSAqcGFnZTsKPiA+Cj4gPiAtICAgICAgICAgICAgIHBhZ2UgPSBwYWdlX3Bv
b2xfZGV2X2FsbG9jX3BhZ2VzKHJxLT5wYWdlX3Bvb2wpOwo+ID4gLSAgICAgICAgICAgICBpZiAo
dW5saWtlbHkoIXBhZ2UpKQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVN
Owo+ID4gLSAgICAgICAgICAgICBidWYgPSAoY2hhciAqKXBhZ2VfYWRkcmVzcyhwYWdlKTsKPiA+
IC0gICAgICAgICAgICAgYnVmICs9IGhlYWRyb29tOyAvKiBhZHZhbmNlIGFkZHJlc3MgbGVhdmlu
ZyBob2xlIGF0IGZyb250IG9mIHBrdCAqLwo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHBhZ2Ug
PSBwYWdlX3Bvb2xfZGV2X2FsbG9jX3BhZ2VzKHJxLT5wYWdlX3Bvb2wpOwo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgIGlmICh1bmxpa2VseSghcGFnZSkpCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gLUVOT01FTTsKPiA+ICsgICAgICAgICAgICAgICAgICAgICBidWYg
PSAoY2hhciAqKXBhZ2VfYWRkcmVzcyhwYWdlKTsKPiA+ICsgICAgICAgICAgICAgICAgICAgICBi
dWYgKz0gaGVhZHJvb207IC8qIGFkdmFuY2UgYWRkcmVzcyBsZWF2aW5nIGhvbGUgYXQgZnJvbnQg
b2YgcGt0ICovCj4gPiArICAgICAgICAgICAgIH0KPiA+ICAgICAgIH0gZWxzZSB7Cj4gPiAgICAg
ICAgICAgICAgIGlmICh1bmxpa2VseSghc2tiX3BhZ2VfZnJhZ19yZWZpbGwobGVuICsgcm9vbSwg
YWxsb2NfZnJhZywgZ2ZwKSkpCj4gPiAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9N
RU07Cj4gPiBAQCAtMzgwMCwxMyArMzgzNSwxNiBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X2FsbG9j
X3BhZ2VfcG9vbChzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEpCj4gPiAgICAgICBzdHJ1Y3Qgdmly
dGlvX2RldmljZSAqdmRldiA9IHJxLT52cS0+dmRldjsKPiA+Cj4gPiAgICAgICBzdHJ1Y3QgcGFn
ZV9wb29sX3BhcmFtcyBwcF9wYXJhbXMgPSB7Cj4gPiAtICAgICAgICAgICAgIC5vcmRlciA9IDAs
Cj4gPiArICAgICAgICAgICAgIC5vcmRlciA9IHBhZ2VfcG9vbF9mcmFnID8gU0tCX0ZSQUdfUEFH
RV9PUkRFUiA6IDAsCj4gPiAgICAgICAgICAgICAgIC5wb29sX3NpemUgPSBycS0+dnEtPm51bV9t
YXgsCj4KPiBJZiBpdCB1c2luZyBvcmRlciBTS0JfRlJBR19QQUdFX09SREVSIHBhZ2UsIHBlcmhh
cHMgcG9vbF9zaXplIGRvZXMKPiBub3QgaGF2ZSB0byBiZSBycS0+dnEtPm51bV9tYXg/IEV2ZW4g
Zm9yIG9yZGVyIDAgcGFnZSwgcGVyaGFwcyB0aGUKPiBwb29sX3NpemUgZG9lcyBub3QgbmVlZCB0
byBiZSBhcyBiaWcgYXMgcnEtPnZxLT5udW1fbWF4Pwo+CgpUaGFua3MgZm9yIHBvaW50aW5nIHRo
aXMgb3V0ISBwb29sX3NpemUgd2lsbCBiZSBsb3dlcmVkIHRvIGEgbW9yZQphcHByb3ByaWF0ZSB2
YWx1ZSBvbiB2Mi4KCgo+ID4gICAgICAgICAgICAgICAubmlkID0gZGV2X3RvX25vZGUodmRldi0+
ZGV2LnBhcmVudCksCj4gPiAgICAgICAgICAgICAgIC5kZXYgPSB2ZGV2LT5kZXYucGFyZW50LAo+
ID4gICAgICAgICAgICAgICAub2Zmc2V0ID0gMCwKPiA+ICAgICAgIH07Cj4gPgo+ID4gKyAgICAg
aWYgKHBhZ2VfcG9vbF9mcmFnKQo+ID4gKyAgICAgICAgICAgICBwcF9wYXJhbXMuZmxhZ3MgfD0g
UFBfRkxBR19QQUdFX0ZSQUc7Cj4gPiArCj4gPiAgICAgICBycS0+cGFnZV9wb29sID0gcGFnZV9w
b29sX2NyZWF0ZSgmcHBfcGFyYW1zKTsKPiA+ICAgICAgIGlmIChJU19FUlIocnEtPnBhZ2VfcG9v
bCkpIHsKPiA+ICAgICAgICAgICAgICAgZGV2X3dhcm4oJnZkZXYtPmRldiwgInBhZ2UgcG9vbCBj
cmVhdGlvbiBmYWlsZWQ6ICVsZFxuIiwKPiA+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

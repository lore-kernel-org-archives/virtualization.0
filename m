Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D792AC433EF
	for <virtualization@archiver.kernel.org>; Thu,  3 Mar 2022 14:17:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5FA944016D;
	Thu,  3 Mar 2022 14:17:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wv-LMf_h8VRc; Thu,  3 Mar 2022 14:17:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 75A9A40018;
	Thu,  3 Mar 2022 14:17:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 494D0C0082;
	Thu,  3 Mar 2022 14:17:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 914AFC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 14:17:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 68EE94016D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 14:17:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QuyPB899uBjL
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 14:17:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B13F340018
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 14:17:12 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id d3so8097761wrf.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Mar 2022 06:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=o87FE1s1Wm0goe8u+iMFz3QFDTGxpEfcNIHyIf4cYXc=;
 b=qjtp5qx/MAS7oqOrzTmksFxlCuVhzhNjct9+cVdZJ0lL6LcvKJpYIbhjcbFQ5y9Sev
 DocA3PoxsiNIlDGie3zqTL7+3cZqizI67vE9M6VfGzSXMuNeAvca61E1ggaYqv9zQFqL
 fJODUuKt9vY9USIyyVUP20Kqq0V7c19LkZlvs7UwQ2NN5XFi/YawqJef+7uk3L9avGAN
 U+tVGYNR/FGSTKHT61X9VJIZzSU+SKbQpPqMelLVGiYbB9c5AR28XhyRDVus0xBAcPmJ
 6FreKTdHUZke8zDVjWjeeEE8ttpNaGeilOikSatq/h4i7sbml9cna2lWaV+MvgXYz04K
 Bjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=o87FE1s1Wm0goe8u+iMFz3QFDTGxpEfcNIHyIf4cYXc=;
 b=5/87kWxq9jsSVjB3V1Ny1t6zuKImCYAjI4SlGXYv6MLLJbc6DrT8E7uWZ+t2BF01wW
 ceurYceEOS4qc9yASNpZOnPgyxSidnZF9i+aLgJCFkPU7alELaa80xII+qqx8ekI97Xj
 xPv1nRYus/uSjvhqQvz9X09EmkIvY/VdAGMhM5IwlHDzTths7aMMXjn93e8DtCZ/chSr
 XQVdBGfWz51GXJIjxfrEe5fmxLqgNcx4CX5ikZA8zxjqWhSZ6KjZLiTErAOfu26F3dGZ
 X9JwtHoWN1U47SnTdUWVaGbuD5URzN2RmaUTHTfA7hejEdUKBHmgvM0IsrH4Mrd7UA0D
 2qVA==
X-Gm-Message-State: AOAM532vQB9gt8ASMNeB2cNPmeAqC5LDgVjEneQ3O9RWF8/lp++M/zXq
 6r+5FOy3Q9DALldsI4T3RRgHCg==
X-Google-Smtp-Source: ABdhPJxGby9qFrKdJzMjz97SEhrdFbTgsA5JiONah34Fa2/z0rLBVsD2gF8PbtEBkulh+SvN06cb+A==
X-Received: by 2002:adf:edc4:0:b0:1ee:27de:4b04 with SMTP id
 v4-20020adfedc4000000b001ee27de4b04mr25622352wro.117.1646317030825; 
 Thu, 03 Mar 2022 06:17:10 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net.
 [86.27.177.88]) by smtp.gmail.com with ESMTPSA id
 z6-20020a1cf406000000b0037c4e2d3baesm9037338wma.19.2022.03.03.06.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Mar 2022 06:17:10 -0800 (PST)
Date: Thu, 3 Mar 2022 14:17:07 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <YiDN4xpb1+8k5K5/@google.com>
References: <20220302075421.2131221-1-lee.jones@linaro.org>
 <20220302082021-mutt-send-email-mst@kernel.org>
 <Yh93k2ZKJBIYQJjp@google.com>
 <20220302095045-mutt-send-email-mst@kernel.org>
 <Yh+F1gkCGoYF2lMV@google.com>
 <CAGxU2F4cUDrMzoHH1NT5_ivxBPgEE8HOzP5s_Bt5JURRaSsLdQ@mail.gmail.com>
 <20220302112945-mutt-send-email-mst@kernel.org>
 <Yh+gDZUbgBRx/1ro@google.com>
 <20220302171048.aijkcrwcrgsu475z@sgarzare-redhat>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220302171048.aijkcrwcrgsu475z@sgarzare-redhat>
Cc: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com,
 kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org,
 Linux Virtualization <virtualization@lists.linux-foundation.org>
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

T24gV2VkLCAwMiBNYXIgMjAyMiwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgoKPiBPbiBXZWQs
IE1hciAwMiwgMjAyMiBhdCAwNDo0OToxN1BNICswMDAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPiBP
biBXZWQsIDAyIE1hciAyMDIyLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiAKPiA+ID4g
T24gV2VkLCBNYXIgMDIsIDIwMjIgYXQgMDU6Mjg6MzFQTSArMDEwMCwgU3RlZmFubyBHYXJ6YXJl
bGxhIHdyb3RlOgo+ID4gPiA+IE9uIFdlZCwgTWFyIDIsIDIwMjIgYXQgMzo1NyBQTSBMZWUgSm9u
ZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPiB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+ID4gPiBPbiBX
ZWQsIDAyIE1hciAyMDIyLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4g
PiA+ID4gPiBPbiBXZWQsIE1hciAwMiwgMjAyMiBhdCAwMTo1NjozNVBNICswMDAwLCBMZWUgSm9u
ZXMgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gT24gV2VkLCAwMiBNYXIgMjAyMiwgTWljaGFlbCBTLiBU
c2lya2luIHdyb3RlOgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBPbiBXZWQsIE1hciAw
MiwgMjAyMiBhdCAwNzo1NDoyMUFNICswMDAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPiA+ID4gPiA+
ID4gPiA+IHZob3N0X3Zzb2NrX2hhbmRsZV90eF9raWNrKCkgYWxyZWFkeSBob2xkcyB0aGUgbXV0
ZXggZHVyaW5nIGl0cyBjYWxsCj4gPiA+ID4gPiA+ID4gPiA+IHRvIHZob3N0X2dldF92cV9kZXNj
KCkuICBBbGwgd2UgaGF2ZSB0byBkbyBpcyB0YWtlIHRoZSBzYW1lIGxvY2sKPiA+ID4gPiA+ID4g
PiA+ID4gZHVyaW5nIHZpcnRxdWV1ZSBjbGVhbi11cCBhbmQgd2UgbWl0aWdhdGUgdGhlIHJlcG9y
dGVkIGlzc3Vlcy4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gTGluazogaHR0
cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPTI3OTQzMmQzMGQ4MjVlNjNiYTAw
Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IENjOiA8c3RhYmxlQHZnZXIua2Vy
bmVsLm9yZz4KPiA+ID4gPiA+ID4gPiA+ID4gUmVwb3J0ZWQtYnk6IHN5emJvdCthZGMzY2IzMjM4
NTU4NmJlYzg1OUBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCj4gPiA+ID4gPiA+ID4gPiA+IFNp
Z25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Cj4gPiA+ID4gPiA+
ID4gPiA+IC0tLQo+ID4gPiA+ID4gPiA+ID4gPiAgZHJpdmVycy92aG9zdC92aG9zdC5jIHwgMiAr
Kwo+ID4gPiA+ID4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+ID4g
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9z
dC92aG9zdC5jIGIvZHJpdmVycy92aG9zdC92aG9zdC5jCj4gPiA+ID4gPiA+ID4gPiA+IGluZGV4
IDU5ZWRiNWExZmZlMjguLmJiYWZmNmE1ZTIxYjggMTAwNjQ0Cj4gPiA+ID4gPiA+ID4gPiA+IC0t
LSBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+ID4gPiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJz
L3Zob3N0L3Zob3N0LmMKPiA+ID4gPiA+ID4gPiA+ID4gQEAgLTY5Myw2ICs2OTMsNyBAQCB2b2lk
IHZob3N0X2Rldl9jbGVhbnVwKHN0cnVjdCB2aG9zdF9kZXYgKmRldikKPiA+ID4gPiA+ID4gPiA+
ID4gICAgICAgICBpbnQgaTsKPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gICAg
ICAgICBmb3IgKGkgPSAwOyBpIDwgZGV2LT5udnFzOyArK2kpIHsKPiA+ID4gPiA+ID4gPiA+ID4g
KyAgICAgICAgICAgICAgIG11dGV4X2xvY2soJmRldi0+dnFzW2ldLT5tdXRleCk7Cj4gPiA+ID4g
PiA+ID4gPiA+ICAgICAgICAgICAgICAgICBpZiAoZGV2LT52cXNbaV0tPmVycm9yX2N0eCkKPiA+
ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgZXZlbnRmZF9jdHhfcHV0KGRl
di0+dnFzW2ldLT5lcnJvcl9jdHgpOwo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAg
aWYgKGRldi0+dnFzW2ldLT5raWNrKQo+ID4gPiA+ID4gPiA+ID4gPiBAQCAtNzAwLDYgKzcwMSw3
IEBAIHZvaWQgdmhvc3RfZGV2X2NsZWFudXAoc3RydWN0IHZob3N0X2RldiAqZGV2KQo+ID4gPiA+
ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgaWYgKGRldi0+dnFzW2ldLT5jYWxsX2N0eC5jdHgp
Cj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGV2ZW50ZmRfY3R4X3B1
dChkZXYtPnZxc1tpXS0+Y2FsbF9jdHguY3R4KTsKPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAg
ICAgICAgIHZob3N0X3ZxX3Jlc2V0KGRldiwgZGV2LT52cXNbaV0pOwo+ID4gPiA+ID4gPiA+ID4g
PiArICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZkZXYtPnZxc1tpXS0+bXV0ZXgpOwo+ID4g
PiA+ID4gPiA+ID4gPiAgICAgICAgIH0KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBT
byB0aGlzIGlzIGEgbWl0aWdhdGlvbiBwbGFuIGJ1dCB0aGUgYnVnIGlzIHN0aWxsIHRoZXJlIHRo
b3VnaAo+ID4gPiA+ID4gPiA+ID4gd2UgZG9uJ3Qga25vdyBleGFjdGx5IHdoYXQgaXQgaXMuICBJ
IHdvdWxkIHByZWZlciBhZGRpbmcgc29tZXRoaW5nIGxpa2UKPiA+ID4gPiA+ID4gPiA+IFdBUk5f
T04obXV0ZXhfaXNfbG9ja2VkKHZxc1tpXS0+bXV0ZXgpIGhlcmUgLSBkb2VzIHRoaXMgbWFrZSBz
ZW5zZT8KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEFzIGEgcmV3b3JrIHRvIHRoaXMsIG9y
IGFzIGEgc3Vic2VxdWVudCBwYXRjaD8KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gQ2FuIGJlIGEg
c2VwYXJhdGUgcGF0Y2guCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gSnVzdCBiZWZvcmUgdGhl
IGZpcnN0IGxvY2sgSSBhc3N1bWU/Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEkgZ3Vlc3Mgc28s
IHllcy4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBObyBwcm9ibGVtLiAgUGF0Y2ggdG8gZm9sbG93Lgo+
ID4gPiA+ID4KPiA+ID4gPiA+IEknbSBhbHNvIGdvaW5nIHRvIGF0dGVtcHQgdG8gZGVidWcgdGhl
IHJvb3QgY2F1c2UsIGJ1dCBJJ20gbmV3IHRvIHRoaXMKPiA+ID4gPiA+IHN1YnN5c3RlbSB0byBp
dCBtaWdodCB0YWtlIGEgd2hpbGUgZm9yIG1lIHRvIGdldCBteSBoZWFkIGFyb3VuZC4KPiA+ID4g
Pgo+ID4gPiA+IElJVUMgdGhlIHJvb3QgY2F1c2Ugc2hvdWxkIGJlIHRoZSBzYW1lIGFzIHRoZSBv
bmUgd2Ugc29sdmVkIGhlcmU6Cj4gPiA+ID4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9YTU4ZGE1M2Zm
ZDcwMjk0ZWJlYThlY2QwZWI0NWZkMGQ3NGFkZDlmOQo+ID4gPiA+Cj4gPiA+ID4gVGhlIHdvcmtl
ciB3YXMgbm90IHN0b3BwZWQgYmVmb3JlIGNhbGxpbmcgdmhvc3RfZGV2X2NsZWFudXAoKS4gU28g
d2hpbGUKPiA+ID4gPiB0aGUgd29ya2VyIHdhcyBzdGlsbCBydW5uaW5nIHdlIHdlcmUgZ29pbmcg
dG8gZnJlZSBtZW1vcnkgb3IgaW5pdGlhbGl6ZQo+ID4gPiA+IGZpZWxkcyB3aGlsZSBpdCB3YXMg
c3RpbGwgdXNpbmcgdmlydHF1ZXVlLgo+ID4gPiAKPiA+ID4gUmlnaHQsIGFuZCBJIGFncmVlIGJ1
dCBpdCdzIG5vdCB0aGUgcm9vdCB0aG91Z2gsIHdlIGRvIGF0dGVtcHQgdG8gc3RvcCBhbGwgd29y
a2Vycy4KPiA+IAo+ID4gRXhhY3RseS4gIFRoaXMgaXMgd2hhdCBoYXBwZW5zLCBidXQgdGhlIHF1
ZXN0aW9uIEknbSBnb2luZyB0byBhdHRlbXB0Cj4gPiB0byBhbnN3ZXIgaXMgKndoeSogZG9lcyB0
aGlzIGhhcHBlbi4KPiAKPiBJSVVDIHRoZSB3b3JrZXIgd2FzIHN0aWxsIHJ1bm5pbmcgYmVjYXVz
ZSB0aGUgL2Rldi92aG9zdC12c29jayBmaWxlIHdhcyBub3QKPiBleHBsaWNpdGx5IGNsb3NlZCwg
c28gdmhvc3RfdnNvY2tfZGV2X3JlbGVhc2UoKSB3YXMgY2FsbGVkIGluIHRoZSBkb19leGl0KCkK
PiBvZiB0aGUgcHJvY2Vzcy4KPiAKPiBJbiB0aGF0IGNhc2UgdGhlcmUgd2FzIHRoZSBpc3N1ZSwg
YmVjYXVzZSB2aG9zdF9kZXZfY2hlY2tfb3duZXIoKSByZXR1cm5lZAo+IGZhbHNlIGluIHZob3N0
X3Zzb2NrX3N0b3AoKSBzaW5jZSBjdXJyZW50LT5tbSB3YXMgTlVMTC4KPiBTbyBpdCByZXR1cm5l
ZCBlYXJsaWVyLCB3aXRob3V0IGNhbGxpbmcgdmhvc3RfdnFfc2V0X2JhY2tlbmQodnEsIE5VTEwp
Lgo+IAo+IFRoaXMgZGlkIG5vdCBzdG9wIHRoZSB3b3JrZXIgZnJvbSBjb250aW51aW5nIHRvIHJ1
biwgY2F1c2luZyB0aGUgbXVsdGlwbGUKPiBpc3N1ZXMgd2UgYXJlIHNlZWluZy4KPiAKPiBjdXJy
ZW50LT5tbSB3YXMgTlVMTCwgYmVjYXVzZSBpbiB0aGUgZG9fZXhpdCgpIHRoZSBhZGRyZXNzIHNw
YWNlIGlzIGNsZWFuZWQKPiBpbiB0aGUgZXhpdF9tbSgpLCB3aGljaCBpcyBjYWxsZWQgYmVmb3Jl
IHJlbGVhc2luZyB0aGUgZmlsZXMgaW50byB0aGUKPiBleGl0X3Rhc2tfd29yaygpLgo+IAo+IFRo
aXMgY2FuIGJlIHNlZW4gZnJvbSB0aGUgbG9ncywgd2hlcmUgd2Ugc2VlIGZpcnN0IHRoZSB3YXJu
aW5ncyBwcmludGVkIGJ5Cj4gdmhvc3RfZGV2X2NsZWFudXAoKSBhbmQgdGhlbiB0aGUgcGFuaWMg
aW4gdGhlIHdvcmtlciAoZS5nLiBoZXJlCj4gaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20v
dGV4dD90YWc9Q3Jhc2hMb2cmeD0xNmE2MWZjZTcwMDAwMCkKPiAKPiBNaWtlIGFsc28gYWRkZWQg
YSBmZXcgbW9yZSBoZWxwZnVsIGRldGFpbHMgaW4gdGhpcyB0aHJlYWQ6Cj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvdmlydHVhbGl6YXRpb24vMjAyMjAyMjExMDA1MDAuMngzczJzZGRxYWhnZGZ5
dEBzZ2FyemFyZS1yZWRoYXQvVC8jcmVlNjEzMTZlYWM2MzI0NWM5YmEzMDUwYjQ0MzMwZTQwMzQy
ODJjYzIKCkkgZ3Vlc3MgdGhhdCBhYm91dCBzdW1zIGl0IHVwLiA6KQoKLS0gCkxlZSBKb25lcyBb
5p2O55C85pavXQpQcmluY2lwYWwgVGVjaG5pY2FsIExlYWQgLSBEZXZlbG9wZXIgU2VydmljZXMK
TGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFybSBTb0NzCkZvbGxvdyBM
aW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

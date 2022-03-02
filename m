Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19917C433F5
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 14:51:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5F8281AF6;
	Wed,  2 Mar 2022 14:51:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TNxxOG4OoWeW; Wed,  2 Mar 2022 14:51:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4CA0281699;
	Wed,  2 Mar 2022 14:51:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32896C0012;
	Wed,  2 Mar 2022 14:51:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25C69C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 14:51:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 138D0410B0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 14:51:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uX2vESAluWSH
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 14:51:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 148EB410A8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 14:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646232686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3fg7E/wVm9novw7LlU1TTAanfNBt/gec/yk4Cr2PfyA=;
 b=PTIULJwP5KRaAottzaWkpLuxqSYLjMy6jvL1vi1FRayE8o0j2bc+Ln7ReYEJm4Y5kp2g//
 bwDXsNSwf5JtIuVcMZaZoZwnPwA+oE/UCMQbF9p/yLNk5xLsTv3VronL90y5J6f+Axi9Sy
 GWENYB4tCOstaCv+0ssYlhaXVybZ+fE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-8ayGwUEsOvCLBKY6Px0jBA-1; Wed, 02 Mar 2022 09:51:20 -0500
X-MC-Unique: 8ayGwUEsOvCLBKY6Px0jBA-1
Received: by mail-wr1-f71.google.com with SMTP id
 c5-20020adffb05000000b001edbbefe96dso719870wrr.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 06:51:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=3fg7E/wVm9novw7LlU1TTAanfNBt/gec/yk4Cr2PfyA=;
 b=Qb8n3Zt37z70ioMj8sBJG9NmTez+XIT1BWdMkshayeovzphjcUkn95/O+kqVtAlAns
 kK48ob9cpsHxQSOFZUz4Bc07Bzs0s9N6XtDw/hAjvkrD+HJ154d9DQxIBW3iX1NV3+A8
 Ga09YM41oy/ZkeattD8VlKe20FTRoyIpSx16arIemVXsMDlPgPb9bZzYpBpBUbNu4vGR
 jFJ63ItGs+MOhd95a3DcOVWLXtZeodqAPbSQtIq6N4BhanJU4Q17qVi06B4n22eQc3IB
 bSzsrbSHZFrVBeEq9JY4a+XOHZFZGU1veKuo7kMqiRK14PytH3WTE7pfkxbVkq1OkQsP
 RClg==
X-Gm-Message-State: AOAM532IC7VNdHaNP4dm3KjVs+YKMoL16jqq+qDim+lqDWG3NDG+X+f1
 LAo+Iv2wjPh0g4xY+GHOidgAAg/QWCRna3FIOzQ1famc99dPZ8dcIQe31y6ate1G/lNRdi0lNhU
 1DbXqpAyrZ/UyeAWca0tqQYs3pD0J9UkIulSU5YhDvQ==
X-Received: by 2002:a1c:a382:0:b0:381:cfd:5564 with SMTP id
 m124-20020a1ca382000000b003810cfd5564mr94722wme.103.1646232678502; 
 Wed, 02 Mar 2022 06:51:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgG53zJnBs87t0enH1Vr7OSUpE9VmdGsUbPEG/nzyOU4NmiWiPZnySacnC9rSCzqe/3NX4wg==
X-Received: by 2002:a1c:a382:0:b0:381:cfd:5564 with SMTP id
 m124-20020a1ca382000000b003810cfd5564mr94706wme.103.1646232678251; 
 Wed, 02 Mar 2022 06:51:18 -0800 (PST)
Received: from redhat.com ([2a10:8006:355c:0:48d6:b937:2fb9:b7de])
 by smtp.gmail.com with ESMTPSA id
 r1-20020a05600c2f0100b00381821b4dbdsm5737493wmn.6.2022.03.02.06.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 06:51:16 -0800 (PST)
Date: Wed, 2 Mar 2022 09:51:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <20220302095045-mutt-send-email-mst@kernel.org>
References: <20220302075421.2131221-1-lee.jones@linaro.org>
 <20220302082021-mutt-send-email-mst@kernel.org>
 <Yh93k2ZKJBIYQJjp@google.com>
MIME-Version: 1.0
In-Reply-To: <Yh93k2ZKJBIYQJjp@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

T24gV2VkLCBNYXIgMDIsIDIwMjIgYXQgMDE6NTY6MzVQTSArMDAwMCwgTGVlIEpvbmVzIHdyb3Rl
Ogo+IE9uIFdlZCwgMDIgTWFyIDIwMjIsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiAKPiA+
IE9uIFdlZCwgTWFyIDAyLCAyMDIyIGF0IDA3OjU0OjIxQU0gKzAwMDAsIExlZSBKb25lcyB3cm90
ZToKPiA+ID4gdmhvc3RfdnNvY2tfaGFuZGxlX3R4X2tpY2soKSBhbHJlYWR5IGhvbGRzIHRoZSBt
dXRleCBkdXJpbmcgaXRzIGNhbGwKPiA+ID4gdG8gdmhvc3RfZ2V0X3ZxX2Rlc2MoKS4gIEFsbCB3
ZSBoYXZlIHRvIGRvIGlzIHRha2UgdGhlIHNhbWUgbG9jawo+ID4gPiBkdXJpbmcgdmlydHF1ZXVl
IGNsZWFuLXVwIGFuZCB3ZSBtaXRpZ2F0ZSB0aGUgcmVwb3J0ZWQgaXNzdWVzLgo+ID4gPiAKPiA+
ID4gTGluazogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPTI3OTQzMmQz
MGQ4MjVlNjNiYTAwCj4gPiA+IAo+ID4gPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+Cj4g
PiA+IFJlcG9ydGVkLWJ5OiBzeXpib3QrYWRjM2NiMzIzODU1ODZiZWM4NTlAc3l6a2FsbGVyLmFw
cHNwb3RtYWlsLmNvbQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0Bs
aW5hcm8ub3JnPgo+ID4gPiAtLS0KPiA+ID4gIGRyaXZlcnMvdmhvc3Qvdmhvc3QuYyB8IDIgKysK
PiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPiA+ID4gCj4gPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiA+
ID4gaW5kZXggNTllZGI1YTFmZmUyOC4uYmJhZmY2YTVlMjFiOCAxMDA2NDQKPiA+ID4gLS0tIGEv
ZHJpdmVycy92aG9zdC92aG9zdC5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+
ID4gPiBAQCAtNjkzLDYgKzY5Myw3IEBAIHZvaWQgdmhvc3RfZGV2X2NsZWFudXAoc3RydWN0IHZo
b3N0X2RldiAqZGV2KQo+ID4gPiAgCWludCBpOwo+ID4gPiAgCj4gPiA+ICAJZm9yIChpID0gMDsg
aSA8IGRldi0+bnZxczsgKytpKSB7Cj4gPiA+ICsJCW11dGV4X2xvY2soJmRldi0+dnFzW2ldLT5t
dXRleCk7Cj4gPiA+ICAJCWlmIChkZXYtPnZxc1tpXS0+ZXJyb3JfY3R4KQo+ID4gPiAgCQkJZXZl
bnRmZF9jdHhfcHV0KGRldi0+dnFzW2ldLT5lcnJvcl9jdHgpOwo+ID4gPiAgCQlpZiAoZGV2LT52
cXNbaV0tPmtpY2spCj4gPiA+IEBAIC03MDAsNiArNzAxLDcgQEAgdm9pZCB2aG9zdF9kZXZfY2xl
YW51cChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpCj4gPiA+ICAJCWlmIChkZXYtPnZxc1tpXS0+Y2Fs
bF9jdHguY3R4KQo+ID4gPiAgCQkJZXZlbnRmZF9jdHhfcHV0KGRldi0+dnFzW2ldLT5jYWxsX2N0
eC5jdHgpOwo+ID4gPiAgCQl2aG9zdF92cV9yZXNldChkZXYsIGRldi0+dnFzW2ldKTsKPiA+ID4g
KwkJbXV0ZXhfdW5sb2NrKCZkZXYtPnZxc1tpXS0+bXV0ZXgpOwo+ID4gPiAgCX0KPiA+IAo+ID4g
U28gdGhpcyBpcyBhIG1pdGlnYXRpb24gcGxhbiBidXQgdGhlIGJ1ZyBpcyBzdGlsbCB0aGVyZSB0
aG91Z2gKPiA+IHdlIGRvbid0IGtub3cgZXhhY3RseSB3aGF0IGl0IGlzLiAgSSB3b3VsZCBwcmVm
ZXIgYWRkaW5nIHNvbWV0aGluZyBsaWtlCj4gPiBXQVJOX09OKG11dGV4X2lzX2xvY2tlZCh2cXNb
aV0tPm11dGV4KSBoZXJlIC0gZG9lcyB0aGlzIG1ha2Ugc2Vuc2U/Cj4gCj4gQXMgYSByZXdvcmsg
dG8gdGhpcywgb3IgYXMgYSBzdWJzZXF1ZW50IHBhdGNoPwoKQ2FuIGJlIGEgc2VwYXJhdGUgcGF0
Y2guCgo+IEp1c3QgYmVmb3JlIHRoZSBmaXJzdCBsb2NrIEkgYXNzdW1lPwoKSSBndWVzcyBzbywg
eWVzLgoKPiAtLSAKPiBMZWUgSm9uZXMgW+adjueQvOaWr10KPiBQcmluY2lwYWwgVGVjaG5pY2Fs
IExlYWQgLSBEZXZlbG9wZXIgU2VydmljZXMKPiBMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBz
b2Z0d2FyZSBmb3IgQXJtIFNvQ3MKPiBGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIg
fCBCbG9nCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4777BC6FD1B
	for <virtualization@archiver.kernel.org>; Tue,  7 Mar 2023 06:44:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7873B61039;
	Tue,  7 Mar 2023 06:44:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7873B61039
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OZ/WTMab
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GS9aU2SAgAhu; Tue,  7 Mar 2023 06:44:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F03D060FCC;
	Tue,  7 Mar 2023 06:44:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F03D060FCC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E5F6C008E;
	Tue,  7 Mar 2023 06:44:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EB2AC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 06:44:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D3C4600BB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 06:44:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D3C4600BB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mRWmBLOgr5m7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 06:44:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8462761029
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8462761029
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 06:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678171449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YLA0p3piGXRjn4NKlMPAnVQ/hmk7vNWwDG2Ot+WA0Ck=;
 b=OZ/WTMabjKiyDIDpm9KYPAIRamYFB4+MAW5JV65TZLXh6ApEUIUPkZqTXSjfeFeBz/gSKX
 d2KzxIGzvrSgtiHhqkB+USotcCtfPZMDPbqYuvL86rCTYUjCcsPnCfourTTxy5NgPTmuan
 Fn5RG0XzkNGhjrzPb45aUggW7TUx0HM=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-22m3gyK1PLm5oKcpWVR9cA-1; Tue, 07 Mar 2023 01:44:08 -0500
X-MC-Unique: 22m3gyK1PLm5oKcpWVR9cA-1
Received: by mail-ot1-f72.google.com with SMTP id
 j5-20020a9d7f05000000b00694125aba5bso5348956otq.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Mar 2023 22:44:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678171447;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YLA0p3piGXRjn4NKlMPAnVQ/hmk7vNWwDG2Ot+WA0Ck=;
 b=ABjaAEpNLOhiCY1+yb2P/XwjwXVojJqDTcg4pQDt0Pg33hffovkpdMH+P+axm8a7yo
 WfvQevBVFauBCuSZmcKi7xjf3O0iFukH1ZNGyOKnVLpnRmyr4afMHzawaL8kTmLUEO3E
 lyD2jBkErQ5RgpsdvlGKeMwmLJDR+Iu5GKamMZGBzKOJ3HKXwo+z/mlV0JxXM4Mb5tJ/
 QyCSd93FKs/PqsOuQKhHedlc7W5flPvS0kiO2LQHz9lJa8UIgKxQDOH9090zcgiCgJ3C
 IfDTMuBRsHCHSjDBhti96i9zkq8yrP/ZcJ5AZ7R1pturhv0yUzubBuazx4nyDDpZ91ob
 tuoQ==
X-Gm-Message-State: AO0yUKUIBsN5LDLlt/Ncg8q/Db1D2vLazer4LNeJMmuguNYMVpYUIllg
 hSjwCWqTwcLbPuWF7GeK0QNbtBupWn7BF8Uv3LB264ole348SPcB4Grv4y6tlPuSazgC6fBotVC
 0/RK4c+kdiy07HB4ll+6KIMvZgb1PGmv2K5wr9TPFfgKc/5OcKN1aYNnImCwmt+5kFDqKklo=
X-Received: by 2002:aca:1708:0:b0:37f:9a01:f661 with SMTP id
 j8-20020aca1708000000b0037f9a01f661mr3839483oii.9.1678171447310; 
 Mon, 06 Mar 2023 22:44:07 -0800 (PST)
X-Google-Smtp-Source: AK7set8AdDqnt0+yP3xLwjVIaQ3n1EQVpdS2ibw6+XSNXeHtC8t439rq/pfOQrgSJonNB6Yk+16AwVDleYY0Gbl72vU=
X-Received: by 2002:aca:1708:0:b0:37f:9a01:f661 with SMTP id
 j8-20020aca1708000000b0037f9a01f661mr3839476oii.9.1678171447099; Mon, 06 Mar
 2023 22:44:07 -0800 (PST)
MIME-Version: 1.0
References: <20230302115908.1461-1-xuanzhuo@linux.alibaba.com>
 <20230302115908.1461-10-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230302115908.1461-10-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 7 Mar 2023 14:43:56 +0800
Message-ID: <CACGkMEudA9CH8gE-Xzv81Wk0y7ARD52qCnCfrKz39TiTrapoig@mail.gmail.com>
Subject: Re: [PATCH vhost v1 09/12] virtio_ring: introduce
 virtqueue_get_dma_dev()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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

T24gVGh1LCBNYXIgMiwgMjAyMyBhdCA3OjU54oCvUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4KPiBBZGRlZCB2aXJ0cXVldWVfZ2V0X2RtYV9kZXYoKSB0
byBnZXQgRE1BIGRldmljZSBmb3IgdmlydGlvLiBUaGVuIHRoZQo+IGNhbGxlciBjYW4gZG8gZG1h
IG9wZXJhdGlvbiBpbiBhZHZhbmNlLiBUaGUgcHVycG9zZSBpcyB0byBrZWVwIG1lbW9yeQo+IG1h
cHBlZCBhY3Jvc3MgbXVsdGlwbGUgYWRkL2dldCBidWYgb3BlcmF0aW9ucy4KPgo+IFNpZ25lZC1v
ZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gLS0tCj4gIGRy
aXZlcnMvdmlydGlvL3ZpcnRpby5jICAgICAgfCAgNiArKysrKysKPiAgZHJpdmVycy92aXJ0aW8v
dmlydGlvX3JpbmcuYyB8IDE3ICsrKysrKysrKysrKysrKysrCj4gIGluY2x1ZGUvbGludXgvdmly
dGlvLmggICAgICAgfCAgMiArKwo+ICAzIGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKykK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW8uYyBiL2RyaXZlcnMvdmlydGlv
L3ZpcnRpby5jCj4gaW5kZXggYjlhODBhZWRlZTFiLi4wNjJiNjM4MWY1YzkgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW8u
Ywo+IEBAIC0xLDQgKzEsNSBAQAo+ICAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MC1vbmx5Cj4gKyNpbmNsdWRlIDxsaW51eC9kbWEtbWFwcGluZy5oPgo+ICAjaW5jbHVkZSA8bGlu
dXgvdmlydGlvLmg+Cj4gICNpbmNsdWRlIDxsaW51eC9zcGlubG9jay5oPgo+ICAjaW5jbHVkZSA8
bGludXgvdmlydGlvX2NvbmZpZy5oPgo+IEBAIC0yNDMsNiArMjQ0LDExIEBAIHN0YXRpYyBpbnQg
dmlydGlvX2Rldl9wcm9iZShzdHJ1Y3QgZGV2aWNlICpfZCkKPiAgICAgICAgIHU2NCBkcml2ZXJf
ZmVhdHVyZXM7Cj4gICAgICAgICB1NjQgZHJpdmVyX2ZlYXR1cmVzX2xlZ2FjeTsKPgo+ICsgICAg
ICAgX2QtPmRtYV9tYXNrID0gJl9kLT5jb2hlcmVudF9kbWFfbWFzazsKPiArICAgICAgIGVyciA9
IGRtYV9zZXRfbWFza19hbmRfY29oZXJlbnQoX2QsIERNQV9CSVRfTUFTSyg2NCkpOwo+ICsgICAg
ICAgaWYgKGVycikKPiArICAgICAgICAgICAgICAgcmV0dXJuIGVycjsKPiArCj4gICAgICAgICAv
KiBXZSBoYXZlIGEgZHJpdmVyISAqLwo+ICAgICAgICAgdmlydGlvX2FkZF9zdGF0dXMoZGV2LCBW
SVJUSU9fQ09ORklHX1NfRFJJVkVSKTsKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IDUzZGYx
MmE4YWI5Ny4uOWI2YTBmZWJhZTU4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTI0MDcs
NiArMjQwNywyMyBAQCBpbnQgdmlydHF1ZXVlX2FkZF9pbmJ1Zl9wcmVtYXBwZWQoc3RydWN0IHZp
cnRxdWV1ZSAqdnEsCj4gIH0KPiAgRVhQT1JUX1NZTUJPTF9HUEwodmlydHF1ZXVlX2FkZF9pbmJ1
Zl9wcmVtYXBwZWQpOwo+Cj4gKy8qKgo+ICsgKiB2aXJ0cXVldWVfZ2V0X2RtYV9kZXYgLSBleHBv
c2UgdGhlIGRtYSBkZXYKCk5pdDogSSBzdWdnZXN0IHRvIHVzZSAiZ2V0IiBpbnN0ZWFkIG9mICJl
eHBvc2UiLCBhbmQgY29uc2lkZXJpbmcgd2UKaGFkIHZyaW5nX2RtYV9kZXYoKSB3ZSBjYW4gc2lt
cGx5IHJlbmFtZSB0aGlzIGZ1bmN0aW9uIGFzCnZpcnRxdWV1ZV9kbWFfZGV2KCkuCgpPdGhlciB0
aGFuIHRoaXMKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhh
bmtzCgoKPiArICogQF92cTogdGhlIHN0cnVjdCB2aXJ0cXVldWUgd2UncmUgdGFsa2luZyBhYm91
dC4KPiArICoKPiArICogUmV0dXJucyB0aGUgZG1hIGRldi4gVGhhdCBjYW4gYmVlbiB1c2VkIGZv
ciBkbWEgYXBpLgo+ICsgKi8KPiArc3RydWN0IGRldmljZSAqdmlydHF1ZXVlX2dldF9kbWFfZGV2
KHN0cnVjdCB2aXJ0cXVldWUgKl92cSkKPiArewo+ICsgICAgICAgc3RydWN0IHZyaW5nX3ZpcnRx
dWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsKPiArCj4gKyAgICAgICBpZiAodnEtPnVzZV9kbWFfYXBp
KQo+ICsgICAgICAgICAgICAgICByZXR1cm4gdnJpbmdfZG1hX2Rldih2cSk7Cj4gKyAgICAgICBl
bHNlCj4gKyAgICAgICAgICAgICAgIHJldHVybiAmdnEtPnZxLnZkZXYtPmRldjsKPiArfQo+ICtF
WFBPUlRfU1lNQk9MX0dQTCh2aXJ0cXVldWVfZ2V0X2RtYV9kZXYpOwo+ICsKPiAgLyoqCj4gICAq
IHZpcnRxdWV1ZV9raWNrX3ByZXBhcmUgLSBmaXJzdCBoYWxmIG9mIHNwbGl0IHZpcnRxdWV1ZV9r
aWNrIGNhbGwuCj4gICAqIEBfdnE6IHRoZSBzdHJ1Y3QgdmlydHF1ZXVlCj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvdmlydGlvLmggYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gaW5kZXgg
M2ViYjM0NmViYjdjLi5hYzAyOGIwN2Y2ODQgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC92
aXJ0aW8uaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvLmgKPiBAQCAtNzEsNiArNzEsOCBA
QCBpbnQgdmlydHF1ZXVlX2FkZF9zZ3Moc3RydWN0IHZpcnRxdWV1ZSAqdnEsCj4gICAgICAgICAg
ICAgICAgICAgICAgIHZvaWQgKmRhdGEsCj4gICAgICAgICAgICAgICAgICAgICAgIGdmcF90IGdm
cCk7Cj4KPiArc3RydWN0IGRldmljZSAqdmlydHF1ZXVlX2dldF9kbWFfZGV2KHN0cnVjdCB2aXJ0
cXVldWUgKnZxKTsKPiArCj4gIGJvb2wgdmlydHF1ZXVlX2tpY2soc3RydWN0IHZpcnRxdWV1ZSAq
dnEpOwo+Cj4gIGJvb2wgdmlydHF1ZXVlX2tpY2tfcHJlcGFyZShzdHJ1Y3QgdmlydHF1ZXVlICp2
cSk7Cj4gLS0KPiAyLjMyLjAuMy5nMDExOTVjZjlmCj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA86C001DE
	for <virtualization@archiver.kernel.org>; Wed, 19 Jul 2023 22:26:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D25C640391;
	Wed, 19 Jul 2023 22:26:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D25C640391
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gwAcUwK0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ryMa8DcWVanp; Wed, 19 Jul 2023 22:26:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0135E4052C;
	Wed, 19 Jul 2023 22:26:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0135E4052C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC2BEC0072;
	Wed, 19 Jul 2023 22:26:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C257EC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 22:26:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 896454052C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 22:26:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 896454052C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JlRwsGpJChBg
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 22:26:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1B48640391
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 22:26:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1B48640391
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689805607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GRWr26/a3fW93qtfogg6jzmjztOmv2YuNrAH4tmN+jk=;
 b=gwAcUwK0THVyalMjP7ZGy4aKvIc7OoD9s73Ivzbv1KoBm2LaCej72DS0WDpNT49XpDaAXO
 bGnVooqmyjxzwhFDfLEVzsbtrp4pvE3XsUHlbeKcGK42reheDPg2Jy0IScBf2ohpFGLowh
 YhRALINxufYyc95bNVOhny7b+aQ+oWo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-6lUc9mCpM4ygVpvEbfT_Ew-1; Wed, 19 Jul 2023 18:26:45 -0400
X-MC-Unique: 6lUc9mCpM4ygVpvEbfT_Ew-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31437f02985so101667f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 15:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689805604; x=1692397604;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GRWr26/a3fW93qtfogg6jzmjztOmv2YuNrAH4tmN+jk=;
 b=OB4FM3pnNAhN/faAdOcludq4r4v3X1wCgleUd354vVv2ox2XF6/8cSlGyhO5KYLf71
 wFSuuW2anCQ5E5p2xsth5MAlEyj3khJYIfcgQSAjW7n2JMXJt6ChPzCaJWnTnxV/Befl
 wzDNyHMjleZYmLWzQGzNhg06GshuE9OvPwJ9s/FxlSQ/0Ph2pd4HnwqlnC1rccfX+nrz
 I7y8nCfyYthJN3lxEeYYeM2zyrrWNch/JVvZ6XQ80PzBYbPt68qlRobun5aA4zYiHUtz
 bu27je0wvxDbc654G8CDd2trRNCyTgZn8GRVCVdZxSNMX8IE13s84UFZqZ88p6EZ7lD/
 pegQ==
X-Gm-Message-State: ABy/qLYoIYLfjbyP3STi6hGdrsfy4kVL93Pz0YDMxRqiPTIEooO/xJPk
 Bopa3h71J/tbXiKUgZAypYP79Q/qT2puzpE+fQgm5nqiygHzwDffWAkVGxv0/2/MJZv3ORbhRBZ
 ZwJU2QZDN7gs2M58do1mHNC2z/Wuv5Cu6BEWAMsxdTw==
X-Received: by 2002:a05:6000:1042:b0:315:adee:1297 with SMTP id
 c2-20020a056000104200b00315adee1297mr891983wrx.10.1689805604600; 
 Wed, 19 Jul 2023 15:26:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEvlUX8tU5JXgVBrbk/KZWgr/MLOWrxY/kV5bYVSTY8sYIDCMK2pUOuvQQKyWa5poxeJ9b+2A==
X-Received: by 2002:a05:6000:1042:b0:315:adee:1297 with SMTP id
 c2-20020a056000104200b00315adee1297mr891970wrx.10.1689805604145; 
 Wed, 19 Jul 2023 15:26:44 -0700 (PDT)
Received: from redhat.com ([2.52.16.41]) by smtp.gmail.com with ESMTPSA id
 t7-20020a5d5347000000b003143add4396sm6313184wrv.22.2023.07.19.15.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 15:26:43 -0700 (PDT)
Date: Wed, 19 Jul 2023 18:26:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does
 not support it
Message-ID: <20230719182112-mutt-send-email-mst@kernel.org>
References: <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
 <20230704063646-mutt-send-email-mst@kernel.org>
 <CAJaqyWfdPpkD5pY4tfzQdOscLBcrDBhBqzWjMbY_ZKsoyiqGdA@mail.gmail.com>
 <20230704114159-mutt-send-email-mst@kernel.org>
 <CACGkMEtWjOMtsbgQ2sx=e1BkuRSyDmVfXDccCm-QSiSbacQyCA@mail.gmail.com>
 <CAJaqyWd0QC6x9WHBT0x9beZyC8ZrF2y=d9HvmT0+05RtGc8_og@mail.gmail.com>
 <eff34828-545b-956b-f400-89b585706fe4@amd.com>
 <20230706020603-mutt-send-email-mst@kernel.org>
 <1fdf73cb-f23e-0c34-f95f-f1bac74332da@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1fdf73cb-f23e-0c34-f95f-f1bac74332da@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio Perez Martin <eperezma@redhat.com>
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

T24gV2VkLCBKdWwgMTksIDIwMjMgYXQgMDM6MjA6MDNQTSAtMDcwMCwgU2ktV2VpIExpdSB3cm90
ZToKPiAKPiAKPiBPbiA3LzUvMjAyMyAxMTowNyBQTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gT24gV2VkLCBKdWwgMDUsIDIwMjMgYXQgMDU6MDc6MTFQTSAtMDcwMCwgU2hhbm5vbiBO
ZWxzb24gd3JvdGU6Cj4gPiA+IE9uIDcvNS8yMyAxMToyNyBBTSwgRXVnZW5pbyBQZXJleiBNYXJ0
aW4gd3JvdGU6Cj4gPiA+ID4gT24gV2VkLCBKdWwgNSwgMjAyMyBhdCA5OjUw4oCvQU0gSmFzb24g
V2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiBPbiBUdWUsIEp1bCA0
LCAyMDIzIGF0IDExOjQ14oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4gPiA+ID4gPiA+IE9uIFR1ZSwgSnVsIDA0LCAyMDIzIGF0IDAxOjM2OjExUE0gKzAy
MDAsIEV1Z2VuaW8gUGVyZXogTWFydGluIHdyb3RlOgo+ID4gPiA+ID4gPiA+IE9uIFR1ZSwgSnVs
IDQsIDIwMjMgYXQgMTI6MzjigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29t
PiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+IE9uIFR1ZSwgSnVsIDA0LCAyMDIzIGF0IDEyOjI1OjMy
UE0gKzAyMDAsIEV1Z2VuaW8gUGVyZXogTWFydGluIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiBP
biBNb24sIEp1bCAzLCAyMDIzIGF0IDQ6NTLigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBNb24sIEp1bCAwMywgMjAy
MyBhdCAwNDoyMjoxOFBNICswMjAwLCBFdWdlbmlvIFDDqXJleiB3cm90ZToKPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IFdpdGggdGhlIGN1cnJlbnQgY29kZSBpdCBpcyBhY2NlcHRlZCBhcyBsb25nIGFz
IHVzZXJsYW5kIHNlbmQgaXQuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IEFsdGhvdWdoIHVzZXJsYW5kIHNob3VsZCBub3Qgc2V0IGEgZmVhdHVyZSBmbGFnIHRo
YXQgaGFzIG5vdCBiZWVuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBvZmZlcmVkIHRvIGl0IHdpdGgg
VkhPU1RfR0VUX0JBQ0tFTkRfRkVBVFVSRVMsIHRoZSBjdXJyZW50IGNvZGUgd2lsbCBub3QKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IGNvbXBsYWluIGZvciBpdC4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gU2luY2UgdGhlcmUgaXMgbm8gc3BlY2lmaWMgcmVhc29u
IGZvciBhbnkgcGFyZW50IHRvIHJlamVjdCB0aGF0IGJhY2tlbmQKPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IGZlYXR1cmUgYml0IHdoZW4gaXQgaGFzIGJlZW4gcHJvcG9zZWQsIGxldCdzIGNvbnRyb2wg
aXQgYXQgdmRwYSBmcm9udGVuZAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gbGV2ZWwuIEZ1dHVyZSBw
YXRjaGVzIG1heSBtb3ZlIHRoaXMgY29udHJvbCB0byB0aGUgcGFyZW50IGRyaXZlci4KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gRml4ZXM6IDk2NzgwMGQyZDUy
ZSAoInZkcGE6IGFjY2VwdCBWSE9TVF9CQUNLRU5EX0ZfRU5BQkxFX0FGVEVSX0RSSVZFUl9PSyBi
YWNrZW5kIGZlYXR1cmUiKQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRXVn
ZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gUGxl
YXNlIGRvIHNlbmQgdjMuIEFuZCBhZ2FpbiwgSSBkb24ndCB3YW50IHRvIHNlbmQgImFmdGVyIGRy
aXZlciBvayIgaGFjawo+ID4gPiA+ID4gPiA+ID4gPiA+IHVwc3RyZWFtIGF0IGFsbCwgSSBtZXJn
ZWQgaXQgaW4gbmV4dCBqdXN0IHRvIGdpdmUgaXQgc29tZSB0ZXN0aW5nLgo+ID4gPiA+ID4gPiA+
ID4gPiA+IFdlIHdhbnQgUklOR19BQ0NFU1NfQUZURVJfS0lDSyBvciBzb21lIHN1Y2guCj4gPiA+
ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+IEN1cnJlbnQgZGV2aWNlcyBkbyBub3Qg
c3VwcG9ydCB0aGF0IHNlbWFudGljLgo+ID4gPiA+ID4gPiA+ID4gV2hpY2ggZGV2aWNlcyBzcGVj
aWZpY2FsbHkgYWNjZXNzIHRoZSByaW5nIGFmdGVyIERSSVZFUl9PSyBidXQgYmVmb3JlCj4gPiA+
ID4gPiA+ID4gPiBhIGtpY2s/Cj4gPiA+IFRoZSBQRFMgdmRwYSBkZXZpY2UgY2FuIGRlYWwgd2l0
aCBhIGNhbGwgdG8gLnNldF92cV9yZWFkeSBhZnRlciBEUklWRVJfT0sgaXMKPiA+ID4gc2V0LiAg
QW5kIEknbSB0b2xkIHRoYXQgb3VyIFZRIGFjdGl2aXR5IHNob3VsZCBzdGFydCB3aXRob3V0IGEg
a2ljay4KPiA+ID4gCj4gPiA+IE91ciB2ZHBhIGRldmljZSBGVyBkb2Vzbid0IGN1cnJlbnRseSBo
YXZlIHN1cHBvcnQgZm9yIFZJUlRJT19GX1JJTkdfUkVTRVQsCj4gPiA+IGJ1dCBJIGJlbGlldmUg
aXQgY291bGQgYmUgYWRkZWQgd2l0aG91dCB0b28gbXVjaCB0cm91YmxlLgo+ID4gPiAKPiA+ID4g
c2xuCj4gPiA+IAo+ID4gT0sgaXQgc2VlbXMgY2xlYXIgYXQgbGVhc3QgaW4gdGhlIGN1cnJlbnQg
dmVyc2lvbiBwZHMgbmVlZHMKPiA+IFZIT1NUX0JBQ0tFTkRfRl9FTkFCTEVfQUZURVJfRFJJVkVS
X09LLgo+ID4gSG93ZXZlciBjYW4gd2UgYWxzbyBjb2RlIHVwIHRoZSBSSU5HX1JFU0VUIHBhdGgg
YXMgdGhlIGRlZmF1bHQ/Cj4gV2hhdCdzIHRoZSByYXRpb25hbGUgb2YgbWFraW5nIFJJTkdfUkVT
RVQgcGF0aCB0aGUgZGVmYXVsdD8gTm90ZWQgdGhpcyBpcyBvbgo+IGEgcGVyZm9ybWFuY2UgY3Jp
dGljYWwgcGF0aCAoZm9yIGxpdmUgbWlncmF0aW9uIGRvd250aW1lKSwgZGlkIHdlIGV2ZXIgZ2V0
Cj4gY29uc2Vuc3VzIGZyb20gZXZlcnkgb3IgbW9zdCBoYXJkd2FyZSB2ZW5kb3JzIHRoYXQgUklO
R19SRVNFVCBoYXMgbG93ZXIgY29zdAo+IGluIHRlcm1zIG9mIGxhdGVuY3kgb3ZlcmFsbCB0aGFu
IEVOQUJMRV9BRlRFUl9EUklWRVJfT0s/IEkgdGhpbmsgKFJJTkcpUkVTRVQKPiBpbiBnZW5lcmFs
IGZhbGxzIG9uIHRoZSBzbG93IHBhdGggZm9yIGhhcmR3YXJlLCB3aGlsZSBJIGFzc3VtZSBlaXRo
ZXIKPiBSSU5HX1JFU0VUIG9yIEVOQUJMRV9BRlRFUl9EUklWRVJfT0sgZG9lc24ndCBtYXR0ZXJz
IG11Y2ggb24gc29mdHdhcmUgYmFja2VkCj4gdmRwYSBlLmcuIHZwX3ZkcGEuIE1heWJlIHNob3Vs
ZCBtYWtlIEVOQUJMRV9BRlRFUl9EUklWRVJfT0sgYXMgdGhlIGRlZmF1bHQ/Cj4gCj4gLVNpd2Vp
CgpDb21pbmcgZnJvbSB0aGUgc3BlYyBSSU5HX1JFU0VUIGhhcyBjbGVhcmVyIHNlbWFudGljcy4K
QXMgbG9uZyBhcyB3ZSBzdXBwb3J0IGl0IGl0IGlzIG5vdCBjcml0aWNhbCB3aGljaCBvbmUKaXMg
dGhlIGRlZmF1bHQgdGhvdWdoLgoKCj4gPiBUaGVuIGRvd24gdGhlIHJvYWQgdmVuZG9ycyBjYW4g
Y2hvb3NlIHdoYXQgdG8gZG8uCj4gPiAKPiA+IAo+ID4gCj4gPiAKPiA+IAo+ID4gPiA+ID4gPiA+
IFByZXZpb3VzIHZlcnNpb25zIG9mIHRoZSBRRU1VIExNIHNlcmllcyBkaWQgYSBzcHVyaW91cyBr
aWNrIHRvIHN0YXJ0Cj4gPiA+ID4gPiA+ID4gdHJhZmZpYyBhdCB0aGUgTE0gZGVzdGluYXRpb24g
WzFdLiBXaGVuIGl0IHdhcyBwcm9wb3NlZCwgdGhhdCBzcHVyaW91cwo+ID4gPiA+ID4gPiA+IGtp
Y2sgd2FzIHJlbW92ZWQgZnJvbSB0aGUgc2VyaWVzIGJlY2F1c2UgdG8gY2hlY2sgZm9yIGRlc2Ny
aXB0b3JzCj4gPiA+ID4gPiA+ID4gYWZ0ZXIgZHJpdmVyX29rLCBldmVuIHdpdGhvdXQgYSBraWNr
LCB3YXMgY29uc2lkZXJlZCB3b3JrIG9mIHRoZQo+ID4gPiA+ID4gPiA+IHBhcmVudCBkcml2ZXIu
Cj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gSSdtIG9rIHRvIGdvIGJhY2sgdG8gdGhpcyBz
cHVyaW91cyBraWNrLCBidXQgSSdtIG5vdCBzdXJlIGlmIHRoZSBodwo+ID4gPiA+ID4gPiA+IHdp
bGwgcmVhZCB0aGUgcmluZyBiZWZvcmUgdGhlIGtpY2sgYWN0dWFsbHkuIEkgY2FuIGFzay4KPiA+
ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiBUaGFua3MhCj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4g
PiA+ID4gWzFdIGh0dHBzOi8vbGlzdHMubm9uZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZl
bC8yMDIzLTAxL21zZzAyNzc1Lmh0bWwKPiA+ID4gPiA+ID4gTGV0J3MgZmluZCBvdXQuIFdlIG5l
ZWQgdG8gY2hlY2sgZm9yIEVOQUJMRV9BRlRFUl9EUklWRVJfT0sgdG9vLCBubz8KPiA+ID4gPiA+
IE15IHVuZGVyc3RhbmRpbmcgaXMgWzFdIGFzc3VtaW5nIEFDQ0VTU19BRlRFUl9LSUNLLiBUaGlz
IHNlZW1zCj4gPiA+ID4gPiBzdWItb3B0aW1hbCB0aGFuIGFzc3VtaW5nIEVOQUJMRV9BRlRFUl9E
UklWRVJfT0suCj4gPiA+ID4gPiAKPiA+ID4gPiA+IEJ1dCB0aGlzIHJlbWluZHMgbWUgb25lIHRo
aW5nLCBhcyB0aGUgdGhyZWFkIGlzIGdvaW5nIHRvbyBsb25nLCBJCj4gPiA+ID4gPiB3b25kZXIg
aWYgd2Ugc2ltcGx5IGFzc3VtZSBFTkFCTEVfQUZURVJfRFJJVkVSX09LIGlmIFJJTkdfUkVTRVQg
aXMKPiA+ID4gPiA+IHN1cHBvcnRlZD8KPiA+ID4gPiA+IAo+ID4gPiA+IFRoZSBwcm9ibGVtIHdp
dGggdGhhdCBpcyB0aGF0IHRoZSBkZXZpY2UgbmVlZHMgdG8gc3VwcG9ydCBhbGwKPiA+ID4gPiBS
SU5HX1JFU0VULCBsaWtlIHRvIGJlIGFibGUgdG8gY2hhbmdlIHZxIGFkZHJlc3MgZXRjIGFmdGVy
IERSSVZFUl9PSy4KPiA+ID4gPiBOb3QgYWxsIEhXIHN1cHBvcnQgaXQuCj4gPiA+ID4gCj4gPiA+
ID4gV2UganVzdCBuZWVkIHRoZSBzdWJzZXQgb2YgaGF2aW5nIHRoZSBkYXRhcGxhbmUgZnJlZXpl
ZCB1bnRpbCBhbGwgQ1ZRCj4gPiA+ID4gY29tbWFuZHMgaGF2ZSBiZWVuIGNvbnN1bWVkLiBJJ20g
c3VyZSBjdXJyZW50IHZEUEEgY29kZSBhbHJlYWR5Cj4gPiA+ID4gc3VwcG9ydHMgaXQgaW4gc29t
ZSBkZXZpY2VzLCBsaWtlIE1MWCBhbmQgUFNELgo+ID4gPiA+IAo+ID4gPiA+IFRoYW5rcyEKPiA+
ID4gPiAKPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4g
PiAKPiA+ID4gPiA+ID4gPiA+ID4gTXkgcGxhbiB3YXMgdG8gY29udmVydAo+ID4gPiA+ID4gPiA+
ID4gPiBpdCBpbiB2cF92ZHBhIGlmIG5lZWRlZCwgYW5kIHJldXNlIHRoZSBjdXJyZW50IHZkcGEg
b3BzLiBTb3JyeSBpZiBJCj4gPiA+ID4gPiA+ID4gPiA+IHdhcyBub3QgZXhwbGljaXQgZW5vdWdo
Lgo+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gVGhlIG9ubHkgc29sdXRpb24g
SSBjYW4gc2VlIHRvIHRoYXQgaXMgdG8gdHJhcCAmIGVtdWxhdGUgaW4gdGhlIHZkcGEKPiA+ID4g
PiA+ID4gPiA+ID4gKHBhcmVudD8pIGRyaXZlciwgYXMgdGFsa2VkIGluIHZpcnRpby1jb21tZW50
LiBCdXQgdGhhdCBjb21wbGljYXRlcwo+ID4gPiA+ID4gPiA+ID4gPiB0aGUgYXJjaGl0ZWN0dXJl
Ogo+ID4gPiA+ID4gPiA+ID4gPiAqIE9mZmVyIFZIT1NUX0JBQ0tFTkRfRl9SSU5HX0FDQ0VTU19B
RlRFUl9LSUNLCj4gPiA+ID4gPiA+ID4gPiA+ICogU3RvcmUgdnEgZW5hYmxlIHN0YXRlIHNlcGFy
YXRlbHksIGF0Cj4gPiA+ID4gPiA+ID4gPiA+IHZkcGEtPmNvbmZpZy0+c2V0X3ZxX3JlYWR5KHRy
dWUpLCBidXQgbm90IHRyYW5zbWl0IHRoYXQgZW5hYmxlIHRvIGh3Cj4gPiA+ID4gPiA+ID4gPiA+
ICogU3RvcmUgdGhlIGRvb3JiZWxsIHN0YXRlIHNlcGFyYXRlbHksIGJ1dCBkbyBub3QgY29uZmln
dXJlIGl0IHRvIHRoZQo+ID4gPiA+ID4gPiA+ID4gPiBkZXZpY2UgZGlyZWN0bHkuCj4gPiA+ID4g
PiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiBCdXQgaG93IHRvIHJlY292ZXIgaWYgdGhlIGRl
dmljZSBjYW5ub3QgY29uZmlndXJlIHRoZW0gYXQga2ljayB0aW1lLAo+ID4gPiA+ID4gPiA+ID4g
PiBmb3IgZXhhbXBsZT8KPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+IE1heWJl
IHdlIGNhbiBqdXN0IGZhaWwgaWYgdGhlIHBhcmVudCBkcml2ZXIgZG9lcyBub3Qgc3VwcG9ydCBl
bmFibGluZwo+ID4gPiA+ID4gPiA+ID4gPiB0aGUgdnEgYWZ0ZXIgRFJJVkVSX09LPyBUaGF0IHdh
eSBubyBuZXcgZmVhdHVyZSBmbGFnIGlzIG5lZWRlZC4KPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+
ID4gPiA+ID4gPiA+IFRoYW5rcyEKPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiAtLS0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNlbnQgd2l0aCBGaXhlczogdGFnIHBvaW50
aW5nIHRvIGdpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9tc3QKPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IGNvbW1pdC4gUGxlYXNlIGxldCBtZSBrbm93IGlmIEkgc2hvdWxkIHNl
bmQgYSB2MyBvZiBbMV0gaW5zdGVhZC4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMzA2MDkxMjEy
NDQtbXV0dC1zZW5kLWVtYWlsLW1zdEBrZXJuZWwub3JnL1QvCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiAtLS0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgNyAr
KysrKy0tCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zo
b3N0L3ZkcGEuYwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gaW5kZXggZTFhYmYyOWZlZDViLi5hN2U1
NTQzNTIzNTEgMTAwNjQ0Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3Zob3N0
L3ZkcGEuYwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMK
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IEBAIC02ODEsMTggKzY4MSwyMSBAQCBzdGF0aWMgbG9uZyB2
aG9zdF92ZHBhX3VubG9ja2VkX2lvY3RsKHN0cnVjdCBmaWxlICpmaWxlcCwKPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ICAgIHsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgc3RydWN0IHZob3N0
X3ZkcGEgKnYgPSBmaWxlcC0+cHJpdmF0ZV9kYXRhOwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAg
ICAgICBzdHJ1Y3Qgdmhvc3RfZGV2ICpkID0gJnYtPnZkZXY7Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiArICAgICBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2LT52ZHBhLT5jb25m
aWc7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgIHZvaWQgX191c2VyICphcmdwID0gKHZv
aWQgX191c2VyICopYXJnOwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICB1NjQgX191c2Vy
ICpmZWF0dXJlcCA9IGFyZ3A7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAtICAgICB1NjQgZmVhdHVy
ZXM7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiArICAgICB1NjQgZmVhdHVyZXMsIHBhcmVudF9mZWF0
dXJlcyA9IDA7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgIGxvbmcgciA9IDA7Cj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgaWYgKGNtZCA9
PSBWSE9TVF9TRVRfQkFDS0VORF9GRUFUVVJFUykgewo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAg
ICAgICAgICAgICAgIGlmIChjb3B5X2Zyb21fdXNlcigmZmVhdHVyZXMsIGZlYXR1cmVwLCBzaXpl
b2YoZmVhdHVyZXMpKSkKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiAtRUZBVUxUOwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICBp
ZiAob3BzLT5nZXRfYmFja2VuZF9mZWF0dXJlcykKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICBwYXJlbnRfZmVhdHVyZXMgPSBvcHMtPmdldF9iYWNrZW5kX2ZlYXR1
cmVzKHYtPnZkcGEpOwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgIGlmIChm
ZWF0dXJlcyAmIH4oVkhPU1RfVkRQQV9CQUNLRU5EX0ZFQVRVUkVTIHwKPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJJVF9VTEwoVkhPU1RfQkFD
S0VORF9GX1NVU1BFTkQpIHwKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX1JFU1VNRSkgfAo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJJVF9VTEwoVkhP
U1RfQkFDS0VORF9GX0VOQUJMRV9BRlRFUl9EUklWRVJfT0spKSkKPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwYXJlbnRfZmVhdHVyZXMpKQo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RT
VVBQOwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgIGlmICgoZmVhdHVyZXMg
JiBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9TVVNQRU5EKSkgJiYKPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ICAgICAgICAgICAgICAgICAgICAgICF2aG9zdF92ZHBhX2Nhbl9zdXNwZW5kKHYpKQo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gLS0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IDIuMzkuMwo+ID4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiA+IFZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdAo+ID4gVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKPiA+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

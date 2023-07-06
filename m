Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8177FEB64DD
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 01:55:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0375F60BF1;
	Thu,  6 Jul 2023 01:55:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0375F60BF1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qn+P0ijJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ecbygBZhjs7k; Thu,  6 Jul 2023 01:55:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 466DF60BB9;
	Thu,  6 Jul 2023 01:55:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 466DF60BB9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F701C0071;
	Thu,  6 Jul 2023 01:55:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FF8EC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 01:55:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3C38160BE8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 01:55:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3C38160BE8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aSgtBMKjdeDa
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 01:55:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D349460BB9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D349460BB9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 01:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688608540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u4oDji0pnQjBPZE3409rybSrvPTs16jwzEuyNSmoWi0=;
 b=Qn+P0ijJreXwYedVmnlTJZtYVVoEmwQ5zzwZskR1CmzWzcTLAoa2pHRErc3I040G/3mqHD
 lTtZWXA5RBGRzrnQI4UF+Qu2leMrUevsyEDKRqzjP/vztPc6iXZhyejdpOUzH5eG4hXqiy
 1TWtebRmv5IGHHd2Ksa43jB5JtweySg=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-xSRAnUG2NYmzbmU-WiYMuA-1; Wed, 05 Jul 2023 21:55:39 -0400
X-MC-Unique: xSRAnUG2NYmzbmU-WiYMuA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b698377ed7so1126831fa.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Jul 2023 18:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688608538; x=1691200538;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u4oDji0pnQjBPZE3409rybSrvPTs16jwzEuyNSmoWi0=;
 b=kM7fmHMme7D1ElA4Tof4uYSi4YR5Vswx2x6vuCS72BnVu8mWJueWV6shNZ/p+EQgms
 OaZVxXXUHXFrr/Aw7QJ1nfJe9NdkdlfKXwgWGoiSvGBVM6xOqtiaa1ooWmiiVvAjAKS7
 qKOPNTElKhL1j9tnqptVB2K2POYEQsiMRwlnqYxwtOc+NCI4pqRbA9mwvzl+AdWhpf39
 PfIBPFG3RPXL8SfHS9agsCLTaot7tVNjOpzQ5Am7R8rezwsCiAgVS60wymeWu1HPbL3p
 GDkKrcXeRQ8JSVCF/dF6vvIM2SUn8GrepqTTfpt5uHpArebVItk1XOFjuf7HJFPC6H8i
 xTfA==
X-Gm-Message-State: ABy/qLbHifY0bENmnwa41bCFzi1LjW/D9s+tOwFQfKDG/yz6TwUOKF6B
 m6iAwzaoqfOttGyvR33b9FIB8Z23ATR47VgiQXftEsaUccRlePYsYYz/c3aJyZxMlhwlpE2AqwH
 QwiybXdOcvAFdPj/T0v2FML5lX0YX+hPFzkQcST/ngp8N+beo5pc6Uotucg==
X-Received: by 2002:a2e:6a05:0:b0:2b6:e10a:a9b with SMTP id
 f5-20020a2e6a05000000b002b6e10a0a9bmr245846ljc.26.1688608537857; 
 Wed, 05 Jul 2023 18:55:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHgWAJSVdWWCkpGlV699dPhWPv844SliSf2RkOP2SP0+DOWdaEzY8qOW4IMuOO9EKsYchCQiS3Os6UX/qiEM3o=
X-Received: by 2002:a2e:6a05:0:b0:2b6:e10a:a9b with SMTP id
 f5-20020a2e6a05000000b002b6e10a0a9bmr245839ljc.26.1688608537515; Wed, 05 Jul
 2023 18:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230703142218.362549-1-eperezma@redhat.com>
 <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
 <20230704063646-mutt-send-email-mst@kernel.org>
 <CAJaqyWfdPpkD5pY4tfzQdOscLBcrDBhBqzWjMbY_ZKsoyiqGdA@mail.gmail.com>
 <20230704114159-mutt-send-email-mst@kernel.org>
 <CACGkMEtWjOMtsbgQ2sx=e1BkuRSyDmVfXDccCm-QSiSbacQyCA@mail.gmail.com>
 <20230705043940-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230705043940-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Jul 2023 09:55:26 +0800
Message-ID: <CACGkMEufNZGvWMN9Shh6NPOZOe-vf0RomfS1DX6DtxJjvO7fNA@mail.gmail.com>
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does not
 support it
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

T24gV2VkLCBKdWwgNSwgMjAyMyBhdCA0OjQx4oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIEp1bCAwNSwgMjAyMyBhdCAwMzo0OTo1OFBN
ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gT24gVHVlLCBKdWwgNCwgMjAyMyBhdCAxMTo0
NeKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+
ID4gPiBPbiBUdWUsIEp1bCAwNCwgMjAyMyBhdCAwMTozNjoxMVBNICswMjAwLCBFdWdlbmlvIFBl
cmV6IE1hcnRpbiB3cm90ZToKPiA+ID4gPiBPbiBUdWUsIEp1bCA0LCAyMDIzIGF0IDEyOjM44oCv
UE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPgo+
ID4gPiA+ID4gT24gVHVlLCBKdWwgMDQsIDIwMjMgYXQgMTI6MjU6MzJQTSArMDIwMCwgRXVnZW5p
byBQZXJleiBNYXJ0aW4gd3JvdGU6Cj4gPiA+ID4gPiA+IE9uIE1vbiwgSnVsIDMsIDIwMjMgYXQg
NDo1MuKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gT24gTW9uLCBKdWwgMDMsIDIwMjMgYXQgMDQ6MjI6MThQ
TSArMDIwMCwgRXVnZW5pbyBQw6lyZXogd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiBXaXRoIHRoZSBj
dXJyZW50IGNvZGUgaXQgaXMgYWNjZXB0ZWQgYXMgbG9uZyBhcyB1c2VybGFuZCBzZW5kIGl0Lgo+
ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IEFsdGhvdWdoIHVzZXJsYW5kIHNob3VsZCBu
b3Qgc2V0IGEgZmVhdHVyZSBmbGFnIHRoYXQgaGFzIG5vdCBiZWVuCj4gPiA+ID4gPiA+ID4gPiBv
ZmZlcmVkIHRvIGl0IHdpdGggVkhPU1RfR0VUX0JBQ0tFTkRfRkVBVFVSRVMsIHRoZSBjdXJyZW50
IGNvZGUgd2lsbCBub3QKPiA+ID4gPiA+ID4gPiA+IGNvbXBsYWluIGZvciBpdC4KPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBTaW5jZSB0aGVyZSBpcyBubyBzcGVjaWZpYyByZWFzb24g
Zm9yIGFueSBwYXJlbnQgdG8gcmVqZWN0IHRoYXQgYmFja2VuZAo+ID4gPiA+ID4gPiA+ID4gZmVh
dHVyZSBiaXQgd2hlbiBpdCBoYXMgYmVlbiBwcm9wb3NlZCwgbGV0J3MgY29udHJvbCBpdCBhdCB2
ZHBhIGZyb250ZW5kCj4gPiA+ID4gPiA+ID4gPiBsZXZlbC4gRnV0dXJlIHBhdGNoZXMgbWF5IG1v
dmUgdGhpcyBjb250cm9sIHRvIHRoZSBwYXJlbnQgZHJpdmVyLgo+ID4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiA+IEZpeGVzOiA5Njc4MDBkMmQ1MmUgKCJ2ZHBhOiBhY2NlcHQgVkhPU1RfQkFD
S0VORF9GX0VOQUJMRV9BRlRFUl9EUklWRVJfT0sgYmFja2VuZCBmZWF0dXJlIikKPiA+ID4gPiA+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29t
Pgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gUGxlYXNlIGRvIHNlbmQgdjMuIEFuZCBhZ2Fp
biwgSSBkb24ndCB3YW50IHRvIHNlbmQgImFmdGVyIGRyaXZlciBvayIgaGFjawo+ID4gPiA+ID4g
PiA+IHVwc3RyZWFtIGF0IGFsbCwgSSBtZXJnZWQgaXQgaW4gbmV4dCBqdXN0IHRvIGdpdmUgaXQg
c29tZSB0ZXN0aW5nLgo+ID4gPiA+ID4gPiA+IFdlIHdhbnQgUklOR19BQ0NFU1NfQUZURVJfS0lD
SyBvciBzb21lIHN1Y2guCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gQ3Vy
cmVudCBkZXZpY2VzIGRvIG5vdCBzdXBwb3J0IHRoYXQgc2VtYW50aWMuCj4gPiA+ID4gPgo+ID4g
PiA+ID4gV2hpY2ggZGV2aWNlcyBzcGVjaWZpY2FsbHkgYWNjZXNzIHRoZSByaW5nIGFmdGVyIERS
SVZFUl9PSyBidXQgYmVmb3JlCj4gPiA+ID4gPiBhIGtpY2s/Cj4gPiA+ID4gPgo+ID4gPiA+Cj4g
PiA+ID4gUHJldmlvdXMgdmVyc2lvbnMgb2YgdGhlIFFFTVUgTE0gc2VyaWVzIGRpZCBhIHNwdXJp
b3VzIGtpY2sgdG8gc3RhcnQKPiA+ID4gPiB0cmFmZmljIGF0IHRoZSBMTSBkZXN0aW5hdGlvbiBb
MV0uIFdoZW4gaXQgd2FzIHByb3Bvc2VkLCB0aGF0IHNwdXJpb3VzCj4gPiA+ID4ga2ljayB3YXMg
cmVtb3ZlZCBmcm9tIHRoZSBzZXJpZXMgYmVjYXVzZSB0byBjaGVjayBmb3IgZGVzY3JpcHRvcnMK
PiA+ID4gPiBhZnRlciBkcml2ZXJfb2ssIGV2ZW4gd2l0aG91dCBhIGtpY2ssIHdhcyBjb25zaWRl
cmVkIHdvcmsgb2YgdGhlCj4gPiA+ID4gcGFyZW50IGRyaXZlci4KPiA+ID4gPgo+ID4gPiA+IEkn
bSBvayB0byBnbyBiYWNrIHRvIHRoaXMgc3B1cmlvdXMga2ljaywgYnV0IEknbSBub3Qgc3VyZSBp
ZiB0aGUgaHcKPiA+ID4gPiB3aWxsIHJlYWQgdGhlIHJpbmcgYmVmb3JlIHRoZSBraWNrIGFjdHVh
bGx5LiBJIGNhbiBhc2suCj4gPiA+ID4KPiA+ID4gPiBUaGFua3MhCj4gPiA+ID4KPiA+ID4gPiBb
MV0gaHR0cHM6Ly9saXN0cy5ub25nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMjMt
MDEvbXNnMDI3NzUuaHRtbAo+ID4gPgo+ID4gPiBMZXQncyBmaW5kIG91dC4gV2UgbmVlZCB0byBj
aGVjayBmb3IgRU5BQkxFX0FGVEVSX0RSSVZFUl9PSyB0b28sIG5vPwo+ID4KPiA+IE15IHVuZGVy
c3RhbmRpbmcgaXMgWzFdIGFzc3VtaW5nIEFDQ0VTU19BRlRFUl9LSUNLLiBUaGlzIHNlZW1zCj4g
PiBzdWItb3B0aW1hbCB0aGFuIGFzc3VtaW5nIEVOQUJMRV9BRlRFUl9EUklWRVJfT0suCj4gPgo+
ID4gQnV0IHRoaXMgcmVtaW5kcyBtZSBvbmUgdGhpbmcsIGFzIHRoZSB0aHJlYWQgaXMgZ29pbmcg
dG9vIGxvbmcsIEkKPiA+IHdvbmRlciBpZiB3ZSBzaW1wbHkgYXNzdW1lIEVOQUJMRV9BRlRFUl9E
UklWRVJfT0sgaWYgUklOR19SRVNFVCBpcwo+ID4gc3VwcG9ydGVkPwo+ID4KPiA+IFRoYW5rcwo+
Cj4gSSBkb24ndCBzZWUgd2hhdCBkb2VzIG9uZSBoYXZlIHRvIGRvIHdpdGggYW5vdGhlciAuLi4K
Pgo+IEkgdGhpbmsgd2l0aCBSSU5HX1JFU0VUIHdlIGhhZCBhbm90aGVyIHNvbHV0aW9uLCBlbmFi
bGUgcmluZ3MKPiBtYXBwaW5nIHRoZW0gdG8gYSB6ZXJvIHBhZ2UsIHRoZW4gcmVzZXQgYW5kIHJl
LWVuYWJsZSBsYXRlci4KCkFzIGRpc2N1c3NlZCBiZWZvcmUsIHRoaXMgc2VlbXMgdG8gaGF2ZSBz
b21lIHByb2JsZW1zOgoKMSkgVGhlIGJlaGF2aW91ciBpcyBub3QgY2xhcmlmaWVkIGluIHRoZSBk
b2N1bWVudAoyKSB6ZXJvIGlzIGEgdmFsaWQgSU9WQQoKVGhhbmtzCgo+Cj4gPiA+Cj4gPiA+Cj4g
PiA+Cj4gPiA+ID4gPiA+IE15IHBsYW4gd2FzIHRvIGNvbnZlcnQKPiA+ID4gPiA+ID4gaXQgaW4g
dnBfdmRwYSBpZiBuZWVkZWQsIGFuZCByZXVzZSB0aGUgY3VycmVudCB2ZHBhIG9wcy4gU29ycnkg
aWYgSQo+ID4gPiA+ID4gPiB3YXMgbm90IGV4cGxpY2l0IGVub3VnaC4KPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gVGhlIG9ubHkgc29sdXRpb24gSSBjYW4gc2VlIHRvIHRoYXQgaXMgdG8gdHJhcCAm
IGVtdWxhdGUgaW4gdGhlIHZkcGEKPiA+ID4gPiA+ID4gKHBhcmVudD8pIGRyaXZlciwgYXMgdGFs
a2VkIGluIHZpcnRpby1jb21tZW50LiBCdXQgdGhhdCBjb21wbGljYXRlcwo+ID4gPiA+ID4gPiB0
aGUgYXJjaGl0ZWN0dXJlOgo+ID4gPiA+ID4gPiAqIE9mZmVyIFZIT1NUX0JBQ0tFTkRfRl9SSU5H
X0FDQ0VTU19BRlRFUl9LSUNLCj4gPiA+ID4gPiA+ICogU3RvcmUgdnEgZW5hYmxlIHN0YXRlIHNl
cGFyYXRlbHksIGF0Cj4gPiA+ID4gPiA+IHZkcGEtPmNvbmZpZy0+c2V0X3ZxX3JlYWR5KHRydWUp
LCBidXQgbm90IHRyYW5zbWl0IHRoYXQgZW5hYmxlIHRvIGh3Cj4gPiA+ID4gPiA+ICogU3RvcmUg
dGhlIGRvb3JiZWxsIHN0YXRlIHNlcGFyYXRlbHksIGJ1dCBkbyBub3QgY29uZmlndXJlIGl0IHRv
IHRoZQo+ID4gPiA+ID4gPiBkZXZpY2UgZGlyZWN0bHkuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
IEJ1dCBob3cgdG8gcmVjb3ZlciBpZiB0aGUgZGV2aWNlIGNhbm5vdCBjb25maWd1cmUgdGhlbSBh
dCBraWNrIHRpbWUsCj4gPiA+ID4gPiA+IGZvciBleGFtcGxlPwo+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiBNYXliZSB3ZSBjYW4ganVzdCBmYWlsIGlmIHRoZSBwYXJlbnQgZHJpdmVyIGRvZXMgbm90
IHN1cHBvcnQgZW5hYmxpbmcKPiA+ID4gPiA+ID4gdGhlIHZxIGFmdGVyIERSSVZFUl9PSz8gVGhh
dCB3YXkgbm8gbmV3IGZlYXR1cmUgZmxhZyBpcyBuZWVkZWQuCj4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+IFRoYW5rcyEKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gLS0t
Cj4gPiA+ID4gPiA+ID4gPiBTZW50IHdpdGggRml4ZXM6IHRhZyBwb2ludGluZyB0byBnaXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbXN0Cj4gPiA+ID4gPiA+ID4gPiBjb21t
aXQuIFBsZWFzZSBsZXQgbWUga25vdyBpZiBJIHNob3VsZCBzZW5kIGEgdjMgb2YgWzFdIGluc3Rl
YWQuCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gWzFdIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvMjAyMzA2MDkxMjEyNDQtbXV0dC1zZW5kLWVtYWlsLW1zdEBrZXJuZWwub3Jn
L1QvCj4gPiA+ID4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ID4gPiA+ICBkcml2ZXJzL3Zob3N0L3Zk
cGEuYyB8IDcgKysrKystLQo+ID4gPiA+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMK
PiA+ID4gPiA+ID4gPiA+IGluZGV4IGUxYWJmMjlmZWQ1Yi4uYTdlNTU0MzUyMzUxIDEwMDY0NAo+
ID4gPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+ID4gPiA+ID4gPiA+
ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gPiA+ID4gPiA+ID4gPiBAQCAtNjgxLDE4ICs2
ODEsMjEgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV91bmxvY2tlZF9pb2N0bChzdHJ1Y3QgZmls
ZSAqZmlsZXAsCj4gPiA+ID4gPiA+ID4gPiAgewo+ID4gPiA+ID4gPiA+ID4gICAgICAgc3RydWN0
IHZob3N0X3ZkcGEgKnYgPSBmaWxlcC0+cHJpdmF0ZV9kYXRhOwo+ID4gPiA+ID4gPiA+ID4gICAg
ICAgc3RydWN0IHZob3N0X2RldiAqZCA9ICZ2LT52ZGV2Owo+ID4gPiA+ID4gPiA+ID4gKyAgICAg
Y29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdi0+dmRwYS0+Y29uZmlnOwo+ID4g
PiA+ID4gPiA+ID4gICAgICAgdm9pZCBfX3VzZXIgKmFyZ3AgPSAodm9pZCBfX3VzZXIgKilhcmc7
Cj4gPiA+ID4gPiA+ID4gPiAgICAgICB1NjQgX191c2VyICpmZWF0dXJlcCA9IGFyZ3A7Cj4gPiA+
ID4gPiA+ID4gPiAtICAgICB1NjQgZmVhdHVyZXM7Cj4gPiA+ID4gPiA+ID4gPiArICAgICB1NjQg
ZmVhdHVyZXMsIHBhcmVudF9mZWF0dXJlcyA9IDA7Cj4gPiA+ID4gPiA+ID4gPiAgICAgICBsb25n
IHIgPSAwOwo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ICAgICAgIGlmIChjbWQgPT0g
VkhPU1RfU0VUX0JBQ0tFTkRfRkVBVFVSRVMpIHsKPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAg
ICAgaWYgKGNvcHlfZnJvbV91c2VyKCZmZWF0dXJlcywgZmVhdHVyZXAsIHNpemVvZihmZWF0dXJl
cykpKQo+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUZBVUxU
Owo+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICBpZiAob3BzLT5nZXRfYmFja2VuZF9mZWF0
dXJlcykKPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBwYXJlbnRfZmVhdHVy
ZXMgPSBvcHMtPmdldF9iYWNrZW5kX2ZlYXR1cmVzKHYtPnZkcGEpOwo+ID4gPiA+ID4gPiA+ID4g
ICAgICAgICAgICAgICBpZiAoZmVhdHVyZXMgJiB+KFZIT1NUX1ZEUEFfQkFDS0VORF9GRUFUVVJF
UyB8Cj4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQklUX1VM
TChWSE9TVF9CQUNLRU5EX0ZfU1VTUEVORCkgfAo+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX1JFU1VNRSkgfAo+ID4g
PiA+ID4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJJVF9VTEwoVkhPU1Rf
QkFDS0VORF9GX0VOQUJMRV9BRlRFUl9EUklWRVJfT0spKSkKPiA+ID4gPiA+ID4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBwYXJlbnRfZmVhdHVyZXMpKQo+ID4gPiA+ID4gPiA+
ID4gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU9QTk9UU1VQUDsKPiA+ID4gPiA+ID4g
PiA+ICAgICAgICAgICAgICAgaWYgKChmZWF0dXJlcyAmIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9G
X1NVU1BFTkQpKSAmJgo+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICF2aG9zdF92
ZHBhX2Nhbl9zdXNwZW5kKHYpKQo+ID4gPiA+ID4gPiA+ID4gLS0KPiA+ID4gPiA+ID4gPiA+IDIu
MzkuMwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPgo+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0166CD68ED
	for <virtualization@archiver.kernel.org>; Tue, 10 Oct 2023 05:45:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3BD2860E41;
	Tue, 10 Oct 2023 05:45:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3BD2860E41
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gdjLTAHT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V8qmXQ6hQSda; Tue, 10 Oct 2023 05:45:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5FA6860E37;
	Tue, 10 Oct 2023 05:45:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5FA6860E37
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32C2CC0071;
	Tue, 10 Oct 2023 05:45:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93FFCC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 05:45:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6FB1D81BA8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 05:45:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6FB1D81BA8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gdjLTAHT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 10Zms-Z8OjfJ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 05:45:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 35ED681B7B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 05:45:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 35ED681B7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696916733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P+I2EY4NGx452ATYzw4Kz0XF6aTAAXvBTqSjZlE93qM=;
 b=gdjLTAHTWNEETbqo6CYPnxiLm05MEVNnDPtqGX81PVKl5g56m/knu8mHlELVyp0ggySTVL
 fNC6hBhSMIGjMBA/fP0Af8TnJDGwywdgYZU47HYY0QsfZ6z3vYBNyzwHse4qW+GBKVFctq
 p51ZIzVg1BGKzgx5cA77RekUkzX4zPk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-i1PBctuLNSShUqSPGfMP2g-1; Tue, 10 Oct 2023 01:45:26 -0400
X-MC-Unique: i1PBctuLNSShUqSPGfMP2g-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5056cc81e30so4605599e87.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Oct 2023 22:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696916725; x=1697521525;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P+I2EY4NGx452ATYzw4Kz0XF6aTAAXvBTqSjZlE93qM=;
 b=oMqBg0Z8DRv70vERhl2hn221ET0ps7Z4OLT8snFbQ+dF5c+mcpKATsoku7/53f6nEW
 MeRAZa1r7vvCEQJ1iLokUmvwu0RmiuSTCGixZOZ493oVc3PLCuhPSXdEzCmpA/GFbaPO
 QjwY87Gy6QOxkr+bavZe8L7sY1KPGxFukx2vW+VFAohUf9XNvvhLhwXua82GISwOOc5j
 K2rF87UnbVLgXbwsPidxm5ZiwSENY272w+OjQvPCihrBRCKQOt08TMoxjrPZ/tSei1wa
 j8DAAhuSEIk2aNvri7U8EdB0ZdV/dh3NYn0oLMdj2KhZzIRjrEM04n12mkJtJIf0AttT
 7peQ==
X-Gm-Message-State: AOJu0Yy0AngBrlggewH3S6BTAhikPm6ejNv/IeKrbPHTECu5HR1GpWl8
 5CAdrCFuauNx43PRg3L5kelg4+9/Vf1trFmNQDdvZRslWRLcORp/bzX/Fb2BiW4Ewjm/Ck/Xk54
 2+3qX5jM2ffKrq6zspG6mNgZCbRsW3ohRZotnHDxNJtb6Lqapq570+dzdOw==
X-Received: by 2002:a05:6512:ea9:b0:500:b2f6:592 with SMTP id
 bi41-20020a0565120ea900b00500b2f60592mr18281189lfb.50.1696916725103; 
 Mon, 09 Oct 2023 22:45:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+pwNtTVbI2Ms4EjKlIUtAy5k+rLiIL3TUr1dcb8YFsqYJmXGlmcetJxkpWxQ3ditYPytVqKZpNg5+JzyWzwk=
X-Received: by 2002:a05:6512:ea9:b0:500:b2f6:592 with SMTP id
 bi41-20020a0565120ea900b00500b2f60592mr18281158lfb.50.1696916724673; Mon, 09
 Oct 2023 22:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-6-akihiko.odaki@daynix.com>
 <CAF=yD-LdwcXKK66s5gvJNOH8qCWRt3SvEL-GkkVif=kkOaYGhg@mail.gmail.com>
 <8f4ad5bc-b849-4ef4-ac1f-8d5a796205e9@daynix.com>
 <CAF=yD-+DjDqE9iBu+PvbeBby=C4CCwG=fMFONQONrsErmps3ww@mail.gmail.com>
 <286508a3-3067-456d-8bbf-176b00dcc0c6@daynix.com>
 <CAF=yD-+syCSJz_wp25rEaHTXMFRHgLh1M-uTdNWPb4fnrKgpFw@mail.gmail.com>
 <8711b549-094d-4be2-b7af-bd93b7516c05@daynix.com>
 <CAF=yD-+M75o2=yDy5d03fChuNTeeTRkUU7rPRG1i6O9aZGhLmQ@mail.gmail.com>
 <695a0611-2b19-49f9-8d32-cfea3b7df0b2@daynix.com>
 <CAF=yD-+_PLPt9qfXy1Ljr=Lou0W8hCJLi6HwPcZYCjJy+SKtbA@mail.gmail.com>
 <5baab0cf-7adf-475d-8968-d46ddd179f9a@daynix.com>
 <CAF=yD-KjvycgFrfKu5CgGGWU-3HbyXt_APQy4tqZgNtJwAUKzg@mail.gmail.com>
 <8f3ed081-134c-45a0-9208-c1cab29cdf37@daynix.com>
In-Reply-To: <8f3ed081-134c-45a0-9208-c1cab29cdf37@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Oct 2023 13:45:11 +0800
Message-ID: <CACGkMEv0tpn4YsJhXXnoispYx2-VBimFAtFmf85Uo=5=6taVuw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/7] tun: Introduce virtio-net hashing feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: songliubraving@fb.com, gustavoars@kernel.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, decui@microsoft.com, ast@kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 steffen.klassert@secunet.com,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 herbert@gondor.apana.org.au, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, yhs@fb.com, pabeni@redhat.com, pablo@netfilter.org,
 elver@google.com, kpsingh@kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>, kuba@kernel.org,
 willemb@google.com, netdev@vger.kernel.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, nogikh@google.com,
 bpf@vger.kernel.org, kafai@fb.com
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

T24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgOTo1MuKAr0FNIEFraWhpa28gT2Rha2kgPGFraWhpa28u
b2Rha2lAZGF5bml4LmNvbT4gd3JvdGU6Cj4KPiBPbiAyMDIzLzEwLzA5IDE5OjQ0LCBXaWxsZW0g
ZGUgQnJ1aWpuIHdyb3RlOgo+ID4gT24gTW9uLCBPY3QgOSwgMjAyMyBhdCAzOjEy4oCvQU0gQWtp
aGlrbyBPZGFraSA8YWtpaGlrby5vZGFraUBkYXluaXguY29tPiB3cm90ZToKPiA+Pgo+ID4+IE9u
IDIwMjMvMTAvMDkgMTk6MDYsIFdpbGxlbSBkZSBCcnVpam4gd3JvdGU6Cj4gPj4+IE9uIE1vbiwg
T2N0IDksIDIwMjMgYXQgMzowMuKAr0FNIEFraWhpa28gT2Rha2kgPGFraWhpa28ub2Rha2lAZGF5
bml4LmNvbT4gd3JvdGU6Cj4gPj4+Pgo+ID4+Pj4gT24gMjAyMy8xMC8wOSAxODo1NywgV2lsbGVt
IGRlIEJydWlqbiB3cm90ZToKPiA+Pj4+PiBPbiBNb24sIE9jdCA5LCAyMDIzIGF0IDM6NTfigK9B
TSBBa2loaWtvIE9kYWtpIDxha2loaWtvLm9kYWtpQGRheW5peC5jb20+IHdyb3RlOgo+ID4+Pj4+
Pgo+ID4+Pj4+PiBPbiAyMDIzLzEwLzA5IDE3OjA0LCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOgo+
ID4+Pj4+Pj4gT24gU3VuLCBPY3QgOCwgMjAyMyBhdCAzOjQ24oCvUE0gQWtpaGlrbyBPZGFraSA8
YWtpaGlrby5vZGFraUBkYXluaXguY29tPiB3cm90ZToKPiA+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+IE9u
IDIwMjMvMTAvMDkgNTowOCwgV2lsbGVtIGRlIEJydWlqbiB3cm90ZToKPiA+Pj4+Pj4+Pj4gT24g
U3VuLCBPY3QgOCwgMjAyMyBhdCAxMDowNOKAr1BNIEFraWhpa28gT2Rha2kgPGFraWhpa28ub2Rh
a2lAZGF5bml4LmNvbT4gd3JvdGU6Cj4gPj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4gT24gMjAyMy8x
MC8wOSA0OjA3LCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOgo+ID4+Pj4+Pj4+Pj4+IE9uIFN1biwg
T2N0IDgsIDIwMjMgYXQgNzoyMuKAr0FNIEFraWhpa28gT2Rha2kgPGFraWhpa28ub2Rha2lAZGF5
bml4LmNvbT4gd3JvdGU6Cj4gPj4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4+IHZpcnRpby1uZXQg
aGF2ZSB0d28gdXNhZ2Ugb2YgaGFzaGVzOiBvbmUgaXMgUlNTIGFuZCBhbm90aGVyIGlzIGhhc2gK
PiA+Pj4+Pj4+Pj4+Pj4gcmVwb3J0aW5nLiBDb252ZW50aW9uYWxseSB0aGUgaGFzaCBjYWxjdWxh
dGlvbiB3YXMgZG9uZSBieSB0aGUgVk1NLgo+ID4+Pj4+Pj4+Pj4+PiBIb3dldmVyLCBjb21wdXRp
bmcgdGhlIGhhc2ggYWZ0ZXIgdGhlIHF1ZXVlIHdhcyBjaG9zZW4gZGVmZWF0cyB0aGUKPiA+Pj4+
Pj4+Pj4+Pj4gcHVycG9zZSBvZiBSU1MuCj4gPj4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4+IEFu
b3RoZXIgYXBwcm9hY2ggaXMgdG8gdXNlIGVCUEYgc3RlZXJpbmcgcHJvZ3JhbS4gVGhpcyBhcHBy
b2FjaCBoYXMKPiA+Pj4+Pj4+Pj4+Pj4gYW5vdGhlciBkb3duc2lkZTogaXQgY2Fubm90IHJlcG9y
dCB0aGUgY2FsY3VsYXRlZCBoYXNoIGR1ZSB0byB0aGUKPiA+Pj4+Pj4+Pj4+Pj4gcmVzdHJpY3Rp
dmUgbmF0dXJlIG9mIGVCUEYuCj4gPj4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4+IEludHJvZHVj
ZSB0aGUgY29kZSB0byBjb21wdXRlIGhhc2hlcyB0byB0aGUga2VybmVsIGluIG9yZGVyIHRvIG92
ZXJjb21lCj4gPj4+Pj4+Pj4+Pj4+IHRoc2UgY2hhbGxlbmdlcy4gQW4gYWx0ZXJuYXRpdmUgc29s
dXRpb24gaXMgdG8gZXh0ZW5kIHRoZSBlQlBGIHN0ZWVyaW5nCj4gPj4+Pj4+Pj4+Pj4+IHByb2dy
YW0gc28gdGhhdCBpdCB3aWxsIGJlIGFibGUgdG8gcmVwb3J0IHRvIHRoZSB1c2Vyc3BhY2UsIGJ1
dCBpdCBtYWtlcwo+ID4+Pj4+Pj4+Pj4+PiBsaXR0bGUgc2Vuc2UgdG8gYWxsb3cgdG8gaW1wbGVt
ZW50IGRpZmZlcmVudCBoYXNoaW5nIGFsZ29yaXRobXMgd2l0aAo+ID4+Pj4+Pj4+Pj4+PiBlQlBG
IHNpbmNlIHRoZSBoYXNoIHZhbHVlIHJlcG9ydGVkIGJ5IHZpcnRpby1uZXQgaXMgc3RyaWN0bHkg
ZGVmaW5lZCBieQo+ID4+Pj4+Pj4+Pj4+PiB0aGUgc3BlY2lmaWNhdGlvbi4KPiA+Pj4+Pj4+Pj4+
Pj4KPiA+Pj4+Pj4+Pj4+Pj4gVGhlIGhhc2ggdmFsdWUgYWxyZWFkeSBzdG9yZWQgaW4gc2tfYnVm
ZiBpcyBub3QgdXNlZCBhbmQgY29tcHV0ZWQKPiA+Pj4+Pj4+Pj4+Pj4gaW5kZXBlbmRlbnRseSBz
aW5jZSBpdCBtYXkgaGF2ZSBiZWVuIGNvbXB1dGVkIGluIGEgd2F5IG5vdCBjb25mb3JtYW50Cj4g
Pj4+Pj4+Pj4+Pj4+IHdpdGggdGhlIHNwZWNpZmljYXRpb24uCj4gPj4+Pj4+Pj4+Pj4+Cj4gPj4+
Pj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEFraWhpa28gT2Rha2kgPGFraWhpa28ub2Rha2lAZGF5
bml4LmNvbT4KPiA+Pj4+Pj4+Pj4+Pj4gLS0tCj4gPj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4g
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgdHVuX3ZuZXRfaGFzaF9jYXAgdHVuX3ZuZXRfaGFzaF9jYXAg
PSB7Cj4gPj4+Pj4+Pj4+Pj4+ICsgICAgICAgLm1heF9pbmRpcmVjdGlvbl90YWJsZV9sZW5ndGgg
PQo+ID4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgVFVOX1ZORVRfSEFTSF9NQVhfSU5ESVJF
Q1RJT05fVEFCTEVfTEVOR1RILAo+ID4+Pj4+Pj4+Pj4+PiArCj4gPj4+Pj4+Pj4+Pj4+ICsgICAg
ICAgLnR5cGVzID0gVklSVElPX05FVF9TVVBQT1JURURfSEFTSF9UWVBFUwo+ID4+Pj4+Pj4+Pj4+
PiArfTsKPiA+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+IE5vIG5lZWQgdG8gaGF2ZSBleHBsaWNp
dCBjYXBhYmlsaXRpZXMgZXhjaGFuZ2UgbGlrZSB0aGlzPyBUdW4gZWl0aGVyCj4gPj4+Pj4+Pj4+
Pj4gc3VwcG9ydHMgYWxsIG9yIG5vbmUuCj4gPj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4gdHVuIGRv
ZXMgbm90IHN1cHBvcnQgVklSVElPX05FVF9SU1NfSEFTSF9UWVBFX0lQX0VYLAo+ID4+Pj4+Pj4+
Pj4gVklSVElPX05FVF9SU1NfSEFTSF9UWVBFX1RDUF9FWCwgYW5kIFZJUlRJT19ORVRfUlNTX0hB
U0hfVFlQRV9VRFBfRVguCj4gPj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4gSXQgaXMgYmVjYXVzZSB0
aGUgZmxvdyBkaXNzZWN0b3IgZG9lcyBub3Qgc3VwcG9ydCBJUHY2IGV4dGVuc2lvbnMuIFRoZQo+
ID4+Pj4+Pj4+Pj4gc3BlY2lmaWNhdGlvbiBpcyBhbHNvIHZhZ3VlLCBhbmQgZG9lcyBub3QgdGVs
bCBob3cgbWFueSBUTFZzIHNob3VsZCBiZQo+ID4+Pj4+Pj4+Pj4gY29uc3VtZWQgYXQgbW9zdCB3
aGVuIGludGVycHJldGluZyBkZXN0aW5hdGlvbiBvcHRpb24gaGVhZGVyIHNvIEkgY2hvc2UKPiA+
Pj4+Pj4+Pj4+IHRvIGF2b2lkIGFkZGluZyBjb2RlIGZvciB0aGVzZSBoYXNoIHR5cGVzIHRvIHRo
ZSBmbG93IGRpc3NlY3Rvci4gSSBkb3VidAo+ID4+Pj4+Pj4+Pj4gYW55b25lIHdpbGwgY29tcGxh
aW4gYWJvdXQgaXQgc2luY2Ugbm9ib2R5IGNvbXBsYWlucyBmb3IgTGludXguCj4gPj4+Pj4+Pj4+
Pgo+ID4+Pj4+Pj4+Pj4gSSdtIGFsc28gYWRkaW5nIHRoaXMgc28gdGhhdCB3ZSBjYW4gZXh0ZW5k
IGl0IGxhdGVyLgo+ID4+Pj4+Pj4+Pj4gbWF4X2luZGlyZWN0aW9uX3RhYmxlX2xlbmd0aCBtYXkg
Z3JvdyBmb3Igc3lzdGVtcyB3aXRoIDEyOCsgQ1BVcywgb3IKPiA+Pj4+Pj4+Pj4+IHR5cGVzIG1h
eSBoYXZlIG90aGVyIGJpdHMgZm9yIG5ldyBwcm90b2NvbHMgaW4gdGhlIGZ1dHVyZS4KPiA+Pj4+
Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4gICAgICAgICAgICAgICBjYXNlIFRV
TlNFVFNURUVSSU5HRUJQRjoKPiA+Pj4+Pj4+Pj4+Pj4gLSAgICAgICAgICAgICAgIHJldCA9IHR1
bl9zZXRfZWJwZih0dW4sICZ0dW4tPnN0ZWVyaW5nX3Byb2csIGFyZ3ApOwo+ID4+Pj4+Pj4+Pj4+
PiArICAgICAgICAgICAgICAgYnBmX3JldCA9IHR1bl9zZXRfZWJwZih0dW4sICZ0dW4tPnN0ZWVy
aW5nX3Byb2csIGFyZ3ApOwo+ID4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgaWYgKElTX0VS
UihicGZfcmV0KSkKPiA+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0g
UFRSX0VSUihicGZfcmV0KTsKPiA+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgIGVsc2UgaWYg
KGJwZl9yZXQpCj4gPj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHR1bi0+dm5l
dF9oYXNoLmZsYWdzICY9IH5UVU5fVk5FVF9IQVNIX1JTUzsKPiA+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+
Pj4+Pj4+IERvbid0IG1ha2Ugb25lIGZlYXR1cmUgZGlzYWJsZSBhbm90aGVyLgo+ID4+Pj4+Pj4+
Pj4+Cj4gPj4+Pj4+Pj4+Pj4gVFVOU0VUU1RFRVJJTkdFQlBGIGFuZCBUVU5TRVRWTkVUSEFTSCBh
cmUgbXV0dWFsbHkgZXhjbHVzaXZlCj4gPj4+Pj4+Pj4+Pj4gZnVuY3Rpb25zLiBJZiBvbmUgaXMg
ZW5hYmxlZCB0aGUgb3RoZXIgY2FsbCBzaG91bGQgZmFpbCwgd2l0aCBFQlVTWQo+ID4+Pj4+Pj4+
Pj4+IGZvciBpbnN0YW5jZS4KPiA+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+PiArICAgICAgIGNh
c2UgVFVOU0VUVk5FVEhBU0g6Cj4gPj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICBsZW4gPSBz
aXplb2Yodm5ldF9oYXNoKTsKPiA+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgIGlmIChjb3B5
X2Zyb21fdXNlcigmdm5ldF9oYXNoLCBhcmdwLCBsZW4pKSB7Cj4gPj4+Pj4+Pj4+Pj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgIHJldCA9IC1FRkFVTFQ7Cj4gPj4+Pj4+Pj4+Pj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgfQo+
ID4+Pj4+Pj4+Pj4+PiArCj4gPj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICBpZiAoKCh2bmV0
X2hhc2guZmxhZ3MgJiBUVU5fVk5FVF9IQVNIX1JFUE9SVCkgJiYKPiA+Pj4+Pj4+Pj4+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgKHR1bi0+dm5ldF9oZHJfc3ogPCBzaXplb2Yoc3RydWN0IHZpcnRp
b19uZXRfaGRyX3YxX2hhc2gpIHx8Cj4gPj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAg
ICAhdHVuX2lzX2xpdHRsZV9lbmRpYW4odHVuKSkpIHx8Cj4gPj4+Pj4+Pj4+Pj4+ICsgICAgICAg
ICAgICAgICAgICAgIHZuZXRfaGFzaC5pbmRpcmVjdGlvbl90YWJsZV9tYXNrID49Cj4gPj4+Pj4+
Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgIFRVTl9WTkVUX0hBU0hfTUFYX0lORElSRUNUSU9O
X1RBQkxFX0xFTkdUSCkgewo+ID4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICBy
ZXQgPSAtRUlOVkFMOwo+ID4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICBicmVh
azsKPiA+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgIH0KPiA+Pj4+Pj4+Pj4+Pj4gKwo+ID4+
Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgYXJncCA9ICh1OCBfX3VzZXIgKilhcmdwICsgbGVu
Owo+ID4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgbGVuID0gKHZuZXRfaGFzaC5pbmRpcmVj
dGlvbl90YWJsZV9tYXNrICsgMSkgKiAyOwo+ID4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAg
aWYgKGNvcHlfZnJvbV91c2VyKHZuZXRfaGFzaF9pbmRpcmVjdGlvbl90YWJsZSwgYXJncCwgbGVu
KSkgewo+ID4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAtRUZBVUxU
Owo+ID4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiA+Pj4+Pj4+
Pj4+Pj4gKyAgICAgICAgICAgICAgIH0KPiA+Pj4+Pj4+Pj4+Pj4gKwo+ID4+Pj4+Pj4+Pj4+PiAr
ICAgICAgICAgICAgICAgYXJncCA9ICh1OCBfX3VzZXIgKilhcmdwICsgbGVuOwo+ID4+Pj4+Pj4+
Pj4+PiArICAgICAgICAgICAgICAgbGVuID0gdmlydGlvX25ldF9oYXNoX2tleV9sZW5ndGgodm5l
dF9oYXNoLnR5cGVzKTsKPiA+Pj4+Pj4+Pj4+Pj4gKwo+ID4+Pj4+Pj4+Pj4+PiArICAgICAgICAg
ICAgICAgaWYgKGNvcHlfZnJvbV91c2VyKHZuZXRfaGFzaF9rZXksIGFyZ3AsIGxlbikpIHsKPiA+
Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVGQVVMVDsKPiA+Pj4+
Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gPj4+Pj4+Pj4+Pj4+ICsg
ICAgICAgICAgICAgICB9Cj4gPj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+PiBQcm9iYWJseSBlYXNp
ZXIgYW5kIGxlc3MgZXJyb3ItcHJvbmUgdG8gZGVmaW5lIGEgZml4ZWQgc2l6ZSBjb250cm9sCj4g
Pj4+Pj4+Pj4+Pj4gc3RydWN0IHdpdGggdGhlIG1heCBpbmRpcmVjdGlvbiB0YWJsZSBzaXplLgo+
ID4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+IEkgbWFkZSBpdHMgc2l6ZSB2YXJpYWJsZSBiZWNhdXNl
IHRoZSBpbmRpcmVjdGlvbiB0YWJsZSBhbmQga2V5IG1heSBncm93Cj4gPj4+Pj4+Pj4+PiBpbiB0
aGUgZnV0dXJlIGFzIEkgd3JvdGUgYWJvdmUuCj4gPj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+Cj4g
Pj4+Pj4+Pj4+Pj4gQnR3OiBwbGVhc2UgdHJpbSB0aGUgQ0M6IGxpc3QgY29uc2lkZXJhYmx5IG9u
IGZ1dHVyZSBwYXRjaGVzLgo+ID4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+IEknbGwgZG8gc28gaW4g
dGhlIG5leHQgdmVyc2lvbiB3aXRoIHRoZSBUVU5TRVRTVEVFUklOR0VCUEYgY2hhbmdlIHlvdQo+
ID4+Pj4+Pj4+Pj4gcHJvcG9zZWQuCj4gPj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+IFRvIGJlIGNsZWFy
OiBwbGVhc2UgZG9uJ3QganVzdCByZXN1Ym1pdCB3aXRoIHRoYXQgb25lIGNoYW5nZS4KPiA+Pj4+
Pj4+Pj4KPiA+Pj4+Pj4+Pj4gVGhlIHNrYiBhbmQgY2IgaXNzdWVzIGFyZSBxdWl0ZSBmdW5kYW1l
bnRhbCBpc3N1ZXMgdGhhdCBuZWVkIHRvIGJlIHJlc29sdmVkLgo+ID4+Pj4+Pj4+Pgo+ID4+Pj4+
Pj4+PiBJJ2QgbGlrZSB0byB1bmRlcnN0YW5kIHdoeSBhZGp1c3RpbmcgdGhlIGV4aXN0aW5nIEJQ
RiBmZWF0dXJlIGZvciB0aGlzCj4gPj4+Pj4+Pj4+IGV4YWN0IHB1cnBvc2UgY2Fubm90IGJlIGFt
ZW5kZWQgdG8gcmV0dXJuIHRoZSBrZXkgaXQgcHJvZHVjZWQuCj4gPj4+Pj4+Pj4KPiA+Pj4+Pj4+
PiBlQlBGIHN0ZWVyaW5nIHByb2dyYW0gaXMgbm90IGRlc2lnbmVkIGZvciB0aGlzIHBhcnRpY3Vs
YXIgcHJvYmxlbSBpbiBteQo+ID4+Pj4+Pj4+IHVuZGVyc3RhbmRpbmcuIEl0IHdhcyBpbnRyb2R1
Y2VkIHRvIGRlcml2ZSBoYXNoIHZhbHVlcyB3aXRoIGFuCj4gPj4+Pj4+Pj4gdW5kZXJzdGFuZGlu
ZyBvZiBhcHBsaWNhdGlvbi1zcGVjaWZpYyBzZW1hbnRpY3Mgb2YgcGFja2V0cyBpbnN0ZWFkIG9m
Cj4gPj4+Pj4+Pj4gZ2VuZXJpYyBJUC9UQ1AvVURQIHNlbWFudGljcy4KPiA+Pj4+Pj4+Pgo+ID4+
Pj4+Pj4+IFRoaXMgcHJvYmxlbSBpcyByYXRoZXIgZGlmZmVyZW50IGluIHRlcm1zIHRoYXQgdGhl
IGhhc2ggZGVyaXZhdGlvbiBpcwo+ID4+Pj4+Pj4+IHN0cmljdGx5IGRlZmluZWQgYnkgdmlydGlv
LW5ldC4gSSBkb24ndCB0aGluayBpdCBtYWtlcyBzZW5zZSB0bwo+ID4+Pj4+Pj4+IGludHJvZHVj
ZSB0aGUgY29tcGxleGl0eSBvZiBCUEYgd2hlbiB5b3UgYWx3YXlzIHJ1biB0aGUgc2FtZSBjb2Rl
Lgo+ID4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4gSXQgY2FuIHV0aWxpemUgdGhlIGV4aXN0aW5nIGZsb3cg
ZGlzc2VjdG9yIGFuZCBhbHNvIG1ha2UgaXQgZWFzaWVyIHRvCj4gPj4+Pj4+Pj4gdXNlIGZvciB0
aGUgdXNlcnNwYWNlIGJ5IGltcGxlbWVudGluZyB0aGlzIGluIHRoZSBrZXJuZWwuCj4gPj4+Pj4+
Pgo+ID4+Pj4+Pj4gT2suIFRoZXJlIGRvZXMgYXBwZWFyIHRvIGJlIG92ZXJsYXAgaW4gZnVuY3Rp
b25hbGl0eS4gQnV0IGl0IG1pZ2h0IGJlCj4gPj4+Pj4+PiBlYXNpZXIgdG8gZGVwbG95IHRvIGp1
c3QgaGF2ZSBzdGFuZGFyZCBUb2VwbGl0eiBhdmFpbGFibGUgd2l0aG91dAo+ID4+Pj4+Pj4gaGF2
aW5nIHRvIGNvbXBpbGUgYW5kIGxvYWQgYW4gZUJQRiBwcm9ncmFtLgo+ID4+Pj4+Pj4KPiA+Pj4+
Pj4+IEFzIGZvciB0aGUgc2tfYnVmZiBhbmQgY2JbXSBjaGFuZ2VzLiBUaGUgZmlyc3QgaXMgcmVh
bGx5IG5vdCBuZWVkZWQuCj4gPj4+Pj4+PiBza19idWZmIHNpbXBseSB3b3VsZCBub3Qgc2NhbGUg
aWYgZXZlcnkgZWRnZSBjYXNlIG5lZWRzIGEgZmV3IGJpdHMuCj4gPj4+Pj4+Cj4gPj4+Pj4+IEFu
IGFsdGVybmF0aXZlIGlzIHRvIG1vdmUgdGhlIGJpdCB0byBjYltdIGFuZCBjbGVhciBpdCBmb3Ig
ZXZlcnkgY29kZQo+ID4+Pj4+PiBwYXRocyB0aGF0IGxlYWQgdG8gbmRvX3N0YXJ0X3htaXQoKSwg
YnV0IEknbSB3b3JyaWVkIHRoYXQgaXQgaXMgZXJyb3ItcHJvbmUuCj4gPj4+Pj4+Cj4gPj4+Pj4+
IEkgdGhpbmsgd2UgY2FuIHB1dCB0aGUgYml0IGluIHNrX2J1ZmYgZm9yIG5vdy4gV2UgY2FuIGlt
cGxlbWVudCB0aGUKPiA+Pj4+Pj4gYWx0ZXJuYXRpdmUgd2hlbiB3ZSBhcmUgc2hvcnQgb2YgYml0
cy4KPiA+Pj4+Pgo+ID4+Pj4+IEkgZGlzYWdyZWUuIHNrX2J1ZmYgZmllbGRzIGFkZCBhIGNvc3Qg
dG8gZXZlcnkgY29kZSBwYXRoLiBUaGV5IGNhbm5vdAo+ID4+Pj4+IGJlIGFkZGVkIGZvciBldmVy
eSBlZGdlIGNhc2UuCj4gPj4+Pgo+ID4+Pj4gSXQgb25seSB0YWtlcyBhbiB1bnVzZWQgYml0IGFu
ZCBkb2VzIG5vdCBncm93IHRoZSBza19idWZmIHNpemUgc28gSQo+ID4+Pj4gdGhpbmsgaXQgaGFz
IHByYWN0aWNhbGx5IG5vIGNvc3QgZm9yIG5vdy4KPiA+Pj4KPiA+Pj4gVGhlIHByb2JsZW0gaXMg
dGhhdCB0aGF0IHRoaW5raW5nIGxlYWRzIHRvIGRlYXRoIGJ5IGEgdGhvdXNhbmQgY3V0cy4KPiA+
Pj4KPiA+Pj4gImZvciBub3ciIGZvcmNlcyB0aGUgY29zdCBvZiBoYXZpbmcgdG8gdGhpbmsgaGFy
ZCBob3cgdG8gYXZvaWQgZ3Jvd2luZwo+ID4+PiBza19idWZmIG9udG8gdGhlIG5leHQgcGVyc29u
LiBMZXQncyBkbyBpdCByaWdodCBmcm9tIHRoZSBzdGFydC4KPiA+Pgo+ID4+IEkgc2VlLiBJIGRl
c2NyaWJlZCBhbiBhbHRlcm5hdGl2ZSB0byBtb3ZlIHRoZSBiaXQgdG8gY2JbXSBhbmQgY2xlYXIg
aXQKPiA+PiBpbiBhbGwgY29kZSBwYXRocyB0aGF0IGxlYWRzIHRvIG5kb19zdGFydF94bWl0KCkg
ZWFybGllci4gRG9lcyB0aGF0Cj4gPj4gc291bmQgZ29vZCB0byB5b3U/Cj4gPgo+ID4gSWYgeW91
IHVzZSB0aGUgY29udHJvbCBibG9jayB0byBwYXNzIGluZm9ybWF0aW9uIGJldHdlZW4KPiA+IF9f
ZGV2X3F1ZXVlX3htaXQgb24gdGhlIHR1biBkZXZpY2UgYW5kIHR1bl9uZXRfeG1pdCwgdXNpbmcg
Z3NvX3NrYl9jYiwKPiA+IHRoZSBmaWVsZCBjYW4gYmUgbGVmdCB1bmRlZmluZWQgaW4gYWxsIG5v
bi10dW4gcGF0aHMuIHR1bl9zZWxlY3RfcXVldWUKPiA+IGNhbiBpbml0aWFsaXplLgo+Cj4gVGhl
IHByb2JsZW0gaXMgdGhhdCB0dW5fc2VsZWN0X3F1ZXVlKCkgaXMgbm90IGFsd2F5cyBjYWxsZWQu
Cj4gbmV0ZGV2X2NvcmVfcGlja190eCgpIGVuc3VyZXMgZGV2LT5yZWFsX251bV90eF9xdWV1ZXMg
IT0gMSBiZWZvcmUKPiBjYWxsaW5nIGl0LCBidXQgdGhpcyB2YXJpYWJsZSBtYXkgY2hhbmdlIGxh
dGVyIGFuZCByZXN1bHQgaW4gYSByYWNlCj4gY29uZGl0aW9uLiBBbm90aGVyIGNhc2UgaXMgdGhh
dCBYRFAgd2l0aCBwcmVkZWZpbmVkIHF1ZXVlLgo+Cj4gPgo+ID4gSSB3b3VsZCBzdGlsbCB1c2Ug
c2tiLT5oYXNoIHRvIGVuY29kZSB0aGUgaGFzaC4gVGhhdCBoYXNoIHR5cGUgb2YgdGhhdAo+ID4g
ZmllbGQgaXMgbm90IHN0cmljdGx5IGRlZmluZWQuIEl0IGNhbiBiZSBzaXBoYXNoIGZyb20gX19f
c2tiX2dldF9oYXNoCj4gPiBvciBhIGRldmljZSBoYXNoLCB3aGljaCBtb3N0IGxpa2VseSBhbHNv
IHVzZXMgVG9lcGxpdHouIFRoZW4geW91IGFsc28KPiA+IGRvbid0IHJ1biBpbnRvIHRoZSBwcm9i
bGVtIG9mIGdyb3dpbmcgdGhlIHN0cnVjdCBzaXplLgo+Cj4gSSdtIGNvbmNlcm5lZCBleGFjdGx5
IGJlY2F1c2UgaXQncyBub3Qgc3RyaWN0bHkgZGVmaW5lZC4gU29tZW9uZSBtYXkKPiBkZWNpZGUg
dG8gb3ZlcndyaXRlIGl0IGxhdGVyIGlmIHdlIGFyZSBub3QgY2F1dGlvdXMgZW5vdWdoLiBxZGlz
Y19za2JfY2IKPiBhbHNvIGhhcyBzdWZmaWNpZW50IHNwYWNlIHRvIGNvbnRhaW4gYm90aCBvZiB0
aGUgaGFzaCB2YWx1ZSBhbmQgdHlwZS4KCkhvdyBhYm91dCB1c2luZyBza2IgZXh0ZW5zaW9ucz8K
ClRoYW5rcwoKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

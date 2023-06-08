Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2141DC7EE2E
	for <virtualization@archiver.kernel.org>; Thu,  8 Jun 2023 07:46:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 849A74050C;
	Thu,  8 Jun 2023 07:46:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 849A74050C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kk+wMU9C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bYnlLgKh86Gv; Thu,  8 Jun 2023 07:46:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CA24F4012B;
	Thu,  8 Jun 2023 07:46:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CA24F4012B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9CACCC0037;
	Thu,  8 Jun 2023 07:46:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 421B9C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 07:46:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B29C4048F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 07:46:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1B29C4048F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WXCbVhJnjgit
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 07:46:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A5D34012B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8A5D34012B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 07:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686210375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4jks4xbNwfyNEVL0zypzxaGA+rFgT4ZCRcn8JM16ug=;
 b=Kk+wMU9CIPPuF/9WI+QIbgj2KEAc4RaRlmEEuVhMGJRDiZpcCqGORWLeA8hfktuRf4ECQn
 wzrrbnGYXT75Eep6+Ik/G3TJZTHrFP46zL9hVUL/t4t6t9G45dxeSO5yBK6BUXcHyfXSPB
 AjCzLLkoWY9ApQTmY8z0G7Ub/vggLpE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-OBe2o_zSMx-dM9aTAGqVcw-1; Thu, 08 Jun 2023 03:46:14 -0400
X-MC-Unique: OBe2o_zSMx-dM9aTAGqVcw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b1e6a2e984so1392461fa.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Jun 2023 00:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686210373; x=1688802373;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m4jks4xbNwfyNEVL0zypzxaGA+rFgT4ZCRcn8JM16ug=;
 b=i2+URGk1/YzmP9p3rgy5/b07pNUAWm8SBfgDqGWA3rfwc067u3T+9UU5sg+Mc/tsRi
 zec+00xzVZVWW0hrfdu9UYMpQUSvJ9Lm8U6b4Zuj0w1YkSM2lEHh6wiYk3YD4qVtbpGn
 yFaQylF1oxDr29Uk4Zj2NGsg/FZDSHNeWmoXDa/4qGTjLayOOU7GHUF9LDtoWs3pbiqF
 uZg1khdV4kezFI1kGyo1vcdIHU57XvUU4IvLGiISQL8BLUkZ6QrC5NNw+td79Hn1yBVh
 rWIrHpdplu6zdwLxmWTq0ibwBlQogU8o11jHbIM+gCPtNV5EShOMjQPjs+8fUEyHJtXe
 6NQg==
X-Gm-Message-State: AC+VfDzJ5in5gkXGwgs5YV6eNpckbrD3sSpc2ueoATja2LWphzs8ofPx
 XUwKiclstqfLxr0DN3/TplAfcmzCknve3yfSxhM1l2UALESh6758bTWKOaq9IIZ6T8umEoXcMSI
 2h/b83270ObX/9HDRiTV5AK7ZH4yncS3BFqnlzohMoNbw55RU0eCvk053LA==
X-Received: by 2002:a2e:8012:0:b0:2b2:90e:165d with SMTP id
 j18-20020a2e8012000000b002b2090e165dmr1082551ljg.2.1686210372775; 
 Thu, 08 Jun 2023 00:46:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ63Z8QuefCG7zMHV1KMGDYxy81pEGWNOWiZwJ5Vm+tBFN/LuRKfkpj4hyczsig6YB47pZpflzAsOmk9Bar5Yo4=
X-Received: by 2002:a2e:8012:0:b0:2b2:90e:165d with SMTP id
 j18-20020a2e8012000000b002b2090e165dmr1082541ljg.2.1686210372444; Thu, 08 Jun
 2023 00:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <24fjdwp44hovz3d3qkzftmvjie45er3g3boac7aezpvzbwvuol@lmo47ydvnqau>
 <20230605085840-mutt-send-email-mst@kernel.org>
 <gi2hngx3ndsgz5d2rpqjywdmou5vxhd7xgi5z2lbachr7yoos4@kpifz37oz2et>
 <20230605095404-mutt-send-email-mst@kernel.org>
 <32ejjuvhvcicv7wjuetkv34qtlpa657n4zlow4eq3fsi2twozk@iqnd2t5tw2an>
 <CACGkMEu3PqQ99UoKF5NHgVADD3q=BF6jhLiyumeT4S1QCqN1tw@mail.gmail.com>
 <20230606085643-mutt-send-email-mst@kernel.org>
 <CAGxU2F7fkgL-HpZdj=5ZEGNWcESCHQpgRAYQA3W2sPZaoEpNyQ@mail.gmail.com>
 <20230607054246-mutt-send-email-mst@kernel.org>
 <CACGkMEuUapKvUYiJiLwtsN+x941jafDKS9tuSkiNrvkrrSmQkg@mail.gmail.com>
 <20230608020111-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230608020111-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 8 Jun 2023 15:46:00 +0800
Message-ID: <CACGkMEt4=3BRVNX38AD+mJU8v3bmqO-CdNj5NkFP-SSvsuy2Hg@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, Tiwei Bie <tiwei.bie@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
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

T24gVGh1LCBKdW4gOCwgMjAyMyBhdCAyOjAz4oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBUaHUsIEp1biAwOCwgMjAyMyBhdCAwODo0MjoxNUFN
ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gT24gV2VkLCBKdW4gNywgMjAyMyBhdCA1OjQz
4oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+Cj4g
PiA+IE9uIFdlZCwgSnVuIDA3LCAyMDIzIGF0IDEwOjM5OjE1QU0gKzAyMDAsIFN0ZWZhbm8gR2Fy
emFyZWxsYSB3cm90ZToKPiA+ID4gPiBPbiBUdWUsIEp1biA2LCAyMDIzIGF0IDI6NTjigK9QTSBN
aWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+
ID4gPiBPbiBUdWUsIEp1biAwNiwgMjAyMyBhdCAwOToyOToyMkFNICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+ID4gPiA+ID4gPiBPbiBNb24sIEp1biA1LCAyMDIzIGF0IDEwOjU44oCvUE0gU3Rl
ZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+IE9uIE1vbiwgSnVuIDA1LCAyMDIzIGF0IDA5OjU0OjU3QU0gLTA0MDAs
IE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+T24gTW9uLCBKdW4gMDUs
IDIwMjMgYXQgMDM6MzA6MzVQTSArMDIwMCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+ID4g
PiA+ID4gPiA+ID4+IE9uIE1vbiwgSnVuIDA1LCAyMDIzIGF0IDA5OjAwOjI1QU0gLTA0MDAsIE1p
Y2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+PiA+IE9uIE1vbiwgSnVuIDA1
LCAyMDIzIGF0IDAyOjU0OjIwUE0gKzAyMDAsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiA+
ID4gPiA+ID4gPiA+PiA+ID4gT24gTW9uLCBKdW4gMDUsIDIwMjMgYXQgMDg6NDE6NTRBTSAtMDQw
MCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4+ID4gPiA+IE9uIE1v
biwgSnVuIDA1LCAyMDIzIGF0IDAxOjA2OjQ0UE0gKzAyMDAsIFN0ZWZhbm8gR2FyemFyZWxsYSB3
cm90ZToKPiA+ID4gPiA+ID4gPiA+PiA+ID4gPiA+IHZob3N0LXZkcGEgSU9DVExzIChlZy4gVkhP
U1RfR0VUX1ZSSU5HX0JBU0UsIFZIT1NUX1NFVF9WUklOR19CQVNFKQo+ID4gPiA+ID4gPiA+ID4+
ID4gPiA+ID4gZG9uJ3Qgc3VwcG9ydCBwYWNrZWQgdmlydHF1ZXVlIHdlbGwgeWV0LCBzbyBsZXQn
cyBmaWx0ZXIgdGhlCj4gPiA+ID4gPiA+ID4gPj4gPiA+ID4gPiBWSVJUSU9fRl9SSU5HX1BBQ0tF
RCBmZWF0dXJlIGZvciBub3cgaW4gdmhvc3RfdmRwYV9nZXRfZmVhdHVyZXMoKS4KPiA+ID4gPiA+
ID4gPiA+PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPj4gPiA+ID4gPiBUaGlzIHdheSwgZXZlbiBp
ZiB0aGUgZGV2aWNlIHN1cHBvcnRzIGl0LCB3ZSBkb24ndCByaXNrIGl0IGJlaW5nCj4gPiA+ID4g
PiA+ID4gPj4gPiA+ID4gPiBuZWdvdGlhdGVkLCB0aGVuIHRoZSBWTU0gaXMgdW5hYmxlIHRvIHNl
dCB0aGUgdnJpbmcgc3RhdGUgcHJvcGVybHkuCj4gPiA+ID4gPiA+ID4gPj4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+ID4+ID4gPiA+ID4gRml4ZXM6IDRjOGNmMzE4ODVmNiAoInZob3N0OiBpbnRyb2R1
Y2UgdkRQQS1iYXNlZCBiYWNrZW5kIikKPiA+ID4gPiA+ID4gPiA+PiA+ID4gPiA+IENjOiBzdGFi
bGVAdmdlci5rZXJuZWwub3JnCj4gPiA+ID4gPiA+ID4gPj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4gPiA+ID4gPiA+ID4g
Pj4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ID4gPiA+PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPj4g
PiA+ID4gPiBOb3RlczoKPiA+ID4gPiA+ID4gPiA+PiA+ID4gPiA+ICAgICBUaGlzIHBhdGNoIHNo
b3VsZCBiZSBhcHBsaWVkIGJlZm9yZSB0aGUgIltQQVRDSCB2MiAwLzNdIHZob3N0X3ZkcGE6Cj4g
PiA+ID4gPiA+ID4gPj4gPiA+ID4gPiAgICAgYmV0dGVyIFBBQ0tFRCBzdXBwb3J0IiBzZXJpZXMg
WzFdIGFuZCBiYWNrcG9ydGVkIGluIHN0YWJsZSBicmFuY2hlcy4KPiA+ID4gPiA+ID4gPiA+PiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPj4gPiA+ID4gPiAgICAgV2UgY2FuIHJldmVydCBpdCB3aGVu
IHdlIGFyZSBzdXJlIHRoYXQgZXZlcnl0aGluZyBpcyB3b3JraW5nIHdpdGgKPiA+ID4gPiA+ID4g
PiA+PiA+ID4gPiA+ICAgICBwYWNrZWQgdmlydHF1ZXVlcy4KPiA+ID4gPiA+ID4gPiA+PiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPj4gPiA+ID4gPiAgICAgVGhhbmtzLAo+ID4gPiA+ID4gPiA+ID4+
ID4gPiA+ID4gICAgIFN0ZWZhbm8KPiA+ID4gPiA+ID4gPiA+PiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gPj4gPiA+ID4gPiAgICAgWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3ZpcnR1YWxpemF0
aW9uLzIwMjMwNDI0MjI1MDMxLjE4OTQ3LTEtc2hhbm5vbi5uZWxzb25AYW1kLmNvbS8KPiA+ID4g
PiA+ID4gPiA+PiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4+ID4gPiA+IEknbSBhIGJpdCBsb3N0IGhl
cmUuIFNvIHdoeSBhbSBJIG1lcmdpbmcgImJldHRlciBQQUNLRUQgc3VwcG9ydCIgdGhlbj8KPiA+
ID4gPiA+ID4gPiA+PiA+ID4KPiA+ID4gPiA+ID4gPiA+PiA+ID4gVG8gcmVhbGx5IHN1cHBvcnQg
cGFja2VkIHZpcnRxdWV1ZSB3aXRoIHZob3N0LXZkcGEsIGF0IHRoYXQgcG9pbnQgd2Ugd291bGQK
PiA+ID4gPiA+ID4gPiA+PiA+ID4gYWxzbyBoYXZlIHRvIHJldmVydCB0aGlzIHBhdGNoLgo+ID4g
PiA+ID4gPiA+ID4+ID4gPgo+ID4gPiA+ID4gPiA+ID4+ID4gPiBJIHdhc24ndCBzdXJlIGlmIHlv
dSB3YW50ZWQgdG8gcXVldWUgdGhlIHNlcmllcyBmb3IgdGhpcyBtZXJnZSB3aW5kb3cuCj4gPiA+
ID4gPiA+ID4gPj4gPiA+IEluIHRoYXQgY2FzZSBkbyB5b3UgdGhpbmsgaXQgaXMgYmV0dGVyIHRv
IHNlbmQgdGhpcyBwYXRjaCBvbmx5IGZvciBzdGFibGUKPiA+ID4gPiA+ID4gPiA+PiA+ID4gYnJh
bmNoZXM/Cj4gPiA+ID4gPiA+ID4gPj4gPiA+ID4gRG9lcyB0aGlzIHBhdGNoIG1ha2UgdGhlbSBh
IE5PUD8KPiA+ID4gPiA+ID4gPiA+PiA+ID4KPiA+ID4gPiA+ID4gPiA+PiA+ID4gWWVwLCBhZnRl
ciBhcHBseWluZyB0aGUgImJldHRlciBQQUNLRUQgc3VwcG9ydCIgc2VyaWVzIGFuZCBiZWluZwo+
ID4gPiA+ID4gPiA+ID4+ID4gPiBzdXJlIHRoYXQKPiA+ID4gPiA+ID4gPiA+PiA+ID4gdGhlIElP
Q1RMcyBvZiB2aG9zdC12ZHBhIHN1cHBvcnQgcGFja2VkIHZpcnRxdWV1ZSwgd2Ugc2hvdWxkIHJl
dmVydCB0aGlzCj4gPiA+ID4gPiA+ID4gPj4gPiA+IHBhdGNoLgo+ID4gPiA+ID4gPiA+ID4+ID4g
Pgo+ID4gPiA+ID4gPiA+ID4+ID4gPiBMZXQgbWUga25vdyBpZiB5b3UgcHJlZmVyIGEgZGlmZmVy
ZW50IGFwcHJvYWNoLgo+ID4gPiA+ID4gPiA+ID4+ID4gPgo+ID4gPiA+ID4gPiA+ID4+ID4gPiBJ
J20gY29uY2VybmVkIHRoYXQgUUVNVSB1c2VzIHZob3N0LXZkcGEgSU9DVExzIHRoaW5raW5nIHRo
YXQgdGhlIGtlcm5lbAo+ID4gPiA+ID4gPiA+ID4+ID4gPiBpbnRlcnByZXRzIHRoZW0gdGhlIHJp
Z2h0IHdheSwgd2hlbiBpdCBkb2VzIG5vdC4KPiA+ID4gPiA+ID4gPiA+PiA+ID4KPiA+ID4gPiA+
ID4gPiA+PiA+ID4gVGhhbmtzLAo+ID4gPiA+ID4gPiA+ID4+ID4gPiBTdGVmYW5vCj4gPiA+ID4g
PiA+ID4gPj4gPiA+Cj4gPiA+ID4gPiA+ID4gPj4gPgo+ID4gPiA+ID4gPiA+ID4+ID4gSWYgdGhp
cyBmaXhlcyBhIGJ1ZyBjYW4geW91IGFkZCBGaXhlcyB0YWdzIHRvIGVhY2ggb2YgdGhlbT8gVGhl
biBpdCdzIG9rCj4gPiA+ID4gPiA+ID4gPj4gPiB0byBtZXJnZSBpbiB0aGlzIHdpbmRvdy4gUHJv
YmFibHkgZWFzaWVyIHRoYW4gdGhlIGVsYWJvcmF0ZQo+ID4gPiA+ID4gPiA+ID4+ID4gbWFzay91
bm1hc2sgZGFuY2UuCj4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+PiBDQ2luZyBTaGFu
bm9uICh0aGUgb3JpZ2luYWwgYXV0aG9yIG9mIHRoZSAiYmV0dGVyIFBBQ0tFRCBzdXBwb3J0Igo+
ID4gPiA+ID4gPiA+ID4+IHNlcmllcykuCj4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+
PiBJSVVDIFNoYW5ub24gaXMgZ29pbmcgdG8gc2VuZCBhIHYzIG9mIHRoYXQgc2VyaWVzIHRvIGZp
eCB0aGUKPiA+ID4gPiA+ID4gPiA+PiBkb2N1bWVudGF0aW9uLCBzbyBTaGFubm9uIGNhbiB5b3Ug
YWxzbyBhZGQgdGhlIEZpeGVzIHRhZ3M/Cj4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+
PiBUaGFua3MsCj4gPiA+ID4gPiA+ID4gPj4gU3RlZmFubwo+ID4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiA+V2VsbCB0aGlzIGlzIGluIG15IHRyZWUgYWxyZWFkeS4gSnVzdCByZXBseSB3aXRo
Cj4gPiA+ID4gPiA+ID4gPkZpeGVzOiA8Pgo+ID4gPiA+ID4gPiA+ID50byBlYWNoIGFuZCBJIHdp
bGwgYWRkIHRoZXNlIHRhZ3MuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBJIHRyaWVkLCBi
dXQgaXQgaXMgbm90IGVhc3kgc2luY2Ugd2UgYWRkZWQgdGhlIHN1cHBvcnQgZm9yIHBhY2tlZAo+
ID4gPiA+ID4gPiA+IHZpcnRxdWV1ZSBpbiB2ZHBhIGFuZCB2aG9zdCBpbmNyZW1lbnRhbGx5Lgo+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gSW5pdGlhbGx5IEkgd2FzIHRoaW5raW5nIG9mIGFk
ZGluZyB0aGUgc2FtZSB0YWcgdXNlZCBoZXJlOgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
Rml4ZXM6IDRjOGNmMzE4ODVmNiAoInZob3N0OiBpbnRyb2R1Y2UgdkRQQS1iYXNlZCBiYWNrZW5k
IikKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFRoZW4gSSBkaXNjb3ZlcmVkIHRoYXQgdnFf
c3RhdGUgd2Fzbid0IHRoZXJlLCBzbyBJIHdhcyB0aGlua2luZyBvZgo+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gRml4ZXM6IDUzMGE1Njc4YmMwMCAoInZkcGE6IHN1cHBvcnQgcGFja2VkIHZp
cnRxdWV1ZSBmb3Igc2V0L2dldF92cV9zdGF0ZSgpIikKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+IFNvIHdlIHdvdWxkIGhhdmUgdG8gYmFja3BvcnQgcXVpdGUgYSBmZXcgcGF0Y2hlcyBpbnRv
IHRoZSBzdGFibGUgYnJhbmNoZXMuCj4gPiA+ID4gPiA+ID4gSSBkb24ndCBrbm93IGlmIGl0J3Mg
d29ydGggaXQuLi4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEkgc3RpbGwgdGhpbmsgaXQg
aXMgYmV0dGVyIHRvIGRpc2FibGUgcGFja2VkIGluIHRoZSBzdGFibGUgYnJhbmNoZXMsCj4gPiA+
ID4gPiA+ID4gb3RoZXJ3aXNlIEkgaGF2ZSB0byBtYWtlIGEgbGlzdCBvZiBhbGwgdGhlIHBhdGNo
ZXMgd2UgbmVlZC4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEFueSBvdGhlciBpZGVhcz8K
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gQUZBSUssIGV4Y2VwdCBmb3IgdnBfdmRwYSwgcGRzIHNl
ZW1zIHRvIGJlIHRoZSBmaXJzdCBwYXJlbnQgdGhhdAo+ID4gPiA+ID4gPiBzdXBwb3J0cyBwYWNr
ZWQgdmlydHF1ZXVlLiBVc2VycyBzaG91bGQgbm90IG5vdGljZSBhbnl0aGluZyB3cm9uZyBpZgo+
ID4gPiA+ID4gPiB0aGV5IGRvbid0IHVzZSBwYWNrZWQgdmlydHF1ZXVlLiBBbmQgdGhlIHByb2Js
ZW0gb2YgdnBfdmRwYSArIHBhY2tlZAo+ID4gPiA+ID4gPiB2aXJ0cXVldWUgY2FtZSBzaW5jZSB0
aGUgZGF5MCBvZiB2cF92ZHBhLiBJdCBzZWVtcyBmaW5lIHRvIGRvIG5vdGhpbmcKPiA+ID4gPiA+
ID4gSSBndWVzcy4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPgo+ID4g
PiA+ID4KPiA+ID4gPiA+IEkgaGF2ZSBhIHF1ZXN0aW9uIHRob3VnaCwgd2hhdCBpZiBkb3duIHRo
ZSByb2FkIHRoZXJlCj4gPiA+ID4gPiBpcyBhIG5ldyBmZWF0dXJlIHRoYXQgbmVlZHMgbW9yZSBj
aGFuZ2VzPyBJdCB3aWxsIGJlCj4gPiA+ID4gPiBicm9rZW4gdG9vIGp1c3QgbGlrZSBQQUNLRUQg
bm8/Cj4gPiA+ID4gPiBTaG91bGRuJ3QgdmRwYSBoYXZlIGFuIGFsbG93bGlzdCBvZiBmZWF0dXJl
cyBpdCBrbm93cyBob3cKPiA+ID4gPiA+IHRvIHN1cHBvcnQ/Cj4gPiA+ID4KPiA+ID4gPiBJdCBs
b29rcyBsaWtlIHdlIGhhZCBpdCwgYnV0IHdlIHRvb2sgaXQgb3V0IChieSB0aGUgd2F5LCB3ZSB3
ZXJlCj4gPiA+ID4gZW5hYmxpbmcgcGFja2VkIGV2ZW4gdGhvdWdoIHdlIGRpZG4ndCBzdXBwb3J0
IGl0KToKPiA+ID4gPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD02MjM0ZjgwNTc0ZDc1Njk0NDRkODcx
ODM1NWZhMjgzOGU5MmIxNThiCj4gPiA+ID4KPiA+ID4gPiBUaGUgb25seSBwcm9ibGVtIEkgc2Vl
IGlzIHRoYXQgZm9yIGVhY2ggbmV3IGZlYXR1cmUgd2UgaGF2ZSB0byBtb2RpZnkKPiA+ID4gPiB0
aGUga2VybmVsLgo+ID4gPiA+IENvdWxkIHdlIGhhdmUgbmV3IGZlYXR1cmVzIHRoYXQgZG9uJ3Qg
cmVxdWlyZSBoYW5kbGluZyBieSB2aG9zdC12ZHBhPwo+ID4gPiA+Cj4gPiA+ID4gVGhhbmtzLAo+
ID4gPiA+IFN0ZWZhbm8KPiA+ID4KPiA+ID4gSmFzb24gd2hhdCBkbyB5b3Ugc2F5IHRvIHJldmVy
dGluZyB0aGlzPwo+ID4KPiA+IEkgbWF5IG1pc3Mgc29tZXRoaW5nIGJ1dCBJIGRvbid0IHNlZSBh
bnkgcHJvYmxlbSB3aXRoIHZEUEEgY29yZS4KPiA+Cj4gPiBJdCdzIHRoZSBkdXR5IG9mIHRoZSBw
YXJlbnRzIHRvIGFkdmVydGlzZSB0aGUgZmVhdHVyZXMgaXQgaGFzLiBGb3IgZXhhbXBsZSwKPiA+
Cj4gPiAxKSBJZiBzb21lIGtlcm5lbCB2ZXJzaW9uIHRoYXQgaXMgcGFja2VkIGlzIG5vdCBzdXBw
b3J0ZWQgdmlhCj4gPiBzZXRfdnFfc3RhdGUsIHBhcmVudHMgc2hvdWxkIG5vdCBhZHZlcnRpc2Ug
UEFDS0VEIGZlYXR1cmVzIGluIHRoaXMKPiA+IGNhc2UuCj4gPiAyKSBJZiB0aGUga2VybmVsIGhh
cyBzdXBwb3J0IHBhY2tlZCBzZXRfdnFfc3RhdGUoKSwgYnV0IGl0J3MgZW11bGF0ZWQKPiA+IGN2
cSBkb2Vzbid0IHN1cHBvcnQsIHBhcmVudHMgc2hvdWxkIG5vdCBhZHZlcnRpc2UgUEFDS0VEIGFz
IHdlbGwKPiA+Cj4gPiBJZiBhIHBhcmVudCB2aW9sYXRlcyB0aGUgYWJvdmUgMiwgaXQgbG9va3Mg
bGlrZSBhIGJ1ZyBvZiB0aGUgcGFyZW50cy4KPiA+Cj4gPiBUaGFua3MKPgo+IFllcyBidXQgd2hh
dCBhYm91dCB2aG9zdF92ZHBhPyBUYWxraW5nIGFib3V0IHRoYXQgbm90IHRoZSBjb3JlLgoKTm90
IHN1cmUgaXQncyBhIGdvb2QgaWRlYSB0byB3b3JrYXJvdW5kIHBhcmVudCBidWdzIHZpYSB2aG9z
dC12RFBBLgoKPiBTaG91bGQgdGhhdCBub3QgaGF2ZSBhIHdoaXRlbGlzdCBvZiBmZWF0dXJlcwo+
IHNpbmNlIGl0IGludGVycHJldHMgaW9jdGxzIGRpZmZlcmVudGx5IGRlcGVuZGluZyBvbiB0aGlz
PwoKSWYgdGhlcmUncyBhIGJ1ZywgaXQgbWlnaHQgb25seSBtYXR0ZXIgdGhlIGZvbGxvd2luZyBz
ZXR1cDoKClNFVF9WUklOR19CQVNFL0dFVF9WUklOR19CQVNFICsgVkRVU0UuCgpUaGlzIHNlZW1z
IHRvIGJlIGJyb2tlbiBzaW5jZSBWRFVTRSB3YXMgaW50cm9kdWNlZC4gSWYgd2UgcmVhbGx5IHdh
bnQKdG8gYmFja3BvcnQgc29tZXRoaW5nLCBpdCBjb3VsZCBiZSBhIGZpeCB0byBmaWx0ZXIgb3V0
IFBBQ0tFRCBpbgpWRFVTRT8KClRoYW5rcwoKPgo+ID4gPgo+ID4gPiAtLQo+ID4gPiBNU1QKPiA+
ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u

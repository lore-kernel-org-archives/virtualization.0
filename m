Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E40CC6FA8E
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 08:12:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DFD2682080;
	Thu,  2 Mar 2023 08:12:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DFD2682080
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dmtzmDto
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qP2RZMS9jJ-b; Thu,  2 Mar 2023 08:12:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 50AF48205C;
	Thu,  2 Mar 2023 08:12:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 50AF48205C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 157C3C0077;
	Thu,  2 Mar 2023 08:12:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4516C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 08:12:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5FAE14100C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 08:10:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5FAE14100C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dmtzmDto
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RVaUJojnCyzs
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 08:10:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3206140FFE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3206140FFE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 08:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677744634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a4doVFCQ5KJmZV+lPvurw3orc9Atjymj2EsOoEfGZFo=;
 b=dmtzmDto+9hlv3tqWjzeuG29U8JX7jYbxXXTQZj8f3b1gqULvM0+F8DGFJY4LPGOnStlNX
 y1aaMI2yMykGrxVU449u7LF3krOHvqJMIeFpAIrrzAh6psjQrXvEnsE+YdkGI03i6EgW4x
 ITaTxqm/XNuv+cjMeh5r5cqrekkwXfE=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-284-Wk0BUe9nM46MVSSNV3qhhw-1; Thu, 02 Mar 2023 03:10:33 -0500
X-MC-Unique: Wk0BUe9nM46MVSSNV3qhhw-1
Received: by mail-ot1-f70.google.com with SMTP id
 r23-20020a05683001d700b0068bc6c8621eso7607538ota.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Mar 2023 00:10:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a4doVFCQ5KJmZV+lPvurw3orc9Atjymj2EsOoEfGZFo=;
 b=3ZHS9gDsZr4jf+FXMgtoJanzWaK6wIj3HAHHYvAMyzOFTFwPaXPooVIZINWnB73ccE
 ctNjoJwcx3GJbJhzNUoRLIfcJUVqhGearv/56dTR797obIq8DiFWNDf0sR3sCgAPFpfA
 IamlhYrP6ph3BaOOX/vmAGg5q/uR47mTe7Ptbm5RVwTMC+A3ubTe9mK0qN3Lm903X+93
 NjiAALRmFTgK3MZnoOlReL5XvGXtKuTlC9cIwga7nfWkXw7kgzeSEHY+Kb+ykTj35xfQ
 2PbyTuYzRTl+ThTu8TfeuMY/Jio/nGpJMnMthI+p015DM20VokTQFLpYTTYBHxO5RNUZ
 Jyqw==
X-Gm-Message-State: AO0yUKUleuWY1lS7JreOTRA8/AmrkAkWPMpYerlqOokqxfOVTw2mN0fZ
 EE1qogl53oD4ni9HkOjdXDYId/Bdyj2QELrufj7pzPS0s017PxavKKhwU7A7B38Fg/TZ9PsYp4m
 Vg6ihBFvtFF2D0d5wLjZsqyBjtEGGANoKFl0ohHuVDTwtiN4Eg0ItM2zdxg==
X-Received: by 2002:a54:480c:0:b0:36e:f6f5:604c with SMTP id
 j12-20020a54480c000000b0036ef6f5604cmr2797482oij.9.1677744632433; 
 Thu, 02 Mar 2023 00:10:32 -0800 (PST)
X-Google-Smtp-Source: AK7set+sj3fbXt8XiifY046sFFbf1plye0Fiy4DTIoY+gujjAl0FnNe8UJAkIsvsAya6Z4XPKOwpwLtdFB2CiXVSkd4=
X-Received: by 2002:a54:480c:0:b0:36e:f6f5:604c with SMTP id
 j12-20020a54480c000000b0036ef6f5604cmr2797460oij.9.1677744631216; Thu, 02 Mar
 2023 00:10:31 -0800 (PST)
MIME-Version: 1.0
References: <20230223-virtio-net-kvmtool-v3-1-e038660624de@rivosinc.com>
 <20230301093054-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230301093054-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Mar 2023 16:10:20 +0800
Message-ID: <CACGkMEsG10CWigz+S6JgSVK8XfbpT=L=30hZ8LDvohtaanAiZQ@mail.gmail.com>
Subject: Re: [PATCH v3] virtio-net: Fix probe of virtio-net on kvmtool
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 rbradford@rivosinc.com, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

T24gV2VkLCBNYXIgMSwgMjAyMyBhdCAxMDo0NOKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gV2VkLCBNYXIgMDEsIDIwMjMgYXQgMDE6NTk6NTJQ
TSArMDAwMCwgUm9iIEJyYWRmb3JkIHZpYSBCNCBSZWxheSB3cm90ZToKPiA+IEZyb206IFJvYiBC
cmFkZm9yZCA8cmJyYWRmb3JkQHJpdm9zaW5jLmNvbT4KPiA+Cj4gPiBTaW5jZSB0aGUgZm9sbG93
aW5nIGNvbW1pdCB2aXJ0aW8tbmV0IG9uIGt2bXRvb2wgaGFzIHByaW50ZWQgYSB3YXJuaW5nCj4g
PiBkdXJpbmcgdGhlIHByb2JlOgo+ID4KPiA+IGNvbW1pdCBkYmNmMjRkMTUzODg0NDM5ZGFkMzA0
ODRhMGUzZjAyMzUwNjkyZTRjCj4gPiBBdXRob3I6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+Cj4gPiBEYXRlOiAgIFR1ZSBBdWcgMTcgMTY6MDY6NTkgMjAyMSArMDgwMAo+ID4KPiA+
ICAgICB2aXJ0aW8tbmV0OiB1c2UgTkVUSUZfRl9HUk9fSFcgaW5zdGVhZCBvZiBORVRJRl9GX0xS
Two+ID4KPiA+IFsgICAgMS44NjU5OTJdIG5ldCBldGgwOiBGYWlsIHRvIHNldCBndWVzdCBvZmZs
b2FkLgo+ID4gWyAgICAxLjg3MjQ5MV0gdmlydGlvX25ldCB2aXJ0aW8yIGV0aDA6IHNldF9mZWF0
dXJlcygpIGZhaWxlZCAoLTIyKTsgd2FudGVkIDB4MDAwMDAwMDAwMDEzNDgyOSwgbGVmdCAweDAw
ODAwMDAwMDAxMzQ4MjkKPiA+Cj4gPiBUaGlzIGlzIGJlY2F1c2UgZHVyaW5nIHRoZSBwcm9iaW5n
IHRoZSB1bmRlcmx5aW5nIG5ldGRldiBkZXZpY2UgaGFzCj4gPiBpZGVudGlmaWVkIHRoYXQgdGhl
IG5ldGRldiBmZWF0dXJlcyBvbiB0aGUgZGV2aWNlIGhhcyBjaGFuZ2VkIGFuZAo+ID4gYXR0ZW1w
dHMgdG8gdXBkYXRlIHRoZSB2aXJ0aW8tbmV0IG9mZmxvYWRzIHRocm91Z2ggdGhlIHZpcnRpby1u
ZXQKPiA+IGNvbnRyb2wgcXVldWUuIGt2bXRvb2wgaG93ZXZlciBkb2VzIG5vdCBoYXZlIGEgY29u
dHJvbCBxdWV1ZSB0aGF0IHN1cHBvcnRzCj4gPiBvZmZsb2FkIGNoYW5naW5nIChWSVJUSU9fTkVU
X0ZfQ1RSTF9HVUVTVF9PRkZMT0FEUyBpcyBub3QgYWR2ZXJ0aXNlZCkKPiA+Cj4gPiBUaGUgbmV0
ZGV2IGZlYXR1cmVzIGhhdmUgY2hhbmdlZCBkdWUgdG8gdmFsaWRhdGlvbiBjaGVja3MgaW4KPiA+
IG5ldGRldl9maXhfZmVhdHVyZXMoKToKPiA+Cj4gPiBpZiAoIShmZWF0dXJlcyAmIE5FVElGX0Zf
UlhDU1VNKSkgewo+ID4gICAgICAgLyogTkVUSUZfRl9HUk9fSFcgaW1wbGllcyBkb2luZyBSWENT
VU0gc2luY2UgZXZlcnkgcGFja2V0Cj4gPiAgICAgICAgKiBzdWNjZXNzZnVsbHkgbWVyZ2VkIGJ5
IGhhcmR3YXJlIG11c3QgYWxzbyBoYXZlIHRoZQo+ID4gICAgICAgICogY2hlY2tzdW0gdmVyaWZp
ZWQgYnkgaGFyZHdhcmUuICBJZiB0aGUgdXNlciBkb2VzIG5vdAo+ID4gICAgICAgICogd2FudCB0
byBlbmFibGUgUlhDU1VNLCBsb2dpY2FsbHksIHdlIHNob3VsZCBkaXNhYmxlIEdST19IVy4KPiA+
ICAgICAgICAqLwo+ID4gICAgICAgaWYgKGZlYXR1cmVzICYgTkVUSUZfRl9HUk9fSFcpIHsKPiA+
ICAgICAgICAgICAgICAgbmV0ZGV2X2RiZyhkZXYsICJEcm9wcGluZyBORVRJRl9GX0dST19IVyBz
aW5jZSBubyBSWENTVU0gZmVhdHVyZS5cbiIpOwo+ID4gICAgICAgICAgICAgICBmZWF0dXJlcyAm
PSB+TkVUSUZfRl9HUk9fSFc7Cj4gPiAgICAgICB9Cj4gPiB9Cj4gPgo+ID4gU2luY2Uga3ZtdG9v
bCBkb2VzIG5vdCBhZHZlcnRpc2UgdGhlIFZJUlRJT19ORVRfRl9HVUVTVF9DU1VNIGZlYXR1cmUg
dGhlCj4gPiBORVRJRl9GX1JYQ1NVTSBiaXQgaXMgbm90IHByZXNlbnQgYW5kIHNvIHRoZSBORVRJ
Rl9GX0dST19IVyBiaXQgaXMKPiA+IGNsZWFyZWQuIFRoaXMgcmVzdWx0cyBpbiB0aGUgbmV0ZGV2
IGZlYXR1cmVzIGNoYW5naW5nLCB3aGljaCB0cmlnZ2Vycwo+ID4gdGhlIGF0dGVtcHQgdG8gcmVw
cm9ncmFtIHRoZSB2aXJ0aW8tbmV0IG9mZmxvYWRzIHdoaWNoIHRoZW4gZmFpbHMuCj4gPgo+ID4g
VGhpcyBjb21taXQgcHJldmVudHMgdGhhdCBzZXQgb2YgbmV0ZGV2IGZlYXR1cmVzIGZyb20gY2hh
bmdpbmcgYnkKPiA+IHByZWVtcHRpdmVseSBhcHBseWluZyB0aGUgc2FtZSB2YWxpZGF0aW9uIGFu
ZCBvbmx5IHNldHRpbmcKPiA+IE5FVElGX0ZfR1JPX0hXIGlmIE5FVElGX0ZfUlhDU1VNIGlzIHNl
dCBiZWNhdXNlIHRoZSBkZXZpY2Ugc3VwcG9ydHMgYm90aAo+ID4gVklSVElPX05FVF9GX0dVRVNU
X0NTVU0gYW5kIFZJUlRJT19ORVRfRl9HVUVTVF9UU097NCw2fQo+ID4KPiA+IFNpZ25lZC1vZmYt
Ynk6IFJvYiBCcmFkZm9yZCA8cmJyYWRmb3JkQHJpdm9zaW5jLmNvbT4KPiA+IC0tLQo+ID4gQ2hh
bmdlcyBpbiB2MzoKPiA+IC0gSWRlbnRpZmllZCByb290LWNhdXNlIG9mIGZlYXR1cmUgYml0IGNo
YW5naW5nIGFuZCB1cGRhdGVkIGNvbmRpdGlvbnMKPiA+ICAgY2hlY2sKPiA+IC0gTGluayB0byB2
MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIzMDIyMy12aXJ0aW8tbmV0LWt2bXRvb2wt
djItMS04ZWM5MzUxMWU2N2ZAcml2b3NpbmMuY29tCj4gPgo+ID4gQ2hhbmdlcyBpbiB2MjoKPiA+
IC0gVXNlIHBhcmVudGhlc2VzIHRvIGdyb3VwIGxvZ2ljYWwgT1Igb2YgZmVhdHVyZXMKPiA+IC0g
TGluayB0byB2MToKPiA+ICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIzMDIyMy12aXJ0
aW8tbmV0LWt2bXRvb2wtdjEtMS1mYzIzZDI5YjlkN2FAcml2b3NpbmMuY29tCj4gPiAtLS0KPiA+
ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAxMCArKysrKystLS0tCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4g
PiBpbmRleCA2MWUzM2U0ZGQwY2QuLjJlNzcwNTE0MmNhNSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4g
PiBAQCAtMzc3OCwxMSArMzc3OCwxMyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcHJvYmUoc3RydWN0
IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gPiAgICAgICAgICAgICAgICAgICAgICAgZGV2LT5mZWF0
dXJlcyB8PSBkZXYtPmh3X2ZlYXR1cmVzICYgTkVUSUZfRl9BTExfVFNPOwo+ID4gICAgICAgICAg
ICAgICAvKiAoIWNzdW0gJiYgZ3NvKSBjYXNlIHdpbGwgYmUgZml4ZWQgYnkgcmVnaXN0ZXJfbmV0
ZGV2KCkgKi8KPiA+ICAgICAgIH0KPiA+IC0gICAgIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRl
diwgVklSVElPX05FVF9GX0dVRVNUX0NTVU0pKQo+ID4gKyAgICAgaWYgKHZpcnRpb19oYXNfZmVh
dHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfQ1NVTSkpIHsKPiA+ICAgICAgICAgICAgICAg
ZGV2LT5mZWF0dXJlcyB8PSBORVRJRl9GX1JYQ1NVTTsKPiA+IC0gICAgIGlmICh2aXJ0aW9faGFz
X2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX0dVRVNUX1RTTzQpIHx8Cj4gPiAtICAgICAgICAg
dmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9HVUVTVF9UU082KSkKPiA+IC0g
ICAgICAgICAgICAgZGV2LT5mZWF0dXJlcyB8PSBORVRJRl9GX0dST19IVzsKPiA+ICsgICAgICAg
ICAgICAgLyogVGhpcyBkZXBlbmRlbmN5IGlzIGVuZm9yY2VkIGJ5IG5ldGRldl9maXhfZmVhdHVy
ZXMgKi8KPiA+ICsgICAgICAgICAgICAgaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJU
SU9fTkVUX0ZfR1VFU1RfVFNPNCkgfHwKPiA+ICsgICAgICAgICAgICAgICAgIHZpcnRpb19oYXNf
ZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNikpCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgZGV2LT5mZWF0dXJlcyB8PSBORVRJRl9GX0dST19IVzsKPiA+ICsgICAgIH0KPiA+
ICAgICAgIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX0NUUkxfR1VF
U1RfT0ZGTE9BRFMpKQo+ID4gICAgICAgICAgICAgICBkZXYtPmh3X2ZlYXR1cmVzIHw9IE5FVElG
X0ZfR1JPX0hXOwoKU2hvdWxkIHdlIG1vdmUgdGhpcyBhbHNvIHVuZGVyIHRoZSBjaGVjayBvZiBS
WENTVU0sIG90aGVyd2lzZSB3ZSBtYXkKZW5kIHVwIHRoZSBmb2xsb3dpbmcgY2FzZToKCndoZW4g
Q1NVTSBpcyBub3QgbmVnb3RpYXRlZCBidXQgR1VFU1RfT0ZGTE9BRFMsIGNhbiBzdGlsbCB0cnkg
dG8KZW5hYmxlLW9yLWRpc2FibGUgZ3Vlc3Qgb2ZmbG9hZHM/IE9yIGRvIHdlIG5lZWQgdG8gZmFp
bCB0aGUgcHJvYmUgaW4KdGhlIGNhc2UgdmlhIHZpcnRuZXRfdmFsaWRhdGVfZmVhdHVyZXMoKT8K
Cj4gPgo+Cj4gSSBzZWUuIEl0IGlzIGFubm95aW5nIHRoYXQgd2UgYXJlIGR1cGxpY2F0aW5nIHRo
ZSBsb2dpYyBmcm9tCj4gbmV0ZGV2X2ZpeF9mZWF0dXJlcyBoZXJlIHRob3VnaCA6KAo+IE1heWJl
IHdlIHNob3VsZCBjYWxsIG5ldGRldl91cGRhdGVfZmVhdHVyZXMsIGluIHRoZSBjYWxsYmFjayBj
aGVjawo+IHRoZSBmbGFncyBhbmQgZGVjaWRlIHdoYXQgdG8gc2V0IGFuZCB3aGF0IHRvIGNsZWFy
Pwo+IE9yIGV4cG9ydCBuZXRkZXZfZml4X2ZlYXR1cmVzIHRvIG1vZHVsZXM/CgpUaGVyZSdzIGEg
bmRvX2ZpeF9mZWF0dXJlcygpIHRoYXQgbWlnaHQgYmUgdXNlZCBoZXJlLgoKPgo+Cj4KPiBBbHNv
IHJlLXJlYWRpbmcgRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL25ldGRldi1mZWF0dXJlcy5yc3Qg
LQo+Cj4gIDEuIG5ldGRldi0+aHdfZmVhdHVyZXMgc2V0IGNvbnRhaW5zIGZlYXR1cmVzIHdob3Nl
IHN0YXRlIG1heSBwb3NzaWJseQo+ICAgICBiZSBjaGFuZ2VkIChlbmFibGVkIG9yIGRpc2FibGVk
KSBmb3IgYSBwYXJ0aWN1bGFyIGRldmljZSBieSB1c2VyJ3MKPiAgICAgcmVxdWVzdC4gIFRoaXMg
c2V0IHNob3VsZCBiZSBpbml0aWFsaXplZCBpbiBuZG9faW5pdCBjYWxsYmFjayBhbmQgbm90Cj4g
ICAgIGNoYW5nZWQgbGF0ZXIuCj4KPiAgMi4gbmV0ZGV2LT5mZWF0dXJlcyBzZXQgY29udGFpbnMg
ZmVhdHVyZXMgd2hpY2ggYXJlIGN1cnJlbnRseSBlbmFibGVkCj4gICAgIGZvciBhIGRldmljZS4g
IFRoaXMgc2hvdWxkIGJlIGNoYW5nZWQgb25seSBieSBuZXR3b3JrIGNvcmUgb3IgaW4KPiAgICAg
ZXJyb3IgcGF0aHMgb2YgbmRvX3NldF9mZWF0dXJlcyBjYWxsYmFjay4KPgo+Cj4gaXMgaXQgdGhl
biB3cm9uZyB0aGF0IHZpcnRpbyBzZXRzIE5FVElGX0ZfUlhDU1VNIGFuZCBORVRJRl9GX0dST19I
VyBpbgo+IGRldi0+ZmVhdHVyZXMgYW5kIG5vdCBpbiBkZXYtPmh3X2ZlYXR1cmVzPwoKTG9va3Mg
bm90IHRoZSBjb3JlIGNhbiB0cnkgdG8gZW5hYmxlIGFuZCBkaXNhYmxlIGZlYXR1cmVzIGFjY29y
ZGluZyB0bwp0aGUgZGlmZiBiZXR3ZWVuIGZlYXR1cmVzIGFuZCBod19mZWF0dXJlcwoKc3RhdGlj
IGlubGluZSBuZXRkZXZfZmVhdHVyZXNfdCBuZXRkZXZfZ2V0X3dhbnRlZF9mZWF0dXJlcygKICAg
ICAgICBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQp7CiAgICAgICAgcmV0dXJuIChkZXYtPmZlYXR1
cmVzICYgfmRldi0+aHdfZmVhdHVyZXMpIHwgZGV2LT53YW50ZWRfZmVhdHVyZXM7Cn0KClRoYW5r
cwoKPiBXZSBzZXQgaXQgdGhlcmUgYmVjYXVzZQo+IHdpdGhvdXQgY3RybCBndWVzdCBvZmZsb2Fk
IHRoZXNlIGNhbiBub3QgYmUgY2hhbmdlZC4KPiBJIHN1c3BlY3QgdGhpcyBpcyBqdXN0IGEgbWlu
b3IgZG9jdW1lbnRhdGlvbiBidWcgeWVzPyBNYXliZSBkZXZpY2VzCj4gd2hlcmUgZmVhdHVyZXMg
Y2FuJ3QgYmUgY2xlYXJlZCBhcmUgdW5jb21tb24uCj4KPiBBbHNvOgo+ICAgICAgICAgaWYgKHZp
cnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfQ1RSTF9HVUVTVF9PRkZMT0FEUykp
Cj4gICAgICAgICAgICAgICAgIGRldi0+aHdfZmVhdHVyZXMgfD0gTkVUSUZfRl9HUk9fSFc7Cj4K
PiBidXQgc2hvdWxkIHdlIG5vdCBzZXQgTkVUSUZfRl9SWENTVU0gdGhlcmUgdG9vPwo+Cj4KPgo+
ID4gLS0tCj4gPiBiYXNlLWNvbW1pdDogYzM5Y2VhNmYzOGVlZmUzNTZkNjRkMGJjMWUxZjIyNjdl
MjgyY2RkMwo+ID4gY2hhbmdlLWlkOiAyMDIzMDIyMy12aXJ0aW8tbmV0LWt2bXRvb2wtODdmMzc1
MTViZTIyCj4gPgo+ID4gQmVzdCByZWdhcmRzLAo+ID4gLS0KPiA+IFJvYiBCcmFkZm9yZCA8cmJy
YWRmb3JkQHJpdm9zaW5jLmNvbT4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

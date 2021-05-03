Return-Path: <SRS0=lx0b=J6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B72C433ED
	for <virtualization@archiver.kernel.org>; Mon,  3 May 2021 08:00:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237DF61221
	for <virtualization@archiver.kernel.org>; Mon,  3 May 2021 08:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237DF61221
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D75B7404D4;
	Mon,  3 May 2021 08:00:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LIlN2yo_JrIX; Mon,  3 May 2021 08:00:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3A28404E0;
	Mon,  3 May 2021 08:00:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD89BC000E;
	Mon,  3 May 2021 08:00:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30DBFC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 08:00:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4BBE640475
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 08:00:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MpZa7Ib9fUH3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 08:00:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 030F54047E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 08:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620028819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KSlg/6TXM81jhkSAlJ0xj1Zt15A1EScYsDk40WJyrac=;
 b=MDQhJh+GbxX8LbdE4CHAzQ58V9o3kviJn1irK/UvcBmxgoRmZDFXOlWrm32pkPk8TO9rUp
 oRMHPamPiVWnouAw98PrpgSRELTH/TNrmfFLH+yYSl9gAwx5Ys7z1uDt3yp2tl1qRC+4oL
 K4Ipglf2pwEGboyQYLV3zx2dM9zSl4Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-pfVjefeCO7CafYBvbHBPog-1; Mon, 03 May 2021 04:00:17 -0400
X-MC-Unique: pfVjefeCO7CafYBvbHBPog-1
Received: by mail-wm1-f70.google.com with SMTP id
 c2-20020a1cb3020000b029013850c82dbcso2144543wmf.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 May 2021 01:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=KSlg/6TXM81jhkSAlJ0xj1Zt15A1EScYsDk40WJyrac=;
 b=kanK7SIm2YMvWvnMGyCu5529QbwKSp4yOGXokIpiU1eUlEmo+medVw7BskPldScuq/
 ajtsUT5483qtA7re2dgv4EFEqmhs3sSGUdxuGLIuwaHmijoVtPU3GELe6a4hBqOHoCkV
 j+NncjOTAByNaJps+SAQzR67IsGVKKiKE5XN3vLjWSas8o1TkTqzKNAwB78NuC7Dtrlo
 XzdbHx8VaHX8RU/hfWxwYqM0MPbCh1VmuphiacmllhxwfswbKy698lqgSkLgy4hxdiW6
 iEhxOUcdHWlns6gcjybkuLx3yV7GpdEHxG1/F3580ak24gmJifB9VCb3WTdAcsZpnzzT
 eBZQ==
X-Gm-Message-State: AOAM530xHw6v5XcxpsawVZIlFHY9fCunMu7PQzs8Nnxrf7TvoSiolaeC
 POP9dYN5Irp0Fl3SfhEiNODha294ntXJXsSTf451zJ2ZLJP1fhrYbzQe1FxAuoHFcEnubNA+r2a
 O6jMzhojCPSxgUCtjnSTEmAleKC0FfMSxoDfVU9rvmQ==
X-Received: by 2002:a05:600c:47d7:: with SMTP id
 l23mr30998085wmo.95.1620028816125; 
 Mon, 03 May 2021 01:00:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxG8f8FKrGEHlHEe8i1uSyVXb+d7Twhf4Z/yX/SHYitc/v+CFKORKHcvRNOcLGDI4wI56ww5A==
X-Received: by 2002:a05:600c:47d7:: with SMTP id
 l23mr30998070wmo.95.1620028815972; 
 Mon, 03 May 2021 01:00:15 -0700 (PDT)
Received: from redhat.com ([2a10:800a:cdef:0:114d:2085:61e4:7b41])
 by smtp.gmail.com with ESMTPSA id r2sm1277623wrv.39.2021.05.03.01.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 May 2021 01:00:15 -0700 (PDT)
Date: Mon, 3 May 2021 04:00:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next] virtio-net: fix use-after-free in skb_gro_receive
Message-ID: <20210503035959-mutt-send-email-mst@kernel.org>
References: <1619151585.3098595-1-xuanzhuo@linux.alibaba.com>
 <b2f5cab7-18dd-2817-7423-e84ea1907bf3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b2f5cab7-18dd-2817-7423-e84ea1907bf3@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Ido Schimmel <idosch@nvidia.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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

T24gRnJpLCBBcHIgMjMsIDIwMjEgYXQgMTI6MzM6MDlQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS80LzIzIOS4i+WNiDEyOjE5LCBYdWFuIFpodW8g5YaZ6YGTOgo+ID4g
T24gRnJpLCAyMyBBcHIgMjAyMSAxMjowODozNCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+IOWcqCAyMDIxLzQvMjIg5LiL5Y2IMTE6MTYsIFh1YW4g
Wmh1byDlhpnpgZM6Cj4gPiA+ID4gV2hlbiAiaGVhZHJvb20iID4gMCwgdGhlIGFjdHVhbCBhbGxv
Y2F0ZWQgbWVtb3J5IHNwYWNlIGlzIHRoZSBlbnRpcmUKPiA+ID4gPiBwYWdlLCBzbyB0aGUgYWRk
cmVzcyBvZiB0aGUgcGFnZSBzaG91bGQgYmUgdXNlZCB3aGVuIHBhc3NpbmcgaXQgdG8KPiA+ID4g
PiBidWlsZF9za2IoKS4KPiA+ID4gPiAKPiA+ID4gPiBCVUc6IEtBU0FOOiB1c2UtYWZ0ZXItZnJl
ZSBpbiBza2JfZ3JvX3JlY2VpdmUgKG5ldC9jb3JlL3NrYnVmZi5jOjQyNjApCj4gPiA+ID4gV3Jp
dGUgb2Ygc2l6ZSAxNiBhdCBhZGRyIGZmZmY4ODgxMTYxOWZmZmMgYnkgdGFzayBrd29ya2VyL3U5
OjAvNTM0Cj4gPiA+ID4gQ1BVOiAyIFBJRDogNTM0IENvbW06IGt3b3JrZXIvdTk6MCBOb3QgdGFp
bnRlZCA1LjEyLjAtcmM3LWN1c3RvbS0xNjM3Mi1nYjE1MGJlMDViODA2ICMzMzgyCj4gPiA+ID4g
SGFyZHdhcmUgbmFtZTogUUVNVSBNU04yNzAwLCBCSU9TIHJlbC0xLjEzLjAtMC1nZjIxYjVhNGFl
YjAyLXByZWJ1aWx0LnFlbXUub3JnIDA0LzAxLzIwMTQKPiA+ID4gPiBXb3JrcXVldWU6IHhwcnRp
b2QgeHNfc3RyZWFtX2RhdGFfcmVjZWl2ZV93b3JrZm4gW3N1bnJwY10KPiA+ID4gPiBDYWxsIFRy
YWNlOgo+ID4gPiA+ICAgIDxJUlE+Cj4gPiA+ID4gZHVtcF9zdGFjayAobGliL2R1bXBfc3RhY2su
YzoxMjIpCj4gPiA+ID4gcHJpbnRfYWRkcmVzc19kZXNjcmlwdGlvbi5jb25zdHByb3AuMCAobW0v
a2FzYW4vcmVwb3J0LmM6MjMzKQo+ID4gPiA+IGthc2FuX3JlcG9ydC5jb2xkIChtbS9rYXNhbi9y
ZXBvcnQuYzo0MDAgbW0va2FzYW4vcmVwb3J0LmM6NDE2KQo+ID4gPiA+IHNrYl9ncm9fcmVjZWl2
ZSAobmV0L2NvcmUvc2tidWZmLmM6NDI2MCkKPiA+ID4gPiB0Y3BfZ3JvX3JlY2VpdmUgKG5ldC9p
cHY0L3RjcF9vZmZsb2FkLmM6MjY2IChkaXNjcmltaW5hdG9yIDEpKQo+ID4gPiA+IHRjcDRfZ3Jv
X3JlY2VpdmUgKG5ldC9pcHY0L3RjcF9vZmZsb2FkLmM6MzE2KQo+ID4gPiA+IGluZXRfZ3JvX3Jl
Y2VpdmUgKG5ldC9pcHY0L2FmX2luZXQuYzoxNTQ1IChkaXNjcmltaW5hdG9yIDIpKQo+ID4gPiA+
IGRldl9ncm9fcmVjZWl2ZSAobmV0L2NvcmUvZGV2LmM6NjA3NSkKPiA+ID4gPiBuYXBpX2dyb19y
ZWNlaXZlIChuZXQvY29yZS9kZXYuYzo2MTY4IG5ldC9jb3JlL2Rldi5jOjYxOTgpCj4gPiA+ID4g
cmVjZWl2ZV9idWYgKGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYzoxMTUxKSB2aXJ0aW9fbmV0Cj4g
PiA+ID4gdmlydG5ldF9wb2xsIChkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmM6MTQxNSBkcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmM6MTUxOSkgdmlydGlvX25ldAo+ID4gPiA+IF9fbmFwaV9wb2xsIChu
ZXQvY29yZS9kZXYuYzo2OTY0KQo+ID4gPiA+IG5ldF9yeF9hY3Rpb24gKG5ldC9jb3JlL2Rldi5j
OjcwMzMgbmV0L2NvcmUvZGV2LmM6NzExOCkKPiA+ID4gPiBfX2RvX3NvZnRpcnEgKC4vYXJjaC94
ODYvaW5jbHVkZS9hc20vanVtcF9sYWJlbC5oOjI1IC4vaW5jbHVkZS9saW51eC9qdW1wX2xhYmVs
Lmg6MjAwIC4vaW5jbHVkZS90cmFjZS9ldmVudHMvaXJxLmg6MTQyIGtlcm5lbC9zb2Z0aXJxLmM6
MzQ2KQo+ID4gPiA+IGlycV9leGl0X3JjdSAoa2VybmVsL3NvZnRpcnEuYzoyMjEga2VybmVsL3Nv
ZnRpcnEuYzo0MjIga2VybmVsL3NvZnRpcnEuYzo0MzQpCj4gPiA+ID4gY29tbW9uX2ludGVycnVw
dCAoYXJjaC94ODYva2VybmVsL2lycS5jOjI0MCAoZGlzY3JpbWluYXRvciAxNCkpCj4gPiA+ID4g
PC9JUlE+Cj4gPiA+ID4gCj4gPiA+ID4gRml4ZXM6IGZiMzI4NTZiMTZhZCAoInZpcnRpby1uZXQ6
IHBhZ2VfdG9fc2tiKCkgdXNlIGJ1aWxkX3NrYiB3aGVuIHRoZXJlJ3Mgc3VmZmljaWVudCB0YWls
cm9vbSIpCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5h
bGliYWJhLmNvbT4KPiA+ID4gPiBSZXBvcnRlZC1ieTogSWRvIFNjaGltbWVsIDxpZG9zY2hAbnZp
ZGlhLmNvbT4KPiA+ID4gPiBUZXN0ZWQtYnk6IElkbyBTY2hpbW1lbCA8aWRvc2NoQG52aWRpYS5j
b20+Cj4gPiA+ID4gLS0tCj4gPiA+IAo+ID4gPiBBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4KPiA+ID4gCj4gPiA+IFRoZSBjb2RlcyBiZWNhbWUgaGFyZCB0byByZWFk
LCBJIHRoaW5rIHdlIGNhbiB0cnkgdG8gZG8gc29tZSBjbGVhbnVwcyBvbgo+ID4gPiB0b3AgdG8g
bWFrZSBpdCBlYXNpZXIgdG8gcmVhZC4KPiA+ID4gCj4gPiA+IFRoYW5rcwo+ID4gWWVzLCB0aGlz
IHBpZWNlIG9mIGNvZGUgbmVlZHMgdG8gYmUgc29ydGVkIG91dC4gRXNwZWNpYWxseSB0aGUgYmln
IGFuZCBtZXJnZWFibGUKPiA+IHNjZW5hcmlvcyBzaG91bGQgYmUgaGFuZGxlZCBzZXBhcmF0ZWx5
LiBSZW1vdmUgdGhlIG1lcmdlYWJsZSBjb2RlIGZyb20gdGhpcwo+ID4gZnVuY3Rpb24sIGFuZCBt
ZXJnZWFibGUgdXNlcyBhIG5ldyBmdW5jdGlvbiBhbG9uZS4KPiAKPiAKPiBSaWdodCwgYW5vdGhl
ciB0aGluZyBpcyB0aGF0IHdlIG1heSBjb25zaWRlciB0byByZWxheCB0aGUgY2hlY2tpbmcgb2Yg
bGVuIDwKPiBHT09EX0NPUFlfTEVOLgoKCldhbnQgdG8gcG9zdCBhIHBhdGNoIG9uIHRvcD8KCj4g
T3VyIFFFIHN0aWxsIHNlZSBsb3cgUFBTIGNvbXBhcmVkIHdpdGggdGhlIGNvZGUgYmVmb3JlIDMy
MjZiMTU4ZTY3YyAoIm5ldDoKPiBhdm9pZCAzMiB4IHRydWVzaXplIHVuZGVyLWVzdGltYXRpb24g
Zm9yIHRpbnkgc2ticyIpLgo+IAo+IFRoYW5rcwo+IAo+IAo+ID4gCj4gPiBUaGFua3MuCj4gPiAK
PiA+ID4gCj4gPiA+ID4gICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMTIgKysrKysrKysr
LS0tCj4gPiA+ID4gICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkKPiA+ID4gPiAKPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gaW5kZXggNzRkMmQ0OTI2NGYz
Li43ZmRhMmFlNGM0MGYgMTAwNjQ0Cj4gPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jCj4gPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gQEAgLTM4
Nyw3ICszODcsNyBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnBhZ2VfdG9fc2tiKHN0cnVjdCB2
aXJ0bmV0X2luZm8gKnZpLAo+ID4gPiA+ICAgIAl1bnNpZ25lZCBpbnQgY29weSwgaGRyX2xlbiwg
aGRyX3BhZGRlZF9sZW47Cj4gPiA+ID4gICAgCXN0cnVjdCBwYWdlICpwYWdlX3RvX2ZyZWUgPSBO
VUxMOwo+ID4gPiA+ICAgIAlpbnQgdGFpbHJvb20sIHNoaW5mb19zaXplOwo+ID4gPiA+IC0JY2hh
ciAqcCwgKmhkcl9wOwo+ID4gPiA+ICsJY2hhciAqcCwgKmhkcl9wLCAqYnVmOwo+ID4gPiA+IAo+
ID4gPiA+ICAgIAlwID0gcGFnZV9hZGRyZXNzKHBhZ2UpICsgb2Zmc2V0Owo+ID4gPiA+ICAgIAlo
ZHJfcCA9IHA7Cj4gPiA+ID4gQEAgLTQwMywxMSArNDAzLDE1IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tf
YnVmZiAqcGFnZV90b19za2Ioc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gPiA+ID4gICAgCSAq
IHNwYWNlIGFyZSBhbGlnbmVkLgo+ID4gPiA+ICAgIAkgKi8KPiA+ID4gPiAgICAJaWYgKGhlYWRy
b29tKSB7Cj4gPiA+ID4gLQkJLyogVGhlIGFjdHVhbCBhbGxvY2F0ZWQgc3BhY2Ugc2l6ZSBpcyBQ
QUdFX1NJWkUuICovCj4gPiA+ID4gKwkJLyogQnVmZmVycyB3aXRoIGhlYWRyb29tIHVzZSBQQUdF
X1NJWkUgYXMgYWxsb2Mgc2l6ZSwKPiA+ID4gPiArCQkgKiBzZWUgYWRkX3JlY3ZidWZfbWVyZ2Vh
YmxlKCkgKyBnZXRfbWVyZ2VhYmxlX2J1Zl9sZW4oKQo+ID4gPiA+ICsJCSAqLwo+ID4gPiA+ICAg
IAkJdHJ1ZXNpemUgPSBQQUdFX1NJWkU7Cj4gPiA+ID4gICAgCQl0YWlscm9vbSA9IHRydWVzaXpl
IC0gbGVuIC0gb2Zmc2V0Owo+ID4gPiA+ICsJCWJ1ZiA9IHBhZ2VfYWRkcmVzcyhwYWdlKTsKPiA+
ID4gPiAgICAJfSBlbHNlIHsKPiA+ID4gPiAgICAJCXRhaWxyb29tID0gdHJ1ZXNpemUgLSBsZW47
Cj4gPiA+ID4gKwkJYnVmID0gcDsKPiA+ID4gPiAgICAJfQo+ID4gPiA+IAo+ID4gPiA+ICAgIAls
ZW4gLT0gaGRyX2xlbjsKPiA+ID4gPiBAQCAtNDE2LDExICs0MjAsMTMgQEAgc3RhdGljIHN0cnVj
dCBza19idWZmICpwYWdlX3RvX3NrYihzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiA+ID4gPiAK
PiA+ID4gPiAgICAJc2hpbmZvX3NpemUgPSBTS0JfREFUQV9BTElHTihzaXplb2Yoc3RydWN0IHNr
Yl9zaGFyZWRfaW5mbykpOwo+ID4gPiA+IAo+ID4gPiA+ICsJLyogY29weSBzbWFsbCBwYWNrZXQg
c28gd2UgY2FuIHJldXNlIHRoZXNlIHBhZ2VzICovCj4gPiA+ID4gICAgCWlmICghTkVUX0lQX0FM
SUdOICYmIGxlbiA+IEdPT0RfQ09QWV9MRU4gJiYgdGFpbHJvb20gPj0gc2hpbmZvX3NpemUpIHsK
PiA+ID4gPiAtCQlza2IgPSBidWlsZF9za2IocCwgdHJ1ZXNpemUpOwo+ID4gPiA+ICsJCXNrYiA9
IGJ1aWxkX3NrYihidWYsIHRydWVzaXplKTsKPiA+ID4gPiAgICAJCWlmICh1bmxpa2VseSghc2ti
KSkKPiA+ID4gPiAgICAJCQlyZXR1cm4gTlVMTDsKPiA+ID4gPiAKPiA+ID4gPiArCQlza2JfcmVz
ZXJ2ZShza2IsIHAgLSBidWYpOwo+ID4gPiA+ICAgIAkJc2tiX3B1dChza2IsIGxlbik7Cj4gPiA+
ID4gICAgCQlnb3RvIG9rOwo+ID4gPiA+ICAgIAl9CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

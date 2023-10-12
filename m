Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A38CDB46E
	for <virtualization@archiver.kernel.org>; Thu, 12 Oct 2023 08:29:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C20740230;
	Thu, 12 Oct 2023 08:29:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3C20740230
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UUWL5Z5/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id frBdNqlvAREx; Thu, 12 Oct 2023 08:29:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 610FA40204;
	Thu, 12 Oct 2023 08:29:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 610FA40204
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36F53C0071;
	Thu, 12 Oct 2023 08:29:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE946C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 08:29:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B521E60A5C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 08:29:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B521E60A5C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UUWL5Z5/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mQel6zW46mKf
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 08:29:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A32BD60803
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 08:29:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A32BD60803
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697099388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vw5dAG2qe9sQwutLGPP6CjbFZLPwvDB+sGyUCh+7Sug=;
 b=UUWL5Z5/an52IQigTshB7M9wasx+xmxUVS1+tgX8uRhMfkY78CQIBcbe4syLFnCCUCf5Fo
 B0Egc4mCix6nF4VmyCs0JOHGYlgqpa019eCaPJqe7WyyS0LOEGmP1N8a1Ashc5UFlg/gzo
 3CnG9VRtu2kZZzjvwyc2xsp7cFSUKVI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-WYF_EU-VMX6QLFGHN9AfZw-1; Thu, 12 Oct 2023 04:29:46 -0400
X-MC-Unique: WYF_EU-VMX6QLFGHN9AfZw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2c3c658e60aso6133221fa.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 01:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697099385; x=1697704185;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vw5dAG2qe9sQwutLGPP6CjbFZLPwvDB+sGyUCh+7Sug=;
 b=hDeTsNTm5CQJ/B+A+vb3gY+mr8VIugRXesQu452YTLvUZBbuDEZwolKxAg5qD4lgPx
 9QtA41nZtTQzmHieeGwBzAZ1Cw/p0rIrPoJHXT+vcrBbxSribDuF1IifwQ/uSyugmoWY
 gpEmolwR67SJiRw4bO6VJwQAnPSP+9lUxe/O3lwL16pobyQJcZZtFaiVLe4yR9CNTEoe
 0E8NGN62U58fzVSgwXqM2JZOLaJWeC3zAPrz4rcN5w+f7pbhYQMYxI4jCGcYm46jZg4f
 1SKKGFV4Qja9LS9+n3Is96mbR0ZQXQPC8bM9Fiy9a9f5wEp++SZmVJk/5plEwPIQyuiM
 pjBA==
X-Gm-Message-State: AOJu0Yzz4dlIliVRGF/7RuFnovl1+AY7hb3f7YIsr8tsHQxHjqqZdh3O
 WMjUJL38/CWUMZRK2EeUTTM7kirASNpbq5kuETRbShGPKWy/bmhtbMlONObhE6metgCt4aInVFd
 UQ95LLAUPXWZBYxyAGmLuX4eaj/R4JqU5MX24FcFO2p10MAUUZqTD0yZrJg==
X-Received: by 2002:a19:910d:0:b0:501:ba04:f34b with SMTP id
 t13-20020a19910d000000b00501ba04f34bmr17462332lfd.44.1697099385363; 
 Thu, 12 Oct 2023 01:29:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6L72gGGcnELBjEfUyBf/q77upOFSG7lJho6VTRgFelGqkudpuilTAwrphbOkgaeFS35fuGuA/oKMzZR8x5I0=
X-Received: by 2002:a19:910d:0:b0:501:ba04:f34b with SMTP id
 t13-20020a19910d000000b00501ba04f34bmr17462324lfd.44.1697099385050; Thu, 12
 Oct 2023 01:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
In-Reply-To: <cover.1697093455.git.hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Oct 2023 16:29:33 +0800
Message-ID: <CACGkMEthktJjPdptHo3EDQxjRqdPELOSbMw4k-d0MyYmR4i9KA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] virtio-net: support dynamic coalescing
 moderation
To: Heng Qi <hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Liu, Yujie" <yujie.liu@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
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

T24gVGh1LCBPY3QgMTIsIDIwMjMgYXQgMzo0NOKAr1BNIEhlbmcgUWkgPGhlbmdxaUBsaW51eC5h
bGliYWJhLmNvbT4gd3JvdGU6Cj4KPiBOb3csIHZpcnRpby1uZXQgYWxyZWFkeSBzdXBwb3J0cyBw
ZXItcXVldWUgbW9kZXJhdGlvbiBwYXJhbWV0ZXIKPiBzZXR0aW5nLiBCYXNlZCBvbiB0aGlzLCB3
ZSB1c2UgdGhlIG5ldGRpbSBsaWJyYXJ5IG9mIGxpbnV4IHRvIHN1cHBvcnQKPiBkeW5hbWljIGNv
YWxlc2NpbmcgbW9kZXJhdGlvbiBmb3IgdmlydGlvLW5ldC4KPgo+IER1ZSB0byBoYXJkd2FyZSBz
Y2hlZHVsaW5nIGlzc3Vlcywgd2Ugb25seSB0ZXN0ZWQgcnggZGltLgoKRG8geW91IGhhdmUgUFBT
IG51bWJlcnM/IEFuZCBUWCBudW1iZXJzIGFyZSBhbHNvIGltcG9ydGFudCBhcyB0aGUKdGhyb3Vn
aHB1dCBjb3VsZCBiZSBtaXNsZWFkaW5nIGR1ZSB0byB2YXJpb3VzIHJlYXNvbnMuCgpUaGFua3MK
Cj4KPiBAVGVzdCBlbnYKPiByeHEwIGhhcyBhZmZpbml0eSB0byBjcHUwLgo+Cj4gQFRlc3QgY21k
Cj4gY2xpZW50OiB0YXNrc2V0IC1jIDAgc29ja3BlcmYgdHAgLWkgJHtJUH0gLXQgMzAgLS10Y3Ag
LW0gJHttc2dfc2l6ZX0KPiBzZXJ2ZXI6IHRhc2tzZXQgLWMgMCBzb2NrcGVyZiBzciAtLXRjcAo+
Cj4gQFRlc3QgcmVzCj4gVGhlIHNlY29uZCBjb2x1bW4gaXMgdGhlIHJhdGlvIG9mIHRoZSByZXN1
bHQgcmV0dXJuZWQgYnkgY2xpZW50Cj4gd2hlbiByeCBkaW0gaXMgZW5hYmxlZCB0byB0aGUgcmVz
dWx0IHJldHVybmVkIGJ5IGNsaWVudCB3aGVuCj4gcnggZGltIGlzIGRpc2FibGVkLgo+ICAgICAg
ICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgICAgICAgIHwgbXNn
X3NpemUgfCAgcnhfZGltPW9uIC8gcnhfZGltPW9mZiB8Cj4gICAgICAgICAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAgICAgICAgfCAgIDE0QiAgICB8ICAgICAgICAg
KyAzJSAgICAgICAgICAgIHwKPiAgICAgICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCj4gICAgICAgICB8ICAgMTAwQiAgIHwgICAgICAgICArIDE2JSAgICAgICAgICAg
fAo+ICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgICAg
ICAgIHwgICA1MDBCICAgfCAgICAgICAgICsgMjUlICAgICAgICAgICB8Cj4gICAgICAgICAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAgICAgICAgfCAgIDE0MDBCICB8
ICAgICAgICAgKyAyOCUgICAgICAgICAgIHwKPiAgICAgICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCj4gICAgICAgICB8ICAgMjA0OEIgIHwgICAgICAgICArIDIyJSAg
ICAgICAgICAgfAo+ICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KPiAgICAgICAgIHwgICA0MDk2QiAgfCAgICAgICAgICsgNSUgICAgICAgICAgICB8Cj4gICAg
ICAgICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+Cj4gLS0tCj4gVGhp
cyBwYXRjaCBzZXQgd2FzIHBhcnQgb2YgdGhlIHByZXZpb3VzIG5ldGRpbSBwYXRjaCBzZXRbMV0u
Cj4gWzFdIHdhcyBzcGxpdCBpbnRvIGEgbWVyZ2VkIGJ1Z2ZpeCBzZXRbMl0gYW5kIHRoZSBjdXJy
ZW50IHNldC4KPiBUaGUgcHJldmlvdXMgcmVsZXZhbnQgY29tbWVudGF0b3JzIGhhdmUgYmVlbiBD
Y2VkLgo+Cj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDgxMTA2NTUxMi4y
MjE5MC0xLWhlbmdxaUBsaW51eC5hbGliYWJhLmNvbS8KPiBbMl0gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsL2NvdmVyLjE2OTY3NDU0NTIuZ2l0LmhlbmdxaUBsaW51eC5hbGliYWJhLmNvbS8K
Pgo+IEhlbmcgUWkgKDUpOgo+ICAgdmlydGlvLW5ldDogcmV0dXJucyB3aGV0aGVyIG5hcGkgaXMg
Y29tcGxldGUKPiAgIHZpcnRpby1uZXQ6IHNlcGFyYXRlIHJ4L3R4IGNvYWxlc2NpbmcgbW9kZXJh
dGlvbiBjbWRzCj4gICB2aXJ0aW8tbmV0OiBleHRyYWN0IHZpcnRxdWV1ZSBjb2FsZXNjaWcgY21k
IGZvciByZXVzZQo+ICAgdmlydGlvLW5ldDogc3VwcG9ydCByeCBuZXRkaW0KPiAgIHZpcnRpby1u
ZXQ6IHN1cHBvcnQgdHggbmV0ZGltCj4KPiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMzk0
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMzIyIGluc2VydGlvbnMoKyksIDcyIGRlbGV0aW9ucygtKQo+Cj4gLS0KPiAyLjE5LjEuNi5n
YjQ4NTcxMGIKPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

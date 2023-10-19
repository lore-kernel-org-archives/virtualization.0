Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D698BCDB465
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 06:10:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 48CB64248B;
	Thu, 19 Oct 2023 06:10:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 48CB64248B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ccwRWMPl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ArQjvk03sMEv; Thu, 19 Oct 2023 06:10:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 53D7A42481;
	Thu, 19 Oct 2023 06:10:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 53D7A42481
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21279C0071;
	Thu, 19 Oct 2023 06:10:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B47FCC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:10:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7AC124248B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:10:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7AC124248B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QzO1HO9hZVUS
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:10:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 473BF42481
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:10:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 473BF42481
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697695836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+UhCiLXC3GKhC7LBn7PFGeNEM6rzFh/63mwCf1MnfRg=;
 b=ccwRWMPl9l/tbGNxjKa2dp4tpZ3Pd118DR/29VYnMCTP131bG5sf3/kF9ZQSR6/UNXYKVW
 ftbY60YEMCVELaRbveGghsVl+l5uOPfNgRIYO/LfjrrHp+rEmexpXbs0waJYzwMEpORDyB
 15HPubN0RvSSyG4L/AbVlbCqmqF6p2g=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-PTI4DMJrPLWRzAEQIDJXTw-1; Thu, 19 Oct 2023 02:10:34 -0400
X-MC-Unique: PTI4DMJrPLWRzAEQIDJXTw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5079a3362afso6081940e87.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 23:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697695833; x=1698300633;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+UhCiLXC3GKhC7LBn7PFGeNEM6rzFh/63mwCf1MnfRg=;
 b=D9iCgnuTyUwR1a2sSCBdJpOIMBoSMCrsOzzKR6eFfYxDM9hvzxxyB/2/pORktjHg5Y
 jNcRmO+edkfxjz+CUNYbxDPHtrrYuj9GViQ2YheXJHepCOeKAL9sTy2e6FxP/fOoxuK4
 7xLDo5nhS+nZn0+C+K3HsP6/uCQ+pqdO1zQCr8tbmvquC3y33QCqWTTgkynXIprHgIO0
 rwlBW45kojs17m4v7+3tPzZQMow6HoQ6+ZWtUefQfOncgs+0CPY4cuoKDBGa2fpONknV
 osqb24YXwq5YDU+sN3wCppWVE4nFFV70bXpFhOeFokSCOUQzgUxXxD+109O+kPYTahIk
 5+kg==
X-Gm-Message-State: AOJu0YwyGPgGgNT1IpHQ38TrxJkbBXm8uDN9fY7nNIgOohHFhyu5VvJH
 BsNxwrFRq9Tze8RdAjCbiS6T7Uzr2xLQmaqvss25m2Km72k2U6IJbq6Ln+gLvdd/jN4JJpS29OR
 /4Hm3mr2nTFtpRExDzA+6wksS+CBChLNr2Km7Ti03jCuD9lVHuF/QZ7O2eQ==
X-Received: by 2002:a05:6512:15a2:b0:507:ce49:81bd with SMTP id
 bp34-20020a05651215a200b00507ce4981bdmr896114lfb.61.1697695832954; 
 Wed, 18 Oct 2023 23:10:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8sj9k9xpWrn8oW1b/1IrnZYzb/HZkAuesmJBQStjDAxGGfZvTonP0LgNbiePQysfQCChTXRtGf1G0Iwe7dDw=
X-Received: by 2002:a05:6512:15a2:b0:507:ce49:81bd with SMTP id
 bp34-20020a05651215a200b00507ce4981bdmr896094lfb.61.1697695832620; Wed, 18
 Oct 2023 23:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 19 Oct 2023 14:10:21 +0800
Message-ID: <CACGkMEtR_OKWQC03HY-pnBGXsMqnD92uS3qHC+DwZy38tDKnwg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 03/19] virtio_net: independent directory
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

T24gTW9uLCBPY3QgMTYsIDIwMjMgYXQgODowMeKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gQ3JlYXRlIGEgc2VwYXJhdGUgZGlyZWN0b3J5IGZv
ciB2aXJ0aW8tbmV0LiBBRl9YRFAgc3VwcG9ydCB3aWxsIGJlIGFkZGVkCj4gbGF0ZXIsIHRoZW4g
YSBzZXBhcmF0ZSB4c2suYyBmaWxlIHdpbGwgYmUgYWRkZWQsIHNvIHdlIHNob3VsZCBjcmVhdGUg
YQo+IGRpcmVjdG9yeSBmb3IgdmlydGlvLW5ldC4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1
byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKPiAtLS0KPiAgTUFJTlRBSU5FUlMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstCj4gIGRyaXZlcnMvbmV0L0tjb25maWcgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgOCArLS0tLS0tLQo+ICBkcml2ZXJzL25ldC9NYWtlZmls
ZSAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0KPiAgZHJpdmVycy9uZXQvdmlydGlvL0tj
b25maWcgICAgICAgICAgICAgICAgICB8IDEzICsrKysrKysrKysrKysKPiAgZHJpdmVycy9uZXQv
dmlydGlvL01ha2VmaWxlICAgICAgICAgICAgICAgICB8ICA4ICsrKysrKysrCj4gIGRyaXZlcnMv
bmV0L3t2aXJ0aW9fbmV0LmMgPT4gdmlydGlvL21haW4uY30gfCAgMAo+ICA2IGZpbGVzIGNoYW5n
ZWQsIDI0IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL25ldC92aXJ0aW8vS2NvbmZpZwo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9uZXQvdmlydGlvL01ha2VmaWxlCj4gIHJlbmFtZSBkcml2ZXJzL25ldC97dmlydGlvX25ldC5j
ID0+IHZpcnRpby9tYWluLmN9ICgxMDAlKQo+Cj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIv
TUFJTlRBSU5FUlMKPiBpbmRleCA5YzE4NmMyMTRjNTQuLmU0ZmJjYmMxMDBlMyAxMDA2NDQKPiAt
LS0gYS9NQUlOVEFJTkVSUwo+ICsrKyBiL01BSU5UQUlORVJTCj4gQEAgLTIyNzY4LDcgKzIyNzY4
LDcgQEAgRjogICAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdmlydGlvLwo+
ICBGOiAgICAgRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL3ZpcnRpby8KPiAgRjogICAgIGRyaXZl
cnMvYmxvY2svdmlydGlvX2Jsay5jCj4gIEY6ICAgICBkcml2ZXJzL2NyeXB0by92aXJ0aW8vCj4g
LUY6ICAgICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArRjogICAgIGRyaXZlcnMvbmV0L3Zp
cnRpby8KPiAgRjogICAgIGRyaXZlcnMvdmRwYS8KPiAgRjogICAgIGRyaXZlcnMvdmlydGlvLwo+
ICBGOiAgICAgaW5jbHVkZS9saW51eC92ZHBhLmgKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
S2NvbmZpZyBiL2RyaXZlcnMvbmV0L0tjb25maWcKPiBpbmRleCA0NGVlYjVkNjFiYTkuLjU0ZWU2
ZmE0ZjRhNiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC9LY29uZmlnCj4gKysrIGIvZHJpdmVy
cy9uZXQvS2NvbmZpZwo+IEBAIC00MzAsMTMgKzQzMCw3IEBAIGNvbmZpZyBWRVRICj4gICAgICAg
ICAgIFdoZW4gb25lIGVuZCByZWNlaXZlcyB0aGUgcGFja2V0IGl0IGFwcGVhcnMgb24gaXRzIHBh
aXIgYW5kIHZpY2UKPiAgICAgICAgICAgdmVyc2EuCj4KPiAtY29uZmlnIFZJUlRJT19ORVQKPiAt
ICAgICAgIHRyaXN0YXRlICJWaXJ0aW8gbmV0d29yayBkcml2ZXIiCj4gLSAgICAgICBkZXBlbmRz
IG9uIFZJUlRJTwo+IC0gICAgICAgc2VsZWN0IE5FVF9GQUlMT1ZFUgo+IC0gICAgICAgaGVscAo+
IC0gICAgICAgICBUaGlzIGlzIHRoZSB2aXJ0dWFsIG5ldHdvcmsgZHJpdmVyIGZvciB2aXJ0aW8u
ICBJdCBjYW4gYmUgdXNlZCB3aXRoCj4gLSAgICAgICAgIFFFTVUgYmFzZWQgVk1NcyAobGlrZSBL
Vk0gb3IgWGVuKS4gIFNheSBZIG9yIE0uCj4gK3NvdXJjZSAiZHJpdmVycy9uZXQvdmlydGlvL0tj
b25maWciCj4KPiAgY29uZmlnIE5MTU9OCj4gICAgICAgICB0cmlzdGF0ZSAiVmlydHVhbCBuZXRs
aW5rIG1vbml0b3JpbmcgZGV2aWNlIgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9NYWtlZmls
ZSBiL2RyaXZlcnMvbmV0L01ha2VmaWxlCj4gaW5kZXggZTI2Zjk4Zjg5N2M1Li40NzUzN2RkMGYx
MjAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvTWFrZWZpbGUKPiArKysgYi9kcml2ZXJzL25l
dC9NYWtlZmlsZQo+IEBAIC0zMSw3ICszMSw3IEBAIG9iai0kKENPTkZJR19ORVRfVEVBTSkgKz0g
dGVhbS8KPiAgb2JqLSQoQ09ORklHX1RVTikgKz0gdHVuLm8KPiAgb2JqLSQoQ09ORklHX1RBUCkg
Kz0gdGFwLm8KPiAgb2JqLSQoQ09ORklHX1ZFVEgpICs9IHZldGgubwo+IC1vYmotJChDT05GSUdf
VklSVElPX05FVCkgKz0gdmlydGlvX25ldC5vCj4gK29iai0kKENPTkZJR19WSVJUSU9fTkVUKSAr
PSB2aXJ0aW8vCj4gIG9iai0kKENPTkZJR19WWExBTikgKz0gdnhsYW4vCj4gIG9iai0kKENPTkZJ
R19HRU5FVkUpICs9IGdlbmV2ZS5vCj4gIG9iai0kKENPTkZJR19CQVJFVURQKSArPSBiYXJldWRw
Lm8KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvL0tjb25maWcgYi9kcml2ZXJzL25l
dC92aXJ0aW8vS2NvbmZpZwo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAwMDAw
MDAwLi5kOGNjYjNhYzQ5ZGYKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIvZHJpdmVycy9uZXQvdmly
dGlvL0tjb25maWcKPiBAQCAtMCwwICsxLDEzIEBACj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjAtb25seQo+ICsjCj4gKyMgdmlydGlvLW5ldCBkZXZpY2UgY29uZmlndXJhdGlv
bgo+ICsjCj4gK2NvbmZpZyBWSVJUSU9fTkVUCj4gKyAgICAgICB0cmlzdGF0ZSAiVmlydGlvIG5l
dHdvcmsgZHJpdmVyIgo+ICsgICAgICAgZGVwZW5kcyBvbiBWSVJUSU8KPiArICAgICAgIHNlbGVj
dCBORVRfRkFJTE9WRVIKPiArICAgICAgIGhlbHAKPiArICAgICAgICAgVGhpcyBpcyB0aGUgdmly
dHVhbCBuZXR3b3JrIGRyaXZlciBmb3IgdmlydGlvLiAgSXQgY2FuIGJlIHVzZWQgd2l0aAo+ICsg
ICAgICAgICBRRU1VIGJhc2VkIFZNTXMgKGxpa2UgS1ZNIG9yIFhlbikuCj4gKwo+ICsgICAgICAg
ICBTYXkgWSBvciBNLgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW8vTWFrZWZpbGUg
Yi9kcml2ZXJzL25ldC92aXJ0aW8vTWFrZWZpbGUKPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+IGlu
ZGV4IDAwMDAwMDAwMDAwMC4uMTVlZDdjOTdmZDRmCj4gLS0tIC9kZXYvbnVsbAo+ICsrKyBiL2Ry
aXZlcnMvbmV0L3ZpcnRpby9NYWtlZmlsZQo+IEBAIC0wLDAgKzEsOCBAQAo+ICsjIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wCj4gKyMKPiArIyBNYWtlZmlsZSBmb3IgdGhlIHZpcnRp
byBuZXR3b3JrIGRldmljZSBkcml2ZXJzLgo+ICsjCj4gKwo+ICtvYmotJChDT05GSUdfVklSVElP
X05FVCkgKz0gdmlydGlvX25ldC5vCj4gKwo+ICt2aXJ0aW9fbmV0LXkgOj0gbWFpbi5vCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpby9t
YWluLmMKPiBzaW1pbGFyaXR5IGluZGV4IDEwMCUKPiByZW5hbWUgZnJvbSBkcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMKPiByZW5hbWUgdG8gZHJpdmVycy9uZXQvdmlydGlvL21haW4uYwo+IC0tCj4g
Mi4zMi4wLjMuZzAxMTk1Y2Y5Zgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

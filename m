Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA7FC678D5
	for <virtualization@archiver.kernel.org>; Tue,  7 Mar 2023 08:34:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4DD38404DF;
	Tue,  7 Mar 2023 08:34:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4DD38404DF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=frcKSEHV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g4zwIPO6gwyK; Tue,  7 Mar 2023 08:34:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AF9274010F;
	Tue,  7 Mar 2023 08:34:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AF9274010F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87E39C0035;
	Tue,  7 Mar 2023 08:34:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A97AC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 08:34:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E88C6408E3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 08:34:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E88C6408E3
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=frcKSEHV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GXKdv8IBeK1X
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 08:34:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C34A0408E0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C34A0408E0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 08:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678178080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1LmY2wPnO87rx3RbzrpQdOXyZOLLC9c+tSZr18MF9Js=;
 b=frcKSEHVPpsiZlVkrIHwRAHjt2tNbGNHJ9/ITImVO0pIXyEUBk4m0WenxUOxkCttjZJ3F5
 fN9nzq3k8e0kKL1ihjTpRnnJrq06cg5Fld5gmy/ni2rB6oThfdpE00d417fjn0sfEVl75h
 3V/x45I+d6ck04UuW+Yq2cttMhUqwws=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-_dHzgqPpPeOAxqxcrNPwlg-1; Tue, 07 Mar 2023 03:34:37 -0500
X-MC-Unique: _dHzgqPpPeOAxqxcrNPwlg-1
Received: by mail-oo1-f71.google.com with SMTP id
 l6-20020a4ad9c6000000b005254392994fso3731499oou.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Mar 2023 00:34:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678178077;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1LmY2wPnO87rx3RbzrpQdOXyZOLLC9c+tSZr18MF9Js=;
 b=hkqtBbKX9oHLyMLW+2DK7Lnm/w2SrK+6Yes876mO0SfXBV4SMWz7mdC6nfUr1H0QYl
 BhMUjDS/uYCAuE5rBNx8TBhJvNpnl4jRUOadk0+4bb0EcKxjd69ND+tMN6wxefpLAyjo
 PATUMgscbCp+DPA2AtAXYbMo97EpHRSgAPMMuvOBZ9+2d6a+gP/NFr1IY6HZhoKTU5Q3
 TeTmlQVy+B3Zfm6U2rxWweD4fiUpHojtcSsu0df/Gcf25h2VAgNXnfZHmOSPodibWCWC
 NeApGH45ttFIXSxg4d+PskWiIVIHBTJbXjOZ98uH2XCOfW6NC0js1Km+juaRJKRmbyia
 2YyQ==
X-Gm-Message-State: AO0yUKV6mTz7t8U3/GZctzmtN/zQGO6vRmfbH2wqS5pIRxs6MANW+ENT
 emJXxRjl9zC9Tj8SG8zbpmmml3WcT74RxstIPHTyP8yu+xc7wNRhToOrVqOOkmd6JWE/xbnTu9G
 OW8xAltg0e3k0WxVhlNwhNWmUMQRKj/velZo5vnuO+9WD9K4BxfCowm337g==
X-Received: by 2002:a54:4612:0:b0:383:fad3:d19 with SMTP id
 p18-20020a544612000000b00383fad30d19mr4407526oip.9.1678178076745; 
 Tue, 07 Mar 2023 00:34:36 -0800 (PST)
X-Google-Smtp-Source: AK7set9mdrdqs3J1EBK7p75F53bJ40P5FZgubP3hrPid3SD0+q5ZXZPN0rFwSbcEIpltgRrHZixRWmlvTVaOJBCBxV4=
X-Received: by 2002:a54:4612:0:b0:383:fad3:d19 with SMTP id
 p18-20020a544612000000b00383fad30d19mr4407515oip.9.1678178076533; Tue, 07 Mar
 2023 00:34:36 -0800 (PST)
MIME-Version: 1.0
References: <20230306041535.73319-1-xuanzhuo@linux.alibaba.com>
 <20230306041535.73319-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230306041535.73319-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 7 Mar 2023 16:34:25 +0800
Message-ID: <CACGkMEsyDvtTnUAUsv4Mg9sNnjthUuPaHsXbSs0vxGuQTAJPrQ@mail.gmail.com>
Subject: Re: [PATCH net 1/2] virtio_net: separate the logic of checking
 whether sq is full
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

T24gTW9uLCBNYXIgNiwgMjAyMyBhdCAxMjoxNeKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gU2VwYXJhdGUgdGhlIGxvZ2ljIG9mIGNoZWNraW5n
IHdoZXRoZXIgc3EgaXMgZnVsbC4gVGhlIHN1YnNlcXVlbnQgcGF0Y2gKPiB3aWxsIHJldXNlIHRo
aXMgZnVuYy4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxp
YmFiYS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDU5ICsrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDM1IGlu
c2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IGluZGV4IGZiNWU2OGVk
M2VjMi4uNzc3ZGUwZWMwYjFiIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
Ywo+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IEBAIC0xNzUwLDYgKzE3NTAsNDAg
QEAgc3RhdGljIHZvaWQgZnJlZV9vbGRfeG1pdF9za2JzKHN0cnVjdCBzZW5kX3F1ZXVlICpzcSwg
Ym9vbCBpbl9uYXBpKQo+ICAgICAgICAgdTY0X3N0YXRzX3VwZGF0ZV9lbmQoJnNxLT5zdGF0cy5z
eW5jcCk7Cj4gIH0KPgo+ICtzdGF0aWMgdm9pZCBjaGVja19zcV9mdWxsKHN0cnVjdCB2aXJ0bmV0
X2luZm8gKnZpLCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IHNlbmRfcXVldWUgKnNxKQo+ICt7CgpOaXQ6IHdlIG5lZWQgYSBiZXR0ZXIg
bmFtZSwgaXQncyBub3Qgb25seSB0aGUgY2hlY2sgYnV0IGFsc28gY2FuIGRpc2FibGUgVFguCgpU
aGFua3MKCj4gKyAgICAgICBib29sIHVzZV9uYXBpID0gc3EtPm5hcGkud2VpZ2h0Owo+ICsgICAg
ICAgaW50IHFudW07Cj4gKwo+ICsgICAgICAgcW51bSA9IHNxIC0gdmktPnNxOwo+ICsKPiArICAg
ICAgIC8qIElmIHJ1bm5pbmcgb3V0IG9mIHNwYWNlLCBzdG9wIHF1ZXVlIHRvIGF2b2lkIGdldHRp
bmcgcGFja2V0cyB0aGF0IHdlCj4gKyAgICAgICAgKiBhcmUgdGhlbiB1bmFibGUgdG8gdHJhbnNt
aXQuCj4gKyAgICAgICAgKiBBbiBhbHRlcm5hdGl2ZSB3b3VsZCBiZSB0byBmb3JjZSBxdWV1aW5n
IGxheWVyIHRvIHJlcXVldWUgdGhlIHNrYiBieQo+ICsgICAgICAgICogcmV0dXJuaW5nIE5FVERF
Vl9UWF9CVVNZLiBIb3dldmVyLCBORVRERVZfVFhfQlVTWSBzaG91bGQgbm90IGJlCj4gKyAgICAg
ICAgKiByZXR1cm5lZCBpbiBhIG5vcm1hbCBwYXRoIG9mIG9wZXJhdGlvbjogaXQgbWVhbnMgdGhh
dCBkcml2ZXIgaXMgbm90Cj4gKyAgICAgICAgKiBtYWludGFpbmluZyB0aGUgVFggcXVldWUgc3Rv
cC9zdGFydCBzdGF0ZSBwcm9wZXJseSwgYW5kIGNhdXNlcwo+ICsgICAgICAgICogdGhlIHN0YWNr
IHRvIGRvIGEgbm9uLXRyaXZpYWwgYW1vdW50IG9mIHVzZWxlc3Mgd29yay4KPiArICAgICAgICAq
IFNpbmNlIG1vc3QgcGFja2V0cyBvbmx5IHRha2UgMSBvciAyIHJpbmcgc2xvdHMsIHN0b3BwaW5n
IHRoZSBxdWV1ZQo+ICsgICAgICAgICogZWFybHkgbWVhbnMgMTYgc2xvdHMgYXJlIHR5cGljYWxs
eSB3YXN0ZWQuCj4gKyAgICAgICAgKi8KPiArICAgICAgIGlmIChzcS0+dnEtPm51bV9mcmVlIDwg
MitNQVhfU0tCX0ZSQUdTKSB7Cj4gKyAgICAgICAgICAgICAgIG5ldGlmX3N0b3Bfc3VicXVldWUo
ZGV2LCBxbnVtKTsKPiArICAgICAgICAgICAgICAgaWYgKHVzZV9uYXBpKSB7Cj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KCF2aXJ0cXVldWVfZW5hYmxlX2NiX2RlbGF5ZWQo
c3EtPnZxKSkpCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2aXJ0cXVldWVfbmFw
aV9zY2hlZHVsZSgmc3EtPm5hcGksIHNxLT52cSk7Cj4gKyAgICAgICAgICAgICAgIH0gZWxzZSBp
ZiAodW5saWtlbHkoIXZpcnRxdWV1ZV9lbmFibGVfY2JfZGVsYXllZChzcS0+dnEpKSkgewo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIC8qIE1vcmUganVzdCBnb3QgdXNlZCwgZnJlZSB0aGVtIHRo
ZW4gcmVjaGVjay4gKi8KPiArICAgICAgICAgICAgICAgICAgICAgICBmcmVlX29sZF94bWl0X3Nr
YnMoc3EsIGZhbHNlKTsKPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoc3EtPnZxLT5udW1f
ZnJlZSA+PSAyK01BWF9TS0JfRlJBR1MpIHsKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIG5ldGlmX3N0YXJ0X3N1YnF1ZXVlKGRldiwgcW51bSk7Cj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB2aXJ0cXVldWVfZGlzYWJsZV9jYihzcS0+dnEpOwo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIH0KPiArICAgICAgICAgICAgICAgfQo+ICsgICAgICAgfQo+ICt9Cj4gKwo+
ICBzdGF0aWMgYm9vbCBpc194ZHBfcmF3X2J1ZmZlcl9xdWV1ZShzdHJ1Y3QgdmlydG5ldF9pbmZv
ICp2aSwgaW50IHEpCj4gIHsKPiAgICAgICAgIGlmIChxIDwgKHZpLT5jdXJyX3F1ZXVlX3BhaXJz
IC0gdmktPnhkcF9xdWV1ZV9wYWlycykpCj4gQEAgLTE5ODksMzAgKzIwMjMsNyBAQCBzdGF0aWMg
bmV0ZGV2X3R4X3Qgc3RhcnRfeG1pdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2Rl
dmljZSAqZGV2KQo+ICAgICAgICAgICAgICAgICBuZl9yZXNldF9jdChza2IpOwo+ICAgICAgICAg
fQo+Cj4gLSAgICAgICAvKiBJZiBydW5uaW5nIG91dCBvZiBzcGFjZSwgc3RvcCBxdWV1ZSB0byBh
dm9pZCBnZXR0aW5nIHBhY2tldHMgdGhhdCB3ZQo+IC0gICAgICAgICogYXJlIHRoZW4gdW5hYmxl
IHRvIHRyYW5zbWl0Lgo+IC0gICAgICAgICogQW4gYWx0ZXJuYXRpdmUgd291bGQgYmUgdG8gZm9y
Y2UgcXVldWluZyBsYXllciB0byByZXF1ZXVlIHRoZSBza2IgYnkKPiAtICAgICAgICAqIHJldHVy
bmluZyBORVRERVZfVFhfQlVTWS4gSG93ZXZlciwgTkVUREVWX1RYX0JVU1kgc2hvdWxkIG5vdCBi
ZQo+IC0gICAgICAgICogcmV0dXJuZWQgaW4gYSBub3JtYWwgcGF0aCBvZiBvcGVyYXRpb246IGl0
IG1lYW5zIHRoYXQgZHJpdmVyIGlzIG5vdAo+IC0gICAgICAgICogbWFpbnRhaW5pbmcgdGhlIFRY
IHF1ZXVlIHN0b3Avc3RhcnQgc3RhdGUgcHJvcGVybHksIGFuZCBjYXVzZXMKPiAtICAgICAgICAq
IHRoZSBzdGFjayB0byBkbyBhIG5vbi10cml2aWFsIGFtb3VudCBvZiB1c2VsZXNzIHdvcmsuCj4g
LSAgICAgICAgKiBTaW5jZSBtb3N0IHBhY2tldHMgb25seSB0YWtlIDEgb3IgMiByaW5nIHNsb3Rz
LCBzdG9wcGluZyB0aGUgcXVldWUKPiAtICAgICAgICAqIGVhcmx5IG1lYW5zIDE2IHNsb3RzIGFy
ZSB0eXBpY2FsbHkgd2FzdGVkLgo+IC0gICAgICAgICovCj4gLSAgICAgICBpZiAoc3EtPnZxLT5u
dW1fZnJlZSA8IDIrTUFYX1NLQl9GUkFHUykgewo+IC0gICAgICAgICAgICAgICBuZXRpZl9zdG9w
X3N1YnF1ZXVlKGRldiwgcW51bSk7Cj4gLSAgICAgICAgICAgICAgIGlmICh1c2VfbmFwaSkgewo+
IC0gICAgICAgICAgICAgICAgICAgICAgIGlmICh1bmxpa2VseSghdmlydHF1ZXVlX2VuYWJsZV9j
Yl9kZWxheWVkKHNxLT52cSkpKQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmly
dHF1ZXVlX25hcGlfc2NoZWR1bGUoJnNxLT5uYXBpLCBzcS0+dnEpOwo+IC0gICAgICAgICAgICAg
ICB9IGVsc2UgaWYgKHVubGlrZWx5KCF2aXJ0cXVldWVfZW5hYmxlX2NiX2RlbGF5ZWQoc3EtPnZx
KSkpIHsKPiAtICAgICAgICAgICAgICAgICAgICAgICAvKiBNb3JlIGp1c3QgZ290IHVzZWQsIGZy
ZWUgdGhlbSB0aGVuIHJlY2hlY2suICovCj4gLSAgICAgICAgICAgICAgICAgICAgICAgZnJlZV9v
bGRfeG1pdF9za2JzKHNxLCBmYWxzZSk7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgaWYgKHNx
LT52cS0+bnVtX2ZyZWUgPj0gMitNQVhfU0tCX0ZSQUdTKSB7Cj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBuZXRpZl9zdGFydF9zdWJxdWV1ZShkZXYsIHFudW0pOwo+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdmlydHF1ZXVlX2Rpc2FibGVfY2Ioc3EtPnZxKTsKPiAt
ICAgICAgICAgICAgICAgICAgICAgICB9Cj4gLSAgICAgICAgICAgICAgIH0KPiAtICAgICAgIH0K
PiArICAgICAgIGNoZWNrX3NxX2Z1bGwodmksIGRldiwgc3EpOwo+Cj4gICAgICAgICBpZiAoa2lj
ayB8fCBuZXRpZl94bWl0X3N0b3BwZWQodHhxKSkgewo+ICAgICAgICAgICAgICAgICBpZiAodmly
dHF1ZXVlX2tpY2tfcHJlcGFyZShzcS0+dnEpICYmIHZpcnRxdWV1ZV9ub3RpZnkoc3EtPnZxKSkg
ewo+IC0tCj4gMi4zMi4wLjMuZzAxMTk1Y2Y5Zgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

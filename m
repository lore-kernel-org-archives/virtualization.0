Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B634CE95A8E
	for <virtualization@archiver.kernel.org>; Sun,  8 Oct 2023 19:07:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4848960FDE;
	Sun,  8 Oct 2023 19:07:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4848960FDE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jucHODzj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F5KrrY3jGkG8; Sun,  8 Oct 2023 19:07:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3D25060BD5;
	Sun,  8 Oct 2023 19:07:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D25060BD5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8685C0071;
	Sun,  8 Oct 2023 19:07:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 397CEC0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 19:07:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 07C0260EE2
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 19:07:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 07C0260EE2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aNy5BBjRPYV4
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 19:07:45 +0000 (UTC)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D97A760BD5
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 19:07:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D97A760BD5
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-7b0a16f0338so1542428241.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 08 Oct 2023 12:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696792063; x=1697396863;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tUIUiIpPTlwOBRO7US0BTmiwF5PXFfWcZRBZPb+tCDY=;
 b=jucHODzju00ECAaLPGS+J4ee3rh/jtZ8IJwVIKwnO4bsxqt/tDObrwtHtG5ahDGaYg
 qSyP8j+yvloTF7m19YhJCPnRQNJf6SCRQ7l/RB6YNEh4+edYFWLvf24bEMlvQPEppGj+
 ZnuP3OCCyfTNEQq3CSFE9fyru/QRAz7c+9chgj9PomqTEYpGt/oTpwMYXIXeyhxnAbBl
 e8X4ex+QJ9DaMWtqOwFMqIbbblGTMBW+cNxa6bsEeNMcz9+lMuB0R/MmLJDH1bmRgW3N
 zNjMnua4naP1pl6aTM1RPi3SWy/nPLbZS0I74C4lYcDHI8vhp3SVLIpzjCDfc+HrKLAF
 mmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696792063; x=1697396863;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tUIUiIpPTlwOBRO7US0BTmiwF5PXFfWcZRBZPb+tCDY=;
 b=bSBxmTIcOHz9vRQNj09MovpJc/DvvHioZFjB8I1yLQcVBVEX0iS8Dh76CR3jatX+Eg
 OvOKiK8EfeAoYYKIPgHfpoCjYv5r+76LMHLnACL5pjy3eZrFyEvWcKn5e8Y5YBUkiH/o
 42Df4BgX2hJKO30mvIAhZXwEmXizM8WU33TK9sjvLepbNJp+yZ88yWqS9TUHTq43X3tz
 i9+G622O5M/cICLqHnp/RfLMNIMjkzR1StYxvm7JQoOQDgDYw6E0Y5MyxitVnpPkSoEV
 9qy6pCeJpQd0hLs5qjPHYfnoBFefNMHSLgsr9WiIfztgHh/YSLMWQJ21hT9np5h3Nm4g
 V0kQ==
X-Gm-Message-State: AOJu0YxPNzGv7i73SZlKIcm858JJerp4shsfchT6+loP8cb+qtRMOY/i
 hbfzW+qUKFlB11lf05l8/3u6Cg03KKV1/9+mesI=
X-Google-Smtp-Source: AGHT+IFyg6cgU92JMHIokRkaJhJ1e8P2rsbmzc2Pl3JccuZl4PPZUIzePqmqzU+Vbf5KveqqFMmHtwZMF46wJiX+l34=
X-Received: by 2002:a67:e40d:0:b0:452:8953:729e with SMTP id
 d13-20020a67e40d000000b004528953729emr13189757vsf.13.1696792063644; Sun, 08
 Oct 2023 12:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-6-akihiko.odaki@daynix.com>
In-Reply-To: <20231008052101.144422-6-akihiko.odaki@daynix.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sun, 8 Oct 2023 21:07:06 +0200
Message-ID: <CAF=yD-LdwcXKK66s5gvJNOH8qCWRt3SvEL-GkkVif=kkOaYGhg@mail.gmail.com>
Subject: Re: [RFC PATCH 5/7] tun: Introduce virtio-net hashing feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: songliubraving@fb.com, gustavoars@kernel.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, decui@microsoft.com, ast@kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, yhs@fb.com,
 pabeni@redhat.com, pablo@netfilter.org, elver@google.com, kpsingh@kernel.org,
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

T24gU3VuLCBPY3QgOCwgMjAyMyBhdCA3OjIy4oCvQU0gQWtpaGlrbyBPZGFraSA8YWtpaGlrby5v
ZGFraUBkYXluaXguY29tPiB3cm90ZToKPgo+IHZpcnRpby1uZXQgaGF2ZSB0d28gdXNhZ2Ugb2Yg
aGFzaGVzOiBvbmUgaXMgUlNTIGFuZCBhbm90aGVyIGlzIGhhc2gKPiByZXBvcnRpbmcuIENvbnZl
bnRpb25hbGx5IHRoZSBoYXNoIGNhbGN1bGF0aW9uIHdhcyBkb25lIGJ5IHRoZSBWTU0uCj4gSG93
ZXZlciwgY29tcHV0aW5nIHRoZSBoYXNoIGFmdGVyIHRoZSBxdWV1ZSB3YXMgY2hvc2VuIGRlZmVh
dHMgdGhlCj4gcHVycG9zZSBvZiBSU1MuCj4KPiBBbm90aGVyIGFwcHJvYWNoIGlzIHRvIHVzZSBl
QlBGIHN0ZWVyaW5nIHByb2dyYW0uIFRoaXMgYXBwcm9hY2ggaGFzCj4gYW5vdGhlciBkb3duc2lk
ZTogaXQgY2Fubm90IHJlcG9ydCB0aGUgY2FsY3VsYXRlZCBoYXNoIGR1ZSB0byB0aGUKPiByZXN0
cmljdGl2ZSBuYXR1cmUgb2YgZUJQRi4KPgo+IEludHJvZHVjZSB0aGUgY29kZSB0byBjb21wdXRl
IGhhc2hlcyB0byB0aGUga2VybmVsIGluIG9yZGVyIHRvIG92ZXJjb21lCj4gdGhzZSBjaGFsbGVu
Z2VzLiBBbiBhbHRlcm5hdGl2ZSBzb2x1dGlvbiBpcyB0byBleHRlbmQgdGhlIGVCUEYgc3RlZXJp
bmcKPiBwcm9ncmFtIHNvIHRoYXQgaXQgd2lsbCBiZSBhYmxlIHRvIHJlcG9ydCB0byB0aGUgdXNl
cnNwYWNlLCBidXQgaXQgbWFrZXMKPiBsaXR0bGUgc2Vuc2UgdG8gYWxsb3cgdG8gaW1wbGVtZW50
IGRpZmZlcmVudCBoYXNoaW5nIGFsZ29yaXRobXMgd2l0aAo+IGVCUEYgc2luY2UgdGhlIGhhc2gg
dmFsdWUgcmVwb3J0ZWQgYnkgdmlydGlvLW5ldCBpcyBzdHJpY3RseSBkZWZpbmVkIGJ5Cj4gdGhl
IHNwZWNpZmljYXRpb24uCj4KPiBUaGUgaGFzaCB2YWx1ZSBhbHJlYWR5IHN0b3JlZCBpbiBza19i
dWZmIGlzIG5vdCB1c2VkIGFuZCBjb21wdXRlZAo+IGluZGVwZW5kZW50bHkgc2luY2UgaXQgbWF5
IGhhdmUgYmVlbiBjb21wdXRlZCBpbiBhIHdheSBub3QgY29uZm9ybWFudAo+IHdpdGggdGhlIHNw
ZWNpZmljYXRpb24uCj4KPiBTaWduZWQtb2ZmLWJ5OiBBa2loaWtvIE9kYWtpIDxha2loaWtvLm9k
YWtpQGRheW5peC5jb20+Cj4gLS0tCgo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHR1bl92bmV0X2hh
c2hfY2FwIHR1bl92bmV0X2hhc2hfY2FwID0gewo+ICsgICAgICAgLm1heF9pbmRpcmVjdGlvbl90
YWJsZV9sZW5ndGggPQo+ICsgICAgICAgICAgICAgICBUVU5fVk5FVF9IQVNIX01BWF9JTkRJUkVD
VElPTl9UQUJMRV9MRU5HVEgsCj4gKwo+ICsgICAgICAgLnR5cGVzID0gVklSVElPX05FVF9TVVBQ
T1JURURfSEFTSF9UWVBFUwo+ICt9OwoKTm8gbmVlZCB0byBoYXZlIGV4cGxpY2l0IGNhcGFiaWxp
dGllcyBleGNoYW5nZSBsaWtlIHRoaXM/IFR1biBlaXRoZXIKc3VwcG9ydHMgYWxsIG9yIG5vbmUu
Cgo+ICAgICAgICAgY2FzZSBUVU5TRVRTVEVFUklOR0VCUEY6Cj4gLSAgICAgICAgICAgICAgIHJl
dCA9IHR1bl9zZXRfZWJwZih0dW4sICZ0dW4tPnN0ZWVyaW5nX3Byb2csIGFyZ3ApOwo+ICsgICAg
ICAgICAgICAgICBicGZfcmV0ID0gdHVuX3NldF9lYnBmKHR1biwgJnR1bi0+c3RlZXJpbmdfcHJv
ZywgYXJncCk7Cj4gKyAgICAgICAgICAgICAgIGlmIChJU19FUlIoYnBmX3JldCkpCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgcmV0ID0gUFRSX0VSUihicGZfcmV0KTsKPiArICAgICAgICAgICAg
ICAgZWxzZSBpZiAoYnBmX3JldCkKPiArICAgICAgICAgICAgICAgICAgICAgICB0dW4tPnZuZXRf
aGFzaC5mbGFncyAmPSB+VFVOX1ZORVRfSEFTSF9SU1M7CgpEb24ndCBtYWtlIG9uZSBmZWF0dXJl
IGRpc2FibGUgYW5vdGhlci4KClRVTlNFVFNURUVSSU5HRUJQRiBhbmQgVFVOU0VUVk5FVEhBU0gg
YXJlIG11dHVhbGx5IGV4Y2x1c2l2ZQpmdW5jdGlvbnMuIElmIG9uZSBpcyBlbmFibGVkIHRoZSBv
dGhlciBjYWxsIHNob3VsZCBmYWlsLCB3aXRoIEVCVVNZCmZvciBpbnN0YW5jZS4KCj4gKyAgICAg
ICBjYXNlIFRVTlNFVFZORVRIQVNIOgo+ICsgICAgICAgICAgICAgICBsZW4gPSBzaXplb2Yodm5l
dF9oYXNoKTsKPiArICAgICAgICAgICAgICAgaWYgKGNvcHlfZnJvbV91c2VyKCZ2bmV0X2hhc2gs
IGFyZ3AsIGxlbikpIHsKPiArICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAtRUZBVUxUOwo+
ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ICsgICAgICAgICAgICAgICB9Cj4gKwo+
ICsgICAgICAgICAgICAgICBpZiAoKCh2bmV0X2hhc2guZmxhZ3MgJiBUVU5fVk5FVF9IQVNIX1JF
UE9SVCkgJiYKPiArICAgICAgICAgICAgICAgICAgICAodHVuLT52bmV0X2hkcl9zeiA8IHNpemVv
ZihzdHJ1Y3QgdmlydGlvX25ldF9oZHJfdjFfaGFzaCkgfHwKPiArICAgICAgICAgICAgICAgICAg
ICAgIXR1bl9pc19saXR0bGVfZW5kaWFuKHR1bikpKSB8fAo+ICsgICAgICAgICAgICAgICAgICAg
IHZuZXRfaGFzaC5pbmRpcmVjdGlvbl90YWJsZV9tYXNrID49Cj4gKyAgICAgICAgICAgICAgICAg
ICAgVFVOX1ZORVRfSEFTSF9NQVhfSU5ESVJFQ1RJT05fVEFCTEVfTEVOR1RIKSB7Cj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgcmV0ID0gLUVJTlZBTDsKPiArICAgICAgICAgICAgICAgICAgICAg
ICBicmVhazsKPiArICAgICAgICAgICAgICAgfQo+ICsKPiArICAgICAgICAgICAgICAgYXJncCA9
ICh1OCBfX3VzZXIgKilhcmdwICsgbGVuOwo+ICsgICAgICAgICAgICAgICBsZW4gPSAodm5ldF9o
YXNoLmluZGlyZWN0aW9uX3RhYmxlX21hc2sgKyAxKSAqIDI7Cj4gKyAgICAgICAgICAgICAgIGlm
IChjb3B5X2Zyb21fdXNlcih2bmV0X2hhc2hfaW5kaXJlY3Rpb25fdGFibGUsIGFyZ3AsIGxlbikp
IHsKPiArICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAtRUZBVUxUOwo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGJyZWFrOwo+ICsgICAgICAgICAgICAgICB9Cj4gKwo+ICsgICAgICAgICAg
ICAgICBhcmdwID0gKHU4IF9fdXNlciAqKWFyZ3AgKyBsZW47Cj4gKyAgICAgICAgICAgICAgIGxl
biA9IHZpcnRpb19uZXRfaGFzaF9rZXlfbGVuZ3RoKHZuZXRfaGFzaC50eXBlcyk7Cj4gKwo+ICsg
ICAgICAgICAgICAgICBpZiAoY29weV9mcm9tX3VzZXIodm5ldF9oYXNoX2tleSwgYXJncCwgbGVu
KSkgewo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IC1FRkFVTFQ7Cj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgYnJlYWs7Cj4gKyAgICAgICAgICAgICAgIH0KClByb2JhYmx5IGVhc2ll
ciBhbmQgbGVzcyBlcnJvci1wcm9uZSB0byBkZWZpbmUgYSBmaXhlZCBzaXplIGNvbnRyb2wKc3Ry
dWN0IHdpdGggdGhlIG1heCBpbmRpcmVjdGlvbiB0YWJsZSBzaXplLgoKQnR3OiBwbGVhc2UgdHJp
bSB0aGUgQ0M6IGxpc3QgY29uc2lkZXJhYmx5IG9uIGZ1dHVyZSBwYXRjaGVzLgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=

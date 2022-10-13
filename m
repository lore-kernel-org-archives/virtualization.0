Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D9FC433FE
	for <virtualization@archiver.kernel.org>; Thu, 13 Oct 2022 01:52:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5F1A540BA7;
	Thu, 13 Oct 2022 01:52:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5F1A540BA7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Aj1Tz-iYwMl; Thu, 13 Oct 2022 01:52:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F1A1A40B39;
	Thu, 13 Oct 2022 01:52:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F1A1A40B39
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5538C0033;
	Thu, 13 Oct 2022 01:52:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66FF2C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 01:52:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3435383E26
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 01:52:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3435383E26
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5JnH4kz27jDt
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 01:52:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 76A7D83E24
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 76A7D83E24
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 01:52:08 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0VS1WvPH_1665625923; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VS1WvPH_1665625923) by smtp.aliyun-inc.com;
 Thu, 13 Oct 2022 09:52:04 +0800
Message-ID: <1665625913.619304-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH RESEND] tools/virtio: initialize spinlocks in vring_test.c
Date: Thu, 13 Oct 2022 09:51:53 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Ricardo Cañuelo" <ricardo.canuelo@collabora.com>
References: <20221012062949.1526176-1-ricardo.canuelo@collabora.com>
In-Reply-To: <20221012062949.1526176-1-ricardo.canuelo@collabora.com>
Cc: kernel@collabora.com, virtualization@lists.linux-foundation.org,
 mst@redhat.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gV2VkLCAxMiBPY3QgMjAyMiAwODoyOTo0OSArMDIwMCwgIlJpY2FyZG8gQ2HDsXVlbG8iIDxy
aWNhcmRvLmNhbnVlbG9AY29sbGFib3JhLmNvbT4gd3JvdGU6Cj4gVGhlIHZpcnRpb19kZXZpY2Ug
dnFzX2xpc3Qgc3BpbmxvY2tzIG11c3QgYmUgaW5pdGlhbGl6ZWQgYmVmb3JlIHVzZSB0bwo+IHBy
ZXZlbnQgZnVuY3Rpb25zIHRoYXQgbWFuaXB1bGF0ZSB0aGUgZGV2aWNlIHZpcnR1YWxxdWV1ZXMs
IHN1Y2ggYXMKPiB2cmluZ19uZXdfdmlydHF1ZXVlKCksIGZyb20gYmxvY2tpbmcgaW5kZWZpbml0
ZWx5Lgo+Cj4gU2lnbmVkLW9mZi1ieTogUmljYXJkbyBDYcOxdWVsbyA8cmljYXJkby5jYW51ZWxv
QGNvbGxhYm9yYS5jb20+CgpSZXZpZXdlZC1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5h
bGliYWJhLmNvbT4KCj4gLS0tCj4gIHRvb2xzL3ZpcnRpby92cmluZ2hfdGVzdC5jIHwgMiArKwo+
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvdG9vbHMv
dmlydGlvL3ZyaW5naF90ZXN0LmMgYi90b29scy92aXJ0aW8vdnJpbmdoX3Rlc3QuYwo+IGluZGV4
IGZhODdiNThiZDVmYS4uOThmZjgwOGQ2ZjBjIDEwMDY0NAo+IC0tLSBhL3Rvb2xzL3ZpcnRpby92
cmluZ2hfdGVzdC5jCj4gKysrIGIvdG9vbHMvdmlydGlvL3ZyaW5naF90ZXN0LmMKPiBAQCAtMzA4
LDYgKzMwOCw3IEBAIHN0YXRpYyBpbnQgcGFyYWxsZWxfdGVzdCh1NjQgZmVhdHVyZXMsCj4KPiAg
CQlndmRldi52ZGV2LmZlYXR1cmVzID0gZmVhdHVyZXM7Cj4gIAkJSU5JVF9MSVNUX0hFQUQoJmd2
ZGV2LnZkZXYudnFzKTsKPiArCQlzcGluX2xvY2tfaW5pdCgmZ3ZkZXYudmRldi52cXNfbGlzdF9s
b2NrKTsKPiAgCQlndmRldi50b19ob3N0X2ZkID0gdG9faG9zdFsxXTsKPiAgCQlndmRldi5ub3Rp
ZmllcyA9IDA7Cj4KPiBAQCAtNDU1LDYgKzQ1Niw3IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFy
ICphcmd2W10pCj4gIAlnZXRyYW5nZSA9IGdldHJhbmdlX2lvdjsKPiAgCXZkZXYuZmVhdHVyZXMg
PSAwOwo+ICAJSU5JVF9MSVNUX0hFQUQoJnZkZXYudnFzKTsKPiArCXNwaW5fbG9ja19pbml0KCZ2
ZGV2LnZxc19saXN0X2xvY2spOwo+Cj4gIAl3aGlsZSAoYXJndlsxXSkgewo+ICAJCWlmIChzdHJj
bXAoYXJndlsxXSwgIi0taW5kaXJlY3QiKSA9PSAwKQo+IC0tCj4gMi4yNS4xCj4KPiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IFZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdAo+IFZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cj4gaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

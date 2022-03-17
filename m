Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273BEC433EF
	for <virtualization@archiver.kernel.org>; Thu, 17 Mar 2022 06:09:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9BB6B40499;
	Thu, 17 Mar 2022 06:09:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1L0inQIGAkMp; Thu, 17 Mar 2022 06:09:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A1FDD40193;
	Thu, 17 Mar 2022 06:09:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BD44C001A;
	Thu, 17 Mar 2022 06:09:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 909E1C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 06:09:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 641466128D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 06:09:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P6tjnWfVWhfG
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 06:09:43 +0000 (UTC)
X-Greylist: delayed 01:06:47 by SQLgrey-1.8.0
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A139C6128C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 06:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=bTtyCTv8jHiRySjv+joBkY5T4kiLsInhhDpfMbwTL1s=; b=os+6uLP+YQvzPOsl13Jv5guvuH
 c88qjXZH5IySVlxqAYUihC2hbNJHZhERaN/9M1O+TRZA8WFEmSQGTv+E/uOHf9IEu5y58HmvUView
 tJqv1oexE/7GCbLX/RqjjjPHc0Nz4QT1PCSUsF7D8Jb/EYTGiFjELEvWYE7Gu9MYUTFHov/uRCRY7
 /x9sJUmFziSe300ACpWlnZupzoQCtmqCqtEMV0UdvwGyry98Nfw5QdyjOvLJ0JePVDhb/0YX8qdJT
 w7vRAVMjNtBdhuXSlAfQdRkRsVo81YE8w/5mlAJkMGGTpqeQHzUxEbTrcOVom5D0PCqAQ3d5CQPbP
 DH34JIfA==;
Received: from [2601:1c0:6280:3f0::aa0b]
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUiEF-001mlP-TU; Thu, 17 Mar 2022 04:59:16 +0000
Message-ID: <5db1feea-f630-79e6-15cc-77babf58a429@infradead.org>
Date: Wed, 16 Mar 2022 21:59:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 6/9] usb: gadget: eliminate anonymous module_init &
 module_exit
Content-Language: en-US
To: Ira Weiny <ira.weiny@intel.com>
References: <20220316192010.19001-1-rdunlap@infradead.org>
 <20220316192010.19001-7-rdunlap@infradead.org>
 <YjKrMyRvHh7nzHwW@iweiny-desk3>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <YjKrMyRvHh7nzHwW@iweiny-desk3>
Cc: x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 nouveau@lists.freedesktop.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Valentina Manea <valentina.manea.m@gmail.com>,
 Karol Herbst <karolherbst@gmail.com>,
 Krzysztof Opasiak <k.opasiak@samsung.com>, Eli Cohen <eli@mellanox.com>,
 netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, coreteam@netfilter.org,
 Jakub Kicinski <kuba@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Joachim Fritschi <jfritschi@freenet.de>, Arnd Bergmann <arnd@arndb.de>,
 Amit Shah <amit@kernel.org>, "James E.J. Bottomley" <jejb@linux.ibm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 linux-block@vger.kernel.org, Pekka Paalanen <ppaalanen@gmail.com>,
 Borislav Petkov <bp@alien8.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Jussi Kivilinna <jussi.kivilinna@mbnet.fi>,
 virtualization@lists.linux-foundation.org, Jens Axboe <axboe@kernel.dk>,
 Felipe Balbi <balbi@kernel.org>, linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, linux-crypto@vger.kernel.org,
 Igor Kotrasinski <i.kotrasinsk@samsung.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
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

CgpPbiAzLzE2LzIyIDIwOjI5LCBJcmEgV2Vpbnkgd3JvdGU6Cj4gT24gV2VkLCBNYXIgMTYsIDIw
MjIgYXQgMTI6MjA6MDdQTSAtMDcwMCwgUmFuZHkgRHVubGFwIHdyb3RlOgo+PiBFbGltaW5hdGUg
YW5vbnltb3VzIG1vZHVsZV9pbml0KCkgYW5kIG1vZHVsZV9leGl0KCksIHdoaWNoIGNhbiBsZWFk
IHRvCj4+IGNvbmZ1c2lvbiBvciBhbWJpZ3VpdHkgd2hlbiByZWFkaW5nIFN5c3RlbS5tYXAsIGNy
YXNoZXMvb29wcy9idWdzLAo+PiBvciBhbiBpbml0Y2FsbF9kZWJ1ZyBsb2cuCj4+Cj4+IEdpdmUg
ZWFjaCBvZiB0aGVzZSBpbml0IGFuZCBleGl0IGZ1bmN0aW9ucyB1bmlxdWUgZHJpdmVyLXNwZWNp
ZmljCj4+IG5hbWVzIHRvIGVsaW1pbmF0ZSB0aGUgYW5vbnltb3VzIG5hbWVzLgo+Pgo+PiBFeGFt
cGxlIDE6IChTeXN0ZW0ubWFwKQo+PiAgZmZmZmZmZmY4MzJmYzc4YyB0IGluaXQKPj4gIGZmZmZm
ZmZmODMyZmM3OWUgdCBpbml0Cj4+ICBmZmZmZmZmZjgzMmZjOGY4IHQgaW5pdAo+Pgo+PiBFeGFt
cGxlIDI6IChpbml0Y2FsbF9kZWJ1ZyBsb2cpCj4+ICBjYWxsaW5nICBpbml0KzB4MC8weDEyIEAg
MQo+PiAgaW5pdGNhbGwgaW5pdCsweDAvMHgxMiByZXR1cm5lZCAwIGFmdGVyIDE1IHVzZWNzCj4+
ICBjYWxsaW5nICBpbml0KzB4MC8weDYwIEAgMQo+PiAgaW5pdGNhbGwgaW5pdCsweDAvMHg2MCBy
ZXR1cm5lZCAwIGFmdGVyIDIgdXNlY3MKPj4gIGNhbGxpbmcgIGluaXQrMHgwLzB4OWEgQCAxCj4+
ICBpbml0Y2FsbCBpbml0KzB4MC8weDlhIHJldHVybmVkIDAgYWZ0ZXIgNzQgdXNlY3MKPj4KPj4g
Rml4ZXM6IGJkMjVhMTRlZGI3NSAoInVzYjogZ2FkZ2V0OiBsZWdhY3kvc2VyaWFsOiBhbGxvdyBk
eW5hbWljIHJlbW92YWwiKQo+PiBGaXhlczogN2JiNWVhNTRiZTQ3ICgidXNiIGdhZGdldCBzZXJp
YWw6IHVzZSBjb21wb3NpdGUgZ2FkZ2V0IGZyYW1ld29yayIpCj4+IEZpeGVzOiAxZGExNzdlNGMz
ZjQgKCJMaW51eC0yLjYuMTItcmMyIikKPiAKPiBJIGNvbnRpbnVlIHRvIGJlIGNvbmZ1c2VkIGFi
b3V0IHRoZSBsYXRlc3QgcnVsZXMgZm9yIHRoZSBGaXhlcyB0YWcgYnV0IHRoaXMgb25lCj4gaW4g
cGFydGljdWxhciBzZWVtcyBjb21wbGV0ZWx5IHVzZWxlc3MuICBUaGlzIGlzIHRoZSAnYmVnaW5u
aW5nIG9mIHRpbWUnIGNvbW1pdAo+IGJ5IExpbnVzIEFGQUlDVC4gIFNvIGRvIGFueSBvZiB0aGVz
ZSBGaXhlcyB0YWdzIG5lZWQgdG8gYmUgaW4gdGhpcyBzZXJpZXM/CgpJIGd1ZXNzIGl0IG1vc3Rs
eSBkZXBlbmRzIG9uIHdoZXRoZXIgdGhleSBnZXQgYXBwbGllZCB0byBzdGFibGUgdHJlZXMsIGJ1
dAppdCdzIGVudGlyZWx5IGZpbmUgd2l0aCBtZSBpZiB0aGV5IGRvbid0LgoKe0kgYWxzbyBjb3Jy
ZWN0ZWQgRmVsaXBlJ3MgZW1haWwgYWRkcmVzcyBoZXJlLn0KCj4gUmVnYXJkbGVzczoKPiAKPiBS
ZXZpZXdlZC1ieTogSXJhIFdlaW55IDxpcmEud2VpbnlAaW50ZWwuY29tPgoKVGhhbmtzLgoKPiAK
Pj4gU2lnbmVkLW9mZi1ieTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+Cj4+
IENjOiBGZWxpcGUgQmFsYmkgPGZlbGlwZS5iYWxiaUBsaW51eC5pbnRlbC5jb20+Cj4+IENjOiBN
aWNoYcWCIE1pcm9zxYJhdyA8bWlycS1saW51eEByZXJlLnFtcW0ucGw+Cj4+IENjOiBHcmVnIEty
b2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPgo+PiBDYzogU2ViYXN0aWFu
IEFuZHJ6ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPgo+PiBDYzogbGludXgtdXNi
QHZnZXIua2VybmVsLm9yZwo+PiAtLS0KPj4gIGRyaXZlcnMvdXNiL2dhZGdldC9sZWdhY3kvaW5v
ZGUuYyAgfCAgICA4ICsrKystLS0tCj4+ICBkcml2ZXJzL3VzYi9nYWRnZXQvbGVnYWN5L3Nlcmlh
bC5jIHwgICAxMCArKysrKy0tLS0tCj4+ICBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2R1bW15X2hj
ZC5jIHwgICAgOCArKysrLS0tLQo+PiAgMyBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCsp
LCAxMyBkZWxldGlvbnMoLSkKPj4KPj4gLS0tIGxueC01MTctcmM4Lm9yaWcvZHJpdmVycy91c2Iv
Z2FkZ2V0L2xlZ2FjeS9zZXJpYWwuYwo+PiArKysgbG54LTUxNy1yYzgvZHJpdmVycy91c2IvZ2Fk
Z2V0L2xlZ2FjeS9zZXJpYWwuYwo+PiBAQCAtMjczLDcgKzI3Myw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
dXNiX2NvbXBvc2l0ZV9kcml2ZXIgZ3NlcmkKPj4gIHN0YXRpYyBpbnQgc3dpdGNoX2dzZXJpYWxf
ZW5hYmxlKGJvb2wgZG9fZW5hYmxlKQo+PiAgewo+PiAgCWlmICghc2VyaWFsX2NvbmZpZ19kcml2
ZXIubGFiZWwpCj4+IC0JCS8qIGluaXQoKSB3YXMgbm90IGNhbGxlZCwgeWV0ICovCj4+ICsJCS8q
IGdzZXJpYWxfaW5pdCgpIHdhcyBub3QgY2FsbGVkLCB5ZXQgKi8KPj4gIAkJcmV0dXJuIDA7Cj4+
ICAKPj4gIAlpZiAoZG9fZW5hYmxlKQo+PiBAQCAtMjgzLDcgKzI4Myw3IEBAIHN0YXRpYyBpbnQg
c3dpdGNoX2dzZXJpYWxfZW5hYmxlKGJvb2wgZG8KPj4gIAlyZXR1cm4gMDsKPj4gIH0KPj4gIAo+
PiAtc3RhdGljIGludCBfX2luaXQgaW5pdCh2b2lkKQo+PiArc3RhdGljIGludCBfX2luaXQgZ3Nl
cmlhbF9pbml0KHZvaWQpCj4+ICB7Cj4+ICAJLyogV2UgKmNvdWxkKiBleHBvcnQgdHdvIGNvbmZp
Z3M7IHRoYXQnZCBiZSBtdWNoIGNsZWFuZXIuLi4KPj4gIAkgKiBidXQgbmVpdGhlciBvZiB0aGVz
ZSBwcm9kdWN0IElEcyB3YXMgZGVmaW5lZCB0aGF0IHdheS4KPj4gQEAgLTMxNCwxMSArMzE0LDEx
IEBAIHN0YXRpYyBpbnQgX19pbml0IGluaXQodm9pZCkKPj4gIAo+PiAgCXJldHVybiB1c2JfY29t
cG9zaXRlX3Byb2JlKCZnc2VyaWFsX2RyaXZlcik7Cj4+ICB9Cj4+IC1tb2R1bGVfaW5pdChpbml0
KTsKPj4gK21vZHVsZV9pbml0KGdzZXJpYWxfaW5pdCk7Cj4+ICAKPj4gLXN0YXRpYyB2b2lkIF9f
ZXhpdCBjbGVhbnVwKHZvaWQpCj4+ICtzdGF0aWMgdm9pZCBfX2V4aXQgZ3NlcmlhbF9jbGVhbnVw
KHZvaWQpCj4+ICB7Cj4+ICAJaWYgKGVuYWJsZSkKPj4gIAkJdXNiX2NvbXBvc2l0ZV91bnJlZ2lz
dGVyKCZnc2VyaWFsX2RyaXZlcik7Cj4+ICB9Cj4+IC1tb2R1bGVfZXhpdChjbGVhbnVwKTsKPj4g
K21vZHVsZV9leGl0KGdzZXJpYWxfY2xlYW51cCk7Cj4+IC0tLSBsbngtNTE3LXJjOC5vcmlnL2Ry
aXZlcnMvdXNiL2dhZGdldC91ZGMvZHVtbXlfaGNkLmMKPj4gKysrIGxueC01MTctcmM4L2RyaXZl
cnMvdXNiL2dhZGdldC91ZGMvZHVtbXlfaGNkLmMKPj4gQEAgLTI3NjUsNyArMjc2NSw3IEBAIHN0
YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGR1bW15X2hjZF8KPj4gIHN0YXRpYyBzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICp0aGVfdWRjX3BkZXZbTUFYX05VTV9VRENdOwo+PiAgc3RhdGljIHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnRoZV9oY2RfcGRldltNQVhfTlVNX1VEQ107Cj4+ICAKPj4g
LXN0YXRpYyBpbnQgX19pbml0IGluaXQodm9pZCkKPj4gK3N0YXRpYyBpbnQgX19pbml0IGR1bW15
X2hjZF9pbml0KHZvaWQpCj4+ICB7Cj4+ICAJaW50CXJldHZhbCA9IC1FTk9NRU07Cj4+ICAJaW50
CWk7Cj4+IEBAIC0yODg3LDkgKzI4ODcsOSBAQCBlcnJfYWxsb2NfdWRjOgo+PiAgCQlwbGF0Zm9y
bV9kZXZpY2VfcHV0KHRoZV9oY2RfcGRldltpXSk7Cj4+ICAJcmV0dXJuIHJldHZhbDsKPj4gIH0K
Pj4gLW1vZHVsZV9pbml0KGluaXQpOwo+PiArbW9kdWxlX2luaXQoZHVtbXlfaGNkX2luaXQpOwo+
PiAgCj4+IC1zdGF0aWMgdm9pZCBfX2V4aXQgY2xlYW51cCh2b2lkKQo+PiArc3RhdGljIHZvaWQg
X19leGl0IGR1bW15X2hjZF9jbGVhbnVwKHZvaWQpCj4+ICB7Cj4+ICAJaW50IGk7Cj4+ICAKPj4g
QEAgLTI5MDUsNCArMjkwNSw0IEBAIHN0YXRpYyB2b2lkIF9fZXhpdCBjbGVhbnVwKHZvaWQpCj4+
ICAJcGxhdGZvcm1fZHJpdmVyX3VucmVnaXN0ZXIoJmR1bW15X3VkY19kcml2ZXIpOwo+PiAgCXBs
YXRmb3JtX2RyaXZlcl91bnJlZ2lzdGVyKCZkdW1teV9oY2RfZHJpdmVyKTsKPj4gIH0KPj4gLW1v
ZHVsZV9leGl0KGNsZWFudXApOwo+PiArbW9kdWxlX2V4aXQoZHVtbXlfaGNkX2NsZWFudXApOwo+
PiAtLS0gbG54LTUxNy1yYzgub3JpZy9kcml2ZXJzL3VzYi9nYWRnZXQvbGVnYWN5L2lub2RlLmMK
Pj4gKysrIGxueC01MTctcmM4L2RyaXZlcnMvdXNiL2dhZGdldC9sZWdhY3kvaW5vZGUuYwo+PiBA
QCAtMjEwMSw3ICsyMTAxLDcgQEAgTU9EVUxFX0FMSUFTX0ZTKCJnYWRnZXRmcyIpOwo+PiAgCj4+
ICAvKi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0qLwo+PiAgCj4+IC1zdGF0aWMgaW50IF9faW5pdCBpbml0ICh2b2lk
KQo+PiArc3RhdGljIGludCBfX2luaXQgZ2FkZ2V0ZnNfaW5pdCAodm9pZCkKPj4gIHsKPj4gIAlp
bnQgc3RhdHVzOwo+PiAgCj4+IEBAIC0yMTExLDEyICsyMTExLDEyIEBAIHN0YXRpYyBpbnQgX19p
bml0IGluaXQgKHZvaWQpCj4+ICAJCQlzaG9ydG5hbWUsIGRyaXZlcl9kZXNjKTsKPj4gIAlyZXR1
cm4gc3RhdHVzOwo+PiAgfQo+PiAtbW9kdWxlX2luaXQgKGluaXQpOwo+PiArbW9kdWxlX2luaXQg
KGdhZGdldGZzX2luaXQpOwo+PiAgCj4+IC1zdGF0aWMgdm9pZCBfX2V4aXQgY2xlYW51cCAodm9p
ZCkKPj4gK3N0YXRpYyB2b2lkIF9fZXhpdCBnYWRnZXRmc19jbGVhbnVwICh2b2lkKQo+PiAgewo+
PiAgCXByX2RlYnVnICgidW5yZWdpc3RlciAlc1xuIiwgc2hvcnRuYW1lKTsKPj4gIAl1bnJlZ2lz
dGVyX2ZpbGVzeXN0ZW0gKCZnYWRnZXRmc190eXBlKTsKPj4gIH0KPj4gLW1vZHVsZV9leGl0IChj
bGVhbnVwKTsKPj4gK21vZHVsZV9leGl0IChnYWRnZXRmc19jbGVhbnVwKTsKPj4gIAoKLS0gCn5S
YW5keQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=

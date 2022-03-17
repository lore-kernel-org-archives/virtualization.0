Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BCAC433F5
	for <virtualization@archiver.kernel.org>; Thu, 17 Mar 2022 03:30:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E180E84131;
	Thu, 17 Mar 2022 03:30:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vq1EBkwE_izN; Thu, 17 Mar 2022 03:30:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 429D38411D;
	Thu, 17 Mar 2022 03:30:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17029C0012;
	Thu, 17 Mar 2022 03:30:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A76DEC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 03:30:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8506040AF9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 03:30:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SJQuTttszX6b
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 03:29:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 645B040AEE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 03:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647487798; x=1679023798;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=AzMb0/YG2S8LI24My11FysIdAjjvdmOrV481bVhZgTI=;
 b=CkMGkFC0ykulvijb1PNe36arxa06H5nrM19HGU3vCFw6XWczWus9rvjH
 t8gfFajYUua194pG2i3T/GyMZjtRHZohJegOjAO9OQmJTeow8o7IOgzXj
 kcOB6FmcgNWKWidZeNQAR/qcjFynQCM1lWTposfsVZaMVKzJwhzOIrtIX
 5af3kZuwI9Hle5GhuKM9PYTMrBaoCYbL9xE67BRU51LwGTKgLF+fk43py
 Q2at8z4UKu4A6gTp+xf1IBkhRXiAxypw3e9TrptMl5WyrvP+nGQKZn9xN
 ggN+xv2UufIygm8FDStFzLA7PvoBpY0PclGp6hCDnf/j0KQM96unBTzHP g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256499745"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; d="scan'208";a="256499745"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 20:29:57 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; d="scan'208";a="635225301"
Received: from mbhanuva-mobl.amr.corp.intel.com (HELO localhost)
 ([10.212.30.158])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 20:29:56 -0700
Date: Wed, 16 Mar 2022 20:29:55 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 6/9] usb: gadget: eliminate anonymous module_init &
 module_exit
Message-ID: <YjKrMyRvHh7nzHwW@iweiny-desk3>
References: <20220316192010.19001-1-rdunlap@infradead.org>
 <20220316192010.19001-7-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220316192010.19001-7-rdunlap@infradead.org>
Cc: x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 nouveau@lists.freedesktop.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Valentina Manea <valentina.manea.m@gmail.com>,
 Karol Herbst <karolherbst@gmail.com>,
 Krzysztof Opasiak <k.opasiak@samsung.com>, Eli Cohen <eli@mellanox.com>,
 netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, coreteam@netfilter.org,
 Jakub Kicinski <kuba@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Joachim Fritschi <jfritschi@freenet.de>,
 Felipe Balbi <felipe.balbi@linux.intel.com>, Amit Shah <amit@kernel.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 linux-block@vger.kernel.org, Pekka Paalanen <ppaalanen@gmail.com>,
 Borislav Petkov <bp@alien8.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Jussi Kivilinna <jussi.kivilinna@mbnet.fi>,
 virtualization@lists.linux-foundation.org,
 Herbert Xu <herbert@gondor.apana.org.au>, Jens Axboe <axboe@kernel.dk>,
 linux-scsi@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
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

T24gV2VkLCBNYXIgMTYsIDIwMjIgYXQgMTI6MjA6MDdQTSAtMDcwMCwgUmFuZHkgRHVubGFwIHdy
b3RlOgo+IEVsaW1pbmF0ZSBhbm9ueW1vdXMgbW9kdWxlX2luaXQoKSBhbmQgbW9kdWxlX2V4aXQo
KSwgd2hpY2ggY2FuIGxlYWQgdG8KPiBjb25mdXNpb24gb3IgYW1iaWd1aXR5IHdoZW4gcmVhZGlu
ZyBTeXN0ZW0ubWFwLCBjcmFzaGVzL29vcHMvYnVncywKPiBvciBhbiBpbml0Y2FsbF9kZWJ1ZyBs
b2cuCj4gCj4gR2l2ZSBlYWNoIG9mIHRoZXNlIGluaXQgYW5kIGV4aXQgZnVuY3Rpb25zIHVuaXF1
ZSBkcml2ZXItc3BlY2lmaWMKPiBuYW1lcyB0byBlbGltaW5hdGUgdGhlIGFub255bW91cyBuYW1l
cy4KPiAKPiBFeGFtcGxlIDE6IChTeXN0ZW0ubWFwKQo+ICBmZmZmZmZmZjgzMmZjNzhjIHQgaW5p
dAo+ICBmZmZmZmZmZjgzMmZjNzllIHQgaW5pdAo+ICBmZmZmZmZmZjgzMmZjOGY4IHQgaW5pdAo+
IAo+IEV4YW1wbGUgMjogKGluaXRjYWxsX2RlYnVnIGxvZykKPiAgY2FsbGluZyAgaW5pdCsweDAv
MHgxMiBAIDEKPiAgaW5pdGNhbGwgaW5pdCsweDAvMHgxMiByZXR1cm5lZCAwIGFmdGVyIDE1IHVz
ZWNzCj4gIGNhbGxpbmcgIGluaXQrMHgwLzB4NjAgQCAxCj4gIGluaXRjYWxsIGluaXQrMHgwLzB4
NjAgcmV0dXJuZWQgMCBhZnRlciAyIHVzZWNzCj4gIGNhbGxpbmcgIGluaXQrMHgwLzB4OWEgQCAx
Cj4gIGluaXRjYWxsIGluaXQrMHgwLzB4OWEgcmV0dXJuZWQgMCBhZnRlciA3NCB1c2Vjcwo+IAo+
IEZpeGVzOiBiZDI1YTE0ZWRiNzUgKCJ1c2I6IGdhZGdldDogbGVnYWN5L3NlcmlhbDogYWxsb3cg
ZHluYW1pYyByZW1vdmFsIikKPiBGaXhlczogN2JiNWVhNTRiZTQ3ICgidXNiIGdhZGdldCBzZXJp
YWw6IHVzZSBjb21wb3NpdGUgZ2FkZ2V0IGZyYW1ld29yayIpCj4gRml4ZXM6IDFkYTE3N2U0YzNm
NCAoIkxpbnV4LTIuNi4xMi1yYzIiKQoKSSBjb250aW51ZSB0byBiZSBjb25mdXNlZCBhYm91dCB0
aGUgbGF0ZXN0IHJ1bGVzIGZvciB0aGUgRml4ZXMgdGFnIGJ1dCB0aGlzIG9uZQppbiBwYXJ0aWN1
bGFyIHNlZW1zIGNvbXBsZXRlbHkgdXNlbGVzcy4gIFRoaXMgaXMgdGhlICdiZWdpbm5pbmcgb2Yg
dGltZScgY29tbWl0CmJ5IExpbnVzIEFGQUlDVC4gIFNvIGRvIGFueSBvZiB0aGVzZSBGaXhlcyB0
YWdzIG5lZWQgdG8gYmUgaW4gdGhpcyBzZXJpZXM/CgpSZWdhcmRsZXNzOgoKUmV2aWV3ZWQtYnk6
IElyYSBXZWlueSA8aXJhLndlaW55QGludGVsLmNvbT4KCj4gU2lnbmVkLW9mZi1ieTogUmFuZHkg
RHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+Cj4gQ2M6IEZlbGlwZSBCYWxiaSA8ZmVsaXBl
LmJhbGJpQGxpbnV4LmludGVsLmNvbT4KPiBDYzogTWljaGHFgiBNaXJvc8WCYXcgPG1pcnEtbGlu
dXhAcmVyZS5xbXFtLnBsPgo+IENjOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZv
dW5kYXRpb24ub3JnPgo+IENjOiBTZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9yIDxiaWdlYXN5QGxp
bnV0cm9uaXguZGU+Cj4gQ2M6IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmcKPiAtLS0KPiAgZHJp
dmVycy91c2IvZ2FkZ2V0L2xlZ2FjeS9pbm9kZS5jICB8ICAgIDggKysrKy0tLS0KPiAgZHJpdmVy
cy91c2IvZ2FkZ2V0L2xlZ2FjeS9zZXJpYWwuYyB8ICAgMTAgKysrKystLS0tLQo+ICBkcml2ZXJz
L3VzYi9nYWRnZXQvdWRjL2R1bW15X2hjZC5jIHwgICAgOCArKysrLS0tLQo+ICAzIGZpbGVzIGNo
YW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQo+IAo+IC0tLSBsbngtNTE3
LXJjOC5vcmlnL2RyaXZlcnMvdXNiL2dhZGdldC9sZWdhY3kvc2VyaWFsLmMKPiArKysgbG54LTUx
Ny1yYzgvZHJpdmVycy91c2IvZ2FkZ2V0L2xlZ2FjeS9zZXJpYWwuYwo+IEBAIC0yNzMsNyArMjcz
LDcgQEAgc3RhdGljIHN0cnVjdCB1c2JfY29tcG9zaXRlX2RyaXZlciBnc2VyaQo+ICBzdGF0aWMg
aW50IHN3aXRjaF9nc2VyaWFsX2VuYWJsZShib29sIGRvX2VuYWJsZSkKPiAgewo+ICAJaWYgKCFz
ZXJpYWxfY29uZmlnX2RyaXZlci5sYWJlbCkKPiAtCQkvKiBpbml0KCkgd2FzIG5vdCBjYWxsZWQs
IHlldCAqLwo+ICsJCS8qIGdzZXJpYWxfaW5pdCgpIHdhcyBub3QgY2FsbGVkLCB5ZXQgKi8KPiAg
CQlyZXR1cm4gMDsKPiAgCj4gIAlpZiAoZG9fZW5hYmxlKQo+IEBAIC0yODMsNyArMjgzLDcgQEAg
c3RhdGljIGludCBzd2l0Y2hfZ3NlcmlhbF9lbmFibGUoYm9vbCBkbwo+ICAJcmV0dXJuIDA7Cj4g
IH0KPiAgCj4gLXN0YXRpYyBpbnQgX19pbml0IGluaXQodm9pZCkKPiArc3RhdGljIGludCBfX2lu
aXQgZ3NlcmlhbF9pbml0KHZvaWQpCj4gIHsKPiAgCS8qIFdlICpjb3VsZCogZXhwb3J0IHR3byBj
b25maWdzOyB0aGF0J2QgYmUgbXVjaCBjbGVhbmVyLi4uCj4gIAkgKiBidXQgbmVpdGhlciBvZiB0
aGVzZSBwcm9kdWN0IElEcyB3YXMgZGVmaW5lZCB0aGF0IHdheS4KPiBAQCAtMzE0LDExICszMTQs
MTEgQEAgc3RhdGljIGludCBfX2luaXQgaW5pdCh2b2lkKQo+ICAKPiAgCXJldHVybiB1c2JfY29t
cG9zaXRlX3Byb2JlKCZnc2VyaWFsX2RyaXZlcik7Cj4gIH0KPiAtbW9kdWxlX2luaXQoaW5pdCk7
Cj4gK21vZHVsZV9pbml0KGdzZXJpYWxfaW5pdCk7Cj4gIAo+IC1zdGF0aWMgdm9pZCBfX2V4aXQg
Y2xlYW51cCh2b2lkKQo+ICtzdGF0aWMgdm9pZCBfX2V4aXQgZ3NlcmlhbF9jbGVhbnVwKHZvaWQp
Cj4gIHsKPiAgCWlmIChlbmFibGUpCj4gIAkJdXNiX2NvbXBvc2l0ZV91bnJlZ2lzdGVyKCZnc2Vy
aWFsX2RyaXZlcik7Cj4gIH0KPiAtbW9kdWxlX2V4aXQoY2xlYW51cCk7Cj4gK21vZHVsZV9leGl0
KGdzZXJpYWxfY2xlYW51cCk7Cj4gLS0tIGxueC01MTctcmM4Lm9yaWcvZHJpdmVycy91c2IvZ2Fk
Z2V0L3VkYy9kdW1teV9oY2QuYwo+ICsrKyBsbngtNTE3LXJjOC9kcml2ZXJzL3VzYi9nYWRnZXQv
dWRjL2R1bW15X2hjZC5jCj4gQEAgLTI3NjUsNyArMjc2NSw3IEBAIHN0YXRpYyBzdHJ1Y3QgcGxh
dGZvcm1fZHJpdmVyIGR1bW15X2hjZF8KPiAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnRoZV91ZGNfcGRldltNQVhfTlVNX1VEQ107Cj4gIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICp0aGVfaGNkX3BkZXZbTUFYX05VTV9VRENdOwo+ICAKPiAtc3RhdGljIGludCBfX2luaXQg
aW5pdCh2b2lkKQo+ICtzdGF0aWMgaW50IF9faW5pdCBkdW1teV9oY2RfaW5pdCh2b2lkKQo+ICB7
Cj4gIAlpbnQJcmV0dmFsID0gLUVOT01FTTsKPiAgCWludAlpOwo+IEBAIC0yODg3LDkgKzI4ODcs
OSBAQCBlcnJfYWxsb2NfdWRjOgo+ICAJCXBsYXRmb3JtX2RldmljZV9wdXQodGhlX2hjZF9wZGV2
W2ldKTsKPiAgCXJldHVybiByZXR2YWw7Cj4gIH0KPiAtbW9kdWxlX2luaXQoaW5pdCk7Cj4gK21v
ZHVsZV9pbml0KGR1bW15X2hjZF9pbml0KTsKPiAgCj4gLXN0YXRpYyB2b2lkIF9fZXhpdCBjbGVh
bnVwKHZvaWQpCj4gK3N0YXRpYyB2b2lkIF9fZXhpdCBkdW1teV9oY2RfY2xlYW51cCh2b2lkKQo+
ICB7Cj4gIAlpbnQgaTsKPiAgCj4gQEAgLTI5MDUsNCArMjkwNSw0IEBAIHN0YXRpYyB2b2lkIF9f
ZXhpdCBjbGVhbnVwKHZvaWQpCj4gIAlwbGF0Zm9ybV9kcml2ZXJfdW5yZWdpc3RlcigmZHVtbXlf
dWRjX2RyaXZlcik7Cj4gIAlwbGF0Zm9ybV9kcml2ZXJfdW5yZWdpc3RlcigmZHVtbXlfaGNkX2Ry
aXZlcik7Cj4gIH0KPiAtbW9kdWxlX2V4aXQoY2xlYW51cCk7Cj4gK21vZHVsZV9leGl0KGR1bW15
X2hjZF9jbGVhbnVwKTsKPiAtLS0gbG54LTUxNy1yYzgub3JpZy9kcml2ZXJzL3VzYi9nYWRnZXQv
bGVnYWN5L2lub2RlLmMKPiArKysgbG54LTUxNy1yYzgvZHJpdmVycy91c2IvZ2FkZ2V0L2xlZ2Fj
eS9pbm9kZS5jCj4gQEAgLTIxMDEsNyArMjEwMSw3IEBAIE1PRFVMRV9BTElBU19GUygiZ2FkZ2V0
ZnMiKTsKPiAgCj4gIC8qLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSovCj4gIAo+IC1zdGF0aWMgaW50IF9faW5pdCBp
bml0ICh2b2lkKQo+ICtzdGF0aWMgaW50IF9faW5pdCBnYWRnZXRmc19pbml0ICh2b2lkKQo+ICB7
Cj4gIAlpbnQgc3RhdHVzOwo+ICAKPiBAQCAtMjExMSwxMiArMjExMSwxMiBAQCBzdGF0aWMgaW50
IF9faW5pdCBpbml0ICh2b2lkKQo+ICAJCQlzaG9ydG5hbWUsIGRyaXZlcl9kZXNjKTsKPiAgCXJl
dHVybiBzdGF0dXM7Cj4gIH0KPiAtbW9kdWxlX2luaXQgKGluaXQpOwo+ICttb2R1bGVfaW5pdCAo
Z2FkZ2V0ZnNfaW5pdCk7Cj4gIAo+IC1zdGF0aWMgdm9pZCBfX2V4aXQgY2xlYW51cCAodm9pZCkK
PiArc3RhdGljIHZvaWQgX19leGl0IGdhZGdldGZzX2NsZWFudXAgKHZvaWQpCj4gIHsKPiAgCXBy
X2RlYnVnICgidW5yZWdpc3RlciAlc1xuIiwgc2hvcnRuYW1lKTsKPiAgCXVucmVnaXN0ZXJfZmls
ZXN5c3RlbSAoJmdhZGdldGZzX3R5cGUpOwo+ICB9Cj4gLW1vZHVsZV9leGl0IChjbGVhbnVwKTsK
PiArbW9kdWxlX2V4aXQgKGdhZGdldGZzX2NsZWFudXApOwo+ICAKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E96C433F5
	for <virtualization@archiver.kernel.org>; Wed, 16 Mar 2022 19:21:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50B1C41823;
	Wed, 16 Mar 2022 19:21:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xI-dzO8z8nGP; Wed, 16 Mar 2022 19:21:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 97C2E41820;
	Wed, 16 Mar 2022 19:21:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69B6FC0082;
	Wed, 16 Mar 2022 19:21:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A74EC0033
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 19:21:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C681400BA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 19:21:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QSwDfxeA1IZR
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 19:21:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 09773400AF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 19:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=X2j8KWKH7mPGrGuSOCsj6/Zr05knYdm/d0qKjoRqe/A=; b=bdC3zFz0aD/kHDcjfAyZbfQHBp
 7D/NlBM1amLmkH4B4sqKV2ufqUvJD88hTlKpyZ6VqDgekjK4FNGYILRpxkEqmQPADEL6WPYAAzU3c
 Sgrf+0emCMPKxF4geOisKrAEZIi126v6w7X5ziKEvg+Vo5Kfv7gQeEp68Rya/2NrsCbuCdD1F1eRO
 BniaXaZDMgIYFHq/3z0YvLS2w5qVtTdqdrrvR04+Nr2xp3obBSzkGzIwryyT9w7ppsZfrvdhEgpU1
 CvVbeb1+V8VRryF0rtfXsRiz/tX5kbeNaIbViAt6lEitADJHoianGTvyLAizZrpPdjB0SFmWrUO/U
 gzvEtNsQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUZBu-00EArp-Lx; Wed, 16 Mar 2022 19:20:14 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] treewide: eliminate anonymous module_init & module_exit
Date: Wed, 16 Mar 2022 12:20:01 -0700
Message-Id: <20220316192010.19001-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Cc: linux-usb@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 nouveau@lists.freedesktop.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Valentina Manea <valentina.manea.m@gmail.com>,
 virtualization@lists.linux-foundation.org,
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
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
 linux-block@vger.kernel.org, Pekka Paalanen <ppaalanen@gmail.com>,
 Borislav Petkov <bp@alien8.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Jussi Kivilinna <jussi.kivilinna@mbnet.fi>,
 Herbert Xu <herbert@gondor.apana.org.au>, Jens Axboe <axboe@kernel.dk>,
 x86@kernel.org, linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Florian Westphal <fw@strlen.de>,
 Karol Herbst <karolherbst@gmail.com>, netfilter-devel@vger.kernel.org,
 linux-crypto@vger.kernel.org, Igor Kotrasinski <i.kotrasinsk@samsung.com>,
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

VGhlcmUgYXJlIGEgbnVtYmVyIG9mIGRyaXZlcnMgdGhhdCB1c2UgIm1vZHVsZV9pbml0KGluaXQp
IiBhbmQKIm1vZHVsZV9leGl0KGV4aXQpIiwgd2hpY2ggYXJlIGFub255bW91cyBuYW1lcyBhbmQg
Y2FuIGxlYWQgdG8KY29uZnVzaW9uIG9yIGFtYmlndWl0eSB3aGVuIHJlYWRpbmcgU3lzdGVtLm1h
cCwgY3Jhc2hlcy9vb3BzL2J1Z3MsCm9yIGFuIGluaXRjYWxsX2RlYnVnIGxvZy4KCkdpdmUgZWFj
aCBvZiB0aGVzZSBpbml0IGFuZCBleGl0IGZ1bmN0aW9ucyB1bmlxdWUgZHJpdmVyLXNwZWNpZmlj
Cm5hbWVzIHRvIGVsaW1pbmF0ZSB0aGUgYW5vbnltb3VzIG5hbWVzLgoKRXhhbXBsZSAxOiAoU3lz
dGVtLm1hcCkKIGZmZmZmZmZmODMyZmM3OGMgdCBpbml0CiBmZmZmZmZmZjgzMmZjNzllIHQgaW5p
dAogZmZmZmZmZmY4MzJmYzhmOCB0IGluaXQKIGZmZmZmZmZmODMyZmNhMDUgdCBpbml0CiBmZmZm
ZmZmZjgzMmZjYmQyIHQgaW5pdAogZmZmZmZmZmY4MzMyOGYwZSB0IGluaXQKIGZmZmZmZmZmODMz
MmM1YjEgdCBpbml0CiBmZmZmZmZmZjgzMzJkOWViIHQgaW5pdAogZmZmZmZmZmY4MzMyZjBhYSB0
IGluaXQKIGZmZmZmZmZmODMzMzBlMjUgdCBpbml0CiBmZmZmZmZmZjgzMzMxN2E1IHQgaW5pdAog
ZmZmZmZmZmY4MzMzZGQ2YiB0IGluaXQKCkV4YW1wbGUgMjogKGluaXRjYWxsX2RlYnVnIGxvZykK
IGNhbGxpbmcgIGluaXQrMHgwLzB4MTIgQCAxCiBpbml0Y2FsbCBpbml0KzB4MC8weDEyIHJldHVy
bmVkIDAgYWZ0ZXIgMTUgdXNlY3MKIGNhbGxpbmcgIGluaXQrMHgwLzB4NjAgQCAxCiBpbml0Y2Fs
bCBpbml0KzB4MC8weDYwIHJldHVybmVkIDAgYWZ0ZXIgMiB1c2VjcwogY2FsbGluZyAgaW5pdCsw
eDAvMHg5YSBAIDEKIGluaXRjYWxsIGluaXQrMHgwLzB4OWEgcmV0dXJuZWQgMCBhZnRlciA3NCB1
c2VjcwogY2FsbGluZyAgaW5pdCsweDAvMHg3MyBAIDEKIGluaXRjYWxsIGluaXQrMHgwLzB4NzMg
cmV0dXJuZWQgMCBhZnRlciA2IHVzZWNzCiBjYWxsaW5nICBpbml0KzB4MC8weDczIEAgMQogaW5p
dGNhbGwgaW5pdCsweDAvMHg3MyByZXR1cm5lZCAwIGFmdGVyIDQgdXNlY3MKIGNhbGxpbmcgIGlu
aXQrMHgwLzB4ZjUgQCAxCiBpbml0Y2FsbCBpbml0KzB4MC8weGY1IHJldHVybmVkIDAgYWZ0ZXIg
MjcgdXNlY3MKIGNhbGxpbmcgIGluaXQrMHgwLzB4N2QgQCAxCiBpbml0Y2FsbCBpbml0KzB4MC8w
eDdkIHJldHVybmVkIDAgYWZ0ZXIgMTEgdXNlY3MKIGNhbGxpbmcgIGluaXQrMHgwLzB4YzkgQCAx
CiBpbml0Y2FsbCBpbml0KzB4MC8weGM5IHJldHVybmVkIDAgYWZ0ZXIgMTkgdXNlY3MKIGNhbGxp
bmcgIGluaXQrMHgwLzB4OWQgQCAxCiBpbml0Y2FsbCBpbml0KzB4MC8weDlkIHJldHVybmVkIDAg
YWZ0ZXIgMzcgdXNlY3MKIGNhbGxpbmcgIGluaXQrMHgwLzB4NjNmIEAgMQogaW5pdGNhbGwgaW5p
dCsweDAvMHg2M2YgcmV0dXJuZWQgMCBhZnRlciA0MTEgdXNlY3MKIGNhbGxpbmcgIGluaXQrMHgw
LzB4MTcxIEAgMQogaW5pdGNhbGwgaW5pdCsweDAvMHgxNzEgcmV0dXJuZWQgMCBhZnRlciA2MSB1
c2VjcwogY2FsbGluZyAgaW5pdCsweDAvMHhlZiBAIDEKIGluaXRjYWxsIGluaXQrMHgwLzB4ZWYg
cmV0dXJuZWQgMCBhZnRlciAzIHVzZWNzCgpDYzogIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEBy
ZWRoYXQuY29tPgpDYzogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KQ2M6IFBhb2xv
IEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+CkNjOiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZh
bmhhQHJlZGhhdC5jb20+CkNjOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkNjOiBBbWl0
IFNoYWggPGFtaXRAa2VybmVsLm9yZz4KQ2M6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+
CkNjOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPgpDYzog
RWxpIENvaGVuIDxlbGlAbWVsbGFub3guY29tPgpDYzogU2FlZWQgTWFoYW1lZWQgPHNhZWVkbUBu
dmlkaWEuY29tPgpDYzogTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+CkNjOiBQYWJs
byBOZWlyYSBBeXVzbyA8cGFibG9AbmV0ZmlsdGVyLm9yZz4KQ2M6IEpvenNlZiBLYWRsZWNzaWsg
PGthZGxlY0BuZXRmaWx0ZXIub3JnPgpDYzogRmxvcmlhbiBXZXN0cGhhbCA8ZndAc3RybGVuLmRl
PgpDYzogIkRhdmlkIFMuIE1pbGxlciIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+CkNjOiBKYWt1YiBL
aWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPgpDYzogIkphbWVzIEUuSi4gQm90dG9tbGV5IiA8amVq
YkBsaW51eC5pYm0uY29tPgpDYzogIk1hcnRpbiBLLiBQZXRlcnNlbiIgPG1hcnRpbi5wZXRlcnNl
bkBvcmFjbGUuY29tPgpDYzogRmVsaXBlIEJhbGJpIDxmZWxpcGUuYmFsYmlAbGludXguaW50ZWwu
Y29tPgpDYzogTWljaGHFgiBNaXJvc8WCYXcgPG1pcnEtbGludXhAcmVyZS5xbXFtLnBsPgpDYzog
U2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPgpDYzogS3J6
eXN6dG9mIE9wYXNpYWsgPGsub3Bhc2lha0BzYW1zdW5nLmNvbT4KQ2M6IElnb3IgS290cmFzaW5z
a2kgPGkua290cmFzaW5za0BzYW1zdW5nLmNvbT4KQ2M6IFZhbGVudGluYSBNYW5lYSA8dmFsZW50
aW5hLm1hbmVhLm1AZ21haWwuY29tPgpDYzogU2h1YWggS2hhbiA8c2h1YWhAa2VybmVsLm9yZz4K
Q2M6IFNodWFoIEtoYW4gPHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+CkNjOiBKdXNzaSBLaXZp
bGlubmEgPGp1c3NpLmtpdmlsaW5uYUBtYm5ldC5maT4KQ2M6IEpvYWNoaW0gRnJpdHNjaGkgPGpm
cml0c2NoaUBmcmVlbmV0LmRlPgpDYzogSGVyYmVydCBYdSA8aGVyYmVydEBnb25kb3IuYXBhbmEu
b3JnLmF1PgpDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+CkNjOiBTdGV2
ZW4gUm9zdGVkdCA8cm9zdGVkdEBnb29kbWlzLm9yZz4KQ2M6IEluZ28gTW9sbmFyIDxtaW5nb0Br
ZXJuZWwub3JnPgpDYzogS2Fyb2wgSGVyYnN0IDxrYXJvbGhlcmJzdEBnbWFpbC5jb20+CkNjOiBQ
ZWtrYSBQYWFsYW5lbiA8cHBhYWxhbmVuQGdtYWlsLmNvbT4KQ2M6IERhdmUgSGFuc2VuIDxkYXZl
LmhhbnNlbkBsaW51eC5pbnRlbC5jb20+CkNjOiBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVs
Lm9yZz4KQ2M6IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4KQ2M6IEJvcmlz
bGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPgpDYzogIkguIFBldGVyIEFudmluIiA8aHBhQHp5dG9y
LmNvbT4KQ2M6IG5ldGZpbHRlci1kZXZlbEB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGNvcmV0ZWFtQG5l
dGZpbHRlci5vcmcKQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGxpbnV4LWJsb2NrQHZn
ZXIua2VybmVsLm9yZwpDYzogbGludXgtY3J5cHRvQHZnZXIua2VybmVsLm9yZwpDYzogbGludXgt
cmRtYUB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGxpbnV4LXNjc2lAdmdlci5rZXJuZWwub3JnCkNjOiBs
aW51eC11c2JAdmdlci5rZXJuZWwub3JnCkNjOiBub3V2ZWF1QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpDYzogdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKQ2M6IHg4NkBr
ZXJuZWwub3JnCgpwYXRjaGVzOgogW1BBVENIIDEvOV0gdmlydGlvX2JsazogZWxpbWluYXRlIGFu
b255bW91cyBtb2R1bGVfaW5pdCAmIG1vZHVsZV9leGl0CiBbUEFUQ0ggMi85XSB2aXJ0aW9fY29u
c29sZTogZWxpbWluYXRlIGFub255bW91cyBtb2R1bGVfaW5pdCAmIG1vZHVsZV9leGl0CiBbUEFU
Q0ggMy85XSBuZXQ6IG1seDU6IGVsaW1pbmF0ZSBhbm9ueW1vdXMgbW9kdWxlX2luaXQgJiBtb2R1
bGVfZXhpdAogW1BBVENIIDQvOV0gbmV0ZmlsdGVyOiBoMzIzOiBlbGltaW5hdGUgYW5vbnltb3Vz
IG1vZHVsZV9pbml0ICYgbW9kdWxlX2V4aXQKIFtQQVRDSCA1LzldIHZpcnRpby1zY3NpOiBlbGlt
aW5hdGUgYW5vbnltb3VzIG1vZHVsZV9pbml0ICYgbW9kdWxlX2V4aXQKIFtQQVRDSCA2LzldIHVz
YjogZ2FkZ2V0OiBlbGltaW5hdGUgYW5vbnltb3VzIG1vZHVsZV9pbml0ICYgbW9kdWxlX2V4aXQK
IFtQQVRDSCA3LzldIHVzYjogdXNiaXA6IGVsaW1pbmF0ZSBhbm9ueW1vdXMgbW9kdWxlX2luaXQg
JiBtb2R1bGVfZXhpdAogW1BBVENIIDgvOV0geDg2L2NyeXB0bzogZWxpbWluYXRlIGFub255bW91
cyBtb2R1bGVfaW5pdCAmIG1vZHVsZV9leGl0CiBbUEFUQ0ggOS85XSB0ZXN0bW1pb3RyYWNlOiBl
bGltaW5hdGUgYW5vbnltb3VzIG1vZHVsZV9pbml0ICYgbW9kdWxlX2V4aXQKCmRpZmZzdGF0Ogog
YXJjaC94ODYvY3J5cHRvL2Jsb3dmaXNoX2dsdWUuYyAgICAgICAgICAgICAgICB8ICAgIDggKysr
Ky0tLS0KIGFyY2gveDg2L2NyeXB0by9jYW1lbGxpYV9nbHVlLmMgICAgICAgICAgICAgICAgfCAg
ICA4ICsrKystLS0tCiBhcmNoL3g4Ni9jcnlwdG8vc2VycGVudF9hdngyX2dsdWUuYyAgICAgICAg
ICAgIHwgICAgOCArKysrLS0tLQogYXJjaC94ODYvY3J5cHRvL3R3b2Zpc2hfZ2x1ZS5jICAgICAg
ICAgICAgICAgICB8ICAgIDggKysrKy0tLS0KIGFyY2gveDg2L2NyeXB0by90d29maXNoX2dsdWVf
M3dheS5jICAgICAgICAgICAgfCAgICA4ICsrKystLS0tCiBhcmNoL3g4Ni9tbS90ZXN0bW1pb3Ry
YWNlLmMgICAgICAgICAgICAgICAgICAgIHwgICAgOCArKysrLS0tLQogZHJpdmVycy9ibG9jay92
aXJ0aW9fYmxrLmMgICAgICAgICAgICAgICAgICAgICB8ICAgIDggKysrKy0tLS0KIGRyaXZlcnMv
Y2hhci92aXJ0aW9fY29uc29sZS5jICAgICAgICAgICAgICAgICAgfCAgICA4ICsrKystLS0tCiBk
cml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvbWFpbi5jIHwgICAgOCArKysr
LS0tLQogZHJpdmVycy9zY3NpL3ZpcnRpb19zY3NpLmMgICAgICAgICAgICAgICAgICAgICB8ICAg
IDggKysrKy0tLS0KIGRyaXZlcnMvdXNiL2dhZGdldC9sZWdhY3kvaW5vZGUuYyAgICAgICAgICAg
ICAgfCAgICA4ICsrKystLS0tCiBkcml2ZXJzL3VzYi9nYWRnZXQvbGVnYWN5L3NlcmlhbC5jICAg
ICAgICAgICAgIHwgICAxMCArKysrKy0tLS0tCiBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2R1bW15
X2hjZC5jICAgICAgICAgICAgIHwgICAgOCArKysrLS0tLQogZHJpdmVycy91c2IvdXNiaXAvdnVk
Y19tYWluLmMgICAgICAgICAgICAgICAgICB8ICAgIDggKysrKy0tLS0KIG5ldC9pcHY0L25ldGZp
bHRlci9uZl9uYXRfaDMyMy5jICAgICAgICAgICAgICAgfCAgICA4ICsrKystLS0tCiAxNSBmaWxl
cyBjaGFuZ2VkLCA2MSBpbnNlcnRpb25zKCspLCA2MSBkZWxldGlvbnMoLSkKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

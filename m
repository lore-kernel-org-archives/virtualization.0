Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3AAC433EF
	for <virtualization@archiver.kernel.org>; Wed, 16 Mar 2022 19:21:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A05841821;
	Wed, 16 Mar 2022 19:21:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z6TWPfxeeth1; Wed, 16 Mar 2022 19:21:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 11B94417EF;
	Wed, 16 Mar 2022 19:21:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6743C0012;
	Wed, 16 Mar 2022 19:21:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65E44C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 19:21:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 44B48611C6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 19:21:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZIk-JGRsR8WZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 19:21:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 90C3A61213
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 19:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=4Krw3MostSzdRmJotMI0a/aFHrz6hD4Rnz4KlkBsZsY=; b=oMmN0YOyCxbwsqUbjdCoYoeLS5
 xwOMYvr9c6y0ZD0gLE9DMUnynweLItGGubfTLvG/AFTS8gDdpV6qbKOe2/SN3s2MVuCKG2ip8Mj1T
 daPYsOGmw7rRzY22M54r0qxbz7gAzmEjzHxFdcWBVn37bavK9d81on5K0p1gEE5WIrLXqWY8/fU6M
 s5P/mifVEcH7CseJqbey8V+DTjHnfTd9wcLrhUE4NbrJGroreYsn7JZe2n7d0wMy7AotAiFE9ZHGk
 8JL0YSuhRL0OVQ5l3GWEQSBBUdGvXVahxlykI44NQpLaQo/Se64NnCywaP3JRAx3A9pSa/0AcvqOF
 CO5qvuzA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUZC5-00EArp-Jb; Wed, 16 Mar 2022 19:20:25 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] usb: gadget: eliminate anonymous module_init & module_exit
Date: Wed, 16 Mar 2022 12:20:07 -0700
Message-Id: <20220316192010.19001-7-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220316192010.19001-1-rdunlap@infradead.org>
References: <20220316192010.19001-1-rdunlap@infradead.org>
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

RWxpbWluYXRlIGFub255bW91cyBtb2R1bGVfaW5pdCgpIGFuZCBtb2R1bGVfZXhpdCgpLCB3aGlj
aCBjYW4gbGVhZCB0bwpjb25mdXNpb24gb3IgYW1iaWd1aXR5IHdoZW4gcmVhZGluZyBTeXN0ZW0u
bWFwLCBjcmFzaGVzL29vcHMvYnVncywKb3IgYW4gaW5pdGNhbGxfZGVidWcgbG9nLgoKR2l2ZSBl
YWNoIG9mIHRoZXNlIGluaXQgYW5kIGV4aXQgZnVuY3Rpb25zIHVuaXF1ZSBkcml2ZXItc3BlY2lm
aWMKbmFtZXMgdG8gZWxpbWluYXRlIHRoZSBhbm9ueW1vdXMgbmFtZXMuCgpFeGFtcGxlIDE6IChT
eXN0ZW0ubWFwKQogZmZmZmZmZmY4MzJmYzc4YyB0IGluaXQKIGZmZmZmZmZmODMyZmM3OWUgdCBp
bml0CiBmZmZmZmZmZjgzMmZjOGY4IHQgaW5pdAoKRXhhbXBsZSAyOiAoaW5pdGNhbGxfZGVidWcg
bG9nKQogY2FsbGluZyAgaW5pdCsweDAvMHgxMiBAIDEKIGluaXRjYWxsIGluaXQrMHgwLzB4MTIg
cmV0dXJuZWQgMCBhZnRlciAxNSB1c2VjcwogY2FsbGluZyAgaW5pdCsweDAvMHg2MCBAIDEKIGlu
aXRjYWxsIGluaXQrMHgwLzB4NjAgcmV0dXJuZWQgMCBhZnRlciAyIHVzZWNzCiBjYWxsaW5nICBp
bml0KzB4MC8weDlhIEAgMQogaW5pdGNhbGwgaW5pdCsweDAvMHg5YSByZXR1cm5lZCAwIGFmdGVy
IDc0IHVzZWNzCgpGaXhlczogYmQyNWExNGVkYjc1ICgidXNiOiBnYWRnZXQ6IGxlZ2FjeS9zZXJp
YWw6IGFsbG93IGR5bmFtaWMgcmVtb3ZhbCIpCkZpeGVzOiA3YmI1ZWE1NGJlNDcgKCJ1c2IgZ2Fk
Z2V0IHNlcmlhbDogdXNlIGNvbXBvc2l0ZSBnYWRnZXQgZnJhbWV3b3JrIikKRml4ZXM6IDFkYTE3
N2U0YzNmNCAoIkxpbnV4LTIuNi4xMi1yYzIiKQpTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAg
PHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4KQ2M6IEZlbGlwZSBCYWxiaSA8ZmVsaXBlLmJhbGJpQGxp
bnV4LmludGVsLmNvbT4KQ2M6IE1pY2hhxYIgTWlyb3PFgmF3IDxtaXJxLWxpbnV4QHJlcmUucW1x
bS5wbD4KQ2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+
CkNjOiBTZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9yIDxiaWdlYXN5QGxpbnV0cm9uaXguZGU+CkNj
OiBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnCi0tLQogZHJpdmVycy91c2IvZ2FkZ2V0L2xlZ2Fj
eS9pbm9kZS5jICB8ICAgIDggKysrKy0tLS0KIGRyaXZlcnMvdXNiL2dhZGdldC9sZWdhY3kvc2Vy
aWFsLmMgfCAgIDEwICsrKysrLS0tLS0KIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvZHVtbXlfaGNk
LmMgfCAgICA4ICsrKystLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEz
IGRlbGV0aW9ucygtKQoKLS0tIGxueC01MTctcmM4Lm9yaWcvZHJpdmVycy91c2IvZ2FkZ2V0L2xl
Z2FjeS9zZXJpYWwuYworKysgbG54LTUxNy1yYzgvZHJpdmVycy91c2IvZ2FkZ2V0L2xlZ2FjeS9z
ZXJpYWwuYwpAQCAtMjczLDcgKzI3Myw3IEBAIHN0YXRpYyBzdHJ1Y3QgdXNiX2NvbXBvc2l0ZV9k
cml2ZXIgZ3NlcmkKIHN0YXRpYyBpbnQgc3dpdGNoX2dzZXJpYWxfZW5hYmxlKGJvb2wgZG9fZW5h
YmxlKQogewogCWlmICghc2VyaWFsX2NvbmZpZ19kcml2ZXIubGFiZWwpCi0JCS8qIGluaXQoKSB3
YXMgbm90IGNhbGxlZCwgeWV0ICovCisJCS8qIGdzZXJpYWxfaW5pdCgpIHdhcyBub3QgY2FsbGVk
LCB5ZXQgKi8KIAkJcmV0dXJuIDA7CiAKIAlpZiAoZG9fZW5hYmxlKQpAQCAtMjgzLDcgKzI4Myw3
IEBAIHN0YXRpYyBpbnQgc3dpdGNoX2dzZXJpYWxfZW5hYmxlKGJvb2wgZG8KIAlyZXR1cm4gMDsK
IH0KIAotc3RhdGljIGludCBfX2luaXQgaW5pdCh2b2lkKQorc3RhdGljIGludCBfX2luaXQgZ3Nl
cmlhbF9pbml0KHZvaWQpCiB7CiAJLyogV2UgKmNvdWxkKiBleHBvcnQgdHdvIGNvbmZpZ3M7IHRo
YXQnZCBiZSBtdWNoIGNsZWFuZXIuLi4KIAkgKiBidXQgbmVpdGhlciBvZiB0aGVzZSBwcm9kdWN0
IElEcyB3YXMgZGVmaW5lZCB0aGF0IHdheS4KQEAgLTMxNCwxMSArMzE0LDExIEBAIHN0YXRpYyBp
bnQgX19pbml0IGluaXQodm9pZCkKIAogCXJldHVybiB1c2JfY29tcG9zaXRlX3Byb2JlKCZnc2Vy
aWFsX2RyaXZlcik7CiB9Ci1tb2R1bGVfaW5pdChpbml0KTsKK21vZHVsZV9pbml0KGdzZXJpYWxf
aW5pdCk7CiAKLXN0YXRpYyB2b2lkIF9fZXhpdCBjbGVhbnVwKHZvaWQpCitzdGF0aWMgdm9pZCBf
X2V4aXQgZ3NlcmlhbF9jbGVhbnVwKHZvaWQpCiB7CiAJaWYgKGVuYWJsZSkKIAkJdXNiX2NvbXBv
c2l0ZV91bnJlZ2lzdGVyKCZnc2VyaWFsX2RyaXZlcik7CiB9Ci1tb2R1bGVfZXhpdChjbGVhbnVw
KTsKK21vZHVsZV9leGl0KGdzZXJpYWxfY2xlYW51cCk7Ci0tLSBsbngtNTE3LXJjOC5vcmlnL2Ry
aXZlcnMvdXNiL2dhZGdldC91ZGMvZHVtbXlfaGNkLmMKKysrIGxueC01MTctcmM4L2RyaXZlcnMv
dXNiL2dhZGdldC91ZGMvZHVtbXlfaGNkLmMKQEAgLTI3NjUsNyArMjc2NSw3IEBAIHN0YXRpYyBz
dHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGR1bW15X2hjZF8KIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICp0aGVfdWRjX3BkZXZbTUFYX05VTV9VRENdOwogc3RhdGljIHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnRoZV9oY2RfcGRldltNQVhfTlVNX1VEQ107CiAKLXN0YXRpYyBpbnQgX19pbml0
IGluaXQodm9pZCkKK3N0YXRpYyBpbnQgX19pbml0IGR1bW15X2hjZF9pbml0KHZvaWQpCiB7CiAJ
aW50CXJldHZhbCA9IC1FTk9NRU07CiAJaW50CWk7CkBAIC0yODg3LDkgKzI4ODcsOSBAQCBlcnJf
YWxsb2NfdWRjOgogCQlwbGF0Zm9ybV9kZXZpY2VfcHV0KHRoZV9oY2RfcGRldltpXSk7CiAJcmV0
dXJuIHJldHZhbDsKIH0KLW1vZHVsZV9pbml0KGluaXQpOworbW9kdWxlX2luaXQoZHVtbXlfaGNk
X2luaXQpOwogCi1zdGF0aWMgdm9pZCBfX2V4aXQgY2xlYW51cCh2b2lkKQorc3RhdGljIHZvaWQg
X19leGl0IGR1bW15X2hjZF9jbGVhbnVwKHZvaWQpCiB7CiAJaW50IGk7CiAKQEAgLTI5MDUsNCAr
MjkwNSw0IEBAIHN0YXRpYyB2b2lkIF9fZXhpdCBjbGVhbnVwKHZvaWQpCiAJcGxhdGZvcm1fZHJp
dmVyX3VucmVnaXN0ZXIoJmR1bW15X3VkY19kcml2ZXIpOwogCXBsYXRmb3JtX2RyaXZlcl91bnJl
Z2lzdGVyKCZkdW1teV9oY2RfZHJpdmVyKTsKIH0KLW1vZHVsZV9leGl0KGNsZWFudXApOworbW9k
dWxlX2V4aXQoZHVtbXlfaGNkX2NsZWFudXApOwotLS0gbG54LTUxNy1yYzgub3JpZy9kcml2ZXJz
L3VzYi9nYWRnZXQvbGVnYWN5L2lub2RlLmMKKysrIGxueC01MTctcmM4L2RyaXZlcnMvdXNiL2dh
ZGdldC9sZWdhY3kvaW5vZGUuYwpAQCAtMjEwMSw3ICsyMTAxLDcgQEAgTU9EVUxFX0FMSUFTX0ZT
KCJnYWRnZXRmcyIpOwogCiAvKi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0qLwogCi1zdGF0aWMgaW50IF9faW5pdCBp
bml0ICh2b2lkKQorc3RhdGljIGludCBfX2luaXQgZ2FkZ2V0ZnNfaW5pdCAodm9pZCkKIHsKIAlp
bnQgc3RhdHVzOwogCkBAIC0yMTExLDEyICsyMTExLDEyIEBAIHN0YXRpYyBpbnQgX19pbml0IGlu
aXQgKHZvaWQpCiAJCQlzaG9ydG5hbWUsIGRyaXZlcl9kZXNjKTsKIAlyZXR1cm4gc3RhdHVzOwog
fQotbW9kdWxlX2luaXQgKGluaXQpOworbW9kdWxlX2luaXQgKGdhZGdldGZzX2luaXQpOwogCi1z
dGF0aWMgdm9pZCBfX2V4aXQgY2xlYW51cCAodm9pZCkKK3N0YXRpYyB2b2lkIF9fZXhpdCBnYWRn
ZXRmc19jbGVhbnVwICh2b2lkKQogewogCXByX2RlYnVnICgidW5yZWdpc3RlciAlc1xuIiwgc2hv
cnRuYW1lKTsKIAl1bnJlZ2lzdGVyX2ZpbGVzeXN0ZW0gKCZnYWRnZXRmc190eXBlKTsKIH0KLW1v
ZHVsZV9leGl0IChjbGVhbnVwKTsKK21vZHVsZV9leGl0IChnYWRnZXRmc19jbGVhbnVwKTsKIApf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=

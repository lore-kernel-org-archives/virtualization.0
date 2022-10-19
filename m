Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94CDC4332F
	for <virtualization@archiver.kernel.org>; Wed, 19 Oct 2022 17:09:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 273A741C4F;
	Wed, 19 Oct 2022 17:09:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 273A741C4F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=dkim header.b=TEqEzpVx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7oq4gDu0SRkc; Wed, 19 Oct 2022 17:09:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6D7C441D27;
	Wed, 19 Oct 2022 17:09:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6D7C441D27
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26417C0032;
	Wed, 19 Oct 2022 17:09:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B33D2C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 17:09:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7603D40DC2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 17:09:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7603D40DC2
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de
 header.a=rsa-sha256 header.s=dkim header.b=TEqEzpVx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HXVGMW5IayY1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 17:09:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0F3F64023B
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F3F64023B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 17:09:43 +0000 (UTC)
Received: from zn.tnic (p200300ea9733e7c5329c23fffea6a903.dip0.t-ipconnect.de
 [IPv6:2003:ea:9733:e7c5:329c:23ff:fea6:a903])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D06B41EC06F6;
 Wed, 19 Oct 2022 18:59:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1666198789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:in-reply-to:
 references; bh=wfzcVssgEajdu3Qp/ntlN+Oqmn9PoGR/l9r0yknqTb8=;
 b=TEqEzpVxA7DXX33Wbq7ud/RduEzU+tJ2UgxwtF6X0o5cy6M04a65q/PD9Rou4opREQp73F
 grdXlwbkGxw+K0xnU9hvK1ObPovjBgTE5QgguZg3iD1pFvUO6qO7ZpKwbSNFeEoGvpzvaQ
 CXfFkU5VEJZsmg1ujeRN/SijAmg6FgQ=
Date: Wed, 19 Oct 2022 18:59:45 +0200
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH x86/core] x86/paravirt: Fix a !PARAVIRT build warning
Message-ID: <Y1AtAXM8YjtBm2cj@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org
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

SGksCgp0aGlzIGdvZXMgb250b3Agb2YgeDg2L2NvcmUgYXMgdGhlIGlzc3VlIGlzIGNhdXNlZCBi
eSBvbmUgb2YgdGhlCmluY2x1ZGVzIGluIGNhbGx0aHVua3MuYyB0aGVyZS4KClRoeC4KCi0tLQpG
cm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQHN1c2UuZGU+CgpGaXgKCiAgLi9pbmNsdWRlL3RyYWNl
L2V2ZW50cy94ZW4uaDoyODozMTogd2FybmluZzog4oCYZW51bSBwYXJhdmlydF9sYXp5X21vZGXi
gJkgXAogICAgZGVjbGFyZWQgaW5zaWRlIHBhcmFtZXRlciBsaXN0IHdpbGwgbm90IGJlIHZpc2li
bGUgb3V0c2lkZSBvZiB0aGlzIGRlZmluaXRpb24gb3IgZGVjbGFyYXRpb24KCndoaWNoIHR1cm5z
IGludG8gYSBidWlsZCBlcnJvcjoKCiAgLi9pbmNsdWRlL3RyYWNlL2V2ZW50cy94ZW4uaDoyODo1
MDogZXJyb3I6IHBhcmFtZXRlciAxICjigJhtb2Rl4oCZKSBoYXMgaW5jb21wbGV0ZSB0eXBlCiAg
ICAgMjggfCAgICAgICAgICAgICAgICAgVFBfUFJPVE8oZW51bSBwYXJhdmlydF9sYXp5X21vZGUg
bW9kZSksIFwKCmR1ZSB0byBlbnVtIHBhcmF2aXJ0X2xhenlfbW9kZSBiZWluZyB2aXNpYmxlIG9u
bHkgdW5kZXIgQ09ORklHX1BBUkFWSVJULgpKdXN0IHB1bGwgaXQgdXAgd2hlcmUgaXQgaXMgdW5j
b25kaXRpb25hbGx5IHZpc2libGUuCgpTaWduZWQtb2ZmLWJ5OiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QHN1c2UuZGU+Ci0tLQogYXJjaC94ODYvaW5jbHVkZS9hc20vcGFyYXZpcnRfdHlwZXMuaCB8IDE0
ICsrKysrKystLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA3IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BhcmF2aXJ0X3R5cGVz
LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wYXJhdmlydF90eXBlcy5oCmluZGV4IGUxMzdkOTQx
MjEyMy4uMjdjNjkyNzkxYjdlIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wYXJh
dmlydF90eXBlcy5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BhcmF2aXJ0X3R5cGVzLmgK
QEAgLTksNiArOSwxMyBAQCBzdHJ1Y3QgcGFyYXZpcnRfcGF0Y2hfc2l0ZSB7CiAJdTggdHlwZTsJ
CS8qIHR5cGUgb2YgdGhpcyBpbnN0cnVjdGlvbiAqLwogCXU4IGxlbjsJCQkvKiBsZW5ndGggb2Yg
b3JpZ2luYWwgaW5zdHJ1Y3Rpb24gKi8KIH07CisKKy8qIExhenkgbW9kZSBmb3IgYmF0Y2hpbmcg
dXBkYXRlcyAvIGNvbnRleHQgc3dpdGNoICovCitlbnVtIHBhcmF2aXJ0X2xhenlfbW9kZSB7CisJ
UEFSQVZJUlRfTEFaWV9OT05FLAorCVBBUkFWSVJUX0xBWllfTU1VLAorCVBBUkFWSVJUX0xBWllf
Q1BVLAorfTsKICNlbmRpZgogCiAjaWZkZWYgQ09ORklHX1BBUkFWSVJUCkBAIC01ODIsMTMgKzU4
OSw2IEBAIGludCBwYXJhdmlydF9kaXNhYmxlX2lvc3BhY2Uodm9pZCk7CiAJX19QVk9QX1ZDQUxM
KG9wLCBQVk9QX0NBTExfQVJHMShhcmcxKSwgUFZPUF9DQUxMX0FSRzIoYXJnMiksCVwKIAkJICAg
ICBQVk9QX0NBTExfQVJHMyhhcmczKSwgUFZPUF9DQUxMX0FSRzQoYXJnNCkpCiAKLS8qIExhenkg
bW9kZSBmb3IgYmF0Y2hpbmcgdXBkYXRlcyAvIGNvbnRleHQgc3dpdGNoICovCi1lbnVtIHBhcmF2
aXJ0X2xhenlfbW9kZSB7Ci0JUEFSQVZJUlRfTEFaWV9OT05FLAotCVBBUkFWSVJUX0xBWllfTU1V
LAotCVBBUkFWSVJUX0xBWllfQ1BVLAotfTsKLQogZW51bSBwYXJhdmlydF9sYXp5X21vZGUgcGFy
YXZpcnRfZ2V0X2xhenlfbW9kZSh2b2lkKTsKIHZvaWQgcGFyYXZpcnRfc3RhcnRfY29udGV4dF9z
d2l0Y2goc3RydWN0IHRhc2tfc3RydWN0ICpwcmV2KTsKIHZvaWQgcGFyYXZpcnRfZW5kX2NvbnRl
eHRfc3dpdGNoKHN0cnVjdCB0YXNrX3N0cnVjdCAqbmV4dCk7Ci0tIAoyLjM1LjEKCgotLSAKUmVn
YXJkcy9HcnVzcywKICAgIEJvcmlzLgoKaHR0cHM6Ly9wZW9wbGUua2VybmVsLm9yZy90Z2x4L25v
dGVzLWFib3V0LW5ldGlxdWV0dGUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

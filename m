Return-Path: <SRS0=Buhk=PC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20D4C433F5
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 15:21:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C91761163
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 15:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C91761163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 185E1402A8;
	Thu, 14 Oct 2021 15:21:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KaAW2w0fwVWy; Thu, 14 Oct 2021 15:21:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7E54040134;
	Thu, 14 Oct 2021 15:21:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56A3CC000F;
	Thu, 14 Oct 2021 15:21:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3C26C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 15:20:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B1763402A8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 15:20:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zsqLSNCY_fYC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 15:20:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 826B940134
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 15:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634224856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tOTKFFGtjip5ZWj15JuU+YQ9cEjBP5TceDwsinyFy6Q=;
 b=HC0Q9p+rL8240Dd6auZTPrrxTUSjyN0rks76EhPyZuOvdwKNAhXcELFVwgya0ctiD7Qnhb
 P1SsORjH7gf9ao7yU6XPgcqeVFyojDPkxeD32P1wurKtFQQIU5eqowD3tWWwslJP763D0r
 Yl3pcgz7hSrT6yWU4JSFx364w7eZLFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-uVLmyzpnMvOJJ5Lw9uSMMA-1; Thu, 14 Oct 2021 11:20:53 -0400
X-MC-Unique: uVLmyzpnMvOJJ5Lw9uSMMA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 101AA1922961;
 Thu, 14 Oct 2021 15:20:52 +0000 (UTC)
Received: from steredhat.redhat.com (unknown [10.39.194.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF7945D6B1;
 Thu, 14 Oct 2021 15:20:46 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH net] vsock_diag_test: remove free_sock_stat() call in
 test_no_sockets
Date: Thu, 14 Oct 2021 17:20:45 +0200
Message-Id: <20211014152045.173872-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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

SW4gYHRlc3Rfbm9fc29ja2V0c2Agd2UgZG9uJ3QgZXhwZWN0IGFueSBzb2NrZXRzLCBpbmRlZWQK
Y2hlY2tfbm9fc29ja2V0cygpIHByaW50cyBhbiBlcnJvciBhbmQgZXhpdHMgaWYgYHNvY2tldHNg
IGxpc3QgaXMKbm90IGVtcHR5LCBzbyBmcmVlX3NvY2tfc3RhdCgpIGNhbGwgaXMgdW5uZWNlc3Nh
cnkgc2luY2UgaXQgd291bGQKb25seSBiZSBjYWxsZWQgd2hlbiB0aGUgYHNvY2tldHNgIGxpc3Qg
aXMgZW1wdHkuCgpUaGlzIHdhcyBkaXNjb3ZlcmVkIGJ5IGEgc3RyYW5nZSB3YXJuaW5nIHByaW50
ZWQgYnkgZ2NjIHYxMS4yLjE6CiAgSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4uLy4uL2luY2x1ZGUv
bGludXgvbGlzdC5oOjcsCiAgICAgICAgICAgICAgICAgICBmcm9tIHZzb2NrX2RpYWdfdGVzdC5j
OjE4OgogIHZzb2NrX2RpYWdfdGVzdC5jOiBJbiBmdW5jdGlvbiDigJh0ZXN0X25vX3NvY2tldHPi
gJk6CiAgLi4vLi4vaW5jbHVkZS9saW51eC9rZXJuZWwuaDozNTo0NTogZXJyb3I6IGFycmF5IHN1
YnNjcmlwdCDigJhzdHJ1Y3QgdnNvY2tfc3RhdFswXeKAmSBpcyBwYXJ0bHkgb3V0c2lkZSBhcnJh
eSBib3VuZAogIHMgb2Yg4oCYc3RydWN0IGxpc3RfaGVhZFsxXeKAmSBbLVdlcnJvcj1hcnJheS1i
b3VuZHNdCiAgICAgMzUgfCAgICAgICAgIGNvbnN0IHR5cGVvZigoKHR5cGUgKikwKS0+bWVtYmVy
KSAqIF9fbXB0ciA9IChwdHIpOyAgICAgXAogICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBefn5+fn4KICAuLi8uLi9pbmNsdWRlL2xpbnV4L2xpc3Qu
aDozNTI6OTogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmGNvbnRhaW5lcl9vZuKAmQog
ICAgMzUyIHwgICAgICAgICBjb250YWluZXJfb2YocHRyLCB0eXBlLCBtZW1iZXIpCiAgICAgICAg
fCAgICAgICAgIF5+fn5+fn5+fn5+fgogIC4uLy4uL2luY2x1ZGUvbGludXgvbGlzdC5oOjM5Mzo5
OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYbGlzdF9lbnRyeeKAmQogICAgMzkzIHwg
ICAgICAgICBsaXN0X2VudHJ5KChwb3MpLT5tZW1iZXIubmV4dCwgdHlwZW9mKCoocG9zKSksIG1l
bWJlcikKICAgICAgICB8ICAgICAgICAgXn5+fn5+fn5+fgogIC4uLy4uL2luY2x1ZGUvbGludXgv
bGlzdC5oOjUyMjoyMTogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmGxpc3RfbmV4dF9l
bnRyeeKAmQogICAgNTIyIHwgICAgICAgICAgICAgICAgIG4gPSBsaXN0X25leHRfZW50cnkocG9z
LCBtZW1iZXIpOyAgICAgICAgICAgICAgICAgICAgICAgXAogICAgICAgIHwgICAgICAgICAgICAg
ICAgICAgICBefn5+fn5+fn5+fn5+fn4KICB2c29ja19kaWFnX3Rlc3QuYzozMjU6OTogbm90ZTog
aW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmGxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZeKAmQogICAg
MzI1IHwgICAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoc3QsIG5leHQsIHNvY2tldHMs
IGxpc3QpIHsKICAgICAgICB8ICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CiAgSW4g
ZmlsZSBpbmNsdWRlZCBmcm9tIHZzb2NrX2RpYWdfdGVzdC5jOjE4OgogIHZzb2NrX2RpYWdfdGVz
dC5jOjMzMzoxOTogbm90ZTogd2hpbGUgcmVmZXJlbmNpbmcg4oCYc29ja2V0c+KAmQogICAgMzMz
IHwgICAgICAgICBMSVNUX0hFQUQoc29ja2V0cyk7CiAgICAgICAgfCAgICAgICAgICAgICAgICAg
ICBefn5+fn5+CiAgLi4vLi4vaW5jbHVkZS9saW51eC9saXN0Lmg6MjM6MjY6IG5vdGU6IGluIGRl
ZmluaXRpb24gb2YgbWFjcm8g4oCYTElTVF9IRUFE4oCZCiAgICAgMjMgfCAgICAgICAgIHN0cnVj
dCBsaXN0X2hlYWQgbmFtZSA9IExJU1RfSEVBRF9JTklUKG5hbWUpCgpJdCBzZWVtcyByZWxhdGVk
IHRvIHNvbWUgY29tcGlsZXIgb3B0aW1pemF0aW9uIGFuZCBhc3N1bXB0aW9uCmFib3V0IHRoZSBl
bXB0eSBgc29ja2V0c2AgbGlzdCwgc2luY2UgdGhpcyB3YXJuaW5nIGlzIHByaW50ZWQKb25seSB3
aXRoIC0wMiBvciAtTzMuIEFsc28gcmVtb3ZpbmcgYGV4aXQoMSlgIGZyb20KY2hlY2tfbm9fc29j
a2V0cygpIG1ha2VzIHRoZSB3YXJuaW5nIGRpc2FwcGVhciBzaW5jZSBpbiB0aGF0CmNhc2UgZnJl
ZV9zb2NrX3N0YXQoKSBjYW4gYmUgcmVhY2hlZCBhbHNvIHdoZW4gdGhlIGxpc3QgaXMKbm90IGVt
cHR5LgoKUmVwb3J0ZWQtYnk6IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUBy
ZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJl
ZGhhdC5jb20+Ci0tLQogdG9vbHMvdGVzdGluZy92c29jay92c29ja19kaWFnX3Rlc3QuYyB8IDIg
LS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rl
c3RpbmcvdnNvY2svdnNvY2tfZGlhZ190ZXN0LmMgYi90b29scy90ZXN0aW5nL3Zzb2NrL3Zzb2Nr
X2RpYWdfdGVzdC5jCmluZGV4IGNlYzZmNWE3MzhlMS4uZmE5MjdhZDE2ZjhhIDEwMDY0NAotLS0g
YS90b29scy90ZXN0aW5nL3Zzb2NrL3Zzb2NrX2RpYWdfdGVzdC5jCisrKyBiL3Rvb2xzL3Rlc3Rp
bmcvdnNvY2svdnNvY2tfZGlhZ190ZXN0LmMKQEAgLTMzMiw4ICszMzIsNiBAQCBzdGF0aWMgdm9p
ZCB0ZXN0X25vX3NvY2tldHMoY29uc3Qgc3RydWN0IHRlc3Rfb3B0cyAqb3B0cykKIAlyZWFkX3Zz
b2NrX3N0YXQoJnNvY2tldHMpOwogCiAJY2hlY2tfbm9fc29ja2V0cygmc29ja2V0cyk7Ci0KLQlm
cmVlX3NvY2tfc3RhdCgmc29ja2V0cyk7CiB9CiAKIHN0YXRpYyB2b2lkIHRlc3RfbGlzdGVuX3Nv
Y2tldF9zZXJ2ZXIoY29uc3Qgc3RydWN0IHRlc3Rfb3B0cyAqb3B0cykKLS0gCjIuMzEuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u

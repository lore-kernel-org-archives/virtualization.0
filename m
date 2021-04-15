Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5987C43462
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 03:34:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62933613B7
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 03:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62933613B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 171876082F;
	Thu, 15 Apr 2021 03:34:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JcXIKzAdTIh2; Thu, 15 Apr 2021 03:34:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B103606FF;
	Thu, 15 Apr 2021 03:34:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35909C000C;
	Thu, 15 Apr 2021 03:34:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96F66C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 03:34:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6A421402E9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 03:34:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jtFdzd_zZ97K
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 03:34:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2EF87401F4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 03:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618457686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5RUei5yo3a+NRHkJr+JjC5QOk4NX0VQ98MyFYxpFYQQ=;
 b=Pf7k85aCjxR6vn8KTXFlZX1WA9yDM/9wQS3sLOQPnNzNK5wHdsrG7m75lRuAZF/hZPf/Lu
 6e6MN726A7mtw36oydquuyUGzCVta+PLgbXonLbinQ7FvXHHOmsRYOCWfhFpznIepZ1di6
 CyZ9svs/SDk7DvQLCZkY5Medk3CMNk0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-yheEFGkTNwWNrW0mXdH1EA-1; Wed, 14 Apr 2021 23:34:45 -0400
X-MC-Unique: yheEFGkTNwWNrW0mXdH1EA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9135A189C448;
 Thu, 15 Apr 2021 03:34:43 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-220.pek2.redhat.com
 [10.72.13.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE57A5D71F;
 Thu, 15 Apr 2021 03:34:36 +0000 (UTC)
Subject: Re: [PATCH 2/3] vDPA/ifcvf: enable Intel C5000X-PL virtio-block for
 vDPA
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, lulu@redhat.com,
 leonro@nvidia.com
References: <20210414091832.5132-1-lingshan.zhu@intel.com>
 <20210414091832.5132-3-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <54839b05-78d2-8edf-317c-372f0ecda024@redhat.com>
Date: Thu, 15 Apr 2021 11:34:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210414091832.5132-3-lingshan.zhu@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNC8xNCDPws7nNToxOCwgWmh1IExpbmdzaGFuINC0tcA6Cj4gVGhpcyBjb21taXQg
ZW5hYmxlZCBJbnRlbCBGUEdBIFNtYXJ0TklDIEM1MDAwWC1QTCB2aXJ0aW8tYmxvY2sKPiBmb3Ig
dkRQQS4KPgo+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVs
LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmggfCAxNyArKysr
KysrKysrKysrKysrLQo+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8IDEwICsr
KysrKysrKy0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIGIv
ZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+IGluZGV4IDFjMDRjZDI1NmZhNy4uOGI0
MDM1MjJiZjA2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgK
PiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4gQEAgLTE1LDYgKzE1LDcg
QEAKPiAgICNpbmNsdWRlIDxsaW51eC9wY2lfcmVncy5oPgo+ICAgI2luY2x1ZGUgPGxpbnV4L3Zk
cGEuaD4KPiAgICNpbmNsdWRlIDx1YXBpL2xpbnV4L3ZpcnRpb19uZXQuaD4KPiArI2luY2x1ZGUg
PHVhcGkvbGludXgvdmlydGlvX2Jsay5oPgo+ICAgI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlv
X2NvbmZpZy5oPgo+ICAgI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX3BjaS5oPgo+ICAgCj4g
QEAgLTI4LDcgKzI5LDEyIEBACj4gICAjZGVmaW5lIEM1MDAwWF9QTF9TVUJTWVNfVkVORE9SX0lE
CTB4ODA4Ngo+ICAgI2RlZmluZSBDNTAwMFhfUExfU1VCU1lTX0RFVklDRV9JRAkweDAwMDEKPiAg
IAo+IC0jZGVmaW5lIElGQ1ZGX1NVUFBPUlRFRF9GRUFUVVJFUyBcCj4gKyNkZWZpbmUgQzUwMDBY
X1BMX0JMS19WRU5ET1JfSUQJCTB4MUFGNAo+ICsjZGVmaW5lIEM1MDAwWF9QTF9CTEtfREVWSUNF
X0lECQkweDEwMDEKPiArI2RlZmluZSBDNTAwMFhfUExfQkxLX1NVQlNZU19WRU5ET1JfSUQJMHg4
MDg2Cj4gKyNkZWZpbmUgQzUwMDBYX1BMX0JMS19TVUJTWVNfREVWSUNFX0lECTB4MDAwMgo+ICsK
PiArI2RlZmluZSBJRkNWRl9ORVRfU1VQUE9SVEVEX0ZFQVRVUkVTIFwKPiAgIAkJKCgxVUxMIDw8
IFZJUlRJT19ORVRfRl9NQUMpCQkJfCBcCj4gICAJCSAoMVVMTCA8PCBWSVJUSU9fRl9BTllfTEFZ
T1VUKQkJCXwgXAo+ICAgCQkgKDFVTEwgPDwgVklSVElPX0ZfVkVSU0lPTl8xKQkJCXwgXAo+IEBA
IC0zNyw2ICs0MywxNSBAQAo+ICAgCQkgKDFVTEwgPDwgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JN
KQkJfCBcCj4gICAJCSAoMVVMTCA8PCBWSVJUSU9fTkVUX0ZfTVJHX1JYQlVGKSkKPiAgIAo+ICsj
ZGVmaW5lIElGQ1ZGX0JMS19TVVBQT1JURURfRkVBVFVSRVMgXAo+ICsJCSgoMVVMTCA8PCBWSVJU
SU9fQkxLX0ZfU0laRV9NQVgpCQl8IFwKPiArCQkgKDFVTEwgPDwgVklSVElPX0JMS19GX1NFR19N
QVgpCQkJfCBcCj4gKwkJICgxVUxMIDw8IFZJUlRJT19CTEtfRl9CTEtfU0laRSkJCXwgXAo+ICsJ
CSAoMVVMTCA8PCBWSVJUSU9fQkxLX0ZfVE9QT0xPR1kpCQl8IFwKPiArCQkgKDFVTEwgPDwgVklS
VElPX0JMS19GX01RKQkJCXwgXAo+ICsJCSAoMVVMTCA8PCBWSVJUSU9fRl9WRVJTSU9OXzEpCQkJ
fCBcCj4gKwkJICgxVUxMIDw8IFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSkpCgoKSSB0aGluayB3
ZSd2ZSBkaXNjdXNzZWQgdGhpcyBzb21ldGltZSBpbiB0aGUgcGFzdCBidXQgd2hhdCdzIHRoZSBy
ZWFzb24gCmZvciBzdWNoIHdoaXRlbGlzdCBjb25zaWRlciB0aGVyZSdzIGFscmVhZHkgYSBnZXRf
ZmVhdHVyZXMoKSBpbXBsZW1lbnRpb24/CgpFLmcgQW55IHJlYXNvbiB0byBibG9jayBWSVJUSU9f
QkxLX0ZfV1JJVEVfWkVST1Mgb3IgVklSVElPX0ZfUklOR19QQUNLRUQ/CgpUaGFua3MKCgo+ICsK
PiAgIC8qIE9ubHkgb25lIHF1ZXVlIHBhaXIgZm9yIG5vdy4gKi8KPiAgICNkZWZpbmUgSUZDVkZf
TUFYX1FVRVVFX1BBSVJTCTEKPiAgIAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYv
aWZjdmZfbWFpbi5jIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+IGluZGV4IDk5
YjBhNmI0YzIyNy4uOWI2YTM4Yjc5OGZhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2
Zi9pZmN2Zl9tYWluLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4g
QEAgLTE3MSw3ICsxNzEsMTEgQEAgc3RhdGljIHU2NCBpZmN2Zl92ZHBhX2dldF9mZWF0dXJlcyhz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2KQo+ICAgCXN0cnVjdCBpZmN2Zl9odyAqdmYgPSB2
ZHBhX3RvX3ZmKHZkcGFfZGV2KTsKPiAgIAl1NjQgZmVhdHVyZXM7Cj4gICAKPiAtCWZlYXR1cmVz
ID0gaWZjdmZfZ2V0X2ZlYXR1cmVzKHZmKSAmIElGQ1ZGX1NVUFBPUlRFRF9GRUFUVVJFUzsKPiAr
CWlmICh2Zi0+ZGV2X3R5cGUgPT0gVklSVElPX0lEX05FVCkKPiArCQlmZWF0dXJlcyA9IGlmY3Zm
X2dldF9mZWF0dXJlcyh2ZikgJiBJRkNWRl9ORVRfU1VQUE9SVEVEX0ZFQVRVUkVTOwo+ICsKPiAr
CWlmICh2Zi0+ZGV2X3R5cGUgPT0gVklSVElPX0lEX0JMT0NLKQo+ICsJCWZlYXR1cmVzID0gaWZj
dmZfZ2V0X2ZlYXR1cmVzKHZmKSAmIElGQ1ZGX0JMS19TVVBQT1JURURfRkVBVFVSRVM7Cj4gICAK
PiAgIAlyZXR1cm4gZmVhdHVyZXM7Cj4gICB9Cj4gQEAgLTUwOSw2ICs1MTMsMTAgQEAgc3RhdGlj
IHN0cnVjdCBwY2lfZGV2aWNlX2lkIGlmY3ZmX3BjaV9pZHNbXSA9IHsKPiAgIAkJCSBDNTAwMFhf
UExfREVWSUNFX0lELAo+ICAgCQkJIEM1MDAwWF9QTF9TVUJTWVNfVkVORE9SX0lELAo+ICAgCQkJ
IEM1MDAwWF9QTF9TVUJTWVNfREVWSUNFX0lEKSB9LAo+ICsJeyBQQ0lfREVWSUNFX1NVQihDNTAw
MFhfUExfQkxLX1ZFTkRPUl9JRCwKPiArCQkJIEM1MDAwWF9QTF9CTEtfREVWSUNFX0lELAo+ICsJ
CQkgQzUwMDBYX1BMX0JMS19TVUJTWVNfVkVORE9SX0lELAo+ICsJCQkgQzUwMDBYX1BMX0JMS19T
VUJTWVNfREVWSUNFX0lEKSB9LAo+ICAgCj4gICAJeyAwIH0sCj4gICB9OwoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

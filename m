Return-Path: <SRS0=ow7J=HD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E35C433E0
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 05:50:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70CB060C41
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 05:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CB060C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 421BC86F76;
	Mon,  1 Feb 2021 05:50:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KW9xx4FKk3k0; Mon,  1 Feb 2021 05:50:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 55EE086E6E;
	Mon,  1 Feb 2021 05:50:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 455C3C0FA7;
	Mon,  1 Feb 2021 05:50:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CD4BC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 05:50:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 439FE86E88
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 05:50:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N8CVwNjaq+Qc
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 05:50:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 48C9086E6E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 05:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612158652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PyRg2mb7fS8awqsRMxtK0XCpw5C/ARLH4lL9K+4Y9N4=;
 b=Kg9HT2XP9f7czM9gRp6Hw+D03nglrxXls3N8HOt5sqiQF4wucw8Up7iEWYFOYMqdp0Q1Hp
 qj4/rNxnYqS158dcpSs5j5ql8DLy4D2KIBxkgf2PLiB4uG5COI6BiJr7hGLWq+VoFVEs77
 X3PptNKShVCq7ErEkeRLtWFGox6r23I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-ETTtlz1bMICSMOwMQFcTKg-1; Mon, 01 Feb 2021 00:50:49 -0500
X-MC-Unique: ETTtlz1bMICSMOwMQFcTKg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 182D35B36B;
 Mon,  1 Feb 2021 05:50:48 +0000 (UTC)
Received: from [10.72.13.120] (ovpn-13-120.pek2.redhat.com [10.72.13.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31C4460C5F;
 Mon,  1 Feb 2021 05:50:37 +0000 (UTC)
Subject: Re: [PATCH RFC v2 08/10] vdpa: add vdpa simulator for block device
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20210128144127.113245-1-sgarzare@redhat.com>
 <20210128144127.113245-9-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f799046b-6c8e-7665-40ef-64b93e44a34f@redhat.com>
Date: Mon, 1 Feb 2021 13:50:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210128144127.113245-9-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjEvMS8yOCDkuIvljYgxMDo0MSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IEZy
b206IE1heCBHdXJ0b3ZveSA8bWd1cnRvdm95QG52aWRpYS5jb20+Cj4KPiBUaGlzIHdpbGwgYWxs
b3cgcnVubmluZyB2RFBBIGZvciB2aXJ0aW8gYmxvY2sgcHJvdG9jb2wuCj4KPiBTaWduZWQtb2Zm
LWJ5OiBNYXggR3VydG92b3kgPG1ndXJ0b3ZveUBudmlkaWEuY29tPgo+IFtzZ2FyemFyZTogdmFy
aW91cyBjbGVhbnVwcy9maXhlc10KPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEg
PHNnYXJ6YXJlQHJlZGhhdC5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+CgoKPiAtLS0KPiB2MjoKPiAtIHJlYmFzZWQgb24gdG9wIG9mIG90aGVyIGNoYW5n
ZXMgKGRldl9hdHRyLCBnZXRfY29uZmlnKCksIG5vdGlmeSgpLCBldGMuKQo+IC0gbWVtc2V0IHRv
IDAgdGhlIGNvbmZpZyBzdHJ1Y3R1cmUgaW4gdmRwYXNpbV9ibGtfZ2V0X2NvbmZpZygpCj4gLSB1
c2VkIHZkcGFzaW0gcG9pbnRlciBpbiB2ZHBhc2ltX2Jsa19nZXRfY29uZmlnKCkKPgo+IHYxOgo+
IC0gUmVtb3ZlZCB1bnVzZWQgaGVhZGVycwo+IC0gVXNlZCBjcHVfdG9fdmRwYXNpbSooKSB0byBz
dG9yZSBjb25maWcgZmllbGRzCj4gLSBSZXBsYWNlZCAnc2VsZWN0IFZEUEFfU0lNJyB3aXRoICdk
ZXBlbmRzIG9uIFZEUEFfU0lNJyBzaW5jZSBzZWxlY3RlZAo+ICAgIG9wdGlvbiBjYW4gbm90IGRl
cGVuZCBvbiBvdGhlciBbSmFzb25dCj4gLSBTdGFydCB3aXRoIGEgc2luZ2xlIHF1ZXVlIGZvciBu
b3cgW0phc29uXQo+IC0gQWRkIGNvbW1lbnRzIHRvIG1lbW9yeSBiYXJyaWVycwo+IC0tLQo+ICAg
ZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jIHwgMTQ1ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKwo+ICAgZHJpdmVycy92ZHBhL0tjb25maWcgICAgICAgICAgICAgICAgIHwg
ICA3ICsrCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vTWFrZWZpbGUgICAgICAgfCAgIDEgKwo+
ICAgMyBmaWxlcyBjaGFuZ2VkLCAxNTMgaW5zZXJ0aW9ucygrKQo+ICAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYwo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYyBiL2RyaXZlcnMvdmRwYS92ZHBh
X3NpbS92ZHBhX3NpbV9ibGsuYwo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAw
MDAwMDAwLi45OTlmOWNhMGI2MjgKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIvZHJpdmVycy92ZHBh
L3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jCj4gQEAgLTAsMCArMSwxNDUgQEAKPiArLy8gU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQo+ICsvKgo+ICsgKiBWRFBBIHNpbXVsYXRv
ciBmb3IgYmxvY2sgZGV2aWNlLgo+ICsgKgo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjAsIE1lbGxh
bm94IFRlY2hub2xvZ2llcy4gQWxsIHJpZ2h0cyByZXNlcnZlZC4KPiArICoKPiArICovCj4gKwo+
ICsjaW5jbHVkZSA8bGludXgvaW5pdC5oPgo+ICsjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+Cj4g
KyNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4KPiArI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPgo+
ICsjaW5jbHVkZSA8bGludXgvc2NoZWQuaD4KPiArI2luY2x1ZGUgPGxpbnV4L3ZyaW5naC5oPgo+
ICsjaW5jbHVkZSA8bGludXgvdmRwYS5oPgo+ICsjaW5jbHVkZSA8dWFwaS9saW51eC92aXJ0aW9f
YmxrLmg+Cj4gKwo+ICsjaW5jbHVkZSAidmRwYV9zaW0uaCIKPiArCj4gKyNkZWZpbmUgRFJWX1ZF
UlNJT04gICIwLjEiCj4gKyNkZWZpbmUgRFJWX0FVVEhPUiAgICJNYXggR3VydG92b3kgPG1ndXJ0
b3ZveUBudmlkaWEuY29tPiIKPiArI2RlZmluZSBEUlZfREVTQyAgICAgInZEUEEgRGV2aWNlIFNp
bXVsYXRvciBmb3IgYmxvY2sgZGV2aWNlIgo+ICsjZGVmaW5lIERSVl9MSUNFTlNFICAiR1BMIHYy
Igo+ICsKPiArI2RlZmluZSBWRFBBU0lNX0JMS19GRUFUVVJFUwkoVkRQQVNJTV9GRUFUVVJFUyB8
IFwKPiArCQkJCSAoMVVMTCA8PCBWSVJUSU9fQkxLX0ZfU0laRV9NQVgpIHwgXAo+ICsJCQkJICgx
VUxMIDw8IFZJUlRJT19CTEtfRl9TRUdfTUFYKSAgfCBcCj4gKwkJCQkgKDFVTEwgPDwgVklSVElP
X0JMS19GX0JMS19TSVpFKSB8IFwKPiArCQkJCSAoMVVMTCA8PCBWSVJUSU9fQkxLX0ZfVE9QT0xP
R1kpIHwgXAo+ICsJCQkJICgxVUxMIDw8IFZJUlRJT19CTEtfRl9NUSkpCj4gKwo+ICsjZGVmaW5l
IFZEUEFTSU1fQkxLX0NBUEFDSVRZCTB4NDAwMDAKPiArI2RlZmluZSBWRFBBU0lNX0JMS19TSVpF
X01BWAkweDEwMDAKPiArI2RlZmluZSBWRFBBU0lNX0JMS19TRUdfTUFYCTMyCj4gKyNkZWZpbmUg
VkRQQVNJTV9CTEtfVlFfTlVNCTEKPiArCj4gK3N0YXRpYyBzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNp
bV9ibGtfZGV2Owo+ICsKPiArc3RhdGljIHZvaWQgdmRwYXNpbV9ibGtfd29yayhzdHJ1Y3Qgd29y
a19zdHJ1Y3QgKndvcmspCj4gK3sKPiArCXN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltID0gY29udGFp
bmVyX29mKHdvcmssIHN0cnVjdCB2ZHBhc2ltLCB3b3JrKTsKPiArCXU4IHN0YXR1cyA9IFZJUlRJ
T19CTEtfU19PSzsKPiArCWludCBpOwo+ICsKPiArCXNwaW5fbG9jaygmdmRwYXNpbS0+bG9jayk7
Cj4gKwo+ICsJaWYgKCEodmRwYXNpbS0+c3RhdHVzICYgVklSVElPX0NPTkZJR19TX0RSSVZFUl9P
SykpCj4gKwkJZ290byBvdXQ7Cj4gKwo+ICsJZm9yIChpID0gMDsgaSA8IFZEUEFTSU1fQkxLX1ZR
X05VTTsgaSsrKSB7Cj4gKwkJc3RydWN0IHZkcGFzaW1fdmlydHF1ZXVlICp2cSA9ICZ2ZHBhc2lt
LT52cXNbaV07Cj4gKwo+ICsJCWlmICghdnEtPnJlYWR5KQo+ICsJCQljb250aW51ZTsKPiArCj4g
KwkJd2hpbGUgKHZyaW5naF9nZXRkZXNjX2lvdGxiKCZ2cS0+dnJpbmcsICZ2cS0+b3V0X2lvdiwK
PiArCQkJCQkgICAgJnZxLT5pbl9pb3YsICZ2cS0+aGVhZCwKPiArCQkJCQkgICAgR0ZQX0FUT01J
QykgPiAwKSB7Cj4gKwkJCWludCB3cml0ZTsKPiArCj4gKwkJCXZxLT5pbl9pb3YuaSA9IHZxLT5p
bl9pb3YudXNlZCAtIDE7Cj4gKwkJCXdyaXRlID0gdnJpbmdoX2lvdl9wdXNoX2lvdGxiKCZ2cS0+
dnJpbmcsICZ2cS0+aW5faW92LAo+ICsJCQkJCQkgICAgICAmc3RhdHVzLCAxKTsKPiArCQkJaWYg
KHdyaXRlIDw9IDApCj4gKwkJCQlicmVhazsKPiArCj4gKwkJCS8qIE1ha2Ugc3VyZSBkYXRhIGlz
IHdyb3RlIGJlZm9yZSBhZHZhbmNpbmcgaW5kZXggKi8KPiArCQkJc21wX3dtYigpOwo+ICsKPiAr
CQkJdnJpbmdoX2NvbXBsZXRlX2lvdGxiKCZ2cS0+dnJpbmcsIHZxLT5oZWFkLCB3cml0ZSk7Cj4g
Kwo+ICsJCQkvKiBNYWtlIHN1cmUgdXNlZCBpcyB2aXNpYmxlIGJlZm9yZSByYXNpbmcgdGhlIGlu
dGVycnVwdC4gKi8KPiArCQkJc21wX3dtYigpOwo+ICsKPiArCQkJbG9jYWxfYmhfZGlzYWJsZSgp
Owo+ICsJCQlpZiAodnJpbmdoX25lZWRfbm90aWZ5X2lvdGxiKCZ2cS0+dnJpbmcpID4gMCkKPiAr
CQkJCXZyaW5naF9ub3RpZnkoJnZxLT52cmluZyk7Cj4gKwkJCWxvY2FsX2JoX2VuYWJsZSgpOwo+
ICsJCX0KPiArCX0KPiArb3V0Ogo+ICsJc3Bpbl91bmxvY2soJnZkcGFzaW0tPmxvY2spOwo+ICt9
Cj4gKwo+ICtzdGF0aWMgdm9pZCB2ZHBhc2ltX2Jsa19nZXRfY29uZmlnKHN0cnVjdCB2ZHBhc2lt
ICp2ZHBhc2ltLCB2b2lkICpjb25maWcpCj4gK3sKPiArCXN0cnVjdCB2aXJ0aW9fYmxrX2NvbmZp
ZyAqYmxrX2NvbmZpZyA9Cj4gKwkJKHN0cnVjdCB2aXJ0aW9fYmxrX2NvbmZpZyAqKWNvbmZpZzsK
PiArCj4gKwltZW1zZXQoY29uZmlnLCAwLCBzaXplb2Yoc3RydWN0IHZpcnRpb19ibGtfY29uZmln
KSk7Cj4gKwo+ICsJYmxrX2NvbmZpZy0+Y2FwYWNpdHkgPSBjcHVfdG9fdmRwYXNpbTY0KHZkcGFz
aW0sIFZEUEFTSU1fQkxLX0NBUEFDSVRZKTsKPiArCWJsa19jb25maWctPnNpemVfbWF4ID0gY3B1
X3RvX3ZkcGFzaW0zMih2ZHBhc2ltLCBWRFBBU0lNX0JMS19TSVpFX01BWCk7Cj4gKwlibGtfY29u
ZmlnLT5zZWdfbWF4ID0gY3B1X3RvX3ZkcGFzaW0zMih2ZHBhc2ltLCBWRFBBU0lNX0JMS19TRUdf
TUFYKTsKPiArCWJsa19jb25maWctPm51bV9xdWV1ZXMgPSBjcHVfdG9fdmRwYXNpbTE2KHZkcGFz
aW0sIFZEUEFTSU1fQkxLX1ZRX05VTSk7Cj4gKwlibGtfY29uZmlnLT5taW5faW9fc2l6ZSA9IGNw
dV90b192ZHBhc2ltMTYodmRwYXNpbSwgMSk7Cj4gKwlibGtfY29uZmlnLT5vcHRfaW9fc2l6ZSA9
IGNwdV90b192ZHBhc2ltMzIodmRwYXNpbSwgMSk7Cj4gKwlibGtfY29uZmlnLT5ibGtfc2l6ZSA9
IGNwdV90b192ZHBhc2ltMzIodmRwYXNpbSwgU0VDVE9SX1NJWkUpOwo+ICt9Cj4gKwo+ICtzdGF0
aWMgaW50IF9faW5pdCB2ZHBhc2ltX2Jsa19pbml0KHZvaWQpCj4gK3sKPiArCXN0cnVjdCB2ZHBh
c2ltX2Rldl9hdHRyIGRldl9hdHRyID0ge307Cj4gKwlpbnQgcmV0Owo+ICsKPiArCWRldl9hdHRy
LmlkID0gVklSVElPX0lEX0JMT0NLOwo+ICsJZGV2X2F0dHIuc3VwcG9ydGVkX2ZlYXR1cmVzID0g
VkRQQVNJTV9CTEtfRkVBVFVSRVM7Cj4gKwlkZXZfYXR0ci5udnFzID0gVkRQQVNJTV9CTEtfVlFf
TlVNOwo+ICsJZGV2X2F0dHIuY29uZmlnX3NpemUgPSBzaXplb2Yoc3RydWN0IHZpcnRpb19ibGtf
Y29uZmlnKTsKPiArCWRldl9hdHRyLmdldF9jb25maWcgPSB2ZHBhc2ltX2Jsa19nZXRfY29uZmln
Owo+ICsJZGV2X2F0dHIud29ya19mbiA9IHZkcGFzaW1fYmxrX3dvcms7Cj4gKwlkZXZfYXR0ci5i
dWZmZXJfc2l6ZSA9IFBBR0VfU0laRTsKPiArCj4gKwl2ZHBhc2ltX2Jsa19kZXYgPSB2ZHBhc2lt
X2NyZWF0ZSgmZGV2X2F0dHIpOwo+ICsJaWYgKElTX0VSUih2ZHBhc2ltX2Jsa19kZXYpKSB7Cj4g
KwkJcmV0ID0gUFRSX0VSUih2ZHBhc2ltX2Jsa19kZXYpOwo+ICsJCWdvdG8gb3V0Owo+ICsJfQo+
ICsKPiArCXJldCA9IHZkcGFfcmVnaXN0ZXJfZGV2aWNlKCZ2ZHBhc2ltX2Jsa19kZXYtPnZkcGEp
Owo+ICsJaWYgKHJldCkKPiArCQlnb3RvIHB1dF9kZXY7Cj4gKwo+ICsJcmV0dXJuIDA7Cj4gKwo+
ICtwdXRfZGV2Ogo+ICsJcHV0X2RldmljZSgmdmRwYXNpbV9ibGtfZGV2LT52ZHBhLmRldik7Cj4g
K291dDoKPiArCXJldHVybiByZXQ7Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lkIF9fZXhpdCB2ZHBh
c2ltX2Jsa19leGl0KHZvaWQpCj4gK3sKPiArCXN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9ICZ2
ZHBhc2ltX2Jsa19kZXYtPnZkcGE7Cj4gKwo+ICsJdmRwYV91bnJlZ2lzdGVyX2RldmljZSh2ZHBh
KTsKPiArfQo+ICsKPiArbW9kdWxlX2luaXQodmRwYXNpbV9ibGtfaW5pdCkKPiArbW9kdWxlX2V4
aXQodmRwYXNpbV9ibGtfZXhpdCkKPiArCj4gK01PRFVMRV9WRVJTSU9OKERSVl9WRVJTSU9OKTsK
PiArTU9EVUxFX0xJQ0VOU0UoRFJWX0xJQ0VOU0UpOwo+ICtNT0RVTEVfQVVUSE9SKERSVl9BVVRI
T1IpOwo+ICtNT0RVTEVfREVTQ1JJUFRJT04oRFJWX0RFU0MpOwo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3ZkcGEvS2NvbmZpZyBiL2RyaXZlcnMvdmRwYS9LY29uZmlnCj4gaW5kZXggMjFhMjM1MDBm
NDMwLi5iOGJkOTJjZjA0ZjkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL0tjb25maWcKPiAr
KysgYi9kcml2ZXJzL3ZkcGEvS2NvbmZpZwo+IEBAIC0yNiw2ICsyNiwxMyBAQCBjb25maWcgVkRQ
QV9TSU1fTkVUCj4gICAJaGVscAo+ICAgCSAgdkRQQSBuZXR3b3JraW5nIGRldmljZSBzaW11bGF0
b3Igd2hpY2ggbG9vcHMgVFggdHJhZmZpYyBiYWNrIHRvIFJYLgo+ICAgCj4gK2NvbmZpZyBWRFBB
X1NJTV9CTE9DSwo+ICsJdHJpc3RhdGUgInZEUEEgc2ltdWxhdG9yIGZvciBibG9jayBkZXZpY2Ui
Cj4gKwlkZXBlbmRzIG9uIFZEUEFfU0lNCj4gKwloZWxwCj4gKwkgIHZEUEEgYmxvY2sgZGV2aWNl
IHNpbXVsYXRvciB3aGljaCB0ZXJtaW5hdGVzIElPIHJlcXVlc3QgaW4gYQo+ICsJICBtZW1vcnkg
YnVmZmVyLgo+ICsKPiAgIGNvbmZpZyBJRkNWRgo+ICAgCXRyaXN0YXRlICJJbnRlbCBJRkMgVkYg
dkRQQSBkcml2ZXIiCj4gICAJZGVwZW5kcyBvbiBQQ0lfTVNJCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmRwYS92ZHBhX3NpbS9NYWtlZmlsZSBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS9NYWtlZmls
ZQo+IGluZGV4IDc5ZDQ1MzZkMzQ3ZS4uZDQ1ODEwMzMwMmYyIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvdmRwYS92ZHBhX3NpbS9NYWtlZmlsZQo+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS9N
YWtlZmlsZQo+IEBAIC0xLDMgKzEsNCBAQAo+ICAgIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMAo+ICAgb2JqLSQoQ09ORklHX1ZEUEFfU0lNKSArPSB2ZHBhX3NpbS5vCj4gICBvYmot
JChDT05GSUdfVkRQQV9TSU1fTkVUKSArPSB2ZHBhX3NpbV9uZXQubwo+ICtvYmotJChDT05GSUdf
VkRQQV9TSU1fQkxPQ0spICs9IHZkcGFfc2ltX2Jsay5vCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

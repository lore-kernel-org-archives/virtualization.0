Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48571C4742C
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 04:10:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEF4522284
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 04:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLteW7IY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF4522284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1F16A8687A;
	Mon, 16 Nov 2020 04:10:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JcG6sMQfp5k2; Mon, 16 Nov 2020 04:10:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4CC7886776;
	Mon, 16 Nov 2020 04:10:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CEF4C0891;
	Mon, 16 Nov 2020 04:10:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F446C07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 04:10:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 133BD86776
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 04:10:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OCzTdGkh+OA8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 04:10:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BCB5786877
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 04:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605499839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hTEAoKD/DW1jYuiFVDgwGvpYgNtkJN9B1/ApILGKy6M=;
 b=BLteW7IYmCrdPzxuu2+/1AJmxYdStRVu5L89vNEeAkPMCnEIHQo3al+rm4vohtM1Yx5FlS
 HGeHF+5uoGQEz99w11edGoOjY8x1e9n51MNMt2BqNFQAG6MKBkaG11JyVtUXpk/uxbNlLc
 LbFKHZuCXFomX6TmNYZK9L1cmnko8Us=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-7KWeLV7RP16f-7DcU7t0eA-1; Sun, 15 Nov 2020 23:10:37 -0500
X-MC-Unique: 7KWeLV7RP16f-7DcU7t0eA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42A7E8030C1;
 Mon, 16 Nov 2020 04:10:36 +0000 (UTC)
Received: from [10.72.13.126] (ovpn-13-126.pek2.redhat.com [10.72.13.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 660616B8D4;
 Mon, 16 Nov 2020 04:10:21 +0000 (UTC)
Subject: Re: [PATCH RFC 04/12] vdpa: add vdpa simulator for block device
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-5-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <061b5093-ef1c-a7d8-495e-1fe338b8b097@redhat.com>
Date: Mon, 16 Nov 2020 12:10:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-5-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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

Ck9uIDIwMjAvMTEvMTMg5LiL5Y2IOTo0NywgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IEZy
b206IE1heCBHdXJ0b3ZveSA8bWd1cnRvdm95QG52aWRpYS5jb20+Cj4KPiBUaGlzIHdpbGwgYWxs
b3cgcnVubmluZyB2RFBBIGZvciB2aXJ0aW8gYmxvY2sgcHJvdG9jb2wuCj4KPiBTaWduZWQtb2Zm
LWJ5OiBNYXggR3VydG92b3kgPG1ndXJ0b3ZveUBudmlkaWEuY29tPgo+IFtzZ2FyemFyZTogdmFy
aW91cyBjbGVhbnVwcy9maXhlc10KPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEg
PHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4gLS0tCj4gdjE6Cj4gLSBSZW1vdmVkIHVudXNlZCBoZWFk
ZXJzCj4gLSBVc2VkIGNwdV90b192ZHBhc2ltKigpIHRvIHN0b3JlIGNvbmZpZyBmaWVsZHMKPiAt
IFJlcGxhY2VkICdzZWxlY3QgVkRQQV9TSU0nIHdpdGggJ2RlcGVuZHMgb24gVkRQQV9TSU0nIHNp
bmNlIHNlbGVjdGVkCj4gICAgb3B0aW9uIGNhbiBub3QgZGVwZW5kIG9uIG90aGVyIFtKYXNvbl0K
PiAtIFN0YXJ0IHdpdGggYSBzaW5nbGUgcXVldWUgZm9yIG5vdyBbSmFzb25dCj4gLSBBZGQgY29t
bWVudHMgdG8gbWVtb3J5IGJhcnJpZXJzCj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0v
dmRwYV9zaW1fYmxrLmMgfCAxMjQgKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gICBkcml2
ZXJzL3ZkcGEvS2NvbmZpZyAgICAgICAgICAgICAgICAgfCAgIDkgKysKPiAgIGRyaXZlcnMvdmRw
YS92ZHBhX3NpbS9NYWtlZmlsZSAgICAgICB8ICAgMSArCj4gICAzIGZpbGVzIGNoYW5nZWQsIDEz
NCBpbnNlcnRpb25zKCspCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy92ZHBhL3ZkcGFf
c2ltL3ZkcGFfc2ltX2Jsay5jCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2lt
L3ZkcGFfc2ltX2Jsay5jIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jCj4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAwMDAwMDAuLjM4NmRiYjJmNzEzOAo+
IC0tLSAvZGV2L251bGwKPiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxr
LmMKPiBAQCAtMCwwICsxLDEyNCBAQAo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMC1vbmx5Cj4gKy8qCj4gKyAqIFZEUEEgc2ltdWxhdG9yIGZvciBibG9jayBkZXZpY2UuCj4g
KyAqCj4gKyAqIENvcHlyaWdodCAoYykgMjAyMCwgTWVsbGFub3ggVGVjaG5vbG9naWVzLiBBbGwg
cmlnaHRzIHJlc2VydmVkLgo+ICsgKgo+ICsgKi8KPiArCj4gKyNpbmNsdWRlIDxsaW51eC9tb2R1
bGUuaD4KPiArCj4gKyNpbmNsdWRlICJ2ZHBhX3NpbS5oIgo+ICsKPiArI2RlZmluZSBWRFBBU0lN
X0JMS19GRUFUVVJFUwkoKDFVTEwgPDwgVklSVElPX0JMS19GX1NJWkVfTUFYKSB8IFwKPiArCQkJ
CSAoMVVMTCA8PCBWSVJUSU9fQkxLX0ZfU0VHX01BWCkgIHwgXAo+ICsJCQkJICgxVUxMIDw8IFZJ
UlRJT19CTEtfRl9CTEtfU0laRSkgfCBcCj4gKwkJCQkgKDFVTEwgPDwgVklSVElPX0JMS19GX1RP
UE9MT0dZKSB8IFwKPiArCQkJCSAoMVVMTCA8PCBWSVJUSU9fQkxLX0ZfTVEpKQo+ICsKPiArI2Rl
ZmluZSBWRFBBU0lNX0JMS19DQVBBQ0lUWSAweDQwMDAwCj4gKyNkZWZpbmUgVkRQQVNJTV9CTEtf
U0laRV9NQVggMHgxMDAwCj4gKyNkZWZpbmUgVkRQQVNJTV9CTEtfU0VHX01BWCAzMgo+ICsjZGVm
aW5lIFZEUEFTSU1fQkxLX1ZRX05VTSAxCj4gKwo+ICtzdGF0aWMgc3RydWN0IHZkcGFzaW0gKnZk
cGFzaW1fYmxrX2RldjsKPiArCj4gK3N0YXRpYyB2b2lkIHZkcGFzaW1fYmxrX3dvcmsoc3RydWN0
IHdvcmtfc3RydWN0ICp3b3JrKQo+ICt7Cj4gKwlzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSA9IGNv
bnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3QgdmRwYXNpbSwgd29yayk7Cj4gKwl1OCBzdGF0dXMgPSBW
SVJUSU9fQkxLX1NfT0s7Cj4gKwlpbnQgaTsKPiArCj4gKwlzcGluX2xvY2soJnZkcGFzaW0tPmxv
Y2spOwo+ICsKPiArCWlmICghKHZkcGFzaW0tPnN0YXR1cyAmIFZJUlRJT19DT05GSUdfU19EUklW
RVJfT0spKQo+ICsJCWdvdG8gb3V0Owo+ICsKPiArCWZvciAoaSA9IDA7IGkgPCBWRFBBU0lNX0JM
S19WUV9OVU07IGkrKykgewo+ICsJCXN0cnVjdCB2ZHBhc2ltX3ZpcnRxdWV1ZSAqdnEgPSAmdmRw
YXNpbS0+dnFzW2ldOwo+ICsKPiArCQlpZiAoIXZxLT5yZWFkeSkKPiArCQkJY29udGludWU7Cj4g
Kwo+ICsJCXdoaWxlICh2cmluZ2hfZ2V0ZGVzY19pb3RsYigmdnEtPnZyaW5nLCAmdnEtPmlvdiwg
JnZxLT5pb3YsCj4gKwkJCQkJICAgICZ2cS0+aGVhZCwgR0ZQX0FUT01JQykgPiAwKSB7Cj4gKwo+
ICsJCQlpbnQgd3JpdGU7Cj4gKwo+ICsJCQl2cS0+aW92LmkgPSB2cS0+aW92LnVzZWQgLSAxOwo+
ICsJCQl3cml0ZSA9IHZyaW5naF9pb3ZfcHVzaF9pb3RsYigmdnEtPnZyaW5nLCAmdnEtPmlvdiwg
JnN0YXR1cywgMSk7Cj4gKwkJCWlmICh3cml0ZSA8PSAwKQo+ICsJCQkJYnJlYWs7Cj4gKwo+ICsJ
CQkvKiBNYWtlIHN1cmUgZGF0YSBpcyB3cm90ZSBiZWZvcmUgYWR2YW5jaW5nIGluZGV4ICovCj4g
KwkJCXNtcF93bWIoKTsKPiArCj4gKwkJCXZyaW5naF9jb21wbGV0ZV9pb3RsYigmdnEtPnZyaW5n
LCB2cS0+aGVhZCwgd3JpdGUpOwo+ICsKPiArCQkJLyogTWFrZSBzdXJlIHVzZWQgaXMgdmlzaWJs
ZSBiZWZvcmUgcmFzaW5nIHRoZSBpbnRlcnJ1cHQuICovCj4gKwkJCXNtcF93bWIoKTsKPiArCj4g
KwkJCWlmICh2cmluZ2hfbmVlZF9ub3RpZnlfaW90bGIoJnZxLT52cmluZykgPiAwKQo+ICsJCQkJ
dnJpbmdoX25vdGlmeSgmdnEtPnZyaW5nKTsKCgpEbyB3ZSBpbml0aWFsaXplIHZyaC0+bm90aWZ5
IGFueXdoZXJlPyBBbmQgVGhpcyBzZWVtcyBkdXBsaWNhdGVkIHdpdGggCnRoZSBmb2xsb3dpbmcg
dnEtPmNiLgoKSSB0aGluayB0aGUgY29ycmVjdCB3YXkgaXMgdG8gaW5pdGlhbGl6ZSB2cmgtPm5v
dGlmeSBhbmQgdXNlIAp2cmluZ2hfbmVlZF9ub3RpZnlfaW90bGIoKS92cmluZ2hfbm90aWZ5KCkg
aW5zdGVhZCBvZiB0aGUgdnEtPmNiIGhlcmUuCgpBbmQgd2hpbGUgYXQgaXQsIGl0J3MgYmV0dGVy
IHRvIGNvbnZlcnQgbmV0IHNpbXVsYXRvciB0byBkbyB0aGUgc2FtZS4KClRoYW5rcwoKCj4gKwo+
ICsJCQlsb2NhbF9iaF9kaXNhYmxlKCk7Cj4gKwkJCWlmICh2cS0+Y2IpCj4gKwkJCQl2cS0+Y2Io
dnEtPnByaXZhdGUpOwo+ICsJCQlsb2NhbF9iaF9lbmFibGUoKTsKPiArCQl9Cj4gKwl9Cj4gK291
dDoKPiArCXNwaW5fdW5sb2NrKCZ2ZHBhc2ltLT5sb2NrKTsKPiArCj4gK30KPiArCj4gK3N0YXRp
YyBpbnQgX19pbml0IHZkcGFzaW1fYmxrX2luaXQodm9pZCkKPiArewo+ICsJc3RydWN0IHZkcGFz
aW1faW5pdF9hdHRyIGF0dHIgPSB7fTsKPiArCXN0cnVjdCB2aXJ0aW9fYmxrX2NvbmZpZyAqY29u
ZmlnOwo+ICsJaW50IHJldDsKPiArCj4gKwlhdHRyLmRldmljZV9pZCA9IFZJUlRJT19JRF9CTE9D
SzsKPiArCWF0dHIuZmVhdHVyZXMgPSBWRFBBU0lNX0ZFQVRVUkVTIHwgVkRQQVNJTV9CTEtfRkVB
VFVSRVM7Cj4gKwlhdHRyLndvcmtfZm4gPSB2ZHBhc2ltX2Jsa193b3JrOwo+ICsJdmRwYXNpbV9i
bGtfZGV2ID0gdmRwYXNpbV9jcmVhdGUoJmF0dHIpOwo+ICsJaWYgKElTX0VSUih2ZHBhc2ltX2Js
a19kZXYpKSB7Cj4gKwkJcmV0ID0gUFRSX0VSUih2ZHBhc2ltX2Jsa19kZXYpOwo+ICsJCWdvdG8g
b3V0Owo+ICsJfQo+ICsKPiArCWNvbmZpZyA9IChzdHJ1Y3QgdmlydGlvX2Jsa19jb25maWcgKil2
ZHBhc2ltX2Jsa19kZXYtPmNvbmZpZzsKPiArCWNvbmZpZy0+Y2FwYWNpdHkgPSBjcHVfdG9fdmRw
YXNpbTY0KHZkcGFzaW1fYmxrX2RldiwgVkRQQVNJTV9CTEtfQ0FQQUNJVFkpOwo+ICsJY29uZmln
LT5zaXplX21heCA9IGNwdV90b192ZHBhc2ltMzIodmRwYXNpbV9ibGtfZGV2LCBWRFBBU0lNX0JM
S19TSVpFX01BWCk7Cj4gKwljb25maWctPnNlZ19tYXggPSBjcHVfdG9fdmRwYXNpbTMyKHZkcGFz
aW1fYmxrX2RldiwgVkRQQVNJTV9CTEtfU0VHX01BWCk7Cj4gKwljb25maWctPm51bV9xdWV1ZXMg
PSBjcHVfdG9fdmRwYXNpbTE2KHZkcGFzaW1fYmxrX2RldiwgVkRQQVNJTV9CTEtfVlFfTlVNKTsK
PiArCWNvbmZpZy0+bWluX2lvX3NpemUgPSBjcHVfdG9fdmRwYXNpbTE2KHZkcGFzaW1fYmxrX2Rl
diwgMSk7Cj4gKwljb25maWctPm9wdF9pb19zaXplID0gY3B1X3RvX3ZkcGFzaW0zMih2ZHBhc2lt
X2Jsa19kZXYsIDEpOwo+ICsJY29uZmlnLT5ibGtfc2l6ZSA9IGNwdV90b192ZHBhc2ltMzIodmRw
YXNpbV9ibGtfZGV2LCA1MTIpOwo+ICsKPiArCXJldCA9IHZkcGFfcmVnaXN0ZXJfZGV2aWNlKCZ2
ZHBhc2ltX2Jsa19kZXYtPnZkcGEpOwo+ICsJaWYgKHJldCkKPiArCQlnb3RvIHB1dF9kZXY7Cj4g
Kwo+ICsJcmV0dXJuIDA7Cj4gKwo+ICtwdXRfZGV2Ogo+ICsJcHV0X2RldmljZSgmdmRwYXNpbV9i
bGtfZGV2LT52ZHBhLmRldik7Cj4gK291dDoKPiArCXJldHVybiByZXQ7Cj4gK30KPiArCj4gK3N0
YXRpYyB2b2lkIF9fZXhpdCB2ZHBhc2ltX2Jsa19leGl0KHZvaWQpCj4gK3sKPiArCXN0cnVjdCB2
ZHBhX2RldmljZSAqdmRwYSA9ICZ2ZHBhc2ltX2Jsa19kZXYtPnZkcGE7Cj4gKwo+ICsJdmRwYV91
bnJlZ2lzdGVyX2RldmljZSh2ZHBhKTsKPiArfQo+ICsKPiArbW9kdWxlX2luaXQodmRwYXNpbV9i
bGtfaW5pdCkKPiArbW9kdWxlX2V4aXQodmRwYXNpbV9ibGtfZXhpdCkKPiArCj4gK01PRFVMRV9W
RVJTSU9OKERSVl9WRVJTSU9OKTsKPiArTU9EVUxFX0xJQ0VOU0UoRFJWX0xJQ0VOU0UpOwo+ICtN
T0RVTEVfQVVUSE9SKCJNYXggR3VydG92b3kgPG1ndXJ0b3ZveUBudmlkaWEuY29tPiIpOwo+ICtN
T0RVTEVfREVTQ1JJUFRJT04oInZEUEEgRGV2aWNlIFNpbXVsYXRvciBmb3IgYmxvY2sgZGV2aWNl
Iik7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9LY29uZmlnIGIvZHJpdmVycy92ZHBhL0tj
b25maWcKPiBpbmRleCBmZGIxYTkyNjczNDcuLjBmYjYzMzYyY2Q1ZCAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL3ZkcGEvS2NvbmZpZwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9LY29uZmlnCj4gQEAgLTI0
LDYgKzI0LDE1IEBAIGNvbmZpZyBWRFBBX1NJTV9ORVQKPiAgIAkgIHRvIFJYLiBUaGlzIGRldmlj
ZSBpcyB1c2VkIGZvciB0ZXN0aW5nLCBwcm90b3R5cGluZyBhbmQKPiAgIAkgIGRldmVsb3BtZW50
IG9mIHZEUEEuCj4gICAKPiArY29uZmlnIFZEUEFfU0lNX0JMT0NLCj4gKwl0cmlzdGF0ZSAidkRQ
QSBzaW11bGF0b3IgZm9yIGJsb2NrIGRldmljZSIKPiArCWRlcGVuZHMgb24gVkRQQV9TSU0KPiAr
CWRlZmF1bHQgbgo+ICsJaGVscAo+ICsJICB2RFBBIGJsb2NrIGRldmljZSBzaW11bGF0b3Igd2hp
Y2ggdGVybWluYXRlcyBJTyByZXF1ZXN0IGluIGEKPiArCSAgbWVtb3J5IGJ1ZmZlci4gVGhpcyBk
ZXZpY2UgaXMgdXNlZCBmb3IgdGVzdGluZywgcHJvdG90eXBpbmcgYW5kCj4gKwkgIGRldmVsb3Bt
ZW50IG9mIHZEUEEuCj4gKwo+ICAgY29uZmlnIElGQ1ZGCj4gICAJdHJpc3RhdGUgIkludGVsIElG
QyBWRiB2RFBBIGRyaXZlciIKPiAgIAlkZXBlbmRzIG9uIFBDSV9NU0kKPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92ZHBhL3ZkcGFfc2ltL01ha2VmaWxlIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL01h
a2VmaWxlCj4gaW5kZXggNzlkNDUzNmQzNDdlLi5kNDU4MTAzMzAyZjIgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy92ZHBhL3ZkcGFfc2ltL01ha2VmaWxlCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFf
c2ltL01ha2VmaWxlCj4gQEAgLTEsMyArMSw0IEBACj4gICAjIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wCj4gICBvYmotJChDT05GSUdfVkRQQV9TSU0pICs9IHZkcGFfc2ltLm8KPiAg
IG9iai0kKENPTkZJR19WRFBBX1NJTV9ORVQpICs9IHZkcGFfc2ltX25ldC5vCj4gK29iai0kKENP
TkZJR19WRFBBX1NJTV9CTE9DSykgKz0gdmRwYV9zaW1fYmxrLm8KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

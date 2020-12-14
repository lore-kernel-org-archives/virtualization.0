Return-Path: <SRS0=0lGn=FS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCA3C4361B
	for <virtualization@archiver.kernel.org>; Mon, 14 Dec 2020 03:13:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35AA220882
	for <virtualization@archiver.kernel.org>; Mon, 14 Dec 2020 03:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35AA220882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DD17D85D52;
	Mon, 14 Dec 2020 03:13:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cpmrfD1Ee8lj; Mon, 14 Dec 2020 03:13:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4528385BFB;
	Mon, 14 Dec 2020 03:13:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B941C0893;
	Mon, 14 Dec 2020 03:13:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E67B2C013B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Dec 2020 03:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AFA262042E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Dec 2020 03:13:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bJjOiCTEJIah
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Dec 2020 03:13:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 4F381203B2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Dec 2020 03:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607915628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+9sQ3ROLDoUM3Q2YuCeuJzaGmgvYQ+sS+5UKJ5fqarw=;
 b=TRsKRce5NuojpLNK3XQPM2nsYW8ZjLWHnkgAK8q9yRk8CGkujG0cDFTGimTz+aNtBf7EyZ
 mXKetabB+yab5JNJtvkl/OVTO0/H2SpqZfpSaZAsbYbEhA83VV5DjDgBRxbYlVL3GRtXEh
 ycHG3YZEJjhojBNnQ8MMoefvTfi08p0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-5YrP6FsXNuuS7gxrQe646A-1; Sun, 13 Dec 2020 22:13:46 -0500
X-MC-Unique: 5YrP6FsXNuuS7gxrQe646A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50DBB10054FF;
 Mon, 14 Dec 2020 03:13:45 +0000 (UTC)
Received: from [10.72.13.213] (ovpn-13-213.pek2.redhat.com [10.72.13.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 13F641002382;
 Mon, 14 Dec 2020 03:13:38 +0000 (UTC)
Subject: Re: [PATCH net] vhost_net: fix high cpu load when sendmsg fails
To: wangyunjian <wangyunjian@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <1607514504-20956-1-git-send-email-wangyunjian@huawei.com>
 <20201209074832-mutt-send-email-mst@kernel.org>
 <34EFBCA9F01B0748BEB6B629CE643AE60DB61ADF@DGGEMM533-MBX.china.huawei.com>
 <f95f061c-dcac-9d56-94a0-50ef683946cd@redhat.com>
 <34EFBCA9F01B0748BEB6B629CE643AE60DB65468@DGGEMM533-MBX.china.huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c8fedd8b-8a09-8994-2ad4-133c9e6dc334@redhat.com>
Date: Mon, 14 Dec 2020 11:13:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <34EFBCA9F01B0748BEB6B629CE643AE60DB65468@DGGEMM533-MBX.china.huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Lilijun \(Jerry\)" <jerry.lilijun@huawei.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 chenchanghu <chenchanghu@huawei.com>,
 "huangbin \(J\)" <brian.huangbin@huawei.com>, xudingke <xudingke@huawei.com>
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

Ck9uIDIwMjAvMTIvMTEg5LiL5Y2IMzozNywgd2FuZ3l1bmppYW4gd3JvdGU6Cj4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tCj4+IEZyb206IEphc29uIFdhbmcgW21haWx0bzpqYXNvd2FuZ0By
ZWRoYXQuY29tXQo+PiBTZW50OiBGcmlkYXksIERlY2VtYmVyIDExLCAyMDIwIDEwOjUzIEFNCj4+
IFRvOiB3YW5neXVuamlhbiA8d2FuZ3l1bmppYW5AaHVhd2VpLmNvbT47IE1pY2hhZWwgUy4gVHNp
cmtpbgo+PiA8bXN0QHJlZGhhdC5jb20+Cj4+IENjOiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgTGlsaWp1bgo+PiAoSmVy
cnkpIDxqZXJyeS5saWxpanVuQGh1YXdlaS5jb20+OyBjaGVuY2hhbmdodSA8Y2hlbmNoYW5naHVA
aHVhd2VpLmNvbT47Cj4+IHh1ZGluZ2tlIDx4dWRpbmdrZUBodWF3ZWkuY29tPgo+PiBTdWJqZWN0
OiBSZTogW1BBVENIIG5ldF0gdmhvc3RfbmV0OiBmaXggaGlnaCBjcHUgbG9hZCB3aGVuIHNlbmRt
c2cgZmFpbHMKPj4KPj4KPj4gT24gMjAyMC8xMi85IOS4i+WNiDk6MjcsIHdhbmd5dW5qaWFuIHdy
b3RlOgo+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4+Pj4gRnJvbTogTWljaGFlbCBT
LiBUc2lya2luIFttYWlsdG86bXN0QHJlZGhhdC5jb21dCj4+Pj4gU2VudDogV2VkbmVzZGF5LCBE
ZWNlbWJlciA5LCAyMDIwIDg6NTAgUE0KPj4+PiBUbzogd2FuZ3l1bmppYW4gPHdhbmd5dW5qaWFu
QGh1YXdlaS5jb20+Cj4+Pj4gQ2M6IGphc293YW5nQHJlZGhhdC5jb207IHZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOwo+Pj4+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7
IExpbGlqdW4gKEplcnJ5KSA8amVycnkubGlsaWp1bkBodWF3ZWkuY29tPjsKPj4+PiBjaGVuY2hh
bmdodSA8Y2hlbmNoYW5naHVAaHVhd2VpLmNvbT47IHh1ZGluZ2tlCj4+IDx4dWRpbmdrZUBodWF3
ZWkuY29tPgo+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0XSB2aG9zdF9uZXQ6IGZpeCBoaWdo
IGNwdSBsb2FkIHdoZW4gc2VuZG1zZwo+Pj4+IGZhaWxzCj4+Pj4KPj4+PiBPbiBXZWQsIERlYyAw
OSwgMjAyMCBhdCAwNzo0ODoyNFBNICswODAwLCB3YW5neXVuamlhbiB3cm90ZToKPj4+Pj4gRnJv
bTogWXVuamlhbiBXYW5nIDx3YW5neXVuamlhbkBodWF3ZWkuY29tPgo+Pj4+Pgo+Pj4+PiBDdXJy
ZW50bHkgd2UgYnJlYWsgdGhlIGxvb3AgYW5kIHdha2UgdXAgdGhlIHZob3N0X3dvcmtlciB3aGVu
Cj4+Pj4+IHNlbmRtc2cgZmFpbHMuIFdoZW4gdGhlIHdvcmtlciB3YWtlcyB1cCBhZ2Fpbiwgd2Un
bGwgbWVldCB0aGUgc2FtZQo+Pj4+PiBlcnJvci4gVGhpcyB3aWxsIGNhdXNlIGhpZ2ggQ1BVIGxv
YWQuIFRvIGZpeCB0aGlzIGlzc3VlLCB3ZSBjYW4gc2tpcAo+Pj4+PiB0aGlzIGRlc2NyaXB0aW9u
IGJ5IGlnbm9yaW5nIHRoZSBlcnJvci4KPj4+Pj4KPj4+Pj4gU2lnbmVkLW9mZi1ieTogWXVuamlh
biBXYW5nIDx3YW5neXVuamlhbkBodWF3ZWkuY29tPgo+Pj4+PiAtLS0KPj4+Pj4gICAgZHJpdmVy
cy92aG9zdC9uZXQuYyB8IDI0ICsrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQo+Pj4+PiAgICAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkKPj4+Pj4KPj4+Pj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvbmV0LmMgYi9kcml2ZXJzL3Zob3N0L25ldC5jIGlu
ZGV4Cj4+Pj4+IDUzMWEwMGQ3MDNjZC4uYWM5NTBiMTEyMGY1IDEwMDY0NAo+Pj4+PiAtLS0gYS9k
cml2ZXJzL3Zob3N0L25ldC5jCj4+Pj4+ICsrKyBiL2RyaXZlcnMvdmhvc3QvbmV0LmMKPj4+Pj4g
QEAgLTgyOSwxNCArODI5LDggQEAgc3RhdGljIHZvaWQgaGFuZGxlX3R4X2NvcHkoc3RydWN0IHZo
b3N0X25ldAo+Pj4+PiAqbmV0LCBzdHJ1Y3Qgc29ja2V0ICpzb2NrKQo+Pj4+Pgo+Pj4+PiAgICAJ
CS8qIFRPRE86IENoZWNrIHNwZWNpZmljIGVycm9yIGFuZCBib21iIG91dCB1bmxlc3MgRU5PQlVG
Uz8KPj4gKi8KPj4+Pj4gICAgCQllcnIgPSBzb2NrLT5vcHMtPnNlbmRtc2coc29jaywgJm1zZywg
bGVuKTsKPj4+Pj4gLQkJaWYgKHVubGlrZWx5KGVyciA8IDApKSB7Cj4+Pj4+IC0JCQl2aG9zdF9k
aXNjYXJkX3ZxX2Rlc2ModnEsIDEpOwo+Pj4+PiAtCQkJdmhvc3RfbmV0X2VuYWJsZV92cShuZXQs
IHZxKTsKPj4+Pj4gLQkJCWJyZWFrOwo+Pj4+PiAtCQl9Cj4+Pj4+IC0JCWlmIChlcnIgIT0gbGVu
KQo+Pj4+PiAtCQkJcHJfZGVidWcoIlRydW5jYXRlZCBUWCBwYWNrZXQ6IGxlbiAlZCAhPSAlemRc
biIsCj4+Pj4+IC0JCQkJIGVyciwgbGVuKTsKPj4+Pj4gKwkJaWYgKHVubGlrZWx5KGVyciA8IDAg
fHwgZXJyICE9IGxlbikpCj4+Pj4+ICsJCQl2cV9lcnIodnEsICJGYWlsIHRvIHNlbmRpbmcgcGFj
a2V0cyBlcnIgOiAlZCwgbGVuIDogJXpkXG4iLAo+PiBlcnIsCj4+Pj4+ICtsZW4pOwo+Pj4+PiAg
ICBkb25lOgo+Pj4+PiAgICAJCXZxLT5oZWFkc1tudnEtPmRvbmVfaWR4XS5pZCA9IGNwdV90b192
aG9zdDMyKHZxLCBoZWFkKTsKPj4+Pj4gICAgCQl2cS0+aGVhZHNbbnZxLT5kb25lX2lkeF0ubGVu
ID0gMDsKPj4+PiBPbmUgb2YgdGhlIHJlYXNvbnMgZm9yIHNlbmRtc2cgdG8gZmFpbCBpcyBFTk9C
VUZTLgo+Pj4+IEluIHRoYXQgY2FzZSBmb3Igc3VyZSB3ZSBkb24ndCB3YW50IHRvIGRyb3AgcGFj
a2V0Lgo+Pj4gTm93IHRoZSBmdW5jdGlvbiB0YXBfc2VuZG1zZygpL3R1bl9zZW5kbXNnKCkgZG9u
J3QgcmV0dXJuIEVOT0JVRlMuCj4+Cj4+IEkgdGhpbmsgbm90LCBpdCBjYW4gaGFwcGVuIGlmIHdl
IGV4Y2VlZHMgc25kYnVmLiBFLmcgc2VlIHR1bl9hbGxvY19za2IoKS4KPiBUaGlzIHBhdGNoICdu
ZXQ6IGFkZCBhbGxvY19za2Jfd2l0aF9mcmFncygpIGhlbHBlcicgbW9kaWZ5cyB0aGUgcmV0dXJu
IHZhbHVlCj4gb2Ygc29ja19hbGxvY19zZW5kX3Bza2IoKSBmcm9tIC1FTk9CVUZTIHRvIC1FQUdB
SU4gd2hlbiB3ZSBleGNlZWRzIHNuZGJ1Zi4KPiBTbyB0aGUgcmV0dXJuIHZhbHVlIG9mIHR1bl9h
bGxvY19za2IgaGFzIGJlZW4gY2hhbmdlZC4KCgpPay4KCgo+Cj4gV2UgZG9uJ3QgZHJvcCBwYWNr
ZXQgaWYgdGhlIHJlYXNvbnMgZm9yIHNlbmRtc2cgdG8gZmFpbCBpcyBFQUdBSU4uCj4gSG93IGFi
b3V0IHRoaXM/CgoKSXQgc2hvdWxkIHdvcmsuCgpCdHcsIHRoZSBwYXRjaCBkb2Vzbid0IGFkZCB0
aGUgaGVhZCB0byB0aGUgdXNlZCByaW5nLiBUaGlzIG1heSBjb25mdXNlIAp0aGUgZHJpdmVyLgoK
VGhhbmtzCgoKPgo+IFRoYW5rcwo+Cj4+IFRoYW5rcwo+Pgo+Pgo+Pj4+IFRoZXJlIGNvdWxkIGJl
IG90aGVyIHRyYW5zaWVudCBlcnJvcnMuCj4+Pj4gV2hpY2ggZXJyb3IgZGlkIHlvdSBlbmNvdW50
ZXIsIHNwZWNpZmljYWxseT8KPj4+IEN1cnJlbnRseSBhIGd1ZXN0IHZtIHNlbmQgYSBza2Igd2hp
Y2ggbGVuZ3RoIGlzIG1vcmUgdGhhbiA2NGsuCj4+PiBJZiB2aXJ0aW8gaGRyIGlzIHdyb25nLCB0
aGUgcHJvYmxlbSB3aWxsIGFsc28gYmUgdHJpZ2dlcmVkLgo+Pj4KPj4+IFRoYW5rcwo+Pj4KPj4+
Pj4gQEAgLTkyNSwxOSArOTE5LDExIEBAIHN0YXRpYyB2b2lkIGhhbmRsZV90eF96ZXJvY29weShz
dHJ1Y3QKPj4+Pj4gdmhvc3RfbmV0ICpuZXQsIHN0cnVjdCBzb2NrZXQgKnNvY2spCj4+Pj4+Cj4+
Pj4+ICAgIAkJLyogVE9ETzogQ2hlY2sgc3BlY2lmaWMgZXJyb3IgYW5kIGJvbWIgb3V0IHVubGVz
cyBFTk9CVUZTPwo+PiAqLwo+Pj4+PiAgICAJCWVyciA9IHNvY2stPm9wcy0+c2VuZG1zZyhzb2Nr
LCAmbXNnLCBsZW4pOwo+Pj4+PiAtCQlpZiAodW5saWtlbHkoZXJyIDwgMCkpIHsKPj4+Pj4gLQkJ
CWlmICh6Y29weV91c2VkKSB7Cj4+Pj4+ICsJCWlmICh1bmxpa2VseShlcnIgPCAwIHx8IGVyciAh
PSBsZW4pKSB7Cj4+Pj4+ICsJCQlpZiAoemNvcHlfdXNlZCAmJiBlcnIgPCAwKQo+Pj4+PiAgICAJ
CQkJdmhvc3RfbmV0X3VidWZfcHV0KHVidWZzKTsKPj4+Pj4gLQkJCQludnEtPnVwZW5kX2lkeCA9
ICgodW5zaWduZWQpbnZxLT51cGVuZF9pZHggLSAxKQo+Pj4+PiAtCQkJCQklIFVJT19NQVhJT1Y7
Cj4+Pj4+IC0JCQl9Cj4+Pj4+IC0JCQl2aG9zdF9kaXNjYXJkX3ZxX2Rlc2ModnEsIDEpOwo+Pj4+
PiAtCQkJdmhvc3RfbmV0X2VuYWJsZV92cShuZXQsIHZxKTsKPj4+Pj4gLQkJCWJyZWFrOwo+Pj4+
PiArCQkJdnFfZXJyKHZxLCAiRmFpbCB0byBzZW5kaW5nIHBhY2tldHMgZXJyIDogJWQsIGxlbiA6
ICV6ZFxuIiwKPj4gZXJyLAo+Pj4+PiArbGVuKTsKPj4+Pj4gICAgCQl9Cj4+Pj4+IC0JCWlmIChl
cnIgIT0gbGVuKQo+Pj4+PiAtCQkJcHJfZGVidWcoIlRydW5jYXRlZCBUWCBwYWNrZXQ6ICIKPj4+
Pj4gLQkJCQkgIiBsZW4gJWQgIT0gJXpkXG4iLCBlcnIsIGxlbik7Cj4+Pj4+ICAgIAkJaWYgKCF6
Y29weV91c2VkKQo+Pj4+PiAgICAJCQl2aG9zdF9hZGRfdXNlZF9hbmRfc2lnbmFsKCZuZXQtPmRl
diwgdnEsIGhlYWQsIDApOwo+Pj4+PiAgICAJCWVsc2UKPj4+Pj4gLS0KPj4+Pj4gMi4yMy4wCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=

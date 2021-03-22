Return-Path: <SRS0=byTZ=IU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C38C433C1
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 03:06:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E4661931
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 03:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E4661931
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 547B260657;
	Mon, 22 Mar 2021 03:06:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0XfZ0lV_ZwT5; Mon, 22 Mar 2021 03:06:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0F836059F;
	Mon, 22 Mar 2021 03:06:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69CBAC000A;
	Mon, 22 Mar 2021 03:06:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D42BCC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 03:06:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C2EF78303C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 03:06:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EqORGy8gzFqY
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 03:06:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C380F83033
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 03:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616382409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qGSGyikb+edIn7bTwEsdqdkd00y7AOsinPPrODeBW6o=;
 b=EzPClbjynDe5Q3d7fv6JyJ0fvrnXQuedSlJoUdx/sxkMvqNQ29GZDAsvYvMyDZEiDxkLfA
 O9rFtl0RQdgxifMfXZ9eCcct4Urlt3LweMCcBNBKdzZOuqsqbMb3hbZ8S3/KF8n6hlHfOK
 HLPxMxWUmgcmvflpYPPojRxGflRmjpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-ZmxVymkNMxi4D3AF6oeFog-1; Sun, 21 Mar 2021 23:06:48 -0400
X-MC-Unique: ZmxVymkNMxi4D3AF6oeFog-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0BF5107ACCA;
 Mon, 22 Mar 2021 03:06:46 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-188.pek2.redhat.com
 [10.72.13.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D441E1001B2C;
 Mon, 22 Mar 2021 03:06:41 +0000 (UTC)
Subject: Re: vDPA: explain in Kconfig what vDPA is, capitalise it consistenly
To: Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20210321163421.GA27314@amd>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2739f8ce-70d2-337d-d952-fd8b6b26f8d8@redhat.com>
Date: Mon, 22 Mar 2021 11:06:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210321163421.GA27314@amd>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

CuWcqCAyMDIxLzMvMjIg5LiK5Y2IMTI6MzQsIFBhdmVsIE1hY2hlayDlhpnpgZM6Cj4gTm90IGV2
ZXJ5b25lIGtub3dzIHdoYXQgdkRQQSBzdGFuZHMgZm9yLCBleHBsYWluIGl0IGluIEtjb25maWcu
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBQYXZlbCBNYWNoZWsgKENJUCkgPHBhdmVsQGRlbnguZGU+Cj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL0tjb25maWcgYi9kcml2ZXJzL3ZkcGEvS2NvbmZp
Zwo+IGluZGV4IGZmZDFlMDk4YmZkMi4uOGNiMzdiM2RkMjc5IDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvdmRwYS9LY29uZmlnCj4gKysrIGIvZHJpdmVycy92ZHBhL0tjb25maWcKPiBAQCAtMyw5ICsz
LDkgQEAgbWVudWNvbmZpZyBWRFBBCj4gICAJdHJpc3RhdGUgInZEUEEgZHJpdmVycyIKPiAgIAlk
ZXBlbmRzIG9uIE5FVAo+ICAgCWhlbHAKPiAtCSAgRW5hYmxlIHRoaXMgbW9kdWxlIHRvIHN1cHBv
cnQgdkRQQSBkZXZpY2UgdGhhdCB1c2VzIGEKPiAtCSAgZGF0YXBhdGggd2hpY2ggY29tcGxpZXMg
d2l0aCB2aXJ0aW8gc3BlY2lmaWNhdGlvbnMgd2l0aAo+IC0JICB2ZW5kb3Igc3BlY2lmaWMgY29u
dHJvbCBwYXRoLgo+ICsJICBFbmFibGUgdGhpcyBtb2R1bGUgdG8gc3VwcG9ydCBWaXJ0dWFsIERh
dGEgUGF0aCBBY2NlbGVyYXRpb24KCgpNeSB1bmRlcnN0YWRpbmcgaXMgdGhhdCAidiIgaXMgc2hv
cnQgZm9yICJ2aXJ0aW8iIGhlcmUuCgpUaGFua3MKCgo+ICsJICAodkRQQSkgZGV2aWNlIHRoYXQg
dXNlcyBhIGRhdGFwYXRoIHdoaWNoIGNvbXBsaWVzIHdpdGgKPiArCSAgdmlydGlvIHNwZWNpZmlj
YXRpb25zIHdpdGggdmVuZG9yIHNwZWNpZmljIGNvbnRyb2wgcGF0aC4KPiAgIAo+ICAgaWYgVkRQ
QQo+ICAgCj4gQEAgLTM4LDggKzM4LDggQEAgY29uZmlnIE1MWDVfVkRQQQo+ICAgCWJvb2wKPiAg
IAlzZWxlY3QgVkhPU1RfSU9UTEIKPiAgIAloZWxwCj4gLQkgIFN1cHBvcnQgbGlicmFyeSBmb3Ig
TWVsbGFub3ggVkRQQSBkcml2ZXJzLiBQcm92aWRlcyBjb2RlIHRoYXQgaXMKPiAtCSAgY29tbW9u
IGZvciBhbGwgdHlwZXMgb2YgVkRQQSBkcml2ZXJzLiBUaGUgZm9sbG93aW5nIGRyaXZlcnMgYXJl
IHBsYW5uZWQ6Cj4gKwkgIFN1cHBvcnQgbGlicmFyeSBmb3IgTWVsbGFub3ggdkRQQSBkcml2ZXJz
LiBQcm92aWRlcyBjb2RlIHRoYXQgaXMKPiArCSAgY29tbW9uIGZvciBhbGwgdHlwZXMgb2YgdkRQ
QSBkcml2ZXJzLiBUaGUgZm9sbG93aW5nIGRyaXZlcnMgYXJlIHBsYW5uZWQ6Cj4gICAJICBuZXQs
IGJsb2NrLgo+ICAgCj4gICBjb25maWcgTUxYNV9WRFBBX05FVAo+IEBAIC00Nyw3ICs0Nyw3IEBA
IGNvbmZpZyBNTFg1X1ZEUEFfTkVUCj4gICAJc2VsZWN0IE1MWDVfVkRQQQo+ICAgCWRlcGVuZHMg
b24gTUxYNV9DT1JFCj4gICAJaGVscAo+IC0JICBWRFBBIG5ldHdvcmsgZHJpdmVyIGZvciBDb25u
ZWN0WDYgYW5kIG5ld2VyLiBQcm92aWRlcyBvZmZsb2FkaW5nCj4gKwkgIHZEUEEgbmV0d29yayBk
cml2ZXIgZm9yIENvbm5lY3RYNiBhbmQgbmV3ZXIuIFByb3ZpZGVzIG9mZmxvYWRpbmcKPiAgIAkg
IG9mIHZpcnRpbyBuZXQgZGF0YXBhdGggc3VjaCB0aGF0IGRlc2NyaXB0b3JzIHB1dCBvbiB0aGUg
cmluZyB3aWxsCj4gICAJICBiZSBleGVjdXRlZCBieSB0aGUgaGFyZHdhcmUuIEl0IGFsc28gc3Vw
cG9ydHMgYSB2YXJpZXR5IG9mIHN0YXRlbGVzcwo+ICAgCSAgb2ZmbG9hZHMgZGVwZW5kaW5nIG9u
IHRoZSBhY3R1YWwgZGV2aWNlIHVzZWQgYW5kIGZpcm13YXJlIHZlcnNpb24uCj4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==

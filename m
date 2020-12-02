Return-Path: <SRS0=DI2N=FG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE85FC64E7B
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 13:33:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CDB92075A
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 13:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDB92075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 799BC870B3;
	Wed,  2 Dec 2020 13:33:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qTDZJDVmErXG; Wed,  2 Dec 2020 13:33:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0726786EFD;
	Wed,  2 Dec 2020 13:33:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA121C0859;
	Wed,  2 Dec 2020 13:33:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B8E9C0052
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 13:33:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 610A387C37
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 13:33:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BKpp-obF4e3T
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 13:33:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2999C87C36
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 13:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606916010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gSBZVtHBrrEzEt57aw8UlqExfUejtXmcX5D0rAUeWo8=;
 b=h6r47FoupNLG3b98qs216wD5PcypOn+2a/ecXMRQJQ3GDfFN/oasn5YqG27CSi6znQYkV9
 sw8cUPGakGqwR9xV/XnSz5ZzKYK0Ckbse8M3RIleVRdkyW+fXBuFYEBchO5pL+dEZWdRSn
 dlqckOt+7OB7OsmZKQtAQRyq+Hujtr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-DL4pFo6gMe2-cWFTzMw1cw-1; Wed, 02 Dec 2020 08:33:27 -0500
X-MC-Unique: DL4pFo6gMe2-cWFTzMw1cw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97E3F18C89E3;
 Wed,  2 Dec 2020 13:33:26 +0000 (UTC)
Received: from [10.72.12.105] (ovpn-12-105.pek2.redhat.com [10.72.12.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85B4E5D9C6;
 Wed,  2 Dec 2020 13:33:21 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20201130043050-mutt-send-email-mst@kernel.org>
 <CACLfguXB+SzocLppNtrTZwKPFsshS8TLVe8_iFJxgjT-cFpSzA@mail.gmail.com>
 <20201130103142-mutt-send-email-mst@kernel.org>
 <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
 <e52b94b6-42a8-1270-1e10-d1905ccae598@redhat.com>
 <20201202055714.GA224423@mtl-vdi-166.wap.labs.mlnx>
 <20201202041518-mutt-send-email-mst@kernel.org>
 <20201202121241.GA228811@mtl-vdi-166.wap.labs.mlnx>
 <20201202071414-mutt-send-email-mst@kernel.org>
 <13d33e2c-ea99-6625-83fd-6cb223dd103b@redhat.com>
 <20201202080533-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <eaaa5fb6-fd6a-200f-8457-d27f758f1c64@redhat.com>
Date: Wed, 2 Dec 2020 21:33:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201202080533-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Eli Cohen <elic@nvidia.com>, linux-kernel@vger.kernel.org,
 Cindy Lu <lulu@redhat.com>, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjAvMTIvMiDkuIvljYg5OjA3LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+Pj4g
VHdvIHF1ZXN0aW9ucyBoZXJlOgo+Pj4+IDEuIE5vdyB3ZSBkb24ndCBoYXZlIHN1cHBvcnQgZm9y
IGNvbnRyb2wgdmlydHF1ZXVlLiBZZXQsIHdlIG11c3QgZmlsdGVyCj4+Pj4gcGFja2V0cyBiYXNl
ZCBvbiBNQUMsIHdoYXQgZG8geW91IHN1Z2dlc3QgdG8gZG8gaGVyZT8KPj4+IEhvdyBhYm91dCBh
biBpb2N0bCB0byBwYXNzIHRoZSBtYWMgdG8gdGhlIGRldmljZT8KPj4+IE1heWJlIG1pcnJvcmlu
ZyB0aGUgY29udHJvbCB2cSBzdHJ1Y3QgZm9ybWF0IC4uLgo+PiBJIHRoaW5rIHdlJ2QgYmV0dGVy
IGF2b2lkIHN1Y2ggYWQtaG9jIGlvY3RscyB0byBtYWtlIHZob3N0LXZEUEEgdHlwZQo+PiBpbmRl
cGVuZGVudC4KPiBGdW5kYW1lbnRhbGx5IHRoaXMgaXMgYWJvdXQgaGFuZGxpbmcgc29tZSBWUXMg
aW4gUUVNVSwgcmlnaHQ/Cj4gTWF5YmUgYSBnZW5lcmljIGlvY3RsIGFsb25nIHRoZSBsaW5lcyBv
ZiAiQ1RSTF9WUSIgcGFzc2luZwo+IHZxIG51bWJlciBhbmQgYSBjb21tYW5kIGJ1ZmZlciBmcm9t
IGd1ZXN0Pwo+IFNlZW1zIGdlbmVyaWMgZW5vdWdoIGZvciB5b3U/Cj4KCkl0IGxvb2tzIHRvIG1l
IHlvdSB3YW50IHRvIGludmVudCBhIHN5bmNocm9uaXplZCBBUEkgKG9yIHZEUEEgY29uZmlnIApv
cHMpIGZvciBzdWJtaXR0aW5nIHZpcnRpbyBkZXNjcmlwdG9ycy4KClNldmVyYWwgaXNzdWVzIEkg
Y2FuIHRoaW5rIGZvciB0aGlzOgoKMSkgY29udHJvbCB2cSBhbGxvd3MgdGhlIHJlcXVlc3QgdG8g
YmUgaGFuZGxlZCBhc3luY2hyb25vdXNseQoyKSB3ZSBzdGlsbCBuZWVkIGEgd2F5IHRvIGlzb2xh
dGUgdGhlIERNQSBpZiB0aGVyZSdzIGEgaGFyZHdhcmUgCnZpcnRxdWV1ZSBmb3IgdGhlIGRldmlj
ZSB0aGF0IHVzZSBETUEKMykgbmV3IHZEUEEgY29uZmlnIG9wZXJhdGlvbnMgbmVlZCB0byBiZSBp
bnZlbnRlZCwgbmV3IHVBUEkgZm9yIAp2aG9zdC12RFBBLCBuZXcgdmlydGlvIGNvbmZpZyBvcHMg
Zm9yIHZpcnRpby12RFBBCgpJdCBsb29rcyB0byBtZSB3ZSBjYW4gb3ZlcmNvbWUgMSkgYW5kIDIp
IGlmIHdlIGp1c3Qgc3RpY2sgdG8gYSB2aXJ0cXVldWUgCmludGVyZmFjZSBpbiB2aG9zdC12RFBB
IGFzIEkgcHJvcG9zZWQgaW4gWzFdLiBGb3IgaXNzdWUgMykgaXQgYWxzbyAKcmVxdWlyZXMgbXVj
aCBsZXNzIHdvcmsuCgpUaGFua3MKClsxXSBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC85LzIz
LzEyNDMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==

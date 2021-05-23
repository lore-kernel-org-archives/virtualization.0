Return-Path: <SRS0=TNbC=KS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D16C4707A
	for <virtualization@archiver.kernel.org>; Sun, 23 May 2021 07:40:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDDA66115C
	for <virtualization@archiver.kernel.org>; Sun, 23 May 2021 07:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDDA66115C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 892C083A05;
	Sun, 23 May 2021 07:39:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jLDMu1nKUq_n; Sun, 23 May 2021 07:39:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4C5D83A3A;
	Sun, 23 May 2021 07:39:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B144AC000D;
	Sun, 23 May 2021 07:39:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF41BC0001
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 May 2021 07:39:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C9CE3400CD
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 May 2021 07:39:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="qsndOR36";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="lhWNVsbJ"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QruzbHfPeoqz
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 May 2021 07:39:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7CC4F4002B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 May 2021 07:39:55 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1621755592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ror9xItdkp0XCqfJcHlXVMnDoOlzSnn2YexGS/5Nflk=;
 b=qsndOR36E3mAKIh0zZVXbhXmhrVkv6BxkHFQzrrflEpLYcQMs6OQsS/vFgxpQL4hDwHUWk
 ECRlBgBT6XRMJnUn7RGns305z0Ps3o5kUirAfNshYm9CKWOGsm4lLPP04+FM0gz0grVR4H
 Ab+DIYmwLK+RIORqtzy2Bc5mtlHpCIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1621755592;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ror9xItdkp0XCqfJcHlXVMnDoOlzSnn2YexGS/5Nflk=;
 b=lhWNVsbJaRg0711DH0I4uR81ByGdOHTSbC6S6mmtf0kuGt6xaUin3HUY2OkI6N11IU8UZC
 ojqj5xFNfo80tLAg==
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id BD253AC46;
 Sun, 23 May 2021 07:39:52 +0000 (UTC)
Subject: Re: [RFC] virtio_scsi: to poll and kick the virtqueue in timeout
 handler
To: Dongli Zhang <dongli.zhang@oracle.com>,
 virtualization@lists.linux-foundation.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20210523063843.1177-1-dongli.zhang@oracle.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <ac161748-15d2-2962-402e-23abca469623@suse.de>
Date: Sun, 23 May 2021 09:39:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210523063843.1177-1-dongli.zhang@oracle.com>
Content-Language: en-US
Cc: martin.petersen@oracle.com, mst@redhat.com, joe.jin@oracle.com,
 junxiao.bi@oracle.com, stefanha@redhat.com, pbonzini@redhat.com,
 srinivas.eeda@oracle.com, jejb@linux.ibm.com
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

T24gNS8yMy8yMSA4OjM4IEFNLCBEb25nbGkgWmhhbmcgd3JvdGU6Cj4gVGhpcyBSRkMgaXMgdG8g
dHJpZ2dlciB0aGUgZGlzY3Vzc2lvbiBhYm91dCB0byBwb2xsIGFuZCBraWNrIHRoZQo+IHZpcnRx
dWV1ZSBvbiBwdXJwb3NlIGluIHZpcnRpby1zY3NpIHRpbWVvdXQgaGFuZGxlci4KPiAKPiBUaGUg
dmlydGlvLXNjc2kgcmVsaWVzIG9uIHRoZSB2aXJ0aW8gdnJpbmcgc2hhcmVkIGJldHdlZW4gVk0g
YW5kIGhvc3QuCj4gVGhlIFZNIHNpZGUgcHJvZHVjZXMgcmVxdWVzdHMgdG8gdnJpbmcgYW5kIGtp
Y2tzIHRoZSB2aXJ0cXVldWUsIHdoaWxlIHRoZQo+IGhvc3Qgc2lkZSBwcm9kdWNlcyByZXNwb25z
ZXMgdG8gdnJpbmcgYW5kIGludGVycnVwdHMgdGhlIFZNIHNpZGUuCj4gCj4gQnkgZGVmYXVsdCB0
aGUgdmlydGlvLXNjc2kgaGFuZGxlciBkZXBlbmRzIG9uIHRoZSBob3N0IHRpbWVvdXQgaGFuZGxl
cgo+IGJ5IEJMS19FSF9SRVNFVF9USU1FUiB0byBnaXZlIGhvc3QgYSBjaGFuY2UgdG8gcGVyZm9y
bSBFSC4KPiAKPiBIb3dldmVyLCB0aGlzIGlzIG5vdCBoZWxwZnVsIGZvciB0aGUgY2FzZSB0aGF0
IHRoZSByZXNwb25zZXMgYXJlIGF2YWlsYWJsZQo+IG9uIHZyaW5nIGJ1dCB0aGUgbm90aWZpY2F0
aW9uIGZyb20gaG9zdCB0byBWTSBpcyBsb3N0Lgo+IApIb3cgY2FuIHRoaXMgaGFwcGVuPwpJZiBy
ZXNwb25zZXMgYXJlIGxvc3QgdGhlIGNvbW11bmljYXRpb24gYmV0d2VlbiBWTSBhbmQgaG9zdCBp
cyBicm9rZW4sIAphbmQgd2Ugc2hvdWxkIHJhdGhlciByZXNldCB0aGUgdmlydGlvIHJpbmdzIHRo
ZW1zZWx2ZXMuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAg
ICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRp
b25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7D
vHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u

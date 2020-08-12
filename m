Return-Path: <SRS0=QAK1=BW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F471C433E1
	for <virtualization@archiver.kernel.org>; Wed, 12 Aug 2020 02:09:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE46206DA
	for <virtualization@archiver.kernel.org>; Wed, 12 Aug 2020 02:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uf95jpW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE46206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7EC4188112;
	Wed, 12 Aug 2020 02:09:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bHqeVkMNiLwE; Wed, 12 Aug 2020 02:09:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AA9438810E;
	Wed, 12 Aug 2020 02:09:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 896DBC013C;
	Wed, 12 Aug 2020 02:09:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB777C004D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Aug 2020 02:09:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CB5A188112
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Aug 2020 02:09:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X1xAK66NRERI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Aug 2020 02:09:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7C7168810E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Aug 2020 02:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597198175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CjBAia3ospUg/zmTq94JkNk1GKssjuXqjxy8UFfaMgA=;
 b=Uf95jpW2bePy3f5h0XLq8U8xNkftY4lHNbzkqh01RPAxz7Tw+YwRkHbUs2WpEZGg3mEkuy
 fPquMuwM+6DX6Cdup1YIMGDx7pcoA7Mnmy8wh8bh1dVIy/VlbcJmO5DQqolah58lgUsY2W
 mv2+pp0K57gBXTjLjNGgV/IjxPNzqUU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-hLK4A1mUMWylNewyGM9dsg-1; Tue, 11 Aug 2020 22:09:32 -0400
X-MC-Unique: hLK4A1mUMWylNewyGM9dsg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E88A102C7F5;
 Wed, 12 Aug 2020 02:09:30 +0000 (UTC)
Received: from [10.72.12.118] (ovpn-12-118.pek2.redhat.com [10.72.12.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EACC087D62;
 Wed, 12 Aug 2020 02:09:23 +0000 (UTC)
Subject: Re: VDPA Debug/Statistics
To: Eli Cohen <elic@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <BN8PR12MB342559414BE03DFC992AD03DAB450@BN8PR12MB3425.namprd12.prod.outlook.com>
 <20200811073144-mutt-send-email-mst@kernel.org>
 <BN8PR12MB34259F2AE1FDAF2D40E48C5BAB450@BN8PR12MB3425.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <02c1cf02-40c7-80d7-60b5-19b691993018@redhat.com>
Date: Wed, 12 Aug 2020 10:09:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BN8PR12MB34259F2AE1FDAF2D40E48C5BAB450@BN8PR12MB3425.namprd12.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Shahaf Shuler <shahafs@mellanox.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "lulu@redhat.com" <lulu@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Majd Dibbiny <majd@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eli@mellanox.com" <eli@mellanox.com>, Maor Dickman <maord@nvidia.com>,
 Parav Pandit <parav@mellanox.com>
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

Ck9uIDIwMjAvOC8xMSDkuIvljYg3OjU4LCBFbGkgQ29oZW4gd3JvdGU6Cj4gT24gVHVlLCBBdWcg
MTEsIDIwMjAgYXQgMTE6MjY6MjBBTSArMDAwMCwgRWxpIENvaGVuIHdyb3RlOgo+PiBIaSBBbGwK
Pj4KPj4gQ3VycmVudGx5LCB0aGUgb25seSBzdGF0aXN0aWNzIHdlIGdldCBmb3IgYSBWRFBBIGlu
c3RhbmNlIGNvbWVzIGZyb20gdGhlIHZpcnRpb19uZXQgZGV2aWNlIGluc3RhbmNlLiBTaW5jZSBW
RFBBIGludm9sdmVzIGhhcmR3YXJlIGFjY2VsZXJhdGlvbiwgdGhlcmUgY2FuIGJlIHF1aXRlIGEg
bG90IG9mIGluZm9ybWF0aW9uIHRoYXQgY2FuIGJlIGZldGNoZWQgZnJvbSB0aGUgdW5kZXJseWlu
ZyBkZXZpY2UuIEN1cnJlbnRseSB0aGVyZSBpcyBubyBnZW5lcmljIG1ldGhvZCB0byBmZXRjaCB0
aGlzIGluZm9ybWF0aW9uLgo+Pgo+PiBPbmUgd2F5IG9mIGRvaW5nIHRoaXMgY2FuIGJlIHRvIGNy
ZWF0ZSBhIHRoZSBob3N0LCBhIG5ldCBkZXZpY2UgZm9yCj4+IGVhY2ggVkRQQSBpbnN0YW5jZSwg
YW5kIHVzZSBpdCB0byBnZXQgdGhpcyBpbmZvcm1hdGlvbiBvciBkbyBzb21lCj4+IGNvbmZpZ3Vy
YXRpb24uIEV0aHRvb2wgY2FuIGJlIHVzZWQgaW4gc3VjaCBhIGNhc2UKCgpUaGUgcHJvYmxlbXMg
YXJlOgoKLSB2RFBBIGlzIG5vdCBuZXQgc3BlY2lmaWMKLSB2RFBBIHNob3VsZCBiZSB0cmFuc3Bh
cmVudCB0byBob3N0IG5ldHdvcmtpbmcgc3RhY2sKCgo+Pgo+PiBJIHdvdWxkIGxpa2UgdG8gaGVh
ciB3aGF0IHlvdSB0aGluayBhYm91dCB0aGlzIG9yIG1heWJlIHlvdSBoYXZlIHNvbWUgb3RoZXIg
aWRlYXMgdG8gYWRkcmVzcyB0aGlzIHRvcGljLgo+Pgo+PiBUaGFua3MsCj4+IEVsaQo+IFNvbWV0
aGluZyBJJ20gbm90IHN1cmUgSSB1bmRlcnN0YW5kIGlzIGhvdyBhcmUgdmRwYSBpbnN0YW5jZXMg
Y3JlYXRlZCBvbiBtZWxsYW5veCBjYXJkcz8gVGhlcmUncyBhIGRldmxpbmsgY29tbWFuZCBmb3Ig
dGhhdCwgaXMgdGhhdCByaWdodD8KPiBDYW4gdGhhdCBiZSBleHRlbmRlZCBmb3Igc3RhdHM/Cj4K
PiBDdXJyZW50bHkgYW55IFZGIHdpbGwgYmUgcHJvYmVkIGFzIFZEUEEgZGV2aWNlLiBXZSdyZSBh
ZGRpbmcgZGV2bGluayBzdXBwb3J0IGJ1dCBJIGFtIG5vdCBzdXJlIGlmIGRldmxpbmsgaXMgc3Vp
dGFibGUgZm9yIGRpc3BsYXlpbmcgc3RhdGlzdGljcy4gV2Ugd2lsbCBkaXNjdXNzIGludGVybmFs
bHkgYnV0IEkgd2FudGVkIHRvIGtub3cgd2h5IHlvdSBndXlzIHRoaW5rLgoKCkkgYWdyZWUgd2l0
aCBNaWNoYWVsLCBpZiBpdCdzIHBvc3NpYmxlLCBpbnRlZ3JhdGluZyBzdGF0cyB3aXRoIGRldmxp
bmsgCnNob3VsZCBiZSB0aGUgYmVzdC4gSGF2aW5nIGFub3RoZXIgaW50ZXJmYWNlIHdpdGggaXMg
anVzdCBmb3Igc3RhdHMgCmxvb2tzIG5vdCBnb29kLgoKVGhhbmtzCgoKPgo+IC0tCj4gTVNUCj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==

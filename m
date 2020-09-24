Return-Path: <SRS0=sVkE=DB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625CFC4727F
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 07:26:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C137E235FD
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 07:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLnnEKPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C137E235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6D85F86B38;
	Thu, 24 Sep 2020 07:26:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9pqoDzlCqEzF; Thu, 24 Sep 2020 07:26:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id F0913860D1;
	Thu, 24 Sep 2020 07:26:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFE8AC0889;
	Thu, 24 Sep 2020 07:26:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B91D4C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 07:26:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B146586B38
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 07:26:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UToUPVWX7uTA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 07:26:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 636C0860D1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 07:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600932388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K3pWzi6XBSxvJ/VWL3fyEt5ORCYjFGoEK4Nlb2X8zSM=;
 b=VLnnEKPDupyXUk1qvUQmVTa1qNw6SyhYZTfJYNcvG0uQdJ5rKul+aHMTwMorN9t8fgzHP4
 6WldMnAASIThjln4lhcYbbo7++63mvbjlNB1X4IM0TQWNaRIruZSb0AzJHdCVRTk4tLG2i
 2AWEMrO0kEiEFYZzsZaTIToeZ8bRNuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-KhdlLsU5M-qlpT4HD7pE3w-1; Thu, 24 Sep 2020 03:26:26 -0400
X-MC-Unique: KhdlLsU5M-qlpT4HD7pE3w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC2AD186DD33;
 Thu, 24 Sep 2020 07:26:24 +0000 (UTC)
Received: from [10.72.13.193] (ovpn-13-193.pek2.redhat.com [10.72.13.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD64A60C15;
 Thu, 24 Sep 2020 07:26:10 +0000 (UTC)
Subject: Re: [RFC PATCH 01/24] vhost-vdpa: fix backend feature ioctls
To: Eli Cohen <elic@nvidia.com>
References: <20200924032125.18619-1-jasowang@redhat.com>
 <20200924032125.18619-2-jasowang@redhat.com>
 <20200924071609.GA170403@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <042dc3f9-40f0-f740-7ffc-611d315bc150@redhat.com>
Date: Thu, 24 Sep 2020 15:26:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200924071609.GA170403@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: lulu@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, mhabets@solarflare.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 hanand@xilinx.com, stefanha@redhat.com, eli@mellanox.com,
 maxime.coquelin@redhat.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
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

Ck9uIDIwMjAvOS8yNCDkuIvljYgzOjE2LCBFbGkgQ29oZW4gd3JvdGU6Cj4gT24gVGh1LCBTZXAg
MjQsIDIwMjAgYXQgMTE6MjE6MDJBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4gQ29tbWl0
IDY1MzA1NWI5YWNkNCAoInZob3N0LXZkcGE6IHN1cHBvcnQgZ2V0L3NldCBiYWNrZW5kIGZlYXR1
cmVzIikKPj4gaW50cm9kdWNlcyB0d28gbWFsZnVuY3Rpb24gYmFja2VuZCBmZWF0dXJlcyBpb2N0
bHM6Cj4+Cj4+IDEpIHRoZSBpb2N0bHMgd2FzIGJsaW5kbHkgYWRkZWQgdG8gdnJpbmcgaW9jdGwg
aW5zdGVhZCBvZiB2ZHBhIGRldmljZQo+PiAgICAgaW9jdGwKPj4gMikgdmhvc3Rfc2V0X2JhY2tl
bmRfZmVhdHVyZXMoKSB3YXMgY2FsbGVkIHdoZW4gZGV2IG11dGV4IGhhcyBhbHJlYWR5Cj4+ICAg
ICBiZWVuIGhlbGQgd2hpY2ggd2lsbCBsZWFkIGEgZGVhZGxvY2sKPj4KPiBJIGFzc3VtZSB0aGlz
IHBhdGNoIHJlcXVpcmVzIHNvbWUgcGF0Y2ggaW4gcWVtdSBhcyB3ZWxsLiBEbyB5b3UgaGF2ZQo+
IHN1Y2ggcGF0Y2g/Cj4KCkl0J3MgdGhpcyBzZXJpZXM6IFtQQVRDSCAwLzNdIFZob3N0LXZEUEE6
IGJhdGNoIElPVExCIHVwZGF0aW5nLgoKWW91IHdlcmUgY29waWVkLgoKVGhhbmtzCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=

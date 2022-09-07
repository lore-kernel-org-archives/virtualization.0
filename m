Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A572C54EE9
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 10:17:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B16FE60AD2;
	Wed,  7 Sep 2022 10:17:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B16FE60AD2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OXf2w8aO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xW2cQ3MM7Lo3; Wed,  7 Sep 2022 10:17:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5A18760783;
	Wed,  7 Sep 2022 10:17:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5A18760783
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43C62C0033;
	Wed,  7 Sep 2022 10:17:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DB1CC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 10:17:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 19A2240199
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 10:17:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 19A2240199
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OXf2w8aO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kbr_Yq5ynzUV
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 10:17:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 75C3240137
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 75C3240137
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 10:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662545833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=afHMjG2HkRYvCDuYzjTQhxoQdwvvL29SNFSccxhwbQY=;
 b=OXf2w8aOd9FNVRhg23RECFwnmLWX4mi8bnqMIjBQbGAu7DuvGiw9QVqu6Cn3GnF+gXQPpG
 A8qe/6XH3SQRa0l4GVHLUzLpfyzWIGCBcwzwNeeB4w5KtqMnfYQcS3a+9vxiHuXX2Hsigr
 lBBI/UlATevjeWeXlbzn95SxXEEQuKE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-AZwPBN3lN5GhXRakgF0ASA-1; Wed, 07 Sep 2022 06:17:10 -0400
X-MC-Unique: AZwPBN3lN5GhXRakgF0ASA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5F2580418F;
 Wed,  7 Sep 2022 10:17:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.195.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CA001121314;
 Wed,  7 Sep 2022 10:17:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 017DF180039B; Wed,  7 Sep 2022 12:17:07 +0200 (CEST)
Date: Wed, 7 Sep 2022 12:17:07 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Zongmin Zhou <min_halo@163.com>
Subject: Re: [PATCH] drm/qxl: fix the suspend/resume issue on qxl device
Message-ID: <20220907101707.ghkrtsba4eeje43p@sirius.home.kraxel.org>
References: <20220907094423.93581-1-min_halo@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220907094423.93581-1-min_halo@163.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 zhouzongmin@kylinos.cn, Ming Xie <xieming@kylinos.cn>, daniel@ffwll.ch,
 spice-devel@lists.freedesktop.org, airlied@redhat.com
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

T24gV2VkLCBTZXAgMDcsIDIwMjIgYXQgMDU6NDQ6MjNQTSArMDgwMCwgWm9uZ21pbiBaaG91IHdy
b3RlOgo+IAo+IEZyb206IFpvbmdtaW4gWmhvdSA8emhvdXpvbmdtaW5Aa3lsaW5vcy5jbj4KPiAK
PiBEZXRhaWxzOgo+IEN1cnJlbnRseSwgd2hlbiB0cnlpbmcgdG8gc3VzcGVuZCBhbmQgcmVzdW1l
IHdpdGggcXhsIGRldmljZe+8jAo+IHRoZXJlIGFyZSBzb21lIGVycm9yIG1lc3NhZ2VzIGFmdGVy
IHJlc3VtaW5nLAo+IGV2ZW50dWFsbHkgY2F1c2VkIHRvIGJsYWNrIHNjcmVlbiBhbmQgY2FuJ3Qg
YmUgcmVjb3ZlcmVkLgoKWyBhbmFseXNpcyBzbmlwcGVkIF0KCj4gTGV0J3MgZml4IHRoaXMgYnkg
cmVzZXQgaW8gYW5kIHJlbW92ZSB0aGUgcXhsX3JpbmdfaW5pdF9oZHIgY2FsbGluZy4KClB1c2hl
ZCB0byBkcm0tbWlzYy1uZXh0Cgp0aGFua3MsCiAgR2VyZAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

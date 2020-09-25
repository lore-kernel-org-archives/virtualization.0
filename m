Return-Path: <SRS0=jbvZ=DC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF756C4741F
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 14:15:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49469208A9
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 14:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjoBIc7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49469208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C54C186DE0;
	Fri, 25 Sep 2020 14:15:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fD6YhNQATTG9; Fri, 25 Sep 2020 14:15:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id ADB6A86DD4;
	Fri, 25 Sep 2020 14:15:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9168FC1AD7;
	Fri, 25 Sep 2020 14:15:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE441C0859
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 14:15:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AA71A86C92
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 14:15:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wKaGnZdihmAc
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 14:14:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E71A786C3E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 14:14:58 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601043297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2R3iNk7E6LuL+FhjbAyC15TLO61WWZH3nk3G89jYXq0=;
 b=HjoBIc7qxLzB9vliFipe5GOmkNGYgYs5YwlOqTcnMjABbxTLN3Dn2gL1qk1MS4NwGiaQkA
 PFH+1KzC2uucx6x2XAJA6eKkyjlXrZQxYloi/irWfiOwgD8C5Z2BxBOc8oM1lGUiQ/M7gZ
 qt62GgVRLNXiR6sbZG1EmfZR3i3v3eU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-W2P_d5LuO86xM8tPcyjomw-1; Fri, 25 Sep 2020 10:14:55 -0400
X-MC-Unique: W2P_d5LuO86xM8tPcyjomw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E34ED195D564;
 Fri, 25 Sep 2020 14:14:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEFC65576F;
 Fri, 25 Sep 2020 14:14:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id BCB7016E0A; Fri, 25 Sep 2020 16:14:46 +0200 (CEST)
Date: Fri, 25 Sep 2020 16:14:46 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200925141446.63iwheqdrqxl3puo@sirius.home.kraxel.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <20200925084806.GB490533@myrica>
 <20200925062230-mutt-send-email-mst@kernel.org>
 <20200925112629.GA1337555@myrica>
 <20200925094405-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200925094405-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, lorenzo.pieralisi@arm.com,
 virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org, joro@8bytes.org,
 virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com,
 bhelgaas@google.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

  Hi,

> Many power platforms are OF based, thus without ACPI or DT support.

pseries has lots of stuff below /proc/device-tree.  Dunno whenever that
is the same kind of device tree we have on arm ...

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

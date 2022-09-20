Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CE4C6FA8B
	for <virtualization@archiver.kernel.org>; Tue, 20 Sep 2022 11:30:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFCFF60E71;
	Tue, 20 Sep 2022 11:30:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BFCFF60E71
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WOaF0pb2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z4VyHu0_jADP; Tue, 20 Sep 2022 11:30:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 566DB60E5B;
	Tue, 20 Sep 2022 11:30:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 566DB60E5B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C456C0032;
	Tue, 20 Sep 2022 11:30:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B3EAC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 11:30:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1E5FC404E0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 11:30:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1E5FC404E0
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WOaF0pb2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RzKEbQjD4Ptv
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 11:30:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 28F654039D
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 28F654039D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 11:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Ufnh2nMLFWVGqIEbVXFQ5bFlJnUCbH6WOUk2G18r1y8=; b=WOaF0pb2mROTLVZj6oPFh/FEVU
 Dl8UExUWm8T66UeCdjXNE09c88ke2G80M4GgWN3ICQ41JHgfvY7DeVuOKLU3QrAyedUw6Gkd9c/JZ
 xzASYsIw47hVIvPfhdZlxwcIpeIfsMs1aoI4pFyhCieMxjdDFlHcIqyn9Bjk119xt+LQQgeVeHgW9
 JiG6T7qdN37W/Rc1zdKr3aD/JgQCwyS3Ezmw7EaAupUS/Q+ffG3TkQzgpV6R3eO/Z9WiFAeb8lAeR
 B67xStuif2T9Mk2ap53GV7HCBlxGa2Dt8whgMwfgbOtYL7aU4wj1hqfjdyVe/wTc8PXEQEnDHPej4
 MqMWmAcw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1oabSC-003JT4-DQ; Tue, 20 Sep 2022 11:30:16 +0000
Date: Tue, 20 Sep 2022 04:30:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daniil Lunev <dlunev@google.com>
Subject: Re: [PATCH RFC 0/8] Introduce provisioning primitives for thinly
 provisioned storage
Message-ID: <YymkSDsFVVg1nbDP@infradead.org>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <YyQTM5PRT2o/GDwy@fedora>
 <CAG9=OMPHZqdDhX=M+ovdg5fa3x4-Q_1r5SWPa8pMTQw0mr5fPg@mail.gmail.com>
 <Yylvvm3zVgqpqDrm@infradead.org>
 <CAAKderPF5Z5QLxyEb80Y+90+eR0sfRmL-WfgXLp=eL=HxWSZ9g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAKderPF5Z5QLxyEb80Y+90+eR0sfRmL-WfgXLp=eL=HxWSZ9g@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, Sarthak Kukreti <sarthakkukreti@chromium.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Bart Van Assche <bvanassche@google.com>, Mike Snitzer <snitzer@kernel.org>,
 linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@google.com>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-ext4@vger.kernel.org, Evan Green <evgreen@google.com>,
 Alasdair Kergon <agk@redhat.com>
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

On Tue, Sep 20, 2022 at 08:17:10PM +1000, Daniil Lunev wrote:
> to WRITE ZERO command in NVMe, but to WRITE UNAVAILABLE in

There is no such thing as WRITE UNAVAILABLE in NVMe.

> NVME 2.0 spec, and to UNMAP ANCHORED in SCSI spec.

The SCSI anchored LBA state is quite complicated, and in addition
to UNMAP you can also create it using WRITE SAME, which is at least
partially useful, as it allows for sensible initialization pattern.
For the purpose of Linux that woud be 0.

That being siad you still haven't actually explained what problem
you're even trying to solve.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD543C433EF
	for <virtualization@archiver.kernel.org>; Tue, 18 Jan 2022 06:56:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D77B408C7;
	Tue, 18 Jan 2022 06:56:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ADFj4B1fK1km; Tue, 18 Jan 2022 06:56:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D8B8E408C8;
	Tue, 18 Jan 2022 06:56:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACD4AC0039;
	Tue, 18 Jan 2022 06:56:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AC2EC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 06:56:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 63C364028D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 06:56:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WlVMPAaBKsrv
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 06:56:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5AA0940286
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 06:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642488996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AmJlqI3V1Qshx6eMkpy4chv7mvxWHrVFABtLYD/f+QU=;
 b=Pg9KAlJruiU2Vev73SVNe7GS0sT4VjxOtXbWWK1Fo11hq/aSQFcBeqpCX1u/RHxvtrXwqb
 KZ7hv4YMNSpMsulVTNNPaT5aHgiUr7HaCJyf+OQjUEJs1B/N2Wijieion5Qs9eHku5JlFq
 DFR5VZCFz8ewaaM50k6C+2H2Hv++znw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-spQxhNexNYmXEy-j9274sw-1; Tue, 18 Jan 2022 01:56:28 -0500
X-MC-Unique: spQxhNexNYmXEy-j9274sw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 391F580ED84;
 Tue, 18 Jan 2022 06:56:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DB2C79455;
 Tue, 18 Jan 2022 06:56:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D1F3E18000A6; Tue, 18 Jan 2022 07:56:24 +0100 (CET)
Date: Tue, 18 Jan 2022 07:56:24 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH] drm/virtio: Ensure that objs is not NULL in
 virtio_gpu_array_put_free()
Message-ID: <20220118065624.uw76mxi2ij3ho4r4@sirius.home.kraxel.org>
References: <20211213183122.838119-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211213183122.838119-1-roberto.sassu@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: syzbot+e9072e90624a31dfa85f@syzkaller.appspotmail.com, airlied@linux.ie,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch
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

On Mon, Dec 13, 2021 at 07:31:22PM +0100, Roberto Sassu wrote:
> If virtio_gpu_object_shmem_init() fails (e.g. due to fault injection, as it
> happened in the bug report by syzbot), virtio_gpu_array_put_free() could be
> called with objs equal to NULL.
> 
> Ensure that objs is not NULL in virtio_gpu_array_put_free(), or otherwise
> return from the function.
> 
> Cc: stable@vger.kernel.org # 5.13.x
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reported-by: syzbot+e9072e90624a31dfa85f@syzkaller.appspotmail.com
> Fixes: 377f8331d0565 ("drm/virtio: fix possible leak/unlock virtio_gpu_object_array")

Pushed to drm-misc-next.

thanks,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

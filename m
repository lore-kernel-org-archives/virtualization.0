Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6689C77B60
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 04:49:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F7A861117;
	Tue, 28 Mar 2023 04:49:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F7A861117
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yVjVeEwJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BVrTKip5D8Kw; Tue, 28 Mar 2023 04:49:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8EE9E610FE;
	Tue, 28 Mar 2023 04:49:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8EE9E610FE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E3B7C007E;
	Tue, 28 Mar 2023 04:49:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E5F3C007A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 04:49:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30BC26110F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 04:49:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30BC26110F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rq1htja_7iLy
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 04:49:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C0FFE610FE
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C0FFE610FE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 04:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=xlPh4S+TbTgkNsO9Dt503SwDvNQzKRyfCiCNpDhlIR8=; b=yVjVeEwJyLcoFyXalwFYFo+Jq+
 S/xBDNNvXpga8t4TgcZdnUESMN2aJKHjt8vx/pY28AnGcz+RxUIYcSoupOwhAGFstqwHLFpttRfjq
 bhnnVINCRXTPRzn9gf0aaIXTv3F8eMcqgTGccGEO5g/mE1oAZ9LJIF1QnkemSLjSzOkK1Up3RKIYV
 mJJKaaTEhqSyjjLHF7ggUnVp02CXpE0OSCitgRtx9s2m2Ms0UpSZ4jcGeyHLuQTHwnEBAuQnorgsL
 bmuu4lmzKNWF2OdtCNtEp7+al4UyKfB5jZ8FIleUkEP+5cxQFqNery4BKmlS7LEP8ngXoG3jeAYwe
 3p+n7Nlw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red
 Hat Linux)) id 1ph1HA-00D8WD-30; Tue, 28 Mar 2023 04:49:40 +0000
Date: Mon, 27 Mar 2023 21:49:40 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: 9p regression (Was: [PATCH v2] virtio_ring: don't update event
 idx on get_buf)
Message-ID: <ZCJx5Dtms5iDhftF@bombadil.infradead.org>
References: <20230325105633.58592-1-huangjie.albert@bytedance.com>
 <ZCJNTBQLZeyLBKKB@codewreck.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZCJNTBQLZeyLBKKB@codewreck.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Albert Huang <huangjie.albert@bytedance.com>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eric Van Hensbergen <ericvh@gmail.com>, v9fs-developer@lists.sourceforge.net
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

On Tue, Mar 28, 2023 at 11:13:32AM +0900, Dominique Martinet wrote:
> Hi Michael, Albert,
> 
> Albert Huang wrote on Sat, Mar 25, 2023 at 06:56:33PM +0800:
> > in virtio_net, if we disable the napi_tx, when we triger a tx interrupt,
> > the vq->event_triggered will be set to true. It will no longer be set to
> > false. Unless we explicitly call virtqueue_enable_cb_delayed or
> > virtqueue_enable_cb_prepare.
> 
> This patch (commited as 35395770f803 ("virtio_ring: don't update event
> idx on get_buf") in next-20230327 apparently breaks 9p, as reported by
> Luis in https://lkml.kernel.org/r/ZCI+7Wg5OclSlE8c@bombadil.infradead.org

Spot on, reverting that commit fixes it.

  Luis
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

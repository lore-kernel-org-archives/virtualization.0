Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE86C433F5
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 04:25:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6CF5F400D1;
	Tue, 26 Apr 2022 04:25:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id otG1LlMuVLnU; Tue, 26 Apr 2022 04:25:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 055CB400AB;
	Tue, 26 Apr 2022 04:25:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBFAFC0039;
	Tue, 26 Apr 2022 04:25:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FCBFC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 04:25:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4F21660E2E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 04:25:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1vx0HPKPN6ZK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 04:25:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 11902605BE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 04:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ql6OU1exhFym7974YqTBfW/6EKRkqJeNSaKNccjHSB4=; b=tXszhFOo6SlOaPho5BX9WVsQvZ
 mff2L6ZCQdShtYYmxjNYuRImFCNJ+R5Do6qEj7Q7Xysbuw3dkq7K1wrkgNMRNWvxyOvFvoIWqewtT
 MEF2l8HmxjRC9dDdwaF7xCL/mqrzH5JKSNXpZTgwC8AjRS5YVc58HIS8pfpnK8HE8YArUq3fOAEug
 BfvLPn065znVlzS8Cmc7K3JC49ZfW0QI0ILRWz9AXsugmSKZ9xDWvNVPpHP/4c1bvtaR8YBA+8hC1
 HtsljFwhZTRGEA+RGbghmVAU0bi/PecWak2/7BJLJlryDQXkETX7UJBidt8xsm/Z1Uk+vFKIswhKb
 Clk7nkuA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1njCky-00CPdx-Cq; Tue, 26 Apr 2022 04:24:56 +0000
Date: Mon, 25 Apr 2022 21:24:56 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, mst@redhat.com,
 jasowang@redhat.com, xieyongji@bytedance.com,
 dan.carpenter@oracle.com, elic@nvidia.com, parav@nvidia.com,
 guanjun@linux.alibaba.com
Subject: Re: [proc/sysctl]  1dd38979b2:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <Ymd0GIf3Ieh3DRcg@bombadil.infradead.org>
References: <20220425083302.GD21864@xsang-OptiPlex-9020>
 <YmbvxQVNFESRwxxU@bombadil.infradead.org>
 <20220425144607.2c2588e6b1f00ab8a6f3f6ea@linux-foundation.org>
 <YmcqCVLv3HQ+Kxeq@bombadil.infradead.org>
 <20220425163434.5f8f47e8c301ea30c2f94a5a@linux-foundation.org>
 <Ymc1Zn8BbQMbjb58@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ymc1Zn8BbQMbjb58@bombadil.infradead.org>
Cc: Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, lkp@lists.01.org,
 Julius Hemanth Pitti <jpitti@cisco.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Johannes Weiner <hannes@cmpxchg.org>,
 kernel test robot <oliver.sang@intel.com>, Ingo Molnar <mingo@elte.hu>,
 Iurii Zaikin <yzaikin@google.com>, Eli Cohen <elic@nvidia.com>, lkp@intel.com
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

On Mon, Apr 25, 2022 at 04:57:26PM -0700, Luis Chamberlain wrote:
> On Mon, Apr 25, 2022 at 04:34:34PM -0700, Andrew Morton wrote:
> > On Mon, 25 Apr 2022 16:08:57 -0700 Luis Chamberlain <mcgrof@kernel.org> wrote:
> > 
> > > On Mon, Apr 25, 2022 at 02:46:07PM -0700, Andrew Morton wrote:
> > > > On Mon, 25 Apr 2022 12:00:21 -0700 Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > > 
> > > > > Andrew, can we drop this patch for now?
> > > > 
> > > > I've been sitting on (ie, forgotten about) this patch
> > > > (https://lore.kernel.org/all/20200709235115.56954-1-jpitti@cisco.com/T/#u)
> > > 
> > > Jesh, yeah I see.
> > > 
> > > > for two years.  Evidently waiting for you/Kees/Ingo to provide
> > > > guidance.  So sure, the need seems very unurgent so I can drop it.
> > > 
> > > Well Keew as OK with it, but I yeah I can't decipher the issue at this
> > > point in time.
> > > 
> > > > However I fail to see how that patch could have caused this crash.  I'm
> > > > suspecting a bisection error?
> > > > 
> > > > Maybe something is unwell in drivers/vdpa/vdpa_user/vduse_dev.c.
> > > 
> > > At a quick glance, yes it could very well by vduse_init() is messy and
> > > races somehow with init, but if a race does lurk here my instincts tell
> > > me this can't be the only place.
> > > 
> > > Not sure if leaving a patch in place more time to see how else things
> > > can explode is worth it.
> > 
> > Confused.  Are you thinking that the above-linked patch was somehow
> > involved in this crash?  If so, but how?  All it does it to permit
> > unprivileged reads to four ints via proc_dointvec_minmax()?
> 
> If the priv allows for it access to dereferencing a pointer is allowed.
> How that race happens though, indeed is beyond the patch's fault.

Even so, I am 99.99% sure this is a driver bug then. And so if enabling
this patch just enables more driver bugs so be it.

So driver maintainers: please take a look, I tried to check but
the driver bug is not obvious to me yet.

  Luis
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F59C433EF
	for <virtualization@archiver.kernel.org>; Fri,  8 Apr 2022 11:25:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A53E461306;
	Fri,  8 Apr 2022 11:25:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S3-bsWMkBLiM; Fri,  8 Apr 2022 11:25:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5BB8C60BDD;
	Fri,  8 Apr 2022 11:25:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3986DC0084;
	Fri,  8 Apr 2022 11:25:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CE7CC002C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 11:25:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E941A41758
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 11:25:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gNQdClX4UlOx
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 11:25:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2B6344097E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 11:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649417132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gygnhxv2HcEj4WyewtIiGrCeH0hI+03W3yYZsLCiAPE=;
 b=MEpq3fDeqDG6GDqbTo4gkDQqXuB8jVjqP3/5/8CGJNQDoYShvVuBkN1kwz3UpXiIXd/1UY
 J8GdjqqRRnuWQo5F3xUC32RYNga2/9oXqcoO3iDcrQUbpbAEIQ6d4TrPEvCU0GphaieA+l
 6snyqL4fwLMNd9/j5pnUvZR5tB0tQhc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-PwCssXcRPryunhEZsufmHg-1; Fri, 08 Apr 2022 07:25:29 -0400
X-MC-Unique: PwCssXcRPryunhEZsufmHg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C27286B8AC;
 Fri,  8 Apr 2022 11:25:29 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.8.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EEC091415130;
 Fri,  8 Apr 2022 11:25:28 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id AEE88220EFF; Fri,  8 Apr 2022 07:25:28 -0400 (EDT)
Date: Fri, 8 Apr 2022 07:25:28 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH] fuse: avoid unnecessary spinlock bump
Message-ID: <YlAbqF4Yts8Aju+W@redhat.com>
References: <20220402103250.68027-1-jefflexu@linux.alibaba.com>
 <Yk7w8L1f/yik+qrR@redhat.com>
 <b7a50fac-0259-e56c-0445-cca3fbf99888@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b7a50fac-0259-e56c-0445-cca3fbf99888@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Cc: linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 miklos@szeredi.hu
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

On Fri, Apr 08, 2022 at 10:36:40AM +0800, JeffleXu wrote:
> 
> 
> On 4/7/22 10:10 PM, Vivek Goyal wrote:
> > On Sat, Apr 02, 2022 at 06:32:50PM +0800, Jeffle Xu wrote:
> >> Move dmap free worker kicker inside the critical region, so that extra
> >> spinlock lock/unlock could be avoided.
> >>
> >> Suggested-by: Liu Jiang <gerry@linux.alibaba.com>
> >> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> > 
> > Looks good to me. Have you done any testing to make sure nothing is
> > broken.
> 
> xfstests -g quick shows no regression. The tested virtiofs is mounted
> with "dax=always".

I think xfstests might not trigger reclaim. You probably will have to
run something like blogbench with a small dax window like 1G so that
heavy reclaim happens.

For fun, I sometimes used to run it with a window of just say 16 dax
ranges so that reclaim was so heavy that if there was a bug, it will
show up.

Thanks
Vivek

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

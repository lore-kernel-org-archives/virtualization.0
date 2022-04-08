Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343ECC433EF
	for <virtualization@archiver.kernel.org>; Fri,  8 Apr 2022 12:06:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CC59A403C2;
	Fri,  8 Apr 2022 12:06:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gZNA-Wzj2uXt; Fri,  8 Apr 2022 12:06:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 57B7A400A8;
	Fri,  8 Apr 2022 12:06:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 116D8C0084;
	Fri,  8 Apr 2022 12:06:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D72BC002C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 12:06:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C1DC828DD
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 12:06:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xtIifAK8KMmZ
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 12:06:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 445DC813AD
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 12:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649419595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D4PLxetJuketg91dT7MvrhWLO7O7hhlCogbjJFrKXZ8=;
 b=Odfhhw4YPQw2bDJWRcG8tm3GXF1199TepEw9RmdkiD7C4WJ7vKv9yN8nMWF1JAnU03YIVZ
 V90qL1adaULIhsOqNRdxBlJGcqLD9Dkv7SyN3gEKU/NmUxttu9GVTpUer8iWpDtckEdYhj
 /MwB2veaABoAc+lc1ykGoxMGSEPSLKI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-nVwcfuKJNcmOTrMRo0-tlw-1; Fri, 08 Apr 2022 08:06:32 -0400
X-MC-Unique: nVwcfuKJNcmOTrMRo0-tlw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92B4285A5BE;
 Fri,  8 Apr 2022 12:06:31 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.8.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E536403179;
 Fri,  8 Apr 2022 12:06:31 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 3F067220EFF; Fri,  8 Apr 2022 08:06:31 -0400 (EDT)
Date: Fri, 8 Apr 2022 08:06:31 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH] fuse: avoid unnecessary spinlock bump
Message-ID: <YlAlR0xVDqQzl98w@redhat.com>
References: <20220402103250.68027-1-jefflexu@linux.alibaba.com>
 <Yk7w8L1f/yik+qrR@redhat.com>
 <b7a50fac-0259-e56c-0445-cca3fbf99888@linux.alibaba.com>
 <YlAbqF4Yts8Aju+W@redhat.com>
 <586dd7bb-4218-63da-c7db-fe8d46f43cde@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <586dd7bb-4218-63da-c7db-fe8d46f43cde@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
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

On Fri, Apr 08, 2022 at 07:50:55PM +0800, JeffleXu wrote:
> 
> 
> On 4/8/22 7:25 PM, Vivek Goyal wrote:
> > On Fri, Apr 08, 2022 at 10:36:40AM +0800, JeffleXu wrote:
> >>
> >>
> >> On 4/7/22 10:10 PM, Vivek Goyal wrote:
> >>> On Sat, Apr 02, 2022 at 06:32:50PM +0800, Jeffle Xu wrote:
> >>>> Move dmap free worker kicker inside the critical region, so that extra
> >>>> spinlock lock/unlock could be avoided.
> >>>>
> >>>> Suggested-by: Liu Jiang <gerry@linux.alibaba.com>
> >>>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> >>>
> >>> Looks good to me. Have you done any testing to make sure nothing is
> >>> broken.
> >>
> >> xfstests -g quick shows no regression. The tested virtiofs is mounted
> >> with "dax=always".
> > 
> > I think xfstests might not trigger reclaim. You probably will have to
> > run something like blogbench with a small dax window like 1G so that
> > heavy reclaim happens.
> 
> 
> Actually, I configured the DAX window to 8MB, i.e. 4 slots when running
> xfstests. Thus I think the reclaim path is most likely triggered.
> 
> 
> > 
> > For fun, I sometimes used to run it with a window of just say 16 dax
> > ranges so that reclaim was so heavy that if there was a bug, it will
> > show up.
> > 
> 
> Yeah, my colleague had ever reported that a DAX window of 4KB will cause
> hang in our internal OS (which is 4.19, we back ported virtiofs to
> 4.19). But then I found that this issue doesn't exist in the latest
> upstream. The reason seems that in the upstream kernel,
> devm_memremap_pages() called in virtio_fs_setup_dax() will fail directly
> since the dax window (4KB) is not aligned with the sparse memory section.

Given our default chunk size is 2MB (FUSE_DAX_SHIFT), may be it is not
a bad idea to enforce some minimum cache window size. IIRC, even one
range is not enough. Minimum 2 are required for reclaim to not deadlock.

Hence, I guess it is not a bad idea to check for cache window size and
if it is too small, reject it and disable dax.

Thanks
Vivek

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <SRS0=6mDK=MM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6F8C07E95
	for <virtualization@archiver.kernel.org>; Tue, 20 Jul 2021 19:40:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA8FF610CC
	for <virtualization@archiver.kernel.org>; Tue, 20 Jul 2021 19:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8FF610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D5B683415;
	Tue, 20 Jul 2021 19:40:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q01nHggc21_u; Tue, 20 Jul 2021 19:40:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 885138308B;
	Tue, 20 Jul 2021 19:40:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67033C0010;
	Tue, 20 Jul 2021 19:40:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37F8FC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 19:40:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 26BEE401E8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 19:40:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id drXNDqBdLFZc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 19:40:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2E044401B0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 19:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626810035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZX6jEwOeEdHBQeHLTDnSnVT2DALhakaB/D7jciFUVJo=;
 b=fpH/onOpW2cXElI7eX9I+cUezbwozNj+JMR3Say1sq45Jm28W8obsDRLhu0JGsbC84pOgU
 Jqp87KWS3Ehfi8kxdXfgToFLWBNI9r0ycJPaiRLX9TgN7SDRax36UNECa2ckeNRe5C7OZ0
 QyqrIcCk6kSQ7RLDtq/YjrRFI0BmdWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-b7tab7UHNzihncjbNRzdlA-1; Tue, 20 Jul 2021 15:40:34 -0400
X-MC-Unique: b7tab7UHNzihncjbNRzdlA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF05B10C1ADC;
 Tue, 20 Jul 2021 19:40:32 +0000 (UTC)
Received: from horse.redhat.com (ovpn-113-228.rdu2.redhat.com [10.10.113.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3549D10016DB;
 Tue, 20 Jul 2021 19:40:29 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id B308F223E70; Tue, 20 Jul 2021 15:40:28 -0400 (EDT)
Date: Tue, 20 Jul 2021 15:40:28 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v2 3/4] fuse: add per-file DAX flag
Message-ID: <YPcmrK/XdPiFIisJ@redhat.com>
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
 <20210716104753.74377-4-jefflexu@linux.alibaba.com>
 <YPXHWmiYXMNxxhf7@redhat.com>
 <99f346bf-e08d-3dad-d931-9d7aeb16ad08@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <99f346bf-e08d-3dad-d931-9d7aeb16ad08@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: miklos@szeredi.hu, virtualization@lists.linux-foundation.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com, stefanha@redhat.com,
 linux-fsdevel@vger.kernel.org
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

On Tue, Jul 20, 2021 at 03:19:50PM +0800, JeffleXu wrote:
> 
> 
> On 7/20/21 2:41 AM, Vivek Goyal wrote:
> > On Fri, Jul 16, 2021 at 06:47:52PM +0800, Jeffle Xu wrote:
> >> Add one flag for fuse_attr.flags indicating if DAX shall be enabled for
> >> this file.
> >>
> >> When the per-file DAX flag changes for an *opened* file, the state of
> >> the file won't be updated until this file is closed and reopened later.
> >>
> >> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> > 
> > [..]
> >> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> >> index 36ed092227fa..90c9df10d37a 100644
> >> --- a/include/uapi/linux/fuse.h
> >> +++ b/include/uapi/linux/fuse.h
> >> @@ -184,6 +184,9 @@
> >>   *
> >>   *  7.34
> >>   *  - add FUSE_SYNCFS
> >> + *
> >> + *  7.35
> >> + *  - add FUSE_ATTR_DAX
> >>   */
> >>  
> >>  #ifndef _LINUX_FUSE_H
> >> @@ -449,8 +452,10 @@ struct fuse_file_lock {
> >>   * fuse_attr flags
> >>   *
> >>   * FUSE_ATTR_SUBMOUNT: Object is a submount root
> >> + * FUSE_ATTR_DAX: Enable DAX for this file in per-file DAX mode
> >>   */
> >>  #define FUSE_ATTR_SUBMOUNT      (1 << 0)
> >> +#define FUSE_ATTR_DAX		(1 << 1)
> > 
> > Generic fuse changes (addition of FUSE_ATTR_DAX) should probably in
> > a separate patch. 
> 
> Got it.
> 
> > 
> > I am not clear on one thing. If we are planning to rely on persistent
> > inode attr (FS_XFLAG_DAX as per Documentation/filesystems/dax.rst), then
> > why fuse server needs to communicate the state of that attr using a 
> > flag? Can client directly query it?  I am not sure where at these
> > attrs stored and if fuse protocol currently supports it.
> 
> There are two issues.
> 
> 1. FUSE server side: Algorithm of deciding whether DAX is enabled for a
> file.
> 
> As I previously replied in [1], FUSE server must enable DAX if the
> backend file is flagged with FS_XFLAG_DAX, to make the FS_XFLAG_DAX
> previously set by FUSE client effective.
> 
> But I will argue that FUSE server also has the flexibility of the
> algorithm implementation. Even if guest queries FS_XFLAG_DAX by
> GETFLAGS/FSGETXATTR ioctl, FUSE server can still enable DAX when the
> backend file is not FS_XFLAG_DAX flagged.
> 
> 
> 2. The protocol between server and client.
> 
> extending LOOKUP vs. LOOKUP + GETFLAGS/FSGETXATTR ioctl
> 
> As I said in [1], client can directly query the FS_XFLAG_DAX flag, but
> there will be one more round trip.
> 
> 
> [1]
> https://lore.kernel.org/linux-fsdevel/031efb1d-7c0d-35fb-c147-dcc3b6cac0ef@linux.alibaba.com/T/#m3f3407158b2c028694c85d82d0d6bd0387f4e24e
> 
> > 
> > What about flag STATX_ATTR_DAX. We probably should report that too
> > in stat if we are using dax on the inode?
> > 
> 
> VFS will automatically report STATX_ATTR_DAX if inode is in DAX mode,
> e.g., in vfs_getattr_nosec().

Good to know. Given user will know which files are using dax and 
which ones are not, it is even more important to define semantics
properly. In what cases DAX will be driven by FS_XFLAGS_DAX attr
and in what cases DAX will completely be driven by server.

May be we should divide it in two patch series. First patch series
implements "-o dax=inode" and server follows FS_XFLAGS_DAX attr
and reports during lookup/getattr/..... 

And once that is merged this can be ehanced with "-o dax=server" where
server is free to choose what files dax should be used on. Only if
this is still needed.

Vivek

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

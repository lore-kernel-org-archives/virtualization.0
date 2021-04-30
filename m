Return-Path: <SRS0=eK/B=J3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA51C433B4
	for <virtualization@archiver.kernel.org>; Fri, 30 Apr 2021 12:18:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2FA0611F1
	for <virtualization@archiver.kernel.org>; Fri, 30 Apr 2021 12:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FA0611F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7BD9E40240;
	Fri, 30 Apr 2021 12:18:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TT3hiLKuGtpD; Fri, 30 Apr 2021 12:18:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2B82A400BD;
	Fri, 30 Apr 2021 12:18:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03CB0C000E;
	Fri, 30 Apr 2021 12:18:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 859F4C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Apr 2021 12:18:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6685540208
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Apr 2021 12:18:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HqkAIbgLf6K0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Apr 2021 12:18:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ACF11400BD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Apr 2021 12:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619785095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QFoo+RFhSNZCaYS4vaZHmUV9XYlNWKNVH9g7dlU2Z6g=;
 b=fDQDQ9oXVqNIUBePKzhV/Kzvg/b8z5FgUmzlUFoYhKR6ecGx5S0yqnEN7M/2nRofXvIDWD
 9TnbzNIqOMfT9d9BjK87IbhUkrRbCIxUU/XA4tyW83pWH0KEF/sIR1OrYTyQsrfJ3++Xdk
 tpgZTtBeYm9s52p6T7CC6VpgrOosC6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-y_bAABREPW-S6Zzk2Wddsw-1; Fri, 30 Apr 2021 08:18:13 -0400
X-MC-Unique: y_bAABREPW-S6Zzk2Wddsw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2016610CE781;
 Fri, 30 Apr 2021 12:18:12 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-26.rdu2.redhat.com [10.10.114.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EFE6719C79;
 Fri, 30 Apr 2021 12:17:57 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 8004322054F; Fri, 30 Apr 2021 08:17:57 -0400 (EDT)
Date: Fri, 30 Apr 2021 08:17:57 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2] virtiofs: propagate sync() to file server
Message-ID: <20210430121757.GA1936051@redhat.com>
References: <20210426151011.840459-1-groug@kaod.org>
 <20210427171206.GA1805363@redhat.com>
 <20210427210921.7b01c661@bahia.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210427210921.7b01c661@bahia.lan>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel@vger.kernel.org,
 Robert Krawitz <rlk@redhat.com>
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

On Tue, Apr 27, 2021 at 09:09:21PM +0200, Greg Kurz wrote:
[..]
> > > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > > index 54442612c48b..1265ca17620c 100644
> > > --- a/include/uapi/linux/fuse.h
> > > +++ b/include/uapi/linux/fuse.h
> > > @@ -179,6 +179,9 @@
> > >   *  7.33
> > >   *  - add FUSE_HANDLE_KILLPRIV_V2, FUSE_WRITE_KILL_SUIDGID, FATTR_KILL_SUIDGID
> > >   *  - add FUSE_OPEN_KILL_SUIDGID
> > > + *
> > > + *  7.34
> > > + *  - add FUSE_SYNCFS
> > >   */
> > >  
> > >  #ifndef _LINUX_FUSE_H
> > > @@ -214,7 +217,7 @@
> > >  #define FUSE_KERNEL_VERSION 7
> > >  
> > >  /** Minor version number of this interface */
> > > -#define FUSE_KERNEL_MINOR_VERSION 33
> > > +#define FUSE_KERNEL_MINOR_VERSION 34
> > >  
> > >  /** The node ID of the root inode */
> > >  #define FUSE_ROOT_ID 1
> > > @@ -499,6 +502,7 @@ enum fuse_opcode {
> > >  	FUSE_COPY_FILE_RANGE	= 47,
> > >  	FUSE_SETUPMAPPING	= 48,
> > >  	FUSE_REMOVEMAPPING	= 49,
> > > +	FUSE_SYNCFS		= 50,
> > >  
> > >  	/* CUSE specific operations */
> > >  	CUSE_INIT		= 4096,
> > > @@ -957,4 +961,8 @@ struct fuse_removemapping_one {
> > >  #define FUSE_REMOVEMAPPING_MAX_ENTRY   \
> > >  		(PAGE_SIZE / sizeof(struct fuse_removemapping_one))
> > >  
> > > +struct fuse_syncfs_in {
> > > +	uint64_t flags;
> > > +};
> > > +
> > 
> > Hi Greg,
> > 
> > Will it be better if 32bits are for flags and reset 32 are
> > padding and can be used in whatever manner.
> > 
> > struct fuse_syncfs_in {
> > 	uint32_t flags;
> > 	uint32_t padding;
> > };
> > 
> > This will increase the flexibility if we were to send more information
> > in future.
> > 
> > I already see bunch of structures where flags are 32 bit and reset
> > are padding bits. fuse_read_in, fuse_write_in, fuse_rename2_in etc.
> > 
> > Thanks
> > Vivek
> > 
> 
> Yes, it makes sense. I'll wait a few more days and roll out a v3.

Thinking more about it. We are not using any of the fields of this
structure right now. So may be all of it can be padding and no need
to add "flags".

struct fuse_syncfs_in {
	uint64_t padding;
};

Essentially what you have already done  :-). Just rename flags to
padding/unused to make it clear its unused for now.

Vivek

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

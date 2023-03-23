Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AD0C6FD1D
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 12:47:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED7F76156C;
	Thu, 23 Mar 2023 12:47:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ED7F76156C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f21S+GO/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PRpowlccn4mE; Thu, 23 Mar 2023 12:47:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 80A6061561;
	Thu, 23 Mar 2023 12:47:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 80A6061561
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21479C0035;
	Thu, 23 Mar 2023 12:47:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50A1CC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 12:47:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B38561568
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 12:47:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B38561568
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AM5Eernnawot
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 12:47:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 379AC61561
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 379AC61561
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 12:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679575642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wYfZJMpNrkEZ/F3L7O50xwvFHvcSjWlpO9iZFIzUt6g=;
 b=f21S+GO/LztEpV3i9Oh/5IB0aC+no4FymxHp44w3PH42KggKcH4Y4dEtaNegNcuKuGl85w
 fcYlU+3ClWPYDyEKZRDOWH6HK9cpQqTf11JoMKCb/iCx2HPWab1Epe9J2OcymrMk4WpRzt
 TwnpXLuaUeXBt5Xre97goGUIpCpZfdk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-100bVLnZNESw7oIrJAkR-Q-1; Thu, 23 Mar 2023 08:47:20 -0400
X-MC-Unique: 100bVLnZNESw7oIrJAkR-Q-1
Received: by mail-ed1-f72.google.com with SMTP id
 dn8-20020a05640222e800b004bd35dd76a9so32376986edb.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 05:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679575639;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wYfZJMpNrkEZ/F3L7O50xwvFHvcSjWlpO9iZFIzUt6g=;
 b=IyAB6KKOZ3ac0+a8FZxbmG9I9/i8t+Tf+79WXJVJBu+HDQ0Jvga3NVO2r+chmYIplQ
 xM5N4y0cDmdbFJE2dWVVTL4PQRFpTsEAxt3QJZwxiwaMvhbv3T0FjU9zjjjyI+LLnMmF
 L/EnRmuxPum00dTZA7Bm6cG561+vk2OcQQfUoe3VpSX7nyey1LpBjB9hee24uBKpZBJh
 9EJq6GWXaNEvsQ3iuTbspxe6wbfBFTSgOWk5uNwqCFALRpUQBM9N53OJI2tAYfvxkDTD
 deZJaaxIG2bL+VVwyCu6bhTCLhO+rwK9GgZNd9jMGccGWej46HK3jT8dEHl0prUHOb2x
 Vg2Q==
X-Gm-Message-State: AO0yUKUcCPldCzxXgRkVFnLPdDoBGO/Gdh/QLVOSdTOuRuBfNDKy66on
 IENGzpYM6n1ohV30YjjrK+/LzQIeX123Z6OoauCK/nmqKFgt34KfFAkr16msbntEQmYH90Tno2v
 k+EAyxuvBlLpVdZOvEqun0niI+o8oziLJ+pk9NuJunQ==
X-Received: by 2002:a17:906:7054:b0:932:4eea:17ce with SMTP id
 r20-20020a170906705400b009324eea17cemr10717163ejj.39.1679575639791; 
 Thu, 23 Mar 2023 05:47:19 -0700 (PDT)
X-Google-Smtp-Source: AK7set9kvskXuqIZ2Tc8VsZs8rA7P/L1Gd2H98L9UlrBHRAQQ4Ckzzp/Alb9KRWggi3nNHeoqR7iKA==
X-Received: by 2002:a17:906:7054:b0:932:4eea:17ce with SMTP id
 r20-20020a170906705400b009324eea17cemr10717145ejj.39.1679575639540; 
 Thu, 23 Mar 2023 05:47:19 -0700 (PDT)
Received: from redhat.com ([2.52.143.71]) by smtp.gmail.com with ESMTPSA id
 hy16-20020a1709068a7000b00931d3509af1sm8521409ejc.222.2023.03.23.05.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Mar 2023 05:47:19 -0700 (PDT)
Date: Thu, 23 Mar 2023 08:47:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 1/1] vhost_task: Fix vhost_task_create return value
Message-ID: <20230323084648-mutt-send-email-mst@kernel.org>
References: <20230322185605.1307-1-michael.christie@oracle.com>
 <20230323033557-mutt-send-email-mst@kernel.org>
 <20230323104445.qidusxeruimeawy6@wittgenstein>
 <20230323073918-mutt-send-email-mst@kernel.org>
 <20230323115049.vsrnufcaqstpxik3@wittgenstein>
MIME-Version: 1.0
In-Reply-To: <20230323115049.vsrnufcaqstpxik3@wittgenstein>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com
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

On Thu, Mar 23, 2023 at 12:50:49PM +0100, Christian Brauner wrote:
> On Thu, Mar 23, 2023 at 07:43:04AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Mar 23, 2023 at 11:44:45AM +0100, Christian Brauner wrote:
> > > On Thu, Mar 23, 2023 at 03:37:19AM -0400, Michael S. Tsirkin wrote:
> > > > On Wed, Mar 22, 2023 at 01:56:05PM -0500, Mike Christie wrote:
> > > > > vhost_task_create is supposed to return the vhost_task or NULL on
> > > > > failure. This fixes it to return the correct value when the allocation
> > > > > of the struct fails.
> > > > > 
> > > > > Fixes: 77feab3c4156 ("vhost_task: Allow vhost layer to use copy_process") # mainline only
> > > > > Reported-by: syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com
> > > > > Signed-off-by: Mike Christie <michael.christie@oracle.com>
> > > > 
> > > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > > > 
> > > > The affected patch is not upstream yet, right?
> > > > I don't know if the tree in question allows rebases - linux-next
> > > > does. So ideally it would be squashed to avoid issues during bisect.
> > > > Still it's error path so I guess not a tragedy even without squashing.
> > > 
> > > I tend to not rebase once stuff has been in linux-next but I make
> > > exceptions as long as it's before -rc4. For now I've put the patch on
> > > top (see the other mail I sent) but if it's really important I can
> > > squash it after the weekend (I'll be mostly afk until then.).
> > 
> > Hard to say how important, but I'd prefer that, yes.
> 
> Ok, fold the fixup into
> 
> e297cd54b3f8 vhost_task: Allow vhost layer to use copy_process
> 
> the series is now at:
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
> branch: kernel.user_worker
> 
> 1a5f8090c6de vhost: move worker thread fields to new struct
> e297cd54b3f8 vhost_task: Allow vhost layer to use copy_process
> 89c8e98d8cfb fork: allow kernel code to call copy_process
> 094717586bf7 fork: Add kernel_clone_args flag to ignore signals
> 11f3f500ec8a fork: add kernel_clone_args flag to not dup/clone files
> 54e6842d0775 fork/vm: Move common PF_IO_WORKER behavior to new flag
> c81cc5819faf kernel: Make io_thread and kthread bit fields
> 73e0c116594d kthread: Pass in the thread's name during creation
> cf587db2ee02 kernel: Allow a kernel thread's name to be set in copy_process
> e0a98139c162 csky: Remove kernel_thread declaration

Thanks a lot! Mike could you give it a spin to make sure all is well?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

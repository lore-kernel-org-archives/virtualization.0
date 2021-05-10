Return-Path: <SRS0=CL3f=KF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBDFC43460
	for <virtualization@archiver.kernel.org>; Mon, 10 May 2021 17:50:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 893B3611F0
	for <virtualization@archiver.kernel.org>; Mon, 10 May 2021 17:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893B3611F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B27A83579;
	Mon, 10 May 2021 17:50:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g0rLLa64pDaB; Mon, 10 May 2021 17:50:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98A4F83440;
	Mon, 10 May 2021 17:50:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A955C000E;
	Mon, 10 May 2021 17:50:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33DECC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 17:50:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 15CE383579
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 17:50:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TLVSdARDqnj1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 17:50:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1893683440
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 17:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620669014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HrqCS5Oeayu/GGO+Glv71VeHRsfWL2u3aYu2EPq2s/s=;
 b=ccNacxYB1+ZOaOUK9k2sfC61Xa+1HaVFdcywMmIijwcSbe6Om+vkJKW2NH6Rho36BJ03fx
 s8M1Hof2qHElqAkRCRelF2BNKMrneyEv61/pBSzyBFjgyTpAHmJL//xEFZc4mxqECPFUQm
 Of37icohipA0OZPccCfUtQHRAy10BiI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-S04TB76sPQOb4nH-3bw1Xg-1; Mon, 10 May 2021 13:50:13 -0400
X-MC-Unique: S04TB76sPQOb4nH-3bw1Xg-1
Received: by mail-qv1-f69.google.com with SMTP id
 b10-20020a0cf04a0000b02901bda1df3afbso13295413qvl.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 10:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HrqCS5Oeayu/GGO+Glv71VeHRsfWL2u3aYu2EPq2s/s=;
 b=E88I8Kvr4DVpDZn20ff4/vfQfGlNV8tGOxf3+1gkmVVHds742mJ+XdCVVnCrEdV+6d
 94SihRTGOPyVJoehkUkvq+bpn8dozwgruyAqjEMgZTlYimo30tRtS/xkaUuV1zU4q7MC
 rurS4vu0aKy+OlaZzWItqQk9V2+rHKztJc+Vm2NxXRKTuoA02m8xeF64go2hphmCE56/
 Saf0eLAyVJH4PGRoHwwWqNfbeF7l9oVeLeiGnpk0PVCOWUOSen/vD/EtApZEQ+F1bAUm
 4D7y+eRMKt9zLe9PbRNan59zgWhekgipW0EeeVb8nUKsnjpj0KX65ouLhteUS9z0ThkG
 vTEA==
X-Gm-Message-State: AOAM533VSb2jv3OnC1mWxt4GYsJeps1HNe8B+/Si2ImMWgZSPLGZ3u3v
 DC9hTB8IfcJOdIsAuQySdTphoUubxjgSvso7QvMEdyl5GJ+XJF6ACYiVEGInR77eTWFIDkruhJd
 Nxs0GxP1IhX9EpBBYG4FVN+k8VMjcCzvrjYAG01c2ew==
X-Received: by 2002:a05:622a:1704:: with SMTP id
 h4mr24083009qtk.30.1620669012582; 
 Mon, 10 May 2021 10:50:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmt6+0BWlVnZlV/PtV9/dBz1kber3TFT7OWUo13/1RCo5dtYbA+CAwLxA56a9L0aqFp/U7hg==
X-Received: by 2002:a05:622a:1704:: with SMTP id
 h4mr24082994qtk.30.1620669012371; 
 Mon, 10 May 2021 10:50:12 -0700 (PDT)
Received: from horse (pool-173-76-174-238.bstnma.fios.verizon.net.
 [173.76.174.238])
 by smtp.gmail.com with ESMTPSA id b7sm12167033qkj.126.2021.05.10.10.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 May 2021 10:50:11 -0700 (PDT)
Date: Mon, 10 May 2021 13:50:09 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Connor Kuehl <ckuehl@redhat.com>
Subject: Re: [PATCH] virtiofs: Enable multiple request queues
Message-ID: <20210510175009.GB177952@horse>
References: <20210507221527.699516-1-ckuehl@redhat.com>
 <20210510152506.GC150402@horse>
 <ddbc96c7-655c-e563-e26e-6550a0cdd7c1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ddbc96c7-655c-e563-e26e-6550a0cdd7c1@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel@vger.kernel.org
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

On Mon, May 10, 2021 at 11:15:21AM -0500, Connor Kuehl wrote:
> On 5/10/21 10:25 AM, Vivek Goyal wrote:
> > On Fri, May 07, 2021 at 03:15:27PM -0700, Connor Kuehl wrote:
> >> Distribute requests across the multiqueue complex automatically based
> >> on the IRQ affinity.
> > 
> > Hi Connor,
> > 
> > Thanks for the patch. I will look into it and also test it.
> > 
> > How did you test it? Did you modify vitiofsd to support multiqueue. Did
> > you also run some performance numbers. Does it provide better/worse
> > performance as compared to single queue.
> 
> Thanks, Vivek! I need to NACK this version of the patch for inclusion
> though since I think the way I did per-CPU state will not work for
> multiple virtio-fs mounts because it will be overwritten with each new
> mount, but for testing purposes this should be OK with just one mount.

Hi Connor,

Ok. Will wait for next version which fixes the multiple mount issue.

> 
> I need to do more benchmarking on this.

That would be nice.

> 
> I had to hack multiqueue support into virtiofsd, which runs against the
> warning in the virtiofsd source code that instructs people to *not*
> enable multiqueue due to thread-safety concerns. I didn't audit
> virtiofsd for correctness, so I also worry this has the potential of
> affecting benchmarks if there are races.

filesystem code already can handle multiple threads because on a single
queue we can have a thread pool processing requests in parallel. I am
not aware of any issues about supporting multiple queues. I think
may be fuse_virtio.c might require a little closer inspection to make
sure nothing is dependent on single queue. 

> 
> For testing, QEMU needs to be invoked with `num-request-queues` like
> this:
> 
> 	-device vhost-user-fs-pci,chardev=char0,tag=myfs,num-request-queues=2 
> 
> And obviously you can choose any value >= 1 for num-request-queues.
> 
> and I also made a quick-and-dirty hack to let me pass in the number of
> total queues to virtiofsd on the command line:

Ok. May be there is some inspiration to take from virtio-blk. How do they
specific number of queues by default and how many. I thought stefan mentioned
that by default there is one queue per vcpu.

Vivek

> 
> diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowlevel.c
> index 58e32fc963..cf8f132efd 100644
> --- a/tools/virtiofsd/fuse_lowlevel.c
> +++ b/tools/virtiofsd/fuse_lowlevel.c
> @@ -2565,9 +2565,9 @@ out1:
>      return NULL;
>  }
>  
> -int fuse_session_mount(struct fuse_session *se)
> +int fuse_session_mount(struct fuse_session *se, unsigned int num_queues)
>  {
> -    return virtio_session_mount(se);
> +    return virtio_session_mount(se, num_queues);
>  }
>  
>  int fuse_session_fd(struct fuse_session *se)
> diff --git a/tools/virtiofsd/fuse_lowlevel.h b/tools/virtiofsd/fuse_lowlevel.h
> index 3bf786b034..50bf86113d 100644
> --- a/tools/virtiofsd/fuse_lowlevel.h
> +++ b/tools/virtiofsd/fuse_lowlevel.h
> @@ -1842,7 +1842,7 @@ struct fuse_session *fuse_session_new(struct fuse_args *args,
>   *
>   * @return 0 on success, -1 on failure.
>   **/
> -int fuse_session_mount(struct fuse_session *se);
> +int fuse_session_mount(struct fuse_session *se, unsigned int num_queues);
>  
>  /**
>   * Enter a single threaded, blocking event loop.
> diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
> index 3e13997406..8622c3dce6 100644
> --- a/tools/virtiofsd/fuse_virtio.c
> +++ b/tools/virtiofsd/fuse_virtio.c
> @@ -747,20 +747,6 @@ static void fv_queue_set_started(VuDev *dev, int qidx, bool started)
>               started);
>      assert(qidx >= 0);
>  
> -    /*
> -     * Ignore additional request queues for now.  passthrough_ll.c must be
> -     * audited for thread-safety issues first.  It was written with a
> -     * well-behaved client in mind and may not protect against all types of
> -     * races yet.
> -     */
> -    if (qidx > 1) {
> -        fuse_log(FUSE_LOG_ERR,
> -                 "%s: multiple request queues not yet implemented, please only "
> -                 "configure 1 request queue\n",
> -                 __func__);
> -        exit(EXIT_FAILURE);
> -    }
> -
>      if (started) {
>          /* Fire up a thread to watch this queue */
>          if (qidx >= vud->nqueues) {
> @@ -997,7 +983,7 @@ static int fv_create_listen_socket(struct fuse_session *se)
>      return 0;
>  }
>  
> -int virtio_session_mount(struct fuse_session *se)
> +int virtio_session_mount(struct fuse_session *se, unsigned int num_queues)
>  {
>      int ret;
>  
> @@ -1048,8 +1034,8 @@ int virtio_session_mount(struct fuse_session *se)
>      se->vu_socketfd = data_sock;
>      se->virtio_dev->se = se;
>      pthread_rwlock_init(&se->virtio_dev->vu_dispatch_rwlock, NULL);
> -    if (!vu_init(&se->virtio_dev->dev, 2, se->vu_socketfd, fv_panic, NULL,
> -                 fv_set_watch, fv_remove_watch, &fv_iface)) {
> +    if (!vu_init(&se->virtio_dev->dev, num_queues, se->vu_socketfd,
> +		 fv_panic, NULL, fv_set_watch, fv_remove_watch, &fv_iface)) {
>          fuse_log(FUSE_LOG_ERR, "%s: vu_init failed\n", __func__);
>          return -1;
>      }
> diff --git a/tools/virtiofsd/fuse_virtio.h b/tools/virtiofsd/fuse_virtio.h
> index 111684032c..a0e78b9b84 100644
> --- a/tools/virtiofsd/fuse_virtio.h
> +++ b/tools/virtiofsd/fuse_virtio.h
> @@ -18,7 +18,7 @@
>  
>  struct fuse_session;
>  
> -int virtio_session_mount(struct fuse_session *se);
> +int virtio_session_mount(struct fuse_session *se, unsigned int num_queues);
>  void virtio_session_close(struct fuse_session *se);
>  int virtio_loop(struct fuse_session *se);
>  
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index 1553d2ef45..9fd4e34980 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -161,6 +161,7 @@ struct lo_data {
>      int allow_direct_io;
>      int announce_submounts;
>      bool use_statx;
> +    int num_vqs;
>      struct lo_inode root;
>      GHashTable *inodes; /* protected by lo->mutex */
>      struct lo_map ino_map; /* protected by lo->mutex */
> @@ -204,6 +205,7 @@ static const struct fuse_opt lo_opts[] = {
>      { "announce_submounts", offsetof(struct lo_data, announce_submounts), 1 },
>      { "killpriv_v2", offsetof(struct lo_data, user_killpriv_v2), 1 },
>      { "no_killpriv_v2", offsetof(struct lo_data, user_killpriv_v2), 0 },
> +    { "num_queues=%d", offsetof(struct lo_data, num_vqs), 2 },
>      FUSE_OPT_END
>  };
>  static bool use_syslog = false;
> @@ -3848,6 +3850,12 @@ int main(int argc, char *argv[])
>          exit(1);
>      }
>  
> +    if (lo.num_vqs < 2) {
> +        fuse_log(FUSE_LOG_ERR, "num_queues must be at least 2 (got %d)\n",
> +                 lo.num_vqs);
> +        exit(1);
> +    }
> +
>      lo.use_statx = true;
>  
>      se = fuse_session_new(&args, &lo_oper, sizeof(lo_oper), &lo);
> @@ -3859,7 +3867,7 @@ int main(int argc, char *argv[])
>          goto err_out2;
>      }
>  
> -    if (fuse_session_mount(se) != 0) {
> +    if (fuse_session_mount(se, lo.num_vqs) != 0) {
>          goto err_out3;
>      }
>  
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

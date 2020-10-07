Return-Path: <SRS0=KkKJ=DO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E4DC4363C
	for <virtualization@archiver.kernel.org>; Wed,  7 Oct 2020 10:48:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C232080A
	for <virtualization@archiver.kernel.org>; Wed,  7 Oct 2020 10:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SrcAbS4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C232080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4BFC522621;
	Wed,  7 Oct 2020 10:48:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KGWlrnFyxqln; Wed,  7 Oct 2020 10:48:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A52152226B;
	Wed,  7 Oct 2020 10:48:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 972C2C016F;
	Wed,  7 Oct 2020 10:48:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AAF9C0051
 for <virtualization@lists.linuxfoundation.org>;
 Wed,  7 Oct 2020 10:48:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id ED792861F4
 for <virtualization@lists.linuxfoundation.org>;
 Wed,  7 Oct 2020 10:48:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k4dB-9NxM7Id
 for <virtualization@lists.linuxfoundation.org>;
 Wed,  7 Oct 2020 10:48:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2B0E1861AF
 for <virtualization@lists.linuxfoundation.org>;
 Wed,  7 Oct 2020 10:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602067695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ya6O5cqck50WgGNUT5w2qYKSjg7Ab2CofO7s+gDR1Hk=;
 b=SrcAbS4dqjU7VO7IkzVhNBjiX/fXERkEVYRkgORgE7O8xfPNsjZe/rQf4oc6n2tm16upBC
 e6oiiaOg+OEniV/4KryAlGm95Z8U4g839QOt6fjoR6i1exbnOOwFMxiP4CXF57YHD1WhEq
 eSvodPkOKOel1wSy5ft7KJv2MnJbD40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-1DK8heIuM4eNb_aMJAorLA-1; Wed, 07 Oct 2020 06:48:11 -0400
X-MC-Unique: 1DK8heIuM4eNb_aMJAorLA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19A09420F0;
 Wed,  7 Oct 2020 10:48:09 +0000 (UTC)
Received: from work-vm (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DBF7C5C1BD;
 Wed,  7 Oct 2020 10:48:02 +0000 (UTC)
Date: Wed, 7 Oct 2020 11:48:00 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH  01/19] tools/virtiofsd: add support for --socket-group
Message-ID: <20201007104800.GB3085@work-vm>
References: <20200925125147.26943-1-alex.bennee@linaro.org>
 <20200925125147.26943-2-alex.bennee@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200925125147.26943-2-alex.bennee@linaro.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: jean-philippe@linaro.org, maxim.uvarov@linaro.org, bing.zhu@intel.com,
 Matti.Moell@opensynergy.com, virtualization@lists.linuxfoundation.org,
 ilias.apalodimas@linaro.org, qemu-devel@nongnu.org, arnd@linaro.org,
 hmo@opensynergy.com, takahiro.akashi@linaro.org,
 Stefan Hajnoczi <stefanha@redhat.com>, joakim.bech@linaro.org,
 stratos-dev@op-lists.linaro.org, tomas.winkler@intel.com, yang.huang@intel.com
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

* Alex Benn=C3=A9e (alex.bennee@linaro.org) wrote:
> If you like running QEMU as a normal user (very common for TCG runs)
> but you have to run virtiofsd as a root user you run into connection
> problems. Adding support for an optional --socket-group allows the
> users to keep using the command line.
> =

> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Queued

> ---
> v1
>   - tweak documentation and commentary
> ---
>  docs/tools/virtiofsd.rst        |  4 ++++
>  tools/virtiofsd/fuse_i.h        |  1 +
>  tools/virtiofsd/fuse_lowlevel.c |  6 ++++++
>  tools/virtiofsd/fuse_virtio.c   | 20 ++++++++++++++++++--
>  4 files changed, 29 insertions(+), 2 deletions(-)
> =

> diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
> index e33c81ed41f1..085f9b12a6a3 100644
> --- a/docs/tools/virtiofsd.rst
> +++ b/docs/tools/virtiofsd.rst
> @@ -87,6 +87,10 @@ Options
>  =

>    Listen on vhost-user UNIX domain socket at PATH.
>  =

> +.. option:: --socket-group=3DGROUP
> +
> +  Set the vhost-user UNIX domain socket gid to GROUP.
> +
>  .. option:: --fd=3DFDNUM
>  =

>    Accept connections from vhost-user UNIX domain socket file descriptor =
FDNUM.
> diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
> index 1240828208ab..492e002181e2 100644
> --- a/tools/virtiofsd/fuse_i.h
> +++ b/tools/virtiofsd/fuse_i.h
> @@ -68,6 +68,7 @@ struct fuse_session {
>      size_t bufsize;
>      int error;
>      char *vu_socket_path;
> +    char *vu_socket_group;
>      int   vu_listen_fd;
>      int   vu_socketfd;
>      struct fv_VuDev *virtio_dev;
> diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowle=
vel.c
> index 2dd36ec03b6e..4d1ba2925d1b 100644
> --- a/tools/virtiofsd/fuse_lowlevel.c
> +++ b/tools/virtiofsd/fuse_lowlevel.c
> @@ -2523,6 +2523,7 @@ static const struct fuse_opt fuse_ll_opts[] =3D {
>      LL_OPTION("--debug", debug, 1),
>      LL_OPTION("allow_root", deny_others, 1),
>      LL_OPTION("--socket-path=3D%s", vu_socket_path, 0),
> +    LL_OPTION("--socket-group=3D%s", vu_socket_group, 0),
>      LL_OPTION("--fd=3D%d", vu_listen_fd, 0),
>      LL_OPTION("--thread-pool-size=3D%d", thread_pool_size, 0),
>      FUSE_OPT_END
> @@ -2630,6 +2631,11 @@ struct fuse_session *fuse_session_new(struct fuse_=
args *args,
>                   "fuse: --socket-path and --fd cannot be given together\=
n");
>          goto out4;
>      }
> +    if (se->vu_socket_group && !se->vu_socket_path) {
> +        fuse_log(FUSE_LOG_ERR,
> +                 "fuse: --socket-group can only be used with --socket-pa=
th\n");
> +        goto out4;
> +    }
>  =

>      se->bufsize =3D FUSE_MAX_MAX_PAGES * getpagesize() + FUSE_BUFFER_HEA=
DER_SIZE;
>  =

> diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
> index 9e5537506c16..7942d3d11a87 100644
> --- a/tools/virtiofsd/fuse_virtio.c
> +++ b/tools/virtiofsd/fuse_virtio.c
> @@ -31,6 +31,8 @@
>  #include <sys/socket.h>
>  #include <sys/types.h>
>  #include <sys/un.h>
> +#include <sys/types.h>
> +#include <grp.h>
>  #include <unistd.h>
>  =

>  #include "contrib/libvhost-user/libvhost-user.h"
> @@ -924,15 +926,29 @@ static int fv_create_listen_socket(struct fuse_sess=
ion *se)
>  =

>      /*
>       * Unfortunately bind doesn't let you set the mask on the socket,
> -     * so set umask to 077 and restore it later.
> +     * so set umask appropriately and restore it later.
>       */
> -    old_umask =3D umask(0077);
> +    if (se->vu_socket_group) {
> +        old_umask =3D umask(S_IROTH | S_IWOTH | S_IXOTH);
> +    } else {
> +        old_umask =3D umask(S_IRGRP | S_IWGRP | S_IXGRP | S_IROTH | S_IW=
OTH | S_IXOTH);
> +    }
>      if (bind(listen_sock, (struct sockaddr *)&un, addr_len) =3D=3D -1) {
>          fuse_log(FUSE_LOG_ERR, "vhost socket bind: %m\n");
>          close(listen_sock);
>          umask(old_umask);
>          return -1;
>      }
> +    if (se->vu_socket_group) {
> +        struct group *g =3D getgrnam(se->vu_socket_group);
> +        if (g) {
> +            if (!chown(se->vu_socket_path, -1, g->gr_gid)) {
> +                fuse_log(FUSE_LOG_WARNING,
> +                         "vhost socket failed to set group to %s (%d)\n",
> +                         se->vu_socket_group, g->gr_gid);
> +            }
> +        }
> +    }
>      umask(old_umask);
>  =

>      if (listen(listen_sock, 1) =3D=3D -1) {
> -- =

> 2.20.1
> =

-- =

Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

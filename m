Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A37C001DF
	for <virtualization@archiver.kernel.org>; Wed, 26 Jul 2023 18:38:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB372837A4;
	Wed, 26 Jul 2023 18:38:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EB372837A4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i0oJ/x71
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rAjp1hxTL981; Wed, 26 Jul 2023 18:38:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 85CF782F31;
	Wed, 26 Jul 2023 18:38:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 85CF782F31
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54CACC0071;
	Wed, 26 Jul 2023 18:38:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEB01C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 18:38:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B8C038366E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 18:38:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B8C038366E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JCXlBN1OGFon
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 18:38:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A74982F31
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 18:38:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A74982F31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690396700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0ZkfxuuQUI6WS1OsCy4f4xk/TS/NLkS7ZKlAlhCGBD4=;
 b=i0oJ/x71pY4hcc4ApJlqbN1g+GUDIS9Vg8iTAS/adzcXN0rx6T+QevqxWNtd4HwXrlfwin
 BN7Aq0TOqiQukLTuANQ9mLCyreHgSJH8gfpc4sV1qdQir1s98eXE0YJTCJIMXsgFv9tKP1
 KQaLFFR9LPbvOkkGyizM7GwJ1PxGkUo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-YArg2sObMw2T1FEpzYEzKA-1; Wed, 26 Jul 2023 14:38:17 -0400
X-MC-Unique: YArg2sObMw2T1FEpzYEzKA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b6f0527454so457961fa.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 11:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690396696; x=1691001496;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ZkfxuuQUI6WS1OsCy4f4xk/TS/NLkS7ZKlAlhCGBD4=;
 b=J2cKbQaSXiNYL2nc7DjBN0OmWasIUkxbqddxQ6fOcXDGzCj2QTq57Ca0KvxwHg2kwC
 ZpY5thqZE+WNqGiv36EVKZpV+m/CfQ/Ak55JoWgUlbcc8/908ehkuZf4aWNoTaSbqet6
 419TpiFSB+cRu+COCTnfcWHjOWsI+6yvMn+d1svG88uoRT8qSs59X8yrSbSxVA6Y+2qF
 6/0FVnMGYJV9SI43xU78qGGT1+lFiveN6kufRmEv78qsQmGW829qlTKJv49r1a7qLmBx
 SHYC1Ir/OYGv2XfLwn8aaq5d1LOZ2bx7CBW6d9EwxkQDnCy9TnBV1JvdIkEH+RxnFUkg
 N6aA==
X-Gm-Message-State: ABy/qLaZvTX2jYnTpVK7oSBvoecog3IxIujDdxCvnn0HhITJJSz1Gfs2
 wuORqOlDLeEMcXym72yf4JsaeXWNV5FxyVDTIYix2OAkZhcmT5l/JhpzZ6KLmTu1CvUVw9dehJL
 +Xo1SJ+i40Paa9CociugWTwdooRnvNR2Ag/c+O5MOGQ==
X-Received: by 2002:a05:6512:32aa:b0:4fe:d9e:a47 with SMTP id
 q10-20020a05651232aa00b004fe0d9e0a47mr2160158lfe.69.1690396696359; 
 Wed, 26 Jul 2023 11:38:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGrmEcx/kJue2Mk0wlq5n2w2uLYFHBteYJyc3Ij9fkV7DF4dbhcJqImI+mNTHeim2phb5ANfA==
X-Received: by 2002:a05:6512:32aa:b0:4fe:d9e:a47 with SMTP id
 q10-20020a05651232aa00b004fe0d9e0a47mr2160137lfe.69.1690396695997; 
 Wed, 26 Jul 2023 11:38:15 -0700 (PDT)
Received: from redhat.com ([2.52.14.22]) by smtp.gmail.com with ESMTPSA id
 v2-20020a170906380200b0099b6becb107sm8669173ejc.95.2023.07.26.11.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 11:38:14 -0700 (PDT)
Date: Wed, 26 Jul 2023 14:38:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH RFC net-next v5 10/14] virtio/vsock: add
 VIRTIO_VSOCK_F_DGRAM feature bit
Message-ID: <20230726143736-mutt-send-email-mst@kernel.org>
References: <20230413-b4-vsock-dgram-v5-0-581bd37fdb26@bytedance.com>
 <20230413-b4-vsock-dgram-v5-10-581bd37fdb26@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230413-b4-vsock-dgram-v5-10-581bd37fdb26@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-hyperv@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 kvm@vger.kernel.org, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Simon Horman <simon.horman@corigine.com>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryantan@vmware.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Krasnov Arseniy <oxffffaa@gmail.com>,
 Vishnu Dasa <vdasa@vmware.com>, Jiang Wang <jiang.wang@bytedance.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

On Wed, Jul 19, 2023 at 12:50:14AM +0000, Bobby Eshleman wrote:
> This commit adds a feature bit for virtio vsock to support datagrams.
> 
> Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
> Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> ---
>  include/uapi/linux/virtio_vsock.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
> index 331be28b1d30..27b4b2b8bf13 100644
> --- a/include/uapi/linux/virtio_vsock.h
> +++ b/include/uapi/linux/virtio_vsock.h
> @@ -40,6 +40,7 @@
>  
>  /* The feature bitmap for virtio vsock */
>  #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
> +#define VIRTIO_VSOCK_F_DGRAM		3	/* SOCK_DGRAM supported */
>  
>  struct virtio_vsock_config {
>  	__le64 guest_cid;

pls do not add interface without first getting it accepted in the
virtio spec.

> -- 
> 2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

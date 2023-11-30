Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394FD3C076
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQ5xgUIL"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C908943597
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 10:45:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C908943597
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gQ5xgUIL
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sBG90YVIsmz1
	for <virtualization@lists.linux-foundation.org>;
	Thu, 30 Nov 2023 10:45:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5E96840116
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 10:45:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5E96840116
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701341152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B+/fVsomVnX5cZm/evhOjmLgbPyA21ZG8SCMHLJVHq4=;
	b=gQ5xgUILeCTeLo31FT7Ldt7U/qiQKRT0hnklTv7ZcELY6BxDsUfnpYHBYfjdxSeN22f1/y
	rdVdBz1b8bk0roGDck3c30iGGk4S2TNndVGXuNXWN956qt3JSdCk/R+wnFcpfmN9mbNh7B
	LtwzUW6jSAcgAbl7GaZeRRG4jWuaL2Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-OLZFXKnQP1Crrsx30t4GhA-1; Thu, 30 Nov 2023 05:45:48 -0500
X-MC-Unique: OLZFXKnQP1Crrsx30t4GhA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-332fcd4b871so555054f8f.0
        for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 02:45:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701341147; x=1701945947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+/fVsomVnX5cZm/evhOjmLgbPyA21ZG8SCMHLJVHq4=;
        b=hbA+CGfyIu5/A6YVTwIGU8gpFDdKPLc5BJ8CiYJR5aoRrBoaLBjabtxTe3l+bUe/bq
         GxtFynL+IfGusEKpadmaI/dLZ/9VNckOO4Mm4OBqg89CqomjIaSstrIyJ9/tejIXBONV
         F74NJEJsVZ19EITZ6lTBjMUkufj1Y2cKFG2F2BSvbr/ZgFz0A6VGrnZDujNn+mLjcWaK
         aU0hBc1Ix0f2GQlHl+SNW8JyO8FsH9bvst5Ccu99hT3nAHeuI27oULDPUQS8wqLjRVAm
         BlrAMM+m96HpYt2XIjY0fh6j1IKt6zit3cYs4ovAAT7BDifMT2hsm6utY8o8o9yi65Wq
         Af5A==
X-Gm-Message-State: AOJu0YwgoNdQq6OKV6Y2h5mRJRhjsjJJdvQx245XoqJ6HN8Jcm9OOXC3
	r2n96bFx8b79YF7bWjl324twvXucNSRo/LOASmFz2V8LZJqDb98rN0XTYyhqp3zx4rQZLLSludV
	p34Lo9jjr21VA9otWtQFy+FizOI9yJS7n8ir4A5ZuZw==
X-Received: by 2002:adf:e847:0:b0:333:a20:f824 with SMTP id d7-20020adfe847000000b003330a20f824mr6187505wrn.17.1701341146989;
        Thu, 30 Nov 2023 02:45:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECV7SLySk5Xo4ac8CHxyIpb+No3gMIcORmfV3LcmSIsbK8lAAd+6tPhREEsDfpfWv2FoUlIg==
X-Received: by 2002:adf:e847:0:b0:333:a20:f824 with SMTP id d7-20020adfe847000000b003330a20f824mr6187483wrn.17.1701341146606;
        Thu, 30 Nov 2023 02:45:46 -0800 (PST)
Received: from redhat.com ([2.55.10.128])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d60c4000000b00332cbd59f8bsm1185570wrt.25.2023.11.30.02.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 02:45:45 -0800 (PST)
Date: Thu, 30 Nov 2023 05:45:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: alex.williamson@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	parav@nvidia.com, feliu@nvidia.com, jiri@nvidia.com,
	kevin.tian@intel.com, joao.m.martins@oracle.com,
	si-wei.liu@oracle.com, leonro@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH V4 vfio 4/9] virtio-pci: Introduce admin commands
Message-ID: <20231130054453-mutt-send-email-mst@kernel.org>
References: <20231129143746.6153-1-yishaih@nvidia.com>
 <20231129143746.6153-5-yishaih@nvidia.com>
 <20231130044910-mutt-send-email-mst@kernel.org>
 <aaa83d6a-779d-44cb-a72e-83ba9c8db76b@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aaa83d6a-779d-44cb-a72e-83ba9c8db76b@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 30, 2023 at 12:35:09PM +0200, Yishai Hadas wrote:
> On 30/11/2023 11:52, Michael S. Tsirkin wrote:
> > On Wed, Nov 29, 2023 at 04:37:41PM +0200, Yishai Hadas wrote:
> > > +/* Transitional device admin command. */
> > > +#define VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE	0x2
> > > +#define VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ		0x3
> > > +#define VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE		0x4
> > > +#define VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ		0x5
> > > +#define VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO		0x6
> > > +
> > > +/* Increment MAX_OPCODE to next value when new opcode is added */
> > > +#define VIRTIO_ADMIN_MAX_CMD_OPCODE			0x6
> > 
> > Does anything need VIRTIO_ADMIN_MAX_CMD_OPCODE? Not in this
> > patchset...
> > 
> 
> Right, once you suggested to move to 'u64 supported_cmds' it's not any more
> in use.
> 
> It still can be used in the future, however I can drop it if it's worth a V5
> sending.
> 
> Yishai

If you don't need it then yea, we need to be careful about what we put in uapi headers.
wait with v5 until others can review v4 though.

-- 
MST


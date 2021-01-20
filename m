Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04868C433DB
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 07:53:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6452E23131
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 07:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6452E23131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3B04185B4D;
	Wed, 20 Jan 2021 07:53:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6u4EczlSXMDo; Wed, 20 Jan 2021 07:53:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B1EBC85085;
	Wed, 20 Jan 2021 07:53:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4A75C088B;
	Wed, 20 Jan 2021 07:53:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D446C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 07:53:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8AC2B86D52
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 07:53:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ssxoiqPKCmUx
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 07:53:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 007F88693C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 07:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611129223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WlP6HTPmgS7QcwkM412p+X8zJad//nJVCA8QPjKz66o=;
 b=UKx501GX6Qxlj1HjswjcWlKgyuYfIwBfeVCGyzQ+jV4MrFZ244P8u9LeiRx5kZ/nqsmpVR
 34UE4Z9ApTa8ZMz0hE3Y2xoqtGTiUQooarcY+KycQ/yilEw/UWH2G7jFVRFuSWfuhrPEJ7
 KyKocvjC7THPJmkBnFaLERteMU8jc/g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-Y4iaf4WcMN63lnh0NYbxoA-1; Wed, 20 Jan 2021 02:53:41 -0500
X-MC-Unique: Y4iaf4WcMN63lnh0NYbxoA-1
Received: by mail-wm1-f72.google.com with SMTP id d2so967655wmc.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 23:53:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WlP6HTPmgS7QcwkM412p+X8zJad//nJVCA8QPjKz66o=;
 b=K1HvrdgAXFAiAu3WRDnfQHuZlbF8GdmOGA9pE9F9aelGjVcXlJ4qJ42ZY+RjGSYmdW
 7rni2Q9AZ3voFMGTizEQ9xOFtHePVWUfdKEecS0y4D2Jj0zYyrQZS0LFgn1LQBBySLjy
 T38v5dtRMzJtttjGEsVhShfVXGCtJ8808uQbYC9BgHOonlOZFnqB33X4kh+kxu9vA/kC
 F9cRnNLg2ntBsdOCE8w73YUQINqF+UquJwK0DWb2o4rk3O9tyXyWrKYNawAx7IHqkXhY
 /5W51aIb0rLV8g5t1xzSOGOI2R1RoFnwyMy36cUXbdvoJ9qOEoH9VYfU3uMg9zJIYKno
 azgw==
X-Gm-Message-State: AOAM533XNEopJ+kF7K/ZJbD5ybNznAboCULhysimT3ReoN7qvRSw7Yez
 eE3TqY9z8QXhikGEjkV3u2UueReR4OFZJhR6CKDMcpH/gZ6fqWLU3b6vqg6JD2JxI++U0QX4hQz
 eq+Y0soRV9t4NOjJUKntYFEc7zPPWgZAbvSABp/oI5w==
X-Received: by 2002:a5d:5112:: with SMTP id s18mr7751744wrt.267.1611129220866; 
 Tue, 19 Jan 2021 23:53:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXLH//Uy8f5/X2BagDxiDXrol049atvxYIO2T3hpG/SPBNOzX/Q9yiywJPE8c+vCWAtYa52Q==
X-Received: by 2002:a5d:5112:: with SMTP id s18mr7751727wrt.267.1611129220717; 
 Tue, 19 Jan 2021 23:53:40 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
 by smtp.gmail.com with ESMTPSA id a16sm1374033wrr.89.2021.01.19.23.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jan 2021 23:53:39 -0800 (PST)
Date: Wed, 20 Jan 2021 02:53:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH linux-next v3 6/6] vdpa_sim_net: Add support for user
 supported devices
Message-ID: <20210120025249-mutt-send-email-mst@kernel.org>
References: <20210105064707-mutt-send-email-mst@kernel.org>
 <BY5PR12MB4322E5E7CA71CB2EE0577706DCD10@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20210105071101-mutt-send-email-mst@kernel.org>
 <BY5PR12MB432235169D805760EC0CF7CEDCD10@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20210105082243-mutt-send-email-mst@kernel.org>
 <BY5PR12MB4322EC8D0AD648063C607E17DCAF0@BY5PR12MB4322.namprd12.prod.outlook.com>
 <66dc44ac-52da-eaba-3f5e-69254e42d75b@redhat.com>
 <BY5PR12MB43225D83EA46004E3AF50D3ADCA80@BY5PR12MB4322.namprd12.prod.outlook.com>
 <01213588-d4af-820a-bcf8-c28b8a80c346@redhat.com>
 <BY5PR12MB432239B28EC63D80791E1459DCA40@BY5PR12MB4322.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB432239B28EC63D80791E1459DCA40@BY5PR12MB4322.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Mon, Jan 18, 2021 at 06:03:57PM +0000, Parav Pandit wrote:
> Hi Michael, Jason,
> 
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Friday, January 15, 2021 11:09 AM
> > 
> > 
> > Thanks for the clarification. I think we'd better document the above in the
> > patch that introduces the mac setting from management API.
> 
> Can we proceed with this patchset?
> We like to progress next to iproute2/vdpa, mac and other drivers post this series in this kernel version.

Let me put this in next so it can get some testing there for a week or
so.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

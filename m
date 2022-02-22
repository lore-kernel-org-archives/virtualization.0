Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4F5C433EF
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 08:11:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 603C6405A0;
	Tue, 22 Feb 2022 08:11:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JJ6OOLKfdScb; Tue, 22 Feb 2022 08:11:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9B832405A3;
	Tue, 22 Feb 2022 08:11:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72EEBC001A;
	Tue, 22 Feb 2022 08:11:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28FD7C0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 08:11:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6132260B83
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 08:11:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gkgHIVniJBe4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 08:11:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9211C60BCF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 08:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645517475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G0GfwrcLD4lf4ANifuaF1OYMcDG4+GeX0AlNzDkoZxA=;
 b=WhxAOV8g/z3PucRBMeS8Oplab5dOAYwrIV4kYFzlcAll4G7vPTFcphnoBlhCJfmVbScCa7
 SOo5dBevI8f6ITQ9xE97RtmQcp8fOLAhNoLS6OORpRhmblFiejn6SmEBmHFpjwTrHrmO71
 yctE5FM3URdueDdJR6iTxwNORTt7msg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-cBRd6sCsO4WgbYJ47-rUsg-1; Tue, 22 Feb 2022 03:11:11 -0500
X-MC-Unique: cBRd6sCsO4WgbYJ47-rUsg-1
Received: by mail-qv1-f69.google.com with SMTP id
 g2-20020a0562141cc200b004123b0abe18so20176540qvd.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 00:11:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=G0GfwrcLD4lf4ANifuaF1OYMcDG4+GeX0AlNzDkoZxA=;
 b=tnBP3Hl0BFvGXFlyv9D5s1pCPJ+w+tA57AqUDGgLoSA1HmeMwlGxJJAvFJwCj9i5dW
 xzIU23KhxaSRfsp1qXRj7+IW8vvEqoa//RQur54nMY2bXULfAKyDjwG7AieHVE/SvNEP
 UAyffNOnbZxa+qbFqgTS2wEHEkUSTfIKb4NugVsY/61TsOmuBbKWJFLdmTjSa6bChe0S
 4o/3DFDpEyKIVCvRXav2zpTSe5tuBBZT91mXeMrnV1w3Tti6/LP45Q6WWeK4zr7hjkUL
 9vY8XUW566pG7B253QzbXhL6BfLFLaTFKSdYNBKzXnNNC9NKY5oRrbbyTvRO2jKdprc/
 h1Zw==
X-Gm-Message-State: AOAM531rR05+cVobYEbiZZ7jed2Y1JrrtnS4UNOF3zvnvleY/vdcuggA
 n/oFTAm7cmNP/RBEjbJm7J6hLiZ0f1xteNIAf6zKqCc1KSqZoAWj1qG4kTP+aTfGRm8vnl1GNrQ
 bx2yPHt2V3zpoQHK2IlhwKykxDNlOhXEj1VYpwvoGhA==
X-Received: by 2002:a05:620a:3706:b0:648:afb4:5794 with SMTP id
 de6-20020a05620a370600b00648afb45794mr8516399qkb.433.1645517471388; 
 Tue, 22 Feb 2022 00:11:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6pPGdI38EWvdExU9PjVYF+abcYYxcjPH+D5uHZtUns1W/zgUWgRUc58bwXKp5JDZUPsdCOQ==
X-Received: by 2002:a05:620a:3706:b0:648:afb4:5794 with SMTP id
 de6-20020a05620a370600b00648afb45794mr8516386qkb.433.1645517471142; 
 Tue, 22 Feb 2022 00:11:11 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156])
 by smtp.gmail.com with ESMTPSA id n16sm5744274qkn.115.2022.02.22.00.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Feb 2022 00:11:10 -0800 (PST)
Date: Tue, 22 Feb 2022 09:11:04 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] vhost/vsock: don't check owner in vhost_vsock_stop()
 while releasing
Message-ID: <20220222081104.a2woahjgno2iv7yl@sgarzare-redhat>
References: <20220221114916.107045-1-sgarzare@redhat.com>
 <202202220707.AM3rKUcP-lkp@intel.com>
MIME-Version: 1.0
In-Reply-To: <202202220707.AM3rKUcP-lkp@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kbuild-all@lists.01.org, lkp@intel.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 kbuild@lists.01.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Asias He <asias@redhat.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Feb 22, 2022 at 08:30:17AM +0300, Dan Carpenter wrote:
>Hi Stefano,
>
>url:    https://github.com/0day-ci/linux/commits/Stefano-Garzarella/vhost-vsock-don-t-check-owner-in-vhost_vsock_stop-while-releasing/20220221-195038
>base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
>config: x86_64-randconfig-m031-20220221 (https://download.01.org/0day-ci/archive/20220222/202202220707.AM3rKUcP-lkp@intel.com/config)
>compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>
>If you fix the issue, kindly add following tag as appropriate
>Reported-by: kernel test robot <lkp@intel.com>
>Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
>smatch warnings:
>drivers/vhost/vsock.c:655 vhost_vsock_stop() error: uninitialized symbol 'ret'.
>
>vim +/ret +655 drivers/vhost/vsock.c
>
>3ace84c91bfcde Stefano Garzarella 2022-02-21  632  static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
>433fc58e6bf2c8 Asias He           2016-07-28  633  {
>433fc58e6bf2c8 Asias He           2016-07-28  634  	size_t i;
>433fc58e6bf2c8 Asias He           2016-07-28  635  	int ret;
>433fc58e6bf2c8 Asias He           2016-07-28  636
>433fc58e6bf2c8 Asias He           2016-07-28  637  	mutex_lock(&vsock->dev.mutex);
>433fc58e6bf2c8 Asias He           2016-07-28  638
>3ace84c91bfcde Stefano Garzarella 2022-02-21  639  	if (check_owner) {
>433fc58e6bf2c8 Asias He           2016-07-28  640  		ret = vhost_dev_check_owner(&vsock->dev);
>433fc58e6bf2c8 Asias He           2016-07-28  641  		if (ret)
>433fc58e6bf2c8 Asias He           2016-07-28  642  			goto err;
>3ace84c91bfcde Stefano Garzarella 2022-02-21  643  	}
>
>"ret" not initialized on else path.

Oooops, I was testing with vhost_vsock_dev_release() where we don't 
check the ret value, but of course we need to initialize it to 0 for the 
vhost_vsock_dev_ioctl() use case.

I'll fix in the v2.

Thanks for the report,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

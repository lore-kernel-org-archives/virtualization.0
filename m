Return-Path: <SRS0=YcCX=LS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAF8C49EA5
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 07:34:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF37613E7
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 07:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF37613E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 766D960829;
	Thu, 24 Jun 2021 07:34:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JEca0TyPjqeN; Thu, 24 Jun 2021 07:34:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1F8C3608D6;
	Thu, 24 Jun 2021 07:34:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E47F7C001A;
	Thu, 24 Jun 2021 07:34:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 389E8C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 07:34:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B4EE4147E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 07:34:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5wxe3fImVco6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 07:34:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 45853406AC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 07:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624520051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+3ri02JcikUDdV3zELjIjJ7m7hQSA/GaXJn3H8LLNW4=;
 b=dQN9bN5E6DnCQ+3n8KV9mDo9IyBVgnaxrnXbgjodpyyt+zP9/HS89D6eJZMBQOZq9w+tlW
 UdFoq/pABKcRld8A3yfQtX0VvgcakD4sdjjOSk+od1XG7G6f5rNnj2cAmkwGd6EW89muWQ
 UQX+adEpZNuZhqobmOwTaRHMuadnQFo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-L_mBQHZIMAaG8L-84KO1pA-1; Thu, 24 Jun 2021 03:34:09 -0400
X-MC-Unique: L_mBQHZIMAaG8L-84KO1pA-1
Received: by mail-ed1-f72.google.com with SMTP id
 y18-20020a0564022712b029038ffac1995eso2885909edd.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 00:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+3ri02JcikUDdV3zELjIjJ7m7hQSA/GaXJn3H8LLNW4=;
 b=Lek5WbYViTzNamALeNxJWhHqFEbaz9Wh93GCPoQ/5J3BJSWvZ8wTLMlOQPQvnzu7GA
 PAyQm6FZgDupiurQorDIF/RaxLSSnyCzf7jE2TTwQ5N2nKL/4Es180gJCrGP50vDaOA/
 cjR+F01ERG97Pjyr/mezzCPe3bDyQRt4HF5wedTmiDBnYmabiQ+kWjxQ/zwESVjoVvpl
 dN+thgwkNglll5jW3wx+hLBF7vsor3nUWpeG9bei5fi0AlkblEzbJRd4tcsg6yWPRMBE
 5IDP0H1ZG8C9/1FfK1/f7cPwz3z1bIEHZ7VRMAFuL+2UeSK6WgUx4JukzftXXryTPOQt
 ibpQ==
X-Gm-Message-State: AOAM530JgdZH/iCEswf4T4sZnx8M4hIxexp/U/5et2OZZnIitI5u5VbF
 NWLdqDvUw7OYrIdPqPTwi+F2+BTUQHBXHKoDHidcH8Qh0MZsbLTTu+b2ud5B+slfV2X2vPQg/rc
 SUTOQPXkDQLQq3OUkyyh142AiBuX4rH40WYd910VE8w==
X-Received: by 2002:a17:906:c2cf:: with SMTP id
 ch15mr3910286ejb.517.1624520048497; 
 Thu, 24 Jun 2021 00:34:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+LNv+c+e63ctYoEu2+THRGxPAm1rIotbbKIkGTW3lDLlJSyqxHRcZeEfzuNc1tYMo/AE2Qw==
X-Received: by 2002:a17:906:c2cf:: with SMTP id
 ch15mr3910269ejb.517.1624520048331; 
 Thu, 24 Jun 2021 00:34:08 -0700 (PDT)
Received: from redhat.com ([77.124.79.210])
 by smtp.gmail.com with ESMTPSA id l7sm1348002edc.78.2021.06.24.00.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jun 2021 00:34:07 -0700 (PDT)
Date: Thu, 24 Jun 2021 03:34:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 0/3] kthread: pass in user and check RLIMIT_NPROC
Message-ID: <20210624033350-mutt-send-email-mst@kernel.org>
References: <20210624030804.4932-1-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20210624030804.4932-1-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 akpm@linux-foundation.org, christian.brauner@ubuntu.com, christian@brauner.io
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

On Wed, Jun 23, 2021 at 10:08:01PM -0500, Mike Christie wrote:
> The vhost driver will create a kthread when userspace does a
> VHOST_SET_OWNER ioctl, but the thread is charged to the kthreadd thread.
> We can then end up violating the userspace process's RLIMIT_NPROC. This
> patchset allows drivers to pass in the user to charge/check.
> 
> The patches were made over Linus's current tree.
> 


Makes sense I guess.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

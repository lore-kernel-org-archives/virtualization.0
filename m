Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00720EB64DB
	for <virtualization@archiver.kernel.org>; Wed, 14 Jun 2023 15:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60ED441C4D;
	Wed, 14 Jun 2023 15:03:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 60ED441C4D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GoEszbyv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kz7fDDDOIPGR; Wed, 14 Jun 2023 15:03:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BA6CA400EE;
	Wed, 14 Jun 2023 15:03:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BA6CA400EE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6419AC0037;
	Wed, 14 Jun 2023 15:03:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C791C0029
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jun 2023 15:03:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB85F60B98
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jun 2023 15:03:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB85F60B98
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GoEszbyv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pT0Jm_jLZD91
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jun 2023 15:03:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1230861321
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1230861321
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jun 2023 15:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686754984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=StBjlzC+K1w2JzS0mxfSPzu6vQtFOd/XKwJV6KORDbk=;
 b=GoEszbyvz7xOVR6kA/1w9EMtM4Z1wP9YkUhC1d0rdbUaZmCaLRQinkUkMqZcSNgWVFXy5C
 y1YGtwTLs9Qejl3Glrp1kBuQ60t+Mf9Cxw1bFNYtSd415ktGDtZwV9XDSgYlEoaly5X5wC
 GSFxqDozXTR8KskrSFgOKCB01hnQrn4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-PRDaHF1PO1iQi4mjTgKrEQ-1; Wed, 14 Jun 2023 11:03:03 -0400
X-MC-Unique: PRDaHF1PO1iQi4mjTgKrEQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-75d4d5eda29so169563385a.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jun 2023 08:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686754982; x=1689346982;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=StBjlzC+K1w2JzS0mxfSPzu6vQtFOd/XKwJV6KORDbk=;
 b=dmjlPCdl4p+9H/AcuPzaxgshQnCBCSnx958V85HslXg6T39CI8ayvSXpWNjNAGWvV/
 QhdXheoCXNhga3ccZKj6fW/ZvA57Sm6TrahycIOvuXM8SfCVcr6Ghtovqvz6rHodwiRI
 DeQGRqv4vIOEWo4uTmjzmadxnz2si1qnkZjWFxfZem4vCu8hxhmtbsjmdbRSN458HIuC
 pm0fCwDzJ+jOxiTMfcsyfgVmGhZUDm9aAOSiFRtoewN+oYfg0pLSezgnOQcHyYTftlze
 Xgt7vMHt1lqQGMAd5ZUQz8xZTDrXFpxJHQEBYKjwJHSE17gak+KHyOw4RXlcCL/+pknp
 pexA==
X-Gm-Message-State: AC+VfDxfZiyRbBvAlxyHdJX1+EaKy40WJdd8PcA3vngSWlv3WZUwMb0j
 sgxDr+JX+tjpibpljDsGXgNIJxfVQrkQSQHrT7zLEQcTTOpsCo4tpwW2jGLdz77cm0+Xqzlfdm+
 qMymefBsRPujuyaID69Gq2kCMAMy6Evh8rxvReCEhNQ==
X-Received: by 2002:a37:b97:0:b0:75f:3d6:8166 with SMTP id
 145-20020a370b97000000b0075f03d68166mr1526840qkl.18.1686754982706; 
 Wed, 14 Jun 2023 08:03:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4XDQaV76PDXC2pJoOhzFD6+vh+s9cTgaUdn5cYBrmPYPQaLYjT+qo9PTIrwiabwmcUXAsuIA==
X-Received: by 2002:a37:b97:0:b0:75f:3d6:8166 with SMTP id
 145-20020a370b97000000b0075f03d68166mr1526815qkl.18.1686754982463; 
 Wed, 14 Jun 2023 08:03:02 -0700 (PDT)
Received: from redhat.com ([172.58.139.140]) by smtp.gmail.com with ESMTPSA id
 o23-20020a05620a15d700b0075cdad9648dsm4364920qkm.25.2023.06.14.08.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 08:03:01 -0700 (PDT)
Date: Wed, 14 Jun 2023 11:02:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: Can vhost translate to io_uring?
Message-ID: <20230614103152-mutt-send-email-mst@kernel.org>
References: <20230602192254.GD555@redhat.com>
 <87r0qt18qq.fsf_-_@email.froward.int.ebiederm.org>
 <ae250076-7d55-c407-1066-86b37014c69c@oracle.com>
 <20230605151037.GE32275@redhat.com>
 <03c07f48-8922-f563-560c-f0d4cc3e1279@oracle.com>
 <20230606121643.GD7542@redhat.com>
 <39f5913c-e658-e476-0378-62236bb4ed49@oracle.com>
 <20230606193907.GB18866@redhat.com>
 <cfbf1a0d-5d62-366f-f32f-6c63b151489e@oracle.com>
 <87mt12oa25.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
In-Reply-To: <87mt12oa25.fsf_-_@email.froward.int.ebiederm.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, brauner@kernel.org, linux-kernel@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>, linux@leemhuis.info, stefanha@redhat.com,
 nicolas.dichtel@6wind.com, virtualization@lists.linux-foundation.org,
 torvalds@linux-foundation.org
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

On Wed, Jun 14, 2023 at 01:02:58AM -0500, Eric W. Biederman wrote:
> At a quick glance it looks like io_uring already supports the
> functionality that vhost supports (which I think is networking and
> scsi).

There's vsock too.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975D3C636CD
	for <virtualization@archiver.kernel.org>; Wed,  1 Feb 2023 16:03:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F83040571;
	Wed,  1 Feb 2023 16:03:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F83040571
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f27xwRz/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Qmm86kKHsgZ; Wed,  1 Feb 2023 16:03:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5369C40510;
	Wed,  1 Feb 2023 16:03:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5369C40510
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28FF6C0032;
	Wed,  1 Feb 2023 16:03:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEDB1C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 16:03:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B780540A07
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 16:03:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B780540A07
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=f27xwRz/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DioOWefQAiuc
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 16:03:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 11B4F40184
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 11B4F40184
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 16:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675267415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b1H9S6BHMI3ZJyJH5QgphGWijBn41dRJFzhUalzPkqw=;
 b=f27xwRz/3I/uAvKds6zrLClWDYmXAzyZFD11ka1qC6wbI5JTp5oXAVs7iyMYirZA5wEEhS
 pNpqtzcyRLCamP0QsFBvsoS/nZzQtjDP61UGXlVgGZPrboQjqN583UCEUM/PQh02CK5kHQ
 FUBh2BWGnfQc3u7v+3PT2olntl4UBEc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-515-CdYS0BzNNNiXmE4RJ-vHkQ-1; Wed, 01 Feb 2023 11:03:34 -0500
X-MC-Unique: CdYS0BzNNNiXmE4RJ-vHkQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 j20-20020a05600c1c1400b003dc5dd44c0cso4286358wms.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Feb 2023 08:03:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b1H9S6BHMI3ZJyJH5QgphGWijBn41dRJFzhUalzPkqw=;
 b=FWC5pT2AM0BQYkAEXdvbPT2SU3uqjxQLajB0QTM0ola5XSlGF53KVtQ7uBFC6H1lOj
 auzWNXtgCs95z5F/kVR9P9e7zct+bxzXKi1+p/P81elxHsC4JmHEAHKKtTTc4gq3cZZ8
 e+G9J4gkM3L8t8gL71WSXcxNBhyAqyVBFGx7+dqapEgfQp0FQ3F13HMq8wakXnmOGXY0
 W/PZyjDImXMlAuDFSe8TUuHl6u97c2TSjVRtMDM/YlORPihXS/tKivr6uSYh90qWEP0U
 jOZpiAlXyqsDgN/XdRGw9K5mbTk/fYdDZWdQTwrjDDtpz3dOfdUj0fosY2wQkjVHNWnb
 KHlg==
X-Gm-Message-State: AO0yUKU6gi1tpxkeLT6UYOTxj4bHcsYbePNHAWYcbMXUKje5a46m0R2T
 9iXAqS4KvTIpzrviT3yIwvxt7kKShl/k3wpDM6RRDWcpTwJdST2huBBGkBY/PMM+cRB+KGHXYe5
 3e1fNkQVIB8FkCtSLbjVSRj+0UcBKP41hY23CaOKyjw==
X-Received: by 2002:a05:6000:80e:b0:2bf:e61c:9b4 with SMTP id
 bt14-20020a056000080e00b002bfe61c09b4mr3116851wrb.4.1675267413053; 
 Wed, 01 Feb 2023 08:03:33 -0800 (PST)
X-Google-Smtp-Source: AK7set9mkTqfA7HywIzLWLc57g9ZcuE/3dWDYMdAt3c3LDfa20GdCpoBqXPbTzeqKwveMvOdDdv25g==
X-Received: by 2002:a05:6000:80e:b0:2bf:e61c:9b4 with SMTP id
 bt14-20020a056000080e00b002bfe61c09b4mr3116833wrb.4.1675267412882; 
 Wed, 01 Feb 2023 08:03:32 -0800 (PST)
Received: from redhat.com ([2.52.144.173]) by smtp.gmail.com with ESMTPSA id
 a18-20020adffad2000000b002be53aa2260sm18737017wrs.117.2023.02.01.08.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Feb 2023 08:03:32 -0800 (PST)
Date: Wed, 1 Feb 2023 11:03:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH] vhost-vdpa: print error when vhost_vdpa_alloc_domain fails
Message-ID: <20230201110253-mutt-send-email-mst@kernel.org>
References: <20230201152018.1270226-1-alvaro.karsz@solid-run.com>
 <20230201105200-mutt-send-email-mst@kernel.org>
 <CAJs=3_Bw5QiZRu-nSeprhT1AMyGqw4oggTY=t+yaPeXBOAOjLQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_Bw5QiZRu-nSeprhT1AMyGqw4oggTY=t+yaPeXBOAOjLQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, Eugenio Perez Martin <eperezma@redhat.com>,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Wed, Feb 01, 2023 at 05:54:53PM +0200, Alvaro Karsz wrote:
> > I'm not sure this is a good idea. Userspace is not supposed to be
> > able to trigger dev_err.
> 
> dev_warn then?

dev_warn_once is ok.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

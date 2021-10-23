Return-Path: <SRS0=Fxu4=PL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67843C433EF
	for <virtualization@archiver.kernel.org>; Sat, 23 Oct 2021 20:12:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1927D60F6F
	for <virtualization@archiver.kernel.org>; Sat, 23 Oct 2021 20:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1927D60F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5156818BE;
	Sat, 23 Oct 2021 20:12:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LMQ5HBCqfuAx; Sat, 23 Oct 2021 20:12:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6D239818B5;
	Sat, 23 Oct 2021 20:12:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 444A0C0019;
	Sat, 23 Oct 2021 20:12:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EF33C000E
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Oct 2021 20:12:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3074740295
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Oct 2021 20:12:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0u3KzTWA7wcU
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Oct 2021 20:12:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 06A874028B
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Oct 2021 20:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635019930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VgEQduzNB4dlnuAxIBgUOHmPrSg6yBY89F+vEdYiO0s=;
 b=EgM9BolkK82hBmmpoG+zArdAwCoWs9HbtYXMjiFg/C5Xq1V951cUkw56iqfUS+0eXRJcxy
 CoaYk4wSTzLA1ZLJ/Ia3Pg+bkfhS6IvQWnfm9UavjWfFRET5g+tAQ7dNxgzxcYlKlIONmT
 dSXQQX84aPHtneWywbppkwqFZAoZqtM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-dmx-Xn2uPguQV-zkbL0Dlg-1; Sat, 23 Oct 2021 16:12:09 -0400
X-MC-Unique: dmx-Xn2uPguQV-zkbL0Dlg-1
Received: by mail-wm1-f71.google.com with SMTP id
 k20-20020a7bc414000000b0030dcd454771so2564529wmi.8
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Oct 2021 13:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VgEQduzNB4dlnuAxIBgUOHmPrSg6yBY89F+vEdYiO0s=;
 b=5Nym3HWnGdJH9eXZaxijb+nhDzT7MFOSryniA/0mT8xT1PfmEaWYYRBWgLTdad4O5u
 vVQtPXL58tXVZAlVgvX08bk4J0HFPFj5ZlRRNanFJrmp1o/qeVMnRmH6ks5Tm8c7ff1D
 7KeLpRh+KSDlPwF8j+ouZuXkxJmyhl80yHcnpVwWAbl1qhHwdI0yVWD4bWIuj90txScY
 ycd4TzWi2oB6VYrEKvoUsIG69+F3IcZvSNLBe0CNq/rRSQj7HIQZ7owYYx6Vl7SetH+F
 6zgX604AhOR/TBaZrYJZPwKEXa/tIJhp0Tv8/tSBSLMhH2xwXrsJHz73+tHlxb4JCbpP
 xiaw==
X-Gm-Message-State: AOAM531hqvJRKbexGGYijQm9gWUD22JZ94j/3ahPAkC8Dm3Qb8x89+Vv
 Wd5sjWoi7ulBVc9B9KOl2OItw5/G7WYoq+uVN00mJbkLhoX2NJJ1vVH1QvDoo105GZs65xk4UzT
 6dytIPv1siNAXgDKzFOmBCoOxbkwe84lhzXEIbgO1kQ==
X-Received: by 2002:a5d:64c5:: with SMTP id f5mr9830526wri.321.1635019928191; 
 Sat, 23 Oct 2021 13:12:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZSCekXchQrLARUvA9cAdSdoDJ4a1ncqtfFS7+1L0KYU9GVCUAFucIoVw/MkbTUcvAk9wadA==
X-Received: by 2002:a5d:64c5:: with SMTP id f5mr9830506wri.321.1635019928047; 
 Sat, 23 Oct 2021 13:12:08 -0700 (PDT)
Received: from redhat.com ([2.55.9.147])
 by smtp.gmail.com with ESMTPSA id k6sm11901376wri.83.2021.10.23.13.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Oct 2021 13:12:07 -0700 (PDT)
Date: Sat, 23 Oct 2021 16:12:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: michael.christie@oracle.com
Subject: Re: [PATCH V3 00/11] vhost: multiple worker support
Message-ID: <20211023161135-mutt-send-email-mst@kernel.org>
References: <20211022051911.108383-1-michael.christie@oracle.com>
 <20211022054625-mutt-send-email-mst@kernel.org>
 <2f8a975a-e01a-5671-7c3a-3b19c8564cb3@oracle.com>
MIME-Version: 1.0
In-Reply-To: <2f8a975a-e01a-5671-7c3a-3b19c8564cb3@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org,
 target-devel@vger.kernel.org, stefanha@redhat.com, pbonzini@redhat.com,
 Christian Brauner <christian.brauner@ubuntu.com>
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

On Fri, Oct 22, 2021 at 10:54:24AM -0500, michael.christie@oracle.com wrote:
> Ccing Christian for the kernel worker API merging stuff.
> 
> On 10/22/21 4:48 AM, Michael S. Tsirkin wrote:
> > On Fri, Oct 22, 2021 at 12:18:59AM -0500, Mike Christie wrote:
> >> The following patches apply over linus's tree and this patchset
> >>
> >> https://urldefense.com/v3/__https://lore.kernel.org/all/20211007214448.6282-1-michael.christie@oracle.com/__;!!ACWV5N9M2RV99hQ!aqbE06mycEW-AMIj5avlBMDSvg2FONlNdYHr8PcNKdvl5FeO4QLCxCOyaVg8g8C2_Kp5$ 
> >>
> >> which allows us to check the vhost owner thread's RLIMITs:
> > 
> > 
> > Unfortunately that patchset in turn triggers kbuild warnings.
> 
> Yeah, that's the Jens/Paul issue I mentioned. I have to remove the
> old create_io_thread code and resolve issues with their trees. Paul's
> tree has a conflict with Jens and then my patch has a issue with Paul's
> patches.
> 
> So Christian and I thought we would re-push the patchset through
> Christian after that has settled in 5.16-rc1 and then shoot for 5.17
> so it has time to bake in next.
> 

Sounds good to me.

> > I was hoping you would address them, I don't think
> > merging that patchset before kbuild issues are addressed
> > is possible.
> > 
> > It also doesn't have lots of acks, I'm a bit apprehensive
> > of merging core changes like this through the vhost tree.
> 
> Ok. Just to make sure we are on the same page. Christian was going to
> push the kernel worker API changes.

Fine.

> > Try to CC more widely/ping people?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

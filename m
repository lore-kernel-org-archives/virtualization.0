Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFC5C001B0
	for <virtualization@archiver.kernel.org>; Sun, 23 Jul 2023 09:55:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 487F282193;
	Sun, 23 Jul 2023 09:55:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 487F282193
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D6dvmPt7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kzFVOJVm9WnZ; Sun, 23 Jul 2023 09:55:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C737B8211D;
	Sun, 23 Jul 2023 09:55:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C737B8211D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C6DCC0071;
	Sun, 23 Jul 2023 09:55:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 464D7C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jul 2023 09:55:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0D7A982193
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jul 2023 09:55:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0D7A982193
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FX_DSi8xHFed
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jul 2023 09:55:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0072E8211D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jul 2023 09:55:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0072E8211D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690106140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oakpx82n4m6+moPT1LMqZIYYFz99Erw7biw+BLa7Rco=;
 b=D6dvmPt7hp8avbfwPERyHyeMl8XBD/I/ugXRURiuqBuaBCmXHj14KbAA89rEJnXv08zahN
 5Isa9RrX2cy/2EQBgNpgM6BVdaZb81Jlu+R58+wdaYQjJWWXeYX7OjlLN6Sxlg75ZdDrJh
 Iq5shzxEFsz7XILWrjUkDcXxI64sT8w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371--12vNK65M3WXoitrVf26og-1; Sun, 23 Jul 2023 05:55:39 -0400
X-MC-Unique: -12vNK65M3WXoitrVf26og-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3142665f122so2018850f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jul 2023 02:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690106138; x=1690710938;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oakpx82n4m6+moPT1LMqZIYYFz99Erw7biw+BLa7Rco=;
 b=f2Ije5xZmrOeT6+2c6Sglc5S4X+4fkKgB3PyNYamBPBjD8F1KGkXTVKq13t5wT1Zst
 EKSwoc45xTuD1hMpySew0AhXZUzC6d8hFw5Kh5Eu30xnDwyYSJu7YF0Zhk9gP0tNo/F2
 HgHKwxBBmmtJNx1IkHXvEOo+8Dro2ty3TKMWQAsII1rHSRz+w7AO3xDPH5JclIsNNSqj
 limoNdDOFc/Wy8cpMCJDGK92zjltGjQk+dZyVxFLs/UoyycJ6lx8O6cLLekwnrw5ZJTh
 yAtjKn3WZql4l1fs3P/rUTaW3NqVueG5WdHcKpg7Cx5bgi2XkDC8DeUtl03UVgreDWHo
 9RHA==
X-Gm-Message-State: ABy/qLYnzt5yHR3UCbTQDMHUwWp6NUL6E1ZVTq43PylGBz8MKVhkgVWf
 4tsX6+iPBsJw+ocRrIo8yAxbEFqiAw0c9gOUD7Yzkcj4f1++87LYg38dPzZuW/fskQR4m0+2yZr
 sgjooupzHWu75PpXcSFOIFl62E462KGqDSDajao3WyA==
X-Received: by 2002:a5d:4523:0:b0:314:36c5:e4c0 with SMTP id
 j3-20020a5d4523000000b0031436c5e4c0mr5830964wra.11.1690106137923; 
 Sun, 23 Jul 2023 02:55:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE3f1FwtvlIDG9rQVwdC8t8ngS8l2Td11UMjhie4u2ZO64W+MeoqKeuBe+O2LsvYRvXoT1ZaA==
X-Received: by 2002:a5d:4523:0:b0:314:36c5:e4c0 with SMTP id
 j3-20020a5d4523000000b0031436c5e4c0mr5830954wra.11.1690106137599; 
 Sun, 23 Jul 2023 02:55:37 -0700 (PDT)
Received: from redhat.com ([2.55.164.187]) by smtp.gmail.com with ESMTPSA id
 x3-20020adfdd83000000b00314398e4dd4sm9252151wrl.54.2023.07.23.02.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jul 2023 02:55:36 -0700 (PDT)
Date: Sun, 23 Jul 2023 05:55:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lin Ma <linma@zju.edu.cn>
Subject: Re: [PATCH v1] vdpa: Complement vdpa_nl_policy for nlattr length check
Message-ID: <20230723053613-mutt-send-email-mst@kernel.org>
References: <20230723080507.3716924-1-linma@zju.edu.cn>
 <20230723050656-mutt-send-email-mst@kernel.org>
 <729f5c17.e4079.18982192866.Coremail.linma@zju.edu.cn>
MIME-Version: 1.0
In-Reply-To: <729f5c17.e4079.18982192866.Coremail.linma@zju.edu.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Sun, Jul 23, 2023 at 05:33:54PM +0800, Lin Ma wrote:
> Hello Michael,
> 
> > >
> > > The vdpa_nl_policy structure is used to validate the nlattr when parsing
> > > the incoming nlmsg. It will ensure the attribute being described produces
> > > a valid nlattr pointer in info->attrs before entering into each handler
> > > in vdpa_nl_ops.
> > > 
> > > That is to say, the missing part in vdpa_nl_policy may lead to illegal
> > > nlattr after parsing, which could lead to OOB read just like CVE-2023-3773.
> > 
> > Hmm.
> > 
> > https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-3773
> > 
> > ** RESERVED ** This candidate has been reserved by an organization or individual that will use it when announcing a new security problem. When the candidate has been publicized, the details for this candidate will be provided.
> > 
> 
> Yeah, that CVE is assigned while fix not upstream yet. FYI, the fix is pending too. 
> See, https://marc.info/?l=linux-kernel&m=169009801131058&w=2.
> 
> > 
> > > This patch adds three missing nla_policy to avoid such bugs.
> > > 
> > > Fixes: 90fea5a800c3 ("vdpa: device feature provisioning")
> > > Fixes: 13b00b135665 ("vdpa: Add support for querying vendor statistics")
> > > Fixes: ad69dd0bf26b ("vdpa: Introduce query of device config layout")
> > > Signed-off-by: Lin Ma <linma@zju.edu.cn>
> > 
> > I don't know how OOB triggers but this duplication is problematic I
> > think: we are likely to forget again in the future.  Isn't there a way
> > to block everything that is not listed?
> > 
> 
> Sure, that is another undergoing task I'm working on. If the nlattr is parsed with
> NL_VALIDATE_UNSPEC, any forgotten nlattr will be rejected, therefore (which is the default
> for modern nla_parse). The problem here is that there are still consumers for
> nla_parse_deprecated. And we cannot simply replace all *_deprecated to modern ones
> as it may break userspace. See the commit message in 8cb081746c03 ("netlink: make
> validation more configurable for future strictness")
> 
> I believe if we can do enough test against userspace toolchains, we can ultimately
> upgrade all *_depprecated parsers to modern ones, which costs time and efforts. This
> send patch is a much simpler (but temporary) solution for now.
> 
> Regards
> Lin

Hmm but vdpa does not use nla_parse_deprecated does it? And in fact was
introduced after 8cb081746c031fb164089322e2336a0bf5b3070c.
So why is there an issue in vdpa?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

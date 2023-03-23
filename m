Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E09C6FD1C
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 11:43:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B4DD41835;
	Thu, 23 Mar 2023 11:43:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B4DD41835
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Aq6fqY5P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OJXgwDLJ1w4Q; Thu, 23 Mar 2023 11:43:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2EA8B417EA;
	Thu, 23 Mar 2023 11:43:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2EA8B417EA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00FC6C0071;
	Thu, 23 Mar 2023 11:43:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89F1DC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 11:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5176084059
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 11:43:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5176084059
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Aq6fqY5P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ANqcbd1adDvg
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 11:43:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9795F84003
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9795F84003
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 11:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679571792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cVq2mVM36cawCh4Vfk1jD5A152b458CdM0n5/LpNp2k=;
 b=Aq6fqY5PUbUwv19NrEsJg3kLHJ26t+8dnsWhAyH1XYACWm/luqOeD0rLTBoKoVYUTNbmrr
 HA7gRSyQesPtKPR8exjIoWHhW+gJWVsVxB5zyjL9GDi4qaaBmdxumKo4YWzlhlW8Cw2QUH
 guFt+5wtcujzngvoQCqI7ZWvhondJlE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-3NkwfvRcNU6hsupvwlMH5w-1; Thu, 23 Mar 2023 07:43:09 -0400
X-MC-Unique: 3NkwfvRcNU6hsupvwlMH5w-1
Received: by mail-ed1-f70.google.com with SMTP id
 i42-20020a0564020f2a00b004fd23c238beso31761898eda.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 04:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679571788;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cVq2mVM36cawCh4Vfk1jD5A152b458CdM0n5/LpNp2k=;
 b=Y0Ff9Pq4l+EhDVc5oaksq4rkEv3SIuBs4CsGS7iVOk3Tq2c8i+fDwKBGRmtpeQOx+R
 0AS6Rw1ZCeSOYPtHbsdqaFeJSCGsZkk23XtFvSJF7ZjaTbuy4d0TV7OrcAZwcwMZIDUl
 qMw8bA5rIobTkuiBF4wdTXv/ryTSxVaTOW5h1XhToZmYpfonWw1N7zFWSc3BZKeUCGzC
 9P0jPkSVsZHDUHXLRLpICX4Yk4RPzGRXADlJwj0uMlAvQWgf6j3LgerrK+PzHDgTXa6J
 cTfoaxRrArF8khbs7yJ67ztE1/rpzg84d+XXpF/xSeitYdR0enSgIHpcgdVJqNUVINo/
 b1gg==
X-Gm-Message-State: AO0yUKVWRiO3kRA71hJaYcMFGXMBYmrI6XxAQayuFyP+qBeKuVRZXrOS
 Yyk5N7WMVn3ah9Zekf+As6o5dcNMDwzVVmWxBrFqZhuEfG5bcDyjmBImiaOKcKekLK7EhD79rik
 Bh8II2+ulW9NaYekdH3+SDK2RchqkiUVlFI0YdNfP6w==
X-Received: by 2002:aa7:d8d1:0:b0:4fa:4b1c:6979 with SMTP id
 k17-20020aa7d8d1000000b004fa4b1c6979mr9960923eds.28.1679571788588; 
 Thu, 23 Mar 2023 04:43:08 -0700 (PDT)
X-Google-Smtp-Source: AK7set8KZdBp0oRYbIBzh9n5LfprMrAnKWiAlrUE2BOpvPhUzjwGFy4ljscwHArQq5l6tGkLkXTHLA==
X-Received: by 2002:aa7:d8d1:0:b0:4fa:4b1c:6979 with SMTP id
 k17-20020aa7d8d1000000b004fa4b1c6979mr9960900eds.28.1679571788332; 
 Thu, 23 Mar 2023 04:43:08 -0700 (PDT)
Received: from redhat.com ([2.52.143.71]) by smtp.gmail.com with ESMTPSA id
 b22-20020a50ccd6000000b00501dac14d7asm2175467edj.3.2023.03.23.04.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Mar 2023 04:43:07 -0700 (PDT)
Date: Thu, 23 Mar 2023 07:43:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 1/1] vhost_task: Fix vhost_task_create return value
Message-ID: <20230323073918-mutt-send-email-mst@kernel.org>
References: <20230322185605.1307-1-michael.christie@oracle.com>
 <20230323033557-mutt-send-email-mst@kernel.org>
 <20230323104445.qidusxeruimeawy6@wittgenstein>
MIME-Version: 1.0
In-Reply-To: <20230323104445.qidusxeruimeawy6@wittgenstein>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com
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

On Thu, Mar 23, 2023 at 11:44:45AM +0100, Christian Brauner wrote:
> On Thu, Mar 23, 2023 at 03:37:19AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Mar 22, 2023 at 01:56:05PM -0500, Mike Christie wrote:
> > > vhost_task_create is supposed to return the vhost_task or NULL on
> > > failure. This fixes it to return the correct value when the allocation
> > > of the struct fails.
> > > 
> > > Fixes: 77feab3c4156 ("vhost_task: Allow vhost layer to use copy_process") # mainline only
> > > Reported-by: syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com
> > > Signed-off-by: Mike Christie <michael.christie@oracle.com>
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > The affected patch is not upstream yet, right?
> > I don't know if the tree in question allows rebases - linux-next
> > does. So ideally it would be squashed to avoid issues during bisect.
> > Still it's error path so I guess not a tragedy even without squashing.
> 
> I tend to not rebase once stuff has been in linux-next but I make
> exceptions as long as it's before -rc4. For now I've put the patch on
> top (see the other mail I sent) but if it's really important I can
> squash it after the weekend (I'll be mostly afk until then.).

Hard to say how important, but I'd prefer that, yes.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

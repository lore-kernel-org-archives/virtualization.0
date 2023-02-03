Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C050C61DA4
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 00:16:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9A79611F0;
	Fri,  3 Feb 2023 00:16:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9A79611F0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Px8JQj+8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8ubV11BNwkhe; Fri,  3 Feb 2023 00:16:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 57C23611F1;
	Fri,  3 Feb 2023 00:16:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 57C23611F1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D80DC0032;
	Fri,  3 Feb 2023 00:16:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9371C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 00:16:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D13D540351
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 00:16:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D13D540351
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux-foundation.org
 header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google
 header.b=Px8JQj+8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wWApqfSp6EDG
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 00:16:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E6BD640330
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E6BD640330
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 00:16:33 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id bk15so10937068ejb.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 16:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Smlwk6vADVM6jgfBM/hp9+5/KUdj3WFKGPaluLskhUU=;
 b=Px8JQj+8SaQhdNfFmOAM7vXPDFme8UFrV2rmuYXkmJBQKa8HORZE5PCgmqf42EAPFZ
 44YX+BpWki+PChSX34nbFwxkjA9n9oQOAq4FwEOlUrDYTjXSWlbt8iRQtCah77qxPjLq
 f7DnHSrufLR5BDHXLoX72OXiIrqLrRhX1iFDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Smlwk6vADVM6jgfBM/hp9+5/KUdj3WFKGPaluLskhUU=;
 b=twYE/T3PZ8iRlaxw4Dv4xi+TfL503a2/0v/krJx+RkVMj6WvAWY6XP1BB4avRbcf6s
 iOF8plZW54ciTCDFhH7Rgn8nbqZnTTEvDeBOaiwM12TVKFqDRCJFbbGau3NCA9vldz1w
 UDztbZRGQ4DnrWPostxl1Wrib0VWS52KJ2GyAZSP+FJV7DMaAJhgKbrmFj3szXPTtdEH
 dNMshRjqetv9ZJ/bpmAbpR7yAhR0uzv0E2Bi+eNSBoalNRUXu9Wu32DgAFnye3ktiVst
 o0y+8TiBIS0tQ0RZoWIt3xwGUHSBiyfZL0yaIoyJAgUWR3C6tJ34YJZIky4JF46NREMD
 ci1g==
X-Gm-Message-State: AO0yUKUo1i6O0QZj1+HCbBV8LXLQxTSkH2WDZ753KP9Rq4g+t0iOsGfI
 g/mjfyzHkJ/fyt+6lRqNAKL0bi1Jf3n6eTO/khb8yg6x
X-Google-Smtp-Source: AK7set/we4Af+doK/4O7/l7UhSlDTS1Bax+HnT6EX+3cd1PybER4g+4NzSj21Qi0hcnoQSrutsofeA==
X-Received: by 2002:a17:906:600f:b0:872:2cc4:6886 with SMTP id
 o15-20020a170906600f00b008722cc46886mr7125122ejj.30.1675383391610; 
 Thu, 02 Feb 2023 16:16:31 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com.
 [209.85.218.53]) by smtp.gmail.com with ESMTPSA id
 m5-20020a1709062b8500b00872c0bccab2sm517512ejg.35.2023.02.02.16.16.30
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Feb 2023 16:16:31 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id p26so10879033ejx.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 16:16:30 -0800 (PST)
X-Received: by 2002:a17:906:f109:b0:882:e1b7:a90b with SMTP id
 gv9-20020a170906f10900b00882e1b7a90bmr2320874ejb.187.1675383390454; Thu, 02
 Feb 2023 16:16:30 -0800 (PST)
MIME-Version: 1.0
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-4-michael.christie@oracle.com>
In-Reply-To: <20230202232517.8695-4-michael.christie@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 Feb 2023 16:16:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9S93D_U8H82nPJmdd4VB7wYib64oXd-zErs-pT0MAdg@mail.gmail.com>
Message-ID: <CAHk-=wj9S93D_U8H82nPJmdd4VB7wYib64oXd-zErs-pT0MAdg@mail.gmail.com>
Subject: Re: [PATCH v11 3/8] fork: add USER_WORKER flag to not dup/clone files
To: Mike Christie <michael.christie@oracle.com>
Cc: brauner@kernel.org, mst@redhat.com, konrad.wilk@oracle.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 hch@infradead.org, ebiederm@xmission.com, stefanha@redhat.com,
 Christoph Hellwig <hch@lst.de>
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

On Thu, Feb 2, 2023 at 3:25 PM Mike Christie
<michael.christie@oracle.com> wrote:
>
> -       retval = copy_files(clone_flags, p);
> +       retval = copy_files(clone_flags, p,
> +                           args->worker_flags & USER_WORKER_NO_FILES);

Just to hit the previous email comment home, adding just another
bitfield case would have made this patch simpler, and this would just
be

       retval = copy_files(clone_flags, p, args->no_files);

which seems more legible too.

             Linus
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

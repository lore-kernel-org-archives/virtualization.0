Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91288C433FE
	for <virtualization@archiver.kernel.org>; Fri, 13 May 2022 12:17:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41D2E402F6;
	Fri, 13 May 2022 12:17:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UTszu7GVrb6u; Fri, 13 May 2022 12:17:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A052B402F9;
	Fri, 13 May 2022 12:17:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73436C0039;
	Fri, 13 May 2022 12:17:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E872BC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 12:17:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C6D1B402F8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 12:17:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bImpXLY4zDNN
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 12:17:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B7CB5402CE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 12:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652444223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ouGdyRe8UyIVf/HXw4oa1UwTNpHx7ZaHNy4q5Gp7oU0=;
 b=KjFcIAJFlPV4YCvLAXS5wjg++rIh7siYfkFR72lLpV746m9+L+I4hyHpMRSIQzhYqnVzH+
 Te1TlDgLE+MjmXs78pWncuTfIM+3bZnuTZaAHzeIaqfNT92lT9ISzhjK8/AMqqDgtNvOik
 c/WKmIfv/pTMZugy4TADL+i04ADTpYo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-hMQvHJYiNLKmg6f2a4N04A-1; Fri, 13 May 2022 08:16:59 -0400
X-MC-Unique: hMQvHJYiNLKmg6f2a4N04A-1
Received: by mail-wm1-f70.google.com with SMTP id
 c62-20020a1c3541000000b0038ec265155fso5881757wma.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 05:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ouGdyRe8UyIVf/HXw4oa1UwTNpHx7ZaHNy4q5Gp7oU0=;
 b=U9UC7SwkVOMDoKfuSF4m+3I62kg3WELYhTz1Rwm3Rwy1lzu/WGPtQrW8ejzcN+wxHz
 TZv8E5E1EyIZINpVnKmhdTn2yxyXbQsBqonaz3+oxITfsnntfrGEItJZ278zpGoruVWD
 R5Q1TApmR3xndGD0W6YiSF+UEbM02UNXfwR0yBYdnz5wgAmXOCbYtJCpD84y3RNvddX3
 M9tnZoEQbFSJmLwUX2ZmSx/5MRozGr+E/GS6n1Gv3kmPSUMVI2WfnxDuNHpDX4OSqs8A
 0JDncmYbYa2kBZN0bo/WSrQ/S9yWFN9kYkL4IxvNJuCpaaAA6hhmF6t3D+dFKQHZT/tA
 6t8g==
X-Gm-Message-State: AOAM531ragoZko9zhed3yCl04Fis5mcDlNix9i0lL96rj0lRsNzt+OtB
 +OHftXFj3uvibnPYnwhImbWuTBsQQmdHS3489FoXXXIFXRZLR1Qf0WsBWl18JASH1bWD+oMNLDW
 ga1BW54QOprfgZFs7KcHwVSb4jvCnulrTv2x/REFEag==
X-Received: by 2002:a05:600c:358c:b0:394:8522:e28 with SMTP id
 p12-20020a05600c358c00b0039485220e28mr4317113wmq.92.1652444218259; 
 Fri, 13 May 2022 05:16:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcCkLBgswrm9r0RR11RPAgrWbq6nMU8hzJ6+dShUaXBgNrjxY30r+aEHSeNuC11eC8S0NYpw==
X-Received: by 2002:a05:600c:358c:b0:394:8522:e28 with SMTP id
 p12-20020a05600c358c00b0039485220e28mr4317096wmq.92.1652444218049; 
 Fri, 13 May 2022 05:16:58 -0700 (PDT)
Received: from redhat.com ([2.53.15.195]) by smtp.gmail.com with ESMTPSA id
 r15-20020a7bc08f000000b00394615cf468sm5266090wmh.28.2022.05.13.05.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 May 2022 05:16:57 -0700 (PDT)
Date: Fri, 13 May 2022 08:16:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
Subject: Re: [GIT PULL] virtio: last minute fixup
Message-ID: <20220513081456-mutt-send-email-mst@kernel.org>
References: <20220510082351-mutt-send-email-mst@kernel.org>
 <CAHk-=wjPR+bj7P1O=MAQWXp0Mx2hHuNQ1acn6gS+mRo_kbo5Lg@mail.gmail.com>
 <Ynuq9wMtJKBe8WOk@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <Ynuq9wMtJKBe8WOk@8bytes.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: KVM list <kvm@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, mie@igel.co.jp,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, May 11, 2022 at 02:24:23PM +0200, J=F6rg R=F6del wrote:
> On Tue, May 10, 2022 at 11:23:11AM -0700, Linus Torvalds wrote:
> > And - once again - I want to complain about the "Link:" in that commit.
> =

> I have to say that for me (probably for others as well) those Link tags
> pointing to the patch submission have quite some value:
> =

> 	1) First of all it is an easy proof that the patch was actually
> 	   submitted somewhere for public review before it went into a
> 	   maintainers tree.
> =

> 	2) The patch submission is often the entry point to the
> 	   discussion which lead to this patch. From that email I can
> 	   see what was discussed and often there is even a link to
> 	   previous versions and the discussions that happened there. It
> 	   helps to better understand how a patch came to be the way it
> 	   is. I know this should ideally be part of the commit message,
> 	   but in reality this is what I also use the link tag for.
> =

> 	3) When backporting a patch to a downstream kernel it often
> 	   helps a lot to see the whole patch-set the change was
> 	   submitted in, especially when it comes to fixes. With the
> 	   Link: tag the whole submission thread is easy to find.
> =

> I can stop adding them to patches if you want, but as I said, I think
> there is some value in them which make me want to keep them.
> =

> Regards,
> =

> 	Joerg

Yea, me too ... Linus, will it be less problematic if it's a different
tag, other than Link? What if it's Message-Id: <foo@bar>? Still a
problem?


-- =

MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

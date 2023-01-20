Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D257EC05027
	for <virtualization@archiver.kernel.org>; Fri, 20 Jan 2023 12:45:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5520582684;
	Fri, 20 Jan 2023 12:45:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5520582684
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AouFfmED
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5gdPju6aagyH; Fri, 20 Jan 2023 12:45:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F372582384;
	Fri, 20 Jan 2023 12:45:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F372582384
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2ECBC0033;
	Fri, 20 Jan 2023 12:45:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 711C6C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 12:45:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4868741CC2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 12:45:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4868741CC2
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AouFfmED
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0XuGf0FoXPKb
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 12:45:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6541C41CC0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6541C41CC0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 12:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674218713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YWTNOPUOumy5aDePbdwVljMsaDB1wMCPYL0DgkBFZF8=;
 b=AouFfmEDf2zYHv8CKzZU/fiRvvHDYMguKIvMpBSW8n750dGe27pNeph6knyeBdNISz8EKc
 XANX9uF4ZM8y+nVNYN8n6KEQDtGyXnqoJgTZzllfN94lTuTLiIiRFVoSaEZ9jbzUIWa/c3
 EVJ6bz0izdweKieA2RBcM/RXiIY7rLM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-492-FcagKXn8MUKN3EIvp7YJJA-1; Fri, 20 Jan 2023 07:45:11 -0500
X-MC-Unique: FcagKXn8MUKN3EIvp7YJJA-1
Received: by mail-wm1-f72.google.com with SMTP id
 j8-20020a05600c190800b003db2dc83dafso1546797wmq.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 04:45:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YWTNOPUOumy5aDePbdwVljMsaDB1wMCPYL0DgkBFZF8=;
 b=it57uZQUM4jAdqXwx9WD6mRuh2ov+PIkwwCv3p3u30JibQziXIaShwvItJLwV6n0RV
 zZY/KhkIYeOgmQrkxoF4CaIOh8YJBKeRfrO5Cd6hCMgP392na4SgMeRXdrfpAVuewVk3
 5loXqhcexZLgyV7PpGFvAI+efo0jbjG9UnWj5ZrXwPAuI8aSvAzv2eTZRrbS+h2ipgUt
 rWJUfIpfVQVfjv7UN2r6Uf2Iu7pAnxxwVb64zyl92TTmoCjP0VWY4hUtzpaipAnMC5jq
 ehhxegR1e9cNGfgVX+PMH21mredLpWoaNo+JISqL2cXBi4vetIsZm3TYWmGt47SoTXO2
 zGxA==
X-Gm-Message-State: AFqh2kr4T/2QI0sYWJ+u12JDkczLOpPwOMoA9b995dIqoEj/i9m5wEjl
 alGX4xUIzk6Epae3tfH71EjVlQ5JeTDwZ7fDVLK/W64G2V32BRzbDjYb685NSz55pM+sNb2BAy+
 TZKWnokb0jPPQ+4NchEvXVv9XQ3trG8KL4etN2l3ssQ==
X-Received: by 2002:a5d:5955:0:b0:2bd:e87c:e831 with SMTP id
 e21-20020a5d5955000000b002bde87ce831mr11862720wri.69.1674218709867; 
 Fri, 20 Jan 2023 04:45:09 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsFTBS2vpkIrxrS4rpXlcCJkUPLp7KgbaNRpa66vaoAYh2QvTIbam4nZFlOHaCWilzFiSDtYQ==
X-Received: by 2002:a5d:5955:0:b0:2bd:e87c:e831 with SMTP id
 e21-20020a5d5955000000b002bde87ce831mr11862700wri.69.1674218709503; 
 Fri, 20 Jan 2023 04:45:09 -0800 (PST)
Received: from redhat.com ([2.52.19.29]) by smtp.gmail.com with ESMTPSA id
 q17-20020a056000137100b002be4ff0c917sm2099412wrz.84.2023.01.20.04.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jan 2023 04:45:08 -0800 (PST)
Date: Fri, 20 Jan 2023 07:45:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 4/6] virtio console: Harden control message handling
Message-ID: <20230120074120-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-5-alexander.shishkin@linux.intel.com>
 <Y8lgIS+jygB7SGrn@kroah.com>
MIME-Version: 1.0
In-Reply-To: <Y8lgIS+jygB7SGrn@kroah.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elena.reshetova@intel.com, kirill.shutemov@linux.intel.com
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

On Thu, Jan 19, 2023 at 04:22:09PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Jan 19, 2023 at 03:57:19PM +0200, Alexander Shishkin wrote:
> > In handle_control_message(), we look at the ->event field twice, which
> > gives a malicious VMM a window in which to switch it from PORT_ADD to
> > PORT_REMOVE, triggering a null dereference further down the line:
> 
> How is the other VMM have full control over the full message here?
> Shouldn't this all have been copied into our local memory if we are
> going to be poking around in it?  Like I mentioned in my other review,
> copy it all once and then parse it.  Don't try to mess with individual
> fields one at a time otherwise that way lies madness...
> 
> thanks,
> 
> greg k-h

I agree and in fact, it is *already* copied since with malicious
device we generally use a bounce buffer.
Having said that, the patch is actually a cleanup, e.g. it's clearer
to byte-swap only once.
Just don't oversell it as a security thing.


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

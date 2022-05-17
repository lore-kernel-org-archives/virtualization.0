Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA54C433EF
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 14:21:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34C758400C;
	Tue, 17 May 2022 14:21:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DRapeaWeoCuf; Tue, 17 May 2022 14:21:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D4FA083DF9;
	Tue, 17 May 2022 14:21:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F0D4C0039;
	Tue, 17 May 2022 14:21:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BFFFC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 14:21:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5916841A3A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 14:21:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rVA3lzxpukN0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 14:20:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7584041A39
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 14:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652797258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DE3AbffAujWctScmXkHH5N5nEpZBXnAzNsjZr1wX+Rg=;
 b=AqdmGfvezUbgxdVMQBDW7f1h+LXsY19PqJbczN5O0plCKijA+YbjULgEsZ/XsxV2KNvXHK
 VjavKtO21FvSSU2q/VtO2cM+Daa+D5JSK21mpTXESEiaJLAeW3RtVaqYAMcLEPa+GB/ms6
 zaDMyZqmvWV4SUdWvv/3O/s3nlJOnAc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-W2wlijkhMRyEsO_1rdv9lA-1; Tue, 17 May 2022 10:20:54 -0400
X-MC-Unique: W2wlijkhMRyEsO_1rdv9lA-1
Received: by mail-wm1-f71.google.com with SMTP id
 r186-20020a1c2bc3000000b00396fee62505so744708wmr.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 07:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DE3AbffAujWctScmXkHH5N5nEpZBXnAzNsjZr1wX+Rg=;
 b=iE6gms0WUw75cMTGHhIVx0r8f8SNDDDSSakce0WJd1r9x+iCatlUO/N0ab406u+MgF
 bgSvlxmwM6s9mTwVtdcvcPgOiRrD7OEFfkkwJ1ZPBU0rBKlnD/QN1NIuHLHsWCWDj+wl
 7DY2nrWWb07lMup1DrEooOdaYH1TEkIJaRqLfAN82yZdJbkOZpoS///rzSt9QfjlaWww
 kExVLGWUZ+lKBNBxTfe0oFW3jfsS5JCWzGIwtwUo2KgCvQ+A5z5M4quikHH/0/5tjtjp
 9y0DHv6VgyEgAzWmXM/Y2J96G4yBF8jAZlqDN3w0QfG9C3IhU1iAjR8a2L1b/IPdshSs
 AH9g==
X-Gm-Message-State: AOAM5311PadGLGmJ+F7c//SWLMjibnsXrUEBCXmDe8ej1/zEWEi+7CoO
 TUz6SEBMmBx786mWCIBNT1jMnpeYeaE5RXl7xWjhIhAOOfoQGYr7zepmcagHJ3FHOO9H3n++flJ
 sIXq4xrkwf++0NEM8XF04Mm1W0CzfC/g774DUanlYMA==
X-Received: by 2002:a05:6000:793:b0:20c:c809:a434 with SMTP id
 bu19-20020a056000079300b0020cc809a434mr18875309wrb.628.1652797253310; 
 Tue, 17 May 2022 07:20:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIs//drmaPc7HP+aECNLDgG8T7Lozmhtito+UWrNNrWVk8Azq5cE6U89/JWLqcEXQRohzjzg==
X-Received: by 2002:a05:6000:793:b0:20c:c809:a434 with SMTP id
 bu19-20020a056000079300b0020cc809a434mr18875298wrb.628.1652797253142; 
 Tue, 17 May 2022 07:20:53 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 t5-20020adfba45000000b0020cdbc5c4f0sm12458359wrg.104.2022.05.17.07.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 May 2022 07:20:52 -0700 (PDT)
Date: Tue, 17 May 2022 16:20:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH V2 0/8] vhost flush cleanups
Message-ID: <20220517142048.clszyzvz77rzbtl5@sgarzare-redhat>
References: <20220515202922.174066-1-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20220515202922.174066-1-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, arbn@yandex-team.com,
 stefanha@redhat.com, mst@redhat.com
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

On Sun, May 15, 2022 at 03:29:14PM -0500, Mike Christie wrote:
>The following patches are Andrey Ryabinin's flush cleanups and some
>from me. They reduce the number of flush calls and remove some bogus
>ones where we don't even have a worker running anymore or they were
>based on outdated or incorrect assumptions.
>
>Jason, for the patches you gave me an explicit acked/reviewed tag I
>added it. For the replies where I answered your review questions and
>you only replied with an affirimative reply I did not add a tag,
>because I was not not 100% sure what you wanted to do.
>
>These patches will be used in the vhost threading patches which I think
>will make progress again now that I have Christian's email figured out
>:) (he had moved to microsoft but I've been using the ubuntu address).
>I think the patches are ok cleanups in general so I thought they could
>get merged separately if people agree.
>
>V2:
>- Added patch to rename vhost_work_dev_flush to just vhost_dev_flush
>to handle review comment from Jason about the naming not being so
>great.
>
>

Thank you for this cleanup!

I think there is only a small issue to fix in vhost/test.c, otherwise it 
looks good to me :-)

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

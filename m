Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C103C433EF
	for <virtualization@archiver.kernel.org>; Wed,  6 Apr 2022 07:48:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE28681B17;
	Wed,  6 Apr 2022 07:48:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rrxuxqkOgDv3; Wed,  6 Apr 2022 07:48:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6C3DE81A5F;
	Wed,  6 Apr 2022 07:48:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DD7FC001D;
	Wed,  6 Apr 2022 07:48:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7529C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 07:48:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C0A9681A95
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 07:48:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IqZe11PjaTeb
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 07:48:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE76E81A5F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 07:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649231280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tnMN3pUaj7lJGkHw7ZLvt0aTt3QjufyLZHnTLczmUJE=;
 b=ZHD3RBHYJUhUtxjgM2rMOgpE09EHsaF1eOMsiBtvDX/SSYJFGN22Fzm5NezPq3o+Punulu
 sotrBOKgiuyO8ZK4JxbHUAlHn+otnFWi/lu0DZg7IcusWLTgfcYjWD6QvAz5gkNYnXgT7x
 lg2Sx4nxTUHPIi3JHjNuwhe3H1namck=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-fyPrJWSAMr6akXP6buUgVw-1; Wed, 06 Apr 2022 03:47:59 -0400
X-MC-Unique: fyPrJWSAMr6akXP6buUgVw-1
Received: by mail-ed1-f69.google.com with SMTP id
 w8-20020a50d788000000b00418e6810364so762794edi.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Apr 2022 00:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tnMN3pUaj7lJGkHw7ZLvt0aTt3QjufyLZHnTLczmUJE=;
 b=OpbviJvzjfwE5eNgTw1gJjeGfcR6DIJ61LReYjS3p3gpBtaqTYOT1WPt7uYnxy79En
 6o4ly/+bihUf1PVdb/wBbtoHBzEyjX9vgGEFoQY4cgWYZ4RHOh7JmNHBaUjQ4jPS1Fbu
 2tRbDkk8n+w9L8wxNgJXlczQem2XrCUROmxyQiktNzi+vUZqwyRVK/aR2cc/73ymc+7+
 tak8nu7tLQGOvZ7hK0YXF146FbKq12aWCcCL8B8WfOLVimdnOSKcNZdRhpLcBczM35Xw
 FMvzNQY6h/3gaNgUadK8AXU12XJVpCu8KXpclwakWXSuO+MJ7FDther/cw7c0ertkwoJ
 UbQg==
X-Gm-Message-State: AOAM530/KD+ujeXek3KzrSrT3leRvH269/3+IDL8RtvXmG3mGQsbUgJk
 KiW41v7GtT6SjpXDhOS3iws0vsLHPQ8ICokJX8990BZ+NgfbivqozDYWr38vo0+WCEJw594Zm+R
 8IcdF7P+lOBP4zqYNCNU5qqwd5qK/Wh6t7W3fZjygQg==
X-Received: by 2002:a05:6402:183:b0:410:fde:887a with SMTP id
 r3-20020a056402018300b004100fde887amr7228687edv.243.1649231278380; 
 Wed, 06 Apr 2022 00:47:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLcLipZLH882pfJA3h0lLGi++W3jsGhKM/fA7YIjyDbCflYB4XnGKFeaNybu/dm01/9LLhtA==
X-Received: by 2002:a05:6402:183:b0:410:fde:887a with SMTP id
 r3-20020a056402018300b004100fde887amr7228671edv.243.1649231278152; 
 Wed, 06 Apr 2022 00:47:58 -0700 (PDT)
Received: from redhat.com ([2.53.144.12]) by smtp.gmail.com with ESMTPSA id
 k23-20020a1709062a5700b006ccd8fdc300sm6132409eje.180.2022.04.06.00.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Apr 2022 00:47:57 -0700 (PDT)
Date: Wed, 6 Apr 2022 03:47:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 0/4] Introduce akcipher service for virtio-crypto
Message-ID: <20220406034721-mutt-send-email-mst@kernel.org>
References: <20220302033917.1295334-1-pizhenwei@bytedance.com>
 <a9d1dfc1-080e-fba2-8fbb-28718b067e0d@bytedance.com>
 <20220307040431-mutt-send-email-mst@kernel.org>
 <87h778g8nn.fsf@redhat.com>
 <20220405012015-mutt-send-email-mst@kernel.org>
 <87ee2cexp5.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87ee2cexp5.fsf@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
 zhenwei pi <pizhenwei@bytedance.com>,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 helei.sig11@bytedance.com
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

On Tue, Apr 05, 2022 at 10:33:42AM +0200, Cornelia Huck wrote:
> On Tue, Apr 05 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Apr 04, 2022 at 05:39:24PM +0200, Cornelia Huck wrote:
> >> On Mon, Mar 07 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> 
> >> > On Mon, Mar 07, 2022 at 10:42:30AM +0800, zhenwei pi wrote:
> >> >> Hi, Michael & Lei
> >> >> 
> >> >> The full patchset has been reviewed by Gonglei, thanks to Gonglei.
> >> >> Should I modify the virtio crypto specification(use "__le32 akcipher_algo;"
> >> >> instead of "__le32 reserve;" only, see v1->v2 change), and start a new issue
> >> >> for a revoting procedure?
> >> >
> >> > You can but not it probably will be deferred to 1.3. OK with you?
> >> >
> >> >> Also cc Cornelia Huck.
> >> 
> >> [Apologies, I'm horribly behind on my email backlog, and on virtio
> >> things in general :(]
> >> 
> >> The akcipher update had been deferred for 1.2, so I think it will be 1.3
> >> material. However, I just noticed while browsing the fine lwn.net merge
> >> window summary that this seems to have been merged already. That
> >> situation is less than ideal, although I don't expect any really bad
> >> problems, given that there had not been any negative feedback for the
> >> spec proposal that I remember.
> >
> > Let's open a 1.3 branch? What do you think?
> 
> Yes, that's probably best, before things start piling up.

OK, want to do it? And we can then start voting on 1.3 things
straight away.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

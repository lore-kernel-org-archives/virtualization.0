Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF21DC10F1B
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 07:22:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F7C860BA2;
	Tue, 27 Dec 2022 07:22:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F7C860BA2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FFeHzEZu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fwgzfJMTuLN9; Tue, 27 Dec 2022 07:22:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B1FC760BA1;
	Tue, 27 Dec 2022 07:22:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B1FC760BA1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98D8AC0035;
	Tue, 27 Dec 2022 07:22:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9D7EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:22:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8BF2360BA2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:22:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8BF2360BA2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zk9_RezGcIMs
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:22:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB06960BA1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB06960BA1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672125726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zfKUWZq7lCvM5zpq0a3YtNlAumoZQidpl8RqW6Hsass=;
 b=FFeHzEZulJS3zPQuwYaPqJGlX2QfHZ24K787gv7Q+ntjVP6olsEJ0/dDFS2P6S71aTgC4Q
 K2s4ngu4chq5zQwPiFmQ9sGfRI4CUJPHWSksFVqmJ5QJfr/qDpOyJgk9qDtC2uVdmN055c
 zHmJVnPftnOaf/QoY8bSoJhns96nFn0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-108-FricIhe6OHSZrxAMUPXuAw-1; Tue, 27 Dec 2022 02:22:04 -0500
X-MC-Unique: FricIhe6OHSZrxAMUPXuAw-1
Received: by mail-wm1-f69.google.com with SMTP id
 f20-20020a7bc8d4000000b003d1cda5bd6fso2999896wml.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 23:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zfKUWZq7lCvM5zpq0a3YtNlAumoZQidpl8RqW6Hsass=;
 b=RxalUf9Ud0P2w5w4WSjq/vYfJJNO9rhoVfRieoPVavGl6F6Tm9fUDWSxh+wP+WjBdw
 hdQ9yf7uzYQtprpMTvB+0hwzbgB7z+xNt8qJ3KKtxHMUOgXPfGlOTFZmQMLh/28qBYI+
 UCTInVS18kEgUHeb8eNd4zAxb4dELsEbS3fnqBXBJcPPnw9zazEQZJnk9lHf7JdPbeQO
 54BCQeeFzr5TlmkYWUy5KOtPV2Xrhag7Dq8/5JtZMn/KWZVAFX0dNjRixhHBIK7dJtZt
 TEongRE6mvctX8BsyeqlbO99mfUFrXGAg7xb/GmtSyMGP+gWZzfuuIcvgRKxqTzZTVmD
 3Tig==
X-Gm-Message-State: AFqh2kqETsnQ5DrHjY1XjhLmo0OUSl1xmbGMHzULCYIvFQrjg9dI8p9I
 Nco8dZp+NV/HVjJqoobl+Y53UhV6+aOPpconJAAYQJcL9ifK9bognKeUjDtb+ixD4/5kd+Vi+MI
 k37r56DZ1RG4FJ24GQIbnXOkGG3DvD981OgIZwJz8lw==
X-Received: by 2002:a05:600c:1e11:b0:3d2:26e1:bd45 with SMTP id
 ay17-20020a05600c1e1100b003d226e1bd45mr18912022wmb.29.1672125723571; 
 Mon, 26 Dec 2022 23:22:03 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtwhWF3hOB+CfPMNbqAWtPqmXhnEhLYXElqDaRnAVfaIXYN2fR1+P4H6eVMgRzb2KIsN1XyWg==
X-Received: by 2002:a05:600c:1e11:b0:3d2:26e1:bd45 with SMTP id
 ay17-20020a05600c1e1100b003d226e1bd45mr18912007wmb.29.1672125723386; 
 Mon, 26 Dec 2022 23:22:03 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 y24-20020a05600c365800b003cf894dbc4fsm16018925wmq.25.2022.12.26.23.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Dec 2022 23:22:03 -0800 (PST)
Date: Tue, 27 Dec 2022 02:21:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Chen, Jian Jun" <jian.jun.chen@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Update maintainer list for virtio i2c
Message-ID: <20221227022149-mutt-send-email-mst@kernel.org>
References: <20221214053631.3225164-1-conghui.chen@intel.com>
 <20221214063107.fazrfq3n26hw4ndl@vireshk-i7>
 <Y5mjcuCRP45ynJis@shikoro>
 <20221214065856-mutt-send-email-mst@kernel.org>
 <fd9bc91a-8afe-9dac-7d1f-2e57e658d2d7@intel.com>
MIME-Version: 1.0
In-Reply-To: <fd9bc91a-8afe-9dac-7d1f-2e57e658d2d7@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: asowang@redhat.com, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
 Conghui <conghui.chen@intel.com>
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

On Tue, Dec 27, 2022 at 12:05:09PM +0800, Chen, Jian Jun wrote:
> 
> On 12/14/2022 20:00, Michael S. Tsirkin wrote:
> > On Wed, Dec 14, 2022 at 11:20:34AM +0100, Wolfram Sang wrote:
> > > Hi Viresh,
> > > 
> > > > I understand that it is okay to pass the maintainership, within the
> > > > company, for platform specific parts from one person to another, since
> > > > they have the best knowledge of the code and are the only one
> > > > interested in maintaining it too.
> > > > 
> > > > But what is the rule for generic drivers like this one ?
> > > Dunno if this is really a rule, but if a maintainer steps out and makes
> > > sure there is someone to pick up the work, this is more than welcome.
> > > Way better than a stale entry in the MAINTAINERS file.
> > > 
> > > I mean, it does not limit the chance to have further maintainers, for
> > > example. I believe in meritocracy here. Those who do and collaborate,
> > > shall get responsibility.
> > Exactly. I'd like to see Jian Jun Chen do and collaborate first.
> 
> Hi Michael,
> 
> Sure, I will start to collaborate first.

Great!

> > > If not, then not. We can fix this, too, if
> > > needed.
> > > 
> > > What is the reason for your question?
> > > 
> > > All the best,
> > > 
> > >     Wolfram
> > > 
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

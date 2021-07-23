Return-Path: <SRS0=XE2Y=MP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3343C4320E
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 01:30:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53DF60EB5
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 01:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A53DF60EB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60429608F4;
	Fri, 23 Jul 2021 01:30:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NrgzOmeHDfhR; Fri, 23 Jul 2021 01:30:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1CA7E60637;
	Fri, 23 Jul 2021 01:30:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5CF5C001A;
	Fri, 23 Jul 2021 01:30:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC224C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 01:30:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AAEC64013C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 01:30:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MbZgtzGKWmXx
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 01:30:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B8425400CE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 01:30:05 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id m1so34588pjv.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 18:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=f06gqWc2bEaZJ6nbd8VrGNk6zDGVJAhrmVyUATfeuhY=;
 b=uH3LTYq9lKkVh6FySVISF2uXoH17+HO/ef+NS7sXs7p8VhOdVPTkf+xDywOJI7ZGeq
 J5vyXN5sIk5K28aSYCheQLYmLarcrwifRRqWOMDtKPWn4zvvxSsqTA/LMekE9uKmElQt
 WO5XrD/lpIAFXo8o3ZlXZ2RLIn59Lahw6A0UOEnlf43IpUPKvrAWKBWbPmx+otKNLFFa
 cTbOkddzUhdmQKUP9KIBFD+aEtLvw3nJaXWw8iW5F28MT+IBeoNC6LThOpDqosoE+XhQ
 /2s1NQSFVXpy9aIoXoI7voS5KTgATBCgzW+ijmB6nTwYCppDaFbliHaMHs227vBPnrLv
 UQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=f06gqWc2bEaZJ6nbd8VrGNk6zDGVJAhrmVyUATfeuhY=;
 b=DdVCqf9MmPSDP7etmd7rT0ZiHaCD4+PcnKQu5gVa6qEL2mweOg1ab2N/bdYjL5H9AL
 sUHgtNUL3TUrAUfJZRTBPApKelMWxpPry5N7f2Qe10jkBZr7QoUf1kV0K7FjKl1Z27oh
 1zulCHMucn1riulnjBeq2228RoJx/kZ1C1IQ7lbpCln/nNOjjBybEmm4W6OvoNuGm46Y
 K/qPTpMV+RB5hfbf8Z5zy8qjgJR9ivOe4YXolVBcgJXCrAjRYeaP5BHccYw+ItzLqVng
 +qR+pBw+BYm9w3SXDzmeI5EwF50oI2yf67GigUHwWV2IIn27gwq/6etbq+MxBfYwIz/f
 MyNQ==
X-Gm-Message-State: AOAM531NE9P3eAvYDOwnGHwn2S9hoepA33j1rrdrnEWnKIWZSEUoVoO1
 +AlbYhjHjJAiuAC2a5GswiqlDQ==
X-Google-Smtp-Source: ABdhPJydmHBLdYGZ806rSsmrNTgmWWvO9B0B1rmVcJM9THK88hoR6AIbtcF5apFDFRDUXuwolLnX+g==
X-Received: by 2002:a17:90a:4586:: with SMTP id
 v6mr2402677pjg.36.1627003805157; 
 Thu, 22 Jul 2021 18:30:05 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id z15sm35760876pgc.13.2021.07.22.18.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jul 2021 18:30:04 -0700 (PDT)
Date: Fri, 23 Jul 2021 07:00:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH V2 5/5] virtio: Bind virtio device to device-tree node
Message-ID: <20210723013000.h43nfnrrichg6nap@vireshk-i7>
References: <cover.1626947324.git.viresh.kumar@linaro.org>
 <026ad5f274d64d46590623f9f3a04b8abfbe62d7.1626947324.git.viresh.kumar@linaro.org>
 <CAK8P3a0iQ5dt_38Y9j6XCoj=n7YA+cPz7i6mjP24k9WY7QL+oA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a0iQ5dt_38Y9j6XCoj=n7YA+cPz7i6mjP24k9WY7QL+oA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>, DTML <devicetree@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Bill Mills <bill.mills@linaro.org>
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

On 22-07-21, 16:52, Arnd Bergmann wrote:
> On Thu, Jul 22, 2021 at 11:56 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > +/* Virtio device compatibles and IDs */
> > +static const struct of_device_id of_virtio_devices[] = {
> > +       { .compatible = "virtio,22", .data = (void *)VIRTIO_ID_I2C_ADAPTER },
> > +       { .compatible = "virtio,29", .data = (void *)VIRTIO_ID_GPIO },
> > +       { }
> > +};
> > +
> > +static int virtio_device_of_init(struct virtio_device *dev)
> > +{
> > +       struct device_node *np, *pnode = dev->dev.parent->of_node;
> > +       const struct of_device_id *match;
> > +       int ret, count;
> > +
> > +       if (!pnode)
> > +               return 0;
> > +
> > +       count = of_get_available_child_count(pnode);
> > +       if (!count)
> > +               return 0;
> > +
> > +       /* There can be only 1 child node */
> > +       if (WARN_ON(count > 1))
> > +               return -EINVAL;
> > +
> > +       np = of_get_next_available_child(pnode, NULL);
> > +       if (WARN_ON(!np))
> > +               return -ENODEV;
> > +
> > +       match = of_match_node(of_virtio_devices, np);
> > +       if (!match) {
> > +               ret = -ENODEV;
> > +               goto out;
> > +       }
> 
> I think it would be better not to have to enumerate the of_virtio_devices[]
> strings, but instead use of_device_is_compatible() to match against
> "virtio,%d". Otherwise we end up modifying this function for every
> virtio driver that needs a binding.

Yeah, will do that.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

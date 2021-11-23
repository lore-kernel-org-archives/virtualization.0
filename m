Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C520DC433F5
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 02:28:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 501444029F;
	Tue, 23 Nov 2021 02:28:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K-t9l0LffbT0; Tue, 23 Nov 2021 02:28:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AC8994010B;
	Tue, 23 Nov 2021 02:28:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76F21C002E;
	Tue, 23 Nov 2021 02:28:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D66DAC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 02:28:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BCFED401B8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 02:28:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UxphuLEYytJ3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 02:28:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D572E4010B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 02:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637634497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4RAeBAOFXB9KJ5rHMapLnFjZqieuF/Pl2Ihdhc6gYMA=;
 b=IHLowJBhFjHLEI7paS3i7O7Oy7jG5USGyCFDhLmumRuS9cLKTcyJDVNFWJsrg4sIQi+MmX
 E+OV84ijJmERxTUaHitV8gM8hkkBcofpAY+KDoc6zrr/S2WLOZE3/5DbmeiYbqW2RvqgRB
 MebNSWlAn8srLspHLSIb89Mf5dYpC+E=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-XocTyDAAMEaw_WWq8jBOQQ-1; Mon, 22 Nov 2021 21:28:16 -0500
X-MC-Unique: XocTyDAAMEaw_WWq8jBOQQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 y40-20020a0565123f2800b003fded085638so13377205lfa.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 18:28:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4RAeBAOFXB9KJ5rHMapLnFjZqieuF/Pl2Ihdhc6gYMA=;
 b=4JDr3jfkTgcdGbeAEyfAc5vmyL+feRFRRarptTeVn423OMgMhcHPdWyViX5DfbXEER
 GSg+8XmGjJJ6DSCe2op3IfCj/vDiHPhDDpJw6laMZMSdY45tqaf35bnjKzbRR+5K2HhI
 qi9VhQBEMQXV85mo2Bp8midL+Pe6YRWFVqzx0HVotzj73/D/5Vjpo7aSwvK6+aYl1jDZ
 QtXB9meW6DL0wBXp/oUA70LTzT3Of8vWIOsbua5W8xgJ2yYGkDXb4ujDCUxNIAyqBSpX
 h6lQxgnKysoY1LTpIkYB8KGW+kLahiOtx9gwevHtB/UOTWQlivi1/xse2ioIUH4SBMhi
 tbxQ==
X-Gm-Message-State: AOAM532wnoQZ+znki+f5zQhsJCTgNYcy3tqa8xqsfFVIUHQpTa8dmjdu
 /ORrMBVkDmvsM0xWBpWxxtpEt+WoohNjjmQB1r681Bl82RbNMUIjTyWke6iVPCZ1CH5ttmZDkbX
 KFOT++bqGH8pIvkWtBhDKh/+FkNzNU8MuOLtCGsAEznSh5Fk0Zw983hEXEA==
X-Received: by 2002:a05:6512:2081:: with SMTP id
 t1mr1197635lfr.348.1637634495245; 
 Mon, 22 Nov 2021 18:28:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLku+5b00pEdNnOg6+h6/74Wtn8J1n2lBt89vj/ABQ38/loe9G5pN4o3XZyPRtY1x85IUOZnXpnpRNp2mhIME=
X-Received: by 2002:a05:6512:2081:: with SMTP id
 t1mr1197618lfr.348.1637634495078; 
 Mon, 22 Nov 2021 18:28:15 -0800 (PST)
MIME-Version: 1.0
References: <20211118055741.239639-1-elic@nvidia.com>
 <20211118055741.239639-2-elic@nvidia.com>
 <CACGkMEsDHKCTSHtLBp3Pr0wntgYzsSBNjCNjQjGkmk2iap80rg@mail.gmail.com>
 <PH0PR12MB548187F4DE8C789908839F9DDC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEssVx-quDa+c7wYAyB6a3j88EBAYTW+y8e_FcxW2mA1nQ@mail.gmail.com>
 <20211122075615.GB74340@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEs0mCKV4iF=O7Psxip38tL5iiu92Kzj_LqLgTqXV-M+NA@mail.gmail.com>
 <20211122090755.GA75489@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEtMB78O7K5E+dV6M7_K3U1fOV_8Q7pArD05THVWszjZKg@mail.gmail.com>
 <PH0PR12MB548147E2266D0A8D7B1951F1DC9F9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211122150704.GA88466@mtl-vdi-166.wap.labs.mlnx>
 <PH0PR12MB548193CA4DE7965673AAC3F7DC9F9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB548193CA4DE7965673AAC3F7DC9F9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Nov 2021 10:28:04 +0800
Message-ID: <CACGkMEvZW6MbfXQh-++tDWZukEQmKsqV660=r-S+mgYM2_NppQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: Add support for querying statistics
To: Parav Pandit <parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>
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

On Mon, Nov 22, 2021 at 11:56 PM Parav Pandit <parav@nvidia.com> wrote:
>
>
>
> > From: Eli Cohen <elic@nvidia.com>
> > Sent: Monday, November 22, 2021 8:37 PM
> >
> > On Mon, Nov 22, 2021 at 12:15:36PM +0200, Parav Pandit wrote:
> > >
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Monday, November 22, 2021 3:02 PM
> > > >
> > > > > If we go with vendor stats, how can we communicate the information
> > > > > to userspace? Currenlty we use netlink attributes defined to pass
> > > > > this information.
> > > >
> > > > It can be done exactly as what have been done in the patch, we can
> > > > document it as vendor stats.
> > > >
> > > Yes, attribute to have VENDOR_ prefix in it.
> > > >
> > > > Ok, I think I get you. So I wonder if it's more useful to use device
> > > > specific counters. For networking, it could be packets send/received etc.
> > >
> > > Yes, I equally discussed this previously with Eli as its more meaningful for end
> > users.
> > > We just return the device id of it along with queue number that helps to show
> > tx and rx.
> > > For ctrl q, it is just ctrl commands and ctrl completions.
> >
> > I don't think we should mix send/receive packets for descriptors statistics. The
> > hardware could process a descriptor and still not transmit any packet.
> >
> > We can add packets send/recv but descriptor statistics have their own value.
> >
> Oh right. I read Jason's comment of _packets_ to fast. I meant to say send/receive descriptors.
> I guess you already named them as tx and rx. Didn't review the patches in this series yet.
>
> > To summarize, I can add the VENDOR_ preifx to the attibutes and re-send or is
> > there anything else you think should change?
> VENDOR_ prefix and command as iproute2 command as "vstats" looks fine to me.

Ack, but we need to figure out:

1) use descriptors or buffers.
2) if we use descriptors, for indirect descriptors and descriptor
chains how are they counted?

Thanks

>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

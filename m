Return-Path: <SRS0=FRCo=EK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFD0C4741F
	for <virtualization@archiver.kernel.org>; Wed,  4 Nov 2020 09:33:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DECA1221F8
	for <virtualization@archiver.kernel.org>; Wed,  4 Nov 2020 09:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EQSmu7gH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECA1221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 380502264A;
	Wed,  4 Nov 2020 09:33:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bEnOri-bhtO3; Wed,  4 Nov 2020 09:33:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 68F802049B;
	Wed,  4 Nov 2020 09:33:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54763C0889;
	Wed,  4 Nov 2020 09:33:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8F34C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 09:33:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B41EE2049B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 09:33:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 83WSnjLT+Ok7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 09:33:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by silver.osuosl.org (Postfix) with ESMTPS id B3CB220445
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 09:33:49 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id p93so21718603edd.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 Nov 2020 01:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=1DyDheOb7hdP2j6+U4rmaA8px4hw4FKnG8K+MWzcbCY=;
 b=EQSmu7gHVfLkVF8VHKlfv0z9wC3WTiS8thx/WbFlnXuy03FTmdr6eI7gSMK+hKzlOX
 vzXdLk5eTEGMKBtye7uzKns5a1uXsQk7lWH2DdYAG9+bYlF2w9/MZ2e6ljk/mYqzjheB
 Olzmy9gyhEiX/6VLDcVwgs0Kuq+TF92bkOXzRshy5jkEtiac+3anQExlCRjj0lcuyk2l
 bRBKsOEM6ACzPe9fg5WRTAtzBUk1JKwQIdm2COAEQToBI8cSMpnuMkDNNSdThGhdp8wA
 0RIm6Pt8ng8j6NtVGkN8ALssajF5YOmP3ktUcTM6jdAydebyKA9Mcf7CzAgNYMJX6urQ
 fvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1DyDheOb7hdP2j6+U4rmaA8px4hw4FKnG8K+MWzcbCY=;
 b=LBPuZ/0HsyR8rEuZB373cmKwYrX2BMex/g4jKo2iCJ90MaBmXI1kOT9mFaB0RZ5NAo
 VBLKO8yJGfbPvH9O86OWOQxn+JTbbprfQwcHKIe4jiX7aLGzzpdic9F2eHuAIRTp7R9o
 QZ1NsGHoggyzvAQnvX/WUJstMf2o6zkMbH7QsttteYcL6VpuBDIKoPf3bPPN1wOzaqJ6
 geYREd0OXpXRuufO5RRSR/uN1jdOkemZoHCa0Na5mFCeded+m8udgALbLnSUp2rLAl4u
 dTuQCbhtY0EZ0j7S5WbsFrjUhofQl47GrfC+8dWt38DCZRqGWn5uKECUCb+a3jUeZwBz
 mUyw==
X-Gm-Message-State: AOAM530s9IaBY8qIit2oyaZ7g+E+56MQZOXNX/PkzLsPTovpTECK1Pl5
 t2A6lT6NcT3CH7S/tydkEkcilQ==
X-Google-Smtp-Source: ABdhPJxwJwBOkJVz8J2LWuNKj/Ohtfm5+UYk8BmI+7+MjrwC4ykaiVvXA9wdH6bYcYvQ5FP9G4l5OQ==
X-Received: by 2002:aa7:da44:: with SMTP id w4mr14267958eds.131.1604482428113; 
 Wed, 04 Nov 2020 01:33:48 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id b12sm726638edn.86.2020.11.04.01.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 01:33:47 -0800 (PST)
Date: Wed, 4 Nov 2020 10:33:28 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20201104093328.GA505400@myrica>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
 <20200924053159-mutt-send-email-mst@kernel.org>
 <d54b674e-2626-fc73-d663-136573c32b8a@redhat.com>
 <20201002182348.GO138842@redhat.com>
 <e8a37837-30d0-d7cc-496a-df4c12fff1da@redhat.com>
 <20201103200904.GA1557194@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201103200904.GA1557194@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, lorenzo.pieralisi@arm.com,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>, virtualization@lists.linux-foundation.org,
 Auger Eric <eric.auger@redhat.com>, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, bhelgaas@google.com
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

Hi Al,

On Tue, Nov 03, 2020 at 01:09:04PM -0700, Al Stone wrote:
> So, there are some questions about the VIOT definition and I just
> don't know enough to be able to answer them.  One of the ASWG members
> is trying to understand the semantics behind the subtables.

Thanks for the update. We dropped subtables a few versions ago, though, do
you have the latest v8?
https://jpbrucker.net/virtio-iommu/viot/viot-v8.pdf

> Is there a particular set of people, or mailing lists, that I can
> point to to get the questions answered?  Ideally it would be one
> of the public lists where it has already been discussed, but an
> individual would be fine, too.  No changes have been proposed, just
> some questions asked.

For a public list, I suggest iommu@lists.linux-foundation.org if we should
pick only one (otherwise add virtualization@lists.linux-foundation.org and
virtio-dev@lists.oasis-open.org). I'm happy to answer any question, and
the folks on here are a good set to Cc:

eric.auger@redhat.com
jean-philippe@linaro.org
joro@8bytes.org
kevin.tian@intel.com
lorenzo.pieralisi@arm.com
mst@redhat.com
sebastien.boeuf@intel.com

Thanks,
Jean
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <SRS0=XmMV=HA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5313C433E0
	for <virtualization@archiver.kernel.org>; Fri, 29 Jan 2021 12:07:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AD4264E09
	for <virtualization@archiver.kernel.org>; Fri, 29 Jan 2021 12:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD4264E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B6F68871AB;
	Fri, 29 Jan 2021 12:07:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f2Bb497FdpM1; Fri, 29 Jan 2021 12:07:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 21FDE871A5;
	Fri, 29 Jan 2021 12:07:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2039C0FA8;
	Fri, 29 Jan 2021 12:07:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2533C08A1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 12:07:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C6E4727256
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 12:07:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OhTz80GbsxLQ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 12:07:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 by silver.osuosl.org (Postfix) with ESMTPS id CD62B233B0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 12:07:13 +0000 (UTC)
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id 78391A1525;
 Fri, 29 Jan 2021 13:07:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=srmailgate02; bh=JJnrezCSsqQA
 dlwabjWvvEpW6RUR5/hwqs7PuSOmpuA=; b=y2WG1hIlKlEDeRpuWLRd+Q1b7blL
 z+NMMR9liQvnr2S1apPRu5RaA4WUzhRYnjYLTYEdLq15pKJu7dbhjmIxLrerqw2o
 wfRhH5q+cMhEhjRHMUKzdeAptPZEfvgiFlbdqQT3XDfyuvDe0ls/oM2UGGn4+Ykl
 JHRe/4n5Jjkm3vCgA3/EIY9XRXgMM+pjubpThc39Pj297WHMr8Wm+n3+re+Xe/mf
 LomXuz2l0dPoiIb+g3bfwmQIkvdyX+0HAJ6FMBOdpD1udLBfY5TCisBk2LXVz8+s
 UpV/IWZ3jbs3+IA71Vt9YK04i7yA0Y67lzbYRSePYNhfTI+Y2x+1TJvFvg==
From: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
To: <vasyl.vavrychuk@opensynergy.com>
Subject: Re: [PATCH RESEND v3] virtio-input: add multi-touch support
Date: Fri, 29 Jan 2021 14:06:54 +0200
Message-ID: <20210129120654.16180-1-vasyl.vavrychuk@opensynergy.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210115002623.8576-1-vasyl.vavrychuk@opensynergy.com>
References: <20210115002623.8576-1-vasyl.vavrychuk@opensynergy.com>
MIME-Version: 1.0
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Cc: mst@redhat.com, rydberg@bitmath.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, mathias.crombez@faurecia.com,
 linux-input@vger.kernel.org
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

Hi, All,

There has been no reply to this patch.

Is there anything I can do?

Thanks,
Vasyl

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

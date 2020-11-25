Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29204C56201
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 18:09:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 825D121973
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 18:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/TE12ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825D121973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0A4CF2E160;
	Wed, 25 Nov 2020 18:09:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ttHKgOBwdOZn; Wed, 25 Nov 2020 18:09:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7B1EA2E10D;
	Wed, 25 Nov 2020 18:09:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65A5FC0891;
	Wed, 25 Nov 2020 18:09:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 871A0C0052
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 18:09:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7602187364
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 18:09:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SN2pgtVkh0ko
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 18:09:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3953D86B02
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 18:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606327739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rj8pm+nQSaWFTSOSQtYB5Wd34YMZOLy1lTAyR9VrKmQ=;
 b=U/TE12qlODFDuw52T394M0TpUla4JMI7aJZ4yDfcjZhs05UF9t3AzfgX+g0BnFhufYOqHt
 FR3wXtr2wnjCkFoeznffj4rcABRSyyt/KU1LEc4FaJkmu3Dz/boPd0fFQDhLEblySc2bC8
 D8qR7KEYtLMxc0a3V+/Qsw4cSfltlco=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-mkLggjtRNAGqQGfqYQ_twg-1; Wed, 25 Nov 2020 13:08:57 -0500
X-MC-Unique: mkLggjtRNAGqQGfqYQ_twg-1
Received: by mail-wm1-f72.google.com with SMTP id g125so639168wme.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 10:08:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Rj8pm+nQSaWFTSOSQtYB5Wd34YMZOLy1lTAyR9VrKmQ=;
 b=hy8lnUZOCWN8AxodmutRN6WojHaDDMl/nDW0UrRVnA4nHpNVHl0mMWb113sY94gdAk
 AAVuit445wBBGVT/s6V8PYp2dAbtbNOHLDeXiAEipWDsLJo5u24wSvzB2+gnd8E9LMgS
 dWn+EN03pp8Yef06JzYEnvF/HNU0ea9fAhtbGiBRvxrAa3No56p2BBum7LpJI3HrVIVF
 4MjtchVJJaS/0cT0RnIoEks9Hel2e+M+TDPlqvuisDiRCCRZasOUcGocbCSn2exDL3zR
 4c6iqKZfRpnwlEB07H7kpEGbSrLdo4dUkWrsdoLPYi6w8ax5Q+UjoryhGSBXh9CAJWDE
 ZLpQ==
X-Gm-Message-State: AOAM531uy/JqVi/TmX2AV3YLlZjtOmWQpkEC16A8NTBXt6ph1ugITXcX
 709VOGEHscjXRa66qVyyxSSSiKl1XU2zK/A2Dk8BIhmTBPLEkl+WcFwdK2lR0VeiIgiw02VYB+j
 FCAKQTWvSLWZyp2tKyDXMPwehrTOCFthgY5oAgGhLSQ==
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr5540350wrp.242.1606327736110; 
 Wed, 25 Nov 2020 10:08:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxr+ms6q6YSMPBxk+kd6cVidxefnBIvfyT4mWfT6nuSapnRRjueuuLmnfqST9DIl1NBvcw1gQ==
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr5540332wrp.242.1606327735945; 
 Wed, 25 Nov 2020 10:08:55 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id d17sm5450435wro.62.2020.11.25.10.08.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2020 10:08:55 -0800 (PST)
Subject: Re: [PATCH AUTOSEL 5.9 22/33] vhost scsi: add lun parser helper
To: Sasha Levin <sashal@kernel.org>
References: <20201125153550.810101-1-sashal@kernel.org>
 <20201125153550.810101-22-sashal@kernel.org>
 <25cd0d64-bffc-9506-c148-11583fed897c@redhat.com>
 <20201125180102.GL643756@sasha-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9670064e-793f-561e-b032-75b1ab5c9096@redhat.com>
Date: Wed, 25 Nov 2020 19:08:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201125180102.GL643756@sasha-vm>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Mike Christie <michael.christie@oracle.com>
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

On 25/11/20 19:01, Sasha Levin wrote:
> On Wed, Nov 25, 2020 at 06:48:21PM +0100, Paolo Bonzini wrote:
>> On 25/11/20 16:35, Sasha Levin wrote:
>>> From: Mike Christie <michael.christie@oracle.com>
>>>
>>> [ Upstream commit 18f1becb6948cd411fd01968a0a54af63732e73c ]
>>>
>>> Move code to parse lun from req's lun_buf to helper, so tmf code
>>> can use it in the next patch.
>>>
>>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
>>> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Acked-by: Jason Wang <jasowang@redhat.com>
>>> Link: 
>>> https://lore.kernel.org/r/1604986403-4931-5-git-send-email-michael.christie@oracle.com 
>>>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>>
>> This doesn't seem like stable material, does it?
> 
> It went in as a dependency for efd838fec17b ("vhost scsi: Add support
> for LUN resets."), which is the next patch.

Which doesn't seem to be suitable for stable either...  Patch 3/5 in the 
series might be (vhost scsi: fix cmd completion race), so I can 
understand including 1/5 and 2/5 just in case, but not the rest.  Does 
the bot not understand diffstats?

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

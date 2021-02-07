Return-Path: <SRS0=8NGF=HJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694E9C433E0
	for <virtualization@archiver.kernel.org>; Sun,  7 Feb 2021 02:21:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCF1364E90
	for <virtualization@archiver.kernel.org>; Sun,  7 Feb 2021 02:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF1364E90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 99B1C8715F;
	Sun,  7 Feb 2021 02:21:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0GAo4MeW+bpd; Sun,  7 Feb 2021 02:21:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0601F8714E;
	Sun,  7 Feb 2021 02:21:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE812C07FD;
	Sun,  7 Feb 2021 02:21:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDAC7C013A
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Feb 2021 02:21:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A81118691C
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Feb 2021 02:21:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CIvev4sg4fSj
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Feb 2021 02:21:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 06EBA86919
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Feb 2021 02:21:07 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id n10so7959596pgl.10
 for <virtualization@lists.linux-foundation.org>;
 Sat, 06 Feb 2021 18:21:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vRl839H4B+mxYDenDA16eRhD9TENdd+1sYt4/bsdS5E=;
 b=eYLGvVAYqIDoa9RmWv8aGH67NAHRzz/FzrZKKgVb+k30I4ECErKCy5F/CM3OYHQJH2
 VQGTPS72G3rh08PTusanJ2RPnLjcc4pqYcmD+uYxxHvKFN0xXNGdnPJQQb+WNd2AGXqO
 URTkwz1OWAsIUlG4f9QxaIssIZDZ143Lg11j8AM7iPOzKawOXgjfrosLJi2QfnSB3lgQ
 UPGacLyyXuPgafUtuDxCkgi552avR2tala+TcC46V82gQH9dDMKV3MIUPO0XodAJz/Kz
 O1k9Y7JznYOIEqi7ldkWvVvTTwZuQ9NhkDlHVaUJOp86mNNJhuaZLS/OXoy3Sl3MDC0P
 Rf3Q==
X-Gm-Message-State: AOAM533PbiOZoQD11bkOPJr7rF46PPUwlaakkTz8JtMQwHFqt45rRzXM
 mJzRvb8MCxdRovGH9BkarjiMY8iXbLg=
X-Google-Smtp-Source: ABdhPJx6vTQo7mESg+A9IbIFkQIw9J3WMrk2kfxnrZBw3pzABcHGC7foI/5nrEimPKT3KQwSMxMHqA==
X-Received: by 2002:aa7:961b:0:b029:1db:532c:9030 with SMTP id
 q27-20020aa7961b0000b02901db532c9030mr2566771pfg.30.1612664466124; 
 Sat, 06 Feb 2021 18:21:06 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:7d2:d17b:df07:7747?
 ([2601:647:4000:d7:7d2:d17b:df07:7747])
 by smtp.gmail.com with ESMTPSA id r68sm3415446pfc.49.2021.02.06.18.21.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Feb 2021 18:21:05 -0800 (PST)
Subject: Re: [PATCH 08/11] target iblock: add backend plug/unplug callouts
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Mike Christie <michael.christie@oracle.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20210204113513.93204-1-michael.christie@oracle.com>
 <20210204113513.93204-9-michael.christie@oracle.com>
 <BYAPR04MB496546E04938C9B78B71401586B09@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <19d5fe27-cf06-72b0-5351-5b41f711d2b5@acm.org>
Date: Sat, 6 Feb 2021 18:21:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB496546E04938C9B78B71401586B09@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
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

On 2/6/21 5:06 PM, Chaitanya Kulkarni wrote:
> On 2/4/21 03:40, Mike Christie wrote:
>>  
>> +	ib_dev->ibd_plug = kcalloc(nr_cpu_ids, sizeof(*ib_dev->ibd_plug),
>> +				   GFP_KERNEL);
> I'd actually prefer struct xxx in sizeof, but maybe that is just my
> preference.
> Not sure what is the standard practice in target code.

The above code is easier to verify than the suggested alternative. With
the alternative one has to look up the definition of ibd_plug to verify
correctness of the code. The above code can be verified without having
to look up the definition of the ibd_plug member.

Bart.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

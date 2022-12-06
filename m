Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B565CC47090
	for <virtualization@archiver.kernel.org>; Tue,  6 Dec 2022 18:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3A1FA40A89;
	Tue,  6 Dec 2022 18:44:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A1FA40A89
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KY27tb1QH8OQ; Tue,  6 Dec 2022 18:43:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C06E7400BB;
	Tue,  6 Dec 2022 18:43:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C06E7400BB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6623BC0033;
	Tue,  6 Dec 2022 18:43:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5FBCC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 18:43:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6DA5B81ED4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 18:43:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6DA5B81ED4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lHmNrEZFhFij
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 18:43:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF4F981ED2
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DF4F981ED2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 18:43:55 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id g10so14788913plo.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Dec 2022 10:43:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kkdpynN3ZZxXXoC+/B2qsqOUkzGgxT1EtXnN9c8yuhc=;
 b=MqcD6q50XiR4V1nod6wPXzKxO0ktoEHAV3Nd1l2mWxTbOJXPNBr7JeyvXx10hGmIXb
 zIP+wiaUnauECodzdPAA24LC4flsjDQB5WyMpP+o57arydz+uQkWK2gwLNg7FnscbZLr
 djRQyT62gRITRZSu7qwsH480n0W5Y250bHd4pouSLFWoDkUuENM2OfGc50SSXA+EHE+C
 P4bdglPe6rtL5ZJR+xrW7Rlia6XAAKSrOZZIYUTL6SWWBCysOPL4t0pt+UAk/eNzinBT
 8KzyeQDoXSoRlmqnWXVn3/VRTvTbVNaRjCnn3tBfW+z/bqof9QSyaGPLenJwMdimU/hl
 +QWQ==
X-Gm-Message-State: ANoB5pmyeOFUxz9VqLKbrrTBpFPV19f0ZtV68Ihz8iD5N18EtQOzh5Uk
 P96IkXk2fQ5WejGG1hYUamE=
X-Google-Smtp-Source: AA0mqf7j+ouvNKByY6CjriE3yqeB9gzC2l06X8kaUAU+HcxR8ONUrkX2oxkDdJixvxaJgsfMp5zJAA==
X-Received: by 2002:a17:90a:bd96:b0:219:3553:4ff5 with SMTP id
 z22-20020a17090abd9600b0021935534ff5mr45767962pjr.22.1670352235149; 
 Tue, 06 Dec 2022 10:43:55 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:6220:45e1:53d2:e1cb?
 ([2620:15c:211:201:6220:45e1:53d2:e1cb])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a63cd41000000b0045dc85c4a5fsm10068334pgj.44.2022.12.06.10.43.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Dec 2022 10:43:54 -0800 (PST)
Message-ID: <1d1c946d-2739-6347-f453-8ccf92c6a0cc@acm.org>
Date: Tue, 6 Dec 2022 10:43:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Content-Language: en-US
To: Alvaro Karsz <alvaro.karsz@solid-run.com>,
 virtualization@lists.linux-foundation.org
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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

On 12/5/22 08:20, Alvaro Karsz wrote:
> +/* Get lifetime information struct for each request */
> +struct virtio_blk_lifetime {
> +	/*
> +	 * specifies the percentage of reserved blocks that are consumed.
> +	 * optional values following virtio spec:
> +	 * 0 - undefined
> +	 * 1 - normal, < 80% of reserved blocks are consumed
> +	 * 2 - warning, 80% of reserved blocks are consumed
> +	 * 3 - urgent, 90% of reserved blocks are consumed
> +	 */
> +	__le16 pre_eol_info;
> +	/*
> +	 * this field refers to wear of SLC cells and is provided in increments of 10used,
> +	 * and so on, thru to 11 meaning estimated lifetime exceeded. All values above 11
> +	 * are reserved
> +	 */
> +	__le16 device_lifetime_est_typ_a;
> +	/*
> +	 * this field refers to wear of MLC cells and is provided with the same semantics as
> +	 * device_lifetime_est_typ_a
> +	 */
> +	__le16 device_lifetime_est_typ_b;
> +};

Why does the above data structure only refer to SLC and MLC but not to
TLC or QLC?

How will this data structure be extended without having to introduce a
new ioctl?

Thanks,

Bart.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

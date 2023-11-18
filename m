Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98AE101D2
	for <virtualization@lists.linux.dev>; Sat, 18 Nov 2023 07:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jc6nTUCT"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6c4884521f6so2499555b3a.0
        for <virtualization@lists.linux.dev>; Fri, 17 Nov 2023 23:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700292831; x=1700897631; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jvS+TEU7BLZ2Ws+wGWBvl7GPGDJLm60NOOheWwUlA+M=;
        b=jc6nTUCTeFa5eS8aPP3fwwwnuino/tq23WZPaXWlWLTuJ2RxIBvYCO17zeQAlUaOrN
         5AE8MMzlStEJU8I9ECYKkgqjgtctw6XSiIaHo+V/0ZfkdI4/SoWlqmnxM8qcUFVKVbxe
         WvaYEOa8fB8RK1uh6sIo8S6Sr5GrDSDdqSc1i3pHleH60ncncWnnx1573ql6U9kDvMxy
         Ts/GF5nwaAFHdbwQzbb4jbVbHs+pLruje7ZCmGJ3rhzBm2UB35gOQq1URlDvC2z/IV6g
         rauRe6yNsp7PbclOE+OKM2xvgBk7m5jqdgQT3nC1RJTqMUNAxUn5HWw/dCV9a6+UdJJl
         HQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700292831; x=1700897631;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvS+TEU7BLZ2Ws+wGWBvl7GPGDJLm60NOOheWwUlA+M=;
        b=G1NqTRP70k+IvHS8aX0/G2GcFpwjUmJ6VBH2f3rTmyRCPNamcjOCsiQKw+5MSwUexl
         ac7orCE0uCDEVoU+4r+x8QgYxA+fuMOTnKglzoSSh7VDR0WYHE91j58gg6BmNHp54CNc
         2H+eCW1Mnk8aqSnVA/JDBt51lo8rGXLD6h6ABPtXuCfgLsiU7iD2+CkKxvHFgwo4IY2g
         Ro2UdpxGGEYtwreeiB2OTX9zI0TCgYiKMaSGqq6fy2tiH7vnTlWzm8usHQ/+NYVSTjxl
         feSCEU6d0eGLXqafWFDj2J1QY7osX1Ai2RnF241+hBDbhznrg6eKk2Q+7lQZrpziGgNk
         iUDA==
X-Gm-Message-State: AOJu0YwkED6aHLasYEnCMtrUkOi5rlPIePBWsKpjJ/0D8LGlx9IiEymV
	OEWxx/cDeD9/NL5H7O5ezsAjNg==
X-Google-Smtp-Source: AGHT+IEumhuQYfV3o4Z721tq/oFbXwiRdHj0B+h8h6mYYmWoONPXZo9l/FJ3wWOkQ2FFk/eykNZFZQ==
X-Received: by 2002:a05:6a20:e609:b0:186:5265:ed1c with SMTP id my9-20020a056a20e60900b001865265ed1cmr1471698pzb.6.1700292830919;
        Fri, 17 Nov 2023 23:33:50 -0800 (PST)
Received: from [10.254.46.51] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id je6-20020a170903264600b001b8a3e2c241sm2482044plb.14.2023.11.17.23.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 23:33:50 -0800 (PST)
Message-ID: <93c0f8f2-f40e-4dea-8260-6f610e77aa7f@bytedance.com>
Date: Sat, 18 Nov 2023 15:33:44 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6 sched/fair: Add
 lag based placement)
Content-Language: en-US
To: Tobias Huschle <huschle@linux.ibm.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org
Cc: Peterz <peterz@infradead.org>, mst@redhat.com, jasowang@redhat.com
References: <c7b38bc27cc2c480f0c5383366416455@linux.ibm.com>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <c7b38bc27cc2c480f0c5383366416455@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/17/23 2:58 AM, Tobias Huschle Wrote:
> #################### TRACE EXCERPT ####################
> The sched_place trace event was added to the end of the place_entity function and outputs:
> sev -> sched_entity vruntime
> sed -> sched_entity deadline
> sel -> sched_entity vlag
> avg -> cfs_rq avg_vruntime
> min -> cfs_rq min_vruntime
> cpu -> cpu of cfs_rq
> nr  -> cfs_rq nr_running
> ---
>      CPU 3/KVM-2950    [014] d....   576.161432: sched_migrate_task: comm=vhost-2920 pid=2941 prio=120 orig_cpu=15 dest_cpu=14
> --> migrates task from cpu 15 to 14
>      CPU 3/KVM-2950    [014] d....   576.161433: sched_place: comm=vhost-2920 pid=2941 sev=4242563284 sed=4245563284 sel=0 avg=4242563284 min=4242563284 cpu=14 nr=0
> --> places vhost 2920 on CPU 14 with vruntime 4242563284
>      CPU 3/KVM-2950    [014] d....   576.161433: sched_place: comm= pid=0 sev=16329848593 sed=16334604010 sel=0 avg=16329848593 min=16329848593 cpu=14 nr=0
>      CPU 3/KVM-2950    [014] d....   576.161433: sched_place: comm= pid=0 sev=42560661157 sed=42627443765 sel=0 avg=42560661157 min=42560661157 cpu=14 nr=0
>      CPU 3/KVM-2950    [014] d....   576.161434: sched_place: comm= pid=0 sev=53846627372 sed=54125900099 sel=0 avg=53846627372 min=53846627372 cpu=14 nr=0
>      CPU 3/KVM-2950    [014] d....   576.161434: sched_place: comm= pid=0 sev=86640641980 sed=87255041979 sel=0 avg=86640641980 min=86640641980 cpu=14 nr=0

As the following 2 lines indicates that vhost-2920 is on_rq so can be
picked as next, thus its cfs_rq must have at least one entity.

While the above 4 lines shows nr=0, so the "comm= pid=0" task(s) can't
be in the same cgroup with vhost-2920.

Say vhost is in cgroupA, and "comm= pid=0" task with sev=86640641980
is in cgroupB ...

>      CPU 3/KVM-2950    [014] dN...   576.161434: sched_stat_wait: comm=vhost-2920 pid=2941 delay=9958 [ns]
>      CPU 3/KVM-2950    [014] d....   576.161435: sched_switch: prev_comm=CPU 3/KVM prev_pid=2950 prev_prio=120 prev_state=S ==> next_comm=vhost-2920 next_pid=2941 next_prio=120
>     vhost-2920-2941    [014] D....   576.161439: sched_waking: comm=vhost-2286 pid=2309 prio=120 target_cpu=008
>     vhost-2920-2941    [014] d....   576.161446: sched_waking: comm=kworker/14:0 pid=6525 prio=120 target_cpu=014
>     vhost-2920-2941    [014] d....   576.161447: sched_place: comm=kworker/14:0 pid=6525 sev=86642125805 sed=86645125805 sel=0 avg=86642125805 min=86642125805 cpu=14 nr=1
> --> places kworker 6525 on cpu 14 with vruntime 86642125805
> -->  which is far larger than vhost vruntime of  4242563284

Here nr=1 means there is another entity in the same cfs_rq with the
newly woken kworker, but which? According to the vruntime, I would
assume kworker is in cgroupB.

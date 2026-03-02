Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EF22E1EE5
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 08:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772438420; cv=none; b=JaPIZitGkEVzLDOLz71IatmkuxO9FgmYLCugZKMzE5bDcjBt1+tnjPStEp6C2JpSGZ9mlcglN2C7YNz9Dm9Rx3o6VSaOjBXR+mmL/n5cxfhTIjK/b58oEux+2XX0/upk36OXKbb0RoZ6rtTnPVsQfs4ih/+veRbCKz19OCoiFRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772438420; c=relaxed/simple;
	bh=3/LPu8Gts57wbVnF84SMwpPToGqL3wOUTkkMJnDpAvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohQWioqhqoJ6prWv+qQH9NB0YU8T22U4bxeqbwqN6R4Ut2Tog9iVa9+RKFWfAm1WWZpOkuJwRTX6+aFr4nLhEga+mQmGdoFkP/66we7eF9dLAZDA5+Q55N26+/FoKvRjFF1xEDiUIFtHXso3XGGLwcenVQCnlyjVerHXwwGFXbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DmmPBCzJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I8LWsMUh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DmmPBCzJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I8LWsMUh"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 621NQhIr2049380
	for <virtualization@lists.linux.dev>; Mon, 2 Mar 2026 08:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qm+FCCw8m1OMv5Ns4PujjpGalNlRFRIbaokGeVA3Mu0=; b=DmmPBCzJu3VyO1SN
	wjUcAMCJ102h39ME6280NXmFtyFkJapr95qwwXuADR9wfyaDz5OhyoPZHJypvWgt
	SedxVIeWxfe3QBXShnLQ0yNo6t3hu5oBxC6xUTxSTL/on6b3UOv/zwE3lLcn0uY2
	JrcMNJE0N5TOSmUvZqUJuyPbksZRFz/S1Z44Nb3D7K1wqaa6klBr8n2x8+RRSKcl
	feXxcoKIoyrZM1R55Gw04M7GZ1H1Qj9KhO9Gq/qHaDRt7NrgswXykBkm44JZizRH
	1NIXEjFdB2bHXQQOqQTgKZthVbYR0w8NEctD724F0aov7cmGAdQfzRnMzu+WGKip
	Pp9zWw==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ckshkvjun-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 08:00:16 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-46393ffb94eso49740152b6e.0
        for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 00:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772438415; x=1773043215; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qm+FCCw8m1OMv5Ns4PujjpGalNlRFRIbaokGeVA3Mu0=;
        b=I8LWsMUhXQUWdHlzf0dXirSdtQTK2RM9zEd2ZgPeUC3YoOvx4C3FaoKV/1iQfmgBUt
         h4bx8hwEMxREyRvRD2sCyGUkkUJLiCusps47NUJXsLrFUsEUB9YUVQXBIZCTVM0+vg4N
         z2P4wyLQnZZDCbpO4RkarmkOK4QMcR7jpPVoJryOmKVeCtNPw0K2huHNncC1crK5/Lv2
         f4iQbPAWYTzxnwnn6Hx0jD7vFWiDiWs7gyTNu1f3+VnaEK66koelbjwHAqvUGLCEYd7x
         cmJf8g95SRgjpn+ObHhpN4qgfRu6JAqS08zL7t4xzIdcs4NlavP/+fOuGsUADaaezCd7
         7Qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772438415; x=1773043215;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qm+FCCw8m1OMv5Ns4PujjpGalNlRFRIbaokGeVA3Mu0=;
        b=Ezqh3vI5L8gMSr3AhrGLtYnsycUKuovjGkM/8J92JCXC564mMwHwOZivPcnMtjseOq
         FzsaeEPylS9oB46ylipuBgvJW+ngorK1shXI86OWGBXNLPTH9LJLImJrA0Zdtfuf3kly
         oq37U0bFN2yD634rowDOi/gNrIDyYOHjRILrjd6eRcaDmBIaImHoDxcfJqkuK3YcnhBb
         kdDy0/jQXDgaL70sutkL321ZRGmL9HvCSuqyFPgVKkMjIHeajr0NByCzrnMmZpe0jpxS
         OtFzNPmiYMy8rKWRwja+340kvR9y+GNBJYCWHf8ad1OeIsb3kUvJkq4X5owc7q3erbO9
         cO7A==
X-Forwarded-Encrypted: i=1; AJvYcCXVaZ4fsrgUYleBJt1i4yvhzdiou0Rgv+ah1uJlkgXY33h0ZyHR+atA8j2AJw4Z9Cb0AeVos15ZpENIaIgdxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxj8b/At9ISWbqQ2yC9WkknTFlK8tcu/PlmakC0zLYF/ux1nrcj
	RxiT5fq6acQHXF3ADa/YHRcQ3DLnSGApj5G6E9x5p9rhOuJr3Ccs0xTj/pOwcM83S1VNo5BsHfZ
	9fhQ7X/lpDpRetCWIePJevxJyfFcbntLyAJPEHZBr/VlbbtXxQAlKpQNbTQTs14xEa1Ik6A==
X-Gm-Gg: ATEYQzxBWsPWqF3oUwZak05BNqGgM+fu/FpNDm9gGkjHj6gKlBk4r+0evunhXrmkpm9
	xoxQ2gfQVV1iYLucUMt9riaZsj3soVGsvXkPKaQIP665UAg5Y2nhz+Gj3yDCiH6uuiGDdiZTkE8
	W9CKbaTj20gqZSX9BOtqMWVBotY7qKuUzM20gmXMU5jwpvtK32IkN7dI/q7mpRj1SPtYNORC0V9
	zCidnw7QV1mh5fqV+kcCzkk2+VzOuHNWUVWs9GDeX/XZhCtypmQ7QKT5UkH/wtdOuKGGPCTrzzi
	DQ23AFM3O/VxRVN6vJATVJV78oP+VHyvox3i0p6hMTFZZjF5lpNvxO6jlxh3tb1jmHBFtm7O2/R
	Ebr8dXkTTncuRS6hdfziJ87EYuUet9H0kyKjWx+gJYOxZVQE/iZorICICviudtgkvv3RR6WJp6S
	4yWpWu
X-Received: by 2002:a05:6808:e82:b0:455:eba2:9efa with SMTP id 5614622812f47-464becb5a7dmr5673090b6e.4.1772438415471;
        Mon, 02 Mar 2026 00:00:15 -0800 (PST)
X-Received: by 2002:a05:6808:e82:b0:455:eba2:9efa with SMTP id 5614622812f47-464becb5a7dmr5673064b6e.4.1772438414974;
        Mon, 02 Mar 2026 00:00:14 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb59ae6csm7159701b6e.11.2026.03.02.00.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 00:00:14 -0800 (PST)
Date: Mon, 2 Mar 2026 00:00:11 -0800
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Michael Kelley <mhklinux@outlook.com>
Cc: Michael Kelley <mhklinux@outlook.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "decui@microsoft.com" <decui@microsoft.com>,
        "longli@microsoft.com" <longli@microsoft.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>, "rppt@kernel.org" <rppt@kernel.org>,
        "surenb@google.com" <surenb@google.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "jackmanb@google.com" <jackmanb@google.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "ziy@nvidia.com" <ziy@nvidia.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 4/4] page_reporting: change
 PAGE_REPORTING_DEFAULT_ORDER to -1
Message-ID: <aaVDiwEPl5t2UPX4@hu-ysakshit-lv.qualcomm.com>
References: <20260227140655.360696-1-yuvraj.sakshith@oss.qualcomm.com>
 <20260227140655.360696-5-yuvraj.sakshith@oss.qualcomm.com>
 <c618e7a4-42c1-4438-9bc2-9c41450a81a2@kernel.org>
 <aaUE7M9QkfnYh12e@hu-ysakshit-lv.qualcomm.com>
 <SN6PR02MB4157D37B3D254251F0135B04D47EA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <b1390b24-eaef-40e0-a16b-77c27decb77e@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1390b24-eaef-40e0-a16b-77c27decb77e@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA2OSBTYWx0ZWRfX6BlwDjB+uxJs
 sQZDs7PVj1UF0zIHbVU8Mu/hTmDK1Cfl936Zrt1JRoKykiD+R08ZX8MmR5c2Opa20iWTnGF7Ksr
 Wb3DT7V2HeZnYNQhO+vKXujnZFVkfNtRJ9FtWY76/9Bk4V9DheTQkM6lJfnEGEvJGGbkCEAs96z
 c1skqeNtHGE1oQDBTAUFA3FX2Kh+YxrgwQC0J3f5kSubmk6v04GEYfSV4aL1BX+0hGQe+v/Sjxs
 qEeIziacwYGo5Fkb9GXZjgPDlZ88GA27UrV0kQnH8iP7wyQO0ZznqojD5C+tMXhfe8Iq037EFeJ
 9227NZZlzIDmFKDojUmczj3rt0HHznAtkfabUD6iY0BRphmRFLHuSlCdwUtAbqJoXk1tIJ6UhqM
 oXurZvw94gWfw2taq269h4ybPxOXZst5RmkAS77D8l6t5hSBwNZ8n90f586UTOu/Ce7pbxCfQ5f
 WjDl3YqEGX+LAvaWFiA==
X-Proofpoint-ORIG-GUID: 6Tep5feLcq4nf0jfS4ELsY9m8O4CtpJk
X-Authority-Analysis: v=2.4 cv=EvbfbCcA c=1 sm=1 tr=0 ts=69a54390 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=evlnEj6GgMtUoz0GkIkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-GUID: 6Tep5feLcq4nf0jfS4ELsY9m8O4CtpJk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020069

On Mon, Mar 02, 2026 at 08:42:57AM +0100, David Hildenbrand (Arm) wrote:
> On 3/2/26 06:25, Michael Kelley wrote:
> > From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com> Sent: Sunday, March 1, 2026 7:33 PM
> >>
> >> On Fri, Feb 27, 2026 at 09:50:15PM +0100, David Hildenbrand (Arm) wrote:
> >>>
> >>> No need for the ().
> >>>
> >>> Wondering whether we now also want to do in this patch:
> >>>
> >>>
> >>> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> >>> index f0042d5743af..d432aadf9d07 100644
> >>> --- a/mm/page_reporting.c
> >>> +++ b/mm/page_reporting.c
> >>> @@ -11,8 +11,7 @@
> >>>  #include "page_reporting.h"
> >>>  #include "internal.h"
> >>>
> >>> -/* Initialize to an unsupported value */
> >>> -unsigned int page_reporting_order = -1;
> >>> +unsigned int page_reporting_order = PAGE_REPORTING_DEFAULT_ORDER;
> >>>
> >>>  static int page_order_update_notify(const char *val, const struct
> >>> kernel_param *kp)
> >>>  {
> >>> @@ -369,7 +368,7 @@ int page_reporting_register(struct
> >>> page_reporting_dev_info *prdev)
> >>>          * pageblock_order.
> >>>          */
> >>>
> >>> -       if (page_reporting_order == -1) {
> >>> +       if (page_reporting_order == PAGE_REPORTING_DEFAULT_ORDER) {
> >>>
> >>>
> >>
> >> Sure. Now that I think of it, don’t you think the first nested if() will
> >> always be false? and can be compressed down to just one if()?
> > 
> > I don't think what you propose is correct. The purpose of testing
> > page_reporting_order for -1 is to see if a page reporting order has
> > been specified on the kernel boot line. If it has been specified, then
> > the page reporting order specified in the call to page_reporting_register()
> > [either a specific value or the default] is ignored and the kernel boot
> > line value prevails. But if page_reporting_order is -1 here, then
> > no kernel boot line value was specified, and the value passed to
> > page_reporting_register() should prevail.
> > 
> > With this in mind, substituting PAGE_REPORTING_DEFAULT_ORDER
> > for the -1 in the test doesn’t exactly make sense to me. The -1 in the
> > test doesn't have quite the same meaning as the -1 for
> > PAGE_REPORTING_DEFAULT_ORDER. You could even use -2 for
> > the initial value of page_reporting_order, and here in the test, in
> > order to make that distinction obvious. Or use a separate symbolic
> > name like PAGE_REPORTING_ORDER_NOT_SET.
> 
Option 1:

if (page_reporting_order == PAGE_REPORTING_DEFAULT_ORDER) {
        if (page_reporting_order != PAGE_REPORTING_DEFAULT_ORDER
                && prdev->order <= MAX_PAGE_ORDER) {
                page_reporting_order = prdev->order;
        } else {
                page_reporting_order = pageblock_order;
        }
}

Option 2:

if (page_reporting_order == PAGE_REPORTING_ORDER_NOT_SET) {
        if (page_reporting_order != PAGE_REPORTING_DEFAULT_ORDER
                && prdev->order <= MAX_PAGE_ORDER) {
                page_reporting_order = prdev->order;
        } else {
                page_reporting_order = pageblock_order;
        }
}


> I don't really see a difference between "PAGE_REPORTING_DEFAULT_ORDER"
> and "PAGE_REPORTING_ORDER_NOT_SET" that would warrant a split and adding
> confusion for the page-reporting drivers.
> 
> In both cases, we want "no special requirement, just use the default".
> Maybe we can use a better name to express that.

Agreed.

If we were to read this code without context, wouldn't it be confusing as to
why PAGE_REPORTING_DEFAULT_ORDER is being checked in the first place?

Option 1 checks if page_reporting_order is equal to PAGE_REPORTING_DEFAULT_ORDER
and then immediately checks if its not equal to it. Which is a bit confusing..

And moreover, page_reporting_order can be set by two people. The commandline and
the driver itself. So PAGE_REPORTING_ORDER_NOT_SET can indicate if its set by cmdline
and PAGE_REPORTING_DEFAULT_ORDER can be used by drivers exclusively to "tell" page-reporting
to select the default value for us.

I think what Michael is pointing out is the prevalence of cmdline option over the driver's
request. 

This is not obvious to the reader if we choose to only have one flag IMO :)

Thanks,
Yuvraj
 
> -- 
> Cheers,
> 
> David












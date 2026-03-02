Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72653389DE3
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772441699; cv=none; b=sYbFcjXB39UgpNGH1+HfDmVuQD5PSV1ebFEcY2lak70AMSfDKVveDvbkgypicYFp5EPM0vDFvYhaj3a4VmgD/+Y7YWSHDST9SpDCNnPHdeFzkWu0skFTkUZrs89yz8MdGSRskhck0jwMa8f4La0/JnlwyaNRH+8UGHGiMvTctmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772441699; c=relaxed/simple;
	bh=yAVNgr9MNWD3wb1JJDuoyQVT80SX0m0ChtTIobo4WTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JR5x5iRXlROhdPvaZWuSPaoA9t3xPtaXlq9P3psdqVilTRQmEqBfQzNs9L26syrZqqJxF+LpaCrpJ34IIm6w54LX9qqrYaUGZM0YwClgvI1A6woa8XVdbcwp47Y7TtY8HgZg1MxJHYoHqOXjEPn9kjTtAgyKF5QKL5GNQE2HUeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UiXClT8S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VPClg2pN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UiXClT8S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VPClg2pN"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6227ghe72280383
	for <virtualization@lists.linux.dev>; Mon, 2 Mar 2026 08:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FDAsilwm29vpqMN7M32WikMZCz3A2rKxXxCHXUW3bm4=; b=UiXClT8StLpOkcSl
	GGZSemcy/y3pud38KNf984akTJRGXanuWkoBn4K0tBx1GU2xO1Rw76YMi+MCilXZ
	d7iIiFsJxK6WvdkR61nk685Mf6YvuxHIW+Xg1lHEK+7HSvJvwT25Koj0QeNEi4KN
	pHZkQDdU6npQtZadSHXg2Izeon+kxnPAQS6+0u4DuLd67gnMzPE59qRxBkpu+y2D
	4dPyx07m12llki85ccLuuKRIvmVwbarFNUGXVmyt0CcEUNPezkVuqudZfx3+1j3G
	G1rO+zQEay0LFMFPXg11Nud0CFhRvzMU7089CwF4iuO5gJYP4X+2gD6UHeN+zbMY
	fBfEXQ==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksgrvvkr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 08:54:57 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-45f16aa81a8so93765860b6e.1
        for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 00:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772441697; x=1773046497; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FDAsilwm29vpqMN7M32WikMZCz3A2rKxXxCHXUW3bm4=;
        b=VPClg2pNAWCOuWIp+VBTs3oi1Ehva6E82WbIoeWOwcVnPcBZ6GqyhRI2HMj1FPokTE
         GuoYiE78po0rKZw3eLznkukXXtIOqC6glFmyl++XaLWYTX3BCaBg/cV3qO+f8Q448a77
         LMXZrPQ6Pa/SZ4Tt/ttAfZRxRIlPOsp/5Blr0qXxgz5cBJGCr3G2ejfo735VK9kHnMOw
         X5R3Dzwf5vl5ofJdwQrh3vA6wmbIa8t04L2YzmHk7DCnxIoYLfRM5eS0YJUea2NwVUmw
         Zn7Vv/1pxR7ZaN0AA7td5M5ham3BOaLxwBHG14WPWxRtLfDRakHxffIlXBrp1S7hnnBO
         9CxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772441697; x=1773046497;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDAsilwm29vpqMN7M32WikMZCz3A2rKxXxCHXUW3bm4=;
        b=oS7vo6Wj6n2lrgQ3VNG4KTfmi6Bn6ZQVMvvfu3r6ztmucBgs9RPI/8mgxpgwMHnkEf
         Asz8EwDMwBF0ZVKjzmK153o7lbEhcrzXIsWv9i27/7jBlNOrIqXhygvib9a4Ec1ZnAA4
         /3XkIBMiagRKKrSgjfwns21Rj2h+Wv5KztCKcLqv22nza23WoAxYYInO07rXtsNpjpPM
         CqzqLfxYRS8vS5bapRUwQGFKDFXrrj7Pkb/WeFkK10zg7TAlphLL+Nlcfi4PZHFMmSoB
         SqIU+EQfxW+Ce3XtWaTFgr8R5k+4uTeSDN8Acypv5HCWli/Gf127VUTFBmdXxImTQ7YZ
         OJ/g==
X-Forwarded-Encrypted: i=1; AJvYcCXApCzLLg9jGfHLY5sgiSRq+U5azfk4L6LqgOT10RDi42sHl1yJD/G2lFYhpdu0+Z6CzIhjf4xEmQKenzK/Mg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzc4XwDagnepnk7Ko9IoakDI3MENuzZ8SyxiGcUsqlmJkbnCD5I
	e1e8SRqkIdGyAgz0NcvcTrJ2nnNws2xO3PrwIBChafAHtpfaKPhbMvDdnQ+W4CGp73/PSXeB/YW
	FdLf4bRf3lpo6SpwfXsQt1x94d0VaOjjlovbjXl5nWv39t3HgKjrDhOoG7CtQoG7jh6x68A==
X-Gm-Gg: ATEYQzwJVD13rpl5iUahXIozyRRphfWNi8nGtL1nIyEyESUvYzDLfePrcMFujgAu4rK
	fBZiv8nWjXeXRWi5jisJDopqRKt8rL88ldfPA28NH8Qj+FBhr8IuPD3mT+lg0hapJvz+Q6zUnNM
	ZZDKnOwH2moE7Xz7rSBzz5k+5tNhmNFVleePtuvLPD+aXHafZwOuXnkS4jnaiO45DiK5aWnFAZS
	oRF7aNV89x91mdnKqzvbnBtAEsOtQbFHbcmniPnj89m2pF8xtkT7WFqyx8jWkPvXJswoEouJ9dJ
	DNFisk0uSQoxsLJqABX/CTItFJcAf4hNVZYjtFXFft6tO7XHDnRg+uimz8ayLwrko+z5XgUTor3
	A2Ny2VNp7r1JpZryVFYu9vVNFNh1kXjQBIgzF8z6yDNMnCfD8kwQvA+CWjlzzcoDgfihGynFGHT
	F760V3
X-Received: by 2002:a05:6808:17a2:b0:43f:28bb:2f85 with SMTP id 5614622812f47-464bed089e3mr6071940b6e.8.1772441696821;
        Mon, 02 Mar 2026 00:54:56 -0800 (PST)
X-Received: by 2002:a05:6808:17a2:b0:43f:28bb:2f85 with SMTP id 5614622812f47-464bed089e3mr6071919b6e.8.1772441696393;
        Mon, 02 Mar 2026 00:54:56 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb3ab494sm6981075b6e.8.2026.03.02.00.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 00:54:55 -0800 (PST)
Date: Mon, 2 Mar 2026 00:54:53 -0800
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
Message-ID: <aaVQXbllLVBLZCwQ@hu-ysakshit-lv.qualcomm.com>
References: <20260227140655.360696-1-yuvraj.sakshith@oss.qualcomm.com>
 <20260227140655.360696-5-yuvraj.sakshith@oss.qualcomm.com>
 <c618e7a4-42c1-4438-9bc2-9c41450a81a2@kernel.org>
 <aaUE7M9QkfnYh12e@hu-ysakshit-lv.qualcomm.com>
 <SN6PR02MB4157D37B3D254251F0135B04D47EA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <b1390b24-eaef-40e0-a16b-77c27decb77e@kernel.org>
 <aaVDiwEPl5t2UPX4@hu-ysakshit-lv.qualcomm.com>
 <a0133403-8ce3-45a4-987f-96fb7421f920@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0133403-8ce3-45a4-987f-96fb7421f920@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA3NyBTYWx0ZWRfX82wY4hHkxrAg
 sCAn1GcRvlszxYsaR+AbLiSscoNoJa1tAb9LOqPF+ag/GDz5FfAFwgRk+XzYzh87FevRiGCREA+
 a03alRfcCIoktK9ABBGSgDZJmXyiIt8N2hffuk8yJdVAKC00eKZi1ozbb90h4UZp2aYGd7PAQt+
 CxJ+Yauuop+jRHGpp/zJenLbq4XV5/dCWtj/MbEcx/wKqx8wLNQUq2Hy3gFKIMf3vMeKOU7EUk0
 sd4GHF2D6fNqB+S6Bbs+ffMQDfvv+mQ75JDVlsVQVOSNyVZS/S9YW0a34nRHH5ubpGkjfK6MPuL
 mtdzR5c7s8AmouxCBDY+/bq64++E19HA614a0hW9ZjvnDtgd+kuIgmLs2NQIJGTkOoEyVXcPaPK
 vnayyoiPrle1BzyHY4OztbCN8WBwbcydr6gE+cuEjKIe+4dvul0jYoRJFznGeiR3YWiTVQCFUuO
 0wmCJn/WsauB1rTedPg==
X-Proofpoint-GUID: u_bM62H24XuLYUp3Lo98UFt41VSN3jT9
X-Proofpoint-ORIG-GUID: u_bM62H24XuLYUp3Lo98UFt41VSN3jT9
X-Authority-Analysis: v=2.4 cv=Zqzg6t7G c=1 sm=1 tr=0 ts=69a55061 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=GS-8L0ZNGZhbl8INtmIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020077

On Mon, Mar 02, 2026 at 09:09:13AM +0100, David Hildenbrand (Arm) wrote:
> On 3/2/26 09:00, Yuvraj Sakshith wrote:
> > On Mon, Mar 02, 2026 at 08:42:57AM +0100, David Hildenbrand (Arm) wrote:
> >> On 3/2/26 06:25, Michael Kelley wrote:
> >>> From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com> Sent: Sunday, March 1, 2026 7:33 PM
> >>>
> >>> I don't think what you propose is correct. The purpose of testing
> >>> page_reporting_order for -1 is to see if a page reporting order has
> >>> been specified on the kernel boot line. If it has been specified, then
> >>> the page reporting order specified in the call to page_reporting_register()
> >>> [either a specific value or the default] is ignored and the kernel boot
> >>> line value prevails. But if page_reporting_order is -1 here, then
> >>> no kernel boot line value was specified, and the value passed to
> >>> page_reporting_register() should prevail.
> >>>
> >>> With this in mind, substituting PAGE_REPORTING_DEFAULT_ORDER
> >>> for the -1 in the test doesn’t exactly make sense to me. The -1 in the
> >>> test doesn't have quite the same meaning as the -1 for
> >>> PAGE_REPORTING_DEFAULT_ORDER. You could even use -2 for
> >>> the initial value of page_reporting_order, and here in the test, in
> >>> order to make that distinction obvious. Or use a separate symbolic
> >>> name like PAGE_REPORTING_ORDER_NOT_SET.
> >>
> > Option 1:
> > 
> > if (page_reporting_order == PAGE_REPORTING_DEFAULT_ORDER) {
> >         if (page_reporting_order != PAGE_REPORTING_DEFAULT_ORDER
> >                 && prdev->order <= MAX_PAGE_ORDER) {
> >                 page_reporting_order = prdev->order;
> >         } else {
> >                 page_reporting_order = pageblock_order;
> >         }
> > }
> > 
> > Option 2:
> > 
> > if (page_reporting_order == PAGE_REPORTING_ORDER_NOT_SET) {
> >         if (page_reporting_order != PAGE_REPORTING_DEFAULT_ORDER
> >                 && prdev->order <= MAX_PAGE_ORDER) {
> >                 page_reporting_order = prdev->order;
> >         } else {
> >                 page_reporting_order = pageblock_order;
> >         }
> > }
> > 
> > 
> >> I don't really see a difference between "PAGE_REPORTING_DEFAULT_ORDER"
> >> and "PAGE_REPORTING_ORDER_NOT_SET" that would warrant a split and adding
> >> confusion for the page-reporting drivers.
> >>
> >> In both cases, we want "no special requirement, just use the default".
> >> Maybe we can use a better name to express that.
> > 
> > Agreed.
> > 
> > If we were to read this code without context, wouldn't it be confusing as to
> > why PAGE_REPORTING_DEFAULT_ORDER is being checked in the first place?
> 
> I proposed in one of the last mail that
> "PAGE_REPORTING_USE_DEFAULT_ORDER" could be clearer, stating that it's
> not really an order just yet. Maybe just using
> PAGE_REPORTING_ORDER_UNSET might be clearer.
> 
Ok
> > 
> > Option 1 checks if page_reporting_order is equal to PAGE_REPORTING_DEFAULT_ORDER
> > and then immediately checks if its not equal to it. Which is a bit confusing..
> 
> 
> Because it's wrong? :) We're not supposed to check page_reporting_order
> a second time. Assume we
> s/PAGE_REPORTING_ORDER/PAGE_REPORTING_ORDER_UNSET/ and actually check
> prdev->order:
Oops, typo :) I meant prdev->order.
> 
> if (page_reporting_order == PAGE_REPORTING_ORDER_UNSET) {
> 	if (prdev->order != PAGE_REPORTING_ORDER_UNSET &&
> 	    prdev->order <= MAX_PAGE_ORDER) {
> 		page_reporting_order = prdev->order;
> 	} else {
> 		page_reporting_order = pageblock_order;
> 	}
> }
> 
Great. Much more clearer on page_reporting.c 's end. 

Don't you think on the driver's end:

prdev->order = PAGE_REPORTING_USE_DEFAULT; looks clearer? As compared to:
prdev->order = PAGE_REPORTING_ORDER_UNSET; ?

I'm thinking, why would a driver worry about page_reporting_order being set/unset?

But yes, too many flags...  


Thanks,
Yuvraj

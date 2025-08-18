Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7772A1E25F9
	for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505678; cv=none; b=Bu7pDAs+R7zkBr6KbaCcniDxP6UPneOM2bKh2xr0ttUowaPw7O0bZexwb70Yyd9hNcxGOnI29BWzd6GECgvTJnA8DXBLmFZzta+9RxJyKkYS1pERtfI0WwK7kGhj7X1fy5q8MRQOgeF3eT0xmcqTALTo4nW3obpiuXqzc5Cb6Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505678; c=relaxed/simple;
	bh=rq6946DzumILvEIR5XWexmQkysEBR7GbvltHkcSl6YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGmkA4KhYuYSLlfep0k6EpSjQM9Y/b7XYUyNEgMqo1P6hQoRMAGC4xHioLkpKagV1LzYWTSSCjUcSIr4NM9tqCQzrz+ZCBW4I1h1h+mIFI+ftp1Zm8gFJm0gteQFE+YjCSu/Bql2nfhcKuRxsiSzKUWtBYoF8fgz4Zkq/Y6zVfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pH0jjYJT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pH0jjYJT"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I7m82F015589
	for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 08:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rq6946DzumILvEIR5XWexmQkysEBR7GbvltHkcSl6YA=; b=pH0jjYJTAl7re29P
	eDXYy6doYRSC9/QrUBVDRGmaKfPZCRnt/27BpOESnbmKcDWYQWQE0TN4RjZHB26p
	r31MIs4hA2/C4q4WvJs0F/TcGgCHu/dmVO2NTsFUfLgXGYc273YerMZN4+uFW9F7
	hypGSTOfjNaHRAfD5yZE9ln9D4CBCF4ZoWT6/s894AJcWj4w2Ceci1tqrMg7FZ7T
	8nC/lLMKExRJTWRCvcqmfiA5ilpDfF1xh3HEHJXusTG+HZ4HJHr6VZH5d8Jd3MdY
	0E5ihcuWt8hBw0jAUsx0ZEQNIeQ0WCoiOmTnd4PZxYXj0A6xg9y5MRgUrzX0TcRD
	r1n2kA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj2ubxhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 08:27:54 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24457f54bb2so94113205ad.0
        for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 01:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755505673; x=1756110473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rq6946DzumILvEIR5XWexmQkysEBR7GbvltHkcSl6YA=;
        b=gr8E4sttuUjPT5ftlAN1yDJFUp3DvLPXEH0ISe4CzvbgLeDNMo4v0PgpF9w1xjzMLK
         4vfWcuja5fVdz5ITynrpPnDYFXbL+vgZc8vBDjz+HCDngBDqJkrJxkgpiRz06pGVg/9P
         5NzfAMUyVV2BxlGywU83P7JTKt3hr6e6VeM+sPxwk/yMpmFwUlK9wJ9bhSNdESv8z51N
         iPuOQmE3B2YgWBzTTpooWVpYRQRgOVgzafcW2ngnzu1CRM1h5yJYWI0rkPipeX1dxlt+
         GiAEP6GtGtA8sO23sUaH5bIIM1468AsI6rWXj4AnrD4yivgTeva5PS8gHmrlF13BCdOE
         z7FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBcPG9isThIF7XXPGPudsigzEc9x5rnDVP26OA4tFSoLmmEdnFhnCJeGZbijzgL/L/+yFGqqPGRtnRMnlJEA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0/IZ3kubfXXVENCgUVagfse/W9YPB4x+EiHIn+Ciwn0RFXAx3
	zSUzMR1UwgTV269pTHpXnTgz/VW07hIyFEtX5m56MVUsaTB7gZPPwYVHUeBXZWuhQeDcUbkwDqI
	PwK4Te78SLXUWf+tuW+LTe1e3QJtzUpQb1TdnC5SuANPs+fxekQB+x6N+u8SChQKQa13yTp+nA9
	qF1bZfq+bFoj7rh5kED2rrzWfq0xM3WUxExZwMsSj82h9U
X-Gm-Gg: ASbGncsJHr/fQuBYriTiMo0/fkhP8ctUb+6qhucZCcmPfuwk4usXEAjOKCRNiDdlL0k
	Sbl/NONwXpl0KPzonyqS1G1o/qyImbZcfP8Ae/jdSbFV6uArQtdm9L2kGBQSIrdACIjCTH2S9vf
	LwjS3LLAavexmjF2h+enbfdA==
X-Received: by 2002:a17:902:e842:b0:235:ed01:18cd with SMTP id d9443c01a7336-2446d99e6acmr165826955ad.44.1755505673493;
        Mon, 18 Aug 2025 01:27:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxmEX0bC4rGj0GsL0Ofny3nTaPHYYQ7bo5uu9L4GZIVv1jBDAAlTveYAPi+e7gAhEyyevMd3DrrsmVZDn0oyA=
X-Received: by 2002:a17:902:e842:b0:235:ed01:18cd with SMTP id
 d9443c01a7336-2446d99e6acmr165826455ad.44.1755505673065; Mon, 18 Aug 2025
 01:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250818-numa_memblks-v1-1-9eb29ade560a@oss.qualcomm.com> <d7cdb65d-c241-478c-aa01-bc1a5f188e4f@redhat.com>
In-Reply-To: <d7cdb65d-c241-478c-aa01-bc1a5f188e4f@redhat.com>
From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 13:57:41 +0530
X-Gm-Features: Ac12FXzcSoeiNhok4BzoYQfoalKvL5KSge90N69qQ3e47Ph8xq7Ih6FtZXa_xiM
Message-ID: <CALzOmR0C8BFY+-u-_aprVeAhq4uPOQa+f2L5m+yZH+=XZ2cv_w@mail.gmail.com>
Subject: Re: [PATCH] mm/numa: Rename memory_add_physaddr_to_nid to memory_get_phys_to_nid
To: David Hildenbrand <david@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-acpi@vger.kernel.org, nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-cxl@vger.kernel.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux.dev, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=MJ9gmNZl c=1 sm=1 tr=0 ts=68a2e40a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=uSFNSxTeKwDZCnUuY58A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: nSi5h4v37XFWX9vXqhqn1lmKV6lKAZqz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMSBTYWx0ZWRfX2K3syL33CfYX
 WtmKUW4KNMhXv27USeOISmWPQjz9Pn90Czl22r0rFbWhYZ17juPw4eSMGlQyUm9G3SSceDm+o9l
 oS0rrPQ/4MBxxyKeb8ZY77jUzdcZZSLOFQUpzar5PmEqUMKjjcNMGqvAPAIJi+mCLpiUG1CDHxq
 gtlDzrBbWs/wQdhqgPLsLUkUkRizjc+SrlrF6Uqqx8n9/m7zHxxR28TG52QUeFjrRakqjCfHks+
 V9xwn7Wmh8I4yaURf5KNgPK7qEQ6y5lBW09uwpfsL52lwBBUSK4bbkmdJy2XmBgDcIZeuGL6qGz
 zoRvDopZhi43wqt48UGIl9RHBFldelp/Iu9IloX9482rhCsWc9aUsuJM6i13qEyfXymp/45Ez83
 OmvXhDdI
X-Proofpoint-GUID: nSi5h4v37XFWX9vXqhqn1lmKV6lKAZqz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160031

On Mon, Aug 18, 2025 at 12:29=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 18.08.25 08:41, pratyush.brahma@oss.qualcomm.com wrote:
> > From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> >
> > The function `memory_add_physaddr_to_nid` seems a misnomer.
> > It does not to "add" a physical address to a NID mapping,
> > but rather it gets the NID associated with a given physical address.
>
> You probably misunderstood what the function is used for: memory hotplug
> aka "memory_add".
Thanks for your feedback. I get the part about memory hotplug here but
using memory_add still seems a little odd as it doesn't truly reflect
what this api is doing.
However, I agree that my current suggestion
may not be the perfect choice for the name, so I'm open to suggestions.

Perhaps, something like "memory_add_get_nid_by_phys" may work here?
>
> This patch is making matters worse by stripping that detail, unfortunatel=
y.
>
>
> --
> Cheers
>
> David / dhildenb
>
Thanks and Regards
Pratyush

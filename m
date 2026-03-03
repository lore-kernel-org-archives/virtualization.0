Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9811F2E6CAB
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772527967; cv=none; b=mM1O+w4JA2R1gODPMBECusy3WNy1c0kEEjH2V0YGxVRp4gXTF3gXfvqO467UrYefnBnbbv1VVRGxDTlwN7BKtb2oyj9Xf8F5j5CNazs88WQLcGc7DaDC42N98LjtS/X+U33niA9Qq1H2vmmNQfdVe0hTqfzjaCMOtx+AN/U31qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772527967; c=relaxed/simple;
	bh=NHydjAt4Cze7NsxZrmEKQXTvB1FSPhoQ8O+U5sJeXiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULb5xZkkBCjKHdgm9vIpeg4HB9A1b5jVvYZUwwbnC3E/ccUZgYBkI1cCVjvtdFEr5OQCf16UN7SBjhQtTEt4UTBShwFsG9aU4rw8Np4obpsJTYs0OpypTx7uboq2Z3me48Z4CuQetxQp95KGM5GaWGOrdd4kyyDzsvp4apqkRdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m8LCE5/G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g/46QsTi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m8LCE5/G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g/46QsTi"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6237Fjp53614687
	for <virtualization@lists.linux.dev>; Tue, 3 Mar 2026 08:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YNCoDF0Cx477EaFoLRXf9AP4
	5l0gNVgmAcjZgp84zKw=; b=m8LCE5/GG26H7daYOSgbqY8Xg4ZNKzApJqvYus6K
	SdQMGPTDn5gNm/wBRQKC3x9wD9ZrYTDIDJFWA9iK1r5vHasFbIS9dYc9+LqN7Nx1
	kUHGHzp3AaFc+C3DQJuxvftRVKKz7+8UnR3sJlRyXv/510mKsSihs/k3RzbQG9ER
	Bo/rTLuUWmKs3i2rjIHmPmw8CbT6iiyqlVXMq3fXTkNd4KcA2YDYqIAN9PS8VQ7q
	NCJT7OQT7lIuMPOWHe9bkJ1raNCq8FSxRq91AWiA7t17uDOcmYqRVFgNg4i7mkQq
	Mb1OwaTxGfvhD0zBjEegsk/B02RZO05M1dwqQhOEIir8Bg==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnu3n8afp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 08:52:44 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4639e1fedcbso61244873b6e.3
        for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 00:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772527964; x=1773132764; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YNCoDF0Cx477EaFoLRXf9AP45l0gNVgmAcjZgp84zKw=;
        b=g/46QsTiP/Dkljnx55NoivtX7AK74SBG9iXDT6IJPDFmEy3LPV8SPYba1kUi6ZtwLU
         z5y2PWehynTvkh488+qrdv/geK55QMOVXLfWHCcNRYr7T/i7UOcXOKw4vBb+ylr+LOk0
         hhU5CAfdV8hL0qYFh0b21KpXKayO+yQrM0GyJ3yZY5E5ylwvxZNzcgbFFkAzipWaRFYw
         Kpt4C2x3oGwf1/nzLK02zZx32wxDfbtlZbvFVsqzmsqCMpbnwfKfR+PTOOq7mYI/PJ0F
         3eV+TN0TFzk/noW6owDm/922XUi05IF9yVAgBQt0MDoeGYC6Zgw0Z/6DJtbYPUa+IOl8
         sDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772527964; x=1773132764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNCoDF0Cx477EaFoLRXf9AP45l0gNVgmAcjZgp84zKw=;
        b=lCpJtQQSqEfIng0PTFKoRlupbDBWhnx85xJXL9/+s23/ZOphcsHhZFPC29ZwSlKTwZ
         5R/v0joR5S30wn1XsJgDRj4oieS4wUv83lyWwMp7kf2uMJ9T/YwCU/8bY5rH/Oj+17lR
         715DE3iK7thoyFSdn4w3WQjS2C8v6IhkZV4LK7rmZDTVb63iPBQi1EKGpdhKDlpzbbi7
         eYiHew+eNZ60XPo5siy0T8Bxs51Wvb3jpNIqlPRf8pmy1Ck/1WmVVmUG2ieA4bwJcmjq
         NqgO8HWUNQKkcxjD5D1/TfYzqPLXvsXtvX91dp+QVw4TlsWcfBdKAAGsQPT4ezTu78W9
         28vw==
X-Forwarded-Encrypted: i=1; AJvYcCVu1YHpuUHX2Ngv0g5BzsVNQpnoCx9xOVBw7E6oX4n4c/hfz6xGbVwoLQM6Hg7pvkLbXTm8gpK9avaxs1HVJw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxG4ShIJsIx1ZdyUwA1tlWybp5tK4cAus/7gsTpc9DzOf0xzd6w
	KMHgbZpzCLL6zeD2reli2394z5eIMw0vLNYXdKllJ+VZzCjhEZ2GyBExOinJuX1aQgm7B8jMeGs
	z5TR9o4US7sIgxUczIaumSE9HterQKaCTi3VMxXg3xo+/ze/NEH/qgQdJgqWNIKw0TtAbaptD8N
	qFHA==
X-Gm-Gg: ATEYQzwmJ4fs9qMMcsAxN4sUQF8ASUvKbA9S42O/t14Q1OvHeJZKyE4bnaC9XCkPeaH
	67wIiATqfBOsVNupJPDgA5jFUS8MEE6Zud8sPMSS8qpoOg36f+cvy00hL3VSdirFdV2XxHyQZKA
	JUPaXp53V1YU10q8DBea/nA32hANir29hLO2njgfpAF+O1xhwl2/LUloylrqKBB/BGAAKtgY0tv
	of4fMMJ67owNxR9d6UsQGEIJLtIFTjHEErbkTspZ0Z/nlrz2tAs/8XxghX61UA4DfXmt+YV2990
	5qCMxFxYL3j5Dq0rNIEcZy7RAqtkXxdqK5TGC6SKP3fXSaj6eCtfisS4aMq5g1EZepfwOa2Ofws
	J4oAbnah0NJaJ6ab2Xs/o8JUdB8UPsloM6HE64ZSkSFocnAnaBtHtwQtHF3XVIrj+VIGEXM5HUh
	lKkHyo
X-Received: by 2002:a05:6808:c412:b0:45e:e174:d07e with SMTP id 5614622812f47-464bec22949mr7968575b6e.3.1772527963985;
        Tue, 03 Mar 2026 00:52:43 -0800 (PST)
X-Received: by 2002:a05:6808:c412:b0:45e:e174:d07e with SMTP id 5614622812f47-464bec22949mr7968567b6e.3.1772527963596;
        Tue, 03 Mar 2026 00:52:43 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb59be78sm9432983b6e.13.2026.03.03.00.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 00:52:43 -0800 (PST)
Date: Tue, 3 Mar 2026 00:52:40 -0800
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, mst@redhat.com, jasowang@redhat.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, linux-mm@kvack.org,
        virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com,
        eperezma@redhat.com, lorenzo.stoakes@oracle.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, jackmanb@google.com,
        hannes@cmpxchg.org, ziy@nvidia.com
Subject: Re: [PATCH v2 1/4] mm/page_reporting: add
 PAGE_REPORTING_ORDER_UNSPECIFIED
Message-ID: <aaahWAWkXTS1lae+@hu-ysakshit-lv.qualcomm.com>
References: <20260302111757.2191056-1-yuvraj.sakshith@oss.qualcomm.com>
 <20260302111757.2191056-2-yuvraj.sakshith@oss.qualcomm.com>
 <2f14572e-e02b-4bc5-abd2-7814c24f7905@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f14572e-e02b-4bc5-abd2-7814c24f7905@kernel.org>
X-Authority-Analysis: v=2.4 cv=JaexbEKV c=1 sm=1 tr=0 ts=69a6a15c cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=oZke_92Gw2P4qifsOy8A:9 a=CjuIK1q_8ugA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-ORIG-GUID: xMUCSEr7U93NxfVzAohUDrTSdB-W9l3-
X-Proofpoint-GUID: xMUCSEr7U93NxfVzAohUDrTSdB-W9l3-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA2NSBTYWx0ZWRfX/jSZBToQh/rs
 Ol16dkaIx//TXoew4Ou26XsvZeZxgHSJMyac+AXkceLfMMWBun/pB/bftImB4ZyfwrL0cxxdYgv
 KWJpiPjaW6DGK2Cz/rIN8tSAZUGQ400a3+zr6coiSLKTsIP3HFVA9DzzxUYKBlL4qNIQrJRwBtb
 iZtrRSha1wUniihzgk9/LIs/25MDUHQYaWB6L0sR2mdnmpLSA6CFWQzbhdZE3VvWVIsb/vPdj6T
 OZNMgatYYGSQzVk4WwxTt3j9BiAqcuAJdqNkydiE+r6oC3PPR1ZxX6MFONEHG5AsErHMX1TQQwq
 OXLenIHS/tYVyXnzTs0BZlDTYvfadkWVYu5lM1WomMUwWvKPKvrltMZsTs7Q5Co1su5ExiXIeV+
 jR8+1482Qugxlmi9nRXFT/SfvnsweXky2XjB7fD8jF/uq4SYXqtzHoWpq0jc29sAsr466Uq+K8l
 qOGCjHEQeCFSL11Lm8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603030065

On Mon, Mar 02, 2026 at 03:57:50PM +0100, David Hildenbrand (Arm) wrote:
> >  /* Initialize to an unsupported value */
> > -unsigned int page_reporting_order = -1;
> > +unsigned int page_reporting_order = PAGE_REPORTING_ORDER_UNSPECIFIED;
> >  
> >  static int page_order_update_notify(const char *val, const struct kernel_param *kp)
> >  {
> > @@ -25,12 +25,7 @@ static int page_order_update_notify(const char *val, const struct kernel_param *
> >  
> >  static const struct kernel_param_ops page_reporting_param_ops = {
> >  	.set = &page_order_update_notify,
> > -	/*
> > -	 * For the get op, use param_get_int instead of param_get_uint.
> > -	 * This is to make sure that when unset the initialized value of
> > -	 * -1 is shown correctly
> > -	 */
> > -	.get = &param_get_int,
> > +	.get = &param_get_uint,
> >  };
> 
> I think the change to page_reporting_order (and param_get_int) should
> come after patch #4.
> 
> Otherwise, you temporarily change the semantics of
> page_reporting_param_ops() etc.
> 
> So you should perform the page_reporting_order changes either in patch
> #4 or in a new patch #5.
> 
> Apart from that LGTM.
> 
> -- 
> Cheers,
> 
> David

Sounds good. Ill add a #5.

Thanks,
Yuvraj

Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AD93C2E
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 03:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772422393; cv=none; b=RM+PA+2pEIrXAeAiKVaA80W7kBb7xJws+jsvVIrXJW9afs+3xY8DBFB3Smk6UlJ3hpnY/9j1WYVNvX/ha4hPbxMsmokxkmNzzOxS0MoFH2PFCBFfbFrgVpsJZVE6XrJD1SAmvS+EONfwyj4gtvYTPjtkxpxX/VcX36JvWuao67c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772422393; c=relaxed/simple;
	bh=ZD54bpaedeQlQDnPkWoaBA11dzBkKlX+EIkM9p3PkGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGiJek2968o0d/ckoyjnI2irP5ER+0ZaELEwLEQk+wQU+wLxWbVZl9oHSfM6tcWNfcyj8anr1wlWW7iGAywdKmIWNDBwjMbaX1Cz01elA9afDzx5+1UDA9rO8NE5HiA4Te9NJ91jWpsG9MGr73s79hT872B1qsdQLf8hImJka7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p1jvc/02; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YpHYvLcx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p1jvc/02";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YpHYvLcx"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 621NQhe72049380
	for <virtualization@lists.linux.dev>; Mon, 2 Mar 2026 03:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b2OsP/70Er+mWuJ/nMEuOkdDfzSNUXpTeUeLCE0ADeA=; b=p1jvc/02W+FH5Xdq
	6BXKsYmuduBiGT62XYdrCYV5pr3T7r0I4bnRwxuhoS8gyVGBBJU57j82RtPEaHg5
	KsQUlmEJIGtcq+aYtAlCoccZ+fJCeQmHLybFqGMLG4mdnF/xlWmLcfwI5+R5QCrf
	pERzMyIgZrwqkVrAGpLfLWBDtF9Vlb6zUAKYb+NoBdKNTDcJlHB4r841HLJbVr5i
	XyjAxSwzCCn2jwdUF0k08vXG/jdFUPpZdQ32uBYKA3qJBWrFi2rtHHYDJcwxApwB
	jBmjGTu/3u04iGQugyTTRJES4X0WeRyfLUvftB9IxYjAJx18hdyh1zzxL8GdN0Fr
	Vqp5HA==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ckshkurs2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 03:33:04 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-463a075e177so21548271b6e.2
        for <virtualization@lists.linux.dev>; Sun, 01 Mar 2026 19:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772422384; x=1773027184; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b2OsP/70Er+mWuJ/nMEuOkdDfzSNUXpTeUeLCE0ADeA=;
        b=YpHYvLcxME7Xn5sJRsko/vh0DY0P7ID2U4qrLIICZ1Dbsp7TSrqNqW4JoK/iurUrB3
         VdpCGgXGEbhFLfPf3U4ILpa5hNYWaE0E1nn+rCI/Nj82R/d+S1XtptmB2NsH9s5VMWRt
         8tOlKdmvb71Jk0OlYK5qbPK2ESs+g3DIKKaIog1U+milOC1AaNJs5Q4iUbT6V3F1TM5a
         F5ldaGza5UP3zy+ZYJdnNNgzt2Gt0N4flTsCXtgTwSMNr/pacRVa1tah0ZUHh8YX/roD
         3nBHl72eNyNSMMgT0cpATHcyHWn77H+k7VVphTw9x/UyPklnA0OlT/pGxT9kUZYBSmHs
         s4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772422384; x=1773027184;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b2OsP/70Er+mWuJ/nMEuOkdDfzSNUXpTeUeLCE0ADeA=;
        b=H1QM1h+m8oDqtN5RVzRngXfs+2KUhvpEV/PxaZ0qqaand/CGlnEeczJfNZ2vO5+PJd
         sSiH+ekrOm+S9mg1a/s7oyuxdidSUoHa6m3X78DdjK10b/ftBTjq9NZ7AjnqJsPqiytD
         4H5E2P79Re6Q9Uk3ot/omjybjFaOEMrwWnSiVArIuyQDIcBZlX2jYfs1E04p/kbedF6J
         BfSxLTX6OAmdppgdBxtCKUlSZmV/qPoCB0JjN0oAV3JsSHhHoI2xbOVe8d8TVmsauNdr
         GEDSVxgIj9/cQjC2oLNDb+0zvl0OpQPlaZGYzg4pSWLmS9+2yNDkYbvUsvFUHk2L216C
         bAjw==
X-Forwarded-Encrypted: i=1; AJvYcCX5NzqdUIIw0Fs0+v4CcISLPN/eLbnSrzjF8P8Halkpc1gJj6Quu8V52arFy6T0LQr5xOg4B74hSiVBv54XNg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwQ80Z4ELmC2eRzAtpyXRh3QPTU4XAAF9xWhKGivRSNhB3uq3f
	gVL+tLIz73FbER5JCyJuJC7YUcMnLL7hPrpV+L7Y1vLIH6tUXegXIpJ6zwglGWyis1rkJCLbhWg
	ZOwA+GjsvjLh/TvKPwFKVmsHdrsToO+uWT5X3rNmRrrTDkbFAOdvg4sTxXb15MxW0ilDabw==
X-Gm-Gg: ATEYQzxZxaAT4xONYsSP/QC+eipuGErfMNUgd9WOEqUhMxAd9A+B85/4ncXX/LAPGX9
	C8Z165t/ummMXIWwr8cB/Sarktvag3SmvKOGqbJT9E+dIeNZ9V48utzpE7TBSK8blH+kvWJWFIB
	gXo6abvmxNQrEJNCD8fcgvzDS3dXbQDdxOK+tNRd8AuAYsIE0kLGbroTWIepXkF/J+AMgeyOoqm
	BomFH23pqZXD0DdZBpjS9MdTm+f6IZakgFiDcMTuTuswcCkL5Y/OAXGibmU183I6Sy4xoGw/21L
	8YaYuHcSB1knKqpctkksMvBiAg7R/CaBXCzOdDG15gcUlo/O51GlBFJVcKBeGQjJVpshSyIf5U2
	2kGm7XZdZ0B7cA6lsNJFTNKAJpzN+hFDhuHFAdFYBIrkOQFyeKMAjU1Yb58VnfdMag7MaC5P6dH
	aUsUfK
X-Received: by 2002:a05:6808:5183:b0:45c:9927:3f33 with SMTP id 5614622812f47-464becb4a3amr4969467b6e.19.1772422384244;
        Sun, 01 Mar 2026 19:33:04 -0800 (PST)
X-Received: by 2002:a05:6808:5183:b0:45c:9927:3f33 with SMTP id 5614622812f47-464becb4a3amr4969443b6e.19.1772422383785;
        Sun, 01 Mar 2026 19:33:03 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf9b240sm10950856fac.8.2026.03.01.19.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 19:33:03 -0800 (PST)
Date: Sun, 1 Mar 2026 19:33:00 -0800
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, mst@redhat.com, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        eperezma@redhat.com, lorenzo.stoakes@oracle.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, jackmanb@google.com,
        hannes@cmpxchg.org, ziy@nvidia.com, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] page_reporting: change
 PAGE_REPORTING_DEFAULT_ORDER to -1
Message-ID: <aaUE7M9QkfnYh12e@hu-ysakshit-lv.qualcomm.com>
References: <20260227140655.360696-1-yuvraj.sakshith@oss.qualcomm.com>
 <20260227140655.360696-5-yuvraj.sakshith@oss.qualcomm.com>
 <c618e7a4-42c1-4438-9bc2-9c41450a81a2@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c618e7a4-42c1-4438-9bc2-9c41450a81a2@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDAyOSBTYWx0ZWRfXyEa2Zsw+YCiS
 3FY8SLNh2GlVxxAZwiDJMmuxoFEbfadmX4db4yExjYFfKX6/fMqcka1jjKxiyiyuISXxHbABg1+
 ZqmySVa9++unvAZnbJXi6CGqYvmhZHgpGJLp/hbSxv17Yxqegc5+x8SdTmqll1/NLA7fpFnDFRl
 pQQINF/Faf+m9zTHp1MrwDsS0/VOAjwsMteMxYJ6KbgTXyjf+oDgnqpG3BpMFAHepqhlXtxbF9Y
 LShboAWUTFi0yqvIoJHt2z4khL/6r9AzYGG9ed0FXLOCoEHincRGwSzVPcqJGEyYN8y3R0WBUdd
 J1Ia1V0QDH/8B6kN2eIAxOQW4zYco6kjUDkzHk7tlgG+fPc2VY7fhWx7UAm/AowttoBail6XRpj
 meV9wqEPPZveWHv2UzcbYgIGAt//672NGINsA3It9STqbW7JRPMjyCN7vE7D/Uh1pSQgDiCFfT1
 Y8IaUOlA5r06QgNDAJg==
X-Proofpoint-ORIG-GUID: lO7ZWMNow60QXX4dZsAzpBJGg22Dccit
X-Authority-Analysis: v=2.4 cv=EvbfbCcA c=1 sm=1 tr=0 ts=69a504f0 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=JqjX9IW5vOmFWWUa66MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-GUID: lO7ZWMNow60QXX4dZsAzpBJGg22Dccit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020029

On Fri, Feb 27, 2026 at 09:50:15PM +0100, David Hildenbrand (Arm) wrote:
> On 2/27/26 15:06, Yuvraj Sakshith wrote:
> > PAGE_REPORTING_DEFAULT_ORDER is now set to zero. This means,
> > pages of order zero cannot be reported to a client/driver -- as zero
> > is used to signal a fallback to MAX_PAGE_ORDER.
> > 
> > Change PAGE_REPORTING_DEFAULT_ORDER to (-1),
> > so that zero can be used as a valid order with which pages can
> > be reported.
> > 
> > Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
> > ---
> >  include/linux/page_reporting.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
> > index a7e3e30f2..3eb3e26d8 100644
> > --- a/include/linux/page_reporting.h
> > +++ b/include/linux/page_reporting.h
> > @@ -7,7 +7,7 @@
> >  
> >  /* This value should always be a power of 2, see page_reporting_cycle() */
> >  #define PAGE_REPORTING_CAPACITY		32
> > -#define PAGE_REPORTING_DEFAULT_ORDER	0
> > +#define PAGE_REPORTING_DEFAULT_ORDER	(-1)
> 
> No need for the ().
> 
> Wondering whether we now also want to do in this patch:
> 
> 
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index f0042d5743af..d432aadf9d07 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -11,8 +11,7 @@
>  #include "page_reporting.h"
>  #include "internal.h"
> 
> -/* Initialize to an unsupported value */
> -unsigned int page_reporting_order = -1;
> +unsigned int page_reporting_order = PAGE_REPORTING_DEFAULT_ORDER;
> 
>  static int page_order_update_notify(const char *val, const struct
> kernel_param *kp)
>  {
> @@ -369,7 +368,7 @@ int page_reporting_register(struct
> page_reporting_dev_info *prdev)
>          * pageblock_order.
>          */
> 
> -       if (page_reporting_order == -1) {
> +       if (page_reporting_order == PAGE_REPORTING_DEFAULT_ORDER) {
> 
> 

Sure. Now that I think of it, don’t you think the first nested if() will
always be false? and can be compressed down to just one if()?

-       if (page_reporting_order == PAGE_REPORTING_DEFAULT_ORDER) {
-               if (prdev->order != PAGE_REPORTING_DEFAULT_ORDER &&
-                       prdev->order <= MAX_PAGE_ORDER)
-                       page_reporting_order = prdev->order;
-               else
-                       page_reporting_order = pageblock_order;
-       }
+       page_reporting_order = pageblock_order;
+
+       if (prdev->order != PAGE_REPORTING_DEFAULT_ORDER &&
+               prdev->order <= MAX_PAGE_ORDER)
+               page_reporting_order = prdev->order;

Thanks,
Yuvraj

> 
> (and wondering whether we should have called it
> PAGE_REPORTING_USE_DEFAULT_ORDER to make it clearer that it is not an
> actual order. Leaving that up to you :) )
> 
> -- 
> Cheers,
> 
> David

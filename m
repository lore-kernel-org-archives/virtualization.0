Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D291F5855
	for <virtualization@lists.linux.dev>; Mon, 17 Mar 2025 22:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742251070; cv=none; b=UVfpSH+Ils480UhCiSCl18emwJSsCVXvzlpVfEG6M98VsXOINOWJ/QhLuLovYj9SIdnZUOLPyJZueOaOMVMD3mKGYqOmKvA1Aio/S+R4g9QdYeLZdqmPFK9Ns4LGlt02SI36UDLSoTGBpGfdryQ/0JrnoOdtsI9yolhUDr4vbe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742251070; c=relaxed/simple;
	bh=iNWq7YFABAaG0GotsD1wbeGMgiEc7memj+eT6dtNqjg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SuAAQ86UFKh4w1Rh90kBLvlPP7yzCHwrOYU22bRdNSx2POOPr0nFOIhk5GemEVtZO5e3eB7YnigEZPgx3XPYryvnPLyzqECGYx2UbUq5I1mG8pYecSbwIM19ZjPCZnP56RGSDy0ywbSEecsSEVSyeD0pyeylI206f9Y88mn9oXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ilPt7Ind; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ilPt7Ind"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742251067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uz73BbCUaqtdYR+gICGbN6AT48ejOu9pXaDANWFGjaE=;
	b=ilPt7IndygqbBshLqzD5ifIlAiiXL2llL20DqGIeAUseDUjYcNUT6jvl1lTGCrrloRQcDn
	NoIXScGv5+YWL2+nlgCZdChG8l1XdzkePwi+GSVbjHzoqlcER4ca1zutIGUyra+PQOIG/o
	YrNS2OeE3JuWuIQP7unqJGmiJu3aC+s=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-8QDuW97xMASxkEk2430tog-1; Mon, 17 Mar 2025 18:37:46 -0400
X-MC-Unique: 8QDuW97xMASxkEk2430tog-1
X-Mimecast-MFC-AGG-ID: 8QDuW97xMASxkEk2430tog_1742251066
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-85b402f69d4so492016339f.3
        for <virtualization@lists.linux.dev>; Mon, 17 Mar 2025 15:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742251066; x=1742855866;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uz73BbCUaqtdYR+gICGbN6AT48ejOu9pXaDANWFGjaE=;
        b=vytEu9kVC1CNy4Hbsfqou8wVOPcB+dIXPmbkCaShgKWrQEnzMKImSqwqTHRy0Py9pB
         1sAaBAVZjZJaz0uP+yChBGRwrXcmDjTEcfMtbsk9ADrrZFWuRLhi3VXyqlc+QVEU1Mrt
         0nBfcy/ufy+BQGgXg1DrZk38ed/D3B03R4gTF5iwn424cRKZL+cx1v256dDIivqnMlvC
         n8SI8MUwfVq+3Pw2OqGyjUqxMCULE6lgNF4rErUoL5QKclMRH1pIzhxOKFgHMjA48Vn4
         VhH0uqXAE1B++DzVG9ZdspRkUe0tWQWDSx9qHXUG2nAHkED8K7T1I1D/PKAc9HqSjnAy
         0oiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5XSQ4iVxWcImuJZtQKD99TRuEQzeUKSgYkONnLgGP3z3WzjHYQpO0dj0qqSIyeR0eZTI9DX2YQRqEf2KDFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwBRTjzqhYBEfkOinhWL7QEwZStpKTmc7MV3By0llXxa/YRWzrG
	8/7RZcpp1nL8xPCaTlB9kuMlrC9IvaIWt1ZWqpNDOUmGbnjBrm6jtrEpyrCrpeExeVYcEKelx+1
	kPcNtk530Ls0cRolMVNOOOMvItYwkgJy5eue9FC7GxnVq0zjccp1c7iepJbUdIdRX
X-Gm-Gg: ASbGnct27p/KBj4bPBjzXkZADm08PbOYQv6SV9r7Js0w1ZFXmf8x67LbcG1krDOpkZy
	RmkvMyTvZ7+tGKT7OcDk6aUKL9oLsBoYM8espF5bGL/l3w7GFnB49uKuKmmLJmTGhj6XwAyFR+/
	NWD8trexUg8uHu4soCZ7RJGf61skFNnXCVQP9GPL5Ee8CrjhCORnsyrtAgnAM3HG288UECFkS+O
	rb6cHAjAMn8R9YedugJPVmUqFuIWBZYv/wDaaOWTk6gb9k4QJnrw4xiaYeiR+Ql5btHGaBsUYAL
	dNqdls3HfEFF3Q8CnfE5
X-Received: by 2002:a05:6602:4084:b0:85b:59f3:2ed3 with SMTP id ca18e2360f4ac-85dc4832c03mr1654237739f.8.1742251065758;
        Mon, 17 Mar 2025 15:37:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXMhXDdQ9jMsi3nNSx90SCr5dH1/wJp5bRT/DRCJ6UEq4at0o5Rp4a0vN5yQf18mlko59M2g==
X-Received: by 2002:a05:6602:4084:b0:85b:59f3:2ed3 with SMTP id ca18e2360f4ac-85dc4832c03mr1654234539f.8.1742251065465;
        Mon, 17 Mar 2025 15:37:45 -0700 (PDT)
Received: from ?IPV6:2601:282:c100:48a0::aa6? ([2601:282:c100:48a0::aa6])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f263702075sm2481735173.6.2025.03.17.15.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 15:37:44 -0700 (PDT)
Message-ID: <a0315ccf-f244-460e-8643-fd7388724fe5@redhat.com>
Date: Mon, 17 Mar 2025 16:37:43 -0600
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nico Pache <npache@redhat.com>
Subject: Re: [PATCH v2 1/4] meminfo: add a per node counter for balloon
 drivers
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux.dev,
 alexander.atanasov@virtuozzo.com, muchun.song@linux.dev,
 roman.gushchin@linux.dev, mhocko@kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 jgross@suse.com, sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
 mst@redhat.com, david@redhat.com, yosry.ahmed@linux.dev, hannes@cmpxchg.org,
 nphamcs@gmail.com, chengming.zhou@linux.dev, kanchana.p.sridhar@intel.com,
 llong@redhat.com, shakeel.butt@linux.dev
References: <20250314213757.244258-1-npache@redhat.com>
 <20250314213757.244258-2-npache@redhat.com>
 <20250314180625.8c3a2a5a990a132a7b0b9072@linux-foundation.org>
In-Reply-To: <20250314180625.8c3a2a5a990a132a7b0b9072@linux-foundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nnOPm3fYTTEHM3t0XGSn_u93G1oYtxHupXP0X_p8vTQ_1742251066
X-Mimecast-Originator: redhat.com
Content-Language: en-US, en-ZM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/14/25 7:06 PM, Andrew Morton wrote:
> On Fri, 14 Mar 2025 15:37:54 -0600 Nico Pache <npache@redhat.com> wrote:
> 
>> Add NR_BALLOON_PAGES counter to track memory used by balloon drivers and
>> expose it through /proc/meminfo and other memory reporting interfaces.
>>
>> ...
>>
>> --- a/fs/proc/meminfo.c
>> +++ b/fs/proc/meminfo.c
>> @@ -162,6 +162,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>>  	show_val_kb(m, "Unaccepted:     ",
>>  		    global_zone_page_state(NR_UNACCEPTED));
>>  #endif
>> +	show_val_kb(m, "Balloon:        ",
>> +		    global_node_page_state(NR_BALLOON_PAGES));
> 
> Please update Documentation/filesystems/proc.rst for this.

@Andrew

Can you please squash the following?

From b1b379a32752e64c60b5e3b6365c93db8e1daf9f Mon Sep 17 00:00:00 2001
From: Nico Pache <npache@redhat.com>
Date: Mon, 17 Mar 2025 16:07:18 -0600
Subject: [PATCH] Documentation: document Balloon Meminfo entry

Add a Balloon entry to the Meminfo documention.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 Documentation/filesystems/proc.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 09f0aed5a08b..2868bb74f76e 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1060,6 +1060,7 @@ Example output. You may not have all of these fields.
     FilePmdMapped:         0 kB
     CmaTotal:              0 kB
     CmaFree:               0 kB
+    Balloon:               0 kB
     HugePages_Total:       0
     HugePages_Free:        0
     HugePages_Rsvd:        0
@@ -1228,6 +1229,8 @@ CmaTotal
               Memory reserved for the Contiguous Memory Allocator (CMA)
 CmaFree
               Free remaining memory in the CMA reserves
+Balloon
+              Memory returned to Host by VM Balloon Drivers
 HugePages_Total, HugePages_Free, HugePages_Rsvd, HugePages_Surp, Hugepagesize,
Hugetlb
               See Documentation/admin-guide/mm/hugetlbpage.rst.
 DirectMap4k, DirectMap2M, DirectMap1G
-- 
2.48.1
> 


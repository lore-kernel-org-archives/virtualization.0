Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF2E437460
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Jul 2026 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314434; cv=none; b=oTKwFRRxt0YB0wbULLk/8JoAle6UpRHhrm92s0hfmnhl8n5SqXEgoqiLKLHm6J/S7UuiZVV54bw/cD0J0v0j6Ua80OoiY+Bw0D8pgKnTGAIfKJWFLOmU3I0RdCYWOhtRfBrO8XDAPDM2CMjFrrQqV/WjnRrmP97wLW1vvry4rs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314434; c=relaxed/simple;
	bh=/lbc0ds/nEhSKq+pRS0v21OIZIp8lfmi/G5Th/cuNpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=MsMAIIEvg93YdVEH3oFcjwh00DNsjd6cwE+nSTzOk7KICJeTZibLsuixi4rGTrjTZnR8UxdBMc7+4n/eIykT+LuCa5aIC5faFSt28MkoGdpnBUSyY//ro1ZeYKZgWm4p8DGnuGp9EoipEFFnb/RO9lg88uScgbQW4GjYMzxots8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=saiJoAhy; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="saiJoAhy"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7318E60768
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Jul 2026 08:40:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LuBOeJ3rCOrf for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jul 2026 08:40:31 +0000 (UTC)
X-Greylist: delayed 323 seconds by postgrey-1.37 at util1.osuosl.org; Wed, 29 Jul 2026 08:40:29 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 140DB606F0
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 140DB606F0
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=saiJoAhy
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.254.224.24; helo=mailout1.samsung.com; envelope-from=alok.rathore@samsung.com; receiver=<UNKNOWN> 
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 140DB606F0
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Jul 2026 08:40:29 +0000 (UTC)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260729083503epoutp01e2e5b8498043a32f46321a90e5a539d1~GtbfPPWXm2398123981epoutp01J
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Jul 2026 08:35:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260729083503epoutp01e2e5b8498043a32f46321a90e5a539d1~GtbfPPWXm2398123981epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1785314103;
	bh=nMumBf6pcwJN35QNg21EPnkz/AZt8LVlK2YGNnvhzR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=saiJoAhy/r7KRwVHHR7YIjl+Nj7jXx0336/L9WpCTejiCSFqRiZqSbxMvaUbv8NU+
	 kkSUaNQ8zh8zuU9bBheB7sAGTwYiYPlFaARqwxR9n2aNYqgqXqjBwiJx3DUq/t9TEv
	 QBtUstpUNwLJo7RQ4CaoQbXAPVsNOYFEScxUaHCY=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260729083502epcas5p2956791f6317ffa4deaefdfb2eaa3c15c~Gtbeng5sa2833528335epcas5p2F;
	Wed, 29 Jul 2026 08:35:02 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4h95HV4cXxz6B9m7; Wed, 29 Jul
	2026 08:35:02 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260728145333epcas5p427c6b6d72bff02de3f29e6a6a2108958~Ge8rj7-9K0791907919epcas5p40;
	Tue, 28 Jul 2026 14:53:33 +0000 (GMT)
Received: from green245.samsungds.net (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260728145330epsmtip1f20094ebf53bcd1bb08fe2dba866c798~Ge8oxGFnu0743207432epsmtip1b;
	Tue, 28 Jul 2026 14:53:30 +0000 (GMT)
From: Alok Rathore <alok.rathore@samsung.com>
To: wangyang.guo@intel.com
Cc: akpm@linux-foundation.org, axboe@fb.com, dan.liang@intel.com,
	hch@lst.de, kbusch@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	ming.lei@redhat.com, rrendec@redhat.com, sagi@grimberg.me,
	tglx@linutronix.de, tianyou.li@intel.com, tim.c.chen@linux.intel.com,
	virtualization@lists.linux-foundation.org, asml.silence@gmail.com,
	cpgs@samsung.com, gost.dev@samsung.com, alokrathore20@gmail.com,
	nitheshshetty@gmail.com, Alok Rathore <alok.rathore@samsung.com>
Subject: Re: [PATCH v2] lib/group_cpus: make group CPU cluster aware
Date: Tue, 28 Jul 2026 20:23:03 +0530
Message-Id: <561480862.11785314102640.JavaMail.epsvc@epcpadp1new>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260113022958.3379650-1-wangyang.guo@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260728145333epcas5p427c6b6d72bff02de3f29e6a6a2108958
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260728145333epcas5p427c6b6d72bff02de3f29e6a6a2108958
References: <20260113022958.3379650-1-wangyang.guo@intel.com>
	<CGME20260728145333epcas5p427c6b6d72bff02de3f29e6a6a2108958@epcas5p4.samsung.com>

For higher number of jobs(>=64), we are seeing ~8% regression with this patch.

Tool: fio with io_uring engine [1]
+------------+------------+-------------------+  
| numjobs    | before     | after patch       |  
+------------+------------+-------------------+  
| 1          | 89         | 88.8 (-0.22%)     |  
| 2          | 169        | 168 (-0.59%)      |  
| 4          | 338        | 337 (-0.30%)      |  
| 8          | 533        | 533 (0.00%)       |  
| 16         | 538        | 541 (+0.56%)      |  
| 32         | 685        | 716 (+4.53%)      |  
| 64         | 933        | 859 (-7.93%)      |  
| 128        | 941        | 867 (-7.86%)      |  
+------------+------------+-------------------+  
* Metric: IOPS (K) (Block device, QD = 1, bs = 4K, Random Read)  

As shown in the table above, while performance is comparable at low job
counts, there is a drop starting from 64 jobs after this patch.

HW info:
Intel(R) Core(TM) Ultra 7 265K
CPU=20
IRQ-CPU are 1:1 mapped.

[1] fio -filename=/dev/nvme0n1 -direct=1 -size=4g -rw=randread \
-numjobs=$(numjobs) -bs=4096 -ioengine=io_uring -iodepth=1 \
-name=uring_test --registerfiles=1 --ramp_time=5 \
--group_reporting --thread


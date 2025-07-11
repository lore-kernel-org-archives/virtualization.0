Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75B11FBEB9
	for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250292; cv=none; b=hAdAhcQ8dOsYwSKkyLOaa8Z37KT9sIVC3zif5yHTgkbXMXfca/N4vBs8NjWeU6LI1lEOswyoSIM6nXa8EQm5n9wgZMpsGWZGwmft4XUA4NA8LLETfQVCu5XD2pbsATEju4uQtWqmOajp9M0sYPtI7LNXv9ln22p/QiKdLHdyjEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250292; c=relaxed/simple;
	bh=nkrxf08I7nRFTSLKc8Jm815R2OjRlj+FsR6McPBmq3I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Jm+txQ3W1zSESImWC6yuXgLO2eG3WQd2MYY1JlQTpPdS4v8flG94HKI3TCu2t+e4GhIcC4rEuwKLG4BJNnVMLyZycv5T/HUa/XOKNQwumOA8Cki04Pfq2dPVDlb8kjN3HSz+6oANERX18+phDqo3XeVa3X7yA9mNjawkF/+Tn74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V6i6FOZF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V6i6FOZF"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B7pdwj006954;
	Fri, 11 Jul 2025 16:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=T6IktpHr9DsoaaxAZsNCDnaMO+Fn
	bKM67VcAl+2LBDc=; b=V6i6FOZFtK45mUQ6Tr7FFfa5FhwCLQP5HYas0PLCrU2A
	RehT2ffHz0JU+B+8VpzGB1MNofEs/yQmjG/rJ1c5ZaWVWjHPxUswZ9HuxXvtV2Yv
	6aUxkN/Bsd59e/NpAwQ5QJequd88mhBPi5Pt57c8+kt3h/Cg92WOyEIiWdyn945S
	e9ifsZKhJiq4Fc9Hkr/U4rYD8WnaJJPFUJkR/Q+HAqbntnbkJ4cNjt66VPXpfDDv
	jej7Z3dAQg1Xr+wkAw2UX7eNthfRHe7fzJj/uypady56BfBjmqNdfdATFR79Yhnk
	78bYJ2FVWU/ELTIIr6G5+mqfbqjWPcqzIWqQs7nUtQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puqntpc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 16:11:23 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56BGBNiQ027708;
	Fri, 11 Jul 2025 16:11:23 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puqntpc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 16:11:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56BD8GXM024284;
	Fri, 11 Jul 2025 16:11:22 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qh32u6kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 16:11:22 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56BGBLGc22414048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 16:11:22 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5A5858045;
	Fri, 11 Jul 2025 16:11:21 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C31058050;
	Fri, 11 Jul 2025 16:11:21 +0000 (GMT)
Received: from [9.61.245.203] (unknown [9.61.245.203])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Jul 2025 16:11:21 +0000 (GMT)
Message-ID: <2be77146-dcbe-4370-b5e3-dfec9f4cf335@linux.ibm.com>
Date: Fri, 11 Jul 2025 11:11:21 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: virtio_net: Incorrect VLAN filter configuration on boot
To: yin31149@gmail.com, odaki@rsg.ci.i.u-tokyo.ac.jp
Cc: eperezma@redhat.com, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux.dev
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FZ43xI+6 c=1 sm=1 tr=0 ts=687137ab cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=dqG4mEvGk3G7bCWfLwAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: K0ELwPjappaJk4p36q88__HHcEJY5VO7
X-Proofpoint-ORIG-GUID: rx3981iNKR_-DXTJUCfdkDTyxKICH6WV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDExNCBTYWx0ZWRfX6otN2iqhknIZ kUWsQep4o7bZ6Hi4t0ehO/s/fCCnWi0kmR4ydj4tUE6REX4ajbIDmpTT8iLyG2nQ27eF45S3LcT nozCN5msFWm9IGV3QV1TKhl5LL4zI7kydN8M2WvHDs9+PgE4P33GR6vN1VbIRaWIz4OpXHvU1+i
 faeedONnBqRK26ocRTKVDKDqtR1/AzSQOd0g9D4jCuAR9vDtxT9drMDXIZtpy7zJ2YHs9PakugP JJ7sFyplZnKo9rl/zHKWkEFTZ4thC71D6ZzmM6NQEDC5M3M1L/jOLi9icxko74pX0Ux3WjbSBoF 74h+a/Ybcu7mugD5J96vQIkTNIunrbfmtcLe5odkeKKQN1pg9mQe52x59qUrU4cXMFllK2a1GDv
 jx83amspo/Etwo/I2h0x0gU9mTPsYjsPdVtZfMe3M7wjxDz28Ax2YLOxKHH4TEOmmdCzJQ9v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 clxscore=1011
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110114

Symptom:
On boot, if VIRTIO_NET_F_CTRL_VLAN is negotiated, QEMU adds all 4096 
VLANs to the VLAN filter table. But, according to the virtio spec, the 
table should be empty in this case. (Observed when using VDPA.)

Investigation:
------------
commit 06b636a1e2ad12ab130edcbb0ccf995118440706
Author: Hawkins Jiawei <yin31149@gmail.com>
Date:   Sun Jul 23 20:09:11 2023 +0800

     virtio-net: do not reset vlan filtering at set_features

     This function is called after virtio_load, so all vlan configuration is
     lost in migration case.

     Just allow all the vlan-tagged packets if vlan is not configured, and
     trust device reset to clear all filtered vlans.

@@ -1029,9 +1029,7 @@ static void virtio_net_set_features(VirtIODevice 
*vdev, uint64_t features)

-    if (virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
-        memset(n->vlans, 0, MAX_VLAN >> 3);
-    } else {
+    if (!virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
          memset(n->vlans, 0xff, MAX_VLAN >> 3);
      }
------------
After the above commit, virtio_net_set_features() can only set all bits 
in vlans[], but never clear them.
It expects virtio_net_reset() to clear the bits. I guess, this worked at 
the time because "set features" and "reset" were called in a favorable 
order. However, then this changed:
------------
commit 0caed25cd171c611781589b5402161d27d57229c
Author: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date:   Mon Apr 21 21:17:20 2025 +0900

     virtio: Call set_features during reset

     virtio-net expects set_features() will be called when the feature set
     used by the guest changes to update the number of virtqueues but it is
     not called during reset, which will clear all features, leaving the
     queues added for VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS. Not only these
     extra queues are visible to the guest, they will cause segmentation
     fault during migration.

     Call set_features() during reset to remove those queues for virtio-net
     as we call set_status(). It will also prevent similar bugs for
     virtio-net and other devices in the future.

@@ -2350,7 +2352,7 @@ void virtio_reset(void *opaque)
      vdev->broken = false;
-    vdev->guest_features = 0;
+    virtio_set_features_nocheck(vdev, 0);
      vdev->queue_sel = 0;
------------
Now virtio_reset() first clears all bits in vlans[], and then calls 
virtio_net_set_features(0) which sets all bits in vlans[]. And that 
causes all VLANs to be added to the filter table on boot.

I'm not sure how to fix this correctly. The QEMU boot is complex - the 
"clear vlans[], set vlans[]" sequence is repeated 5 times during the boot...

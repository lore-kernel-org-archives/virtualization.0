Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EA2C6FD1D
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 02:17:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EA9D040C1C;
	Tue, 28 Mar 2023 02:17:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EA9D040C1C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=VE+1Q8Oi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mAgaHEjhsGss; Tue, 28 Mar 2023 02:17:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 48047400EC;
	Tue, 28 Mar 2023 02:17:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 48047400EC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53C37C008E;
	Tue, 28 Mar 2023 02:17:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 795F5C007E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:17:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5217141850
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:17:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5217141850
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=VE+1Q8Oi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h31gXKjmgCHD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:17:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 37720416BE
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 37720416BE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:17:21 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32S24shY006761; Tue, 28 Mar 2023 02:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=CNk8GULyVFmfo5GhMIi7eDTnsxQAVJ7/EmvaL6k5m7k=;
 b=VE+1Q8OihojKWQzyUTYkrlweAdmLl0rOOevBZHuXu/i97nk6xCnGQpcbly4OMUeGkwO9
 6bkmUiVskPF2GUnn133RCdZy40Za/UZBRKAeWolwdVFPP09ZATH7DM37YyMvXFE4Vabo
 DNqxr67tCOuVpRg6LCfO5d6ROkPoBolZtVygWMsW6NpUwzLdd8yqH1NZKx4GOGqGhCBI
 PHRSX8tBSs6RxuJVvqrpEsBp+iaYRIRPnim/kJIj/Otp8qEek98m/QLcAlbY8YJOftJm
 9enzJxv5T9MyBVElI6HBKyp0P/RMEYWJVWcfSOxesNR4uM40bRnwIBUVTNB8ixFHZgj/ Ew== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pkq4k00e4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Mar 2023 02:17:20 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 32S1f4FD020368; Tue, 28 Mar 2023 02:17:19 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-123-40.vpn.oracle.com
 [10.154.123.40])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3phqd61bky-1; Tue, 28 Mar 2023 02:17:19 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v6 00/11] vhost: multiple worker support
Date: Mon, 27 Mar 2023 21:17:06 -0500
Message-Id: <20230328021717.42268-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=547 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280016
X-Proofpoint-ORIG-GUID: o5qg4I2UU86MdkQ_jMNP38JN-2zdUhaO
X-Proofpoint-GUID: o5qg4I2UU86MdkQ_jMNP38JN-2zdUhaO
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The following patches were built over linux-next which contains various
vhost patches in mst's tree and the vhost_task patchset in Christian
Brauner's tree:

git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git

kernel.user_worker branch:

https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=kernel.user_worker

The latter patchset handles the review comment for the patches in thread
to make sure that worker threads we create are accounted for in the parent
process's NPROC limit. The patches are scheduled to be sent to Linus for
6.4.

The patches in this patchset allow us to support multiple vhost workers
per device. The design is a modified version of Stefan's original idea
where userspace has the kernel create a worker and we pass back the pid.
In this version instead of passing the pid between user/kernel space we
use a worker_id which is just an integer managed by the vhost driver and
we allow userspace to create and free workers and then attach them to
virtqueues at setup time.

All review comments from the past reviews should be handled. If I didn't
reply to a review comment, I agreed with the comment and should have
handled it in this posting. Let me know if I missed one.

Results:
--------

fio jobs        1       2       4       8       12      16
----------------------------------------------------------
1 worker        160k   488k     -       -       -       -
worker per vq   160k   310k    620k    1300k   1836k   2326k

Notes:
0. This used a simple fio command:

fio --filename=/dev/sdb  --direct=1 --rw=randrw --bs=4k \
--ioengine=libaio --iodepth=128  --numjobs=$JOBS_ABOVE

and I used a VM with 16 vCPUs and 16 virtqueues.

1. The patches were tested with LIO's emulate_pr=0 which drops the
LIO PR lock use. This was a bottleneck at around 12 vqs/jobs.

2. Because we have a hard limit of 1024 cmds, if the num jobs * iodepth
was greater than 1024, I would decrease iodepth. So 12 jobs used 85 cmds,
and 16 used 64.

3. The perf issue above at 2 jobs is because when we only have 1 worker
we execute more cmds per vhost_work due to all vqs funneling to one worker.
This results in less context switches and better batching without having to
tweak any settings. I'm working on patches to add back batching during lio
completion and do polling on the submission side.

We will still want the threading patches, because if we batch at the fio
level plus use the vhost theading patches, we can see a big boost like
below. So hopefully doing it at the kernel will allow apps to just work
without having to be smart like fio.

fio using io_uring and batching with the iodepth_batch* settings:

fio jobs        1       2       4       8       12      16
-------------------------------------------------------------
1 worker        494k    520k    -       -       -       -
worker per vq   496k    878k    1542k   2436k   2304k   2590k


V6:
- Rebase against vhost_task patchset.
- Used xa instead of idr.
V5:
- Rebase against user_worker patchset.
- Rebase against flush patchset.
- Redo vhost-scsi tmf flush handling so it doesn't access vq->worker.
V4:
- fix vhost-sock VSOCK_VQ_RX use.
- name functions called directly by ioctl cmd's to match the ioctl cmd.
- break up VHOST_SET_VRING_WORKER into a new, free and attach cmd.
- document worker lifetime, and cgroup, namespace, mm, rlimit
inheritance, make it clear we currently only support sharing within the
device.
- add support to attach workers while IO is running.
- instead of passing a pid_t of the kernel thread, pass a int allocated
by the vhost layer with an idr.

V3:
- fully convert vhost code to use vq based APIs instead of leaving it
half per dev and half per vq.
- rebase against kernel worker API.
- Drop delayed worker creation. We always create the default worker at
VHOST_SET_OWNER time. Userspace can create and bind workers after that.

V2:
- change loop that we take a refcount to the worker in
- replaced pid == -1 with define.
- fixed tabbing/spacing coding style issue
- use hash instead of list to lookup workers.
- I dropped the patch that added an ioctl cmd to get a vq's worker's
pid. I saw we might do a generic netlink interface instead.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <SRS0=OSH5=O3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EF6C43219
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 21:45:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70B4C60FDC
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 21:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 70B4C60FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4437D40132;
	Thu,  7 Oct 2021 21:45:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T4Cn8vhBR3Ax; Thu,  7 Oct 2021 21:45:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CB19D402BB;
	Thu,  7 Oct 2021 21:45:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B24F8C0021;
	Thu,  7 Oct 2021 21:45:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A299C000F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C3D4607BD
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="OEBndBh6";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="UvRFnuzv"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NK1elzwTU52N
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4DD5F606C7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:32 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197KYYKb007651; 
 Thu, 7 Oct 2021 21:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=HTxGLrE/JntltL2+s5tbpy8b0l0O6fm4D69Hmybks0Q=;
 b=OEBndBh6aCwl5upLF1+UkUXKxrIFRB+gIn8SnX9xYreJqzD3T248JRkUc1BZ2hdNAHly
 s894o0gVthnt75yH0dQNnqdmdojSbE9Spji7wWXPiM/ghyNAlF52xDMtAAlKBouiakOt
 DrnnlkoneSviSQ9n1rKfYQWD1uekO/CZj6gKGi4cLrB683VUKZgKUk6FpYLdQ+8KRsYo
 1Qjx2JUXQTPIU5iQQ4S95w45x6S3otNZGSt4r+gV8oZLr8srquf9NuOTqeLqAOKc+j45
 2+eGTbW2iUNjiWxW69I0TKywELARk/hDvHBV7ssjz+FCRUuRIOs7kxX4B7eqUxTZaGSs eQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bj0pw475k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Oct 2021 21:45:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 197Le7IR113075;
 Thu, 7 Oct 2021 21:45:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by aserp3030.oracle.com with ESMTP id 3bev7x4uju-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Oct 2021 21:45:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mi3B9cDcT4l7ybUmXaGM23kMYCxf16G4rzukfBnrg7p4hU/mCaIYV91ZAYHhzGLu751zJK1W2uVThOJpOB7RWM55KgzGQsD2ERvHmnUvEn9oUl5+Zao8xlVcNPFhjOSlJvzcV6sN2t6cTpZa3bXwtYqQasZE6PHkxabYaQUbd7Kc15+SCZ92uw8BPX0eztz2f27fVltgf3434eYHipQuq6ST48P6CSy4Uf65SqZ5ApfSlvYvEmA7OKtek2LQaFV5F5W+UtBPoUyeL+2UX1GPb72jisLBbcahjroimHPUVgeItGU8e8ocj7ZorQOxSX4DBMfmpKr4OHzVmLGo7Bqn3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTxGLrE/JntltL2+s5tbpy8b0l0O6fm4D69Hmybks0Q=;
 b=H+Z2D2RB76uhHVKX27D29Z2R9XZvgq/RL2wg6oMu5PNJfSWIElTwMVIZs2f0/oVFc1JZOZsUfGo8jvfP1M3ii759SaYghT2xo/6c92D87iOXfqeyMsSyj3HFYjEgg3SFOvbtOgYzrQD+QpkvpSTJM+QBo/fWB063yaG5a5HcAvS1qCQuRmD5qV8c6qXHjAuHUq6MIXQ85KoQwYxQvuZZRKDbHpgyu8pe/oz3/vzRW9YWhIp4pUPGo8GLHEkUH2F6i3R1nscnAmC+yKxrR3k0Jf5+JO28KG9IQsPmUnPgH823Q6a3enb11ZBI9Yo4ENjnU2fm5drdImdT0O8CfXZWvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTxGLrE/JntltL2+s5tbpy8b0l0O6fm4D69Hmybks0Q=;
 b=UvRFnuzv9noawu5NepOgoW86dUNGdr780ZSm+DUTYqK1KAKZfrnNWar8x0ekmE+kzXGACJNkaj1vQBZq2t2cqT8+uXEBclb33WwZqhTNG/E1rhBvuNR7zLJ7g21OB3K3VtQdFW5k7Lpf6oy1M18XFzg1A5nd9JCFLCGBLIdbQS4=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1612.namprd10.prod.outlook.com (2603:10b6:4:5::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.19; Thu, 7 Oct 2021 21:45:00 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531%5]) with mapi id 15.20.4587.021; Thu, 7 Oct 2021
 21:45:00 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V4 6/8] io_uring: switch to kernel_worker
Date: Thu,  7 Oct 2021 16:44:46 -0500
Message-Id: <20211007214448.6282-7-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007214448.6282-1-michael.christie@oracle.com>
References: <20211007214448.6282-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM5PR20CA0008.namprd20.prod.outlook.com
 (2603:10b6:3:93::18) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR20CA0008.namprd20.prod.outlook.com (2603:10b6:3:93::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 21:44:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b404032-a458-44be-4557-08d989dbb63e
X-MS-TrafficTypeDiagnostic: DM5PR10MB1612:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR10MB16124269AADD07BBA6E98E0AF1B19@DM5PR10MB1612.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:61;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YNrTmGkEHa2gvKXHjj81wpZYc4YfFHBI4u2+fCV3pfyS4q8CxG5lgigLyQ3BPveJFR2QAdTSxKZ/0bRtrJRBShu/pXyH+7J6XS4ls6mlyiH0y6tTmS3Ae72BbjLKjUYNj15OpaicHbL4ZnAe14NXfNsIN+GpVrWNIRDQ9N2x54g6gYAMudg5a7ob+ptTkKq1m+ASMciqNyxTQhDDVhB7W6o82qs7/zalefGzsa8jGTvYzqzJ56i7umnSbibyZiXfWF7tjO4wDFfi+JRZ196f/ogpNyu/up87Bnj+ILXaymNs2x39CWh/iveMWRUdRsCNnzmIgSFozRaM+DRCJSa6ZpmzNpUwLMoQrE1fPhUyRlP3ND2W9HqYotQQ3zKu/pb+Zlpk5GWRgOajnlzq45MKvZiH+jJ5BwsoMJajDNmQPax49Icf+NNMS+7K/iOYUjpR/HSZlC8+kGpxAzLC0j8KrDxb180+LCckoc6R7IDJPbORw5od4n8oRQUZ4HTIg7NWmL0xSrWTeklm/aa5L5C+QjjLXxr93xAeNRJNjlie7AUV/uKxRWgXNp5hR+qZlUroJ2rUzQAlmIUIQvqRHs1Fyit92MXV+RnDlPW7NKobLUZ3LB95mf8DGDGn34WB2qRP6huszaQ0tKK7OzCAOPQZjSQdNLdp/MjHiClwzPE/pBg9HtOCBuMhGSnjooxy4LZkDANa1uDYk2wrCJK0VQpmrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(36756003)(2906002)(66556008)(1076003)(66476007)(86362001)(186003)(6506007)(83380400001)(508600001)(7416002)(52116002)(66946007)(6512007)(8936002)(921005)(107886003)(26005)(4326008)(8676002)(2616005)(956004)(6666004)(6486002)(5660300002)(38100700002)(38350700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tTufB9vnWXR6oV8N9+RweSpW4/6+Rxui8dinqYU0zpuM1kYKW4CETyXt9JpY?=
 =?us-ascii?Q?A3WPruTnH3+U/U1CInIZNcmqkHniIg7dzydjg7vIVSkvwq5IypaoCLwE8Gav?=
 =?us-ascii?Q?BUDbJIeJT/ng46U7fe53ueChrpafSVnoO4kLBI+x0bFXevg6WQPyF2QfomRI?=
 =?us-ascii?Q?sK3d1EibKdfLo9pwTqlTL57jc6p4duVDuM53Rl/jKavXJVcFGGs5VOM4aRgv?=
 =?us-ascii?Q?rHa31MRHWdmHnR//8TNmmX0abG2kDxxn2rEsVvBR0plg6W66IXlWaQw6mvGd?=
 =?us-ascii?Q?hZiEVV80h3AtbAftUdGmNTOiol34M0wylIlBH0AyDtyeQ3YhLMFaEIC092HL?=
 =?us-ascii?Q?1uQeB4vAQMvs++uzMN2pqIWU+/p/bbwg0FHkYSloOSz0OX2hkw+aEAfspED1?=
 =?us-ascii?Q?XBMEdxYPXTb3sMbe1pmt4+RQJnku0wTL7ENEH3dd+OO+z1kUgUr+454Kwt7Y?=
 =?us-ascii?Q?c1uEFvr6Hxk2GkVDIsclujCia4BpBTjEoj6EBDKEKeFjyBJ66ipeJYBwYuZn?=
 =?us-ascii?Q?ZiLv5qh3QJ01+Z7081FF9wLjzT1hN2AEMeVnHvUf+xZRm/bopxSBpSxcYRZ/?=
 =?us-ascii?Q?BaS2O0LkvCCJulwyps0JwvWuIdHxnFUUPNIx1y409y2KcNxm6kMK0ZHdpzF9?=
 =?us-ascii?Q?zKF3SGJ2vqoIFW4n8V/VcCvTf6LNZDFjuF8m9U8+6oJZdI+6bQXlSB50Nbme?=
 =?us-ascii?Q?fDb1K9P7RluuqON1LXhiJ2KypwIDBeVAGamXMAKACD1YWYNok6giRsfrLzoz?=
 =?us-ascii?Q?diK2oQq3+PblifhizddIXM9byJwaSv8xm3VyBBLuKjD5h21aj7IklQCf8zga?=
 =?us-ascii?Q?xxUuSs5WucGi9HsptQiNDMxm7nfMi5IqF3QE3hYoL8K2m9lOnTST0+cNMlLH?=
 =?us-ascii?Q?xiAVGLiIgsB6ZbrE+yAXaQzS8SE69+8Um5nuXaVF3nus2I2du3L7wwjvWYyW?=
 =?us-ascii?Q?zqXR3BwDBjUAXNBg2AirhRnL3Uug5YkUSpQQoHe5MjUmW8Ft4YLSWAYUqYob?=
 =?us-ascii?Q?+hczuoug+FZSmt9l68kNjZ26wIHI7DqiOi8d5rSvdRILHRZUejxNUl66zxv1?=
 =?us-ascii?Q?F6tIzGgKWYbpFbNZLGN6qW9z/6/utTJ9tFJa4/hX+grmcb9HWVSkllPr4LTt?=
 =?us-ascii?Q?p5TH8V0kgh7JIFbypEaiDz911NFhNqjoXvFeyjS/r7ZNBIQlHwzvmI07VPnx?=
 =?us-ascii?Q?YmA8fZakp2kM3Iwy3aRXpl3qOSEHc0CN3yz6kVGRsERIVm/B1OIZZ7lmB+kb?=
 =?us-ascii?Q?y0NmpIgblaRWvXjken0oGj6+etShLEL1+LqaZFKc416SF/S3JeiWD69K2kPF?=
 =?us-ascii?Q?2xiOx3LAyMglqVYrL2XHUOo7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b404032-a458-44be-4557-08d989dbb63e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 21:44:59.9762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0lAkFq0dj9tzZZM9YVjcA24xyIXB/0uSLJXpzildS9em4EYN5s6gUavDkE40nmhgzv9xHk6Tud1C/TKdPm/gs9U9DVbcwKuZGQr9mdq4R9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1612
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110070137
X-Proofpoint-ORIG-GUID: RMa7bo0EhCjCU04KXZcmyePOUBv03VVJ
X-Proofpoint-GUID: RMa7bo0EhCjCU04KXZcmyePOUBv03VVJ
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

Convert io_uring and io-wq to use kernel_worker.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
---

Note: To avoid patch application conflicts this patch was made over
linux-next which has Jens Axboe's block tree's for-next branch and Paul
Moore's selinux tree's next branch because:

commit: 5bd2182d58e9 ("audit,io_uring,io-wq: add some basic audit
support to io_uring")

from Paul's tree had conflicts.

 fs/io-wq.c                 | 15 ++++++++-------
 fs/io_uring.c              | 11 +++++------
 include/linux/sched/task.h |  1 -
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 962952951126..32b140754496 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -70,6 +70,9 @@ struct io_worker {
 
 #define IO_WQ_NR_HASH_BUCKETS	(1u << IO_WQ_HASH_ORDER)
 
+#define IO_WQ_CLONE_FLAGS	(CLONE_FS | CLONE_FILES | CLONE_SIGHAND | \
+				 CLONE_THREAD | CLONE_IO)
+
 struct io_wqe_acct {
 	unsigned nr_workers;
 	unsigned max_workers;
@@ -550,13 +553,9 @@ static int io_wqe_worker(void *data)
 	struct io_wqe *wqe = worker->wqe;
 	struct io_wq *wq = wqe->wq;
 	bool last_timeout = false;
-	char buf[TASK_COMM_LEN];
 
 	worker->flags |= (IO_WORKER_F_UP | IO_WORKER_F_RUNNING);
 
-	snprintf(buf, sizeof(buf), "iou-wrk-%d", wq->task->pid);
-	set_task_comm(current, buf);
-
 	audit_alloc_kernel(current);
 
 	while (!test_bit(IO_WQ_BIT_EXIT, &wq->state)) {
@@ -654,7 +653,7 @@ static void io_init_new_worker(struct io_wqe *wqe, struct io_worker *worker,
 	list_add_tail_rcu(&worker->all_list, &wqe->all_list);
 	worker->flags |= IO_WORKER_F_FREE;
 	raw_spin_unlock(&wqe->lock);
-	wake_up_new_task(tsk);
+	kernel_worker_start(tsk, "iou-wrk-%d", wqe->wq->task->pid);
 }
 
 static bool io_wq_work_match_all(struct io_wq_work *work, void *data)
@@ -684,7 +683,8 @@ static void create_worker_cont(struct callback_head *cb)
 	worker = container_of(cb, struct io_worker, create_work);
 	clear_bit_unlock(0, &worker->create_state);
 	wqe = worker->wqe;
-	tsk = create_io_thread(io_wqe_worker, worker, wqe->node);
+	tsk = kernel_worker(io_wqe_worker, worker, wqe->node,
+			    IO_WQ_CLONE_FLAGS, KERN_WORKER_IO);
 	if (!IS_ERR(tsk)) {
 		io_init_new_worker(wqe, worker, tsk);
 		io_worker_release(worker);
@@ -754,7 +754,8 @@ static bool create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 	if (index == IO_WQ_ACCT_BOUND)
 		worker->flags |= IO_WORKER_F_BOUND;
 
-	tsk = create_io_thread(io_wqe_worker, worker, wqe->node);
+	tsk = kernel_worker(io_wqe_worker, worker, wqe->node, IO_WQ_CLONE_FLAGS,
+			    KERN_WORKER_IO);
 	if (!IS_ERR(tsk)) {
 		io_init_new_worker(wqe, worker, tsk);
 	} else if (!io_should_retry_thread(PTR_ERR(tsk))) {
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 488aa14da287..5e21ae6d4ff4 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -7440,12 +7440,8 @@ static int io_sq_thread(void *data)
 	struct io_sq_data *sqd = data;
 	struct io_ring_ctx *ctx;
 	unsigned long timeout = 0;
-	char buf[TASK_COMM_LEN];
 	DEFINE_WAIT(wait);
 
-	snprintf(buf, sizeof(buf), "iou-sqp-%d", sqd->task_pid);
-	set_task_comm(current, buf);
-
 	if (sqd->sq_cpu != -1)
 		set_cpus_allowed_ptr(current, cpumask_of(sqd->sq_cpu));
 	else
@@ -8669,6 +8665,8 @@ static int io_sq_offload_create(struct io_ring_ctx *ctx,
 		fdput(f);
 	}
 	if (ctx->flags & IORING_SETUP_SQPOLL) {
+		unsigned long flags = CLONE_FS | CLONE_FILES | CLONE_SIGHAND |
+					CLONE_THREAD | CLONE_IO;
 		struct task_struct *tsk;
 		struct io_sq_data *sqd;
 		bool attached;
@@ -8710,7 +8708,8 @@ static int io_sq_offload_create(struct io_ring_ctx *ctx,
 
 		sqd->task_pid = current->pid;
 		sqd->task_tgid = current->tgid;
-		tsk = create_io_thread(io_sq_thread, sqd, NUMA_NO_NODE);
+		tsk = kernel_worker(io_sq_thread, sqd, NUMA_NO_NODE,
+				    flags, KERN_WORKER_IO);
 		if (IS_ERR(tsk)) {
 			ret = PTR_ERR(tsk);
 			goto err_sqpoll;
@@ -8718,7 +8717,7 @@ static int io_sq_offload_create(struct io_ring_ctx *ctx,
 
 		sqd->thread = tsk;
 		ret = io_uring_alloc_task_context(tsk, ctx);
-		wake_up_new_task(tsk);
+		kernel_worker_start(tsk, "iou-sqp-%d", sqd->task_pid);
 		if (ret)
 			goto err;
 	} else if (p->flags & IORING_SETUP_SQ_AFF) {
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 2bfc0629c868..c8ab90e28f11 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -88,7 +88,6 @@ extern void exit_files(struct task_struct *);
 extern void exit_itimers(struct signal_struct *);
 
 extern pid_t kernel_clone(struct kernel_clone_args *kargs);
-struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
 struct task_struct *kernel_worker(int (*fn)(void *), void *arg, int node,
 				  unsigned long clone_flags, u32 worker_flags);
 __printf(2, 3)
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

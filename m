Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013084.outbound.protection.outlook.com [52.103.14.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A098B35BDD5
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871414; cv=fail; b=AABtvJYYUXxOPj3WHvDNyU4Y9xCk1FJr0slnfH8Lmn+MWaqhYnmV7tztqkKOzSTtalQKXq7/rJ2ZFKyLQYaZ0+THud04uypUtZoUNRuMQOX6DJpbsq7VoCqzER8xkLHjDEg7ahPuRJbyHHEJMqYgLyKGsrov/U4LL3qzHxtjW2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871414; c=relaxed/simple;
	bh=72WeMV7sHbuWxFzvkP3f9wiZu78/bMMCACMqGHov+HU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ML7ieyL5KV4Ejo2XyAW5gGVObbUSA01lx5DBD82oss3RhWmk6oUkulWvQWTWJoH1VYbsTN7/MR4pnjCYlgl6CMiZ9vmyhXHS2TZceNSyqME8fDHqC6Ibt0KlcGlYlmBU4FcVX4G+n0wG9AtTa1EBZqk2BGHswRgtzmB5sD4sUA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dlzUxO2J; arc=fail smtp.client-ip=52.103.14.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dlzUxO2J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3B2tE2E2dxQ07ajAqiARJcoZ5L2vKY+iNZpULcEd2gfnf7iPnzG42BxiUj+28JFFO2gc1QNASN6vJ48ctmLxIaqMZnQdDN3e/NVd1MlY1rGAHDW1sRlQvuSg/vnhgp+2g1YUWo6SJRElNT4lHs3C5z3Nb/zNaVwyAaHP0NFIE7lGb4rV/6/LgZlQ1Fc6I1lzzMbzOgCtKw7XdNk6OVsV312mkWXjo70VWkJIKTIOVRY2i4adxb30zKnDu8crya1zOeQwbomnA9XRCTUEw6XbhG3ZzcbH5ykCMQqwRXJ0WPr4TB0IT3x3cQ7gGonSnm0eqa6Eg40oFg0vk84noFBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=d7tP5TniD/mSDwMnP5Qt+l8r59MulOC8HncBeeQ4JA0=;
 b=cOds7aLqthulIUa/Z0frypL7FtrAeKAWtZ0sk0gjEUT1BxkTI/kvpcGfGVpdeCVGHX5YJJXQHRxu4kBtLQrfGS8k+lqsQXzZkUyQhMPW3gFWRbqzKaKQ+3dzc7g2PKHD3hwu1SeViJTpOvlhD4v6LOYq2P89sBSrKT1xKPyJ27eXlEzfMjOZ2b4l2rQCpFeXjsLE0tKVwfVE6M55suSNVE/pFV5G/QhvW2iivJzzd9y2OI1B5B+sQkBRVdACoAzqJUgLIHQ2VuvbxNq1AvjteRHLIbk9fPE9NGLIZ7w43c0f7juJYGZXlpBty7DGC9RPjWqMljvU5/0oNEei4FpHQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7tP5TniD/mSDwMnP5Qt+l8r59MulOC8HncBeeQ4JA0=;
 b=dlzUxO2JTmbbkh22dTDYXw3YPpGAkdHkSoYaTn0d7nFDv1wxwD0rEaPWwD4Q8rt0X5iO1miPoRHXEZXxkTg7mX5gewe8LY6f+BSkKgdoV7jZstOPkuPH74kpjwrvVY6eWpPFe1UjUJLjiU25AXiSYY8C5UZ3MiM+IYLDnWKHZbhI3jnYHnlQMqcGv9Ruq69K/CCIR3e+bIaYeBo4HSxN7NFdioiuEmFrltNbgjWMNGmmfpmr7C0+wkY32Tso6q/vkpg4hBiDKwR45HI6NyWKU4cYHnS90Qn+EK3IkwwuRpYqbaduHjDJdgiQUt7P2TqC34TCMinOnxXriIWchV23Fg==
Received: from SN6PR05MB5806.namprd05.prod.outlook.com (2603:10b6:805:103::11)
 by SJ0PR05MB8711.namprd05.prod.outlook.com (2603:10b6:a03:388::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 19:23:29 +0000
Received: from SN6PR05MB5806.namprd05.prod.outlook.com
 ([fe80::72f4:b6a1:932e:6f0a]) by SN6PR05MB5806.namprd05.prod.outlook.com
 ([fe80::72f4:b6a1:932e:6f0a%4]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 19:23:29 +0000
From: Roi L <roeilev321_@outlook.com>
To: mst@redhat.com
Cc: Roi L <roeilev321_@outlook.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio: virtio_ring: prevent potential null dereference on per-desc state
Date: Tue,  4 Aug 2026 22:21:00 +0300
Message-ID:
 <SN6PR05MB5806027A02B2C001C8E600FDDDD42@SN6PR05MB5806.namprd05.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To SN6PR05MB5806.namprd05.prod.outlook.com (2603:10b6:805:103::11)
X-Microsoft-Original-Message-ID:
 <20260804192059.91627-2-roeilev321_@outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR05MB5806:EE_|SJ0PR05MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: df212748-0fc7-4f6a-4d86-08def25ddcf1
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwUXBahuwteIkQeW30lJPuxObYuPPhNsgaZ1jXOIS0VLkQxjd+ZIssjQvgepS0vgOacXD98kagY//UmHG5PhLQYxzXoR0ZF8N/Jjplak7y54tu6JEqCby41NgvaQ0n8//OufAhYdMlXTcb19l4cG5ftYy31mEmVObL0fTVAzOtwR2WgZNnBaJDpoMUDp5uXkG8tqrXXmVLavvbfycfFKpR0g4BY1f7d8C0pPTcC2rhCz9DasCTs2KJS9sd1XP+J+UWznk3SG8KuP4uidizoL8OLyhi35grz/g0aPCkm5iyEnNTNAz7ssrgPACLLLbM/jtiNhGnIQT6si2Nhlw0DUnC1cL0Xvo0wuWtolj5VPWle+ZEMzzkII2pLue/UGo7WElKVY4PTVp8AvtPKH2zeIg6pQ2XiDQf4iE8DWFfaVBiIvPSKUIqE0QUP1QBi3rOSQeJ22IgQ2ufQE8ps4Ow15NLF1c0vnJjFEK99/kkGRP2wdrtlGktfYMEqbN9WVDcj4p73FzllGr8VT2f+hB2yxjO7hZfasSqaEYoOLdV6tMISv7HsIcKbFKthjxSA6TWEdBLthOOrUq6sFxiXq1CeLMAKy0iTwuOfx3zEnP34viFKgRZrmlCJ867HToTA8lVi4wpwbR265/YnBjR//fEzGivIdHMEl5xFXbcC/y/c1tVzZOTB+2+RcIG9p3Z0P6R/3o5mXSgRCgNWJXlLWK3Ccc+TLaKSwsbIC+W0RfbVOVAV1enytOSNHDZDFRrwIl1CXFNA=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|4140399003|5072599009|15080799012|25010399006|19110799012|22141099003|24021099003|41001999006|23021999003|8060799015|5062599005|39105399006|3412199025|26104999009|440099028|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eZCnfhfz4NYvk/8dPWex833RN2KmO2AbHX6bwkTYA0fZFlv/08cI8Qhd2PCw?=
 =?us-ascii?Q?HZxEf4qOpwXFT6a4KGAucLcQl446p1zx87QeqLb4TqHc1Rg2auI3B8tUQksw?=
 =?us-ascii?Q?9zkLLYKkNW9kz4YXOMgbw4tfXY54s9xxfAJ6KYdayYT0XHWCB+M8bgWLMWUu?=
 =?us-ascii?Q?UOQPj+9BMcPTdu/otJbhLEXtESGVYEhsNkhyLiDxa2b6GKXwHlXO32FiAbfF?=
 =?us-ascii?Q?Y/wItBiPwINq0oR4yBkKb9OOmMyzKZcNR+/R9wbw2LXenJRr4g3TMrif0p6t?=
 =?us-ascii?Q?bAZBjhTcUA7B79btPxSoN5oifQ7VPiuvdCKxYa7RzlmjHS4OT5AFqFJ9lurW?=
 =?us-ascii?Q?vpIT35e7BvMErCFLzT4Nli7lptJOPnxZiDRNyol30huhuQpdFNTXbo1CBbVK?=
 =?us-ascii?Q?FxbOFXFrX8liRYDpfaqYPgKbOOGQ5QR/9jnaOWDRfhYHH/9jU/TVNqaoRSvI?=
 =?us-ascii?Q?Xlq9lrC2KKuujkuNLfBqS06NHzpJ3NbHRKMdJ7VNMO5t3vAxUthIPZeSwPjq?=
 =?us-ascii?Q?fDQeZ0Xo/Z3JIUYabl0k91O15O3YBCWdpNp+yIYVqeiS4G3z4cIZiiamEUKK?=
 =?us-ascii?Q?9/qJiTWr5FKdgi/7pFO+nSYSfZsRRvXPcsr65xs1Ejlm5k+zObEhf1hxpcaZ?=
 =?us-ascii?Q?0wB4fWjGiE3pU75YFfXmcztnAvEthPqpbJaOXn0tF6Cjim6Wzk3yLVP7Tpp5?=
 =?us-ascii?Q?iNOe2XAUcKrWUlrzvxE4rHToQpah9rbdBESX8+MJPVabRH4idvckfHDkk1sm?=
 =?us-ascii?Q?dtuO6JJ+++L6vDWZmXo50RuJF/ATWZQm2BLaA6DigDroi+IVcajrHJuh8W3q?=
 =?us-ascii?Q?0o43sJZeqRr86Sav1geFs8bpHoBAnm+yPqsX4Ns5dP007ZXW+vrro+Q6T/+K?=
 =?us-ascii?Q?1wRvfYPT0Vinv0KV5tlRxS+KJ1ZoIWy2kVCYZX6y/R5EMsrYkeqfUI0P4rqd?=
 =?us-ascii?Q?Rcl3CQ5IlE8P8CdswUj2YhMoa9IL2SJmW3TarpfL0R6ZdV12vJB51Q4VIFHv?=
 =?us-ascii?Q?8gxKfHm9EemhnWjwvdWXaRpO10N/uz5CTq3idOOMx6zaUQGEfChFig4MJZm1?=
 =?us-ascii?Q?fj5YhSY3?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a4gIw5h0whBEqCcArVRKRqhtN35Z4F/Y7Lp5gGxfaqJpHfrjoM/axIUNPrB6?=
 =?us-ascii?Q?WFjcuvF4mQabTR5J9XfeV5tzxir5G43xn+naXgQC/2kOBRaTsDDn9PoLccwR?=
 =?us-ascii?Q?qLh4eKOpZQCYfNMzgyB5J2zxDaJwNkniHH2lDPP43dtPEfNHhx/5471i8xld?=
 =?us-ascii?Q?ShYJH1l5IwR/SVZC40dS7Jqk31xLa7xknEhBQZBpVSliLzhlFcpJ835Kkbex?=
 =?us-ascii?Q?CrJBlsVJ0rT4T0Bvlg/ThlumO42EPU8kP365GXIJoKhpIPW0BEQdIkkikRvI?=
 =?us-ascii?Q?XyZ0bj/mQY/o2rhkhHCE8L8KmJ3M/jqxBIFWWNarrCKtPcsinRIKh1BCJQSk?=
 =?us-ascii?Q?lvSGnLXLpZptMsFn63ueoqwkvX4NTFSxOiW9qxMW4E5+vzd9woSxaDd4Fy2/?=
 =?us-ascii?Q?B+DoXbbiGRjLtAHgdlVvIQ0kTyt0AW+VAKB8qLKAWv7tpiv1QOcEQNmru0eL?=
 =?us-ascii?Q?7Itvh4SXFO8A1yzyyhxH7gt38EOzilnBGHvY1dztOL7nnedG5/E8s8WQdEM7?=
 =?us-ascii?Q?2sVWocmJnJxbsG8UyHf04bBMkkZJpJ/lF0RZoOVBYJjTGfwvVrSAnrHLUIv7?=
 =?us-ascii?Q?GjnlIqmCMLabeOtE3FpY5K5gyBp51QX8iLcArLoRcSkp1rlgn6nKRvIMshUW?=
 =?us-ascii?Q?e56Pg2WDy2GmzVD3Op0quPPm3X6O0EWfpTgbEd4zQrbOz9VmlGxmqNNcA4dY?=
 =?us-ascii?Q?uXiRx0ZpooEk4+sZ7Ajb4hEqYGZKg7uliCLP02uGDhArgibM2O+NOd3DUYRo?=
 =?us-ascii?Q?S8ujkzN/f5C159Zo+HaORCZO0MXjLjw1bEyUJuzHFCgkJOwlzSXcUtrMzbU2?=
 =?us-ascii?Q?RrZTsypcFuCjyurB/E2WUwZOz/htP4GOzNdh4+Fuy/GgWWATdIPPPYmMuA67?=
 =?us-ascii?Q?gVqMYbof7ozYiLlUJpDzgc3SKBvsFWkWju2ZXEoyMTvIdnp35b249FrgL6BY?=
 =?us-ascii?Q?hsMCX9Y6eFZggfmEITrwvit2uqfyc8WoKg7K2flyKJJSPn1T0XB/1UQs/Byb?=
 =?us-ascii?Q?9/TkWfFC40hTmySY/Qm3FH4TfqmTicSX6kHZ9RRVQxN762S185x6wzKlV6Pl?=
 =?us-ascii?Q?R7SsHMUureE26MK51M6vS33T1WOGtsOajObymk24CNp2Whvoh+0HM2qvyxiB?=
 =?us-ascii?Q?B5TMSyboArQBgdAMMMoDJaTIGPuJHaY5xB2gnN+3iNxW7N68eDjmWKn5rd+n?=
 =?us-ascii?Q?JSoKVEvw+HroBdRIxo9U6+AOzIDydwOQjijJ/rsDIAR4GSnccG0AoW2fkljW?=
 =?us-ascii?Q?lXVzu8VYc7ad++oSvZoGYcwJK0v7twViEKiDgz0NqvRn4nhBV8A61n9G6/lR?=
 =?us-ascii?Q?fKR5tAmDNi5QAScao/zAK1TjD0+72ddtyNhPPPNM71YWaC1BZSL+iFv2UiJz?=
 =?us-ascii?Q?bbvA9KOm23lQJAzh8A+9q8GkFW7XXy/7p5kjE2hmuMhFQZTJqrHEv2SeMxxB?=
 =?us-ascii?Q?BzgNmkqJ/M3v9ZnnLHVNvYB4VpNqSB5e?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df212748-0fc7-4f6a-4d86-08def25ddcf1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR05MB5806.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 19:23:29.1268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB8711

When accessing the per-descriptor state structure, we could overflow
desc_state[] because id can be accessed by the host and the guest
at the same time, as described by the packed implementation.

'commit 32fe1de5c124 ("virtio_ring: Add READ_ONCE annotations for device-writable fields")'

The commit mentions these are legitimate races, so I assume id might
get corrupted? "id" is actually just ""last_used"" in some contexts,
and at the path where last_used gets manipulated, KCSAN reports these races.

I'm not sure if this is the right approach though, maybe we should handle it
differently other than just return?

Signed-off-by: Roi L <roeilev321_@outlook.com>
---
 drivers/virtio/virtio_ring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index b438dc2ce1b8..1d99b75f3bd7 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2025,6 +2025,8 @@ static void detach_buf_packed_in_order(struct vring_virtqueue *vq,
 	unsigned int i, curr;
 
 	state = &vq->packed.desc_state[id];
+	if (unlikely(!state))
+		return;
 
 	/* Clear data ptr. */
 	state->data = NULL;
-- 
2.55.0


Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2FC19A
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Jun 2025 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675684; cv=fail; b=i+w16OMMXyizIFsF8O+toYdqhZ1y4PH+l0Q6jeN1hWhzcSKXd+VTTl7i7wU3SKarjD87FGlDSqlLO+P0lXub00jfB5iruzRb+9nZWe0jbOmEdYwsW++JXQ+sJYbwrQ385pt6WRt8DgL990dzfkhmDY7w2Z7Rup4mZ5zvfyKmswk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675684; c=relaxed/simple;
	bh=SC1vtjs52XYFpjVpOsINYjeKoGyOufQcIJAONZupn5E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ULQobuMXj00XWJRRocmjE8kmfabvwvdpm43S+P5N6EbW/MKTiVbVVQZ4LKJPOolErH4ZFR9fnb5tyI1gkrAuADmvaSt41ZPzztywGPrf9YJ4bmRECLxjdwoyQDpr1I1nO+AM5YcIGDOEJ7mhmckhKOQGGEjVqysAcrIfQSNi4E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pbEsYLDm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MTai+jkR; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pbEsYLDm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MTai+jkR"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32A8340E32
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Jun 2025 21:01:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.489
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q2iI7sJtyoFA for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jun 2025 21:01:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1CD7240E2C
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1CD7240E2C
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=pbEsYLDm;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=MTai+jkR
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1CD7240E2C
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Jun 2025 21:01:19 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BKW41h007787;
	Wed, 11 Jun 2025 21:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=vVt5kzlfLrFJuSTD
	atpScNfSV4d5YykZ5o1r+sHOP70=; b=pbEsYLDm0k70YTVgPbngUxhoAMAjk8DM
	8y4dyCFlWYTLT7xRkh/qJybzEvPVhm7ZGlhottAnChwNg9/LeD73/mKk6OuitNll
	gu3BLns6GLyGVH38GL0mpOsDPk5vhG8KjSlJnuSFT1nnIKR0nk/uS0RkZ48jLv5n
	K7vzRBaUityu33iYOPHwBzjFsjOoMN1MJiK3Jp9g/huJ0f87ldd/HQRRNuZqz9Mm
	pbBt1AgGvd/RqvHxT1NfLu3DxbxhkrIVn/hG6q+abkinTLhENYyxEXl+bZYiNCK8
	5vN1agcPAJ+lgEg4mkuCzWDKQ3H3rtJ8a6wdAUYpMZye1gIR7/EFNg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c750hp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 21:01:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55BKGtS1031360;
	Wed, 11 Jun 2025 21:01:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bvaqqt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 21:01:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iO2om5YiilOdjmMkbRUK1iAbfENOtEQa0b9lD1UcECaBoci/0+6DSwSUig4iOcNCDbi6zz8rPW90krqIZF0zpSRWwqEAN2b5qTgLZrh7edCMi2eO6oNDO0jXn9PcpEx+jF0ZLiqW1GZ3Y9vt4ZWOwRbwrsJp4mKVhT9JT6W/qUV9Nj4MTdzXeTJEwhIsyHGe8PAOCQs/srxHvWyc0hqH086nc2G0/Bb3wrO74B+g0fYP9ij4mZ+By2CqopvKcpMUf02nPrQRb8Ak3qwn0DYmBesdhPxhsv33hHAVZdcZ5p6hLSqLelmQR1IXTTwMqrvPnHOPKiqg6UfHkT3IEvQzhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVt5kzlfLrFJuSTDatpScNfSV4d5YykZ5o1r+sHOP70=;
 b=MGiRAAzFk4TXpUzIrs8QMYf90W/1hpZjj3MHvF2zOyesxRn5iV4/JAEIn9Vz1/y6/1Z/dsr+RQveq6mVGZ+cyS9z/vrcJHrotEC2Nm1Gx1NuCexZZZLScSQet+8pR71JAp6Hg52gSVVOPBqM9K8dIbcTZaIK6eEydC48iYGy2VFuFlCtxio1D8dPHkFjierIc9ZvNl7vWyBdbfgjnVuOEwZkvIh6NsaCZX7Ng48wLXTCwJMH3AEQ8LW6kz9Qf36uqNHIGszEpDscU9W9x8R/demNdQHK0FxGmldEDBlkG0aypnIDog/SRGQx1OSY0b7nj37v6LOlw2OdDhtrSCcp8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVt5kzlfLrFJuSTDatpScNfSV4d5YykZ5o1r+sHOP70=;
 b=MTai+jkR+kinPHMC+sNqokCKHVWcFHS/IjZCnh1BllXSfyuP7hixEectfeAICt6ceXUvt2v+ZhJi6dkYgyFvsbeizFo74OsSh0sDrvyhwNhB4YDl2uU15yYy6OOifG4rLnN/KN6Q5ZUNSFBmWfWPiq3GOy43qz7xXf8GcbEXR9o=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SJ2PR10MB7708.namprd10.prod.outlook.com (2603:10b6:a03:574::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 21:01:15 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 21:01:15 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 1/1] vhost-scsi: Fix log flooding with target does not exist errors
Date: Wed, 11 Jun 2025 16:01:13 -0500
Message-ID: <20250611210113.10912-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR06CA0027.namprd06.prod.outlook.com (2603:10b6:8:54::6)
 To CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SJ2PR10MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f91117a-b578-4a11-ad4a-08dda92b1a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ljbXtyeb4XgaOx8+T0WNVthARwgRq/hnYWQL1rhz3d6C5dxlI1jCkf6IpoUS?=
 =?us-ascii?Q?8Tj8r+xyHIAKky0w9AxOVij+8rm2nM4IbYfXIU4PlCGz1lw/TAEHMvr3ZMNX?=
 =?us-ascii?Q?hn/OsFxS8PsWwOzTMA0l93zmGSQkccc+wRiiNb049l5Gr2RTAHto6dnksZvX?=
 =?us-ascii?Q?L5eNS+JpJMS51uFhyEMrTk+9vRdaUmwlO+foNfwk0Ylt2VgHL0G89zFHrfu4?=
 =?us-ascii?Q?zCmyi80KCfNfxWi+d4tFrknHIwqBiEvFV0bPvusUs4NSbNJiEbEkprDSSK7a?=
 =?us-ascii?Q?LL9sczot6zGUPEyHsiwnxdlZq3mILWutiWEBYXKYAALNK+yPZEzeyZikRpgo?=
 =?us-ascii?Q?R/Y3gpVPMTXTBH5jeI021wBtepXA6TIOx7R/tjXjpQ4k8EVeyh4J0fox515t?=
 =?us-ascii?Q?YRSQw0jiccI0MBD06pxLzBkLCw2/ziDxOx6hrv1f4BOz2pyPz34D3InB9nBX?=
 =?us-ascii?Q?mN1aVdVmi9vuNvFIoJI3Z0PwygtHRyRAlhoL+KbWNhqStkbr3JKQmV5DUD08?=
 =?us-ascii?Q?9bmLze4lY+Hz7YDaIn5j0p2o9VLoq6L4lSZAWYLHheO4P0zIT6Dn44rFC+37?=
 =?us-ascii?Q?G2exkT97cnqFDLesvxNNfTaRHCiipJMQbVrAVVTLSxtAYszwoS869Zp3b3Ld?=
 =?us-ascii?Q?DwJ2s5LHdXOVX1Ng1CaZSMdYVvHvMopz1CLhU/ejQvliZuGY4S2oGOvY+p9/?=
 =?us-ascii?Q?8ow8FD2UmUidJg6RPGF9XAJOi1dfbGdbwth3H3I4s5+PNgVSxp9SXFHYbSyi?=
 =?us-ascii?Q?b2VXWEFoG//akqyHaBhYRI123MWF27bBbLrVJyMg0z/7dcFHHVj2QwX/i4HN?=
 =?us-ascii?Q?XyKURc0CEh8Ve+KxojGId3xEHaBcKsAuCRdTMoCvqEn1c8F8HwgRuJxYTXlm?=
 =?us-ascii?Q?9ncdLyQUX63C82fFI4cCbWCvg4jAaI3ISdlCBRX+l+8MehxyRWGDH4GYT/dV?=
 =?us-ascii?Q?1GC6t5x8OWkP4McgK+9+CMuTQkPpUT1Xm9DJfFklQOgc35QQsUwDmrEtoO8b?=
 =?us-ascii?Q?0p11JdlqZp18SEyuG7GuXHuMW+5qLp4mPpMtZtuid4QCKB5tLK3hj6zHuU9U?=
 =?us-ascii?Q?+KiwcxIh5HlQHAviH3K18uUcj65njzkMIdlVllYtG4W5JQoFtjTRFLfoVDFH?=
 =?us-ascii?Q?A9ppY92ipMpuDsuYwztNKQkWAIWyIG3GIywrzGTSwo7YPz1ux8RLKum4oBN3?=
 =?us-ascii?Q?U/MEQO5/Lcyk25V4EV2H4n6iOXC/5E/TKU0ilOaGjso42lGRqPnE/Mu8EOnm?=
 =?us-ascii?Q?wRbmTSubZLOoWagXI2PdODj3qhIj+HCTDzrgt9qxpvkiXoI3nUjY99Iy+MSC?=
 =?us-ascii?Q?50GnHJ1eduAL6EpO8wW/OQ28+kxzuiOZAvXZSu5n3/kXCWOBVlQ2mMeTC888?=
 =?us-ascii?Q?tItwsCBRsmfaPRvNJwXzde0SikbqiTeOj4ny7wNYDZumwr/gfW7VUDM2rKZS?=
 =?us-ascii?Q?0Qz2LGelPmc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ahAgQArs0bUX5351VF2sTPdKyAIHzAmKn4f7xodUqLX2pNprG/MNoLZ/c1Um?=
 =?us-ascii?Q?jlILtSRmn8D+lVTboolwzTCNLy2cbPqUJ6vsQTVwQqJbQoTyR7VtYPtMf2PI?=
 =?us-ascii?Q?/rpaGsK3UupSLufIPNZPlLJtgWngYna1dFaM27dANATCNJ8Y3cCGE+pkUfQq?=
 =?us-ascii?Q?LmJPBxtzquId/0NLZewOCo17f3xznEFGHm1ABtIsLyUZzopvI72WvgmeRq5p?=
 =?us-ascii?Q?bi760w6xEg7Z82K8fRY1LbTCHPlB5zOLFZL8btV1Sq8AZ52dbwLR/dBSOcyg?=
 =?us-ascii?Q?wgOuj4QE8xkQaMer+jupwN8JuXpbTU+Ghww/7GkYlMSbHPR9Re1AEg2VMXHn?=
 =?us-ascii?Q?L3LlfNCoOSbQg2WmlEZqxtWd42M9H5Bu/AkUpy8N7VdZP5IDTKHne7xllJKS?=
 =?us-ascii?Q?Q9XRtdKo020rJnLhshcapdNTdGEsVpwNSPCG32Jjhye+vOLmSkof/aZHOwxi?=
 =?us-ascii?Q?PJjhNJDg3VZX58biw0ciVpglE3nHh1HLyLQx12gSCwn9hidOL8HJRREZH58c?=
 =?us-ascii?Q?gcEu0knX1PYAXTKwkIkC4kL+1kn/JpEvMxj5PcjINViGU2wdkqlnlvC1jHDw?=
 =?us-ascii?Q?ifqvhcQu6pczBzSB50HWWfp3U1GEBlXFwiUv3jwWMRcr+zl9A4tCXAncTpQC?=
 =?us-ascii?Q?T5Uci4T004sf4p56U+YHFPE0NOcNpW6VK41vI3UK9NIhDcrsOsRsuM5y3DtH?=
 =?us-ascii?Q?S8SptzuNp+S338ArI1Vle1lYSW7SFy74gmJyoGnr7/StHasThJpMZwb97xDf?=
 =?us-ascii?Q?zWeKJGReF/nyf6R7BWDGPOGHTMYNccBxYp+dutPAVzAk2/VznceEHXlK2CVn?=
 =?us-ascii?Q?/hHQt0kOxCG7IxKZ16uwzxqT3h5K2tv18cxGO2DeIvOuzpoYC1s+k3peX3iR?=
 =?us-ascii?Q?YAA/Njyoz8IFBXRDxXMf3gXz5KmV5zzIP3PEpXZL19KkTBT4phi5jPyX8r1g?=
 =?us-ascii?Q?TyQ2uNaF6m3+OPxLgr2eWzMh//Mt2oovTnDzVRHGeQKmW6Y53w9N6jAZeTLf?=
 =?us-ascii?Q?V7Ld1GeNc/1xhD4aMUwMRTqLqavgo1BCDp/Xhcy0G8IwlBXg0Yj3QD9k/VU8?=
 =?us-ascii?Q?RbmtBgVvv46XONVuIOVt8BOUKl4KYkM661YnAR+SnzdrwJ/QlcSOS5YIEL29?=
 =?us-ascii?Q?JL6KHlrjONlhepHj1nlCZ1c5I/10Zhcan3ZFsMgRGg7NoCEJCpGhQ/XIKhuu?=
 =?us-ascii?Q?i32he3MrSJDgyy/QQgYG+hWFcOMDbrLABiRDQGQgzh5RNV+Fk+YSqoi8gooY?=
 =?us-ascii?Q?sKy7howCtPzT5b8HKqlyIYdO1FSSW0oIO8JvxCYfHNJtdN5fc5SipMlddMoc?=
 =?us-ascii?Q?dfSuF1RJET2jcTVJ3G/KiUqZdUZzVIgoH92AbfLeKoyHR6F7jG5YpC/EAUqD?=
 =?us-ascii?Q?DM+I7UbAa1qW0UxJ9NIjZUWYM59hc6YHc/J/5badiXp/0PaDku3uf1bjpGqh?=
 =?us-ascii?Q?xQYlygqLyCOn4hLIfSnONAetQ+0AO7vW7YQ7pnv2EimWVhxc8Y49uyy1yUci?=
 =?us-ascii?Q?DU0ASJ8HCaywnkE7PISGtqBqJ0gV76HErY1LwJmSZ+e3FDGKKneHSBpxRU0k?=
 =?us-ascii?Q?RnBn8ulHUrgBE/9a5vvY+JAId6HmMi+9NHKRaAyZhDi/hTmt0ckj8LAlJqGa?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BsCHWe6xz4D48vkjdy37gHrMqZ3Hr9BQ6MtP1np7+SZzYO/mZJcq4ovQh36fOnR/OJLJ9I63MazietqtmXXd637/dXxoWLPEJdjTI0o2Z7VksKBPfgGrjcjhbjdSMQe9zYiJqxuZgml6TpZhweYtpaT/PNYtxzO0A20VW27L15rgwqtfhRCn5N4LAgKAt5SkeSw6x63zg01swuboJPJL8AGMJ3knWmC+Cs7udUuYTU/meeRsqXQTrCqL8uK18IJMK3qCm7RzjP5eTDglaQxtN/rjJSnWKuQBr6D++yWlxrqvUr+/QvAudamGotwX8W8w1Zi/GNpH29SiWndnF5gMib/h74BJi3v05ArV/J/z0JlBn+5KTTeF07FXnCTreMP1uSm6AyvjxZ6Js375KZIWx4DUTjCeSSKq3nVfrDsm5TIxinZIY5TT+hQcC6iPmMWmdiq9IyVRySZkdDiCdthQkSMQtbggarpD/t3CxG93eybDQ12gKFxbiQ12XShFsGScPVto42mrsk+iFP4Y4aGpPtKiEI3cDPpcE1M6OMPfzhKq9OZxFT9Wd00DmKzey1U9wY3zn7RYzUEUbzPNCREi16Mf39hw04aojCg0yzGQfv0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f91117a-b578-4a11-ad4a-08dda92b1a7b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 21:01:15.2904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8sNvCYSmedVvUQX31lwQPc9MTLM5c0L0egGtFA2LMH8+THpn0Q8/kKL5Nl0J4+RWyINX3XYPwOvV01AtbRxag2CDk/AALPDVI+WTrfor6iE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506110177
X-Authority-Analysis: v=2.4 cv=LIpmQIW9 c=1 sm=1 tr=0 ts=6849ee9e cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=Bg5pyWz_XA-PGitI8PcA:9
X-Proofpoint-ORIG-GUID: ChwPRI45yOU028DFGDFBxf9ezKPMppBw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDE3NyBTYWx0ZWRfXwiTuyxEXzx6T 2d4YE84Rl25/Uue5AJJ0+38W9iNVHGxeYE+k20SN7zK1fHf54TI4kV/tPd4mav7pDy5SPR/xuPI VqKW5yCs5O8WaVd2awjy9hKQ8FEfZzOnlMPAmfgCXsH4HSy1E/UrHaGunatRjr3frPGYzwpEU75
 cC81W3IbAEZhYH7d0tXa1oJXjoq1+Q1EdXcuWAfZkofNqpKz2dMteohgGAVQHYxN70wfIUrZpGL z2eCXxLpaLJeBeKRDhXczcnRdE51HaDOS9H0YWqgOMbupQWV56E63mQurv5/ZL3cQXBkw+e6/61 kohZa1rqlvDkuotSot1zdh/WrK1CuLhvs8jaa2HM5QxrAMvQvPIkMjO8cxdTUNOQB+kEaFOajug
 rI3+L6h6w9MlpxJBEeXRvOamwsxFO0HWf6p5o/CHuFNiubDuppOnaXGJO6mZS/WzZN852g5o
X-Proofpoint-GUID: ChwPRI45yOU028DFGDFBxf9ezKPMppBw

As part of the normal initiator side scanning the guest's scsi layer
will loop over all possible targets and send an inquiry. Since the
max number of targets for virtio-scsi is 256, this can result in 255
error messages about targets not existing if you only have a single
target. When there's more than 1 vhost-scsi device each with a single
target, then you get N * 255 log messages.

It looks like the log message was added by accident in:

commit 3f8ca2e115e5 ("vhost/scsi: Extract common handling code from
control queue handler")

when we added common helpers. Then in:

commit 09d7583294aa ("vhost/scsi: Use common handling code in request
queue handler")

we converted the scsi command processing path to use the new
helpers so we started to see the extra log messages during scanning.

The patches were just making some code common but added the vq_err
call and I'm guessing the patch author forgot to enable the vq_err
call (vq_err is implemented by pr_debug which defaults to off). So
this patch removes the call since it's expected to hit this path
during device discovery.

Fixes: 09d7583294aa ("vhost/scsi: Use common handling code in request queue handler")
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/scsi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index c12a0d4e6386..c9f418a4571a 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1226,10 +1226,8 @@ vhost_scsi_get_req(struct vhost_virtqueue *vq, struct vhost_scsi_ctx *vc,
 			/* validated at handler entry */
 			vs_tpg = vhost_vq_get_backend(vq);
 			tpg = READ_ONCE(vs_tpg[*vc->target]);
-			if (unlikely(!tpg)) {
-				vq_err(vq, "Target 0x%x does not exist\n", *vc->target);
+			if (unlikely(!tpg))
 				goto out;
-			}
 		}
 
 		if (tpgp)
-- 
2.43.0


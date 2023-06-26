Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF32C0015E
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 23:23:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D97181919;
	Mon, 26 Jun 2023 23:23:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1D97181919
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=SDMbp50e;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=S7C8oEti
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fy3IWylEiEXS; Mon, 26 Jun 2023 23:23:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B8A5781971;
	Mon, 26 Jun 2023 23:23:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B8A5781971
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00D40C00A3;
	Mon, 26 Jun 2023 23:23:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6691C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 78AF16059D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 78AF16059D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=SDMbp50e; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=S7C8oEti
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RhnxvxnwPNVr
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A6CF16059A
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A6CF16059A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:24 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35QMi6Kf023181; Mon, 26 Jun 2023 23:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=AoBYWsHARX948oereUpU887Y0cEPljoIb3k/tNNg0e8=;
 b=SDMbp50eo0ukrSFR/Vxe/gwa8cS7U1kYcJ15ogF94nBexkkmCeXwaviBNAZVnuk6JAW/
 uwtoOjYfFO+e0uM/NhyGtYAMPvML8dgD6dEFOMojTHtCsXnZY41ZDFtD5gW5Y9Kj2PuG
 aK/XDVuOyOEe93oh9tBScvR1qV9JJwlvB35XhtIIyVojLzr/R86SIOWIDG7uYU3nxkIP
 Af+PcKzuKcSQxSgIagflnMyhWNuZC0wCiD0vB1bU4Q8ox8WDCJ3jHD0vwoStJE3YrExb
 oA3vyxroRI55etueG+/U5jkK7bTFwHn9TdUczGcwE/RLbRYcvx/xxcRB6lxGPbXGMLL2 lw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq933uf0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:23 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35QMJNka028275; Mon, 26 Jun 2023 23:23:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx3rgcu-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkW9RuAO/Z2/ZhCOzneRQtsMdG/1FVE9GC8IQbsuNDq23kY6N9LqWer1T2WZnUee0zvD4xRfiY60+MvJetA9471Gfz117KJoaB2PAP9fhZorIiEzU80TxTwjP2UOv4NVIxCnLo5l4n/NwnahKs1QlQgRKcSgxKoP2+AcZpfh3UuqpwnCFnkPEHPak/f7CFi74YHzfa6ROhwm1Q8QUiTB3rCWs6S6d/izXZTvAWVluHbOSh8t7g7YIfBxYmb4yB1p0NGaxDiRJaLFVYhhuXMvGAb8KOdEbNb86DzXEPasBDPAkzYkV5SCcLduLwOSzZvdMldq/+jebmurfHuJeH2wlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoBYWsHARX948oereUpU887Y0cEPljoIb3k/tNNg0e8=;
 b=KNY8E7xmLJaOFFOS5GLCw/OQOipXJqgjpZ1gyl7xC55R3IL5Ivwsj30Q3lfG/5vgHIt3JdM063nHqbRKSftMjTCgeytuwyg/d/l+ETRZZeyq4OkoEQtOjL3ZH+TISJU3yLEMa83DYL+gDrlFf1AQEQS+gdJENdkG6GAdMUvRVtkChiDy2EeIEEtH/LMFdBhAaY2Dis0TlGWC1s1uEhuieXBJtVE7vsUfA3B7gskYcLtUDQK2PX8tixNt9/7YsB2m9uLAT2TCMYosJZ9cqjTSHQF80gfRfUm7HXXQUECibbkzq1UvyjreIqMsMPMaVWc0C767Z4+Q+4ezey1GRuTXMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoBYWsHARX948oereUpU887Y0cEPljoIb3k/tNNg0e8=;
 b=S7C8oEtizLJpAJZI9GLBhCS8iyXIiY8AQyNJxX8mgkdQX4wIe/ZaeUfmT4wIumXj0wDqkqj+1u2Bn0DSpE2C2r87LD8t0U9CpmtB8if1yeofbdOG2+6kPsty/1ya/xPOl0DOf+hmjjSYxPIhgP94lLTtvyP5UAvr9OKq7ZAwPM8=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CY8PR10MB7377.namprd10.prod.outlook.com (2603:10b6:930:94::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 23:23:18 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 23:23:18 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v9 05/17] vhost: take worker or vq instead of dev for queueing
Date: Mon, 26 Jun 2023 18:22:55 -0500
Message-Id: <20230626232307.97930-6-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626232307.97930-1-michael.christie@oracle.com>
References: <20230626232307.97930-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::14) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CY8PR10MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ad9a27-95b5-4d40-48a2-08db769c52ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F+2pfejWzK3EGu1vW2sVLJowmza0tGm2k+1dJy2v7KVZO28dWp10vG3NutoNYKibi/ZYsuwDe+rQouaa7CeYE2fSd5h+dC4iyU4e1EMdN39tOJ5d8G1laPpVJ6Ku5dGkYuiNWfHqPNVzaVBcN1Y7IVIoKF9OJ5RoCkMz8A71R7KJFiU2arPGvSSqpV0gMrTU7423dMgR27RbBz7AkAk4pErwpgQa0bPIB4FjevLFeFlt6JYg1Mi5eLW3N+mV4LK5q+b0aEkOFb8JZYtzdKsELnkLjZJIk1UPo9vspwS5DO3f2ZdlbTBJq+OwgXDmMOcJ4V++hVGxmSSdLf1jxvp/wQVUychYaEuc2Jid9Vo47BEjQUwenruWEs6VWsHEBz0pvRGQ9LEFHMmHJMtK4J5pkRlNLEbiTxsBFerVFt6JV8T8gTOmE1uMw4U5Oz6IDYo9ui3rZLBgfK9y0ZwZjEVIXTK5IRp+OyKjWznmLwQnNxr8ngs+oeRCgYN+0bk8G9UUqGu3ZTYT0FtS0biq8O3XALd4+9nqr6LgVbzYghCfwsjUylthBQTslRThwGbjUURvroEYagaq3YPVgdI/8NgIxC9TlIZ70G1OUrBTSkFYfIc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(2906002)(86362001)(41300700001)(6486002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(2616005)(107886003)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M9etqco3bBrzs6hBbc4pQ6D3yPD6WsLLv3G6aoCW8yr86lzS7tbkgiOHBrX7?=
 =?us-ascii?Q?e08twrgb1LkPyDERFmKRdisPcGy9oeSwq39LmseYXon9P2Y+OJmQcw7Kdbwn?=
 =?us-ascii?Q?XfpITck+BSoUyhwXgecZzuUMDy6fjDSXjG/Z/Vn3+pGeKl05sq/2G1roSbd6?=
 =?us-ascii?Q?nkPDPtCZLfX4Onb0c9QaDZoIHQdPnYhMwueQaGE9ZADsYkfcugCLdSZprAbn?=
 =?us-ascii?Q?EbLbAuJS1TLwt2ivPFFCcEY38jmVdxcymzZQ0d/XWwgWZd7tLD5f0CsCzpNs?=
 =?us-ascii?Q?FjeV8dHjFy38LH4Q24PXEbBUoq5m972b6v7rHmOlQX+XqKjoO3IGC+M2Zkzw?=
 =?us-ascii?Q?QCQOmJjNeVzbZ9Ydkq4TrLslromXiLEkfvwjfCtqTmE2oyo7vWiTmifSbNm6?=
 =?us-ascii?Q?ryx10yfKFCPmgcGMAMKfwIwp9owtV1DL8PnCCbkVPFgR/papJ3fNgvVscOoH?=
 =?us-ascii?Q?I0weUl1i5EJCGGFX6r1pyhLHRNzbFx3p+5jU1r3pueFn0qP51wkJmguIhwkO?=
 =?us-ascii?Q?nuFWHjdKjdzmcYO4/PLDvWT/+FubbIWvHVjnfHFGmw2kqMAEM0RKodAaFsCu?=
 =?us-ascii?Q?poja+r77aQG8ZwxP7BxSQl7NaBgowoY0Zn2pd6iAdKP+i6Ugkj+cgwV4Rzqm?=
 =?us-ascii?Q?Wc3HfZ4T+U7rKsTlc8FipcEOMBLVTm9OJjUPpBmG/s0Bg6OtMcczxiAbVsBr?=
 =?us-ascii?Q?CxPRkxw0ie7v6mWX1mdduoAmePLAaRhf+Cb12xrYOWaXyvszkJWvwDMnDv3a?=
 =?us-ascii?Q?eMaOULumfJAIm25GbpLOFzaeKRAaUdZsjHiwEvze1odvAceVgSx0PB0Ccd+q?=
 =?us-ascii?Q?/iFGkWpe6W9gnVUuu/pDo6dF+V3GGHTKw9JyCA+tNicf2NMQYSBsfzPFjuGs?=
 =?us-ascii?Q?/C3Be1BUGdzlu7nnfccqnqKJO8RHOAuA/ReiUQbMErsHTpY4Ot39u816RkH4?=
 =?us-ascii?Q?FR0oWaF7u45DcVMsBlsZjDoCpTyHBF4UMuDuf/m45uFsaKbf3h62hHFaNBVB?=
 =?us-ascii?Q?aZII2ojCrfy7U1AX/iGUT3NtMuOzx/GjBFnA74nVw+AaRTxrGswNy9Pz7q8r?=
 =?us-ascii?Q?EZcyle1ZZq/fDdUDmznxgyvAO1V2/KylXDqPZS+x6OYOOonRJkCPPw9MnklT?=
 =?us-ascii?Q?iWG6mwDknIuvNVgmtGMEz9MAKj74WzGJINjMZZmjnAGaIdHIy7k5VXyER98C?=
 =?us-ascii?Q?kUh+Iv2kzPdbXt5JrzlliUAWz9+uZmPM6rS+Zlxe7uY3yIiXm27puPlV9lbX?=
 =?us-ascii?Q?PLBKLPrzIIdF0tpjxbeZ6/5E+jQZMS9Y0ahkPS8uROTYlT4oXeSoe+4dzkEX?=
 =?us-ascii?Q?mdYK0cUfPUpRW98qa2itRLWDCE0S+fdMn1i7cRv8w41pSMps0riif13OYJ1k?=
 =?us-ascii?Q?R5aijiOtRgNdOalfXA6P1nlI4mvwQETFt0ExJpIOXI3SXjSgvAF/OQoJYyCM?=
 =?us-ascii?Q?bSCoY3+NHYuxsQQVaGKH/oYLemgADGOVSqPVp4u12Jptrb1d7v7A7e0PRYNV?=
 =?us-ascii?Q?i1WuGIt1qFjq8r4QISHbaLpObHX6bK3vsqDeAQLlTj8ua4aWwGZpX74KM8c4?=
 =?us-ascii?Q?OdAoAQBC6ol0I+Disp4gHr0BieG+M7Altv2LaLrJfzT+GvHihx9T1kPUnOpK?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4Ff2bK6AB8Ivbo99bWIx3UtjkpqqwVvMqhKKK9SRzmKgLZEJOLxGquljoLszDgnLTdteNKhjedSJGKU8iZXZzrugWT+2M0VdKe/FBcC5avcxZjk/BhszBDwoNUjoq43drg/2na01VeAC/ZANQoB3ZF5KDHh1EpPtAGzA2G/f1xoec6/dN/Vc3EAfmwcdzAuFOSqtreozWDqB5Ux9xwq6VXk48WLs71H/A+IWPydBDfmmddTa7tJJXPkp/c/hC0P3LLNVj5Wxf5dYIBjyS1c9qEHr5Bpw6klr6gQMrKWWxLo4FRLjQ5UqzdiGCfExJrE12U/omgN8fEX9r4sjRUwQZZiNcAZ2qL6BmrkyBaatoRBReVeTcqojZ5KyHJDxKBSP/VHAicckKMEoxy86t54Es4Ccrls9TTFyzuzeobKdqDf2XBXlHECnwMdYBjyoIgZjBjTG8i1qPfukPHKLC9K35MybHpAxMsrylA5ivhCy1G14YZKcVydlK1Hxll27Th09AFSyo0NRfxVXpSwnT/h9nRUIV+h0lDvqQprt2OtY+wgkEjqmz3Q7HiyWMqFU6w2FhXH0ofVYO2LKY7EhQEgP8i5+uG7n2QS+jbZLG+NvQTYAwNcFNa28r4a3HJV2WO1qZJgjjUm7gNneFTJSXp1mnjmNj3NOm2ZjZ8/zL30dfDgwqtsKM9FaIaEJOS4dBzkqTMSCydkIV253nMT/O82XD2d6XrBfu5kNL+pHgFzpXGquolGsUNiG/0qqnX71i0hLoOKsBg5Wvod3K0pCwef5QqyJrgqJMHqPPpMEFN5sa/0AuouzGVVYscyamItqvbRN
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ad9a27-95b5-4d40-48a2-08db769c52ea
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 23:23:18.2582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYjDzGbA50WfToONcYh09fkGcbDZnzQ4gNh9Y8VOOLEkX6ab/nb8gM6KbIgrKZ8J79G1k9M2B1pGTNuThb2FfP50RR7ksZBpgAiH+HQPilA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_18,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260218
X-Proofpoint-ORIG-GUID: 0nfwgT80IFAPqR8L-9-a9C_gRUjpkpYx
X-Proofpoint-GUID: 0nfwgT80IFAPqR8L-9-a9C_gRUjpkpYx
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

This patch has the core work queueing function take a worker for when we
support multiple workers. It also adds a helper that takes a vq during
queueing so modules can control which vq/worker to queue work on.

This temp leaves vhost_work_queue. It will be removed when the drivers
are converted in the next patches.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 44 +++++++++++++++++++++++++++----------------
 drivers/vhost/vhost.h |  1 +
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index aafb23e12477..611e495eeb3c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -231,21 +231,10 @@ void vhost_poll_stop(struct vhost_poll *poll)
 }
 EXPORT_SYMBOL_GPL(vhost_poll_stop);
 
-void vhost_dev_flush(struct vhost_dev *dev)
+static bool vhost_worker_queue(struct vhost_worker *worker,
+			       struct vhost_work *work)
 {
-	struct vhost_flush_struct flush;
-
-	init_completion(&flush.wait_event);
-	vhost_work_init(&flush.work, vhost_flush_work);
-
-	if (vhost_work_queue(dev, &flush.work))
-		wait_for_completion(&flush.wait_event);
-}
-EXPORT_SYMBOL_GPL(vhost_dev_flush);
-
-bool vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
-{
-	if (!dev->worker)
+	if (!worker)
 		return false;
 	/*
 	 * vsock can queue while we do a VHOST_SET_OWNER, so we have a smp_wmb
@@ -257,14 +246,37 @@ bool vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 		 * sure it was not in the list.
 		 * test_and_set_bit() implies a memory barrier.
 		 */
-		llist_add(&work->node, &dev->worker->work_list);
-		vhost_task_wake(dev->worker->vtsk);
+		llist_add(&work->node, &worker->work_list);
+		vhost_task_wake(worker->vtsk);
 	}
 
 	return true;
 }
+
+bool vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
+{
+	return vhost_worker_queue(dev->worker, work);
+}
 EXPORT_SYMBOL_GPL(vhost_work_queue);
 
+bool vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work)
+{
+	return vhost_worker_queue(vq->worker, work);
+}
+EXPORT_SYMBOL_GPL(vhost_vq_work_queue);
+
+void vhost_dev_flush(struct vhost_dev *dev)
+{
+	struct vhost_flush_struct flush;
+
+	init_completion(&flush.wait_event);
+	vhost_work_init(&flush.work, vhost_flush_work);
+
+	if (vhost_work_queue(dev, &flush.work))
+		wait_for_completion(&flush.wait_event);
+}
+EXPORT_SYMBOL_GPL(vhost_dev_flush);
+
 /* A lockless hint for busy polling code to exit the loop */
 bool vhost_vq_has_work(struct vhost_virtqueue *vq)
 {
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index d5728f986744..e2dd4558a1f9 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -198,6 +198,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *,
 		      struct vhost_log *log, unsigned int *log_num);
 void vhost_discard_vq_desc(struct vhost_virtqueue *, int n);
 
+bool vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work);
 bool vhost_vq_has_work(struct vhost_virtqueue *vq);
 bool vhost_vq_is_setup(struct vhost_virtqueue *vq);
 int vhost_vq_init_access(struct vhost_virtqueue *);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C284C637
	for <virtualization@lists.linux.dev>; Fri, 10 May 2024 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369196; cv=fail; b=stL2fU0iTaX/n84l9XetuJsvajRccJ0Jr6t0XbrJy91tnQCj1yD4Nb9ttsyhOGYKp0Lr6wSJuVY/29fUUnF7/T3I/n22MDTo03Ny2x2ulOYW7xN1iF98PCAL7A6dI8IcrwJcxx1lbwauziDjTITLCgOtPCGw2TTSdl8fvhvNVOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369196; c=relaxed/simple;
	bh=tl/TIvL8E4dXFIYKTIZjOaA3JLfzTLne9KFhdd61UP8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IuozqGwB+r6SX483UJmg7MJF7GUCiuQwTWXTP9vNQkORDFIlQ/wF37e1mfCxFE47OTA55Ia/9QE9n4NF0DDogTdF2WnC+ryfIknPDAgIDCun6+bokR4ZzXnCl2s/Do8gQ4P3hG8gUSkyjfXJhzKK6T8AXLMs0tACX8RiecFmEms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iqmSmeuj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ifJOE5A+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iqmSmeuj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ifJOE5A+"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44AHpVMY014759;
	Fri, 10 May 2024 19:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=ooXkCXRiNOkFrAKiHsrExTDaQIt5adRTdgoLtrnXkts=;
 b=iqmSmeujMCnr1hYF9fhEbeq9gM7bcbhtWPRglZUAXxTN8nKFp3sla9HYKCpL1pQqZaWe
 5KTurZG9anOHDqfl869hqLDEievPyIGUdTJG81wWrT6MsG3SVAQeIOCYkh0XYdMf2KiR
 o7xH1KRqPvASEx3NcitRqXygKDkU85bfCiVvEUK9s61pMsbZUt7vEIRynE1RrI1cFMKW
 rSAF1AW/B0vCgyaPklrRkU33NaOVV0yR/+1lvzJlgduZW6BzP3sxeYpW+YwuhXT/N3lR
 m3zexRPqlv5DUeoHC/r1/pzm8HBhVjEWOq0npgBnAj4HYEDh0+kgVmVYKxAVJ6iZJxHY nw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y1q1trdjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 19:26:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44AHvpUg018006;
	Fri, 10 May 2024 19:26:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfq8unh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 19:26:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2009bM2hJ90E0kJ6UEzMoim7tJAAFI6tjzDclanNIO1vZImYbZBEQw3FoYk2lTtCWW70WtXpGYMZRy4/A+UDCHXsp2qaFB4Wi8jmH0GFS1ulF0cWJk478zrl6hsVuDHBan7u0g3uWj81jLY95vA15BL27T6EFkn8Kr1cZonROsSWmB+YAV2OBLrkQM6ZqQ7AWT/MmpLZEGTuy4hS25cXJShpsOgHC5qkaGa36AynCUKTEbnsg0iYmQqMFlV0oQJ2SE/WxsC/IZAJjSeo0SnN98RoHwAFFC1G97rFKafWVZ/yz708oiaWYN2jNO8NaXagR3LWzvrwcO1Qr/HfUWMng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooXkCXRiNOkFrAKiHsrExTDaQIt5adRTdgoLtrnXkts=;
 b=JBu2C/JoF4vVCrfBP0P/tpm6GkP+oV8hz+Ean3P4YCljVTFr08cfrs3yAWVJMQow8AXYWFwGRrT3cK+LF8bNgoAEysr23XibjvelxRMAaRUDVT3DvOtPLEWUTJtllHV0JkTrhsWNrPHjrIPWaPPNN5GQqES8EdRXsWG7brVS7P7JiKHXs/CzggUMgb2vYEvXaYa1hv5NVjxNuNc/F55Ux5IuB2HbbkikaWx7I3vn/UzmMhJ1z/V36xfqOj5hsNL1rCiiwc/6w16ZSAdkm4gLgpKRaeNzv29Eg3iDQXrE5b4YJFuwTGQy/bII/sFbfC5OBxhFmpMGB+nAOz7b5kg6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooXkCXRiNOkFrAKiHsrExTDaQIt5adRTdgoLtrnXkts=;
 b=ifJOE5A+8pZqECOL8D8lOuNKF2Ok5g1YS3hidz+d5oXCzfmBY/az+iLNkHJ9d3HaFx1enUP7tj5k41iMCFmgb33U3eftrBZ3DjJvGZA9kpdp3TgN01u0ycPN+27TSQtYETTG5uYzJ0sOB00BsfE/NkD4NgmKXljkC3iFcWVA15g=
Received: from SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8)
 by DS0PR10MB7223.namprd10.prod.outlook.com (2603:10b6:8:de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 19:26:21 +0000
Received: from SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::447b:4d38:1f8b:28f1]) by SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::447b:4d38:1f8b:28f1%5]) with mapi id 15.20.7544.049; Fri, 10 May 2024
 19:26:21 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, joe.jin@oracle.com,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: [PATCH RESEND 1/1] x86/vector: Fix vector leak during CPU offline
Date: Fri, 10 May 2024 12:21:10 -0700
Message-Id: <20240510192110.117175-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0199.namprd05.prod.outlook.com
 (2603:10b6:a03:330::24) To SA0PR10MB6425.namprd10.prod.outlook.com
 (2603:10b6:806:2c0::8)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR10MB6425:EE_|DS0PR10MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: 261e65b3-a19c-4d76-9fb9-08dc7127129a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?w79QM6TG3srPMl5EyXYpSc/7Bms7Ztmkypvbypoy0Q41qu1qqoZ+sfb5SEDO?=
 =?us-ascii?Q?nSnNs2i5TFnMGh/y9A7st7TmZxKID9SIxz9qTX8EP0nqZr5krRzIpg+TST6a?=
 =?us-ascii?Q?EJnBqR5mlzXl5G/zsfQY2ZkauWgHd+florZLZPYFzaIJPYjzGuCJ7qcL87Yz?=
 =?us-ascii?Q?/4Q+L8PnEx9UdXVawVLoGpK6Lh3Xuwxz4bd6XC/YNiidOcc+XabsPafTB3TV?=
 =?us-ascii?Q?Lx25ZhunuZJUoCNa3bJnDek49ryWvnJzJDQESQQLGBqI0M+xdGQPtS8nGWI9?=
 =?us-ascii?Q?JhtspeozZJkxCV5W+H+9I6pLuSazAZ140fGhd2qJlJLAuaFUMf1dHfUT6U24?=
 =?us-ascii?Q?y9ru4weRXfPvJE0cJZp7Hvl7ejJjacFiBcl7wIwEJSGaWKSMFlGlE1EH0Z3f?=
 =?us-ascii?Q?ixB+ZJt07EjLzb2wprnvVABGqugz6qyofh0PLdYSqq8HPWCiYMyv38HGayDy?=
 =?us-ascii?Q?Mkl82TSB90Lq/CUi1NToaPqN91C4cKsDzf3654bBT1myW63nK1BPzO3zqSrA?=
 =?us-ascii?Q?vcwSFnSvalk3+e5wmdNUL4nYi0J9aObAIF4HRdOSZG6/jus/pk2GknkV2jQK?=
 =?us-ascii?Q?dDqpQHVttsNv94UINAij71qfv+u6kK8REX60b0AycFEWJK+V+YDaHO13wP5z?=
 =?us-ascii?Q?U35mjGoETeU+95T6PRThmJoGT9WBQaPREAyUk2pZ7louDIBIChpI2hvCuGiN?=
 =?us-ascii?Q?je3xaxATfJihRyiKfOY/WB+WMTYXgXaTnOyX+JGbUzd2m4J9Yg3mkjjPeOpb?=
 =?us-ascii?Q?GHmGyUKs8CSMjtZoy+/bRh9pH4434x91Zfkz2GMf3DuaWhTc3a0RtPFZe80q?=
 =?us-ascii?Q?GgAom2SrMfLlRcBSfoH8sjGEbFJhZ51RmonGYuzE3YU59waQStqpyQEMzwgB?=
 =?us-ascii?Q?4E5hcjPpAbZw6bwxk7ZJqQqEZCRlouc6Yqn2jvEhWyQxhiBzFlYTRCbTiyft?=
 =?us-ascii?Q?QywSjgZ/R7DCYrziW3bTZHZfc3djE0kcIeLNKAyrZeOITgvTO1Wy7AD+l7c+?=
 =?us-ascii?Q?Gl13T2uamk13ld50ddmnIO6+0QXByQ/KbP6ve1Ba0It8TvXDiXfXJzpZpQUb?=
 =?us-ascii?Q?SuiSbKc4WgTcl10ocaRlSoGUBkz5jdNjdsuGuLnIkgzHoprwLUxfMUa0Ei7O?=
 =?us-ascii?Q?FBhEP2z4YB0J4I3OkWWRSUel/S6sYy6y1I/x1liuBLegsONS6XuSUwzyIT1F?=
 =?us-ascii?Q?xXxFrlk3XcbLDTXiBrXtTjrDxNNHAH8Y4hWVLvjcXgeu8de2Il2Aq0KTNjAf?=
 =?us-ascii?Q?9NWn/cEyOyDkNoG0nglpRofthrXp/fa+PSq+F4eGkw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR10MB6425.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UQYnnW0Hfvl5HFGYRYG95hq3DhJnJ8ZT+iRMJ+Ju/JUrca0dT2iu/cnt5s8L?=
 =?us-ascii?Q?94HAPjgLPcykuyKwZOaVnj6LcafwoSSGMMxV7oKzGlrsS/grcfIWvOvjwVEu?=
 =?us-ascii?Q?Wk+2eLUC7Nk0Fkqtz7AwkJw1rV0UPtDrRtJSCP+m5h/+WrBG4Al6f4H1dB9K?=
 =?us-ascii?Q?Z3Iwur9jnEWB13AE1Krt1ldZKrM27Xr7LAH2ZLrV969TZ6WxRHdjm2tarE+m?=
 =?us-ascii?Q?fmidj/bx21Fy15kmrNo7ReA63O9C/ZdrQrecYyyCFTf2fkJdxSfPkzk1dgFH?=
 =?us-ascii?Q?4F8T8UjwIe9lI19PoBvlMaLpfQBJChGjg1YM/Pdt/d2+siuNV/N0q9T70rQ+?=
 =?us-ascii?Q?1WjsqLi6yUcFH2EIwJVi9nW9xRioZ2iQ+wuMf2gLdEWBQzH5VnDTSI4vjHXo?=
 =?us-ascii?Q?CLqHXpBgq8+3rLFBqCyBuYZX5L7DD6NqDVI6aZrlT6OE0Fxug2SUYXhpeAVH?=
 =?us-ascii?Q?4mZTQrA2UHskEQtoeth6YOkuqYPTusODZpciJKxi1EBk7pP8fVYeLF72CpTF?=
 =?us-ascii?Q?8TfuWz0pMGiKafyXm40i5uhjCI9Nhl3R+FKiuBxfv7qhZ3r2NOHYLAt1zbiz?=
 =?us-ascii?Q?alH7eYvXMMAX1jE33CmfPuZVQkrkRiSqcwaw5YDHa6aK2XxViU7AWJt+TrWG?=
 =?us-ascii?Q?YCC3GKcAomtuAAVfdnZLBILpsDVDSMMotgfX02VsQvRFVqxeCeozX4dsaeng?=
 =?us-ascii?Q?QEjPq2U3LMwqQ6o9FCc50iqeq1zOaIzOY+l1npGGM0GZNEQvTHyr3UpnDb+7?=
 =?us-ascii?Q?VcrEN405ylXrIOqubxfW3x5UpW6Tpj1dOvM7BTTY7sAMNWkklUzlPk/+4uwY?=
 =?us-ascii?Q?IHtnVlaojZHKw3hMz5YEiFef6UvrRFqlYSrOxsenHfyBHfer21UA9mMgTPZI?=
 =?us-ascii?Q?FF9x6t9v3HGWfrfQWfEvfHjphAszhBIsWVIj+CPBnBoGcAXn6gsbEaVMoZ0S?=
 =?us-ascii?Q?igXZ9doSNHZYrXVtMuUyTiEnn6xmC0JpTIYSJMC2XBv6Bz5+IRKuQhM5P6oy?=
 =?us-ascii?Q?FC8tIesTyP6d4HTUJZoZzlhSgCOSc9UKMXSDQbSFaYGoICynelmgxVWRyzDW?=
 =?us-ascii?Q?DUgkaTw4riju4n3HhRGS1MU6ut3iVU+4LSGPJROkLomHkG19HwA5lOdHbsLl?=
 =?us-ascii?Q?X0duNC9gDyqdBSQj/GJXDXE3/KQ1UlO7e0j9Hi1IY/qYzsP0i0VL6DPgT3Lr?=
 =?us-ascii?Q?e+P0SJvyieNvXorpZt6M+n5WptaC4kYr8iBLpv3Nr5vllRTssjIew1p/NCh7?=
 =?us-ascii?Q?ldp3jMjrYqHTrnDUQyTy62zREkzeA3bDRf/Dc7YXtb7O7iNnpyvpnRFIFj/B?=
 =?us-ascii?Q?rzThX0dn1Gms5tnbeTtqmIuwTHxlJWNy5UlBehP7FiXZDlLnASqKg4J/JJw5?=
 =?us-ascii?Q?dLYQjHqD/ge0QQc0aCZeYHo35yx/gPT/+KO9sJIPxtKaE5cMMu9IrL3k980P?=
 =?us-ascii?Q?IhRQJjhDKyzqVGU3lwApJ1RumVs8ehHi2JBpmHHy+Hiqzm5saUWzy3GtGEmj?=
 =?us-ascii?Q?m/y2ANfMni7HjzNX8R3uaXatl4P6cbx/Nf4wfTqAwOIoOidc/m7aUl9lunWY?=
 =?us-ascii?Q?3SBb4Et/O4/jEL6A/2Zhrszl2EjB2K/bz9q03VuFgC+dVMBdsGmZuXxGp43P?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	P2SeT7ApEhJ8P/1NiRKXm4Tlb99ZuiRdGeYq2pgF5fZ3WM27QRfu++cUAPiF4uV66OnDU+QYAObgLDodCUX6AmwBgoaCT34LbsfdgRtr/h8yRJpFcmH/c39Lf2S6EGdWtjFk/twye8iYFpu47gC7ivJuAM9Dfz81gmCZbo5T2oPs4QpFxJYrtfjlu7NOcGWQd4MJ3zhoK8oqyvDty8w0EVS2mYqhKfUX+qXRK8tSZJxrp95IuZmX+26/pApMeP3oYxpMP94FU6uSpRavRNWX20ktj08+SXHwiF+K83B5bfG5edTvKAMEkMTho2teJWI+TvCvcmW26EY+l7bvOomrC7KxI+DejotUkR/wzvjwrQ/fIF5vOlEZoCmJtXPQOvl8TsC09FiC44JueE8y8GXbgqSDJSyEf5vfiOkhSiNy/7wW5I75+oXRd+rKzz7YPZMzu94HE5Yb4zWxldotEMkd8AY5JzJEijR2nQRCL53m5f+1fpugRb17rGEJp7IRPHYziy4K7Trpbj7h61rEr+OwPdwkjGJRCWjazC2Y61zjmOmAt9lOODKhRWO8VnIc5ywoRfxx+YtQhX0uVxdm4wpcJfEaCxzXjkqiEukgzG4MQkw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261e65b3-a19c-4d76-9fb9-08dc7127129a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR10MB6425.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 19:26:21.0439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oh6xv9FVP4MUPNEAJnXQiVHDHVjqq1v6eEUrrf1j6l873QEvmyaJ+ZB6S32mQenG5FmF6pZlZ5dxBn1wiiKO7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405100138
X-Proofpoint-ORIG-GUID: BYWqXiXWS8YMVHWWWVw6BbKAWaAbyT_H
X-Proofpoint-GUID: BYWqXiXWS8YMVHWWWVw6BbKAWaAbyT_H

The absence of IRQD_MOVE_PCNTXT prevents immediate effectiveness of
interrupt affinity reconfiguration via procfs. Instead, the change is
deferred until the next instance of the interrupt being triggered on the
original CPU.

When the interrupt next triggers on the original CPU, the new affinity is
enforced within __irq_move_irq(). A vector is allocated from the new CPU,
but if the old vector on the original CPU remains online, it is not
immediately reclaimed. Instead, apicd->move_in_progress is flagged, and the
reclaiming process is delayed until the next trigger of the interrupt on
the new CPU.

Upon the subsequent triggering of the interrupt on the new CPU,
irq_complete_move() adds a task to the old CPU's vector_cleanup list if it
remains online. Subsequently, the timer on the old CPU iterates over its
vector_cleanup list, reclaiming vectors.

However, if the old CPU is offline before the interrupt triggers again on
the new CPU, irq_complete_move() simply resets both apicd->move_in_progress
and apicd->prev_vector to 0. Consequently, the vector remains unreclaimed
in vector_matrix, resulting in a CPU vector leak.

To address this issue, the fix borrows from the comments and implementation
of apic_update_vector(): "If the target CPU is offline then the regular
release mechanism via the cleanup vector is not possible and the vector can
be immediately freed in the underlying matrix allocator.".

Cc: Joe Jin <joe.jin@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
Correct the email of bp@alien8.de. Sorry for my fault. 

 arch/x86/kernel/apic/vector.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 185738c72766..aad189a3bac9 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -1036,6 +1036,15 @@ static void __vector_schedule_cleanup(struct apic_chip_data *apicd)
 			add_timer_on(&cl->timer, cpu);
 		}
 	} else {
+		/*
+		 * This call borrows from the comments and implementation
+		 * of apic_update_vector(): "If the target CPU is offline
+		 * then the regular release mechanism via the cleanup
+		 * vector is not possible and the vector can be immediately
+		 * freed in the underlying matrix allocator.".
+		 */
+		irq_matrix_free(vector_matrix, apicd->prev_cpu,
+				apicd->prev_vector, apicd->is_managed);
 		apicd->prev_vector = 0;
 	}
 	raw_spin_unlock(&vector_lock);
-- 
2.39.3


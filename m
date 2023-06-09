Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8EEC7EE37
	for <virtualization@archiver.kernel.org>; Fri,  9 Jun 2023 18:25:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4ECA84252D;
	Fri,  9 Jun 2023 18:25:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4ECA84252D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=vmware.com header.i=@vmware.com header.a=rsa-sha256 header.s=selector2 header.b=JYFGftrZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 40opmAZRbHFn; Fri,  9 Jun 2023 18:25:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8DEAB42534;
	Fri,  9 Jun 2023 18:25:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8DEAB42534
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 649F9C007A;
	Fri,  9 Jun 2023 18:25:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 542AFC0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 18:25:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 20B2460BEB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 18:25:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 20B2460BEB
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=vmware.com header.i=@vmware.com header.a=rsa-sha256
 header.s=selector2 header.b=JYFGftrZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WLTkWNS72DXV
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 18:25:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1779E60B28
Received: from CY4PR02CU008.outbound.protection.outlook.com
 (mail-westcentralusazon11012001.outbound.protection.outlook.com
 [40.93.200.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1779E60B28
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 18:25:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxLElXgy9ddw1ltYYN46WexmhTcT+Fvr/y9uYAMpYcjQ4eZ2/muVZyt2yOzXrIkVhYs71I0mZVqy8bBmpaP8SCiiLJIQYqaF5FtYhtgeUYhXi9KkWYBR4GQwypouHhlxfPXtWFJWa87kDUC2TR7yo5md+1p9Y69Ysdk9+t24iDsJiA5rhC5cebelTypZ00nyvsDqdxHqUI8kmu03VWvs//BF6uWKsSYbgveD7dO2SamMbVabGPIQQEVXSLwF33pdca3JokCY/xMAJZ1bNoamGRTP9Hs1NuCeS9otR41pqsnnsR7DCsgxPz1CWGl29xUkfWLNVWBEdby27HGUK/VFkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqYXoVhc2coJCdBcdAI0cJ+WuWrucPdiVs1WdmeXYzo=;
 b=dz1bjq2g+B3to9aSVSfW+ldcolz/lm7bfmp4Lj8DytMwRyoq+rCrCaRqklErBXCY0Y/jttRtJjYlnuxBcKKj+HRIfhqrtDRPw/ZSrB+uzTDLv3vUsCocJfBWdcW+t2Irs2qhPUaMjwF9cfCgPOOuown6xA869oPqMWo7n+d0u95MSssf3Z3hB2yiUlxqGeiE9wx6JgbrmJBfxtLOG9mT3GhRzlavvgTV3a7iapnARgtDfZbib370ETdUrS0yQPemEteqOoUYsyUrH2L/HrdSAVKe4aXiL86f+TYNQ5AooJgFFayFuahYCzdnyaAwmih4muT9Smp15ldHOUGtoJQRmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqYXoVhc2coJCdBcdAI0cJ+WuWrucPdiVs1WdmeXYzo=;
 b=JYFGftrZf+1Xeuco4nFMp7z6ZvheWVPftVklg+M0UIqIRXu6fJsGwyYsZz5E+fvUTnkC0uwWNYk103XfFIubHWYIzllr+tEWgGpAe/eODZ571KS7OHcKHnVdxPtDtk6es0k7xory+LGXQwl072OCGm2TECepxvLRvSQ5VeCMS4g=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by CH3PR05MB10075.namprd05.prod.outlook.com (2603:10b6:610:133::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Fri, 9 Jun
 2023 18:25:36 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::45c9:cdc8:ff01:5e8a]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::45c9:cdc8:ff01:5e8a%6]) with mapi id 15.20.6455.037; Fri, 9 Jun 2023
 18:25:36 +0000
To: Hou Wenlong <houwenlong.hwl@antgroup.com>
Subject: Re: [PATCH 2/2] x86/paravirt: Make the struct paravirt_patch_site
 packed
Thread-Topic: [PATCH 2/2] x86/paravirt: Make the struct paravirt_patch_site
 packed
Thread-Index: AQHZmrdK0cS1ZqzTfUGKvtxOsR4tqq+CyhcA
Date: Fri, 9 Jun 2023 18:25:35 +0000
Message-ID: <1DF3CDEE-E9DF-4F16-B5DA-1727BBBC3C2D@vmware.com>
References: <9e6053107fbaabc0d33e5d2865c5af2c67ec9925.1686301237.git.houwenlong.hwl@antgroup.com>
 <6dcb20159ded36586c5f7f2ae159e4e030256627.1686301237.git.houwenlong.hwl@antgroup.com>
In-Reply-To: <6dcb20159ded36586c5f7f2ae159e4e030256627.1686301237.git.houwenlong.hwl@antgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|CH3PR05MB10075:EE_
x-ms-office365-filtering-correlation-id: 2eaba6fe-7569-4258-8f71-08db6916eb3a
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +0xqf58BFg3ToJnGUcOeXoWZN2EcUqY0UUJItVl29b+JDQ62eyVFszo7UUnl2vx6CXgMPmYXs1DuAD838q71vftm9RT66caIkoRAgzPSjYFMSdIh5AgEZZOTTE/ZJ1JTzLfyJ9U6iew0mC2/uaOApsodS1tFGA6otV02eyEhVQuQPMJUODl8bYozUZIwcW9Gy5BuNGGfwXbX43y/0T/fKSRqkNfOjnmTuO8LDDgcQ7lh7LRxpV2hNihvqyPPKW9H99N6/zCOw7gshS8gkTCl5eJ6k2P1Z9SqwBF+4OlqgaGv+FsCBlewfg663xRaVXDr2WISjiazP7jg3a5gwD2XD3qQug6TblFcC9dDC8zjDr9n29IOwYdseGpo0bK+Gr7UJ2G0+5S8ToinkNJd3AmaMOyCNl9ON5jjI512jDeILOqx5VeIMLy3YVfjXDFwEELT7qu0oyqze3iSEl+Bv4QifbKLWDxVhTRZYVnBbllF2KUCBIktf8LGk1hjZ4cSBbw+1UEBv2wH+Ud+M+Zu29C39l/QLs7PKJnC5yuyzxl9n8OxJ2yUQ3fgabYn5jy3EMR1yx4+ZuXlmn+TT/DiuTN/NPmy5TXn15gvjvGBYlvs7WGuSOcPC4jOXL3YoyX/vMtZRPqLtvRNHxPKSKswf8PYJw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR05MB8531.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(6486002)(316002)(41300700001)(38070700005)(6512007)(186003)(53546011)(26005)(6506007)(7416002)(86362001)(2616005)(2906002)(33656002)(558084003)(122000001)(38100700002)(5660300002)(8936002)(36756003)(8676002)(66946007)(66476007)(66556008)(76116006)(478600001)(66446008)(54906003)(71200400001)(6916009)(4326008)(64756008)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gPBW4xEL1ACbCPcaGEovGcuY3M13YLkKA6Ofy9s0Y9nJkGZQlsLO3dxkl+CS?=
 =?us-ascii?Q?+NtMNCl0tQ1xmwJNvyfCZBLSgsTLtejDzXpu9IKolb8W7mTUz4LXiwv+nfVm?=
 =?us-ascii?Q?BXpUOxXZnNd1WkYlzr/ASTLaBW4AM0GB7jGhpRDpnj9xJSXrCCe8W6W/9FFD?=
 =?us-ascii?Q?DPaz2KXzbENqdxcZb/M8GDaw+aPYKaf9/WHrlejEdZ9vvRFmnhgo75i3tOom?=
 =?us-ascii?Q?xV8f1TTBg51Cvkzc9q84hK/090a0jGzFxt1EIpqjI+qJxNW7/ZqIBtTqVTt+?=
 =?us-ascii?Q?dYO4eHb6gYd2Byw/RyzROIWPR1ld7chSbX47upiQOC46SYyNyWspawvBd9x1?=
 =?us-ascii?Q?MWDj1nF2ba2cFP1yVFbskzU5lkfr727tWaAhsqhB2QYL5hbQVTXxfK+F4hwZ?=
 =?us-ascii?Q?1+Ab4fjH15OkQK8Figi0a3cEbNpeCc2S64rJ39Jm4tB25Ug4q8L2JicBYzd8?=
 =?us-ascii?Q?AhjZO01NcVD1l66f04ofmw+Q/ZOOwnEjo9DYCjAtNnE8KtmZywqVqgs0Q6au?=
 =?us-ascii?Q?qeXZ+hrfT6x6Z+mzraX9J0f9whHz7hgkEYe5Z+OgFaLD9YVXBrVJsplm9cMi?=
 =?us-ascii?Q?W40rPTuxMxCuseTSkJiauxnDOWno97L2JhbUTtpF1+IxxJXb6ip49GQt7GfH?=
 =?us-ascii?Q?2UNkcLlBPik0ftglAi2wkZ31FFHalo/4oGptgd5BtzUx0LqyZEAlbtp4PmMb?=
 =?us-ascii?Q?bqaacp3434Gc1lB0lsysmkbBnagAUtBeZSxwzmAtq3K5vP/B0f0xl4KEYlJz?=
 =?us-ascii?Q?ooEmNsGfgPfvVxc3rTlsfWnzfgWDs8ws9ky5y1KFL8SHp3pJVXkbLQCdtOXa?=
 =?us-ascii?Q?RmULJC/r0p8GLYzGv8dGPaLYI3/gO7eHA8kRDNUe2jfBDYu4obZQ+4JhFm0N?=
 =?us-ascii?Q?SH8LZEThzbkLaAbO51qv4HWcR/7be7UuEIqs88O1yKyj9LDbE2yGYV5Uduxo?=
 =?us-ascii?Q?6vXdk1I4XAfYP5TngE1zh/YEq4uavN3qe654sPXw80jGMPylQaiQXmQeE1Xy?=
 =?us-ascii?Q?WJrU6KFJUM7g0zvxvmrP099L8/X48YMiEs60KG47k50L9WwNQ4qsnvthNpO9?=
 =?us-ascii?Q?Tt75BL3uwiX5VZfUVJD7anUKfrpuH2uvl2N0Rh7f9CJwF1OedUz/bVWmo7tj?=
 =?us-ascii?Q?4wV/v5aW9z5rSSHhcDwpAxpdTwMohwx9p2r7w53OVzP1R1rSRTXy8mEn584V?=
 =?us-ascii?Q?YIO2AX9sqszwNnI3zX9h4+YeNHEObtEaUqGml/WcAODd9fHsLge1xxN7P5QJ?=
 =?us-ascii?Q?CSjDMcTC5THnT1nxYBhIiKVitC9VzErGFhyXpXVaas/pmw9z8h0ZPcjZD3Y6?=
 =?us-ascii?Q?3yNFPXger62Xd9w1nFDzHNTGfPIT2SQk6AyxmOuHEGylVjff+/Kjz9kNKb32?=
 =?us-ascii?Q?TdXSpCwuSr7qiXqRMqy2IUBmOd5ECCAaB61wyAVc5QGU2Nf8EchxpBVeZdAI?=
 =?us-ascii?Q?3OY6xIiASUJkIfvfImpif+KSa+bf4sxZq53RWFPeNAzszpw/ySYOZLNW5/1M?=
 =?us-ascii?Q?cDm5xsd0UA6FxbQXicfNSdpNxV+LHNUzdEL3ms/I48vxpSYPhNTbRjDu9d/P?=
 =?us-ascii?Q?YD3k7CVTaCf1LWZUw9jZL+C1bldZ01wm6Mufc1lj?=
Content-ID: <E8AFCD4AC6F0B948A00DABDA354E9386@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eaba6fe-7569-4258-8f71-08db6916eb3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 18:25:35.9189 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: etZAr1twmoA7tF6Du2Oe2wTxYk/LMFu4txvbxBNIT/WCyy+uxafOuHeif29CfJKBvZwjNLnnaqSFTSLc2I7gEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR05MB10075
Cc: Juergen Gross <jgross@suse.com>, X86 ML <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Pv-drivers <Pv-drivers@vmware.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 kernel list <linux-kernel@vger.kernel.org>,
 Lai Jiangshan <jiangshan.ljs@antgroup.com>, Ajay Kaher <akaher@vmware.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Alexey Makhalov <amakhalov@vmware.com>, Thomas Gleixner <tglx@linutronix.de>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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
From: Nadav Amit via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: Nadav Amit <namit@vmware.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


> On Jun 9, 2023, at 2:45 AM, Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
> 
> Similar to struct alt_instr, make the struct paravirt_patch_site packed
> and get rid of all the .align directives. This could save 2 bytes for
> one entry on X86_64.

Thanks for taking care of it.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

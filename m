Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD00ECAAD1
	for <virtualization@archiver.kernel.org>; Thu,  1 Sep 2022 07:47:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AD2C61018;
	Thu,  1 Sep 2022 07:47:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9AD2C61018
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QHhWeo5J
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XJiy52XfZ3X4; Thu,  1 Sep 2022 07:47:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F400C60E0F;
	Thu,  1 Sep 2022 07:47:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F400C60E0F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CEF38C0032;
	Thu,  1 Sep 2022 07:47:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D7CEC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:47:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB48B61018
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:47:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB48B61018
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kdu8CBXwhM4O
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:47:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8BD0F60E0F
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8BD0F60E0F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:47:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPG0t1a2d6ycTpZIduUFcLk+dCEvP27AJaT7Vs3uQzE8CbLjYUDeEuhn1q8xJrfN9GXPRhJrIrshSIExVfX6a076U1Nfgv4vEDDjf/kGzNhT4n74FT/TcXqhuvWUe/v1EHACy3sHtkz8CbC6CtQyJfbqK7v+mD3a7zSPYNNtilw1baQKtl4XZNIdm6b8LPo+caQ/xr9RTp+4tXUJTfrMEwNdPTYFCGsXTZiPdCRum6rT6pEad93h+gzg+r57TjYjePs5Mtgh+nW8hfqr0FTzv4ONTzamPvR8e5mc3fkToDTk1akGStHQDlxMCjcf68Imq/lMTd/9WgWhIap1wk/5dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/Bdyndzcla1GmGf06qfQ4CIfG9ZrhA2pOhkF4w4RcI=;
 b=AzXNO/Ebgs7KsYboZQ81Sy9mXuqZse2alEpRnI8UFdmC36QKnTbaqkUYfMF/bc84LUJO1O8LNobeayXJdMd8B1+vZ1ulcTfN7V8vn9utAeTKDa8VIcIuGRY43YD6T6EKFu+VoG6YORXh45i/dQ5Z6kuDUJcQWVWN6HjAq1i9Hi0mUYUTA++ku9cm6teMExm4Rh0MZlcxU8taIL/OJAKU5tE5hM4jP6TJ/1rAosqC716u3cEBjvNbJPZH+9i7EACPlQ5SnlxUP0u5+sF2ShnC7d8X4MA8y//6QJ3BlB5zbOLr4W3/TGMV1nI6KgiPlzWN+R93zPx/ZPJxTAPGItBBmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/Bdyndzcla1GmGf06qfQ4CIfG9ZrhA2pOhkF4w4RcI=;
 b=QHhWeo5JdnCPYgnKYkkB4WTvB4iI0sk32s+d2dQqETr8PVjd5a633escMfpuCZ1RBQkUpAH+jC95L2t4yEY26qWRpru2M+T5XcUfeha5T9pAoJv5XqBONOTUnX8aWnzb9NpkCU4hZ7eTJuuBS2dyTIoiB/OxJ08upO7PH7L3UoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB7068.namprd12.prod.outlook.com (2603:10b6:a03:4ae::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 1 Sep
 2022 07:47:12 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4524:eda6:873a:8f94]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4524:eda6:873a:8f94%7]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 07:47:11 +0000
Message-ID: <fd3ceab5-585f-c814-5df6-408f25e96354@amd.com>
Date: Thu, 1 Sep 2022 09:46:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 21/21] dma-buf: Remove obsoleted internal lock
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robdclark@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, Thierry Reding
 <thierry.reding@gmail.com>, Tomasz Figa <tfiga@chromium.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>,
 Qiang Yu <yuq825@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Tomi Valkeinen <tomba@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Lucas Stach <l.stach@pengutronix.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>
References: <20220831153757.97381-1-dmitry.osipenko@collabora.com>
 <20220831153757.97381-22-dmitry.osipenko@collabora.com>
In-Reply-To: <20220831153757.97381-22-dmitry.osipenko@collabora.com>
X-ClientProxiedBy: AS9PR07CA0005.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::28) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e46d7f8-95a1-43b4-ab5e-08da8bee2dac
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7068:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G04l9/jWR2wcOGf4mzqMHPpFHGj6dRta1rTvry398jlRnBYgTPPgoNz8A8LV0ejXK5MoD4hlKvziGfZzBoRm5M/bZieHhjEflISu4+0G6gwRA6pLSwNHVeI9i7xkm/83vIwgkX4JAxMZtP1JrbJ68hatX68KyIW8RquOYllAfmRLSpfX6p51SZqluLqPwlnV/7EH0GEEK+ctpGI5BdeQc+DNaUKB4TnnP/X7mTj0Gr71uME5l3BYDj+VN61qZOP7A2zlB3Vukl8CKeJC37mpFKIgaS7Byyhp3pOUTmK47BTC1slgYL6IKhdPHQ9vNW+JettpXcOLr8SxqBOoZvbHaybGsqhOmjMQEIjsMT49ReWhA50rqtjno44PAqnkNqOE0AQgBUQrgT7iQweyWQ/uN4Vst7yF4K42y799A1C1FRpPabOSSvd6OLAdO7jYjMfeA4s9ozYv+p8dljYzTqE0qa51VwcHKt60j5PaXTQW3g1cs9z/dBy0EK6KqJLJKdKKqbgrXXd5PeetxFrJkaGU17HYIbT0nSnourNArYUeNLdNcniSoX2U/WIraPjpplTssF5s+1kIWqe0XHPshBoZOiaGye24FCz7zgFFn+85tdaFt4+liBWJA6KOc6UnLka7tUJZPZ+aB5xdnqXAsVxpY1zXK2+ATj7P1WjOX5aZspcW2G1cWygdJSn93GUbQNemK3dPlVT5HkvizxfZ4Wyii+/DcM7EQxo4AIe6750du1PXToYDiDGezZv63xrcKlTf/rMSTNcEUlWRSK3ONJ66OK941P909SNWJy7MDeDj8a9LQRVfbvNJtDcm33nlKUxx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(31686004)(316002)(110136005)(38100700002)(186003)(86362001)(921005)(31696002)(36756003)(2616005)(2906002)(83380400001)(6486002)(41300700001)(8676002)(66556008)(66476007)(66946007)(4326008)(478600001)(7416002)(6666004)(8936002)(7406005)(5660300002)(6506007)(66574015)(6512007)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzNjYVh3bjRSREJWbkcwTTY2UFJ6UFptZExGRldSanB4RXhncGkxTEtuUHNk?=
 =?utf-8?B?UXBzVGNoUC9xVHE5TGZYa0RwbGE0cFcrcmUwamhHd1llMkVHTkMyQktGOGhh?=
 =?utf-8?B?aHpBVkl3U0FyVGpUc0pZK2Ywa3lOaTgyckZIMUtlQXBXTjh5NkpwbkdHendZ?=
 =?utf-8?B?UVE2b0hVK2FTUVEvWEUwVVR6b0FqNERHVjlnNVAzNmNKNnlkMzB3di9iTFRi?=
 =?utf-8?B?SDE2eFhpYmIzZEdGUFBYYjh2ZVBZcnJLNFlFMDlzYk9aNkhzY2N4SmxCQU1X?=
 =?utf-8?B?cXJYSTl0ZzBFSS9nU0w0bnBPQzlPMkczVXRDZDR0dkJ6L3F1ZW5sRE02a3p0?=
 =?utf-8?B?WHJkTGF2QktuVnFKK21LV09CK050dW56d0o3c21qMWRGVnFvenhnMG1vVURr?=
 =?utf-8?B?bWwwYTBTc3VaeUUwVGNmZThCR3NQQXd6S3I0bEMrbVFMSENpSzhEZWZ4MGkr?=
 =?utf-8?B?UStYVStBbVo2elBnbEFTQllxdFFoRDNQWFNDL0lYSm9JclpzSnFncUZSSDRR?=
 =?utf-8?B?SkxNSTg4eThlTjVuQXRTZzR6cERSTDZwR1FqZTJCYnV0MWdtb0Frc3JIdlh4?=
 =?utf-8?B?WHB3cHFIb0NCK3EwMWxMRWppWmdoMU14eDNvTWxZdXNjMG9tbkVoNHIwRXFK?=
 =?utf-8?B?eW9od2hXT2hXNU5yUVhEVFpVNEFoYVI3ZC91MEdrMlUxc0hIUHg2VDhDRTMy?=
 =?utf-8?B?NjJpTmhNdDFUaXQxYVN5WnZUNkVIcFpLUjRVYlY5cmpMazd0QUZSYjhqek1j?=
 =?utf-8?B?MkxlUHBFbDFhclpVU3JIb2NtRjg4bzBYNUVJSW5pUEFKWExuTUpGb3h1SjZo?=
 =?utf-8?B?VDlwNnE3MlhuRGJqdUdxb3dsWmMvME5tQlBZbjByQlRTVkh2U2g3U0t3Q0ht?=
 =?utf-8?B?R0FFV2VwQ0RyVFlVclRaRk9FM0l6MTRuTWFYRldqYWNwYnRwLzRIdGp4QW9v?=
 =?utf-8?B?d1Y5Sms4VHdmK2J0ZmgxWUxERGZjS0ZIczAxN2l5dkE2Z2s2Q0I5dEJlYjh3?=
 =?utf-8?B?YWhVYWNpZmwrdWhWbUJUTGwrSWYvN1IwcFAwUi9jMlgrZko2cTF1WUhITXR3?=
 =?utf-8?B?SkRNbXJrUEZFZVZ1bitveVA3U2RhOWhZZTFOV2YwdmtjY0dwUVFhRTd3MGdG?=
 =?utf-8?B?bk52Uk9nTGJZdW9ZaDVHUUx3NGdkNlFWbzQrTmZsMFNyaTlXZDk1SUVlSXcr?=
 =?utf-8?B?dklUSXh6aHF5bnp4bEROdnJUWjhQd2RZdVZzQ29iOHprK003aEVUVzY5dHo0?=
 =?utf-8?B?U2gvazlUWkdxSi9wSFY2UFFnZTBRbVJnVHJPOXlBRjZ3NHNCQnc4cDk1OUZS?=
 =?utf-8?B?b2dzQnVRYmZaTlhXTldqaGE5WHpkcXhvem0wQWRzZVVod0xHbGI4V0g2b3Fh?=
 =?utf-8?B?aXpoTysrcjZVcWx6TCtvU1hZcWNMWW5uVytuM0JCVmFPTzZxVFlNWmZDTEFS?=
 =?utf-8?B?dGZ4VENoQWpJY2sraDBUTzY3QnVzYXloNm5sTGI3Qkx4N3ZuWVo5SEVCdXFV?=
 =?utf-8?B?dmV0NUtQMmp2Mk5GMTNadW9VMGNwZS9NQ2hRV1k5dFpxTHcvZDEwcXNuRVI5?=
 =?utf-8?B?bld4a2c2WFdIUnhWcmtPd09Yay9UL1ZXclhGN256ajZrV3pUbGk5YmgrTzVE?=
 =?utf-8?B?aXpUOGdDVUg3M1hoaExhOWhCK3lGV2ptaDdwbFh2VGpIL2pGSjJyS3gzaEsr?=
 =?utf-8?B?emRoSjZvRnlqS3hGVm12N3BNVnc2TnY0S0RKRURraEhrSFZ5blpYcTVaOXdJ?=
 =?utf-8?B?bDVvZ0hJR1YzeGJIWmphMkFZZEJWenUrSWRidzExTkdranFuS09DbzdYVTEr?=
 =?utf-8?B?akRVQ1oxZHplaEQyMyt5T05aYi93UXl2QThnVmNWZWR4c3hDVmxYdEF1TThu?=
 =?utf-8?B?cklyeGVlRkFxOGxWSUZpdzdFQXdkWkQ1ekRnWldwaE52WFFVdFNYNEFadkQ3?=
 =?utf-8?B?RGgvM2pONEsrT1BDMHdsOVk3V2R4WFZLeWk4eWhWSk9RYXRrbUt3RlVvcjd6?=
 =?utf-8?B?R1FrN2laaXl1VW00SGh1WWl0NEZHOS96VFNoZjZWRnpPajJrNnNBUnhsdk9V?=
 =?utf-8?B?UHQrLzg0TlhUVXZDbTFGV2Z4cHBOaUtzMWhpdXkzbVE2RllXUktsOWl1OWhH?=
 =?utf-8?Q?O/rAMylHuTAEoHWME4UOlIt3n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e46d7f8-95a1-43b4-ab5e-08da8bee2dac
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 07:47:11.3301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uf0HmlRAio7B1t1ZrPjLhQVBm0H/97h+pRNX+q/ypQEEyT+GZrbM4JEDfPR+jfau
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7068
Cc: linux-rdma@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com,
 linux-media@vger.kernel.org
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
From: =?UTF-8?Q?Christian_K=c3=b6nig?= via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

QW0gMzEuMDguMjIgdW0gMTc6Mzcgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gVGhlIGludGVy
bmFsIGRtYS1idWYgbG9jayBpc24ndCBuZWVkZWQgYW55bW9yZSBiZWNhdXNlIHRoZSB1cGRhdGVk
Cj4gbG9ja2luZyBzcGVjaWZpY2F0aW9uIGNsYWltcyB0aGF0IGRtYS1idWYgcmVzZXJ2YXRpb24g
bXVzdCBiZSBsb2NrZWQKPiBieSBpbXBvcnRlcnMsIGFuZCB0aHVzLCB0aGUgaW50ZXJuYWwgZGF0
YSBpcyBhbHJlYWR5IHByb3RlY3RlZCBieSB0aGUKPiByZXNlcnZhdGlvbiBsb2NrLiBSZW1vdmUg
dGhlIG9ic29sZXRlZCBpbnRlcm5hbCBsb2NrLgo+Cj4gQWNrZWQtYnk6IENocmlzdGlhbiBLw7Zu
aWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgT3Np
cGVua28gPGRtaXRyeS5vc2lwZW5rb0Bjb2xsYWJvcmEuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJz
L2RtYS1idWYvZG1hLWJ1Zi5jIHwgMTQgKysrKy0tLS0tLS0tLS0KPiAgIGluY2x1ZGUvbGludXgv
ZG1hLWJ1Zi5oICAgfCAgOSAtLS0tLS0tLS0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspLCAxOSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS1idWYv
ZG1hLWJ1Zi5jIGIvZHJpdmVycy9kbWEtYnVmL2RtYS1idWYuYwo+IGluZGV4IDk3Y2U4ODRmYWQ3
Ni4uNzcyZmRkOWVlZWQ4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMK
PiArKysgYi9kcml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jCj4gQEAgLTY1Niw3ICs2NTYsNiBAQCBz
dHJ1Y3QgZG1hX2J1ZiAqZG1hX2J1Zl9leHBvcnQoY29uc3Qgc3RydWN0IGRtYV9idWZfZXhwb3J0
X2luZm8gKmV4cF9pbmZvKQo+ICAgCj4gICAJZG1hYnVmLT5maWxlID0gZmlsZTsKPiAgIAo+IC0J
bXV0ZXhfaW5pdCgmZG1hYnVmLT5sb2NrKTsKPiAgIAlJTklUX0xJU1RfSEVBRCgmZG1hYnVmLT5h
dHRhY2htZW50cyk7Cj4gICAKPiAgIAltdXRleF9sb2NrKCZkYl9saXN0LmxvY2spOwo+IEBAIC0x
NTAyLDcgKzE1MDEsNyBAQCBFWFBPUlRfU1lNQk9MX05TX0dQTChkbWFfYnVmX21tYXAsIERNQV9C
VUYpOwo+ICAgaW50IGRtYV9idWZfdm1hcChzdHJ1Y3QgZG1hX2J1ZiAqZG1hYnVmLCBzdHJ1Y3Qg
aW9zeXNfbWFwICptYXApCj4gICB7Cj4gICAJc3RydWN0IGlvc3lzX21hcCBwdHI7Cj4gLQlpbnQg
cmV0ID0gMDsKPiArCWludCByZXQ7Cj4gICAKPiAgIAlpb3N5c19tYXBfY2xlYXIobWFwKTsKPiAg
IAo+IEBAIC0xNTE0LDI4ICsxNTEzLDI1IEBAIGludCBkbWFfYnVmX3ZtYXAoc3RydWN0IGRtYV9i
dWYgKmRtYWJ1Ziwgc3RydWN0IGlvc3lzX21hcCAqbWFwKQo+ICAgCWlmICghZG1hYnVmLT5vcHMt
PnZtYXApCj4gICAJCXJldHVybiAtRUlOVkFMOwo+ICAgCj4gLQltdXRleF9sb2NrKCZkbWFidWYt
PmxvY2spOwo+ICAgCWlmIChkbWFidWYtPnZtYXBwaW5nX2NvdW50ZXIpIHsKPiAgIAkJZG1hYnVm
LT52bWFwcGluZ19jb3VudGVyKys7Cj4gICAJCUJVR19PTihpb3N5c19tYXBfaXNfbnVsbCgmZG1h
YnVmLT52bWFwX3B0cikpOwo+ICAgCQkqbWFwID0gZG1hYnVmLT52bWFwX3B0cjsKPiAtCQlnb3Rv
IG91dF91bmxvY2s7Cj4gKwkJcmV0dXJuIDA7Cj4gICAJfQo+ICAgCj4gICAJQlVHX09OKGlvc3lz
X21hcF9pc19zZXQoJmRtYWJ1Zi0+dm1hcF9wdHIpKTsKPiAgIAo+ICAgCXJldCA9IGRtYWJ1Zi0+
b3BzLT52bWFwKGRtYWJ1ZiwgJnB0cik7Cj4gICAJaWYgKFdBUk5fT05fT05DRShyZXQpKQo+IC0J
CWdvdG8gb3V0X3VubG9jazsKPiArCQlyZXR1cm4gcmV0Owo+ICAgCj4gICAJZG1hYnVmLT52bWFw
X3B0ciA9IHB0cjsKPiAgIAlkbWFidWYtPnZtYXBwaW5nX2NvdW50ZXIgPSAxOwo+ICAgCj4gICAJ
Km1hcCA9IGRtYWJ1Zi0+dm1hcF9wdHI7Cj4gICAKPiAtb3V0X3VubG9jazoKPiAtCW11dGV4X3Vu
bG9jaygmZG1hYnVmLT5sb2NrKTsKPiAtCXJldHVybiByZXQ7Cj4gKwlyZXR1cm4gMDsKPiAgIH0K
PiAgIEVYUE9SVF9TWU1CT0xfTlNfR1BMKGRtYV9idWZfdm1hcCwgRE1BX0JVRik7Cj4gICAKPiBA
QCAtMTU3NywxMyArMTU3MywxMSBAQCB2b2lkIGRtYV9idWZfdnVubWFwKHN0cnVjdCBkbWFfYnVm
ICpkbWFidWYsIHN0cnVjdCBpb3N5c19tYXAgKm1hcCkKPiAgIAlCVUdfT04oZG1hYnVmLT52bWFw
cGluZ19jb3VudGVyID09IDApOwo+ICAgCUJVR19PTighaW9zeXNfbWFwX2lzX2VxdWFsKCZkbWFi
dWYtPnZtYXBfcHRyLCBtYXApKTsKPiAgIAo+IC0JbXV0ZXhfbG9jaygmZG1hYnVmLT5sb2NrKTsK
PiAgIAlpZiAoLS1kbWFidWYtPnZtYXBwaW5nX2NvdW50ZXIgPT0gMCkgewo+ICAgCQlpZiAoZG1h
YnVmLT5vcHMtPnZ1bm1hcCkKPiAgIAkJCWRtYWJ1Zi0+b3BzLT52dW5tYXAoZG1hYnVmLCBtYXAp
Owo+ICAgCQlpb3N5c19tYXBfY2xlYXIoJmRtYWJ1Zi0+dm1hcF9wdHIpOwo+ICAgCX0KPiAtCW11
dGV4X3VubG9jaygmZG1hYnVmLT5sb2NrKTsKPiAgIH0KPiAgIEVYUE9SVF9TWU1CT0xfTlNfR1BM
KGRtYV9idWZfdnVubWFwLCBETUFfQlVGKTsKPiAgIAo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L2RtYS1idWYuaCBiL2luY2x1ZGUvbGludXgvZG1hLWJ1Zi5oCj4gaW5kZXggZjExYjViYmMy
ZjM3Li42ZmE4ZDRlMjk3MTkgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC9kbWEtYnVmLmgK
PiArKysgYi9pbmNsdWRlL2xpbnV4L2RtYS1idWYuaAo+IEBAIC0zMjYsMTUgKzMyNiw2IEBAIHN0
cnVjdCBkbWFfYnVmIHsKPiAgIAkvKiogQG9wczogZG1hX2J1Zl9vcHMgYXNzb2NpYXRlZCB3aXRo
IHRoaXMgYnVmZmVyIG9iamVjdC4gKi8KPiAgIAljb25zdCBzdHJ1Y3QgZG1hX2J1Zl9vcHMgKm9w
czsKPiAgIAo+IC0JLyoqCj4gLQkgKiBAbG9jazoKPiAtCSAqCj4gLQkgKiBVc2VkIGludGVybmFs
bHkgdG8gc2VyaWFsaXplIGxpc3QgbWFuaXB1bGF0aW9uLCBhdHRhY2gvZGV0YWNoIGFuZAo+IC0J
ICogdm1hcC91bm1hcC4gTm90ZSB0aGF0IGluIG1hbnkgY2FzZXMgdGhpcyBpcyBzdXBlcnNlZWRl
ZCBieQo+IC0JICogZG1hX3Jlc3ZfbG9jaygpIG9uIEByZXN2Lgo+IC0JICovCj4gLQlzdHJ1Y3Qg
bXV0ZXggbG9jazsKPiAtCj4gICAJLyoqCj4gICAJICogQHZtYXBwaW5nX2NvdW50ZXI6Cj4gICAJ
ICoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==

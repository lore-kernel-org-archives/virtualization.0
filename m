Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAECC433EF
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 15:21:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D19E610A0
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 15:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4D19E610A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 047B281AF5;
	Wed, 27 Oct 2021 15:21:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RjP516YzouzL; Wed, 27 Oct 2021 15:21:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AB4FC81ADE;
	Wed, 27 Oct 2021 15:21:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 846FCC0012;
	Wed, 27 Oct 2021 15:21:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA474C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 15:21:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8CD8F40542
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 15:21:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3VCTdVcg4F5l
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 15:21:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75A0440540
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 15:21:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E05R0H+E2kalw3Mo/9BaHuOxUoyRk9fquIA6rKEH/xpkN9JwcHmqo7/7izD37z82oZF5FEVBcWKygjjXAL54GVtV7WesJtF4yh4mY+ZTnRRe75brXpv/T1h6lO664fb46MRtiuZDSenwefMha3C2d8209gXlsxjkFA+ABU9+wWhjCgrd0TOra+GEpM/SoA2caoluL2DFhI3aUh21uNOBn3uKFsWikJVmFMq0VZ6H2JiJ5hm2b/AqFFcNGlly73bm9H2BHOn94nF6SFyf/AHYun+l4gdjCSseD5ww2zBU8cZoRRDPeRMMshFH0uXS386cvfobk47PZe911V40r9LvLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKTwF9LeXE2nTudCE8CseEaxoD78gxmYNT8APGNGhs0=;
 b=V+/c6fh6xUV0N4RhshXe57VWcRPsw4/+zMrPfhzjbvPgvnT6QckfrLcVEnEebk76SFuhxNUHs2FbZ2zpozRsjaWR+EDvNH7/tW4lD45KHOhpOaqkwzr6gVQZhXLinXjM18Qhdfyu5uU1KjxY22+dc/X7t5gmuroTiRdHJv8+PoSL269IL0J2DjH/qQl3RqkGcrXhNXlJfHW1BD9to9iRjpmic5rbOJd0AjXph/bs2TPR2B6BlbubTgm3rsiyVwPeCJqlIAkzbwL+yXPDGRFAECyLiGJpRv3+23yt9bUV/s0THNEd3sCclTnY6jGiFXgWXE2cfgvI7JcsX/Sbvxwq8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKTwF9LeXE2nTudCE8CseEaxoD78gxmYNT8APGNGhs0=;
 b=rmnyaR39neS09V00yiOPsAYj0qT0pCoWQK2fxIzGxU7HDNetOtgzpk0vw4l6wgq7FzcnNc81QJuiDlcJtGAyrfTNNdJUWF1EelUI1leUIzfQkH+b9Aa4BRCieFWSF412hZK1AGeYDU5QSvwQxESjJpnuV7dGsiaA6F17dyk+XFE8KUUPwo+tXRRpv6/WU9W0Q7fIYQbZszxmPoNa8kroJE5KLb608sBUn2dXHSZ6DuMyhiwsG6/Nz2E9i12SuzTicS+RelkpiAc9aJAGo6rBAQSZzcaxbnMyYa0eno8fgxTESgJ6l6UdAjl8yWrtfj50T4teRdRXQJAh+5Exm2XwBg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 15:21:16 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633%3]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 15:21:16 +0000
To: Stefano Garzarella <sgarzare@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Michael Tsirkin <mst@redhat.com>
Subject: RE: vDPA bus driver selection
Thread-Topic: vDPA bus driver selection
Thread-Index: AQHXyz+5W8bHEdMi9Ue0cOjhXwdA36vm745A
Date: Wed, 27 Oct 2021 15:21:15 +0000
Message-ID: <PH0PR12MB548115FD6354339B41A11CE3DC859@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <CAGxU2F7r7=P8E-f1Nnm2h18S-hL8YBt7s=J81fkQcrAdpZ-KwQ@mail.gmail.com>
In-Reply-To: <CAGxU2F7r7=P8E-f1Nnm2h18S-hL8YBt7s=J81fkQcrAdpZ-KwQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ae55a44-212a-40dc-d820-08d9995d6b49
x-ms-traffictypediagnostic: PH0PR12MB5404:
x-microsoft-antispam-prvs: <PH0PR12MB54049D92842286255FFD742FDC859@PH0PR12MB5404.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DL7HGSZ1LKdWm67FicLi91dQ0whjL+ls2wDGL5Brsf4e24kvRHTh0s6CkqpSnhETfNGem7oaHZ4qQVrLbJUeSaJ0vEnPD24aCEhJ/GynJ/6Cl4nI/rc4rMD3ktuS/mYh2HT/t4nOPuoEEEoB3/vtBfDeRTq1Z6I/CvSZ+CR3goSuwVITL+QhKsk789TSzR6YYjBzj6Ogi1msGy8RBeWtGo3rIlLPPnTZbkfcRBvnG3Z4LdZBiMm4CQrTGFFWhtd8n895csActLb//JeZCNVhYZ7J2ola7KsRbYKkYjlSCGZzbu9OrYngCrE9fRhg92TfMMU4PGHm0snY5Z1bIKNgDsyuPJ4hHaxUKk29IoK6v6cvahoEzNwPn59ypy+1IPRewKfGyWag+YSV0yeHGl7Z6PzYBoJlU/5TWRTY8EPMJWbOfts6b5YNcNyqNjm7LywYIwEKjk1s40yt809PRU9QcvQNKaa0lGn+F6HaB9kftuSN/tx3J95fPYlxMubvvvlQsFfrX6ALDVyscypKFR2xTLMYPVJ4zXd0gLq/PPHgwckOaAnl5KAFm9RhEzAbt+P6IbZkHqFpLgFy1Rwyg1ehR0Hh3QsMpGmfsVYe7zgO76fZcpV+6M0lAY1YbVyvjiD4HYxSXg7qboffmzWe1KHT+AcDATHY1YNAal8/+nFcCV+wFrt68jcA4DsKTMiXRrgopxp8GtLNA4thn3lrClvBVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(3480700007)(9686003)(38100700002)(55016002)(8676002)(33656002)(26005)(122000001)(110136005)(52536014)(54906003)(316002)(4326008)(7696005)(186003)(5660300002)(107886003)(71200400001)(66446008)(83380400001)(66946007)(86362001)(38070700005)(64756008)(2906002)(66556008)(76116006)(66476007)(8936002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODY5Unpkb1I4RHNxUnF6czlWWmtpcDJmWkFJVDc0bzhZdXNEMEtkaXI4cEhs?=
 =?utf-8?B?cWpEMWRRaFo5dkV5RkdlK2J5V2F0N1NVZGhEZjVxWHovbW9oaFl4QWlQTzNr?=
 =?utf-8?B?REtZZlFwK3BuaVVNN24zWVZxK1VmVGtZeHo1YnZEdUJ1dWpMOEdrRTNjaFpI?=
 =?utf-8?B?NVhsb201a2RPWkowWjJtNHF6ZjdVbmNKOGgvRUhicjBLenF5OUpTRXVMdnA4?=
 =?utf-8?B?WlU4Zy9aak5jMlJUN05hdEpkMDhvazIzRmxkbDkyZEZGVWlodlNaMmRkTk10?=
 =?utf-8?B?S2NwQXMvUTFqQVVvNXA2NFRMMEJyd25DaCtUVUN1WllxOXF1V3hTVzg0K1pv?=
 =?utf-8?B?dEF3T01LMXlrci9aK042Uzk0di93cE9oMTV5NUxSSlVlVXFBUVROdzZHckRB?=
 =?utf-8?B?OG5LR0VObENpeEhGZExIVTVER0JSbTNnUld0OURPQXBYaDl5b3BGa2tXZTc3?=
 =?utf-8?B?c3dZVUxIZ0xDYUJxSFRqSVB4blpUU0pDeGJzbG92czlJeFdJMmJ3TGszNVJ5?=
 =?utf-8?B?c3NLM0hRd2ExeUJOVXUwY250bFRzRG5wVVFJc1ljMjRNOFBGbS8wMndkSXBi?=
 =?utf-8?B?aWpWVUpKR0NzWFBBWlBWSkxUSS8zK3VnUkZzNmpSZlZpQ21NbTlxdzhXYUpX?=
 =?utf-8?B?bU5ZTWpIY0E4Q0xxMktISEhjL2U1SmtTcVBPcUxzU0JuNDdlcjMrbUZzRFQ5?=
 =?utf-8?B?V05uQlVlV0NJL2lJOVcwTUtlS2p0QUFTQUhCa1VyK2ZENlVqdWVETTBna0hw?=
 =?utf-8?B?ZmQwYllqNlpwSE5aTTJpdXhsUUZvajRHa0RtU2NlL0FUeUNjZ2d2dzBxeHls?=
 =?utf-8?B?dURyTWpVMDRGb09WWFlPQVcra1pLeW16bEpGV1lyZDlqR0Q3TVdtMDZoa3Iy?=
 =?utf-8?B?VnUyWGpmN05yRzhCZFBRelNRaDF1UjRYNm43OFZTRVhab3RuK3d4UnBkbWhD?=
 =?utf-8?B?MDFMRmlpYjdkQUdLZXI2MHhLUTMvQ29NWmgyTE85LzAxN1ZqdVk5OXFIZFV3?=
 =?utf-8?B?amJjN0hCWHA5TkE4dU54Y1E1WGJ1RHRwS2ZFdGdDZ01ad2dYWHdRWGFlWlU5?=
 =?utf-8?B?SDF2VWN4bEk3TG9rZ1dYVW1FMGdzdlpPalhPeUNwVDlsMzZJMnJ2aStoYTdn?=
 =?utf-8?B?am5SeG9YUGRkc0hkVEppejM2eEVyaFh1ZW5JeEhmc1JTWFhtOWU3Tm1KMnRH?=
 =?utf-8?B?WXVCMWNPL1dqSE5NY0NCNG5KMDRaWTNBd0FPVUZEZFhjTURuWWlNN2pqZEF2?=
 =?utf-8?B?S3ZxREEvaE8wQWJzMGZYaE94ZWU0eDVzZkFHVGQyNmtNcmNrUi9mYjY5WVF6?=
 =?utf-8?B?OVlkenB3NFh2dlo0cC9GVHBaS3dQbVIyY1Q1T2FmR3lPMTBkTXgrYjE3VGVL?=
 =?utf-8?B?dHFvRTBYK2hDSjdRVmNyaUQ2MlZyYnZxcS8wb1BjMmhkUzliZlFIajJEcnRX?=
 =?utf-8?B?d0RzcjhWVmJ4U28zN29zc1RyWTd2azBualM4T1pCaGRySFRqMXNPNTBUMlE3?=
 =?utf-8?B?YnpMa2M2MkozYjlFdmdETlozZWdYeVVCWi9Uc1A2eHRJTlZPZmtCUFZ4b3dq?=
 =?utf-8?B?VFN4VlNRbGlJWmNuaDF6YkJIQ0ZCR1ExZDdaWk9QbkFZOFA2dzhma3QxbExw?=
 =?utf-8?B?Qk1SMi9ITWJseCtKSTYyNVhVcy9KQ3loMHM2NlpXOVUvVmY0aERVZW01ejlO?=
 =?utf-8?B?Mk82WWFjOTRXNU96RXo3WDg2T1l1Nm54bTZxZ3U0V2RqRmFvZzlvYSt2a3h6?=
 =?utf-8?B?S0dGVWpKSXUweDZyYkRqQ2pUY2FSZUJZK1pPNm5nZGZQbm9NM3FZNjhxdzBp?=
 =?utf-8?B?UTlPVGQzaGZqMVZ3c01WOW5TYUFoWmpHN3pqZnVCVjFiZWM4OEpjSVR0ZzRU?=
 =?utf-8?B?SXNSQ29PTldsc2RpSXMvaWpOV0M3bSt1Ymw3VzJWVk9OWlB2VlN0TXlvdmF4?=
 =?utf-8?B?c1JrQXFtejdjcUp1dlJPRzBST3FSTTZYeFp3VWxKY3ZTbHZ1T2gyTys0SVR2?=
 =?utf-8?B?YS8vb1lWWGh0Rmtkc3JYVHNCZmJGcGJnTXRYZTNPSTRVQXZSc0M0RC9COFY4?=
 =?utf-8?B?anlqOUc1eFJhNlJtZ3NzWWRncDJNSVdpNHN2dll2SzZVNktyTE92Q2tmT1FV?=
 =?utf-8?B?azZNQmZMR2E1SjJHb2FMNVRSalJmUHZrUlNkeU1mYlFCRWtPL0hBdW1JNit2?=
 =?utf-8?Q?H0KGLwjZrC7jJKLpR9g7y/4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae55a44-212a-40dc-d820-08d9995d6b49
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 15:21:15.8714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SuFVMFcTSuqHQzkt735rPyY8RhLcWzz9RID525ds02LQ/1mTjrhqdcBiz7x1VrbzF1qY1tecHakqwc51shbELw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5404
Cc: Eli Cohen <elic@nvidia.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Stefano,

> From: Stefano Garzarella <sgarzare@redhat.com>
> Sent: Wednesday, October 27, 2021 8:04 PM
> 
> Hi folks,
> I was trying to understand if we have a way to specify which vDPA bus driver
> (e.g. vhost-vdpa, virtio-vdpa) a device should use.
> IIUC we don't have it, and the first registered driver is used when a new device
> is registered.
> 
> I was thinking if it makes sense to extend the management API to specify which
> bus driver to use for a device. A use case could be for example a single host
> handling VMs and bare-metal containers, so we would have both virtio-vdpa
> and vhost-vdpa loaded and we want to attach some devices to VMs through
> vhost-vdpa and others to containers through virtio-vdpa.
> 
> What do you think?
> 
One option is, user keeps the drivers_autoprobe disabled for the vdpa bus using,

$ vdpa/vdpa dev add mgmtdev vdpasim_net name vdpa0 mac 00:11:22:33:44:55
$ echo 0 > /sys/bus/vdpa/drivers_autoprobe

And after vdpa device creation, it manually binds to the desired driver such as,

$ echo vdpa0 > /sys/bus/vdpa/drivers/virtio_vdpa/bind
Or
$ echo vdpa0 > /sys/bus/vdpa/drivers/vhost_vdpa/bind

In an case of VDUSE, it makes more sense to bind to the one of the above driver after user space has connected the use space backend to the kernel device.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

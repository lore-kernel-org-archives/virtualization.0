Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F462253A4
	for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742491878; cv=none; b=aZi+4RfZHaUTnsLNwFWVqV/xpF+s749GcCwyShrojWvkLTHl6XjIl0dt9KegnBBnCQ+k3/E7llljEi2rIVHshI1fHRlnLzle1q5jzmyypvwA98/bYPl5fbOoHANuEyZpk5T7ecybxXqwdMKeo75EL3Eg2imwoolBbsT488EhoGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742491878; c=relaxed/simple;
	bh=PBSfuBcn6T6xlKhkGWVOX/Axg3UmuOPns8NtdC8VO6s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AcSBLIVPGIbzhOM9DFmgBENGzsEAdMKOcr+mBeQA4XWPOL7GFXpuhYIH2dWBs5IHGh1sMhmOEcf5AjkGgGjJzzykCT5cMqQj/XUbW7Fj5BaYuPLHNGfx78gnHhefH0835l42XidQ7ev3hiwHFqG/8EV9BhHm4XwYUJwqlVc3J7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P8XPpg8n; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P8XPpg8n"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KDMvwc029949;
	Thu, 20 Mar 2025 17:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7QGyA9
	V6AuybZbxza4pFhzygW0JgI2L6F6IeSjRPY70=; b=P8XPpg8nhbyiYeMiSMpVdf
	SwR7EO1LUlaCpwMY6ZYh/DGnnO87pFTSxEnBplWa6yeRoRJqckSgS7rKk753ovp5
	OYGrpgayqsezkfRi4HEUDjDQIsSwX4cbgMjlIT7K+Itrh10k/qpEoIFZ8V2k0Ri8
	j51KUYiGaPycYOtDja070+Gov1bEi0Z4SwG6ebpeZW0AQ2JGMfOEH37I8zBi29Xs
	iXPWBIzjITMAggkLaXKFkYclYy9BLxkOz+vQEFmfaNe0XNYl0Z+utOpHQgnu7I6w
	9qAKaiRW/9aSYPZOtE3vsW0CMiNaBIGCNnRHBA+9AksAF5QCIyVs7Q0jjiwQbG1A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45gbd9m4ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 17:31:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52KFRrsn012341;
	Thu, 20 Mar 2025 17:31:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dmvp96s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 17:31:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52KHVAgc49938782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 17:31:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F241720040;
	Thu, 20 Mar 2025 17:31:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E5D52004B;
	Thu, 20 Mar 2025 17:31:09 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.ibm.com (unknown [9.171.57.148])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 20 Mar 2025 17:31:09 +0000 (GMT)
Message-ID: <9c2a3f5f1af9ec1fc5e389409d801110a40cbdf6.camel@linux.ibm.com>
Subject: Re: [PATCH] virtio: console: Make resize control event handling
 compliant with spec
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        mst@redhat.com, pasic@linux.ibm.com, amit@kernel.org,
        schnelle@linux.ibm.com
Date: Thu, 20 Mar 2025 18:31:08 +0100
In-Reply-To: <20250320172654.624657-1-maxbr@linux.ibm.com>
References: <20250320172654.624657-1-maxbr@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tBsJ92BQC_MNkoaotaGDVRaySiNF2elO
X-Proofpoint-GUID: tBsJ92BQC_MNkoaotaGDVRaySiNF2elO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503200111

On Thu, 2025-03-20 at 18:26 +0100, Maximilian Immanuel Brandtner wrote:
> According to section 5.3.6.2 of the virtio spec a control buffer with
> the event VIRITO_CONSOLE_RESIZE is followed by a
> virtio_console_resize
> struct containing 2 little endian 16bit integerts cols,rows. The
> kernel
> implementation assums native endianness (which results in mangled
> values
> on big endian architectures)(a seperate patch by Halil Pasic will
> deal with
> that issue) and swaps the ordering of columns and rows.
> This patch changes the ordering of rows and columns to columns then
> rows.
>=20
> Fixes: 8345adbf96fc1 ("virtio: console: Accept console size along
> with resize control message")
> Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
> Cc: stable@vger.kernel.org=C2=A0# v2.6.35+
> ---
> =C2=A0drivers/char/virtio_console.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/char/virtio_console.c
> b/drivers/char/virtio_console.c
> index 24442485e73e..9668e89873cf 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1579,8 +1579,8 @@ static void handle_control_message(struct
> virtio_device *vdev,
> =C2=A0		break;
> =C2=A0	case VIRTIO_CONSOLE_RESIZE: {
> =C2=A0		struct {
> -			__u16 rows;
> =C2=A0			__u16 cols;
> +			__u16 rows;
> =C2=A0		} size;
> =C2=A0
> =C2=A0		if (!is_console_port(port))

I forgot to run git format-patch with --subject-prefix=3D"PATCH v2".
Sorry about that


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3946D285CAA
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954708; cv=none; b=GF4Stzh3tt+hkqMajB7gIOPCqbL1wb6pS27/j3jVCgVsWayY++rt6Au/NQ3ZjnD6sQPFSYApL67DpQ69ohAFIb1OCGhCOd4qyUgmd8qog9UNK6CTngEBRLD/VhMlSBbth6SHPM3OWkApMJ0N3YCTPdfeRyaGoSIoQ4y2X3xzhoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954708; c=relaxed/simple;
	bh=YlvkPaMs0t1PmNbYOSO3YQJzT0UijzMZmPn5PdxCCis=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dWNl/Ho8+JywnupZzKD5NEWYIaOYjxr1e+HEGsVxFosFo3gcOIY2aCgVQU9VEiJ7UbEAG7+9AIXZ4hBwaVvDHr/b6ckyYEeP6SdglXIemQMzePfDfHZeO1QzzeziudqzepDhU9Zmmi5pYdHxZibNMP/6lF4otZ34cl4VtP4WvjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=THPst/pl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="THPst/pl"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FBg0Wh011065;
	Mon, 15 Sep 2025 16:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ktd1ZZ
	D5/H7RqBGfiUbU4dNdJWoPAfJYQDKU49aG/zU=; b=THPst/plqn8BPo4IZHzI+u
	chfD1pb/oyJkLnWVUH6C3ivNi+kqtWTj+013Sxy3awvRdn3wVdsJxbi2sVzwl+nB
	+AfBvBl+IgeRW3ZqiY3aIaS0ELpJZ89yqjwfFqTJAV4SYmT0lADuSCZWr8bIatUm
	hm+h1kRqlGhJEysSsAxnVuODI2bZD9yDIxatpYB+/qxT3lYWEVm7DLDUdVOAaRNc
	EZNHZkRaDcdPEQ8AXmjF00kq2uoUfGhgdshK2LW6UTCYrk/y+I6AgB0Z3pmlORi+
	D3He3MRT4BH877CTEeKIFpWd4rXObOGwDOEkVFphM311leif/5ES69RR8RkAOD0A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49509y42af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 16:44:57 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58FGTRio007332;
	Mon, 15 Sep 2025 16:44:57 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49509y42a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 16:44:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58FEN9kZ029817;
	Mon, 15 Sep 2025 16:44:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kb0qkqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 16:44:55 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58FGirKD29229590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 16:44:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBD472004E;
	Mon, 15 Sep 2025 16:44:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 903A820040;
	Mon, 15 Sep 2025 16:44:51 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.ibm.com (unknown [9.61.163.204])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Sep 2025 16:44:51 +0000 (GMT)
Message-ID: <32bc2a49fabd619ea7dcafd7f5d50fca206b38ac.camel@linux.ibm.com>
Subject: Re: [PATCH] Revert "virtio_console: fix order of fields cols and
 rows"
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Filip Hejsek <filip.hejsek@gmail.com>, Amit Shah <amit@kernel.org>,
        Arnd
 Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux.dev
Date: Mon, 15 Sep 2025 18:44:50 +0200
In-Reply-To: <7ebfa9a5ec3f07506b3d8f01cd4f2a35e2135679.1757666355.git.mst@redhat.com>
References: 
	<7ebfa9a5ec3f07506b3d8f01cd4f2a35e2135679.1757666355.git.mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyMCBTYWx0ZWRfX/LOWpyIdnOex
 AI2B5w7d0qfZa/C/r73MhGj4S/RR+85p2riKsMa5i8KN/ONstpeqHCHRvkdoRQ2DeU+nXuYDqk4
 jG98A4XBYPOgG2DWtJjcJqIWytAKG1PI0dh39xi2y2enRw7evIhahYC1aKMobDG/1+UhMYcaWNr
 mvvkQJPHn2LCpHjr8fbp2AmOVL5eotZPeUfskigi+7TEc9KTHk9ZXuF8wcwNJ1Dfqh95uRXrvl4
 7PGt9Dbn1IFpxUjl6luvr83ZBXji1TWhtVHU3HtW8Rc9MFbE44E8VTStt9THIX43JG6lhKhzV6l
 pAy6fvWGgP4ZqYaCcApYB6wMc8l/q0XcvD6AZ+fOf6hGTGOfo2XdkLYdJjz4xnmo1xhTkvnRtD4
 rJTAHmuQ
X-Authority-Analysis: v=2.4 cv=OPYn3TaB c=1 sm=1 tr=0 ts=68c84289 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=An3k0oS3jMOg4QUPsmwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WvH70v3tCZ5IqkNXzr-kDV0as1xZBBFp
X-Proofpoint-ORIG-GUID: dSZv335uWMmFkxbcDLTpCQYjLN49pRJG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_06,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130020

On Fri, 2025-09-12 at 04:40 -0400, Michael S. Tsirkin wrote:
> This reverts commit 5326ab737a47278dbd16ed3ee7380b26c7056ddd.
>=20
> The problem is that for a long time, the
> Linux kernel used a different field order from what was specified in
> the
> virtio spec. The kernel implementation was apparently merged around
> 2010,
> while the virtio spec came in 2014, so when a previous version of
> this
> patch series was being discussed here on this mailing list in 2020,
> it
> was decided that QEMU should match the Linux implementation, and
> ideally,
> the virtio spec should be changed.
>=20
> There are about 15 years' worth
> of kernel versions with the swapped field order, including the kernel
> currently shipped in Debian stable. The effects of the swapped
> dimensions
> can sometimes be quite annoying - e.g. if you have a terminal with
> 24 rows, this will be interpreted as 24 columns, and your shell may
> limit
> line editing to this small space, most of which will be taken by your
> prompt.
>=20
> NB: the command structures really should move to the UAPI header so
> it
> is easier to notice when a change is breaking the guest/host ABI.

As I already mentioned in the QEMU discussion, I proposed the fix,
because I was working on a similar implementation to bring resizing to
QEMU. Unfortunately, the patch-set was stuck in limbo for a while and
now that someone else has picked up the slack, I've descided that it's
better to contribute to the patch-set that is upstream instead of
sending a competing patch-set that does the same thing. Accordingly, I
no longer have any skin in the game of implementing resizing for virtio
console in QEMU as the other patch-set takes care of that task.

On a related note, during the initial discussion of this changing the
virtio spec was proposed as well (as can be read from the commit mgs),
however at the time on the viritio mailing list people were resistent
to the idea of changing the virtio spec to conform to the kernel
implementation.
I don't really care if this discrepancy is fixed one way or the other,
but it should most definitely be fixed.

Kind regards,
Max Brandtner

>=20
> Reported-by: Filip Hejsek <filip.hejsek@gmail.com>
> Fixes: 5326ab737a47 ("virtio_console: fix order of fields cols and
> rows")
> Cc: "Maximilian Immanuel Brandtner" <maxbr@linux.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> =C2=A0drivers/char/virtio_console.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/char/virtio_console.c
> b/drivers/char/virtio_console.c
> index 088182e54deb..216c5115637d 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1576,8 +1576,8 @@ static void handle_control_message(struct
> virtio_device *vdev,
> =C2=A0		break;
> =C2=A0	case VIRTIO_CONSOLE_RESIZE: {
> =C2=A0		struct {
> -			__virtio16 cols;
> =C2=A0			__virtio16 rows;
> +			__virtio16 cols;
> =C2=A0		} size;
> =C2=A0
> =C2=A0		if (!is_console_port(port))


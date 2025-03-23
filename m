Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F2E163
	for <virtualization@lists.linux.dev>; Sun, 23 Mar 2025 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742733623; cv=none; b=XhNg/8i2S+YQ6Vn8rXhJ5n/ksiIihij5B76X6e4OEwaPS5EFQ3QUfADspWz+cyFjcJXAKNheEFMq4Bfs/z5n69ArlVlod4BNXH9n+zh4+0id8m3GJSO+a5KhczU5pkUx1A83Tebzs7dV0dY04Vsdmpxt4zUcXwtgH6N1gOsIpuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742733623; c=relaxed/simple;
	bh=sDQQWolVVAwUj2FFoOe71h7C9U0e3SoNEYBkjX19iAg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cO+XwX4DHPnSlRODcysH4zDOT4sbXNiYZXpkOGqrIVKyAzEo5pMa9T22KSH0WJw1ob9Fs+hV6JVw/4opiFIMRXTYidHtbvD+8jMG0SYERqM5UVP3XlrUamWE+OR4yXVD3Bu6r0r0Ph+zNSasJQ7BcJMcvMQafbV1+VevnX42kiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FGhAMjat; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FGhAMjat"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52MJkAVw025743;
	Sun, 23 Mar 2025 12:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pZ1tpm
	pahgzLQ9BBWtucRBsw1sVzO382Pg9fhIj0QtA=; b=FGhAMjatEFKqF1+czsWk3n
	YhWHp2PCiIbqz5iH3gjvQ00ooM4IBZBQvATpnMg0dum6FGn8b+F5TtyHeTTc1Ld2
	2xUT5WW/B2xSj5uHKTW6YURDTzmdmeKa2a7My/S7QuFQSDnjeK8SFGVjCGinGKaD
	DqsVf9DpOKdMxR0KhOFdP+XDZtTWtFk8+jZN8OUdPmQdlaVZKXLPPoBeOPzojsLV
	zatvugCOIVMhdLo3hx0Uwhrgglfprt7Oge9RfucXdFMgDgAb/VYn5bwoOdxVY4FV
	PWuoUnYk7dwdcj86vUgyEvr3ImqlXhhPTcCjnReGrLVOn6eTcO22+TW9hl4Fd3tA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45j1cwtrcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Mar 2025 12:40:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52N855xj009692;
	Sun, 23 Mar 2025 12:40:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j9rk9kw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Mar 2025 12:40:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52NCeC1t27656912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Mar 2025 12:40:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 592D320040;
	Sun, 23 Mar 2025 12:40:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D83AC20043;
	Sun, 23 Mar 2025 12:40:11 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.20.112])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sun, 23 Mar 2025 12:40:11 +0000 (GMT)
Date: Sun, 23 Mar 2025 13:40:10 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        mst@redhat.com, amit@kernel.org, schnelle@linux.ibm.com,
        Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH] virtio: console: Make resize control event handling
 compliant with spec
Message-ID: <20250323134010.30ea007d.pasic@linux.ibm.com>
In-Reply-To: <20250320172654.624657-1-maxbr@linux.ibm.com>
References: <20250320172654.624657-1-maxbr@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z75Do0MsR9I3EyGhfGk7v9MGNMGITD84
X-Proofpoint-ORIG-GUID: z75Do0MsR9I3EyGhfGk7v9MGNMGITD84
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-23_06,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503230092

On Thu, 20 Mar 2025 18:26:54 +0100
Maximilian Immanuel Brandtner <maxbr@linux.ibm.com> wrote:

Let my try to do some nitpicking here. First on the subject. I would go
with something more specific like "fix order of fields cols and rows",
especially now that we have figured out the byte order handling is absent
as well.

> According to section 5.3.6.2 of the virtio spec a control buffer with

I would refrain form referencing section from the spec only by its
number without also telling which incarnation of the spec you mean. I
don't think those numbers are set in stone.

> the event VIRITO_CONSOLE_RESIZE is followed by a virtio_console_resize
> struct containing 2 little endian 16bit integerts cols,rows. 

s/integerts/integers/

I think technically it is still the same buffer. I would opt for struct
virtio_console_control is followed by struct virtio_console_resize. 

> The kernel
> implementation assums native endianness (which results in mangled
> values on big endian architectures)(a seperate patch by Halil Pasic
> will deal with that issue) and swaps the ordering of columns and rows.

I would simply omit the reference to the other patch. I understand that
you introduced this because your patch does not deliver everything that
the short description promises.

I didn't realize that addressing the byte order stuff would cause
a merge conflict, but it does. So maybe it would make sense to rebase
your fix on top of mine and send it as a series titled.
"Make resize control event handling compliant with spec". Just an idea.


> This patch changes the ordering of rows and columns to columns then
> rows.
> 
> Fixes: 8345adbf96fc1 ("virtio: console: Accept console size along with
> resize control message") Signed-off-by: Maximilian Immanuel Brandtner
> <maxbr@linux.ibm.com> Cc: stable@vger.kernel.org # v2.6.35+
> ---
>  drivers/char/virtio_console.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/virtio_console.c
> b/drivers/char/virtio_console.c index 24442485e73e..9668e89873cf 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1579,8 +1579,8 @@ static void handle_control_message(struct
> virtio_device *vdev, break;
>  	case VIRTIO_CONSOLE_RESIZE: {
>  		struct {
> -			__u16 rows;
>  			__u16 cols;
> +			__u16 rows;
>  		} size;
>  
>  		if (!is_console_port(port))


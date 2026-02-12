Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4AA2749E6
	for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 21:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770931333; cv=none; b=A7n8S23kfZNXmSS5fpFSFxNn/aU9P0GHLJqAau2izxe2Zh8BZtNX94twnEnthukGzOqRfzvWsiTOJzyWBhIcvxDSfJn6bpfbEpgMcv6XKUZY+Cg89OpO/xDVZ5vWk6MHb9qdjVx+m2lzZE/elu2wJWeui5qsW5XbNN+ZQfn+MBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770931333; c=relaxed/simple;
	bh=tnKhqaHrt/YHjDCTUT88krYBL9XB89h2wRCDDULlcLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/IXPHB3PiXfbdGyzwMAC6n7VhgJ1pSgLkLzZcvrIuaVVdPkgVDon/WOosRUBGMyx65Ni3irkKObsuVIO7FRUk4VPEEkKOuDW4ooakXIMD6cyouOqNQ8ej8Jwt4gP1qQcSBM2yW1O3164CU/QsiZPuzBr+9qGmh0BkN+KDLeUUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irBsvtyy; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irBsvtyy"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1271195d2a7so600649c88.0
        for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 13:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770931332; x=1771536132; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R1no2tHnWUokc2knFQltcsvUs2YRSdVUtSLFMCjUwtQ=;
        b=irBsvtyynQWPHZjsosnMn7e+HLsqFuLFu/ZeJgnLNk5c8eeX+ulAbNnD0gPk30N/l1
         qjZqtaz7PXPGsWpLjr9QJYadj7eLukTcHtufxU6CUv3Y7jQQEAofeFUGqYVasTYHZtY3
         4yTVDbxS8FzJy8xFcSDPmbp+VbCmY1osndCi2vhKiTJoPJ2LxKYPs5uSicCVAuTD+CK+
         i6VNKyhyxEEfdETrc1Yzq1Qa5SYkPWuG7SbiTlbYrPRQKxXnm0SIZ0QYxqjne+q/CLCG
         WhIQakNTB0Rj2RUxMZgxlvCSl/kvajnl7cQ+ppPlxUwalcBYMD3E3wUfiZ7MAfOvmj5B
         +jVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770931332; x=1771536132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1no2tHnWUokc2knFQltcsvUs2YRSdVUtSLFMCjUwtQ=;
        b=UosUdbqxuVyRoSPBU2Jk1BI/gyTRMrFLZTnqK38iOgi5h4vqP7I2N1+eScCQnyzmlt
         LYSAwuUPp/OuZWgbn9Q8yRAyN/1iumZwZ5BQRpIWQrfdK3V1tp0DtgLAnWXrrA15Ko4y
         +rGqc57UzRHjTjAR3RmJnWabJFtJCXezBzrjSgTyFqXL2WlA10lKZZQNYk4oXk7FbDx8
         xcACv9qTnpKH1gp+57byGNkD97Gmgc9hERZ0Lz+XzPirerRKTOxYW9hMwe1XM2kJxoHy
         rZgDmmS6WshB+MxRaMT+GKbKpaqtgP4FVGx3lPNXcJQYYrXjQruNa0hpnPjXgbbG4Ws3
         NxhA==
X-Forwarded-Encrypted: i=1; AJvYcCU1KIdpYGKGxOXl+pQt/2AClVDYcuFEUcqiCk+BE8if9C2f9zsgE4Df/EFiXKaWEtFnTsmbSFcemH+LSRKsSg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8uYx1ant7mlelzKD1RBWpmWSq6v/x3xkSA5ZjSoRw9LsrvZGU
	6le6YdciwsGPhlw4sv58zggcbvY9HO0lKeu1nPMnP3U0nqfYudJ3Gnhw
X-Gm-Gg: AZuq6aKc8n+q+dbIwfpSOKilmDBqnh+atDctpR0qjSdgOM0LeLi0rAWBhE/hjqprpuZ
	OZt6ywY8kTKmWRKHgQFXABkRrZUkQfqkg7g/0xm0obeRaNWsOpwzPfAqQ0jIbQFuU0yZXNm6H/l
	BvAfyX9NUkDFKKb8WY4CfFCpBY2cWruGNXFhygbSz+xHv4Hq46/o1MNk11hFXtG3GKyszL+/hyk
	EKzQq4DLnuvZfk2pcM8wo8GhHtbU+b6d+bKM7XJX+rroltlQyUG18o20Ov4V4WXux0DtTAvcQEm
	cKF3be2Vn52SlV1we7sB4kRWx/8WGobznf8KV5Nl/aPiz0HaWqaoDLB82xEsqBufyaKr6wttSxM
	mV0FHpDDJ49BDd8OCoSE4VZww/hBIThe9RoAzSq92E87nG82yflZEfKYNxX2zGEKdRZT/5Z09/I
	+yqpQwE7oDMGm7i0ituHx6Yq07ijsTtZ/y
X-Received: by 2002:a05:7022:4395:b0:11d:f440:b758 with SMTP id a92af1059eb24-12739829f69mr179121c88.25.1770931331418;
        Thu, 12 Feb 2026 13:22:11 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a6fe357sm5577294c88.16.2026.02.12.13.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 13:22:11 -0800 (PST)
Message-ID: <3bf72620-88ac-4c56-b3ec-0fcfa53c14c8@gmail.com>
Date: Thu, 12 Feb 2026 13:22:09 -0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] improve per-node allocation and reclaim visibility
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, apopple@nvidia.com, akpm@linux-foundation.org,
 axelrasmussen@google.com, byungchul@sk.com, cgroups@vger.kernel.org,
 david@kernel.org, eperezma@redhat.com, gourry@gourry.net,
 jasowang@redhat.com, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
 Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, matthew.brost@intel.com, mst@redhat.com,
 mhocko@suse.com, rppt@kernel.org, muchun.song@linux.dev,
 zhengqi.arch@bytedance.com, rakie.kim@sk.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, surenb@google.com, virtualization@lists.linux.dev,
 vbabka@suse.cz, weixugc@google.com, xuanzhuo@linux.alibaba.com,
 ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
 kernel-team@meta.com
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <aY1dusLPzP2AHP6f@casper.infradead.org>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <aY1dusLPzP2AHP6f@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/11/26 8:57 PM, Matthew Wilcox wrote:
> On Wed, Feb 11, 2026 at 08:51:07PM -0800, JP Kobryn wrote:
>> We sometimes find ourselves in situations where reclaim kicks in, yet there
> 
> who is we?  you haven't indicated any affiliation in your tags.

Meta. Is there a preferred way of indicating this?

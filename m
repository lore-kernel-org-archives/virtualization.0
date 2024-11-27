Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18621433C8
	for <virtualization@lists.linux.dev>; Wed, 27 Nov 2024 23:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732749670; cv=none; b=bDEwOvJ554BwNdmH55Sjue8k5cOcWnZCvBLGuSVGwalzmnXb4uxgFtmoG3MgdiDfHdEKD1QNwAlUA1pT9JABKOsXxMoiDeqqiWVjdqKh6YitThUH8rhh7iQtjukKUkZk67ZIyv4DnZZkOfOT5gnYbEUUtsgfZh6DwxVlgtVe7w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732749670; c=relaxed/simple;
	bh=+jPnjmSkIWnfw1ypNxPAHk3jExZky9QC/KYnqBebpVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsyhyawpUoZZtvho5VP2b1Hgtb8HSGmCiitZt8sgGioGDGUyKY8MLPaDKuTEie8rlZLSycZrb94e1uPfIGPSNEzcJQk6g/9a5Vwqgb0dQ9iXITopQCzSdFC7e2mcy9fD+c52HQfAz3h3QuWHByjVBxgZJgyPeGTGO0MrRmw0Q/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iy/BXCe+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iy/BXCe+"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725007836bdso48651b3a.1
        for <virtualization@lists.linux.dev>; Wed, 27 Nov 2024 15:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732749666; x=1733354466; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYut6aU/zn0xLVmf0unpLL5mLReSDppc7n+P3njEiRE=;
        b=iy/BXCe+j1X9BCj4+lIukrH1jNqVK7OkbglapUwkgvh180wSLjcwBLeZ9A5y5YS4yf
         YKmj8Dl86kLDnvB7Vcv/Veinli5NnPh5WOTB10MprW3HRubbrEWfSshe+df5ESdO73CH
         9e0LJh0/PyDA7H88Mqmlvy7tBWxpioKPlq/JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732749666; x=1733354466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYut6aU/zn0xLVmf0unpLL5mLReSDppc7n+P3njEiRE=;
        b=OL0bdFrT47mLx63ZjeYUHqvUZtg3EOMvi66TjRvo3gDDwGpUTnF5VCFrxGUE79EjkK
         kL+DIAe2tAUkbkDI4fP8DSyAAievlNejPg569fJEVwNOQ4UArmw3wYzH3CCmccTNcnhJ
         W7nPvghVqJHl4jyPPZGIsHKOMZDLL9cHmgLbfvVnJMvNrMXOKuFLFI4zuedHupXrhD0U
         P8eRVPhLJiSbKh9pA/Ti2iFfgAs7cWucOFtJ19coX001s29Z9HEaTsEepM1N586dZC39
         Auc/r4V+kZ8VjmfCzwSK+9JjqkS+ihTFY2LRnSDvsAjQjrfIYB6QU7RfJw7WF4RJXoMb
         Jb/A==
X-Forwarded-Encrypted: i=1; AJvYcCWKMcXkQqDxRWCMRTheVT7lz533eNOBj1FKvi/WzvtUyreHpIHHY9mcdvElo14iHmU4S07aZQRdaCVo4KDthQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxf2X/54Yw/Xq3gLR7Re3vdtWlZ0ZnuLfTOj6GG4RGYPiot1vCn
	8EEbc0q817OimdaiZxDSjJraFVwdac030RHkZwdp8aIGpjW4hgQ62cRLMZOANszyHbl3p1kl2YS
	rXQ==
X-Gm-Gg: ASbGncv4BDhgl4ZiindH12nH9PbX9Yn8s9wFRZFgH1UHFet74cMVfPTEnZwypBeu/2J
	JTG1dhIL4NQUlNhbh9kn4dqp7YKt3h9mmoLvnAaLQIz7SOW5o5a1kaV1sXBlCmkMr/0iAly9wCj
	e7YmfDgxIT53SifxIPntgZE2pPfw6aebXNxT2hkUKrhHfkHiOZ1OeQ0B2AQ06av+5fHrVOJpC3d
	0s1wEH3B99h6Rv8kl+PQaTScdtSvKapsghwkcfwGP3I2xWINyGYK+AtJsI3rha+JiDl955v9MQ6
	8RQgnTVokr8c/j2Bzw==
X-Google-Smtp-Source: AGHT+IGxH3xzerHU07CtSAuiDJDF456071kg/LlZo+dZ8Dn6yPZS9CL7RhCsaS+v8CMk+nXVvrNIlw==
X-Received: by 2002:a05:6a00:c84:b0:724:e149:3d55 with SMTP id d2e1a72fcca58-72530208a9amr2841626b3a.7.1732749666265;
        Wed, 27 Nov 2024 15:21:06 -0800 (PST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com. [209.85.215.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fbf47sm118451b3a.128.2024.11.27.15.21.05
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 15:21:05 -0800 (PST)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ee7e87f6e4so133989a12.2
        for <virtualization@lists.linux.dev>; Wed, 27 Nov 2024 15:21:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXeoZPq7LgFM7blwhZnYhHe5PXM9pHbNcqS3MDnR+q7zdTkyPkdzbkxEEyE3GnGx/UT7/VXpUYnhgWY38BFvA==@lists.linux.dev
X-Received: by 2002:a17:902:f382:b0:212:655c:caf with SMTP id
 d9443c01a7336-21501e5af92mr39560115ad.55.1732749318060; Wed, 27 Nov 2024
 15:15:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241127025728.3689245-1-yuanchu@google.com> <20241127025728.3689245-10-yuanchu@google.com>
In-Reply-To: <20241127025728.3689245-10-yuanchu@google.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Wed, 27 Nov 2024 15:14:52 -0800
X-Gmail-Original-Message-ID: <CABVzXAnbSeUezF_dqk2=6HGTCd09T4rd6AssP7-dbCgZSkZgiw@mail.gmail.com>
Message-ID: <CABVzXAnbSeUezF_dqk2=6HGTCd09T4rd6AssP7-dbCgZSkZgiw@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] virtio-balloon: add workingset reporting
To: Yuanchu Xie <yuanchu@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, 
	Henry Huang <henry.hj@antgroup.com>, Yu Zhao <yuzhao@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Gregory Price <gregory.price@memverge.com>, 
	Huang Ying <ying.huang@intel.com>, Lance Yang <ioworker0@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Daniel Watson <ozzloy@each.do>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 7:00=E2=80=AFPM Yuanchu Xie <yuanchu@google.com> wr=
ote:
[...]
> diff --git a/include/linux/workingset_report.h b/include/linux/workingset=
_report.h
> index f6bbde2a04c3..1074b89035e9 100644
> --- a/include/linux/workingset_report.h
> +++ b/include/linux/workingset_report.h
[...]
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/vir=
tio_balloon.h
> index ee35a372805d..668eaa39c85b 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -25,6 +25,7 @@
>   * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY=
 WAY
>   * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY O=
F
>   * SUCH DAMAGE. */
> +#include "linux/workingset_report.h"
>  #include <linux/types.h>
>  #include <linux/virtio_types.h>
>  #include <linux/virtio_ids.h>

This seems to be including a non-uapi header
(include/linux/workingset_report.h) from a uapi header
(include/uapi/linux/virtio_balloon.h), which won't compile outside the
kernel. Does anything in the uapi actually need declarations from
workingset_report.h?

> @@ -37,6 +38,7 @@
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT        3 /* VQ to report free pa=
ges */
>  #define VIRTIO_BALLOON_F_PAGE_POISON   4 /* Guest is using page poisonin=
g */
>  #define VIRTIO_BALLOON_F_REPORTING     5 /* Page reporting virtqueue */
> +#define VIRTIO_BALLOON_F_WS_REPORTING  6 /* Working Set Size reporting *=
/
>
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> @@ -128,4 +130,32 @@ struct virtio_balloon_stat {
>         __virtio64 val;
>  } __attribute__((packed));
>
> +/* Operations from the device */
> +#define VIRTIO_BALLOON_WS_OP_REQUEST 1
> +#define VIRTIO_BALLOON_WS_OP_CONFIG 2
> +
> +struct virtio_balloon_working_set_notify {
> +       /* REQUEST or CONFIG */
> +       __le16 op;
> +       __le16 node_id;
> +       /* the following fields valid iff op=3DCONFIG */
> +       __le32 report_threshold;
> +       __le32 refresh_interval;
> +       __le32 idle_age[WORKINGSET_REPORT_MAX_NR_BINS];
> +};
> +
> +struct virtio_balloon_working_set_report_bin {
> +       __le64 idle_age;
> +       /* bytes in this bucket for anon and file */
> +       __le64 anon_bytes;
> +       __le64 file_bytes;
> +};
> +
> +struct virtio_balloon_working_set_report {
> +       __le32 error;
> +       __le32 node_id;
> +       struct virtio_balloon_working_set_report_bin
> +               bins[WORKINGSET_REPORT_MAX_NR_BINS];
> +};
> +
>  #endif /* _LINUX_VIRTIO_BALLOON_H */

Have the spec changes been discussed in the virtio TC?

Thanks,
-- Daniel

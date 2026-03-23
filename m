Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F3B22A4F1
	for <virtualization@lists.linux.dev>; Mon, 23 Mar 2026 01:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774231145; cv=none; b=GoGN6Xk+Os8ogiVOAYa9xnMhFp6GhUSYBbFX14P+flhFEbcTRg3nzRO/wBpFb4oPieH3U4Un4RlFetMaLbczDMcCvMg1BN5LsvHo1mUXipZAHnGv3qoWmRdKFb0Znhn4hYqFEnJMhxZZeoUNytGsVx+CY8VPjh8kI7+6jUekxsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774231145; c=relaxed/simple;
	bh=zMG8kFAtT3OOjB1RuZEtshwFC7c3DR76jhK7imoYyuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+q3Pc57zwOxmcuhQK35HZ6TQGit8iK7vmrAEKYrLOMx3ZsXHE5ZanKWT9vafJLbewTeJejIVnmAo4bZ/Xqm32J5ErnKQzCZwLW1xEHSiZMQGcI/REUU5Kt5wc5DcxfARGYdvaz9NaufhYlbgcQIq/ZiTuHzpQS9NqIl+aUsJw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d6467da0265b11f1a21c59e7364eecb8-20260323
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:ed6d3d56-3705-465d-85f1-ecb091a5360a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:84d72b8fc7c3a34f5e3c30aaf6b61340,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d6467da0265b11f1a21c59e7364eecb8-20260323
X-User: liwang@kylinos.cn
Received: from [10.42.16.85] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1334524809; Mon, 23 Mar 2026 09:58:50 +0800
Message-ID: <a34e2926-02ca-4379-a362-81b9507726af@kylinos.cn>
Date: Mon, 23 Mar 2026 09:58:47 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtiofs: Verify that server properly follows FUSE
 protocol
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: German Maglione <gmaglione@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org
References: <20260319025609.10721-1-liwang@kylinos.cn>
 <CAJSP0QXErw8yDeCnOgK6jco1-yDpS5x73vQLMtrj7oy7JxNEFg@mail.gmail.com>
Content-Language: en-GB
From: Li Wang <liwang@kylinos.cn>
In-Reply-To: <CAJSP0QXErw8yDeCnOgK6jco1-yDpS5x73vQLMtrj7oy7JxNEFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Stefan,

On 20/03/2026 23:00, Stefan Hajnoczi wrote:
> On Wed, Mar 18, 2026 at 10:58 PM Li Wang <liwang@kylinos.cn> wrote:
>>
>> Verify that server properly follows FUSE protocol, by checking
>> oh.uniq and oh.len.
>>
>> Signed-off-by: Li Wang <liwang@kylinos.cn>
>> ---
>>  fs/fuse/virtio_fs.c | 27 ++++++++++++++++++++++++++-
>>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> Earlier patch series addressing this:
> - https://lore.kernel.org/all/20251028200311.40372-1-brajeshpatil11@gmail.com/
> - https://lore.kernel.org/all/20260216073158.75151-1-ytohnuki@amazon.com/
> 
> The second one was applied and I think your version conflicts with it.
> 
> Please take a look and let us know whether you want to drop your patch
> or send a v2 rebased on Miklos latest tree
> (https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git).
> 

Thanks for the review, and I will submit a V2 to address your feedback.

Thanks,
Li

> Thanks,
> Stefan
> 
>>
>> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
>> index 057e65b51b99..c30f6f58664c 100644
>> --- a/fs/fuse/virtio_fs.c
>> +++ b/fs/fuse/virtio_fs.c
>> @@ -768,10 +768,34 @@ static void virtio_fs_request_complete(struct fuse_req *req,
>>         struct folio *folio;
>>
>>         /*
>> -        * TODO verify that server properly follows FUSE protocol
>> +        * Verify that server properly follows FUSE protocol
>>          * (oh.uniq, oh.len)
>>          */
>>         args = req->args;
>> +       if (test_bit(FR_ISREPLY, &req->flags)) {
>> +               struct fuse_out_header *oh = &req->out.h;
>> +
>> +               if (unlikely(oh->unique != req->in.h.unique)) {
>> +                       pr_warn_ratelimited("virtio-fs: bad reply unique %llu (expected %llu)\n",
>> +                                           oh->unique, req->in.h.unique);
>> +                       oh->error = -EIO;
>> +                       oh->len = sizeof(*oh);
>> +                       goto out;
>> +               }
>> +               unsigned int num_out = args->out_numargs - args->out_pages;
>> +               unsigned int cap = sizeof(req->out.h);
>> +
>> +               cap += fuse_len_args(num_out, args->out_args);
>> +               if (args->out_pages)
>> +                       cap += args->out_args[args->out_numargs - 1].size;
>> +               if (unlikely(oh->len < sizeof(*oh) || oh->len > cap)) {
>> +                       pr_warn_ratelimited("virtio-fs: bad reply len %u (cap %u)\n",
>> +                                           oh->len, cap);
>> +                       oh->error = -EIO;
>> +                       oh->len = sizeof(*oh);
>> +                       goto out;
>> +               }
>> +       }
>>         copy_args_from_argbuf(args, req);
>>
>>         if (args->out_pages && args->page_zeroing) {
>> @@ -790,6 +814,7 @@ static void virtio_fs_request_complete(struct fuse_req *req,
>>                 }
>>         }
>>
>> +out:
>>         clear_bit(FR_SENT, &req->flags);
>>
>>         fuse_request_end(req);
>> --
>> 2.34.1
>>
>>


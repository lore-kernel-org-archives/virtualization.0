Return-Path: <SRS0=6mDK=MM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9544FC07E95
	for <virtualization@archiver.kernel.org>; Tue, 20 Jul 2021 05:54:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E051C6101B
	for <virtualization@archiver.kernel.org>; Tue, 20 Jul 2021 05:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E051C6101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A339402B3;
	Tue, 20 Jul 2021 05:54:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ueA3wU7XIR9B; Tue, 20 Jul 2021 05:54:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4E81E4027D;
	Tue, 20 Jul 2021 05:54:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28CF6C0010;
	Tue, 20 Jul 2021 05:54:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3ADFCC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 05:54:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1A02D4023A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 05:54:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id joM87SF2yo4z
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 05:54:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A449A400E5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 05:54:21 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R841e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=jefflexu@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0UgOhWzz_1626760458; 
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0UgOhWzz_1626760458) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 20 Jul 2021 13:54:18 +0800
Subject: Re: [PATCH v2 2/4] fuse: Make DAX mount option a tri-state
To: Vivek Goyal <vgoyal@redhat.com>
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
 <20210716104753.74377-3-jefflexu@linux.alibaba.com>
 <YPW+NgbMDnGQ2UPI@redhat.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <8ffadee4-701c-52db-31b3-fd27dc6422d6@linux.alibaba.com>
Date: Tue, 20 Jul 2021 13:54:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPW+NgbMDnGQ2UPI@redhat.com>
Content-Language: en-US
Cc: miklos@szeredi.hu, virtualization@lists.linux-foundation.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com, stefanha@redhat.com,
 linux-fsdevel@vger.kernel.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 7/20/21 2:02 AM, Vivek Goyal wrote:
> On Fri, Jul 16, 2021 at 06:47:51PM +0800, Jeffle Xu wrote:
>> We add 'always', 'never', and 'inode' (default). '-o dax' continues to
>> operate the same which is equivalent to 'always'.
>>
>> By the time this patch is applied, 'inode' mode is actually equal to
>> 'always' mode, before the per-file DAX flag is introduced in the
>> following patch.
>>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>> ---
>>  fs/fuse/dax.c       | 13 ++++++++++++-
>>  fs/fuse/fuse_i.h    | 11 +++++++++--
>>  fs/fuse/inode.c     |  2 +-
>>  fs/fuse/virtio_fs.c | 16 ++++++++++++++--
>>  4 files changed, 36 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
>> index c6f4e82e65f3..a478e824c2d0 100644
>> --- a/fs/fuse/dax.c
>> +++ b/fs/fuse/dax.c
>> @@ -70,6 +70,9 @@ struct fuse_inode_dax {
>>  };
>>  
>>  struct fuse_conn_dax {
>> +	/** dax mode: FUSE_DAX_MOUNT_* (always, never or per-file) **/
>> +	unsigned int mode;
> 
> Why "/**" ?

I copied this comment style from fuse in v4.19... Anyway, I will fix this.

> 
> How about make it something like "enum fuse_dax_mode mode" instead?
> 
> enum fuse_dax_mode dax_mode;

OK.

> 
>> +
>>  	/* DAX device */
>>  	struct dax_device *dev;
>>  
>> @@ -1288,7 +1291,8 @@ static int fuse_dax_mem_range_init(struct fuse_conn_dax *fcd)
>>  	return ret;
>>  }
>>  
>> -int fuse_dax_conn_alloc(struct fuse_conn *fc, struct dax_device *dax_dev)
>> +int fuse_dax_conn_alloc(struct fuse_conn *fc, unsigned int mode,
>> +			struct dax_device *dax_dev)
>>  {
>>  	struct fuse_conn_dax *fcd;
>>  	int err;
>> @@ -1301,6 +1305,7 @@ int fuse_dax_conn_alloc(struct fuse_conn *fc, struct dax_device *dax_dev)
>>  		return -ENOMEM;
>>  
>>  	spin_lock_init(&fcd->lock);
>> +	fcd->mode = mode;
>>  	fcd->dev = dax_dev;
>>  	err = fuse_dax_mem_range_init(fcd);
>>  	if (err) {
>> @@ -1339,10 +1344,16 @@ static const struct address_space_operations fuse_dax_file_aops  = {
>>  static bool fuse_should_enable_dax(struct inode *inode)
>>  {
>>  	struct fuse_conn *fc = get_fuse_conn(inode);
>> +	unsigned int mode;
>>  
>>  	if (!fc->dax)
>>  		return false;
>>  
>> +	mode = fc->dax->mode;
>> +
>> +	if (mode == FUSE_DAX_MOUNT_NEVER)
>> +		return false;
>> +
>>  	return true;
>>  }
>>  
>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>> index 07829ce78695..f29018323845 100644
>> --- a/fs/fuse/fuse_i.h
>> +++ b/fs/fuse/fuse_i.h
>> @@ -487,6 +487,12 @@ struct fuse_dev {
>>  	struct list_head entry;
>>  };
>>  
>> +enum {
> And this becomes.
> 
> enum fuse_dax_mode {
> };

OK.

> 
>> +	FUSE_DAX_MOUNT_INODE,
>> +	FUSE_DAX_MOUNT_ALWAYS,
>> +	FUSE_DAX_MOUNT_NEVER,
>> +};
> 
> How about getting rid of "MOUNT" and just do.
> 
> 	FUSE_DAX_INODE,
> 	FUSE_DAX_ALWAYS,
> 	FUSE_DAX_NEVER,

OK.

> 
>> +
>>  struct fuse_fs_context {
>>  	int fd;
>>  	unsigned int rootmode;
>> @@ -503,7 +509,7 @@ struct fuse_fs_context {
>>  	bool no_control:1;
>>  	bool no_force_umount:1;
>>  	bool legacy_opts_show:1;
>> -	bool dax:1;
>> +	unsigned int dax;
> 
> enum fuse_dax_mode dax_mode;

OK.

> 
>>  	unsigned int max_read;
>>  	unsigned int blksize;
>>  	const char *subtype;
>> @@ -1242,7 +1248,8 @@ ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to);
>>  ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from);
>>  int fuse_dax_mmap(struct file *file, struct vm_area_struct *vma);
>>  int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start, u64 dmap_end);
>> -int fuse_dax_conn_alloc(struct fuse_conn *fc, struct dax_device *dax_dev);
>> +int fuse_dax_conn_alloc(struct fuse_conn *fc, unsigned int mode,
> 						   ^^
> 						enum fuse_dax_mode dax_mode

OK.

>> +			struct dax_device *dax_dev);
>>  void fuse_dax_conn_free(struct fuse_conn *fc);
>>  bool fuse_dax_inode_alloc(struct super_block *sb, struct fuse_inode *fi);
>>  void fuse_dax_inode_init(struct inode *inode);
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index b9beb39a4a18..f6b46395edb2 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -1434,7 +1434,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>>  	sb->s_subtype = ctx->subtype;
>>  	ctx->subtype = NULL;
>>  	if (IS_ENABLED(CONFIG_FUSE_DAX)) {
>> -		err = fuse_dax_conn_alloc(fc, ctx->dax_dev);
>> +		err = fuse_dax_conn_alloc(fc, ctx->dax, ctx->dax_dev);
>>  		if (err)
>>  			goto err;
>>  	}
>> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
>> index 8f52cdaa8445..561f711d1945 100644
>> --- a/fs/fuse/virtio_fs.c
>> +++ b/fs/fuse/virtio_fs.c
>> @@ -88,12 +88,21 @@ struct virtio_fs_req_work {
>>  static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
>>  				 struct fuse_req *req, bool in_flight);
>>  
>> +static const struct constant_table dax_param_enums[] = {
>> +	{"inode",	FUSE_DAX_MOUNT_INODE },
>> +	{"always",	FUSE_DAX_MOUNT_ALWAYS },
>> +	{"never",	FUSE_DAX_MOUNT_NEVER },
>> +	{}
>> +};
>> +
>>  enum {
>>  	OPT_DAX,
>> +	OPT_DAX_ENUM,
>>  };
>>  
>>  static const struct fs_parameter_spec virtio_fs_parameters[] = {
>>  	fsparam_flag("dax", OPT_DAX),
>> +	fsparam_enum("dax", OPT_DAX_ENUM, dax_param_enums),
>>  	{}
>>  };
>>  
>> @@ -110,7 +119,10 @@ static int virtio_fs_parse_param(struct fs_context *fc,
>>  
>>  	switch (opt) {
>>  	case OPT_DAX:
>> -		ctx->dax = 1;
>> +		ctx->dax = FUSE_DAX_MOUNT_ALWAYS;
>> +		break;
>> +	case OPT_DAX_ENUM:
>> +		ctx->dax = result.uint_32;
> 
> Do we want to check here if result.uint_32 has one of the allowed values.
> FUSE_DAX_MOUNT_INODE, FUSE_DAX_MOUNT_ALWAYS or FUSE_DAX_MOUNT_NEVER. Or
> VFS has already taken care of that?

VFS will ensure that the returned result.uint_32 can only be among the
values defined in 'struct constant_table', or fs_parse() will return
-EINVAL.

-- 
Thanks,
Jeffle
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

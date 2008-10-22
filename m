From: Chen Zumeng <zumeng.chen@windriver.com>
Subject: Re: [PATCH 0/2] dm-ioband: I/O bandwidth controller v1.8.0:
	Introduction
Date: Wed, 22 Oct 2008 15:55:15 +0800
Message-ID: <48FEDC63.308__13356.7442688674$1224662448$gmane$org@windriver.com>
References: <20081017.160950.71109894.ryov@valinux.co.jp>
	<48FDB8AC.9020707@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48FDB8AC.9020707@windriver.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ryo Tsuruta <ryov@valinux.co.jp>
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, fernando@oss.ntt.co.jp, Bruce Ashfield <bruce.ashfield@windriver.com>, Haotian Zhang <haotian.zhang@windriver.com>
List-Id: virtualization@lists.linuxfoundation.org

Chen Zumeng wrote:
> Hi, Ryo Tsuruta
> 
> And our test team want to test bio_tracking as your benchmark reports,
> so would you please send me your test codes? Thanks in advance.
Hi Ryo Tsuruta,

I wonder if you received last email, so I reply this email to ask
for your bio_tracking test codes to generate your benchmark reports
as shown in your website. Thanks in advance :)

Regards,
Zumeng
> 
> Regards,
> Zumeng
> 
> P.S. The following are my changes to avoid schedule_timeout:
> 
> 
> diff --git a/drivers/md/dm-ioband-ctl.c b/drivers/md/dm-ioband-ctl.c
> index a792620..643ca4e 100644
> --- a/drivers/md/dm-ioband-ctl.c
> +++ b/drivers/md/dm-ioband-ctl.c
> @@ -100,6 +100,7 @@ static struct ioband_device 
> *alloc_ioband_device(char *name,
>                         return dp;
>                 }
>         }
> +       spin_unlock_irqrestore(&ioband_devicelist_lock, flags);
> 
>         /*
>          * Prepare its own workqueue as generic_make_request() may
> @@ -133,9 +134,11 @@ static struct ioband_device 
> *alloc_ioband_device(char *name,
>         init_waitqueue_head(&new->g_waitq);
>         init_waitqueue_head(&new->g_waitq_suspend);
>         init_waitqueue_head(&new->g_waitq_flush);
> -       list_add_tail(&new->g_list, &ioband_device_list);
> 
> +       spin_lock_irqsave(&ioband_devicelist_lock, flags);
> +       list_add_tail(&new->g_list, &ioband_device_list);
>         spin_unlock_irqrestore(&ioband_devicelist_lock, flags);
> +
>         return new;
>  }
> ---
> 
> Ryo Tsuruta wrote:
>> Hi Alasdair and all,
>>
>> This is the dm-ioband version 1.8.0 release.
>>
>> Dm-ioband is an I/O bandwidth controller implemented as a device-mapper
>> driver, which gives specified bandwidth to each job running on the same
>> physical device.
>>
>> This release is a minor bug fix and confirmed running on the latest
>> stable kernel 2.6.27.1.
>>
>> - Can be applied to the kernel 2.6.27.1 and 2.6.27-rc5-mm1.
>> - Changes from 1.7.0 (posted on Oct 3, 2008):
>>   - Fix a minor bug in io_limit setting that causes dm-ioband to stop
>>     issuing I/O requests when a large value is set to io_limit.
>>
>> Alasdair, could you please review this patch and give me any comments?
>>
>> Thanks,
>> Ryo Tsuruta
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
> 
> 

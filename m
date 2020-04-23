From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH RFC v2 02/24] scsi: allocate separate queue for reserved
 commands
Date: Thu, 23 Apr 2020 16:33:53 +0100
Message-ID: <17c47c8c-f993-b472-43ac-936cec560744@huawei.com>
References: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
 <1583857550-12049-3-git-send-email-john.garry@huawei.com>
 <20200310183243.GA14549@infradead.org>
 <79cf4341-f2a2-dcc9-be0d-2efc6e83028a@huawei.com>
 <20200311062228.GA13522@infradead.org>
 <b5a63725-722b-8ccd-3867-6db192a248a4@suse.de>
 <9c6ced82-b3f1-9724-b85e-d58827f1a4a4@huawei.com>
 <39bc2d82-2676-e329-5d32-8acb99b0a204@suse.de>
 <20200407163033.GA26568@infradead.org>
 <ae3b498b-aea8-dc09-53b8-9e160effc681@huawei.com>
 <a0316b0b-a24c-7d0c-df17-0573593e2a11@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a0316b0b-a24c-7d0c-df17-0573593e2a11@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com, ming.lei@redhat.com, bvanassche@acm.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org, esc.storagedev@microsemi.com, chenxiang66@hisilicon.com, Hannes Reinecke <hare@suse.com>
List-Id: virtualization@lists.linuxfoundation.org


>> Not sure if we want a static scsi_device per host, or alloc and free 
>> dynamically.
>>
>> (@Hannes, I also have some proper patches for libsas if you want to 
>> add it)
>>
> Hold your horses.

I wasn't going to do anything else...

> I'm currently preparing a patchset implementing things by improving the 
> current scsi_get_host_dev() etc.

OK, great, all you have to do is say.

> 
> RFC should be ready by the end of the week.
> 

Thanks,
John

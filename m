From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH RFC v2 22/24] scsi: drop scsi command list
Date: Tue, 10 Mar 2020 20:47:10 +0000
Message-ID: <2ffd671a-e580-cd5e-dd90-802f9641519f@huawei.com>
References: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
 <1583857550-12049-23-git-send-email-john.garry@huawei.com>
 <20200310183504.GB14549@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <20200310183504.GB14549@infradead.org>
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.de, ming.lei@redhat.com, bvanassche@acm.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org, esc.storagedev@microsemi.com, chenxiang66@hisilicon.com, Hannes Reinecke <hare@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

On 10/03/2020 18:35, Christoph Hellwig wrote:
> On Wed, Mar 11, 2020 at 12:25:48AM +0800, John Garry wrote:
>> From: Hannes Reinecke <hare@suse.com>
>>
>> No users left, kill it.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.com>
> 
> Wasn't this part of a series from Hannes that already got merged?


Ah, yes. I'll check what can be dropped now.

cheers

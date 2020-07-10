From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] scsi: virtio_scsi: Remove unnecessary condition checks
Date: Fri, 10 Jul 2020 09:46:54 +0200
Message-ID: <d052b441-cc4d-4b2b-1442-b1a30bed2fdb@redhat.com>
References: <a197f532-7020-0d8e-21bf-42bb66e8daec@web.de>
 <e87746e6-813e-7c0e-e21e-5921e759da5d@redhat.com>
 <8eb9a827-45f1-e71c-0cbf-1c29acd8e310@web.de>
 <58e3feb8-1ffb-f77f-cf3a-75222b3cd524@redhat.com>
 <9815ef2d-d0da-d197-49d7-83559d750ff1@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9815ef2d-d0da-d197-49d7-83559d750ff1@web.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>, Xianting Tian <xianting_tian@126.com>, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, "James E. J. Bottomley" <jejb@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 10/07/20 09:40, Markus Elfring wrote:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/virtio_scsi.c?id=42f82040ee66db13525dc6f14b8559890b2f4c1c#n980
>>>
>>>  	if (!virtscsi_cmd_cache) {
>>>  		pr_err("kmem_cache_create() for virtscsi_cmd_cache failed\n");
>>> -		goto error;
>>> +		return -ENOMEM;
>>>  	}
>>
>> Could be doable, but I don't see a particular benefit.
> 
> Can a bit more “compliance” (with the Linux coding style) matter here?

No.

>> Having a single error loop is an advantage by itself.
> 
> I do not see that a loop is involved in the implementation of the function “init”.

s/loop/label/ sorry.

Paolo

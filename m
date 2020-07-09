From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] scsi: virtio_scsi: Remove unnecessary condition checks
Date: Thu, 9 Jul 2020 19:25:47 +0200
Message-ID: <e87746e6-813e-7c0e-e21e-5921e759da5d@redhat.com>
References: <a197f532-7020-0d8e-21bf-42bb66e8daec@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a197f532-7020-0d8e-21bf-42bb66e8daec@web.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>, Xianting Tian <xianting_tian@126.com>, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, "James E. J. Bottomley" <jejb@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 09/07/20 19:16, Markus Elfring wrote:
>> +	mempool_destroy(virtscsi_cmd_pool);
>> +	virtscsi_cmd_pool = NULL;
>> +	kmem_cache_destroy(virtscsi_cmd_cache);
>> +	virtscsi_cmd_cache = NULL;
>>  	return ret;
>>  }
> 
> How do you think about to add a jump target so that the execution
> of a few statements can be avoided according to a previous
> null pointer check?

The point of the patch is precisely to simplify the code, executing a
couple more instruction is not an issue.

Paolo

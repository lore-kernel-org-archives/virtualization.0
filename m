From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] scsi: virtio_scsi: Remove unnecessary condition checks
Date: Fri, 10 Jul 2020 09:17:59 +0200
Message-ID: <58e3feb8-1ffb-f77f-cf3a-75222b3cd524@redhat.com>
References: <a197f532-7020-0d8e-21bf-42bb66e8daec@web.de>
 <e87746e6-813e-7c0e-e21e-5921e759da5d@redhat.com>
 <8eb9a827-45f1-e71c-0cbf-1c29acd8e310@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <8eb9a827-45f1-e71c-0cbf-1c29acd8e310@web.de>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>, Xianting Tian <xianting_tian@126.com>, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, "James E. J. Bottomley" <jejb@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 10/07/20 08:32, Markus Elfring wrote:
>>>> +	mempool_destroy(virtscsi_cmd_pool);
>>>> +	virtscsi_cmd_pool = NULL;
>>>> +	kmem_cache_destroy(virtscsi_cmd_cache);
>>>> +	virtscsi_cmd_cache = NULL;
>>>>  	return ret;
>>>>  }
>>>
>>> How do you think about to add a jump target so that the execution
>>> of a few statements can be avoided according to a previous
>>> null pointer check?
>>
>> The point of the patch is precisely to simplify the code,
> 
> I suggest to reconsider also Linux coding style aspects
> for the implementation of the function “init”.
> https://elixir.bootlin.com/linux/v5.8-rc4/source/drivers/scsi/virtio_scsi.c#L980
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/virtio_scsi.c?id=42f82040ee66db13525dc6f14b8559890b2f4c1c#n980
> 
>  	if (!virtscsi_cmd_cache) {
>  		pr_err("kmem_cache_create() for virtscsi_cmd_cache failed\n");
> -		goto error;
> +		return -ENOMEM;
> 	}

Could be doable, but I don't see a particular benefit.  Having a single
error loop is an advantage by itself.

The coding style is a suggestion.  Note the difference between

		kfree(foo->bar);
		kfree(foo);

and

		kfree(bar);
		kfree(foo);

> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=42f82040ee66db13525dc6f14b8559890b2f4c1c#n461
> 
> 
>> executing a couple more instruction is not an issue.
> 
> With which update steps would like to achieve such a code variant?
> 
> destroy_pool:
> 	mempool_destroy(virtscsi_cmd_pool);
> 	virtscsi_cmd_pool = NULL;
> destroy_cache:
> 	kmem_cache_destroy(virtscsi_cmd_cache);
> 	virtscsi_cmd_cache = NULL;
> 	return ret;

... while there's no advantage in this.

Paolo

From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] scsi: virtio_scsi: Remove unnecessary condition checks
Date: Thu, 9 Jul 2020 22:55:46 +0200
Message-ID: <072edd61-9b00-4c63-804f-e98bf271b683@web.de>
References: <a197f532-7020-0d8e-21bf-42bb66e8daec@web.de>
 <e87746e6-813e-7c0e-e21e-5921e759da5d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e87746e6-813e-7c0e-e21e-5921e759da5d@redhat.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Paolo Bonzini <pbonzini@redhat.com>, Xianting Tian <xianting_tian@126.com>, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, "James E. J. Bottomley" <jejb@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

>>> +	mempool_destroy(virtscsi_cmd_pool);
>>> +	virtscsi_cmd_pool =3D NULL;
>>> +	kmem_cache_destroy(virtscsi_cmd_cache);
>>> +	virtscsi_cmd_cache =3D NULL;
>>>  	return ret;
>>>  }
>>
>> How do you think about to add a jump target so that the execution
>> of a few statements can be avoided according to a previous
>> null pointer check?
>
> The point of the patch is precisely to simplify the code,

I propose another bit of fine-tuning there.


> executing a couple more instruction is not an issue.

Can an additional label help here besides a possible identifier renaming?

Regards,
Markus

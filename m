From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] scsi: virtio_scsi: Remove unnecessary condition checks
Date: Fri, 10 Jul 2020 09:40:12 +0200
Message-ID: <9815ef2d-d0da-d197-49d7-83559d750ff1@web.de>
References: <a197f532-7020-0d8e-21bf-42bb66e8daec@web.de>
 <e87746e6-813e-7c0e-e21e-5921e759da5d@redhat.com>
 <8eb9a827-45f1-e71c-0cbf-1c29acd8e310@web.de>
 <58e3feb8-1ffb-f77f-cf3a-75222b3cd524@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <58e3feb8-1ffb-f77f-cf3a-75222b3cd524@redhat.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Paolo Bonzini <pbonzini@redhat.com>, Xianting Tian <xianting_tian@126.com>, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, "James E. J. Bottomley" <jejb@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/scsi/virtio_scsi.c?id=3D42f82040ee66db13525dc6f14b8559890b2f4c1c#=
n980
>>
>>  	if (!virtscsi_cmd_cache) {
>>  		pr_err("kmem_cache_create() for virtscsi_cmd_cache failed\n");
>> -		goto error;
>> +		return -ENOMEM;
>>  	}
>
> Could be doable, but I don't see a particular benefit.

Can a bit more =E2=80=9Ccompliance=E2=80=9D (with the Linux coding style) =
matter here?


> Having a single error loop is an advantage by itself.

I do not see that a loop is involved in the implementation of the function=
 =E2=80=9Cinit=E2=80=9D.


>> destroy_pool:
>> 	mempool_destroy(virtscsi_cmd_pool);
>> 	virtscsi_cmd_pool =3D NULL;
>> destroy_cache:
>> 	kmem_cache_destroy(virtscsi_cmd_cache);
>> 	virtscsi_cmd_cache =3D NULL;
>> 	return ret;
>
> ... while there's no advantage in this.

I propose again to improve the affected exception handling another bit
by using appropriate labels.
Will further software improvements be achieved by a corresponding patch se=
ries?

Regards,
Markus

From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] scsi: virtio_scsi: Remove unnecessary condition checks
Date: Fri, 10 Jul 2020 08:32:33 +0200
Message-ID: <8eb9a827-45f1-e71c-0cbf-1c29acd8e310@web.de>
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

I suggest to reconsider also Linux coding style aspects
for the implementation of the function =E2=80=9Cinit=E2=80=9D.
https://elixir.bootlin.com/linux/v5.8-rc4/source/drivers/scsi/virtio_scsi.=
c#L980
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/scsi/virtio_scsi.c?id=3D42f82040ee66db13525dc6f14b8559890b2f4c1c#n98=
0

 	if (!virtscsi_cmd_cache) {
 		pr_err("kmem_cache_create() for virtscsi_cmd_cache failed\n");
-		goto error;
+		return -ENOMEM;
	}


See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?id=3D42f82040ee66db13525dc6f14b855989=
0b2f4c1c#n461


> executing a couple more instruction is not an issue.

With which update steps would like to achieve such a code variant?

destroy_pool:
	mempool_destroy(virtscsi_cmd_pool);
	virtscsi_cmd_pool =3D NULL;
destroy_cache:
	kmem_cache_destroy(virtscsi_cmd_cache);
	virtscsi_cmd_cache =3D NULL;
	return ret;


Regards,
Markus

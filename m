From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] scsi: virtio_scsi: Remove unnecessary condition checks
Date: Thu, 9 Jul 2020 19:16:01 +0200
Message-ID: <a197f532-7020-0d8e-21bf-42bb66e8daec@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Xianting Tian <xianting_tian@126.com>, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, "James E. J. Bottomley" <jejb@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> kmem_cache_destroy and mempool_destroy can correctly handle
> null pointer parameter, so there is no need to check if the
> parameter is null before calling kmem_cache_destroy and
> mempool_destroy.

Can another imperative wording be preferred for the change description?


=E2=80=A6
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -1003,14 +1003,10 @@ static int __init init(void)
>  	return 0;
>
>  error:

Can such a label be questionable?


=E2=80=A6
> +	mempool_destroy(virtscsi_cmd_pool);
> +	virtscsi_cmd_pool =3D NULL;
> +	kmem_cache_destroy(virtscsi_cmd_cache);
> +	virtscsi_cmd_cache =3D NULL;
>  	return ret;
>  }

How do you think about to add a jump target so that the execution
of a few statements can be avoided according to a previous
null pointer check?

Regards,
Markus

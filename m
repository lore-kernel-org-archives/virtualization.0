From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v7 0/2] s390: virtio: let arch validate VIRTIO features
Date: Wed, 15 Jul 2020 16:36:10 +0800
Message-ID: <73459586-3315-44cf-8d82-13a394bdf115@redhat.com>
References: <1594801869-13365-1-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1594801869-13365-1-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre Morel <pmorel@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/7/15 下午4:31, Pierre Morel wrote:
> Hi all,
>
> The goal of the series is to give a chance to the architecture
> to validate VIRTIO device features.
>
> in this respin:
>
> 1) I kept removed the ack from Jason as I reworked the patch
>     @Jason, the nature and goal of the patch did not really changed
>             please can I get back your acked-by with these changes?


Yes.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


>
> 2) Rewording for warning messages
>
> Regards,
> Pierre
>
> Pierre Morel (2):
>    virtio: let arch validate VIRTIO features
>    s390: virtio: PV needs VIRTIO I/O device protection
>
>   arch/s390/mm/init.c           | 28 ++++++++++++++++++++++++++++
>   drivers/virtio/virtio.c       | 19 +++++++++++++++++++
>   include/linux/virtio_config.h |  1 +
>   3 files changed, 48 insertions(+)
>

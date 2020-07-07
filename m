From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v4 1/2] virtio: let arch validate VIRTIO features
Date: Tue, 7 Jul 2020 13:09:12 +0200
Message-ID: <afbb9979-9136-3d52-e6cb-4c6905f73b6d@de.ibm.com>
References: <1594111477-15401-1-git-send-email-pmorel@linux.ibm.com>
 <1594111477-15401-2-git-send-email-pmorel@linux.ibm.com>
 <20200707112652.42fcab80.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200707112652.42fcab80.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com
List-Id: virtualization@lists.linuxfoundation.org



On 07.07.20 11:26, Cornelia Huck wrote:
> On Tue,  7 Jul 2020 10:44:36 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> An architecture may need to validate the VIRTIO devices features
>> based on architecture specificities.
> 
> s/specifities/specifics/
> 
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>  drivers/virtio/virtio.c       | 19 +++++++++++++++++++
>>  include/linux/virtio_config.h |  1 +
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>> index a977e32a88f2..3179a8aa76f5 100644
>> --- a/drivers/virtio/virtio.c
>> +++ b/drivers/virtio/virtio.c
>> @@ -167,6 +167,21 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
>>  }
>>  EXPORT_SYMBOL_GPL(virtio_add_status);
>>  
>> +/*
>> + * arch_needs_virtio_iommu_platform - provide arch specific hook when finalizing
> 
> s/arch_needs_virtio_iommu_platform/arch_validate_virtio_features/

With the things from Conny fixed,

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v6 2/2] s390: virtio: PV needs VIRTIO I/O device
 protection
Date: Tue, 14 Jul 2020 13:52:49 +0200
Message-ID: <7a1da5c1-3448-9e22-e741-ea8985fba0cc@linux.ibm.com>
References: <1594726682-12076-1-git-send-email-pmorel@linux.ibm.com>
 <1594726682-12076-3-git-send-email-pmorel@linux.ibm.com>
 <f72b0978-9c66-bccc-948c-bea7df989372@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f72b0978-9c66-bccc-948c-bea7df989372@de.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org
Cc: pasic@linux.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
List-Id: virtualization@lists.linuxfoundation.org



On 2020-07-14 13:42, Christian Borntraeger wrote:
> 
> On 14.07.20 13:38, Pierre Morel wrote:
>> If protected virtualization is active on s390, the virtio queues are
>> not accessible to the host, unless VIRTIO_F_IOMMU_PLATFORM has been
>> negotiated. Use the new arch_validate_virtio_features() interface to
>> fail probe if that's not the case, preventing a host error on access
>> attempt.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> 
> We will probably move this (and other related code) into a new file,
> but we can do that later.
> As for now:
> 
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen

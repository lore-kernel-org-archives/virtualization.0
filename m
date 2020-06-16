From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] s390: virtio: let arch accept devices without
 IOMMU feature
Date: Tue, 16 Jun 2020 09:33:04 +0200
Message-ID: <588f4b63-1e94-521a-b011-f1d8ced75173@linux.ibm.com>
References: <1592224764-1258-1-git-send-email-pmorel@linux.ibm.com>
 <1592224764-1258-2-git-send-email-pmorel@linux.ibm.com>
 <b45e321a-5acb-9be2-4cd6-ae75d7f78f05@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <b45e321a-5acb-9be2-4cd6-ae75d7f78f05@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org
Cc: pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On 2020-06-16 08:22, Jason Wang wrote:
> 
> On 2020/6/15 下午8:39, Pierre Morel wrote:
>> An architecture protecting the guest memory against unauthorized host
>> access may want to enforce VIRTIO I/O device protection through the
>> use of VIRTIO_F_IOMMU_PLATFORM.
>>
>> Let's give a chance to the architecture to accept or not devices
>> without VIRTIO_F_IOMMU_PLATFORM.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> 
> 
> Acked-by: Jason Wang <jasowang@redhat.com>

Thanks,

Pierre



-- 
Pierre Morel
IBM Lab Boeblingen

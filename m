From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v5 1/2] virtio: let arch validate VIRTIO features
Date: Thu, 9 Jul 2020 12:48:38 +0200
Message-ID: <d385b15b-6d5d-bea8-8824-b5595dcfbe81@linux.ibm.com>
References: <1594283959-13742-1-git-send-email-pmorel@linux.ibm.com>
 <1594283959-13742-2-git-send-email-pmorel@linux.ibm.com>
 <20200709115800.7a6e93c8.pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200709115800.7a6e93c8.pasic@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com
List-Id: virtualization@lists.linuxfoundation.org



On 2020-07-09 11:58, Halil Pasic wrote:
> On Thu,  9 Jul 2020 10:39:18 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> An architecture may need to validate the VIRTIO devices features
>> based on architecture specifics.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> Acked-by: Halil Pasic <pasic@linux.ibm.com>


Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen

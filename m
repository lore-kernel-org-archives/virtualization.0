From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH 2/2] virtio reset support
Date: Mon, 28 Jan 2008 09:40:55 -0600
Message-ID: <479DF787.2020100__12952.466417528$1201535313$gmane$org@us.ibm.com>
References: <200801240116.26160.rusty@rustcorp.com.au>
	<200801240118.09032.rusty@rustcorp.com.au>
	<479C8599.60007@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <479C8599.60007@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Dor Laor <dor.laor@gmail.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> Rusty Russell wrote:
>> +
>> +static void vp_reset(struct virtio_device *vdev)
>> +{
>> +    struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>> +    /* 0 status means a reset. */
>> +    return iowrite8(0, vp_dev->ioaddr + VIRTIO_PCI_STATUS);
>>  }
>>   
>
> pci has something called FLR for function-level reset.  If we use that 
> as the reset mechanism, then reset can be initiated from outside the 
> virtio layer, if the guest OS supports that.

PCI-e has a common reset concept (warm and cold).  I've been looking 
around and I can't seem to find any common reset mechanism for PCI.  Is 
FLR something that is per-device or a standard PCI mechanism?  If it's 
the former, than we've basically implemented FLR using this bit in the 
config space.

Regards,

Anthony Liguori

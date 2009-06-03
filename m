From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] Re: [PATCH] qemu: virtio save/load bindings
Date: Wed, 03 Jun 2009 13:31:32 +0300
Message-ID: <4A265104.6060700__46735.2054002278$1244025420$gmane$org@redhat.com>
References: <20090525133405.GA6166@redhat.com> <4A1BA998.8040803@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A1BA998.8040803@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
> Michael S. Tsirkin wrote:
>> Implement bindings for virtio save/load. Use them in virtio pci.
>>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>
>> Is anyone working to fill in load/save bindings so that saving virtio
>> devices works? Here's a trivial patch to do this (this one is on top 
>> of my
>> MSI-X patchset).
>> Comments?
>>
>>  hw/virtio-pci.c |   49 
>> ++++++++++++++++++++++++++++++++++++++++++++++++-
>>  hw/virtio.c     |   31 ++++++++++++++-----------------
>>  hw/virtio.h     |    4 ++++
>>  3 files changed, 66 insertions(+), 18 deletions(-)
>>
>>  static void virtio_init_pci(VirtIOPCIProxy *proxy, VirtIODevice *vdev,
>> diff --git a/hw/virtio.c b/hw/virtio.c
>> index 63ffcff..b773dff 100644
>> --- a/hw/virtio.c
>> +++ b/hw/virtio.c
>> @@ -568,9 +568,8 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
>>  {
>>      int i;
>>  
>> -    /* FIXME: load/save binding.  */
>> -    //pci_device_save(&vdev->pci_dev, f);
>> -    //msix_save(&vdev->pci_dev, f);
>>   
>
> qdev regressed save/restore?  What else is broken right now from the 
> qdev commit?
>
> I'm beginning to think committing in the state it was in was a 
> mistake.  Paul, can you put together a TODO so that we know all of the 
> things that have regressed so we can get things back into shape?
>

virtio is still broken.  Anthony, are you planning to commit this patch?

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

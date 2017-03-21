From: Marcel Apfelbaum <marcel@redhat.com>
Subject: Re: [BUG] virtio-net linux driver fails to probe on MIPS Malta since
	'hw/virtio-pci: fix virtio behaviour'
Date: Tue, 21 Mar 2017 16:16:58 +0200
Message-ID: <c92a77f3-7ddc-c0b8-7046-6d8f1c56aec7@redhat.com>
References: <20170317215725.GJ996@jhogan-linux.le.imgtec.org>
	<6b3ec98b-55e2-ecc8-d962-dc9d13866319@redhat.com>
	<20170320174101-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170320174101-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: James Hogan <james.hogan@imgtec.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 03/20/2017 05:43 PM, Michael S. Tsirkin wrote:
> On Mon, Mar 20, 2017 at 05:21:22PM +0200, Marcel Apfelbaum wrote:
>> On 03/17/2017 11:57 PM, James Hogan wrote:
>>> Hi,
>>>
>>> I've bisected the following failure of the virtio_net linux v4.10 driver
>>> to probe in QEMU v2.9.0-rc1 emulating a MIPS Malta machine:
>>>
>>> virtio_net virtio0: virtio: device uses modern interface but does not have VIRTIO_F_VERSION_1
>>> virtio_net: probe of virtio0 failed with error -22
>>>
>>> To QEMU commit 9a4c0e220d8a ("hw/virtio-pci: fix virtio behaviour").
>>>
>>> It appears that adding ",disable-modern=on,disable-legacy=off" to the
>>> virtio-net -device makes it work again.
>>>
>>> I presume this should really just work out of the box. Any ideas why it
>>> isn't?
>>>
>>
>> Hi,
>>
>>
>> This is strange. This commit changes virtio devices from legacy to virtio "transitional".
>> (your command line changes it to legacy)
>> Linux 4.10 supports virtio modern/transitional (as far as I know) and on QEMU side
>> there is nothing new.
>>
>> Michael, do you have any idea?
>>
>> Thanks,
>> Marcel
>
> My guess would be firmware mishandling 64 bit BARs - we saw such
> a case on sparc previously. As a result you are probably reading
> all zeroes from features register or something like that.
> Marcel, could you send a patch making the bar 32 bit?
> If that helps we know what the issue is.
>

Hi James,

Can you please check if the below patch fixes the problem?
Please note it is not a solution.

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index f9b7244..5b4d429 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1671,9 +1671,7 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
          }

          pci_register_bar(&proxy->pci_dev, proxy->modern_mem_bar_idx,
-                         PCI_BASE_ADDRESS_SPACE_MEMORY |
-                         PCI_BASE_ADDRESS_MEM_PREFETCH |
-                         PCI_BASE_ADDRESS_MEM_TYPE_64,
+                         PCI_BASE_ADDRESS_SPACE_MEMORY,
                           &proxy->modern_bar);

          proxy->config_cap = virtio_pci_add_mem_cap(proxy, &cfg.cap);


Thanks,
Marcel

From: "Zhang, Yang Z" <yang.z.zhang@intel.com>
Subject: RE: [opnfv-tech-discuss] rfc: vhost user enhancements for vm2vm
	communication
Date: Mon, 14 Sep 2015 00:43:47 +0000
Message-ID: <A9667DDFB95DB7438FA9D7D576C3D87E0ADA88F4@SHSMSX104.ccr.corp.intel.com>
References: <20150831160655-mutt-send-email-mst@redhat.com>
	<55ED854A.1080804@huawei.com>
	<20150909095258-mutt-send-email-mst@redhat.com>
	<55F2F59B.4030401@huawei.com>
	<20150913120821-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150913120821-mutt-send-email-mst@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Claudio Fontana <claudio.fontana@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "opnfv-tech-discuss@lists.opnfv.org" <opnfv-tech-discuss@lists.opnfv.org>, Jan Kiszka <jan.kiszka@siemens.com>
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote on 2015-09-13:
> On Fri, Sep 11, 2015 at 05:39:07PM +0200, Claudio Fontana wrote:
>> On 09.09.2015 09:06, Michael S. Tsirkin wrote:
>> 
>> There are many consequences to this, offset within BAR alone is not
>> enough, there are multiple things at the virtio level that need sorting
>> out. Also we need to consider virtio-mmio etc.
>> 
>>> This would allow VM2VM communication if there are only 2 VMs, but
>>> if data needs to be sent to multiple VMs, you must copy it.
>> 
>> Not necessarily, however getting it to work (sharing the backend window
>> and arbitrating the multicast) is really hard.
>> 
>>> 
>>> Additionally, it's a single-purpose feature: you can use it from a
>>> userspace PMD but linux will never use it.
>>> 
>>> 
>>> My proposal is a superset: don't require that BAR memory is used,
>>> use IOMMU translation tables.
>>> This way, data can be sent to multiple VMs by sharing the same
>>> memory with them all.
>> 
>> Can you describe in detail how your proposal deals with the
>> arbitration
> necessary for multicast handling?
> 
> Basically it falls out naturally. Consider linux guest as an example,
> and assume dynamic mappings for simplicity.
> 
> Multicast is done by a bridge on the guest side. That code clones the
> skb (reference-counting page fragments) and passes it to multiple ports.
> Each of these will program the IOMMU to allow read access to the
> fragments to the relevant device.

How to work with vswitch in host side like OVS? Since the flow table is inside host, but guest cannot see it.

Best regards,
Yang

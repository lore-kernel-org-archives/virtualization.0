From: "Zhang, Yang Z" <yang.z.zhang@intel.com>
Subject: RE: [opnfv-tech-discuss] rfc: vhost user enhancements for vm2vm
	communication
Date: Wed, 9 Sep 2015 06:40:48 +0000
Message-ID: <A9667DDFB95DB7438FA9D7D576C3D87E0AD9AB0B__38327.6321263567$1441856862$gmane$org@SHSMSX104.ccr.corp.intel.com>
References: <20150831160655-mutt-send-email-mst@redhat.com>
	<55ED854A.1080804@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <55ED854A.1080804@huawei.com>
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
To: Claudio Fontana <claudio.fontana@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "opnfv-tech-discuss@lists.opnfv.org" <opnfv-tech-discuss@lists.opnfv.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
List-Id: virtualization@lists.linuxfoundation.org

Claudio Fontana wrote on 2015-09-07:
> Coming late to the party,
> 
> On 31.08.2015 16:11, Michael S. Tsirkin wrote:
>> Hello!
>> During the KVM forum, we discussed supporting virtio on top
>> of ivshmem. I have considered it, and came up with an alternative
>> that has several advantages over that - please see below.
>> Comments welcome.
> 
> as Jan mentioned we actually discussed a virtio-shmem device which would
> incorporate the advantages of ivshmem (so no need for a separate ivshmem
> device), which would use the well known virtio interface, taking advantage of
> the new virtio-1 virtqueue layout to split r/w and read-only rings as seen from
> the two sides, and make use also of BAR0 which has been freed up for use by
> the device.

Interesting! Can you elaborate it? 

> 
> This way it would be possible to share the rings and the actual memory
> for the buffers in the PCI bars. The guest VMs could decide to use the
> shared memory regions directly as prepared by the hypervisor (in the

"the shared memory regions" here means share another VM's memory or like ivshmem?

> jailhouse case) or QEMU/KVM, or perform their own validation on the
> input depending on the use case.
> 
> Of course the communication between VMs needs in this case to be
> pre-configured and is quite static (which is actually beneficial in our use case).

pre-configured means user knows which VMs will talk to each other and configure it when booting guest(i.e. in Qemu command line)?

> 
> But still in your proposed solution, each VM needs to be pre-configured to
> communicate with a specific other VM using a separate device right?
> 
> But I wonder if we are addressing the same problem.. in your case you are
> looking at having a shared memory pool for all VMs potentially visible to all VMs
> (the vhost-user case), while in the virtio-shmem proposal we discussed we
> were assuming specific different regions for every channel.
> 
> Ciao,
> 
> Claudio
> 
> 
>


Best regards,
Yang

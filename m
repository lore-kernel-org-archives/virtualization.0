From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: RFC: virtio-peer shared memory based peer communication device
Date: Mon, 21 Sep 2015 14:15:41 +0200
Message-ID: <55FFF4ED.4000908@redhat.com>
References: <20150831160655-mutt-send-email-mst@redhat.com>
	<55ED854A.1080804@huawei.com>
	<A9667DDFB95DB7438FA9D7D576C3D87E0AD9AB0B@SHSMSX104.ccr.corp.intel.com>
	<55EFF03A.4000109@huawei.com> <55FC3BE7.5010503@huawei.com>
	<55FC7DFA.80204@redhat.com> <55FFE03E.6080106@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <55FFE03E.6080106@siemens.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Kiszka <jan.kiszka@siemens.com>, Claudio Fontana <claudio.fontana@huawei.com>, "Zhang, Yang Z" <yang.z.zhang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "opnfv-tech-discuss@lists.opnfv.org" <opnfv-tech-discuss@lists.opnfv.org>
List-Id: virtualization@lists.linuxfoundation.org



On 21/09/2015 12:47, Jan Kiszka wrote:
>> > Apart from the windows idea, how does virtio-peer compare to virtio-rpmsg?
> rpmsg is a very specialized thing. It targets single AMP cores, assuming
> that those have full access to the main memory.

Yes, this is why I did say "apart from the windows idea".

> And it is also a
> centralized approach where all message go through the main Linux
> instance. I suspect we could cover that use case as well with generic
> inter-vm shared memory device, but I didn't think about all details yet.

The virtqueue handling seems very similar between the two.  However, the
messages for rpmsg however have a small header (struct rpmsg_hdr in
include/linux/rpmsg.h) and there is a weird feature bit VIRTIO_RPMSG_F_NS.

So I guess virtio-rpmsg and virtio-peer are about as similar as
virtio-serial and virtio-peer.

Paolo

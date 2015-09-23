From: "Ergin, Mesut A" <mesut.a.ergin@intel.com>
Subject: RE: [opnfv-tech-discuss] RFC: virtio-peer shared memory based peer
	communication device
Date: Wed, 23 Sep 2015 18:53:50 +0000
Message-ID: <3615B82CA151CF42A86EDDD9846A8B3873C09259@ORSMSX112.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: Claudio Fontana <claudio.fontana@huawei.com>, "Zhang, Yang Z" <yang.z.zhang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "opnfv-tech-discuss@lists.opnfv.org" <opnfv-tech-discuss@lists.opnfv.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
List-Id: virtualization@lists.linuxfoundation.org

On 18/09/2015 18:29, Claudio Fontana wrote:
 
> The Virtio Peer shared memory communication device (virtio-peer) is a
> virtual device which allows high performance low latency guest to guest
> communication. It uses a new queue extension feature tentatively called
> VIRTIO_F_WINDOW which indicates that descriptor tables, available and
> used rings and Queue Data reside in physical memory ranges called
> Windows, each identified with an unique identifier called WindowID.
> 

Should we consider virtio-peer a pair-wise created device for two guests, 
where sending side driver is operating receive side virtqueue to drop
packets directly? Do you have some architectural description of how
guests are expected to use virtio-peer? Thanks.

Mesut

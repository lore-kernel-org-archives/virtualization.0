From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: RFC: virtio-peer shared memory based peer communication device
Date: Fri, 18 Sep 2015 23:11:22 +0200
Message-ID: <55FC7DFA.80204@redhat.com>
References: <20150831160655-mutt-send-email-mst@redhat.com>
	<55ED854A.1080804@huawei.com>
	<A9667DDFB95DB7438FA9D7D576C3D87E0AD9AB0B@SHSMSX104.ccr.corp.intel.com>
	<55EFF03A.4000109@huawei.com> <55FC3BE7.5010503@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <55FC3BE7.5010503@huawei.com>
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
> 
> this is a first RFC for virtio-peer 0.1, which is still very much a work in progress:
> 
> https://github.com/hw-claudio/virtio-peer/wiki
> 
> It is also available as PDF there, but the text is reproduced here for commenting:
> 
> Peer shared memory communication device (virtio-peer)

Apart from the windows idea, how does virtio-peer compare to virtio-rpmsg?

Paolo

From: Yuanhan Liu <yuanhan.liu@linux.intel.com>
Subject: Re: [virtio-dev] packed ring layout proposal - todo list
Date: Tue, 28 Feb 2017 12:29:43 +0800
Message-ID: <20170228042943.GH18844__35359.1340281584$1488675785$gmane$org@yliu-dev.sh.intel.com>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
	<20170222054336-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170222054336-mutt-send-email-mst@kernel.org>
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
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Michael,

Again, as usual, sorry for being late :/

On Wed, Feb 22, 2017 at 06:27:11AM +0200, Michael S. Tsirkin wrote:
> Stage 2: prototype guest/host drivers
> 
> At this stage we need real guest and host drivers
> to be able to test real life performance.
> I suggest dpdk drivers + munimal hack in qemu to
> pass features around.
> 

I have already done that in last Nov. I made a very rough (yet hacky)
version (only with Tx path) in one day while companying my wife in
hospital.

If someone are interested in, I could share the code soon. I could
even cleanup the code a bit if necessary.


> Tasks:
> 
> - implement vhost-user support in dpdk
> - implement virtio support in dpdk
> - implement minimal stub in qemu

I didn't hack the QEMU, instead, I hacked the DPDK virtio-user, yet
another virtio-net emulation. It's simpler and quicker for me.

And here is my plan on virtio 1.1:

- Look deeper inside the virtio net performance issues (WIP)

  It's basically a job about digging the DPDK vhost/virtio code
  deeper, something like how exactly the cache acts while Tx/Rx
  pkts, what can be optimized by implementation, and what could
  be improved with the help of spec extension.

  Please note that I often got interrupted on this task: it didn't
  go smooth as I would have expected.


- Try to accelerate vhost/virtio with vector instructions.

  Something I will look into when above item is done. Currently,
  I thought of two items may help the vector implementation:

  * what kind of vring and desc layout could make the vector
    implementation easier.

  * what kind of hint we need from virtio spec for (dynamically)
    enabling the vector path.

  Besides that, I don't have too much clue yet.

	--yliu

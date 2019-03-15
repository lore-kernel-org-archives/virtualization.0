From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: virtio-blk: should num_vqs be limited by num_possible_cpus()?
Date: Fri, 15 Mar 2019 13:41:12 +0100
Message-ID: <20190315134112.7d63348c.cohuck@redhat.com>
References: <e4afe4c5-0262-4500-aeec-60f30734b4fc@default>
	<20190312183351.74764f4f.cohuck@redhat.com>
	<173d19c9-24db-35f2-269f-0b9b83bd0ad6@oracle.com>
	<20190313103900.1ea7f996.cohuck@redhat.com>
	<a3f24cfa-5160-0ccc-decc-a48362c8de19@oracle.com>
	<537e6420-8994-43d6-1d4d-ccb6e0fafa0b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <537e6420-8994-43d6-1d4d-ccb6e0fafa0b@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: axboe@kernel.dk, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 15 Mar 2019 12:50:11 +0800
Jason Wang <jasowang@redhat.com> wrote:

> Or something like I proposed several years ago? 
> https://do-db2.lkml.org/lkml/2014/12/25/169
> 
> Btw, for virtio-net, I think we actually want to go for having a maximum 
> number of supported queues like what hardware did. This would be useful 
> for e.g cpu hotplug or XDP (requires per cpu TX queue). But the current 
> vector allocation doesn't support this which will results all virtqueues 
> to share a single vector. We may indeed need more flexible policy here.

I think it should be possible for the driver to give the transport
hints how to set up their queues/interrupt structures. (The driver
probably knows best about its requirements.) Perhaps whether a queue is
high or low frequency, or whether it should be low latency, or even
whether two queues could share a notification mechanism without
drawbacks. It's up to the transport to make use of that information, if
possible.

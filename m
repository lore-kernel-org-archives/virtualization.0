From: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: Resource management for ndo_xdp_xmit (Was: [PATCH net]
	virtio_net: Account for tx bytes and packets on sending xdp_frames)
Date: Fri, 8 Feb 2019 18:05:16 -0800
Message-ID: <20190208180516.287f6ddc__21590.6997722172$1549716352$gmane$org@cakuba.netronome.com>
References: <1548934830-2389-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<20190131101516-mutt-send-email-mst@kernel.org>
	<20190131.094523.2248120325911339180.davem@davemloft.net>
	<20190131211555.3b15c81f@carbon>
	<b8c97120-851f-450f-dc71-59350236329e@gmail.com>
	<20190204125307.08492005@redhat.com>
	<bdcfedd6-465d-4485-e268-25c4ce6b9fcf@gmail.com>
	<140ecbe1e25f54f90d859cc696c4119aa96bc6eb.camel@mellanox.com>
	<20190207084815.1e8bd817@carbon>
	<9e5e6882566ac67276209b35ec112a824b256bff.camel@mellanox.com>
	<71c687209afb1268fdb5dc4aabbab9ecf6c2aa37.camel@mellanox.com>
	<b4eb9dd1c7aaa3215ade8d3d17f397588a519ca3.camel@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <b4eb9dd1c7aaa3215ade8d3d17f397588a519ca3.camel@mellanox.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Saeed Mahameed <saeedm@mellanox.com>
Cc: "toke@toke.dk" <toke@toke.dk>, "hawk@kernel.org" <hawk@kernel.org>, "mst@redhat.com" <mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dsahern@gmail.com" <dsahern@gmail.com>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "thoiland@redhat.com" <thoiland@redhat.com>, "brouer@redhat.com" <brouer@redhat.com>, "borkmann@iogearbox.net" <borkmann@iogearbox.net>, "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan <tariqt@mellanox.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 9 Feb 2019 00:18:31 +0000, Saeed Mahameed wrote:
> On Fri, 2019-02-08 at 15:17 -0800, Saeed Mahameed wrote:
> > On Thu, 2019-02-07 at 19:08 +0000, Saeed Mahameed wrote:  
> > > 
> > > So 
> > > 1) on dev_map_update_elem() we will call
> > > dev->dev->ndo_bpf() to notify the device on the intention to
> > > start/stop
> > > redirect, and wait for it to create/destroy the HW resources
> > > before/after actually updating the map
> > >   
> > 
> > silly me, dev_map_update_elem must be atomic, we can't hook driver
> > resource allocation to it, it must come as a separate request
> > (syscall)
> > from user space to request to create XDP redirect resources.
> >   
> 
> Well, it is possible to render dev_map_update_elem non-atomic and fail
> BPF programs who try to update it in the verifier
> check_map_func_compatibility.
> 
> if you know of any case where devmap needs to be updated from the BPF
> program please let me know.

Did we find a solution to non-map redirect?

Sorry if I missed the discussion, I couldn't make the iovisor call this
week due to travel.

From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Resource management for ndo_xdp_xmit (Was: [PATCH net] virtio_net:
	Account for tx bytes and packets on sending xdp_frames)
Date: Thu, 7 Feb 2019 08:48:15 +0100
Message-ID: <20190207084815.1e8bd817__43123.6313468375$1549525718$gmane$org@carbon>
References: <1548934830-2389-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<20190131101516-mutt-send-email-mst@kernel.org>
	<20190131.094523.2248120325911339180.davem@davemloft.net>
	<20190131211555.3b15c81f@carbon>
	<b8c97120-851f-450f-dc71-59350236329e@gmail.com>
	<20190204125307.08492005@redhat.com>
	<bdcfedd6-465d-4485-e268-25c4ce6b9fcf@gmail.com>
	<140ecbe1e25f54f90d859cc696c4119aa96bc6eb.camel@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <140ecbe1e25f54f90d859cc696c4119aa96bc6eb.camel@mellanox.com>
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
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>, "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>, "hawk@kernel.org" <hawk@kernel.org>, "mst@redhat.com" <mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, brouer@redhat.com, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Toke =?UTF-8?B?SMO4aWxhbmQt?= =?UTF-8?B?SsO4cmdlbnNlbg==?= <thoiland@redhat.com>, "dsahern@gmail.com" <dsahern@gmail.com>, "borkmann@iogearbox.net" <borkmann@iogearbox.net>, "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan <tariqt@mellanox.com>
List-Id: virtualization@lists.linuxfoundation.org


On Wed, 6 Feb 2019 00:06:33 +0000 Saeed Mahameed <saeedm@mellanox.com> wrote:

> On Mon, 2019-02-04 at 19:13 -0800, David Ahern wrote:
[...]
> > 
> > mlx5 needs some work. As I recall it still has the bug/panic
> > removing xdp programs - at least I don't recall seeing a patch for
> > it.  
> 
> Only when xdp_redirect to mlx5, and removing the program while
> redirect is happening, this is actually due to a lack of
> synchronization means between different drivers, we have some ideas
> to overcome this using a standard XDP API, or just use a hack in mlx5
> driver which i don't like:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git/commit/?h=topic/xdp-redirect-fix&id=a3652d03cc35fd3ad62744986c8ccaca74c9f20c
> 
> I will be working on this towards the end of this week.

Toke and I have been discussing how to solve this.

The main idea for fixing this is to tie resource allocation to interface
insertion into interface maps (kernel/bpf/devmap.c). As the =devmap=
already have the needed synchronisation mechanisms and steps for safely
adding and removing =net_devices= (e.g. stopping RX side, flushing
remaining frames, waiting RCU period before freeing objects, etc.)

As described here:
 https://github.com/xdp-project/xdp-project/blob/master/xdp-project.org#better-ndo_xdp_xmit-resource-management

--Jesper

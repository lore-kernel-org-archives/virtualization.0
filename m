From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] net: don't use kvzalloc for DMA memory
Date: Wed, 18 Apr 2018 21:00:23 +0300
Message-ID: <20180418205539-mutt-send-email-mst@kernel.org>
References: <3e65977e-53cd-bf09-bc4b-0ce40e9091fe@gmail.com>
	<alpine.LRH.2.02.1804181218270.19136@file01.intranet.prod.int.rdu2.redhat.com>
	<5f4e1286-b79f-0b9f-9a30-47d7654f3889@gmail.com>
	<20180418.134721.283381724211219025.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180418.134721.283381724211219025.davem@davemloft.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>
Cc: eric.dumazet@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, edumazet@google.com, mpatocka@redhat.com, joby.poriyath@citrix.com, bhutchings@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 18, 2018 at 01:47:21PM -0400, David Miller wrote:
> From: Eric Dumazet <eric.dumazet@gmail.com>
> Date: Wed, 18 Apr 2018 09:51:25 -0700
> 
> > I suggest that virtio_net clearly identifies which part needs a specific allocation
> > and does its itself, instead of abusing the netdev_priv storage.
> > 
> > Ie use a pointer to a block of memory, allocated by virtio_net, for virtio_net.
> 
> +1

I can do this, but just FYI it's all of 16 bytes which is only mapped
for DMA temporarily - and not all of it - a byte here, a byte there.
The amount of hoops one has to jump through just to get 1 byte from
device nowdays is annoying.

-- 
MST

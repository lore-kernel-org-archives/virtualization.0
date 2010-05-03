From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv7] add mergeable buffers support to vhost_net
Date: Mon, 3 May 2010 13:34:11 +0300
Message-ID: <20100503103410.GA11113@redhat.com>
References: <1272488232.11307.4.camel@w-dls.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1272488232.11307.4.camel@w-dls.beaverton.ibm.com>
Sender: netdev-owner@vger.kernel.org
To: David L Stevens <dlstevens@us.ibm.com>
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 28, 2010 at 01:57:12PM -0700, David L Stevens wrote:
> This patch adds mergeable receive buffer support to vhost_net.
> 
> Signed-off-by: David L Stevens <dlstevens@us.ibm.com>

I've been doing some more testing before sending out a pull
request, and I see a drastic performance degradation in guest to host
traffic when this is applied but mergeable buffers are not in used
by userspace (existing qemu-kvm userspace).

This is both with and without my patch on top.

Without patch:
[mst@tuck ~]$ sh runtest  2>&1 | tee ser-meregeable-disabled-kernel-only-tun-only.log
Starting netserver at port 12865
set_up_server could not establish a listen endpoint for  port 12865 with family AF_UNSPEC
TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 11.0.0.4 (11.0.0.4) port 0 AF_INET : demo
Recv   Send    Send                          Utilization       Service Demand
Socket Socket  Message  Elapsed              Send     Recv     Send    Recv
Size   Size    Size     Time     Throughput  local    remote   local   remote
bytes  bytes   bytes    secs.    10^6bits/s  % S      % S      us/KB   us/KB

 87380  16384  16384    10.00      9107.26   89.20    33.85    0.802   2.436  

With patch:
TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 11.0.0.4 (11.0.0.4) port 0 AF_INET : demo
Recv   Send    Send                          Utilization       Service Demand
Socket Socket  Message  Elapsed              Send     Recv     Send    Recv
Size   Size    Size     Time     Throughput  local    remote   local   remote
bytes  bytes   bytes    secs.    10^6bits/s  % S      % S      us/KB   us/KB

 87380  16384  16384    10.00        35.00   2.21     0.62     5.181   11.575 


For ease of testing, I put this on my tree
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost-broken

Please take a look.
Thanks!

-- 
MST

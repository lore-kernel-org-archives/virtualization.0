From: Ilya Lesokhin <ilyal@mellanox.com>
Subject: RE: packed ring layout proposal v3
Date: Thu, 14 Sep 2017 08:23:32 +0000
Message-ID: <AM4PR0501MB27231AB2873CFFB99E66CE98D46F0@AM4PR0501MB2723.eurprd05.prod.outlook.com>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

> -----Original Message-----
> From: virtualization-bounces@lists.linux-foundation.org
> [mailto:virtualization-bounces@lists.linux-foundation.org] On Behalf Of
> Michael S. Tsirkin
> Sent: Sunday, September 10, 2017 8:06 AM
> To: virtio-dev@lists.oasis-open.org
> Cc: virtualization@lists.linux-foundation.org
> Subject: packed ring layout proposal v3
> 
> This is an update from v2 version.
...
> When driver descriptors are chained in this way, multiple descriptors are
> treated as a part of a single transaction containing an optional write buffer
> followed by an optional read buffer.
> All descriptors in the chain must have the same ID.
> 
...

I think you should consider removing  the "same ID" requirement.

Assuming out of order execution, how is the driver supposed to re-assign unique IDs to the previously
chained descriptor?
Do you expected driver to copy original IDs somewhere else before the chaining and then restore them after the chain is
executed?

Thanks,
Ilya

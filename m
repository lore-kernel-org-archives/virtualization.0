From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next] virtio-net: make napi_tx param easier to grasp
Date: Sun, 20 Aug 2017 16:30:38 -0400
Message-ID: <CAF=yD-JA_JPyUbDd=SR9Epvzw6-kbUcrfvwRWODwmeV+yHEMHw__40313.1344392479$1503261089$gmane$org@mail.gmail.com>
References: <20170819063707.26822-1-den@klaipeden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170819063707.26822-1-den@klaipeden.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Koichiro Den <den@klaipeden.com>
Cc: Network Development <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Aug 19, 2017 at 2:37 AM, Koichiro Den <den@klaipeden.com> wrote:
> The module param napi_tx needs not to be writable for now since we do
> not have any means of activating/deactivating it online,

A virtio_net device inherits its napi tx mode from the global napi_tx flag
on device up. It is possible to change the parameter and bring a device
down/up to change the device mode.

> @@ -1179,13 +1172,19 @@ static int virtnet_open(struct net_device *dev)
>         struct virtnet_info *vi = netdev_priv(dev);
>         int i;
>
> +       /* Tx napi touches cachelines on the cpu handling tx interrupts. Only
> +        * enable the feature if this is likely affine with the transmit path.
> +        */
> +       if (!vi->affinity_hint_set)
> +               napi_tx = false;
> +

This disables napi globally if a specific device lacks affinity.

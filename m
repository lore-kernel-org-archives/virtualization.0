From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH 4/4] lguest: Use GSO/IFF_VNET_HDR extensions on tun/tap
Date: Wed, 25 Jun 2008 14:07:18 -0500
Message-ID: <48629766.4040905__20669.8114089251$1214421021$gmane$org@codemonkey.ws>
References: <200806260028.07883.rusty@rustcorp.com.au>	<200806260029.40267.rusty@rustcorp.com.au>	<200806260030.38293.rusty@rustcorp.com.au>
	<200806260032.12359.rusty__46755.7742762894$1214404667$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200806260032.12359.rusty__46755.7742762894$1214404667$gmane$org@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: markmc@redhat.com, virtualization@lists.linux-foundation.org, Herbert Xu <herbert@gondor.apana.org.au>, Max Krasnyansky <maxk@qualcomm.com>, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> @@ -1563,6 +1561,16 @@ static void setup_tun_net(char *arg)
>  	/* Tell Guest what MAC address to use. */
>  	add_feature(dev, VIRTIO_NET_F_MAC);
>  	add_feature(dev, VIRTIO_F_NOTIFY_ON_EMPTY);
> +	/* Expect Guest to handle everything except UFO */
> +	add_feature(dev, VIRTIO_NET_F_CSUM);

You're setting this feature twice.

> +	add_feature(dev, VIRTIO_NET_F_GUEST_CSUM);

You set this feature, but I never see the virtio-net driver acknowledge 
the feature.  Curiously, my implementation with KVM is struggling 
because UDP packet checksums are not correct so the DHCP client is 
ignoring them.  If I disable CSUM offload, things it works fine (using 
the virtio-net header).  The problem is only host=>guest, guest=>host is 
fine.

Regards,

Anthony Liguori

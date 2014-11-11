From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH net] Revert "drivers/net: Disable UFO through virtio" in
	macvtap and tun
Date: Tue, 11 Nov 2014 17:12:58 +0000
Message-ID: <1415725978.3398.101.camel@decadent.org.uk>
References: <20141111105849.GA8482@stefanha-thinkpad.redhat.com>
	<1415708246.3398.88.camel@decadent.org.uk>
	<20141111155750.GA17418@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1943730518192265152=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141111155750.GA17418@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, jelledejong@powercraft.nl, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org


--===============1943730518192265152==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-o4n8v3fyw0ZZJRFdqmgr"


--=-o4n8v3fyw0ZZJRFdqmgr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This reverts commit 88e0e0e5aa722b193c8758c8b45d041de5316924 for
the tap drivers, but leaves UFO disabled in virtio_net.

libvirt at least assumes that tap features will never be dropped
in new kernel versions, and doing so prevents migration of VMs to
the never kernel version while they are running with virtio net
devices.

Fixes: 88e0e0e5aa7a ("drivers/net: Disable UFO through virtio")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
Compile-tested only.

Ben.

 drivers/net/macvtap.c | 13 ++++++++-----
 drivers/net/tun.c     | 19 ++++++++-----------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/macvtap.c b/drivers/net/macvtap.c
index 6f226de..aeaeb6d 100644
--- a/drivers/net/macvtap.c
+++ b/drivers/net/macvtap.c
@@ -66,7 +66,7 @@ static struct cdev macvtap_cdev;
 static const struct proto_ops macvtap_socket_ops;
=20
 #define TUN_OFFLOADS (NETIF_F_HW_CSUM | NETIF_F_TSO_ECN | NETIF_F_TSO | \
-		      NETIF_F_TSO6)
+		      NETIF_F_TSO6 | NETIF_F_UFO)
 #define RX_OFFLOADS (NETIF_F_GRO | NETIF_F_LRO)
 #define TAP_FEATURES (NETIF_F_GSO | NETIF_F_SG)
=20
@@ -570,8 +570,6 @@ static int macvtap_skb_from_vnet_hdr(struct sk_buff *sk=
b,
 			gso_type =3D SKB_GSO_TCPV6;
 			break;
 		case VIRTIO_NET_HDR_GSO_UDP:
-			pr_warn_once("macvtap: %s: using disabled UFO feature; please fix this =
program\n",
-				     current->comm);
 			gso_type =3D SKB_GSO_UDP;
 			if (skb->protocol =3D=3D htons(ETH_P_IPV6))
 				ipv6_proxy_select_ident(skb);
@@ -619,6 +617,8 @@ static void macvtap_skb_to_vnet_hdr(const struct sk_buf=
f *skb,
 			vnet_hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
 		else if (sinfo->gso_type & SKB_GSO_TCPV6)
 			vnet_hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV6;
+		else if (sinfo->gso_type & SKB_GSO_UDP)
+			vnet_hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP;
 		else
 			BUG();
 		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
@@ -953,6 +953,9 @@ static int set_offload(struct macvtap_queue *q, unsigne=
d long arg)
 			if (arg & TUN_F_TSO6)
 				feature_mask |=3D NETIF_F_TSO6;
 		}
+
+		if (arg & TUN_F_UFO)
+			feature_mask |=3D NETIF_F_UFO;
 	}
=20
 	/* tun/tap driver inverts the usage for TSO offloads, where
@@ -963,7 +966,7 @@ static int set_offload(struct macvtap_queue *q, unsigne=
d long arg)
 	 * When user space turns off TSO, we turn off GSO/LRO so that
 	 * user-space will not receive TSO frames.
 	 */
-	if (feature_mask & (NETIF_F_TSO | NETIF_F_TSO6))
+	if (feature_mask & (NETIF_F_TSO | NETIF_F_TSO6 | NETIF_F_UFO))
 		features |=3D RX_OFFLOADS;
 	else
 		features &=3D ~RX_OFFLOADS;
@@ -1064,7 +1067,7 @@ static long macvtap_ioctl(struct file *file, unsigned=
 int cmd,
 	case TUNSETOFFLOAD:
 		/* let the user check for future flags */
 		if (arg & ~(TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6 |
-			    TUN_F_TSO_ECN))
+			    TUN_F_TSO_ECN | TUN_F_UFO))
 			return -EINVAL;
=20
 		rtnl_lock();
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 7302398..a0987d1 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -175,7 +175,7 @@ struct tun_struct {
 	struct net_device	*dev;
 	netdev_features_t	set_features;
 #define TUN_USER_FEATURES (NETIF_F_HW_CSUM|NETIF_F_TSO_ECN|NETIF_F_TSO| \
-			  NETIF_F_TSO6)
+			  NETIF_F_TSO6|NETIF_F_UFO)
=20
 	int			vnet_hdr_sz;
 	int			sndbuf;
@@ -1152,20 +1152,10 @@ static ssize_t tun_get_user(struct tun_struct *tun,=
 struct tun_file *tfile,
 			skb_shinfo(skb)->gso_type =3D SKB_GSO_TCPV6;
 			break;
 		case VIRTIO_NET_HDR_GSO_UDP:
-		{
-			static bool warned;
-
-			if (!warned) {
-				warned =3D true;
-				netdev_warn(tun->dev,
-					    "%s: using disabled UFO feature; please fix this program\n",
-					    current->comm);
-			}
 			skb_shinfo(skb)->gso_type =3D SKB_GSO_UDP;
 			if (skb->protocol =3D=3D htons(ETH_P_IPV6))
 				ipv6_proxy_select_ident(skb);
 			break;
-		}
 		default:
 			tun->dev->stats.rx_frame_errors++;
 			kfree_skb(skb);
@@ -1265,6 +1255,8 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 				gso.gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
 			else if (sinfo->gso_type & SKB_GSO_TCPV6)
 				gso.gso_type =3D VIRTIO_NET_HDR_GSO_TCPV6;
+			else if (sinfo->gso_type & SKB_GSO_UDP)
+				gso.gso_type =3D VIRTIO_NET_HDR_GSO_UDP;
 			else {
 				pr_err("unexpected GSO type: "
 				       "0x%x, gso_size %d, hdr_len %d\n",
@@ -1774,6 +1766,11 @@ static int set_offload(struct tun_struct *tun, unsig=
ned long arg)
 				features |=3D NETIF_F_TSO6;
 			arg &=3D ~(TUN_F_TSO4|TUN_F_TSO6);
 		}
+
+		if (arg & TUN_F_UFO) {
+			features |=3D NETIF_F_UFO;
+			arg &=3D ~TUN_F_UFO;
+		}
 	}
=20
 	/* This gives the user a way to test for new features in future by


--=20
Ben Hutchings
Experience is directly proportional to the value of equipment destroyed.
                                                         - Carolyn Scheppne=
r

--=-o4n8v3fyw0ZZJRFdqmgr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVGJDn+e/yOyVhhEJAQpHgxAAt+C0HX7xhAlI5/wwJw5Oy3EMuGVYpDRO
EddhQrblGkT6ibGf/0St8CyiUu+Oa/tzHx96Po7zCjKNMoJVkSqR+9x1CikU7Z2S
Yn/esbEcLpvUUEn/xMuT87VfXLBASAL69ufinKdVlGy+5B4rCAjDOvRgo7yZZxay
u15rdVnLOlxHKCGIHDCuqUYR/jQOhuvk5Hi834+voiS+7tdO8qYEaCyGToIgZXBi
tn0mul0GdvlskVJqDfnKlEKM+YZ5WRfL9b6rNL46n52buCaXBcEPgFUeEMaR1knW
egfntN75x99oAc/aEY3QynKWHS72Gnjjw9wESmH+waslxNdYafoaR661c7s0a2Xm
rDfXkYh8R6FxPoPJiEf+kquKl0YXA0PN/O6S2t2qgGaBDn7mY8fhkmDj22fDaWnb
asVTR8ox8g592H1ddNpy9xsE2fsd0RezxxIPfemjmnbSKq8kTT38eHtnmDVKxE+F
xZFWtiyR9DMG4GtHtqBFS0HGcZklQ32d4ePzk0QgqUDV/sumLfFhJCgwf1C05/jH
4FJM9eUMqW+1rDNc4tRMHPZ+Jg9JrlioztGulfu+6JDM8pTV6P58g7FN0Gg3ufkI
wXNcUtWh+7BAEw5E+8FOnZ1h+zp7gYwH1B/Sfe3jhEmBApF90K53mB6Dp/XkleLx
Pq4Gyt4JfWM=
=RT5/
-----END PGP SIGNATURE-----

--=-o4n8v3fyw0ZZJRFdqmgr--

--===============1943730518192265152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1943730518192265152==--

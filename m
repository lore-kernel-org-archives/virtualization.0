From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH 01/10] core: Split out UFO6 support
Date: Wed, 17 Dec 2014 20:10:39 +0000
Message-ID: <1418847039.30883.29.camel__44383.8301035159$1418847085$gmane$org@decadent.org.uk>
References: <1418840455-22598-1-git-send-email-vyasevic@redhat.com>
	<1418840455-22598-2-git-send-email-vyasevic@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7290502508278052117=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418840455-22598-2-git-send-email-vyasevic@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vladislav Yasevich <vyasevich@gmail.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============7290502508278052117==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-6xuBJaCtt6FnniNcR7cU"


--=-6xuBJaCtt6FnniNcR7cU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2014-12-17 at 13:20 -0500, Vladislav Yasevich wrote:
> Split IPv6 support for UFO into its own feature similiar to TSO.
> This will later allow us to re-enable UFO support for virtio-net
> devices.
[...]
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 6c8b6f6..8538b67 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -372,6 +372,7 @@ enum {
> =20
>  	SKB_GSO_MPLS =3D 1 << 12,
> =20
> +	SKB_GSO_UDP6 =3D 1 << 13

It seems like it would be cleaner to use the names SKB_GSO_UDPV{4,6},
similarly to SKB_GSO_TCPV{4,6}.

>  };
> =20
>  #if BITS_PER_LONG > 32
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 945bbd0..fa4d2ee 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
[...]
> @@ -5952,24 +5958,21 @@ static netdev_features_t netdev_fix_features(stru=
ct net_device *dev,
[...]
> +	/* UFO also needs checksumming */
> +	if ((features & NETIF_F_UFO) && !(features & NETIF_F_GEN_CSUM) &&
> +					!(features & NETIF_F_IP_CSUM)) {

You can use !(features & NETIF_F_V4_CSUM) instead of the last two terms.

> +		netdev_dbg(dev,
> +			   "Dropping NETIF_F_UFO since no checksum offload features.\n");
> +		features &=3D ~NETIF_F_UFO;
> +	}
> +	if ((features & NETIF_F_UFO6) && !(features & NETIF_F_GEN_CSUM) &&
> +					 !(features & NETIF_F_IPV6_CSUM)) {
[...]

Similarly you can use !(features & NETIF_F_V6_CSUM) instead of the last
two terms.

Aside from those minor points, this looks fine.

Ben.

--=20
Ben Hutchings
Absolutum obsoletum. (If it works, it's out of date.) - Stafford Beer

--=-6xuBJaCtt6FnniNcR7cU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVJHjROe/yOyVhhEJAQqjbRAAkzv9Ent2gLMZa1lE5MVJKspcLFLXhRNo
Ng6yo3l0TBo53MdO47E43tMZf3+R4HlOCYIBWSrth5kZ+vG5M3wc81XClN4btTK5
VEnHPA9sNod3ZTKYYvoaFB9AmXRCu+v5P/+u2eM0s0VSiQO76rNovIMQ8dvQ7BWs
b792gb6WrmL+2phrE/6mm+Pdmd3TLY+EuA6hPdMQr9xWElyR9CrzwwZLLC99urdc
+r7yOf3V0jDfwqGdfmiesmf0fH6pWfq4f1C4zh2YgXgUeKP6Jh7tVvZ192AWucSM
mPQQ69UB2kMsu0TpP/1OH5r9Px9UMjuRVgiCBI9kEmzQCWlguNba7bLejZ5z40CJ
Wl1djSAwdy/e50nQYeMtyCHD4Yej6X6KbJeY3UHbiwV6YSrfSuZS0LcAgGwnoaU3
4AE5ZjXYFMasMk6rzLCD/SDBDLEYDuy+lU5gfnTH69fCqqnOeo48dPAK9IkFInGA
rnL67ZletU2d40izubk7yV5Gm7HpIBarbUKqDBJP8pO0kjyV0b601t2nrc5B8GGg
aP0HWc+5FbfO86le1I+FX5lAIFNrTDV3ub9VaszfdYzNTbYh+5qBLLVS477OLRNt
qZS/n4oxyShZds0AeOvEtCnGi/egwhoRIeI12PvDjN/+PDSpTFMcG+Kk3LxfUv/Y
RSwzlEqk/yE=
=p560
-----END PGP SIGNATURE-----

--=-6xuBJaCtt6FnniNcR7cU--

--===============7290502508278052117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7290502508278052117==--

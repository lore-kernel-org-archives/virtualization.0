From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 08/18] virtiofs: Drain all pending requests during
	->remove time
Date: Fri, 6 Sep 2019 11:52:10 +0100
Message-ID: <20190906105210.GP5900__34297.9445982323$1567767152$gmane$org@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
	<20190905194859.16219-9-vgoyal@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7323030670655801549=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190905194859.16219-9-vgoyal@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: miklos@szeredi.hu, mst@redhat.com, linux-kernel@vger.kernel.org, dgilbert@redhat.com, virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============7323030670655801549==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4IFtMBbmeqbTM/ox"
Content-Disposition: inline


--4IFtMBbmeqbTM/ox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2019 at 03:48:49PM -0400, Vivek Goyal wrote:
> +static void virtio_fs_drain_queue(struct virtio_fs_vq *fsvq)
> +{
> +	WARN_ON(fsvq->in_flight < 0);
> +
> +	/* Wait for in flight requests to finish.*/
> +	while (1) {
> +		spin_lock(&fsvq->lock);
> +		if (!fsvq->in_flight) {
> +			spin_unlock(&fsvq->lock);
> +			break;
> +		}
> +		spin_unlock(&fsvq->lock);
> +		usleep_range(1000, 2000);
> +	}

I think all contexts that call this allow sleeping so we could avoid
usleep here.

--4IFtMBbmeqbTM/ox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1yOloACgkQnKSrs4Gr
c8gmeQgAoJQJeQAjTj+aeNGzBdb4oLsqKKM6Q+4z3dqyaIM7pOTsdgiPZ/q1DA5U
3/e2c4UFDTEg+r9xvEx5FFgBiPFrpwGU3N8mroPEUY9yueCllNsIZmS0y8n76YDb
dCAPCksGMF4o9AWlHAMnxFoao+EfbsJd1mNU/7f7hFqFQoAuCu64321mwhqtOO+V
PXUqk6wTZtWxPAzvZCO93D4DuUfrW7jzHRNyvCvgPiJLCTU43uptr1PDJKuDCxAp
Sqpb5jJevhxuwbc84hIEnKY/0ERKxjky+XWBsHHc1Yy/CWAdNCyU0tW8OuUaG5+k
FF9UbW4BK3wqyzMhWOd/4jDbTz6oyA==
=x8L/
-----END PGP SIGNATURE-----

--4IFtMBbmeqbTM/ox--

--===============7323030670655801549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7323030670655801549==--

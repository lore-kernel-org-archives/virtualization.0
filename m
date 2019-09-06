From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 14/18] virtiofs: Add a fuse_iqueue operation to put()
	reference
Date: Fri, 6 Sep 2019 13:00:09 +0100
Message-ID: <20190906120009.GV5900__48658.6703731277$1567771259$gmane$org@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
	<20190905194859.16219-15-vgoyal@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4367025304054692416=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190905194859.16219-15-vgoyal@redhat.com>
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


--===============4367025304054692416==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OlucDFihBVSxvK/7"
Content-Disposition: inline


--OlucDFihBVSxvK/7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2019 at 03:48:55PM -0400, Vivek Goyal wrote:
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 85e2dcad68c1..04e2c000d63f 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -479,6 +479,11 @@ struct fuse_iqueue_ops {
>  	 */
>  	void (*wake_pending_and_unlock)(struct fuse_iqueue *fiq)
>  		__releases(fiq->waitq.lock);
> +
> +	/**
> +	 * Put a reference on fiq_priv.

I'm a bit confused about fiq->priv's role in this.  The callback takes
struct fuse_iqueue *fiq as the argument, not void *priv, so it could
theoretically do more than just release priv.

I think one of the following would be clearer:

 /**
  * Drop a reference to fiq->priv.
  */
 void (*put_priv)(void *priv);

Or:

 /**
  * Clean up when fuse_iqueue is destroyed.
  */
 void (*release)(struct fuse_iqueue *fiq);

In the second case fuse_conn_put() shouldn't check fiq->priv.

--OlucDFihBVSxvK/7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1ySkkACgkQnKSrs4Gr
c8ivNAf+NYLja/k2E1pzgRX+58rLDkzT6qfQX2XKwJVUqTns/MMKaTPd/OJkf+hW
4ubt3/0sb0kFtAsyffCUY7NiLFRWbanKCEZzP1RLN/ciK2l6bGJldM5TCC0AjMXi
waisC1VR9iopyR8dEIZpZZykVQEjY2CF2UvUJwzCBph382sQM25+a6OpUQ8N2FSI
7/7VMBVILOpdeBDum2QijFCXREuqvk0Si2Kg47nTq+muuOCD/mrGg7byV/pWPvyY
2l3YzL/W0S03phxm8SlNegD0jQ9nr8po2bcY1coriYMz6WSqxDbBwmbb9Izr3aXD
phrdP6+MgQk6AvUlXsmFd/yzwtYC4Q==
=lftV
-----END PGP SIGNATURE-----

--OlucDFihBVSxvK/7--

--===============4367025304054692416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4367025304054692416==--

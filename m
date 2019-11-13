From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 3/3] virtiofs: Use completions while waiting for queue to
	be drained
Date: Wed, 13 Nov 2019 14:40:02 +0000
Message-ID: <20191113144002.GB554680__45522.9334229202$1573656029$gmane$org@stefanha-x1.localdomain>
References: <20191030150719.29048-1-vgoyal@redhat.com>
	<20191030150719.29048-4-vgoyal@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1496840029369470473=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191030150719.29048-4-vgoyal@redhat.com>
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
Cc: miklos@szeredi.hu, linux-kernel@vger.kernel.org, dgilbert@redhat.com, virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============1496840029369470473==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline

--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2019 at 11:07:19AM -0400, Vivek Goyal wrote:
> While we wait for queue to finish draining, use completions instead of
> uslee_range(). This is better way of waiting for event.

s/uslee_range()/usleep_range()/

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3MFcIACgkQnKSrs4Gr
c8iVMQgAlnZ9d6GvnmORD+LRCvqgvHMMUlFoZS9nF/QBnEG7N4Pqr8BPRJw7Gi0D
uBdcZjReMZY2fG9ZNXoMA0ivvPUPa3eDEBeuXlQrp8Qw4yx32ciL9VYvKly8vvV2
2SMpOnsiuxDhldW2norjAP2piC7VCt+ni8x0yMTECQbaIfvrMhAxR/be/NWOj3pa
RIFzuyeB4yqi73m0yRXtuN4AwL8Fzq/R0NFAfZDlGSiDmhWJ+xIJpPiL4ZfwVBaK
hwzVPIkrA6TmDNNLtI7aCmVrQiA8lpnMH5FbKLmobmXjhedf4PwtiUEMSa3ESC6Y
lBzMsJ4gnruQmDefdEdC1G7ohBHzSg==
=47Ie
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--


--===============1496840029369470473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1496840029369470473==--

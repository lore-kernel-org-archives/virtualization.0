From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4] virtio_blk: add DISCARD and WRIET ZEROES commands
	support
Date: Thu, 31 May 2018 11:30:47 +0100
Message-ID: <20180531103047.GB27838@stefanha-x1.localdomain>
References: <1527558144-3825-1-git-send-email-changpeng.liu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5590708503658083436=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1527558144-3825-1-git-send-email-changpeng.liu@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: pbonzini@redhat.com, cavery@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============5590708503658083436==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 29, 2018 at 09:42:24AM +0800, Changpeng Liu wrote:
>  	num = blk_rq_map_sg(hctx->queue, req, vbr->sg);
>  	if (num) {
> -		if (rq_data_dir(req) == WRITE)
> +		if (rq_data_dir(req) == WRITE || type == VIRTIO_BLK_T_DISCARD ||
> +		    type == VIRTIO_BLK_T_WRITE_ZEROES)
>  			vbr->out_hdr.type |= cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_OUT);

The VIRTIO specification says:

  The type of the request is either a read (VIRTIO_BLK_T_IN), a write
  (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
  (VIRTIO_BLK_T_WRITE_ZEROES) or a flush (VIRTIO_BLK_T_FLUSH).

But this patch actually uses VIRTIO_BLK_T_DISCARD | VIRTIO_BLK_T_OUT or
VIRTIO_BLK_T_WRITE_ZEROES | VIRTIO_BLK_T_OUT.  "either A or B" is
exclusive, it does not mean "A and B".

Can you clarify whether the spec needs to be changed or what the purpose
of ORing in the VIRTIO_BLK_T_OUT bit is?

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbD87XAAoJEJykq7OBq3PIudYIAIKsYMpny06ZeH+7MOwasy8/
HyKWWBIPh+loSSEZEwnOQXl8zY+DKZCzTpJG3q2XuQSyF1U5NsuaDI/anBPMVxMA
qpKVGnuHjX/l87ygd6XRsR9YcK6gMo0fAdBacRKO/NLEOxWY+8p2SrKqux8pi2Vj
4nK97JhWnX0w/sCIWE0xps5GZkXaxTMLwKC0rhdNgMT1DpISudS9Hsgek4EpcKy2
UXCHzFFn+NilPdR9aij0w5r80kI4ZiFA8/usRT55lKwo6tfAJCWuqB10qrf2wrwI
ONxZ5goMsvcuJzVdCDDEat846ClsaWuCjSQ/i1RtcFlhp4S+wbzlOMmFNYW39Tk=
=syYk
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--

--===============5590708503658083436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5590708503658083436==--

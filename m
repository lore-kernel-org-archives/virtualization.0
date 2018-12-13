From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 2/5] VSOCK: support fill data to mergeable rx buffer
	in host
Date: Thu, 13 Dec 2018 15:49:23 +0000
Message-ID: <20181213154923.GN23318__40228.74097941$1544716059$gmane$org@stefanha-x1.localdomain>
References: <5C10D4FB.6070009@huawei.com>
	<20181212103138-mutt-send-email-mst@kernel.org>
	<5C11CD14.3040809@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3882740791103829292=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5C11CD14.3040809@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jiangyiwen <jiangyiwen@huawei.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============3882740791103829292==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="citGix+cyBYE+lqp"
Content-Disposition: inline


--citGix+cyBYE+lqp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 11:08:04AM +0800, jiangyiwen wrote:
> On 2018/12/12 23:37, Michael S. Tsirkin wrote:
> > On Wed, Dec 12, 2018 at 05:29:31PM +0800, jiangyiwen wrote:
> >> When vhost support VIRTIO_VSOCK_F_MRG_RXBUF feature,
> >> it will merge big packet into rx vq.
> >>
> >> Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
> >=20
> > I feel this approach jumps into making interface changes for
> > optimizations too quickly. For example, what prevents us
> > from taking a big buffer, prepending each chunk
> > with the header and writing it out without
> > host/guest interface changes?
> >=20
> > This should allow optimizations such as vhost_add_used_n
> > batching.
> >=20
> > I realize a header in each packet does have a cost,
> > but it also has advantages such as improved robustness,
> > I'd like to see more of an apples to apples comparison
> > of the performance gain from skipping them.
> >=20
> >=20
>=20
> Hi Michael,
>=20
> I don't fully understand what you mean, do you want to
> see a performance comparison that before performance and
> only use batching?
>=20
> In my opinion, guest don't fill big buffer in rx vq because
> the balance performance and guest memory pressure, add
> mergeable feature can improve big packets performance,
> as for small packets, I try to find out the reason, may be
> the fluctuation of test results, or in mergeable mode, when
> Host send a 4k packet to Guest, we should call vhost_get_vq_desc()
> twice in host(hdr + 4k data), and in guest we also should call
> virtqueue_get_buf() twice.

I like the idea of making optimizations in small steps and measuring the
effect of each step.  This way we'll know which aspect caused the
differences in benchmark results.

Stefan

--citGix+cyBYE+lqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcEn+DAAoJEJykq7OBq3PI88EH/j8nz2j/p2Yg2w62DjCcZVky
DPaHNwVkFHuMxrjcBoaimYPfADxtei9YWMvuXm1YwkHYA9RnPJE1RnqkAn+Dfrsp
ZpwxqfGL1+mdJjzpvNhntZKNwd8GL//s/OA+4DJv4nkZNqQKTkAfklQfTe6JVKko
lBHJcRNBYlPA35//cO1n1Qrt+4cB9Z2e8HvBVYnWJsz0kAKbJ9AlsbESgClE+mZc
pU43NI5FE7YspbqFmU3kX3akQYtSWw6DSsLQ31fO5+PZiQpYeHuVikFOGlN1RgBn
jG0bGLCxMR1gY+9nbYdI6xPadfHeRhR4k9/BI//T0vwzr7P+cgvMsR/CS8F9X9A=
=TjD8
-----END PGP SIGNATURE-----

--citGix+cyBYE+lqp--

--===============3882740791103829292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3882740791103829292==--

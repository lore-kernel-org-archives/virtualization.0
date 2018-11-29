From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 0/5] VSOCK: support mergeable rx buffer in vhost-vsock
Date: Thu, 29 Nov 2018 14:19:28 +0000
Message-ID: <20181129141928.GC17554@stefanha-x1.localdomain>
References: <5BDFF49C.3040603@huawei.com>
	<b9d535f8-ddc3-a4bc-21c9-ca21e808f0d1@redhat.com>
	<5BE0F9C9.2080003@huawei.com>
	<b4ce06c8-1c4b-724f-52e8-cb8d7b23fd27@redhat.com>
	<5BE107B5.2050900@huawei.com>
	<229559d5-1787-09b1-6c26-57b535f20006@redhat.com>
	<5BE12C72.6000204@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2625636413438673550=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5BE12C72.6000204@huawei.com>
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
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============2625636413438673550==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
Content-Disposition: inline


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 06, 2018 at 01:53:54PM +0800, jiangyiwen wrote:
> On 2018/11/6 11:32, Jason Wang wrote:
> >=20
> > On 2018/11/6 =E4=B8=8A=E5=8D=8811:17, jiangyiwen wrote:
> >> On 2018/11/6 10:41, Jason Wang wrote:
> >>> On 2018/11/6 =E4=B8=8A=E5=8D=8810:17, jiangyiwen wrote:
> >>>> On 2018/11/5 17:21, Jason Wang wrote:
> >>>>> On 2018/11/5 =E4=B8=8B=E5=8D=883:43, jiangyiwen wrote:
> >>>>>> Now vsock only support send/receive small packet, it can't achieve
> >>>>>> high performance. As previous discussed with Jason Wang, I revisit=
 the
> >>>>>> idea of vhost-net about mergeable rx buffer and implement the merg=
eable
> >>>>>> rx buffer in vhost-vsock, it can allow big packet to be scattered =
in
> >>>>>> into different buffers and improve performance obviously.
> >>>>>>
> >>>>>> I write a tool to test the vhost-vsock performance, mainly send big
> >>>>>> packet(64K) included guest->Host and Host->Guest. The result as
> >>>>>> follows:
> >>>>>>
> >>>>>> Before performance:
> >>>>>>                  Single socket            Multiple sockets(Max Ban=
dwidth)
> >>>>>> Guest->Host   ~400MB/s                 ~480MB/s
> >>>>>> Host->Guest   ~1450MB/s                ~1600MB/s
> >>>>>>
> >>>>>> After performance:
> >>>>>>                  Single socket            Multiple sockets(Max Ban=
dwidth)
> >>>>>> Guest->Host   ~1700MB/s                ~2900MB/s
> >>>>>> Host->Guest   ~1700MB/s                ~2900MB/s
> >>>>>>
> >>>>>>    From the test results, the performance is improved obviously, a=
nd guest
> >>>>>> memory will not be wasted.
> >>>>> Hi:
> >>>>>
> >>>>> Thanks for the patches and the numbers are really impressive.
> >>>>>
> >>>>> But instead of duplicating codes between sock and net. I was consid=
ering to use virtio-net as a transport of vsock. Then we may have all exist=
ed features likes batching, mergeable rx buffers and multiqueue. Want to co=
nsider this idea? Thoughts?
> >>>>>
> >>>>>
> >>>> Hi Jason,
> >>>>
> >>>> I am not very familiar with virtio-net, so I am afraid I can't give =
too
> >>>> much effective advice. Then I have several problems:
> >>>>
> >>>> 1. If use virtio-net as a transport, guest should see a virtio-net
> >>>> device instead of virtio-vsock device, right? Is vsock only as a
> >>>> transport between socket and net_device? User should still use
> >>>> AF_VSOCK type to create socket, right?
> >>>
> >>> Well, there're many choices. What you need is just to keep the socket=
 API and hide the implementation. For example, you can keep the vosck devic=
e in guest and switch to use vhost-net in host. We probably need a new feat=
ure bit or header to let vhost know we are passing vsock packet. And vhost-=
net could forward the packet to vsock core on host.
> >>>
> >>>
> >>>> 2. I want to know if this idea has already started, and how is
> >>>> the current progress?
> >>>
> >>> Not yet started.  Just want to listen from the community. If this sou=
nds good, do you have interest in implementing this?
> >>>
> >>>
> >>>> 3. And what is stefan's idea?
> >>>
> >>> Talk with Stefan a little on this during KVM Forum. I think he tends =
to agree on this idea. Anyway, let's wait for his reply.
> >>>
> >>>
> >>> Thanks
> >>>
> >>>
> >> Hi Jason,
> >>
> >> Thanks your reply, what you want is try to avoid duplicate code, and s=
till
> >> use the existed features with virtio-net.
> >=20
> >=20
> > Yes, technically we can use virtio-net driver is guest as well but we c=
ould do it step by step.
> >=20
> >=20
> >> Yes, if this sounds good and most people can recognize this idea, I am=
 very
> >> happy to implement this.
> >=20
> >=20
> > Cool, thanks.
> >=20
> >=20
> >>
> >> In addition, I hope you can review these patches before the new idea is
> >> implemented, after all the performance can be improved. :-)
> >=20
> >=20
> > Ok.
> >=20
> >=20
> > So the patch actually did three things:
> >=20
> > - mergeable buffer implementation
> >=20
> > - increase the default rx buffer size
> >=20
> > - add used and signal guest in a batch
> >=20
> > It would be helpful if you can measure the performance improvement inde=
pendently. This can give reviewer a better understanding on how much did ea=
ch part help.
> >=20
> > Thanks
> >=20
> >=20
>=20
> Great, I will test the performance independently in the later version.

I'm catching up on email so maybe you've already discussed this, but a
key design point in virtio-vsock is reliable in-order delivery.  When
using virtio-net code it's important to keep those properties so that
AF_VSOCK SOCK_STREAM sockets work as expected.  Packets must not be
reordered or dropped.

In addition, there's the virtio-vsock flow control scheme that allows
multiple sockets to share a ring without starvation or denial-of-service
problems.  The guest knows how much socket buffer space is available on
the host (and vice versa).  A well-behaved guest only sends up to the
available buffer space so that the host can copy the data into the
socket buffer and free up ring space for other sockets.  This scheme is
how virtio-vsock achieves guaranteed delivery while avoiding starvation
or denial-of-service.

So you'll need to use some kind of framing (protocol) that preserves
these properties on top of virtio-net.  This framing could be based on
virtio-vsock's packet headers.

Stefan

--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb//VvAAoJEJykq7OBq3PIXVMIALRFVOEPu8o5ufxAnxdqbYIy
ZKy6L7Zoqt60JL0uMuGdoI2hm2vaZD3waoafCmv69Rj0iuwTAPa8gpdj3OLR+bDq
7ckNaNfmGx8daS41B4UZQ0PEhhz93JlzOyWyLDDvZPxlW1xX2E4G9zfFV8fF7ywi
X9XcKW845j3Xu26Buy+J5yVRyj/ycb7YTpt8rHgmZ2PxBTQSxVTAXrRUHIr+WZaS
2DqsvWn5c4oaXZLUsQn/Q4lzO1Fz8CpL0Gu9pUd8W6gcPO01SBK33u4sm5vKAjYM
eZ0O470xjDpjYkLGKeR73Xtrh7OuatXma++qqlVWaXRXph6e4c002TEuWzHvV98=
=0hK5
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--

--===============2625636413438673550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2625636413438673550==--

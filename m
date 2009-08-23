From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv3 0/4] qemu-kvm: vhost net support
Date: Sun, 23 Aug 2009 22:45:39 +0300
Message-ID: <20090823194539.GB29928__47016.5247134448$1251056965$gmane$org@redhat.com>
References: <20090817123701.GA10700@redhat.com>
	<7162ab20908181354g653ecd2ch3b3dc36ca16babff@mail.gmail.com>
	<20090818210411.GD20393@redhat.com>
	<7162ab20908181411q4209d1f7v64b263712fd74852@mail.gmail.com>
	<7162ab20908181423l65f30744vc9a968c0e546a361@mail.gmail.com>
	<20090820070321.GA5448@redhat.com>
	<7162ab20908201505o41240db2l1c67dc5343589396@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <7162ab20908201505o41240db2l1c67dc5343589396@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alex Williamson <alex.williamson@hp.com>
Cc: avi@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

OK, there is a small issue with networking setup here, but otherwise it
looks like we'll have to debug it in vhost ...

Forgot to ask - dmesg does not show anything interesting, does it?

On Thu, Aug 20, 2009 at 04:05:04PM -0600, Alex Williamson wrote:
> On Thu, Aug 20, 2009 at 1:03 AM, Michael S. Tsirkin<mst@redhat.com> wrote:
> >
> > I think the duplicates are our best hint that something's wrong at this
> > point. Let's try to see where do they come from.
> >
> > What is it exactly that you see?
> =

> # ping 10.100.100.74
> PING 10.100.100.74 (10.100.100.74) 56(84) bytes of data.
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D0.263 ms
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D0.358 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D0.394 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D0.478 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D0.626 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D0.727 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D0.834 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D0.909 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D0.997 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D1.08 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D1.12 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D1.18 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D1.29 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D1.38 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D1.46 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D1.55 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D1.56 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D1.65 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D1.68 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D1.70 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D1.83 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D1.89 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D1.95 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D1.98 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D2.08 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D2.22 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D2.27 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D2.31 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D2.44 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D2.50 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D2.51 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D2.57 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D2.63 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D2.76 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D2.81 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D2.84 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D2.90 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D2.94 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D3.02 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D3.06 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D3.09 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D3.15 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D3.17 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D3.24 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D3.28 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D3.35 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D3.37 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D3.44 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D3.47 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D3.54 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D3.57 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D3.64 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D3.67 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D3.75 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D3.77 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D3.84 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D3.87 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D3.94 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D3.98 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D4.04 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D4.07 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D4.15 ms (DUP!)
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D4.17 ms (DUP!)
> >From 10.91.73.253 icmp_seq=3D1 Time to live exceeded
> 64 bytes from 10.100.100.74: icmp_seq=3D1 ttl=3D64 time=3D4.26 ms (DUP!)
> ^C
> --- 10.100.100.74 ping statistics ---
> 1 packets transmitted, 1 received, +63 duplicates, +1 errors, 0%
> packet loss, time 0ms
> rtt min/avg/max/mdev =3D 0.263/2.481/4.266/1.147 ms
> =

> > This ping is external box to guest,
> > correct?
> =

> Either direction, external box->guest or guest->external box

Yes, one way you get duplicate replies, the other way duplicate
requests.

> > Is it the external box that gets duplicates or the guest?
> > What happens when you ping the other way?
> > What does tcpdump show on both sides when you ping?
> =

> ping -c 1 guest (10.100.100.74) -> external (10.91.73.252) (these are
> on the same subnet)
> =

> guest:
> 15:29:51.342545 IP 10.100.100.74 > 10.91.73.252: ICMP echo request, id
> 64778, seq 1, length 64
> 15:29:51.342716 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.342734 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.342799 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.342835 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.342909 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.342955 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.343004 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.343043 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.343105 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.343151 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.343277 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.343293 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.343355 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.343403 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.343524 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.343550 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.343604 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.343654 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.343770 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.343795 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.343857 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.343898 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.343968 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.343980 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.344052 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.344103 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.344225 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.344250 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.344302 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.344351 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.344470 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.344495 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.344550 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.344599 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.344689 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.344709 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.344749 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.344798 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.344890 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.344910 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.344949 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.344997 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.345061 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.345100 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.345153 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.345207 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.345295 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.345315 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.345352 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.345402 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.345491 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.345510 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.345552 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.345601 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.345692 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.345712 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.345790 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.345806 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.345867 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.345886 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.345947 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.345996 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.346083 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:29:51.346103 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64

OK, but now, could you please run tcpdump -i eth10 on host
so that we can check whether these duplicates arrived from outside?


> external:
> 15:24:25.892748 IP 10.100.100.74 > 10.91.73.252: ICMP echo request, id
> 64778, seq 1, length 64
> 15:24:25.892770 IP 10.91.73.252 > 10.100.100.74: ICMP echo reply, id
> 64778, seq 1, length 64
> 15:24:25.896254 IP 10.91.73.253 > 10.91.73.252: ICMP time exceeded
> in-transit, length 92
> (note 253 is the IP address of eth0 on the KVM host... odd)

This might mean you enabled ipv4 forwarding on KVM host,
so it tried to forward the packet on and could not.
Try disabling it?

> ping -c 1 external (10.91.73.252) -> guest (10.100.100.74)
> =

> external:
> 15:28:38.278291 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:28:38.278590 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.278760 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.278881 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.279024 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.279064 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.279157 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.279180 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.279299 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.279319 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.279361 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.279457 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.279478 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.279567 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.279612 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.279693 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.279738 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.279786 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.279877 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.279991 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.280000 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.280085 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.280105 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.280173 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.280202 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.280228 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.280271 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.280312 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.280401 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.280447 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.280534 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.280548 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.280581 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.280634 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.280766 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.280773 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.280805 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.280855 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.280902 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.280934 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.281014 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.281064 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.281113 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.281159 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.281215 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.281253 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.281300 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.281344 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.281408 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.281447 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.281503 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.281542 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.281644 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.281670 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.281723 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.281763 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.281816 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.281847 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.281918 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.281937 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.282059 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.282086 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.282153 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.282159 IP 10.91.73.253 > 10.91.73.252: ICMP time exceeded
> in-transit, length 92
> 15:28:38.282175 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:28:38.282204 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> =

> guest:
> 15:34:03.722851 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.722880 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.723023 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.723050 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64

So, it is again the guest that gets duplicates.
If it's a bug in vhost, it's a problem on RX path.

> 15:34:03.723155 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.723165 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.723305 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.723316 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.723340 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.723349 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.723442 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.723452 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.723469 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.723478 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.723578 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.723588 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.723613 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.723623 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.723639 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.723658 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.723744 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.723753 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.723768 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.723776 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.723855 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.723864 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.723907 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.723916 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.723971 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.723981 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.724004 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.724013 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.724067 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.724078 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.724161 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.724171 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.724249 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.724258 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.724275 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.724284 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.724362 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.724371 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.724393 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.724402 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.724457 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.724467 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.724491 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.724500 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.724529 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.724538 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.724561 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.724570 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.724599 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.724608 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.724663 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.724683 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.724726 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.724737 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.724783 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.724806 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.724838 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.724848 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.724882 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.724891 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.724917 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.724925 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.725015 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.725027 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.725063 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.725080 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.725084 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.725102 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.725136 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.725156 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.725186 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.725199 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.725222 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.725230 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.725296 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.725308 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.725352 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.725360 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.725408 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.725416 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.725442 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.725450 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.725497 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.725505 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.725537 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.725545 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.725577 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.725596 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.725629 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.725637 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.725691 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.725701 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.725737 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.725744 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.725777 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.725797 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.725829 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.725837 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.725913 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.725924 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.725961 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.725969 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.726009 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.726016 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.726050 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.726058 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.726100 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.726107 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.726136 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.726143 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.726176 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.726195 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.726228 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.726235 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.726333 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.726343 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.726378 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.726385 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.726424 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.726431 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.726465 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.726473 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64
> 15:34:03.726505 IP 10.91.73.252 > 10.100.100.74: ICMP echo request, id
> 30800, seq 1, length 64
> 15:34:03.726512 IP 10.100.100.74 > 10.91.73.252: ICMP echo reply, id
> 30800, seq 1, length 64

So, to eliminate networking setup issues, could you please use Or's
patch to map raw networking device to virtio in userspace?
(Don't forget to add promisc=3Dn otherwise it'll set your card
 in promisc mode).

> > A couple of extra datapoints to check:
> > - What if you assign a different IP to the host (in the same subnet) and
> > =A0try external guest to host?
> =

> I'm not sure what you mean by external guest.  If I change the IP of
> the host, nothing changes except the time exceeed messages seen by the
> external system have the new IP.

Sorry, I just meant ping from external to KVM host.
But based on this data I do not expect any dups.

> > - Is the card in promisc mode? What if you disable promisc mode?
> =

> No, I'm using the physical MAC in the guest to avoid promisc.
> =

> > Also, it seems that you have an external bridge that sends your outgoing
> > packets back to you. Is that right?
> =

> Not that I'm aware of.  My config is simply:
> =

> eth0 - host nic
> eth10 - vhost nic
> =

> I can ifdown eth0 and switch the host to eth10 and don't get duplicate
> packets on host<->external pings.  Thanks,
> =

> Alex

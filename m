From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH] qemu: Introduce
	VIRTIO_NET_F_STANDBY feature bit to virtio_net
Date: Tue, 26 Jun 2018 18:38:51 +0300
Message-ID: <20180626183706-mutt-send-email-mst__10813.6566392661$1530027428$gmane$org@kernel.org>
References: <CADGSJ23SBEFJCD50K-F-Gt86Q1-i_6iHTmSSjdXDzNnnpWZ_oQ@mail.gmail.com>
	<CADGSJ22nLcz_XaJNzUUdpjQaJY8b5wZs=ohm=B7c2qf2K7_yGA@mail.gmail.com>
	<20180623002628-mutt-send-email-mst@kernel.org>
	<CADGSJ20td7b6He6S1PBSJjCq=bNvgqMGbOjiho2eeQm2pgpK3g@mail.gmail.com>
	<20180623012406-mutt-send-email-mst@kernel.org>
	<CADGSJ211pWKYnuuzcgUqJZiHU+=7H3oQSpp1TnE=+EBjkdmCSQ@mail.gmail.com>
	<CADGSJ22DX8=rNPY+gNS_q=LCYLR5ieoE7oD8p4+8AnpzQsWSCg@mail.gmail.com>
	<da144f8f-65cd-45d9-3c81-6c8ca1fb25fe@intel.com>
	<20180626044650-mutt-send-email-mst@kernel.org>
	<20180626171732.5038f53f.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180626171732.5038f53f.cohuck@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, konrad.wilk@oracle.com, Jakub Kicinski <kubakici@wp.pl>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, Venu Busireddy <venu.busireddy@oracle.com>, Netdev <netdev@vger.kernel.org>, boris.ostrovsky@oracle.com, aaron.f.brown@intel.com, Joao Martins <joao.m.martins@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 26, 2018 at 05:17:32PM +0200, Cornelia Huck wrote:
> On Tue, 26 Jun 2018 04:50:25 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> =

> > On Mon, Jun 25, 2018 at 10:54:09AM -0700, Samudrala, Sridhar wrote:
> > > > > > > Might not neccessarily be something wrong, but it's very limi=
ted to
> > > > > > > prohibit the MAC of VF from changing when enslaved by failove=
r.  =

> > > > > > You mean guest changing MAC? I'm not sure why we prohibit that.=
  =

> > > > > I think Sridhar and Jiri might be better person to answer it. My
> > > > > impression was that sync'ing the MAC address change between all 3
> > > > > devices is challenging, as the failover driver uses MAC address to
> > > > > match net_device internally.  =

> > > =

> > > Yes. The MAC address is assigned by the hypervisor and it needs to ma=
nage the movement
> > > of the MAC between the PF and VF.=A0 Allowing the guest to change the=
 MAC will require
> > > synchronization between the hypervisor and the PF/VF drivers. Most of=
 the VF drivers
> > > don't allow changing guest MAC unless it is a trusted VF.  =

> > =

> > OK but it's a policy thing. Maybe it's a trusted VF. Who knows?
> > For example I can see host just
> > failing VIRTIO_NET_CTRL_MAC_ADDR_SET if it wants to block it.
> > I'm not sure why VIRTIO_NET_F_STANDBY has to block it in the guest.
> > =

> =

> So, what I get from this is that QEMU needs to be able to control all
> of standby, uuid, and mac to accommodate the different setups
> (respectively have libvirt/management software set it up). Is the host
> able to find out respectively define whether a VF is trusted?

You do it with ip link I think but QEMU doesn't normally do this,
it relies on libvirt to poke at host kernel and supply the info.

-- =

MST

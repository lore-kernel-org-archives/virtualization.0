From: Vivek Thampi <vithampi@vmware.com>
Subject: Re: [PATCH RESEND] ptp: add VMware virtual PTP clock driver
Date: Thu, 5 Mar 2020 04:47:28 +0000
Message-ID: <20200305044713.GA173879@sc2-cpbu2-b0737.eng.vmware.com>
References: <20200228053230.GA457139@sc2-cpbu2-b0737.eng.vmware.com>
 <20200304.140410.731261448085906331.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200304.140410.731261448085906331.davem@davemloft.net>
Content-Language: en-US
Content-ID: <C0CC8BFB48469A448048072E8EA83764@namprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: "richardcochran@gmail.com" <richardcochran@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Pv-drivers <Pv-drivers@vmware.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "x86@kernel.org" <x86@kernel.org>, Thomas Hellstrom <thellstrom@vmware.com>, "jgross@suse.com" <jgross@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

Thanks for taking a look, David.

On Wed, Mar 04, 2020 at 02:04:10PM -0800, David Miller wrote:
> From: Vivek Thampi <vithampi@vmware.com>
> Date: Fri, 28 Feb 2020 05:32:46 +0000
>=20
> > Add a PTP clock driver called ptp_vmw, for guests running on VMware ESX=
i
> > hypervisor. The driver attaches to a VMware virtual device called
> > "precision clock" that provides a mechanism for querying host system ti=
me.
> > Similar to existing virtual PTP clock drivers (e.g. ptp_kvm), ptp_vmw
> > utilizes the kernel's PTP hardware clock API to implement a clock devic=
e
> > that can be used as a reference in Chrony for synchronizing guest time =
with
> > host.
> >=20
> > The driver is only applicable to x86 guests running in VMware virtual
> > machines with precision clock virtual device present. It uses a VMware
> > specific hypercall mechanism to read time from the device.
> >=20
> > Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
> > Signed-off-by: Vivek Thampi <vithampi@vmware.com>
> > ---
> >  Based on feedback, resending patch to include a broader audience.
>=20
> If it's just providing a read of an accurate timesource, I think it's kin=
da
> pointless to provide a full PTP driver for it.

The point of a PTP driver for this timesource is to provide an interface
that can be consumed by Chrony (and possibly other applications) as a
reference clock for time sync. This is admittedly a very basic first
step providing just PTP_SYS_OFFSET functionality (which gets us to <1us
VM-host time sync). Down the line, I also intend to introduce
cross-timestamping for more precise offsets.

Using the PHC infrastructure seems like a good fit for this, but please
let me know if I'm missing something or misinterpreting your comment.

Thanks.

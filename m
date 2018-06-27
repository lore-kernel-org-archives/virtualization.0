From: Siwei Liu <loseweigh@gmail.com>
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH] qemu: Introduce
	VIRTIO_NET_F_STANDBY feature bit to virtio_net
Date: Tue, 26 Jun 2018 23:21:04 -0700
Message-ID: <CADGSJ22Sv_AFUkDou6hdq9++RNC40BTB-puS9209tOqzGLFJ-g__7945.87731729752$1530080347$gmane$org@mail.gmail.com>
References: <CADGSJ23SBEFJCD50K-F-Gt86Q1-i_6iHTmSSjdXDzNnnpWZ_oQ@mail.gmail.com>
	<CADGSJ22nLcz_XaJNzUUdpjQaJY8b5wZs=ohm=B7c2qf2K7_yGA@mail.gmail.com>
	<20180623002628-mutt-send-email-mst@kernel.org>
	<CADGSJ20td7b6He6S1PBSJjCq=bNvgqMGbOjiho2eeQm2pgpK3g@mail.gmail.com>
	<20180623012406-mutt-send-email-mst@kernel.org>
	<CADGSJ211pWKYnuuzcgUqJZiHU+=7H3oQSpp1TnE=+EBjkdmCSQ@mail.gmail.com>
	<CADGSJ22DX8=rNPY+gNS_q=LCYLR5ieoE7oD8p4+8AnpzQsWSCg@mail.gmail.com>
	<da144f8f-65cd-45d9-3c81-6c8ca1fb25fe@intel.com>
	<20180626044650-mutt-send-email-mst@kernel.org>
	<CADGSJ204fgdnafRsrzMVh+SeBCj3-z_twS9B+7g8iiOaUQGW5g@mail.gmail.com>
	<20180627032825-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180627032825-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, konrad.wilk@oracle.com, Jakub Kicinski <kubakici@wp.pl>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Venu Busireddy <venu.busireddy@oracle.com>, Netdev <netdev@vger.kernel.org>, boris.ostrovsky@oracle.com, aaron.f.brown@intel.com, Joao Martins <joao.m.martins@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 26, 2018 at 5:29 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Jun 26, 2018 at 04:38:26PM -0700, Siwei Liu wrote:
>> On Mon, Jun 25, 2018 at 6:50 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > On Mon, Jun 25, 2018 at 10:54:09AM -0700, Samudrala, Sridhar wrote:
>> >> > > > > Might not neccessarily be something wrong, but it's very limited to
>> >> > > > > prohibit the MAC of VF from changing when enslaved by failover.
>> >> > > > You mean guest changing MAC? I'm not sure why we prohibit that.
>> >> > > I think Sridhar and Jiri might be better person to answer it. My
>> >> > > impression was that sync'ing the MAC address change between all 3
>> >> > > devices is challenging, as the failover driver uses MAC address to
>> >> > > match net_device internally.
>> >>
>> >> Yes. The MAC address is assigned by the hypervisor and it needs to manage the movement
>> >> of the MAC between the PF and VF.  Allowing the guest to change the MAC will require
>> >> synchronization between the hypervisor and the PF/VF drivers. Most of the VF drivers
>> >> don't allow changing guest MAC unless it is a trusted VF.
>> >
>> > OK but it's a policy thing. Maybe it's a trusted VF. Who knows?
>> > For example I can see host just
>> > failing VIRTIO_NET_CTRL_MAC_ADDR_SET if it wants to block it.
>> > I'm not sure why VIRTIO_NET_F_STANDBY has to block it in the guest.
>>
>> That's why I think pairing using MAC is fragile IMHO. When VF's MAC
>> got changed before virtio attempts to match and pair the device, it
>> ends up with no pairing found out at all.
>
> Guest seems to match on the hardware mac and ignore whatever
> is set by user. Makes sense to me and should not be fragile.
Host can change the hardware mac for VF any time.

-Siwei
>
>
>> UUID is better.
>>
>> -Siwei
>>
>> >
>> > --
>> > MST

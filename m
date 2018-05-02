From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next v9 3/4] virtio_net: Extend virtio to use VF
	datapath when available
Date: Wed, 2 May 2018 09:50:21 +0200
Message-ID: <20180502075021.GC19250__10632.1988896982$1525247304$gmane$org@nanopsycho>
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
	<1524848820-42258-4-git-send-email-sridhar.samudrala@intel.com>
	<20180428094205.GM5632@nanopsycho.orion>
	<638e52c7-64db-9d8d-7530-f6b000d3e292@intel.com>
	<20180430072034.GH23854@nanopsycho.orion>
	<9c6f055c-c665-0601-3973-bce74d72544b@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <9c6f055c-c665-0601-3973-bce74d72544b@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Wed, May 02, 2018 at 02:20:26AM CEST, sridhar.samudrala@intel.com wrote:
>On 4/30/2018 12:20 AM, Jiri Pirko wrote:
>> =

>> > > Now I try to change mac of the failover master:
>> > > [root@test1 ~]# ip link set ens3 addr 52:54:00:b2:a7:f3
>> > > RTNETLINK answers: Operation not supported
>> > > =

>> > > That I did expect to work. I would expect this would change the mac =
of
>> > > the master and both standby and primary slaves.
>> > If a VF is untrusted, a VM will not able to change its MAC and moreover
>> Note that at this point, I have no VF. So I'm not sure why you mention
>> that.
>> =

>> =

>> > in this mode we are assuming that the hypervisor has assigned the MAC =
and
>> > guest is not expected to change the MAC.
>> Wait, for ordinary old-fashioned virtio_net, as a VM user, I can change
>> mac and all works fine. How is this different? Change mac on "failover
>> instance" should work and should propagate the mac down to its slaves.
>> =

>> =

>> > For the initial implementation, i would propose not allowing the guest=
 to
>> > change the MAC of failover or standby dev.
>> I see no reason for such restriction.
>> =

>
>It is true that a VM user can change mac address of a normal virtio-net in=
terface,
>however when it is in STANDBY mode i think we should not allow this change=
 specifically
>because we are creating a failover instance based on a MAC that is assigne=
d by the
>hypervisor.
>
>Moreover,=A0 in a cloud environment i would think that PF/hypervisor assig=
ns a MAC to
>the VF and it cannot be changed by the guest.

So that is easy. You allow the change of the mac and in the "failover"
mac change implementation you propagate the change down to slaves. If
one slave does not support the change, you bail out. And since VF does
not allow it as you say, once it will be enslaved, the mac change could
not be done. Seems like a correct behavior to me and is in-sync with how
bond/team behaves.


>
>So for the initial implementation, do you see any issues with having this =
restriction
>in STANDBY mode.
>
>

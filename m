From: Siwei Liu <loseweigh@gmail.com>
Subject: Re: [virtio-dev] Re: [RFC PATCH 1/3] qemu: virtio-bypass should
	explicitly bind to a passthrough device
Date: Fri, 6 Apr 2018 19:54:33 -0700
Message-ID: <CADGSJ22Zqm1s2Xr=i4G7upp4mZRHz4HEQGVvzNjBTcdCQ4hoDw__11527.068905025$1523069563$gmane$org@mail.gmail.com>
References: <1522573990-5242-1-git-send-email-si-wei.liu@oracle.com>
	<1522573990-5242-2-git-send-email-si-wei.liu@oracle.com>
	<20180403152308-mutt-send-email-mst@kernel.org>
	<CADGSJ23jr7xrq8h9rFHLtXkbpsB+AK8wcUzOQnpeftbhiYdOvA@mail.gmail.com>
	<d666b8a9-9ff8-4a56-0faa-ef3d0bf81d25@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <d666b8a9-9ff8-4a56-0faa-ef3d0bf81d25@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, "Samudrala,
	Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, Si-Wei Liu <si-wei.liu@oracle.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

(click the wrong reply button again, sorry)


On Thu, Apr 5, 2018 at 8:31 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 04/04/2018 10:02, Siwei Liu wrote:
>>> pci_bus_num is almost always a bug if not done within
>>> a context of a PCI host, bridge, etc.
>>>
>>> In particular this will not DTRT if run before guest assigns bus
>>> numbers.
>>>
>> I was seeking means to reserve a specific pci bus slot from drivers,
>> and update the driver when guest assigns the bus number but it seems
>> there's no low-hanging fruits. Because of that reason the bus_num is
>> only obtained until it's really needed (during get_config) and I
>> assume at that point the pci bus assignment is already done. I know
>> the current one is not perfect, but we need that information (PCI
>> bus:slot.func number) to name the guest device correctly.
>
> Can you use the -device "id", and look it up as
>
>     devices = container_get(qdev_get_machine(), "/peripheral");
>     return object_resolve_path_component(devices, id);


No. The problem of using device id is that the vfio device may come
and go at any time, this is particularly true when live migration is
happening. There's no gurantee we can get the bus:device.func info if
that device is gone. Currently the binding between vfio and virtio-net
is weakly coupled through the backup property, there's no better way
than specifying the bus id and addr property directly.

Regards,
-Siwei

>
> ?
>
> Thanks,
>
> Paolo

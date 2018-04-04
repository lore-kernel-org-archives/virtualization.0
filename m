From: Siwei Liu <loseweigh@gmail.com>
Subject: Re: [virtio-dev] Re: [RFC PATCH 1/3] qemu: virtio-bypass should
	explicitly bind to a passthrough device
Date: Wed, 4 Apr 2018 01:02:37 -0700
Message-ID: <CADGSJ23jr7xrq8h9rFHLtXkbpsB+AK8wcUzOQnpeftbhiYdOvA__16631.6834780902$1522828861$gmane$org@mail.gmail.com>
References: <1522573990-5242-1-git-send-email-si-wei.liu@oracle.com>
	<1522573990-5242-2-git-send-email-si-wei.liu@oracle.com>
	<20180403152308-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180403152308-mutt-send-email-mst@kernel.org>
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
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, "Samudrala,
	Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, Si-Wei Liu <si-wei.liu@oracle.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 3, 2018 at 5:25 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Sun, Apr 01, 2018 at 05:13:08AM -0400, Si-Wei Liu wrote:
>> @@ -896,6 +898,68 @@ void qmp_device_del(const char *id, Error **errp)
>>      }
>>  }
>>
>> +int pci_get_busdevfn_by_id(const char *id, uint16_t *busnr,
>> +                           uint16_t *devfn, Error **errp)
>> +{
>> +    uint16_t busnum = 0, slot = 0, func = 0;
>> +    const char *pc, *pd, *pe;
>> +    Error *local_err = NULL;
>> +    ObjectClass *class;
>> +    char value[1024];
>> +    BusState *bus;
>> +    uint64_t u64;
>> +
>> +    if (!(pc = strchr(id, ':'))) {
>> +        error_setg(errp, "Invalid id: backup=%s, "
>> +                   "correct format should be backup="
>> +                   "'<bus-id>:<slot>[.<function>]'", id);
>> +        return -1;
>> +    }
>> +    get_opt_name(value, sizeof(value), id, ':');
>> +    if (pc != id + 1) {
>> +        bus = qbus_find(value, errp);
>> +        if (!bus)
>> +            return -1;
>> +
>> +        class = object_get_class(OBJECT(bus));
>> +        if (class != object_class_by_name(TYPE_PCI_BUS) &&
>> +            class != object_class_by_name(TYPE_PCIE_BUS)) {
>> +            error_setg(errp, "%s is not a device on pci bus", id);
>> +            return -1;
>> +        }
>> +        busnum = (uint16_t)pci_bus_num(PCI_BUS(bus));
>> +    }
>
> pci_bus_num is almost always a bug if not done within
> a context of a PCI host, bridge, etc.
>
> In particular this will not DTRT if run before guest assigns bus
> numbers.
>
I was seeking means to reserve a specific pci bus slot from drivers,
and update the driver when guest assigns the bus number but it seems
there's no low-hanging fruits. Because of that reason the bus_num is
only obtained until it's really needed (during get_config) and I
assume at that point the pci bus assignment is already done. I know
the current one is not perfect, but we need that information (PCI
bus:slot.func number) to name the guest device correctly.

Regards,
-Siwei
>
>> +
>> +    if (!devfn)
>> +        goto out;
>> +
>> +    pd = strchr(pc, '.');
>> +    pe = get_opt_name(value, sizeof(value), pc + 1, '.');
>> +    if (pe != pc + 1) {
>> +        parse_option_number("slot", value, &u64, &local_err);
>> +        if (local_err) {
>> +            error_propagate(errp, local_err);
>> +            return -1;
>> +        }
>> +        slot = (uint16_t)u64;
>> +    }
>> +    if (pd && *(pd + 1) != '\0') {
>> +        parse_option_number("function", pd, &u64, &local_err);
>> +        if (local_err) {
>> +            error_propagate(errp, local_err);
>> +            return -1;
>> +        }
>> +        func = (uint16_t)u64;
>> +    }
>> +
>> +out:
>> +    if (busnr)
>> +        *busnr = busnum;
>> +    if (devfn)
>> +        *devfn = ((slot & 0x1F) << 3) | (func & 0x7);
>> +    return 0;
>> +}
>> +
>>  BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
>>  {
>>      DeviceState *dev;
>> --
>> 1.8.3.1
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

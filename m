From: Rick Jones <rick.jones2@hp.com>
Subject: Re: [RFC PATCH net-next] enable virtio_net to return bus_info in
	ethtool -i consistent with emulated NICs
Date: Mon, 14 Nov 2011 14:40:18 -0800
Message-ID: <4EC198D2.9050802__37323.7427477308$1321310867$gmane$org@hp.com>
References: <20111114215241.5B8BF2900307@tardy>
	<1321309800.2827.22.camel@bwh-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1321309800.2827.22.camel@bwh-desktop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ben Hutchings <bhutchings@solarflare.com>
Cc: netdev@vger.kernel.org, Rick Jones <raj@tardy.cup.hp.com>, virtualization@lists.linux-foundation.org, Michael Tsirkin <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 11/14/2011 02:30 PM, Ben Hutchings wrote:
> On Mon, 2011-11-14 at 13:52 -0800, Rick Jones wrote:
>> From: Rick Jones<rick.jones2@hp.com>
>>
>> Add a new .bus_name to virtio_config_ops then modify virtio_net to
>> call through to it in an ethtool .get_drvinfo routine to report
>> bus_info in ethtool -i output which is consistent with other
>> emulated NICs and the output of lspci.
> [...]
>> diff --git a/drivers/lguest/lguest_device.c b/drivers/lguest/lguest_device.c
>> index 0dc30ff..3724d45 100644
>> --- a/drivers/lguest/lguest_device.c
>> +++ b/drivers/lguest/lguest_device.c
>> @@ -381,6 +381,11 @@ error:
>>   	return PTR_ERR(vqs[i]);
>>   }
>>
>> +static const char *lg_bus_name(struct virtio_device *vdev)
>> +{
>> +	return "Not Implemented";
>> +}
> [...]
>> +static const char *kvm_bus_name(struct virtio_device *vdev)
>> +{
>> +	return "Not Implemented";
>> +}
> [...]
>
> Please use the existing 'not implemented' value, which is the empty
> string.

Will do.

thanks,

rick

From: Liran Alon <liran.alon@oracle.com>
Subject: Re: [RFC PATCH net-next] failover: allow name change on IFF_UP slave
	interfaces
Date: Thu, 7 Mar 2019 01:36:10 +0200
Message-ID: <D8A06856-62A4-44BC-920E-9BE60011C9C1__43717.373050616$1555717325$gmane$org@oracle.com>
References: <1551747059-11831-1-git-send-email-si-wei.liu@oracle.com>
	<20190306120430.GA2819@nanopsycho>
	<7d1e79f6-01ff-413d-dac0-ee34258aafec@oracle.com>
	<cb71d2c4-c2b9-28df-1882-154ee3b9b9b6@intel.com>
	<7bc9dc90-6597-4223-c192-55a314ff079f@oracle.com>
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <7bc9dc90-6597-4223-c192-55a314ff079f@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: si-wei liu <si-wei.liu@oracle.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, "Samudrala,
	Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, boris.ostrovsky@oracle.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org



> On 6 Mar 2019, at 23:42, si-wei liu <si-wei.liu@oracle.com> wrote:
> 
> 
> 
> On 3/6/2019 1:36 PM, Samudrala, Sridhar wrote:
>> 
>> On 3/6/2019 1:26 PM, si-wei liu wrote:
>>> 
>>> 
>>> On 3/6/2019 4:04 AM, Jiri Pirko wrote:
>>>>> --- a/net/core/failover.c
>>>>> +++ b/net/core/failover.c
>>>>> @@ -16,6 +16,11 @@
>>>>> 
>>>>> static LIST_HEAD(failover_list);
>>>>> static DEFINE_SPINLOCK(failover_lock);
>>>>> +static bool slave_rename_ok = true;
>>>>> +
>>>>> +module_param(slave_rename_ok, bool, (S_IRUGO | S_IWUSR));
>>>>> +MODULE_PARM_DESC(slave_rename_ok,
>>>>> +		 "If set allow renaming the slave when failover master is up");
>>>>> 
>>>> No module parameters please. If you need to set something do it using
>>>> rtnl_link_ops. Thanks.
>>>> 
>>>> 
>>> I understand what you ask for, but without module parameters userspace don't work. During boot (dracut) the virtio netdev gets enslaved earlier than when userspace comes up, so failover has to determine the setting during initialization/creation. This config is not dynamic, at least for the life cycle of a particular failover link it shouldn't be changed. Without module parameter, how does the userspace specify this value during kernel initialization? 
>>> 
>> Can we enable this by default and not make it configurable via module parameter?
>> Is there any  usecase where someone expects rename to fail with failover slaves?
> Probably just cater for those application that assumes fixed name on UP interface?
> 
> It's already the default for the configurable. I myself don't think that's a big problem for failover users. So far there's not even QEMU support I think everything can be changed. I don't feel strong to just fix it without introducing configurable. But maybe Michael or others think it differently...
> 
> If no one objects, I don't feel strong to make it fixed behavior.
> 
> -Siwei
> 

I agree we should just remove the module parameter.

-Liran

From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Subject: Re: [RFC PATCH] virtio_net: Extend virtio to use VF datapath when
	available
Date: Tue, 19 Dec 2017 11:42:33 -0800
Message-ID: <344f0afc-b4aa-9f1a-15b8-166ba97d270b__46570.6074414358$1515606411$gmane$org@intel.com>
References: <20171219174259-mutt-send-email-mst@kernel.org>
	<ca709329-a47a-2e76-b1fc-38fc665d7c0b@intel.com>
	<20171219095548.61d70d10@xeon-e3>
	<20171219.132117.666798483874609477.davem@davemloft.net>
	<20171219104159.30d9caaf@xeon-e3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171219104159.30d9caaf@xeon-e3>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, alexander.duyck@gmail.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org



On 12/19/2017 10:41 AM, Stephen Hemminger wrote:
> On Tue, 19 Dec 2017 13:21:17 -0500 (EST)
> David Miller <davem@davemloft.net> wrote:
>
>> From: Stephen Hemminger <stephen@networkplumber.org>
>> Date: Tue, 19 Dec 2017 09:55:48 -0800
>>
>>> could be 10ms, just enough to let udev do its renaming
>> Please, move to some kind of notification or event based handling of
>> this problem.
>>
>> No delay is safe, what if userspace gets swapped out or whatever
>> else might make userspace stall unexpectedly?
>>
> The plan is to remove the delay and do the naming in the kernel.
> This was suggested by Lennart since udev is only doing naming policy
> because kernel names were not repeatable.
>
> This makes the VF show up as "ethN_vf" on Hyper-V which is user friendly.
>
> Patch is pending.
Do we really need to delay the setup until the name is changed?
Can't we call dev_set_mtu() and dev_open() until dev_change_name() is done?

Thanks
Sridhar

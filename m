From: Siwei Liu <loseweigh@gmail.com>
Subject: Re: [RFC PATCH] virtio_net: Extend virtio to use VF datapath when
	available
Date: Wed, 20 Dec 2017 18:16:30 -0800
Message-ID: <CADGSJ22mDyC0Sw2EPW96ZWvMPLnzif+Y9MMouhM-6T03ZaKA0Q__34842.7723897204$1515606477$gmane$org@mail.gmail.com>
References: <20171219174259-mutt-send-email-mst@kernel.org>
	<ca709329-a47a-2e76-b1fc-38fc665d7c0b@intel.com>
	<20171219095548.61d70d10@xeon-e3>
	<20171219.132117.666798483874609477.davem@davemloft.net>
	<20171219104159.30d9caaf@xeon-e3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171219104159.30d9caaf@xeon-e3>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: mst@redhat.com, sridhar.samudrala@intel.com, alexander.duyck@gmail.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 19, 2017 at 10:41 AM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Tue, 19 Dec 2017 13:21:17 -0500 (EST)
> David Miller <davem@davemloft.net> wrote:
>
>> From: Stephen Hemminger <stephen@networkplumber.org>
>> Date: Tue, 19 Dec 2017 09:55:48 -0800
>>
>> > could be 10ms, just enough to let udev do its renaming
>>
>> Please, move to some kind of notification or event based handling of
>> this problem.
>>
>> No delay is safe, what if userspace gets swapped out or whatever
>> else might make userspace stall unexpectedly?
>>
>
> The plan is to remove the delay and do the naming in the kernel.
> This was suggested by Lennart since udev is only doing naming policy
> because kernel names were not repeatable.
>
> This makes the VF show up as "ethN_vf" on Hyper-V which is user friendly.
>
> Patch is pending.

While it's good to show VF with specific naming to indicate
enslavement, I wonder wouldn't it be better to hide this netdev at all
from the user space? IMHO this extra device is useless when being
enslaved and we may delegate controls (e.g. ethtool) over to the
para-virtual device instead? That way it's possible to eliminate the
possibility of additional udev setup or modification?

I'm not sure if this  is consistent with Windows guest or not, but I
don't find it _Linux_ user friendly that ethtool doesn't work on the
composite interface any more, and I have to end up with finding out
the correct enslaved VF I must operate on.

Regards,
-Siwei

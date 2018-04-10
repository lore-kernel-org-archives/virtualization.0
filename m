From: Siwei Liu <loseweigh@gmail.com>
Subject: Re: [RFC PATCH net-next v6 4/4] netvsc: refactor notifier/event
	handling code to use the bypass framework
Date: Tue, 10 Apr 2018 16:44:47 -0700
Message-ID: <CADGSJ22rVsC0TDTd6OKVnwbx0ExoQ8xWXBMumKB-OFH4sX=yaQ__39682.4339674369$1523403781$gmane$org@mail.gmail.com>
References: <1523386790-12396-1-git-send-email-sridhar.samudrala@intel.com>
	<1523386790-12396-5-git-send-email-sridhar.samudrala@intel.com>
	<20180410142608.50f15b45@xeon-e3>
	<20180411022807-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180411022807-mutt-send-email-mst@kernel.org>
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
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 10, 2018 at 4:28 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Apr 10, 2018 at 02:26:08PM -0700, Stephen Hemminger wrote:
>> On Tue, 10 Apr 2018 11:59:50 -0700
>> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
>>
>> > Use the registration/notification framework supported by the generic
>> > bypass infrastructure.
>> >
>> > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> > ---
>>
>> Thanks for doing this.  Your current version has couple show stopper
>> issues.
>>
>> First, the slave device is instantly taking over the slave.
>> This doesn't allow udev/systemd to do its device rename of the slave
>> device. Netvsc uses a delayed work to workaround this.
>
> Interesting. Does this mean udev must act within a specific time window
> then?

Sighs, lots of hacks. Why propgating this from driver to a common
module. We really need a clean solution.

-Siwei


>
>> Secondly, the select queue needs to call queue selection in VF.
>> The bonding/teaming logic doesn't work well for UDP flows.
>> Commit b3bf5666a510 ("hv_netvsc: defer queue selection to VF")
>> fixed this performance problem.
>>
>> Lastly, more indirection is bad in current climate.
>>
>> I am not completely adverse to this but it needs to be fast, simple
>> and completely transparent.

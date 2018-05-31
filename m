From: Siwei Liu <loseweigh@gmail.com>
Subject: Re: [PATCH net-next v12 2/5] netvsc: refactor notifier/event handling
	code to use the failover framework
Date: Thu, 31 May 2018 13:41:56 -0700
Message-ID: <CADGSJ23N=8=of_4fKF+r31E-ywewLM7B1JhL6X0qZFP-ORdLQA__27896.5927697302$1527799219$gmane$org@mail.gmail.com>
References: <1527180917-39737-1-git-send-email-sridhar.samudrala@intel.com>
	<1527180917-39737-3-git-send-email-sridhar.samudrala@intel.com>
	<20180530220635.206ee6d7@shemminger-XPS-13-9360>
	<20180531212356-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180531212356-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, venu.busireddy@oracle.com
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, anjali.singhai@intel.com, aaron.f.brown@intel.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 31, 2018 at 11:35 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Wed, May 30, 2018 at 10:06:35PM -0400, Stephen Hemminger wrote:
>> On Thu, 24 May 2018 09:55:14 -0700
>> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
>>
>> > Use the registration/notification framework supported by the generic
>> > failover infrastructure.
>> >
>> > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>>
>> Why was this merged? It was never signed off by any of the netvsc maintainers,
>> and there were still issues unresolved.
>>
>> There are also namespaces issues I am fixing and this breaks them.
>> Will start my patch set with a revert for this. Sorry
>
> As long as you finish the patch set with re-integrating with failover,
> that's fine IMHO.
>
> I suspect it's easier to add the code to failover though - namespace
> things likely affect virtio as well. Lookup by ID would be an optional
> feature for virtio, but probably a useful one - I won't ask you
I would think for production uses this is a required feature and
should be enabled by default.

Venu (cc'ed) is working on the group ID stuff currently for pairing
virtio and passthrough devices. Would appreciate feedback on the group
ID proposal on virtio-dev.

-Siwei

> to add it to virtio but it could be a mode in failover
> that virtio will activate down the road. And reducing the number of
> times we look cards up based on ID can only be a good thing.
>
> --
> MST

From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH v7 net-next 4/4] netvsc: refactor notifier/event handling
	code to use the failover framework
Date: Mon, 23 Apr 2018 19:25:50 +0200
Message-ID: <20180423172550.GF3585__41184.7879797735$1524504246$gmane$org@nanopsycho.orion>
References: <1524188524-28411-1-git-send-email-sridhar.samudrala@intel.com>
	<1524188524-28411-5-git-send-email-sridhar.samudrala@intel.com>
	<20180420082802.6ca37e4c@xeon-e3>
	<20180420160058.GB2150@nanopsycho.orion>
	<20180423100406.71b95f74@xeon-e3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180423100406.71b95f74@xeon-e3>
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, mst@redhat.com, kubakici@wp.pl, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, netdev@vger.kernel.org, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Mon, Apr 23, 2018 at 07:04:06PM CEST, stephen@networkplumber.org wrote:
>On Fri, 20 Apr 2018 18:00:58 +0200
>Jiri Pirko <jiri@resnulli.us> wrote:
>
>> Fri, Apr 20, 2018 at 05:28:02PM CEST, stephen@networkplumber.org wrote:
>> >On Thu, 19 Apr 2018 18:42:04 -0700
>> >Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
>> >  
>> >> Use the registration/notification framework supported by the generic
>> >> failover infrastructure.
>> >> 
>> >> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>  
>> >
>> >Do what you want to other devices but leave netvsc alone.
>> >Adding these failover ops does not reduce the code size, and really is
>> >no benefit.  The netvsc device driver needs to be backported to several
>> >other distributions and doing this makes that harder.  
>> 
>> We should not care about the backport burden when we are trying to make
>> things right. And things are not right. The current netvsc approach is
>> just plain wrong shortcut. It should have been done in a generic way
>> from the very beginning. We are just trying to fix this situation.
>> 
>> Moreover, I believe that part of the fix is to convert netvsc to 3
>> netdev solution too. 2 netdev model is wrong.
>> 
>> 
>> >
>> >I will NAK patches to change to common code for netvsc especially the
>> >three device model.  MS worked hard with distro vendors to support transparent
>> >mode, ans we really can't have a new model; or do backport.
>> >
>> >Plus, DPDK is now dependent on existing model.  
>> 
>> Sorry, but nobody here cares about dpdk or other similar oddities.
>
>The network device model is a userspace API, and DPDK is a userspace application.
>You can't go breaking userspace even if you don't like the application.

I don't understand how you can break anything by exposing
just-another-netdevice. If you break it, it is already broken...

And how you can break anything in userspace by doing refactoring inside
the kernel is puzzling me even more...

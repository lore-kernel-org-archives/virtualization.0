From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: Shepherd request (P83): Multipath TCP: Present Use Cases and an
	Upstream Future
Date: Tue, 22 May 2018 17:36:14 +0200
Message-ID: <20180522153614.GK2149__28495.863514445$1527003286$gmane$org@nanopsycho>
References: <1526954781-35359-1-git-send-email-sridhar.samudrala@intel.com>
	<1526954781-35359-3-git-send-email-sridhar.samudrala@intel.com>
	<20180522090637.GE2149@nanopsycho>
	<20180522090853.GF2149@nanopsycho>
	<39081bce-3913-5b07-3d07-0c476fca5e78@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <39081bce-3913-5b07-3d07-0c476fca5e78@intel.com>
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, anjali.singhai@intel.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Tue, May 22, 2018 at 05:28:42PM CEST, sridhar.samudrala@intel.com wrote:
>
>On 5/22/2018 2:08 AM, Jiri Pirko wrote:
>> Tue, May 22, 2018 at 11:06:37AM CEST, jiri@resnulli.us wrote:
>> > Tue, May 22, 2018 at 04:06:18AM CEST, sridhar.samudrala@intel.com wrot=
e:
>> > > Use the registration/notification framework supported by the generic
>> > > failover infrastructure.
>> > > =

>> > > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> > In previous patchset versions, the common code did
>> > netdev_rx_handler_register() and netdev_upper_dev_link() etc
>> > (netvsc_vf_join()). Now, this is still done in netvsc. Why?
>> > =

>> > This should be part of the common "failover" code.
>
>Based on Stephen's feedback on earlier patches, i tried to minimize the ch=
anges to
>netvsc and only commonize the notifier and the main event handler routine.
>Another complication is that netvsc does part of registration in a delayed=
 workqueue.

:( This kind of degrades the whole efford of having single solution
in "failover" module. I think that common parts, as
netdev_rx_handler_register() and others certainly is should be inside
the common module. This is not a good time to minimize changes. Let's do
the thing properly and fix the netvsc mess now.


>
>It should be possible to move some of the code from net_failover.c to gene=
ric
>failover.c in future if Stephen is ok with it.
>
>
>> > =

>> Also note that in the current patchset you use IFF_FAILOVER flag for
>> master, yet for the slave you use IFF_SLAVE. That is wrong.
>> IFF_FAILOVER_SLAVE should be used.
>
>Not sure which code you are referring to.=A0 I only set IFF_FAILOVER_SLAVE
>in patch 3.

The existing netvsc driver.

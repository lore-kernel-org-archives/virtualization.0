From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [PATCH] stopmachine: add stopmachine_timeout v4
Date: Thu, 17 Jul 2008 00:09:49 -0700
Message-ID: <487EF03D.9090401__6112.35485780544$1216278803$gmane$org@qualcomm.com>
References: <487B05CE.1050508@jp.fujitsu.com> <487EE2DB.7090205@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <487EE2DB.7090205@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Hidetoshi Seto wrote:
> If stop_machine() invoked while one of onlined cpu is locked up
> by some reason, stop_machine cannot finish its work because the
> locked cpu cannot stop.  This means all other healthy cpus
> will be blocked infinitely by one dead cpu.
> 
> This patch allows stop_machine to return -EBUSY with some printk
> messages if any of stop_machine's threads cannot start running on
> its target cpu in time.  You can enable this timeout via sysctl.
> 
> v4:
>  - move extern into linux/stop_machine.h and add include of the
>    header to kernel/sysctl.c.  Now stopmachine_timeout is available
>    only on smp.
> 
> v3:
>  - set stopmachine_timeout default to 0 (= never timeout)
> 
> v2:
>  - remove fix for warning since it will be fixed upcoming typesafe
>    patches
>  - make stopmachine_timeout from secs to msecs
>  - allow disabling timeout by setting the stopmachine_timeout to 0
> 
> Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
> ---
>  include/linux/stop_machine.h |    3 ++
>  kernel/stop_machine.c        |   54 +++++++++++++++++++++++++++++++++++++++--
>  kernel/sysctl.c              |   12 +++++++++
>  3 files changed, 66 insertions(+), 3 deletions(-)

Looks good to me.
Ack.

Max

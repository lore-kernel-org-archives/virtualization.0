From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net-next v12 2/5] netvsc: refactor notifier/event
	handling code to use the failover framework
Date: Wed, 30 May 2018 22:06:35 -0400
Message-ID: <20180530220635.206ee6d7__27444.9392025874$1527732287$gmane$org@shemminger-XPS-13-9360>
References: <1527180917-39737-1-git-send-email-sridhar.samudrala@intel.com>
	<1527180917-39737-3-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1527180917-39737-3-git-send-email-sridhar.samudrala@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, anjali.singhai@intel.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 24 May 2018 09:55:14 -0700
Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:

> Use the registration/notification framework supported by the generic
> failover infrastructure.
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>

Why was this merged? It was never signed off by any of the netvsc maintainers,
and there were still issues unresolved.

There are also namespaces issues I am fixing and this breaks them.
Will start my patch set with a revert for this. Sorry

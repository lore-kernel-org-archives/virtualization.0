From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next v11 2/5] netvsc: refactor notifier/event
	handling code to use the failover framework
Date: Tue, 22 May 2018 11:06:37 +0200
Message-ID: <20180522090637.GE2149__47286.0306188979$1526979917$gmane$org@nanopsycho>
References: <1526954781-35359-1-git-send-email-sridhar.samudrala@intel.com>
	<1526954781-35359-3-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1526954781-35359-3-git-send-email-sridhar.samudrala@intel.com>
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, anjali.singhai@intel.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Tue, May 22, 2018 at 04:06:18AM CEST, sridhar.samudrala@intel.com wrote:
>Use the registration/notification framework supported by the generic
>failover infrastructure.
>
>Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>

In previous patchset versions, the common code did
netdev_rx_handler_register() and netdev_upper_dev_link() etc
(netvsc_vf_join()). Now, this is still done in netvsc. Why?

This should be part of the common "failover" code.

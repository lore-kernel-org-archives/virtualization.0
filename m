From: John Fastabend <john.r.fastabend@intel.com>
Subject: Re: [E1000-eedc] [PATCH 16/17] lldpad support for libvirt netlink
	message
Date: Tue, 03 Aug 2010 00:52:46 -0700
Message-ID: <4C57CACE.2070202@intel.com>
References: <1279881273-10261-1-git-send-email-jens@linux.vnet.ibm.com>
	<1279881273-10261-17-git-send-email-jens@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1279881273-10261-17-git-send-email-jens@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Osterkamp <jens@linux.vnet.ibm.com>
Cc: "chrisw@redhat.com" <chrisw@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Gerhard Stenzel <gstenzel@linux.vnet.ibm.com>, "evb@yahoogroups.com" <evb@yahoogroups.com>, "e1000-eedc@lists.sourceforge.net" <e1000-eedc@lists.sourceforge.net>
List-Id: virtualization@lists.linuxfoundation.org

Jens Osterkamp wrote:
> This code receives a IEEE 802.1Qbg virtual station instance from libvirt in
> a SETLINK message. The parsed VSI is then handed over to VDP for processing.
> The VDP state machine processes the VSI while libvirt polls the result using
> GETLINK.
> 
> Requires at least Linux kernel 2.6.35-rc1.
> 
> Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
> Signed-off-by: Gerhard Stenzel <gstenzel@linux.vnet.ibm.com>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  event_iface.c |  617 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  lldp_vdp.c    |    2 +-
>  lldpad.c      |   10 +
>  3 files changed, 622 insertions(+), 7 deletions(-)
> 

Jens,

Can you explain why this interface is needed?  There is already a kernel 
interface for this how come libvirt and lldpad can not use the kernel interface?

Thanks,
John.

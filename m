From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] tun: Fix/rewrite packet filtering logic
Date: Mon, 14 Jul 2008 22:16:02 -0700 (PDT)
Message-ID: <20080714.221602.232989530.davem__9810.76152897931$1216099089$gmane$org@davemloft.net>
References: <1215852774-23974-1-git-send-email-maxk@qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1215852774-23974-1-git-send-email-maxk@qualcomm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: maxk@qualcomm.com
Cc: jeff@garzik.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, borntraeger@de.ibm.com, linuxkernel@bristyle.com, sjackman@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

From: Max Krasnyansky <maxk@qualcomm.com>
Date: Sat, 12 Jul 2008 01:52:54 -0700

> This is on top of the latest and greatest :). Assuming virt folks are ok with
> the API this should go into 2.6.27.

Really? :-)

It doesn't apply cleanly to net-next-2.6, as I just tried to
stick this into my tree.

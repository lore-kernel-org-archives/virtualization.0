From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 7/7] [v4] drivers/virt: introduce Freescale hypervisor
	management driver
Date: Thu, 9 Jun 2011 11:36:02 -0500
Message-ID: <4DF0F672.8040206__8719.17963163487$1307736888$gmane$org@freescale.com>
References: <1307573154-15838-1-git-send-email-timur@freescale.com>
	<20110608161009.7b05d305.randy.dunlap@oracle.com>
	<201106090938.23027.arnd@arndb.de> <4DF0F5A1.5080008@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4DF0F5A1.5080008@oracle.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>, konrad.wilk@oracle.com, greg@kroah.com, kumar.gala@freescale.com, linux-kernel@vger.kernel.org, cmetcalf@tilera.com, Linux Virtualization <virtualization@lists.linux-foundation.org>, dsaxena@linaro.org, linux-console@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alan@lxorguk.ukuu.org.uk
List-Id: virtualization@lists.linuxfoundation.org

Randy Dunlap wrote:
> But it sounds like virt/ needs virt/host/ and virt/guest/ to me.

I'm okay with that idea, except there's a consensus that drivers should be in
drivers/.

-- 
Timur Tabi
Linux kernel developer at Freescale

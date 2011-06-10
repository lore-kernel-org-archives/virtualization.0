From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/7] [v4] drivers/virt: introduce Freescale hypervisor
	management driver
Date: Fri, 10 Jun 2011 17:36:14 +0200
Message-ID: <201106101736.14850.arnd__37381.2920450748$1307720240$gmane$org@arndb.de>
References: <1307573154-15838-1-git-send-email-timur@freescale.com>
	<201106090938.23027.arnd@arndb.de> <4DF22770.4010103@tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4DF22770.4010103@tilera.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, konrad.wilk@oracle.com, greg@kroah.com, kumar.gala@freescale.com, linux-kernel@vger.kernel.org, Linux Virtualization <virtualization@lists.linux-foundation.org>, dsaxena@linaro.org, linux-console@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@freescale.com>, alan@lxorguk.ukuu.org.uk
List-Id: virtualization@lists.linuxfoundation.org

On Friday 10 June 2011, Chris Metcalf wrote:
> This still leaves open the question of what really should go in this new
> directory. Is it just for drivers that manage/control the hypervisor?  Or
> is it also for drivers that just use the hypervisor to do I/O of some kind,
> but aren't related to any other "family" of drivers, i.e., a driver that
> would have been dumped in drivers/char or drivers/misc in the old days?
> 
> My specific interest at the moment is the proposed tile-srom.c driver
> (https://patchwork.kernel.org/patch/843892/), which uses a simple
> hypervisor read/write API to access the portion of the SPI ROM used to hold
> the boot stream for a TILE processor.

I'd still put that driver in drivers/char for now, because it already contains
similar drivers. We can probaby group them in a subdirectory of drivers/char
at some point or move them out to a new directory.

For your raw hcall passthrough driver, that would be something that should
go into drivers/virt/ IMHO.

	Arnd

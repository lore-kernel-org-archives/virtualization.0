From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 7/7] [v4] drivers/virt: introduce Freescale hypervisor
	management driver
Date: Thu, 09 Jun 2011 09:32:33 -0700
Message-ID: <4DF0F5A1.5080008__6055.17931185222$1307637229$gmane$org@oracle.com>
References: <1307573154-15838-1-git-send-email-timur@freescale.com>
	<20110608161009.7b05d305.randy.dunlap@oracle.com>
	<201106090938.23027.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201106090938.23027.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: konrad.wilk@oracle.com, greg@kroah.com, kumar.gala@freescale.com, linux-kernel@vger.kernel.org, cmetcalf@tilera.com, Linux Virtualization <virtualization@lists.linux-foundation.org>, dsaxena@linaro.org, linux-console@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@freescale.com>, alan@lxorguk.ukuu.org.uk
List-Id: virtualization@lists.linuxfoundation.org

On 06/09/11 00:38, Arnd Bergmann wrote:
> On Thursday 09 June 2011 01:10:09 Randy Dunlap wrote:
>> On Wed, 8 Jun 2011 17:45:54 -0500 Timur Tabi wrote:
>>
>>> Add the drivers/virt directory, which houses drivers that support
>>> virtualization environments, and add the Freescale hypervisor management
>>> driver.
>>
>> It can't go in linux/virt or linux/virt/fsl instead?  why drivers/ ?
>>
>> or maybe linux/virt should be drivers/virt ?
> 
> See discussion for v2 of this patch. I suggested that drivers/firmware and virt/
> as options, the counterarguments were that drivers/firmware is for passive
> firmware as opposed to firmware that acts as a hypervisor, and that virt/ is
> for the host side of hypervisors like kvm, not for guests.

OK, I read that thread.  Didn't see a real consensus there.

If you were not the drivers/misc/ maintainer, would you mind if this
driver lived in drivers/misc/?  I wouldn't.

But it sounds like virt/ needs virt/host/ and virt/guest/ to me.


> The driver in here most closely resembles the xen dom0 model, where a
> priviledged guest controls other guests, but unlike xen there is a single
> driver file, so there is no need to have drivers/fsl-hv directory just
> for this one file. We do have a number of other hypervisors that fit in the
> same category, so they can be added here later.


-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***

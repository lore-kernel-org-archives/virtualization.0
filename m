From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 7/7] [v6] drivers/virt: introduce Freescale hypervisor
	management driver
Date: Fri, 1 Jul 2011 01:18:15 +0000
Message-ID: <BANLkTi=3r=UQYJVqRLRe-eu7rdkXQS-ESQ__39545.7172570333$1309490123$gmane$org@mail.gmail.com>
References: <1307652726-4356-1-git-send-email-timur@freescale.com>
	<201106092304.55479.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201106092304.55479.arnd@arndb.de>
Content-Language: en-US
Content-ID: <4EA51EC6BB80F340A5CB3FBBFBD06B1C@freescale.net>
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
Cc: "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cmetcalf@tilera.com" <cmetcalf@tilera.com>, "dsaxena@linaro.org" <dsaxena@linaro.org>, "linux-console@vger.kernel.org" <linux-console@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, Gala Kumar-B11780 <B11780@freescale.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 9, 2011 at 4:04 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 09 June 2011 22:52:06 Timur Tabi wrote:
>> Add the drivers/virt directory, which houses drivers that support
>> virtualization environments, and add the Freescale hypervisor management
>> driver.
....
>>
>> Signed-off-by: Timur Tabi <timur@freescale.com>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

So I've made the changes that people have asked for, and Arnd has
acked this driver.  Who's going to pick it up?  Who will be the
maintainer for drivers/virt?  I'd really like to see this driver in
3.1, and there's not much time left.

-- 
Timur Tabi
Linux kernel developer at Freescale

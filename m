From: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [RFC PATCH 03/11] PCI/MSI: Refactor pci_dev_msi_enabled()
Date: Wed, 6 Aug 2014 09:23:51 +0800
Message-ID: <53E183A7.80905__3148.06711762703$1407288367$gmane$org@huawei.com>
References: <1406344128-27055-1-git-send-email-wangyijing@huawei.com>	<1406344128-27055-4-git-send-email-wangyijing@huawei.com>
	<CALRxmdB0Ltt3_G=D4i7x47pHCtCKo8RHgn-hgN+u=px22dimOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALRxmdB0Ltt3_G=D4i7x47pHCtCKo8RHgn-hgN+u=px22dimOA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stuart Yoder <b08248@gmail.com>
Cc: linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Paul.Mundt@huawei.com, linux-pci@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Xinwei Hu <huxinwei@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>, Wuyun <wuyun.wu@huawei.com>, arnab.basu@freescale.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On 2014/8/6 6:35, Stuart Yoder wrote:
> On Fri, Jul 25, 2014 at 10:08 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>> Pci_dev_msi_enabled() is used to check whether device
>> MSI/MSIX enabled. Refactor this function  to suuport
>> checking only device MSI or MSIX enabled.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> 
> So this patch refactors things so that checks like this:
>    > -       if (!dev->msi_enabled)
> 
> are moved into a function:
>    > +       if (!pci_dev_msi_enabled(dev, MSI_TYPE))
> 
> Can you explain a bit more why this  needed.   Is it just cleanup?

Hi Stuart, it's not just cleanup, because "[RFC PATCH 08/11] PCI/MSI: Introduce new struct msi_irqs and struct msi_ops"
introduced struct msi_irqs, so the code will change to
if (!dev->msi_irqs->msi_enabled)

I think driver should not need to know the details of MSI members.
So I try to rework the pci_dev_msi_enabled() to hide the detailed MSI info.


Thanks!
Yijing.


> 
> .
> 


-- 
Thanks!
Yijing

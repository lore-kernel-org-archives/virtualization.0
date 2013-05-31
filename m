From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [PATCH] xen-pciback: fix error return code in
	pcistub_irq_handler_switch()
Date: Fri, 31 May 2013 13:20:40 +0100
Message-ID: <51A8B1B802000078000DA0A0@nat28.tlf.novell.com>
References: <CAPgLHd89ByaKLsvu=C-im9cg=7X7jNANuS+BaHt_EGotc-8hmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAPgLHd89ByaKLsvu=C-im9cg=7X7jNANuS+BaHt_EGotc-8hmA@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Yongjun <weiyj.lk@gmail.com>, konrad.wilk@oracle.com
Cc: jeremy@goop.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, xen-devel <xen-devel@lists.xen.org>, yongjun_wei@trendmicro.com.cn, jkosina@suse.cz, shemminger@vyatta.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

>>> On 31.05.13 at 13:59, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return -ENOENT in the pcistub_device_find() and pci_get_drvdata()
> error handling case instead of 0(overwrite to 0 by str_to_slot()), as done
> elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked-by: Jan Beulich <jbeulich@suse.com>

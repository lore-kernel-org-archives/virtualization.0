From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-pci: use module_pci_driver to simplify the code
Date: Thu, 11 Oct 2012 19:02:50 +1030
Message-ID: <87ipah76j1.fsf__14122.1870239407$1349988571$gmane$org@rustcorp.com.au>
References: <CAPgLHd-GzSDQ+E-zboLA8RfbOVk5bHFK+NTDe2WkWihVFVCtmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAPgLHd-GzSDQ+E-zboLA8RfbOVk5bHFK+NTDe2WkWihVFVCtmA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Yongjun <weiyj.lk@gmail.com>, mst@redhat.com
Cc: yongjun_wei@trendmicro.com.cn, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Wei Yongjun <weiyj.lk@gmail.com> writes:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Use the module_pci_driver() macro to make the code simpler
> by eliminating module_init and module_exit calls.
>
> dpatch engine is used to auto generate this patch.
> (https://github.com/weiyj/dpatch)
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Thanks, applied!
Rusty.

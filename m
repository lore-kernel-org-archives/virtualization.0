From: Brandon Philips <brandon@ifup.org>
Subject: Re: [PATCH 05/10] staging: hv: Convert camel cased functions in
	hv.c to lower cases
Date: Tue, 2 Nov 2010 10:04:08 -0700
Message-ID: <20101102170406.GA4557@jenkins.home.ifup.org>
References: <1288644369-12958-1-git-send-email-haiyangz@linuxonhyperv.com>
	<1288644369-12958-2-git-send-email-haiyangz@linuxonhyperv.com>
	<1288644369-12958-3-git-send-email-haiyangz@linuxonhyperv.com>
	<1288644369-12958-4-git-send-email-haiyangz@linuxonhyperv.com>
	<1288644369-12958-5-git-send-email-haiyangz@linuxonhyperv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1288644369-12958-5-git-send-email-haiyangz@linuxonhyperv.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Haiyang Zhang <haiyangz@linuxonhyperv.com>
Cc: haiyangz@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, devel@linuxdriverproject.org
List-Id: virtualization@lists.linuxfoundation.org

On 13:46 Mon 01 Nov 2010, Haiyang Zhang wrote:
> -static int HvQueryHypervisorInfo(void)
> +static int hvquery_hypervisor_info(void)
> -static u64 HvDoHypercall(u64 control, void *input, void *output)
> +static u64 hvdo_hypercall(u64 control, void *input, void *output)

Should these be hv_do_hypercall and hv_query_hypervisor? That seems to
be the style in the rest of the patch:

> -int HvInit(void)
> +int hv_init(void)

> -void HvCleanup(void)
> +void hv_cleanup(void)

> -u16 HvPostMessage(union hv_connection_id connection_id,
> +u16 hv_post_message(union hv_connection_id connection_id,

> -u16 HvSignalEvent(void)
> +u16 hv_signal_event(void)

Cheers,

	Brandon

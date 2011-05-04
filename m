From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/1] Staging: hv: Add the necessary dependencies to
 hyperv Kconfig
Date: Wed, 4 May 2011 14:51:42 -0400
Message-ID: <20110504185142.GA28458@infradead.org>
References: <1304535105-26892-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1304535105-26892-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 04, 2011 at 11:51:45AM -0700, K. Y. Srinivasan wrote:
>  config HYPERV
>  	tristate "Microsoft Hyper-V client drivers"
> -	depends on X86 && m
> +	depends on X86 && ACPI && PCI && m

I can't see anything preventing this driver from beeing built-in,
so the "depends on m" should probably go away.

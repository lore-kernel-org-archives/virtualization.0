From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 3/7] More generic paravirtualization entry point.
Date: Sun, 29 Oct 2006 08:41:37 -0800
Message-ID: <200610290841.38032.ak@suse.de>
References: <20061029024504.760769000@sous-sol.org> <20061029024605.950760000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965290AbWJ2Qm3@vger.kernel.org>
In-Reply-To: <20061029024605.950760000@sous-sol.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.osdl.org
Cc: Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org, ak@muc.de, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Saturday 28 October 2006 00:00, Chris Wright wrote:

> +
> +/* We simply declare start_kernel to be the paravirt probe of last resort.
> */ +asmlinkage void __init start_kernel(void);

Didn't rusty put that into a header recently?

-Andi

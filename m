From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/1] Staging: hv: util: Invoke cn_netlink_send() in a
 work context
Date: Mon, 10 Oct 2011 07:43:58 -0400
Message-ID: <20111010114358.GA12665@infradead.org>
References: <1318214548-22572-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1318214548-22572-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Oct 09, 2011 at 07:42:28PM -0700, K. Y. Srinivasan wrote:
> Invoke cn_netlink_send() in a work context as opposed being called
> in the context of  channel callback. On entry into the channel callback
> code the channel inbound spin lock is held and deferring to a work
> context avoids having to invoke cn_netlink_send() while holding
> the inbound lock. As part of this adjustment, also increase the
> timeout value for waiting for the user level component of KVP.

As told a few times you really need to move away from the connector
before sumitting the KVP support.  What about tackling that instead of
band aiding it?

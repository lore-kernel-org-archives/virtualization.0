From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 129/206] Staging: hv: Move the sector size check into
 blkvsc_drv_init
Date: Tue, 10 May 2011 04:49:09 -0400
Message-ID: <20110510084909.GA6276@infradead.org>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-129-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1304978288-22999-129-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 09, 2011 at 02:56:51PM -0700, K. Y. Srinivasan wrote:
> The subject line says it all.

Is there any good reason to not support a 32-bit sector_t?

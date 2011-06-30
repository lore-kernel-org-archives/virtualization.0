From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 34/40] Staging: hv: storvsc: Add the contents of
 hyperv_storage.h to storvsc_drv.c
Date: Thu, 30 Jun 2011 15:45:30 -0400
Message-ID: <20110630194530.GE22707@infradead.org>
References: <1309358301-8488-1-git-send-email-kys@microsoft.com>
 <1309358377-8537-1-git-send-email-kys@microsoft.com>
 <1309358377-8537-34-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1309358377-8537-34-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 29, 2011 at 07:39:31AM -0700, K. Y. Srinivasan wrote:
> Add the contents of hyperv_storage.h to storvsc_drv.c and cleanup storvsc_drv.c.n

I'd at least leave the first half of the header that defines the
protocol around. 

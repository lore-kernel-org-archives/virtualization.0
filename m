From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 26/49] Staging: hv: vmbus: Get rid of the poll timer in
 the channel state
Date: Mon, 6 Jun 2011 19:15:53 -0400
Message-ID: <20110606231553.GC18222@infradead.org>
References: <1307400540-13193-1-git-send-email-kys@microsoft.com>
 <1307400613-13234-1-git-send-email-kys@microsoft.com>
 <1307400613-13234-26-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1307400613-13234-26-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 06, 2011 at 03:49:50PM -0700, K. Y. Srinivasan wrote:
> Since tis is not used anymore,  get rid of the poll timer in the channel state.

This would be more useful together with the patch that removes the use
of the timer. 

From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 38/40] Staging: hv: storvsc: Fixup srb_status for INQUIRY
 and MODE_SENSE
Date: Thu, 30 Jun 2011 15:47:54 -0400
Message-ID: <20110630194754.GG22707@infradead.org>
References: <1309358301-8488-1-git-send-email-kys@microsoft.com>
 <1309358377-8537-1-git-send-email-kys@microsoft.com>
 <1309358377-8537-38-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1309358377-8537-38-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 29, 2011 at 07:39:35AM -0700, K. Y. Srinivasan wrote:
> The current handler on the Windows Host does not correctly handle
> INQUIRY and MODE_SENSE commands with some options. Fixup srb_status
> in these cases since the failure is not fatal.

> +	/*
> +	 * The current SCSI handling on the host side does
> +	 * not correctly handle:
> +	 * INQUIRY command with page code parameter set to 0x80
> +	 * MODE_SENSE command with cmd[2] == 0x1c
> +	 *
> +	 * Setup srb status so this won't be fatal.
> +	 */
> +
> +	if ((stor_pkt->vm_srb.cdb[0] == INQUIRY) ||
> +	   (stor_pkt->vm_srb.cdb[0] == MODE_SENSE))
> +		vstor_packet->vm_srb.srb_status = 0;

Given that the srb_status is only used for debug printks I don't
quite see the point.  If people explicitly turn on debugging they
should see that these commands fail, shouldn't they?
